Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E22D376BC2
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475320; cv=none; b=bnYHVTTzj4XMZ51fWeWgtAH4dKXa8Ao9BHsD+0XM4x3Xp0fWJTl4APPA1LwWNLGgEKGrFpkT+IIaYJ2fTPqBXSax8EjHAvMXSMu5LmFMTkIFv0r/CzrCbp1vF4n5l7+E03JUtn1X34k5vO/vBKSOJBkqeWMr5EA7d24hkO/+OOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475320; c=relaxed/simple;
	bh=6w/QlsY8bJKy9R3dS8Pm+COOlXmaHus95lvcWBLwA2k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NVjBzQ/Nj1dufs6Khz0xX701W1DH5A3uwoUv0IplZfh8GRpTiVnRE7HODqdrhHB8tooYEfl7nrbpmqOt8HrQ5hFCGHp1SbAASxleTMZVJTZ/WMvAHL28TzTcmDFuSoN4/9Xf12iWLsYVgD2oO0d+G+DBR23nEJDn269wxJd+R7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsLDP6nw; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsLDP6nw"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a0a33d0585so5386195ad.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 03:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768475318; x=1769080118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4/PEAiycu+Acn9ZNbhPg4cdMRwBROWE5BFKtT6Wnx54=;
        b=PsLDP6nwmNl9CbPQtfLDVEQaiJrnf35LfELFP35d49kFXGDxNktibGSxwPQ2b8Gu7L
         8ps1QmrvvyN8eVO1dVXDs/aAA8lXV/PhkQDXobrCL9XWlEZ6GMqJTG8lIS3PLLYVar5D
         MTt3m49D2VPshqcXR48mCMzH+uTVD+Ewt7OYN4l2ZngmFTl7hZfpJlIuW8FL882xaZBY
         e1snR9bMz8lA8dz2jCXd6zdq/IlcCL8HMrZrdfMuOuPfmkW0uvwwUU+J/LV6eOzUXypV
         WmcGhNINSMSA0r21QMZvJtkgY3Y5YKRo05QfzfAEN3Mt+cApnKByPmkTpa9BG5A9H39b
         Dp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768475318; x=1769080118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/PEAiycu+Acn9ZNbhPg4cdMRwBROWE5BFKtT6Wnx54=;
        b=dM5iw8/9yLe63/kYR9CaPxgOchFAr4UYd5a0R0JDYx9U+qBmvI4EGugWbkKzhNqt8d
         zQLOKHj3+O8t2cUUgG5xsxKt6HNX2KwZ5NRKpfBovwvMSO1Xpe8dFkjQxKuF7TfcgCxB
         ++aAB9Kdv6A5AungbCTeE/YmUBOhhSaEU+VhCreOMOxGEqlsLuLoyviP+sFkIpwHI6Nh
         XBbJSFODfGPGPS+K0hjfizomQgFgDozJpC3y9+P4atWbF8oHcxoNET7AAn8cIcP9RvnK
         EHiChiD2LgMLliSj9M+lfMohl9dmgDAu9CBTmoW+FdzxRkmR/SwiD/rNOESdB7c3alUM
         Gppg==
X-Gm-Message-State: AOJu0Yx7sZkN94JnDL0HhInzJJybPAcZrk2GTNhgWw46WsH8Dmv2jyVM
	oUuLnq9GWJf5NF8JeYnd5dtkv/c1+6RxNA+/QqVVCxzxV0cQScNR9N2B2Sh1uuzx
X-Gm-Gg: AY/fxX6/By9SibiGoGpGjKf/u7HFCKqYHPPxM35RKg3r4cP5yRySSjAcVyMfItQytmW
	igJuo7kEbzfOvDMPfWI8g40H+fheF11R0iZc4uMyat9LLrt0i6/25senMitAbkXsyNObVR1Hlol
	KCxb7SluSqS38X8QPVyeqnTU6Vrc6z2ciCU3L1LzMrpGNaSqMFtb7uoIVurJpuwC6MAu3JPp6k+
	AzxeikTFKBaFeKlN4nGklzrTweEDfXhiRJ6Mp4UNkVR3g2Yko2a3fKT0ay/e7Xg488Mh8RNB3Zd
	B553+Wo0cpshDh4u2JG+0lxCyCWaNr7M6OuCL7OOowsUnDvMnufclqL6975e+re5rfWjE/r0e6A
	8DiirhZTYKN+DCvei3ZkQHWe/TMwnDJqP1NJob644DeF/l2Du+W7inKudzKx8aNRbND1uVO4knX
	Qe8KohzU7mN4ajvovq25tIzcEmQtXOE/pN
X-Received: by 2002:a17:902:ea0a:b0:29f:301a:f6d2 with SMTP id d9443c01a7336-2a599dd18b2mr58929275ad.19.1768475318365;
        Thu, 15 Jan 2026 03:08:38 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2b72sm251288235ad.51.2026.01.15.03.08.36
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:08:38 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH] Documentation/config: fix replacement for --get-urlmatch
Date: Thu, 15 Jan 2026 11:08:05 +0000
Message-ID: <20260115110832.15315-1-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation claims that --get-urlmatch is replaced by

  git config get --all --show-names --url=<URL> <name>

However, --url cannot be combined with --all, and this command
fails in practice.

Update the replacement to use only --url, which matches the
actual behavior of --get-urlmatch.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
 Documentation/git-config.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index cc054fa7e1..ac3b536a15 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -332,7 +332,7 @@ recommended to migrate to the new syntax.
 	Replaced by `git config get --all --show-names --regexp <name-regexp>`.
 
 --get-urlmatch <name> <URL>::
-	Replaced by `git config get --all --show-names --url=<URL> <name>`.
+	Replaced by `git config get --url=<URL> <name>`.
 
 --get-color <name> [<default>]::
 	Replaced by `git config get --type=color [--default=<default>] <name>`.
-- 
2.43.0

