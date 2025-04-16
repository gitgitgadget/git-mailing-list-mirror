Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED3023C385
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744805783; cv=none; b=jTLThLuYOnaU+yF+1b24Y3guM/1SKsfH178whdMRo+d2p2H099XqECkrGNgwhILiK57pOCb2tlL4910BgbpfhCpi31CCGpHQ5rHszUqk5WoVnIWiPw2LKIxnyATIGphAJjqZY49/L86E5wf+wlmQPsLxdQzhQ8oiTcl2w2YOsVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744805783; c=relaxed/simple;
	bh=wlbe2qtXNnkBrjK60p9wilU1zsyLu/D/ihOqijsgMn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l1Soto4L16hHAsPVTbskPmZUcxbzU7yjHvrNcC2M3U1Uq4Z3U2bGJ6rAFcD6wxBloH2LVpx7lDjm1qDD9G0xgDhuylFPTuG7hiW2Aq4v6pB5QUhfA0bkwaaa4HK4+0KTC+0QWb9znOYNtsW+6IU9WUaYvlUKrLqRNcdJ4YWeMZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TuGYkVqJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UjLzBXJD; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TuGYkVqJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UjLzBXJD"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id D448711400E1;
	Wed, 16 Apr 2025 08:16:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 16 Apr 2025 08:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744805780;
	 x=1744892180; bh=0rhgTQ42jtsNwOZPEo1u1J4tYBhgJca0C9fLoG7I2J4=; b=
	TuGYkVqJAiK9AVuXsOwwvryedBbMnhl/vg3hdRVJaiS53ya1/aNXeo4r+gue/fWW
	hY8peTKtTlrAnxIctryxzMd8uMuapjf2zg0efV1/dzJSMO5F3zbUWzlLfLG6djsQ
	IoHVm+SnFbbSfJz6F/dpwRDlYKfq20UyL4AgQPDjPUE6N2gbq9dBtdFHGXFMxfpR
	mjAup8kBx7m7QcSqHfbBUxT9jd0YvUX8Zp2Yo4ZcIrMRwxf+IZ3/ntaXMOwrJUra
	5kaUmSvR0hAUymXpxkqGTU3SXtpO/UyNgZldN3h6jJrdR1n3FG2JzxrC6Ihx1o26
	wMFXpITsuHeNavHhaT2RHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744805780; x=
	1744892180; bh=0rhgTQ42jtsNwOZPEo1u1J4tYBhgJca0C9fLoG7I2J4=; b=U
	jLzBXJD7IQOWtrxqqSi0a/EOWZDSr+RZ8jQk9DOlqpip9UVWuJ044M+9QeitC39m
	TuFtaiD+J0Cd9yJM3xCnoTen17TkiuOX9+nFmuX0P0JF2yKbcMMAyLNPnBXjabdH
	yW3/JxETMOmft/3PngT2PtfqwLn8C9SZHB/tf62eUwSOdyz/HrY/qAWj31SR6y70
	QocPmE/vufeEIwq74uuxMMB9CYu6Ygkp/aNBIcZgimihfyDNELKhhhhC+qZbQSqL
	EHQ2syiRXVPFGVlUGRxAE9RXv57D286Xp6PkR2ODam8P/gNG2CbM2JyKsuYQmGz/
	tN93QXsBoUhWYrQaIPt6Q==
X-ME-Sender: <xms:lJ__ZxN-G4HH_4hpitMXCggSTEamji-E99jzzcV64CRbTTCx-dH02Q>
    <xme:lJ__Zz_cc6e_eiwCp3_Ej58VQp0OlNqX_Dw42iAoh2zt2uIqtDs7CSBxDo_03HLFA
    -yAtHXtFZTa0G8hQQ>
X-ME-Received: <xmr:lJ__ZwS5qQcDDl6Lpsy3t_QT1P-nIa49Z2oSU-s3POvbHeLhqPsI6Qk2ObKt9kOp0vnbXS7MfdSN82dtK09139Bnsh_cDpgBeQ_rlO6ojfyAQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeifeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    ohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:lJ__Z9vKEAz8SWaVIlESPqOVDb37T9qJ3SR9YxMDoNgn38e01QIqmg>
    <xmx:lJ__Z5fljmEb99hZswVND9GM0QukduX9qdMA_FyBzK39sLTLg9cjGA>
    <xmx:lJ__Z50HOAb1-CTBFIYMBpwX4gHagaIvoHG1HE--t9hBFwg_2X7ATA>
    <xmx:lJ__Z1_dC5oL3V751ECevG0n844P3skNmtVnEUhb2riKTIHB-gwnBw>
    <xmx:lJ__Zwf2XBRzThG7cSx8pWNGeojNa4tqwTNjUR_hnpA-3-5vIi9b7Kzv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 08:16:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 99d695ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Apr 2025 12:16:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 16 Apr 2025 14:16:09 +0200
Subject: [PATCH v2 3/4] Documentation: stop depending on Perl to massage
 user manual
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-b4-pks-drop-perl-v2-3-bdd0492e9498@pks.im>
References: <20250416-b4-pks-drop-perl-v2-0-bdd0492e9498@pks.im>
In-Reply-To: <20250416-b4-pks-drop-perl-v2-0-bdd0492e9498@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>
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

