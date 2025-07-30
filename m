Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4892DFA4A
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753893847; cv=none; b=ci2H0f66LjSYDxhnbH6rWDy1e77QiOcvJbzajWKGDd43XH2neADTB3O4gDJOMUUDEDhOgQphBe2vVAjpiu94KEmNKLxyTz4wOLyPzRabyKAPuXwqOnbvFbLAYzKQEaIbEATEfkZavqVR+GRwQl+k/gO4BBpN8RCCIRWl/SY+Tjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753893847; c=relaxed/simple;
	bh=uJtZomIJi+HJ/AeNCfsYn17xz1izpvFpRFU+OGkY9S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4DrBr05R502CuM+QF8mi6CpWL/dRNhBPvptH7Is77/mCYmXNnbqzydZ0Elq376aQBK0H7VkGVkm1KZPWAF8rKHDGJvlseDmHAmJ2EjXZc/PE6Q5xhwn6D2/PY8BmGSQp26AbmtX7gVw+7A0cyYqMmCJNPNfVri7590qnTlDyxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jy6nvdx1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jy6nvdx1"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76b0724d64bso13226b3a.1
        for <git@vger.kernel.org>; Wed, 30 Jul 2025 09:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753893845; x=1754498645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXdYKuC5RSU6BH2qRDOAfKxYZuOMYAGkvUiip3RYfic=;
        b=Jy6nvdx1dWPrHWqZpTLEj3rzoUzSvddPW6OX221B+/6lqpM0/3bwRNeAcKLReDNucZ
         0kSv7dXgx7Ds3Iuj9L8W8e8ELIfle1zShkZ4qEpAGD7GA2gk2Qqvtv6hhS5dwy3AVEQG
         9h+RE/cnGOa5RiR2e5zb4zFs80pEuWn6VyPhzFZMi/ipFk5nisYRuOe1eqtMNbQSy5XC
         dxWGJSTNRA43ljMtXYJDx6Ea4fahXefEuyELWX8ioeZEsBGfW6z7bh8RLXVyqhp7DvfZ
         dZsgd4R1gYyk4LPMiXI9AfWqGENIpGFA+H0y/tpTL2aFOD4m+bR4yHdgZ6Fd2cEQrJyi
         0NvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753893845; x=1754498645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXdYKuC5RSU6BH2qRDOAfKxYZuOMYAGkvUiip3RYfic=;
        b=maLnhMyjXy0CeIkqzyrCnDU/QLpRThVqEFVo4XM3/yxtBRy+nvzfM3b2B7WNRcY81q
         NvneQutRVuG+YFt7lH3VhaZe1AXVAKMhBFH+LT8h5XEokwNlcDL/6O4kFvbEf8G88KtY
         qj++/DBz/mw5Z+J4WlIl9x/GYlUF4tpsfBXWi7kIh8y63h9SxYBgf1PwvN8+mmy7kHoG
         TH0xAumb/SdllqoAdiUakwb5QGfkhEWYnft88F94O3bjjadIaGmxMRbD75W2dj+3i09x
         N1xyP8l/duLNlCUVhzTnP1IxrfwgkndCqZRplK22DuHy13N1SROhHBaOsdlhqbGS/zsp
         HLQA==
X-Gm-Message-State: AOJu0YyMf8rR25LJwiGvO0lo3Oiy4SsVSSEawNHTTOnnxNWAlGNf8b5s
	4epbCZw6RAYSW994PevnRTQv/7rNByepH+xPE0E7V2Nrmsl35du1Bkji6haWhg==
X-Gm-Gg: ASbGncthX4jzrOYXUXS5Ep9I+dmnQLffa4g6GvLzG2boEmw/RdGDNSJJp7LIzg+mPeh
	xYn/gLEyJUt4bJYXGTnbBdaNnGNG8dj3Xtk6NkvCjcbAXxmMR+HmmGr3zt+W7dYCWWiwBAtf0JT
	zpNF9Rp1kGNpSYX6SMJa5oDzpUvesD1Td06JECVkngchBXPv2FjoGWxTz2bXNZKB9rd2nZxHenZ
	62JrCinX4EzBYowHqC9zNLWtEKx/e9GlxWZqdfH4f3V29SioLfXVnidAARS/p5xr0j/z7dCHdkY
	i+PFTUVGfnKWtBHzvyxQCTEsz+E6fBD20hHTAfgUZQ6AsyPitSe/llhVqng+3iM1tf9WbqLS8na
	O4SR7ACO5NvzA1FAWXOJTw7ySrXJxgiHZffPtMkWaoezqDlMedO2xifuwd3Y1MiDgKbftvuVd
X-Google-Smtp-Source: AGHT+IEWilZwUJ4fTVrSbP5fhKRRe4m9BoLr4QKhZ0DhGlRdTGusfOrGV3DLALLoOZbfgKSbFVXSVA==
X-Received: by 2002:a05:6a20:939f:b0:237:b321:1e0 with SMTP id adf61e73a8af0-23dc0d581a1mr5883778637.17.1753893845051;
        Wed, 30 Jul 2025 09:44:05 -0700 (PDT)
Received: from localhost.localdomain (c-73-70-17-6.hsd1.ca.comcast.net. [73.70.17.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f58b95esm9671536a12.16.2025.07.30.09.44.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Jul 2025 09:44:04 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH 5/5] git-gui: ensure own version of git-gui--askpass is used
Date: Wed, 30 Jul 2025 09:40:52 -0700
Message-ID: <20250730164052.15371-6-carenas@gmail.com>
X-Mailer: git-send-email 2.50.1.475.g795bb014d8
In-Reply-To: <20250730164052.15371-1-carenas@gmail.com>
References: <20250730164052.15371-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Propagate the `git --exec-path` that is defined at build time
and use it when defining which askpass helper to use by default.

This is specially useful in macOS where a broken version of that
helper is provided by the system git.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 generate-git-gui.sh |  1 +
 git-gui.sh          | 10 +++++++++-
 lib/about.tcl       |  4 ++--
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/generate-git-gui.sh b/generate-git-gui.sh
index 39dfafd..f804686 100755
--- a/generate-git-gui.sh
+++ b/generate-git-gui.sh
@@ -22,6 +22,7 @@ sed \
 	-e "s|@@SHELL_PATH@@|$SHELL_PATH|" \
 	-e "1,30s|^ exec wish | exec '$TCLTK_PATH' |" \
 	-e "s|@@GITGUI_VERSION@@|$GITGUI_VERSION|g" \
+	-e "s|@@GITGUI_GITEXECDIR@@|$GITGUI_GITEXECDIR|" \
 	-e "s|@@GITGUI_RELATIVE@@|$GITGUI_RELATIVE|" \
 	-e "${GITGUI_RELATIVE}s|@@GITGUI_LIBDIR@@|$GITGUI_LIBDIR|" \
 	"$INPUT" >"$OUTPUT"+
diff --git a/git-gui.sh b/git-gui.sh
index 8bb121d..9e6c152 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -364,6 +364,7 @@ set _isbare {}
 set _githtmldir {}
 set _reponame {}
 set _shellpath {@@SHELL_PATH@@}
+set _gitexecdir {@@GITGUI_GITEXECDIR@@}
 
 set _trace [lsearch -exact $argv --trace]
 if {$_trace >= 0} {
@@ -387,6 +388,13 @@ if {[string match @@* $_shellpath]} {
 	}
 }
 
+if {[string match @@* $_gitexecdir]} {
+	if {[catch {set _gitexecdir [exec git --exec-path]} err]} {
+		error "Git not installed?\n\n$err"
+	}
+	set _gitexecdir [file normalize $_gitexecdir]
+}
+
 if {[is_Windows]} {
 	set _shellpath [safe_exec [list cygpath -m $_shellpath]]
 }
@@ -1114,7 +1122,7 @@ citool {
 
 # Suggest our implementation of askpass, if none is set
 if {![info exists env(SSH_ASKPASS)]} {
-	set env(SSH_ASKPASS) [file join [git --exec-path] git-gui--askpass]
+	set env(SSH_ASKPASS) [file join $_gitexecdir git-gui--askpass]
 }
 
 ######################################################################
diff --git a/lib/about.tcl b/lib/about.tcl
index 122ebfb..d68e23b 100644
--- a/lib/about.tcl
+++ b/lib/about.tcl
@@ -2,7 +2,7 @@
 # Copyright (C) 2006, 2007 Shawn Pearce
 
 proc do_about {} {
-	global appvers copyright oguilib
+	global appvers copyright oguilib _gitexecdir
 	global tcl_patchLevel tk_patchLevel
 	global ui_comm_spell
 
@@ -44,7 +44,7 @@ proc do_about {} {
 
 	set d {}
 	append d "git wrapper: $::_git\n"
-	append d "git exec dir: [git --exec-path]\n"
+	append d "git exec dir: $_gitexecdir\n"
 	append d "git-gui lib: $oguilib"
 
 	paddedlabel $w.vers -text $v
-- 
2.50.1.475.g795bb014d8

