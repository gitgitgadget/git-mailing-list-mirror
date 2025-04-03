Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA00919DF4D
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 05:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743656767; cv=none; b=YA4MRrf1Icc5pX3PbbS2Qzod89l2LLBMNjeBT/M0awZfWOnURC8/1jKvmk1c9Fldf13+T3TlwClO/epJxw1eAc6h/gY+GoYRW9agCEg+dL6pT54KkEFi41lhssMlRk8cGg2Lm7jSLaB4lOJHykmhe1TsCFpL4+ZCqfCb0nlpGM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743656767; c=relaxed/simple;
	bh=wUjtEwhCxGHAwr5qr/OOPHnJwJ6RXrKJr20am0V1E3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BQc9yZ8BLx6QtEKPSdlKbpR4r31FYE6QZReoIod0lGujj2H8YDlEOD3xNBOnpJ7RdXHiy24uvxZccoN4wGt/WyprNXBDZI8NbUFo4oIRcLie29KtVwAtFG0jCBeBpr92zSBqvLAM6pomiLaQCvspvycC6Tvx+z7Y9ZOCnB9hyiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W9isgnRq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L0u4mDas; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W9isgnRq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L0u4mDas"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id DC85A114019D;
	Thu,  3 Apr 2025 01:06:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 03 Apr 2025 01:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743656763;
	 x=1743743163; bh=UrD2EpYKGl1WHIFc6EMOT2Otfv/s6i3zk+gh/xeYwo0=; b=
	W9isgnRqKj+KNgNLg78vdZ3bq56x9tuBy4oATsKhqC1fCWul+ajO0us23riCrU3p
	s+YdM0cy00M7tI/KfQwJiqschf67edN7H3cqBNDsPqJBEyXcwBXBACPqvaF/07L6
	FguZOfJalIenZO+BQIPvG5UACHxrtLaSRxJ4c/Gu3tAJy6rgHsMBoEZbf9FSG0Yf
	oerw3wFmTeC/6FEzdeVwAfkRo4qqDMl8M6qoODEhbC/DWv02FrDJEiUsLHWxRhHd
	tIEPrAowhWZKPXgM8+KRd1GYc/Ypzq9MhJqDX3qzadxjusD0D9OEly+8vCpgmaIF
	1TVXKZWJkVasMPlEs0F4rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743656763; x=
	1743743163; bh=UrD2EpYKGl1WHIFc6EMOT2Otfv/s6i3zk+gh/xeYwo0=; b=L
	0u4mDase6BxMpg03dKdQds3k6GuX8THk9JLX6q2thjTE3/9WQ9kitVV6bVRVyPqj
	a6Y4N70sbcVw4SY0c2LqX0cnWGifHiA9yGvPkviK24VylHJfxFSYZ5xGyJTjNqAK
	U2B5R9SlKPRo/0y6h3Ljxz05U3t3P9094qr5byUcrpeSmkpfHno9MBRgjI17VHiQ
	HV5N8ur8rgD4Z22oG1eGaFEmpFMBSQurm20c9hNHAvOT3tFiLZPtAEZRnGplvoip
	tjDz2O3j5sSmcvuavXlFCgyDfJbABYx7eia4+7nddUB2P8aZHfEmVd1mn0gmjBmb
	5i47sAo5tOqtVw29Wg4lw==
X-ME-Sender: <xms:OxfuZzOO2mgTTUXo8zTCAiETLt8SSIk8ih50xyIpVSwpqbqoeWFp6A>
    <xme:OxfuZ995ypm0XDuGufjLwRwLGd3JclfBbN8-Wr77hrwwdEZegDLvcFUl13MBd0Ui2
    Eczkifl3lDrcJoiJQ>
X-ME-Received: <xmr:OxfuZySWqBfbOZrb25bqJHs0qBrWfdBtjiq8f5k98c-S_RWhoYt8-F3VLy5WLLZ3hx_NmxUeQdjl91uOoxTvsMYjt6fChI0e2niC5GJClBi3c8s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OxfuZ3uxv2--OFI0sC0OxH6EmjQuhKRA2YBvSbHQEDjPpGAh3dVRjA>
    <xmx:OxfuZ7fXulGHnYnSDLZmX_4ZRayly-wq_fFfS_aVLSEZMM1wY1DcPQ>
    <xmx:OxfuZz3f9rkTogwk7AE4ctS7oEHlo4SGtqlD6_SHA1fcxMmrLQ3-QQ>
    <xmx:OxfuZ39shx-WcvmaJC36WpW7pRM5NJZQjSg6S4lFOJcV_U7nuDXRIg>
    <xmx:OxfuZ7S0wsiNslWRckcaeAUsILFGYJJOF9T5okCTpfBIYdVLwYuJ3hUL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 01:06:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 041ecfc8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Apr 2025 05:05:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Apr 2025 07:05:55 +0200
Subject: [PATCH v4 04/20] t: adapt `test_copy_bytes()` to not use Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-b4-pks-t-perlless-v4-4-be20ac3db39a@pks.im>
References: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
In-Reply-To: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
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
2.49.0.604.gff1f9ca942.dirty

