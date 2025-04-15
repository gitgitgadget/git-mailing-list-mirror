Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED3128BABF
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744711041; cv=none; b=ZkgwaniJhU03IViHRWajQnWPbt7xccC342taHglCkrzsflxSr7imDoCjDQAM3EIH4ShiMdW1T1Bm2iPXzoLjSDul7C7ffdlnDfCSRDKMhg4lBmUsrImcX+kDzyVHtsubvKr6SRQj0WF1rGFX9T2FU7TWU3f5YmVD/tE4s6BpO2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744711041; c=relaxed/simple;
	bh=wlbe2qtXNnkBrjK60p9wilU1zsyLu/D/ihOqijsgMn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AlQCf7u8DLeQBM61KQhleVDdRSsx1ZHqgcxhSKSoy6JscR8+4ngXCNAI7NvqpNS2BYfRPbtsvEpVZcWWWn+b5Eo9JuJ6gD1EdSYkk5W7wsAVaikPwFRXYF82dkUWg8FuIkuwRGEWcxkMdjIqhIuXC7OvzBazPUTB1kO5s1Q0EcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=r/waJWYM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MCOt7HyM; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r/waJWYM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MCOt7HyM"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D5B9711402E4;
	Tue, 15 Apr 2025 05:57:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 15 Apr 2025 05:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744711038;
	 x=1744797438; bh=0rhgTQ42jtsNwOZPEo1u1J4tYBhgJca0C9fLoG7I2J4=; b=
	r/waJWYMKc3OG+mMahm3XGikNqKUwmxZqpaPdnEO02kiVSOf1kn/swilEvfnNdIH
	fjXHkjOOwDU4uDDr3J9w6fGBN6hiErk32kbLPV1e8pNIUbNv07DQVtDU7ErZYkFm
	1G30gPOMgLaH7UQAOExOD+kimw28jn0f1wO/VS0D8X7en/4XQRuSfrj+CRbWhQhD
	jzdVpuWZtYRtfEUPCAhlAb06Fsejo8N7VTcfGozTYh6S0MaZQtQhxZc8dGzOUWNm
	fR1ZJaeGNJUQIKZGIXwJ35fT9yuUY0PldgJspaQsaWSV+SZzuSJCao2655WbvhG8
	pDrTogwinVOoUnnDJVnIFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744711038; x=
	1744797438; bh=0rhgTQ42jtsNwOZPEo1u1J4tYBhgJca0C9fLoG7I2J4=; b=M
	COt7HyMlibPKrsHCTNuLTwLAb6YVGqyGC6f402pRY4w+wMudUN4kxzC8yaHD9qNV
	/4u2+0dovRaxLso3jf4xydgrW1rp/IDu+ZXCS1jEQr9eY4R3Vy+wQKk+PqkK+S4P
	3hQ41BHNyJLebo8pb2mGBLAt9KGpzZNAwXK35+Dw0rSu9AHZfAveff/lUc/mzUKj
	3ENRmhhk/9enSnqCI0yZo9telz7/wJDgoPw69mAvhE0n3TCjZ6iizV2scXOsw34J
	+3TJARATroWLhRiaod+vhuAk9QsILndyrVkAXT4w/dB1XdxBBYDeiwJ4F1Cp8RY/
	uOkzJYNli1XtYl7XxGFVg==
X-ME-Sender: <xms:fi3-Zz1Lfr1famAObXOa5ehMF__bwKJxb3qXG0bwQ6fXQvo7LMcJzg>
    <xme:fi3-ZyHzkLAgoW1BBslhT6SmbvQIoQgO50yA6VJZAVSu4R0FRyFyx4zZF6C3W0m1S
    b0-RaAFCnLuC8AO_w>
X-ME-Received: <xmr:fi3-Zz6D8x-65dbFlo8pAL5v-ptm3nkKfp64ojGpd9j7FgSsV9ZFzJJG37mVuqv5F4rTovjfyZLZW98Kpz1OsmfgUCVNGOHEmkuGZlcjj6SjwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fi3-Z40BpGjdGs7dcRNTLG_UKNNXjimrX8WlcG6-IvU1Vw6yTBF5dw>
    <xmx:fi3-Z2EbedeN4128Oys6MAEKrD5VzEoETIWP8fJwFrTDIWQL1gFx1A>
    <xmx:fi3-Z59qfGnr2CuyNmBcG8T-dLAQvlAXLMeM-5NvkYnYOvzabctopw>
    <xmx:fi3-ZznR9VCQ0uGZs5lsyWyFJBNA4Wx0Qv2kLRlcUFCe8YFD0tvWbA>
    <xmx:fi3-Z5bDZn7CafVvICLixfyrqbj6eIfj0zuKsN55EofFy-fpacae84B_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 05:57:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 86029e98 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 09:57:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 15 Apr 2025 11:57:10 +0200
Subject: [PATCH 3/4] Documentation: stop depending on Perl to massage user
 manual
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-b4-pks-drop-perl-v1-3-c6addf175858@pks.im>
References: <20250415-b4-pks-drop-perl-v1-0-c6addf175858@pks.im>
In-Reply-To: <20250415-b4-pks-drop-perl-v1-0-c6addf175858@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

The "fix-texi.perl" script is used to fix up the output of
`docbook2x-texi`:

  - It changes the filename to be "git.info".

  - It changes the directory category and entry.

The script is written in Perl, but it can be rather trivially converted
to a shell script. Do so to remove the dependency on Perl for building
the user manual.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/Makefile      |  4 ++--
 Documentation/fix-texi.perl | 15 ---------------
 Documentation/fix-texi.sh   | 21 +++++++++++++++++++++
 3 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 0d3a2c6bfe6..6485d40f620 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -398,9 +398,9 @@ user-manual.html: user-manual.xml $(XSLT)
 git.info: user-manual.texi
 	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split -o $@ user-manual.texi
 
-user-manual.texi: user-manual.xml
+user-manual.texi: user-manual.xml fix-texi.sh
 	$(QUIET_DB2TEXI)$(DOCBOOK2X_TEXI) user-manual.xml --encoding=UTF-8 --to-stdout >$@+ && \
-	$(PERL_PATH) fix-texi.perl <$@+ >$@ && \
+	$(SHELL_PATH) fix-texi.sh <$@+ >$@ && \
 	$(RM) $@+
 
 user-manual.pdf: user-manual.xml
diff --git a/Documentation/fix-texi.perl b/Documentation/fix-texi.perl
deleted file mode 100755
index ff7d78f620a..00000000000
--- a/Documentation/fix-texi.perl
+++ /dev/null
@@ -1,15 +0,0 @@
-#!/usr/bin/perl -w
-
-while (<>) {
-	if (/^\@setfilename/) {
-		$_ = "\@setfilename git.info\n";
-	} elsif (/^\@direntry/) {
-		print '@dircategory Development
-@direntry
-* Git: (git).           A fast distributed revision control system
-@end direntry
-';	}
-	unless (/^\@direntry/../^\@end direntry/) {
-		print;
-	}
-}
diff --git a/Documentation/fix-texi.sh b/Documentation/fix-texi.sh
new file mode 100755
index 00000000000..bc300f7b0f1
--- /dev/null
+++ b/Documentation/fix-texi.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+
+awk '
+	/^@setfilename/{
+		print "@setfilename git.info"
+		next
+	}
+	/^@direntry/{
+		direntry=1
+		print "@dircategory Development"
+		print "@direntry"
+		print "* Git: (git).           A fast distributed revision control system"
+		print "@end direntry"
+		next
+	}
+	/^@end direntry/{
+		direntry=0
+		next
+	}
+	!direntry
+'

-- 
2.49.0.805.g082f7c87e0.dirty

