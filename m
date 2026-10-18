Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3034D0CC7
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792337080; cv=none; b=tMTmu01yXZxQWSJ/dStNQTncRcKZZiVtL2HK8jLWxoKXQLVqjhKXtWPPuei1oTls/04IICt+9ajR8/GSdtB/Ef2mhg4brcBEoBZYL5h1k4e5IQleuvVggZt1tm/S3hIVZsGcCQfeB/11jogD7I/O3yKr2vKczR5qLOCe+3NRVLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792337080; c=relaxed/simple;
	bh=B9Ubekv2QTpX8w7yS0cxYO9gNeslWf4s4cc2Gpq6fUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HeuRSsZLoJA+BeRUgAKzUI6Pid3Bbc8kEiDhQ8RDOpK3e0Xvb8h0wDu+FUzfrCN7oQ7EeGP02v3Gw3uoOyS3Yp2ukK+n+rBQROm79clhPAs9QeQWFRYlRCNjKi1qtQnpR4x96wWKUvtfDtLnENGO19GsbXuCVE3bsBCpZcHaw7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBaefqxH; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBaefqxH"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3ab1a37faaeso1962841fa.0
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 08:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792337075; x=1792941875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wKBO35TTYhQRByiH9MuB6ioAbFHKLdCW4cjUUx8OU3k=;
        b=lBaefqxHdUBpDoXoAdtVBCF2EIXx2vT/lmMpcFiI9gzIjgWS3sAqdkNeu8y/dHUSX2
         cBvWzpCL2Spf1Cb2rgqrS8ZhwoljVdPU/4AE4bh1NbhOtMk26HHrHLVE7brK5E4LgpPb
         AcpTnlTt88N7RxeMxwtf8t7MbU9UkoEPdhyEh/iMD2fZykyREWjRAYPxKb3B01cNC5Jw
         KoUHiMDcsaR11yWXYXvPjb/EqOXvBehfa5VwulxYBxxDvEwcbiJ5Me4s7xxnTj1ivS9Q
         tud3VzmRaj3GESFIhsbp4lSYcPjAulx4h3/79UwMGv7QRoHCIHztMqjTWuo92XA84aKC
         mr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792337075; x=1792941875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wKBO35TTYhQRByiH9MuB6ioAbFHKLdCW4cjUUx8OU3k=;
        b=c6MPIee3RHkGStCoQ0x1dbmG2IyXtpVTzVk4HosTY3DtTxK1ugQdFuvK1KerhHOyrZ
         p6KH+Z89qw3zchP/rSs1quccCVDc1UAIFp6YV/pT/2ICa7d1DSLeO2E0lKOdFopcogoF
         baR9+ILO5Fml/nda8muduOXE6D/NscBiYtBK2kRGFlvn3Xu5236xfDlgiBNKboowdOyN
         E6dzD8eVBCGFdI7NtOyEcoucfraxeq5RHFrjAM4qgVNTw5cisiZOZaRhJ2x/YDZxLwmB
         UOQfsEZ38wEpA4vqMxHp/mKLBlQ5YS/RwzLBjtDOoVegXrZPPYa5m3fa/prY16bA55yZ
         wWtQ==
X-Gm-Message-State: AFq9FYL2jWTdmso1KKJxSLXsdwz2wfJsbS5l50aq4T/vu9HxNhYY3ISH
	QOHD0lBa2hp2F9f1fAx4SRv002t4JAoXXJmm0T0HrezW+0P/dmKzYAUjsaCaA2ZZk9s=
X-Gm-Gg: AYBFou2eOmyAYuxHJmDR8PEEvAiLULISDo3edLVZkSOUiBsG03N93kQPHbsC6OZlMzB
	uscsKkyunBQRiMJ5GpnTgitglV+G5PnSaE4Ww2LY8iPoWSA8a3IVBUDB5VPg4v+qmB/0IQ+Tc1w
	gfyT3L2nsZlyTY3lVP/PiCeB40Q4r61phX0XAjyG4nLuBMquT2EpxE2GqN7GBBNjVtivBdSPj83
	nFsL3A+japoqaOUbusNM4E6AzZZDX9LejJZZkjktoPaJLXd3OVNgMWUAa8hQ6Zh/Gwt6KmuWLKW
	W7BOi6C2gUMU47b9kRwJUE62xmlJsbgWaOvt72SrEa/bP5Qcs+ZPl/3304lGbp8iYms9AShUJIn
	wPDptRgBy9s3LJxPU1gSizNnGjpV2JXFENvj5+WDXmIWH5pHUtm+y+d1H5DSTBMSAFNtQyNTsl+
	2ozVGLfM94Q9VLklQQlzzROnHG81456tCMheNfbg7+2hIeVao3S0nSNQySoP8aNZeFK1aaDBgjK
	Kg+s9q070mvsl938r//fkfqWRw2tCCZBzm82kEIUg==
X-Received: by 2002:a05:6512:3f20:b0:5ba:3579:3673 with SMTP id 2adb3069b0e04-5be50a88e2emr1512541e87.5.1792337075053;
        Sun, 18 Oct 2026 08:24:35 -0700 (PDT)
Received: from Iris-HRQ6HW3.. (78-71-217-218-no600.tbcn.telia.com. [78.71.217.218])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a3fd03dsm1483225e87.11.2026.10.18.08.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 08:24:34 -0700 (PDT)
From: Olof Fairbrook <olof.fairbrook@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Olof Fairbrook <olof.fairbrook@gmail.com>
Subject: [PATCH] config: read the bytes of a blob as unsigned characters
Date: Sun, 18 Oct 2026 17:24:26 +0200
Message-ID: <20261018152426.2716899-1-olof.fairbrook@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"git config --blob" and the other readers of config from memory get
each byte from config_buf_fgetc(), which returns it as a plain "char".
Where "char" is signed, as on x86, a byte 0xff comes back as -1, which
is EOF, and any byte from 0x80 up as a negative number.  So the parser
stops at a byte 0xff and silently ignores the rest of the blob:

  $ printf '# caf\377\n[some]\n\tkey = value\n' >config
  $ git config --blob=$(git hash-object -w config) --list
  $

and a blob that starts with a UTF-8 byte order mark is a "bad config
line 1", because the code that skips the mark compares with unsigned
bytes.  A config file has neither problem, as getc() returns unsigned
bytes.  ".gitmodules" read from a commit goes through the same reader.

This has been so since config_buf_fgetc() was added in 1bc888193e
(teach config --blob option to parse config from database,
2013-07-12).

Return the byte as an unsigned char, as getc() does.
config_buf_ungetc() checks that it is given back the byte it read; it
now compares with the byte as an unsigned char too, or a CR followed
by such a byte would hit its BUG().

Signed-off-by: Olof Fairbrook <olof.fairbrook@gmail.com>
---
 config.c               |  4 ++--
 t/t1307-config-blob.sh | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index d9019e7e6c..fbe873274e 100644
--- a/config.c
+++ b/config.c
@@ -92,7 +92,7 @@ static long config_file_ftell(struct config_source *conf)
 static int config_buf_fgetc(struct config_source *conf)
 {
 	if (conf->u.buf.pos < conf->u.buf.len)
-		return conf->u.buf.buf[conf->u.buf.pos++];
+		return (unsigned char)conf->u.buf.buf[conf->u.buf.pos++];
 
 	return EOF;
 }
@@ -101,7 +101,7 @@ static int config_buf_ungetc(int c, struct config_source *conf)
 {
 	if (conf->u.buf.pos > 0) {
 		conf->u.buf.pos--;
-		if (conf->u.buf.buf[conf->u.buf.pos] != c)
+		if ((unsigned char)conf->u.buf.buf[conf->u.buf.pos] != c)
 			BUG("config_buf can only ungetc the same character");
 		return c;
 	}
diff --git a/t/t1307-config-blob.sh b/t/t1307-config-blob.sh
index 5cb546dd00..e2c0883350 100755
--- a/t/t1307-config-blob.sh
+++ b/t/t1307-config-blob.sh
@@ -72,6 +72,27 @@ test_expect_success 'can parse blob ending with CR' '
 	test_cmp expect actual
 '
 
+test_expect_success 'a byte 0xff does not end a blob' '
+	test_commit --printf FF config "# caf\\377\\n[some]\\n\\tkey = value\\n" &&
+	echo value >expect &&
+	git config --blob=HEAD:config some.key >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'a byte 0xff after a CR in a blob' '
+	test_commit --printf CRFF config "# a\\r\\377\\n[some]\\n\\tkey = value\\n" &&
+	echo value >expect &&
+	git config --blob=HEAD:config some.key >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'can parse blob starting with a byte order mark' '
+	test_commit --printf BOM config "\\357\\273\\277[some]\\n\\tkey = value\\n" &&
+	echo value >expect &&
+	git config --blob=HEAD:config some.key >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'config --blob outside of a repository is an error' '
 	nongit test_must_fail git config --blob=foo --list
 '

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
2.43.0

