Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9494422258F
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463339; cv=none; b=DXY/Gz6vAhbzGj6nUea7yFEQFVlA2jX6jOA2n3HBxBRDxK/8+bBUCuKcKC1ZQiFZvC9cenSBPrxE3KLwdCUnUAoWY0ALPGpG8W5r+blvGPTiwx8/DwbXG/01FcGI/pfLiRLElIiKXVqCApVtlaTjDuWBi7vJoKnkrLi+QMMk7KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463339; c=relaxed/simple;
	bh=QjgKs2zBlmqc+C10EXoziYvrwPFdIEO6RN7X/4TjnLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pIM1y/BytKB/yn5nkuu8FrzwuR7vooV3M1im2p3fo/ztGQt4s9WaYZuIwx/j7xq6IQIzjpx38j0CzPergSdzRzMGL4lkv7wjXp5t6ZsRGfOmxDXUXjlM3rMe82v9YkBrPyWKJOMuPA0vBXNNrdQsytgaVawLFwIjMZQee6skwW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pL0AmuIR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v/9Lgq2s; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pL0AmuIR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v/9Lgq2s"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9C9732540164;
	Thu, 20 Mar 2025 05:35:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 20 Mar 2025 05:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742463336;
	 x=1742549736; bh=FVRzN5probz2tBNOBHZiwqoUS1ZTExFewoPw5q+Mbg4=; b=
	pL0AmuIRKFi8MPOX70/zi5Qa8P54pnKol/ei8AZP1CPVeit01rteQB4/BCFPpzqA
	AYMApJKlF4T0wYfmlEvyv3kHaDTYV0qcr86F5ezy3lJqUTUephpvNbyPoy1jVT1J
	j6zw1Kb91uBEG1wR7JmVZlc5Hn7/4mwOeq7j4g9ryuscXdIxfsZ4RUFtsGZpDDPY
	Lzp9/oy0FI695RXoIEib54EM5TZvw+s+rT/0EPU+2Z8q6/rRW8p0u6r8rOz0mTbR
	TYGLNoPPoMVNg+c9o8+khz6W/THH3k6GC7Q6r6RHoB63zgqs9FLRLX5UD7c6dTdz
	+5gNM9+YzHzJbjxh8o1yZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742463336; x=
	1742549736; bh=FVRzN5probz2tBNOBHZiwqoUS1ZTExFewoPw5q+Mbg4=; b=v
	/9Lgq2sfB/rWQge2ktXye+7noIXSQd17pi7a9f2Z/06V9+U+txxzT0hMwrmRXVvI
	tYVP4RTI+7cie7FOVWCUjYwCPPo/6t+2Mad+jD9cYv5PcyetfOVR+vGdXdYfbIxy
	p8tpX7VfANkvFJT/bbKzk5eJbDY0YVjq6Sliz1NCempnJ84kK7UsXvHgW/Prt0UC
	AiLqS+SDHC32bdEbTiG4amB2677gl2Zb8eqUBUSOZvmQ7aTFxmJ1kn+RJrwD7BCs
	AXhqrwebemBzNs/crZmdwl44d/UvDIPYez9BtRycnHUmYHgil5BskVuC90oDInLq
	r1THeBv467Qa6FmWmi87Q==
X-ME-Sender: <xms:aOHbZyOzXUmtnN_E4o3FRD6jLzE9ANFo2SpepowuPCAIZ1W2D7nd5A>
    <xme:aOHbZw_UEDLVXsQB8gXNjBgWO3TEPiej6674ycS873m6qQaDWEEK0Cr6JrO4J4ubP
    pjWMCAFA1ldIq3Mbw>
X-ME-Received: <xmr:aOHbZ5Qc5OZWdNDIhORbedcCxGOrbXPzHhI28zjFprkY0miCZJxL6TyNdNskrKcVxucsjEstE2jXfAZFBgpVTxRNUK73L8VNAPohI4ErzScb2JI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:aOHbZyuPIDagJmIPe6vylKlSTHykRGWcKscKnWDXa7PVlYdCSpdEBA>
    <xmx:aOHbZ6dbZc56kcPxqK-oVW7EscWVVhqv4aPaAh2F4dyAsc8Q2MoZOA>
    <xmx:aOHbZ22sWsLr3YB4h-R9vj-fSX967pfu6FMq1mzdPnsmv-1w115brw>
    <xmx:aOHbZ-_pniRqzDYMmjzl-cd-mUItSbp7FpFuusQPY7tmeLZWjyrYdA>
    <xmx:aOHbZ7qW60OLhSZohw4ahxMqppfBUrRQ3oa1ENrcOEMa2gG8QX28pCih>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 05:35:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e0fb2388 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 09:35:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 20 Mar 2025 10:35:31 +0100
Subject: [PATCH 04/20] t: adapt `test_copy_bytes()` to not use Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-b4-pks-t-perlless-v1-4-b1eefe27ac55@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
In-Reply-To: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

The `test_copy_bytes()` helper function copies up to N bytes from stdin
to stdout. This is implemented using Perl, but it can be trivially
adapted to instead use dd(1).

Refactor the helper accordingly, which allows a bunch of tests to pass
when Perl is not available.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib-functions.sh | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 377f08a1428..c4b4d3a4c7f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1640,17 +1640,7 @@ test_match_signal () {
 
 # Read up to "$1" bytes (or to EOF) from stdin and write them to stdout.
 test_copy_bytes () {
-	perl -e '
-		my $len = $ARGV[1];
-		while ($len > 0) {
-			my $s;
-			my $nread = sysread(STDIN, $s, $len);
-			die "cannot read: $!" unless defined($nread);
-			last unless $nread;
-			print $s;
-			$len -= $nread;
-		}
-	' - "$1"
+	dd ibs=1 count="$1" 2>/dev/null
 }
 
 # run "$@" inside a non-git directory

-- 
2.49.0.472.ge94155a9ec.dirty

