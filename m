Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E616220F07A
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071835; cv=none; b=p54Vq1ueNc565GY1/yp9/Tfz66OrVdu+rjvBEmVY4S3Bo2FtL3nNneBxNa6b9p85WGiSglSJ6ppLjO5JCBqO7TPKmBxaUE9jqHMk3xza7kB5CuHk9NnC0IvR5TuwmYTgl7yenY2Hh7WA6Yf/k758fUWnK4y45AsgsiC11NxGGmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071835; c=relaxed/simple;
	bh=QjgKs2zBlmqc+C10EXoziYvrwPFdIEO6RN7X/4TjnLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KZMxtTh/mNa+pCg4w2jK3dueOTDqkVi4vjc8zoKLTXeLPLLFjdP86Wp7xpg4QV4rllMK+Wh243wSVt58f3itCyaKXKcOvgyRnj5cXUbCRzCFH4XRhvE842DZCXrxHaiiw8GVXyUXZKo14G9iNQZzJbEx307Zmj6YBCqiCZDJpjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=npPn4LxM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OBnTDDFM; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="npPn4LxM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OBnTDDFM"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 05CF711400FE;
	Thu, 27 Mar 2025 06:37:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 27 Mar 2025 06:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743071833;
	 x=1743158233; bh=FVRzN5probz2tBNOBHZiwqoUS1ZTExFewoPw5q+Mbg4=; b=
	npPn4LxMAr4R7E4p5hh+wvb9HR3kuCSbuWUDVPSTFBXYfEXkqePGyf0woJvjHf+N
	lBtJn2p3WEkSR7ikBCDraLIWEYgb2UkGmvMqK8zCG5B+Km/65Td2UV7/Jv72sRF8
	otkqJlaHjopbT9fQpo07H/y+pgsQwSXBJsAEqcADOSXeZH8BNhsuUaOABLdhDkvd
	/Ej4BanhtQCAQazJsRqGd7cYI9bXdANLOOOYwqf0ErcUCmsCKBLQTioQ+BlI/j0I
	z+C0Imi/7ln1O9bvXP9chc08cwpMm/Ucah7EE06mxFN1BF2HIqHLSIUi1ejGScyr
	/lWAcnE8rexONy0Unf3WTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743071833; x=
	1743158233; bh=FVRzN5probz2tBNOBHZiwqoUS1ZTExFewoPw5q+Mbg4=; b=O
	BnTDDFMnhs2Qe7ZHwBeeoTkCDQtEuhC4LHQveFOpl2jccKNVyylQb6oFS4iGbUMw
	X3H8qoIBnE4iD4Xxz5wdBl/8w7zV2M8Huc40KznkBM8MV3OkFRW/RONh8bryoowI
	eQvBDlUg0ve5oaqrAaS5+nOg8miZh2WkYyPfjyItuYrf7glCW3c4cyMkGbY9mktx
	TejQGu7ZqKcnnC48jGJ+fRc2IRb7owfKSGhBwvJl8/vs/155097m7M6/d2rIsQox
	XI+THnTHmjz1QkE0Mj5nCgHYEhGy3MFuvtQGU+uesTFm/D4qi6UAxa2NjJSARiZP
	o+utKJVanCSp9qT/55Lfg==
X-ME-Sender: <xms:WCrlZxNDunxKH532k0cojXht-Cbc2cVsAHaJ70JmG-qff_YmQYOSFQ>
    <xme:WCrlZz-9Cwsek0bThvUMJagt5GD1zpb_O5VbFhX-vXwug9RuLFm5LdxaNNnc32n51
    J12zDW6U4VNWjR03g>
X-ME-Received: <xmr:WCrlZwSGek8ybH_1WviZlhLV0IdVPcDG0TlOuXdRhQOVcmuslK-cxEdbkWlfirPBRPSWt8o4WXUDsFMcFmKAxNN63_45sdoVsaewKxtOG7k_ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtg
    hordgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdr
    tghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WCrlZ9sTJjSkP5wv_0R9bC0xZSZCkeDpelyViL7uNbb5bE0OCHUpfw>
    <xmx:WCrlZ5f6NN5eJ-8SL_CdKPF0sBHRYfPmIIlux3WysIYylbn5wHvIRQ>
    <xmx:WCrlZ534zKuWFygn6BXvvL9Tf_ZhLoPoRzYAojv62czIuxFccAdC_A>
    <xmx:WCrlZ196_BbTPtgn9eXxQhkS4TMDMAjDPCpy4OParU0s4wpUoUf-ng>
    <xmx:WSrlZyEu6yTNUtxRXamban3qecFdOXvK0sIxZXljVUI2e_GJThqJ4oFj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 06:37:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a073dfac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 10:37:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 11:37:02 +0100
Subject: [PATCH v3 04/20] t: adapt `test_copy_bytes()` to not use Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-b4-pks-t-perlless-v3-4-b436de9da1b8@pks.im>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
In-Reply-To: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
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

