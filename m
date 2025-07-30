Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2802DFA25
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753893846; cv=none; b=Hwg9VUNBijBFPLClBoWTKsbh4+pHc1N/iJEzHc1QqJ8nKLcJwGuIRnRhjN6sVQC8baNkDNoEhtoCB6lpWTiDbOf6svHUPNaqlRGX4+qT69BVoTWGA51w7InGWdb2zkxPDA1KMDEBbUW1ZseBUzcRyrWJv+3Eyfua5amieX8j23k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753893846; c=relaxed/simple;
	bh=CS0gCu31kQGiEBMZlaHZiHry3VS32HOmKanAjs+XgHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBJfiCkbrRzM3Cm4qSpz5XXM6cGXQH9yEsRQLOdlMone/y/AmuHF4t7H5AY54nuO5TqIxndKEs+M7UoQCuxTtb2llMnPTsr8sYgwTNwYTrqoRC4zC9/ZoXh6feDIF/jQ9N+ldF+0o0cP/+C5CbuRUNgAVQOWx3vfjKAfiwYQKaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLIRDQ6O; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLIRDQ6O"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-749248d06faso5110b3a.2
        for <git@vger.kernel.org>; Wed, 30 Jul 2025 09:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753893844; x=1754498644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ze7NpQx0fYzCyL2aSc20gqTMOwErvj1HnP/p+uGzc40=;
        b=WLIRDQ6OMMGYC+dEqIeSnH1kB/lm8/XdBO4/kbRYzD90QcjYoMeMNNbqtC8NgLKm//
         0DR7bu2iy97m+dZsOcijbNAR9pphOe0arGm23HGDsNlmVm4ACBKdWEHw4nG+QwETZXbp
         xyqmDCOBuxeLDH1wXyPvkEQ10sFEsuwGtKLAEWpgh+h6UcbvAnb7bs6EZeN1N9NXm4fU
         I2Df9p13K7MSKn6s/wAVZ58r2oH4QCh6HehKB8VuFT1r1KzMrxLtAnPZpvjbxViuNEDq
         GXOFArD3T0ms+mwKZxQ7v1P0d8w5e51xuQBp5V2KxISIYg52aiqHnX0zSbV+QpJka412
         uJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753893844; x=1754498644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ze7NpQx0fYzCyL2aSc20gqTMOwErvj1HnP/p+uGzc40=;
        b=iOR1aWoW+HWbPj8d0Ld9zNHo1hQzFKdq0pJle7hvmg2Edkj6KjJwrzHV6fqHpNkTQL
         4hFG894FP28agnF/joTMwC/ob8GF2VCbXGDHrci8Rjh9ApvvZtZ43VTJDIBDyc+20vmn
         pkI9mORxXJmU0h1QbG9Zqkvw6/Ix3lfUhAeDIGkn+2EZp5QN7Zh5DvtmZIMcXMHadzkt
         N3OVWddKXKgAQeW6rTgL7YV60PbMVJ/xrdY0qeB7UvRtcwl+cdv3opmNBesXLxhyIZ1K
         1aBmAjFmM4ZYKPXKFhuVvpIDey7lOQvCoVOo0o+psKvKvTDtmAOOMol2MSj7mL8zKYcK
         cjwQ==
X-Gm-Message-State: AOJu0Yxc2vf+K5xiL6WogysnLlY0GEW+nB3nCBQ5KviXBkL4owMWEuC5
	26fnFjgcmuwmMu7E2n0HrMQmcqrDQjlf2QaKnLImtc9WY6OmbPnzykhvh2iUFw==
X-Gm-Gg: ASbGncvGKCvyGAhV6TrZjp6mlC4mvH9mi0DT2BgdG06XPQPzIydBUDhmNDYJrLU6UYT
	6yhtRFtucKtmBayX+GWVPlvL441iZ71Hu7NnU0WLnsr4dTbXg7Rftw7+DorOQYUQn0zWyjEO6LC
	AecJ5K7Ks/nOhWFEg3t/xcxfDDPVngssVtgrOkICTpeSwF3by3cNuG0cI1WYszVK6qEhNZi7CTR
	p/KL9u+Fv8Jop3TqzvJK2Q8RY45Wug4JfipeEZxrEgTKZ8grtgEmoaFK5beHEN/V5GIBpnRi6nM
	IgaqDrTXftXCjhkE0Kwxr4KKuFtksPkgp+HWUqC9RTV+3qNx7d30AM1Jq9Y6jta7IV9ae8Nu86b
	LXjRZ/ZDVig0Qyz1yqXIx4tFJplY3I3rJxqAJbnLtOWR5+aTlDW6a+6GUvdydIi4o4gsJnE65E0
	SiD4xNbxI=
X-Google-Smtp-Source: AGHT+IHZrQ4+OPqhJBE9h3oGbZW+odJ3W76UfjDuJSGQ98Iw04sYgKUx+e82E1tWXHk5if2wz4TvpQ==
X-Received: by 2002:a05:6a20:2446:b0:233:14ec:4f83 with SMTP id adf61e73a8af0-23dc0d68e30mr6760581637.6.1753893843735;
        Wed, 30 Jul 2025 09:44:03 -0700 (PDT)
Received: from localhost.localdomain (c-73-70-17-6.hsd1.ca.comcast.net. [73.70.17.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f58b95esm9671536a12.16.2025.07.30.09.44.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Jul 2025 09:44:03 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH 4/5] git-gui: honor TCLTK_PATH in git-gui--askpass
Date: Wed, 30 Jul 2025 09:40:51 -0700
Message-ID: <20250730164052.15371-5-carenas@gmail.com>
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

Since its introduction in 8c76212 (git-gui: Add a simple implementation
of SSH_ASKPASS., 2008-10-15), git-gui--askpass has been calling whatever
wish interpreter is in the path, unlike git-gui.

Correct that by turning it into a script that would be processed at build
time.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 .gitignore                              |  1 +
 Makefile                                |  9 ++++++---
 generate-script.sh                      | 22 ++++++++++++++++++++++
 git-gui--askpass => git-gui--askpass.sh |  0
 meson.build                             | 22 ++++++++++++++--------
 5 files changed, 43 insertions(+), 11 deletions(-)
 create mode 100755 generate-script.sh
 rename git-gui--askpass => git-gui--askpass.sh (100%)

diff --git a/.gitignore b/.gitignore
index ba845f3..5130b4f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -4,4 +4,5 @@ git-gui.tcl
 GIT-GUI-BUILD-OPTIONS
 GIT-VERSION-FILE
 git-gui
+git-gui--askpass
 lib/tclIndex
diff --git a/Makefile b/Makefile
index 2ac5f44..b2d7ffb 100644
--- a/Makefile
+++ b/Makefile
@@ -173,10 +173,13 @@ GIT-GUI-BUILD-OPTIONS: FORCE
 	@if grep -q '^[A-Z][A-Z_]*=@.*@$$' $@+; then echo "Unsubstituted build options in $@" >&2 && exit 1; fi
 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
 
+git-gui--askpass: git-gui--askpass.sh GIT-GUI-BUILD-OPTIONS generate-script.sh
+	$(QUIET_GEN)$(SHELL_PATH) generate-script.sh $@ $< GIT-GUI-BUILD-OPTIONS
+
 ifdef GITGUI_WINDOWS_WRAPPER
-all:: git-gui
+all:: git-gui git-gui--askpass
 endif
-all:: $(GITGUI_MAIN) lib/tclIndex $(ALL_MSGFILES)
+all:: $(GITGUI_MAIN) git-gui--askpass lib/tclIndex $(ALL_MSGFILES)
 
 install: all
 	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(gitexecdir_SQ)' $(INSTALL_D1)
@@ -215,7 +218,7 @@ dist-version: GIT-VERSION-FILE
 	@sed 's|^GITGUI_VERSION=||' <GIT-VERSION-FILE  >$(TARDIR)/version
 
 clean::
-	$(RM_RF) $(GITGUI_MAIN) lib/tclIndex po/*.msg $(PO_TEMPLATE)
+	$(RM_RF) $(GITGUI_MAIN) git-gui--askpass lib/tclIndex po/*.msg $(PO_TEMPLATE)
 	$(RM_RF) GIT-VERSION-FILE GIT-GUI-BUILD-OPTIONS
 ifdef GITGUI_WINDOWS_WRAPPER
 	$(RM_RF) git-gui
diff --git a/generate-script.sh b/generate-script.sh
new file mode 100755
index 0000000..0dd2da9
--- /dev/null
+++ b/generate-script.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+
+set -e
+
+if test $# -ne 3
+then
+	echo >&2 "USAGE: $0 <OUTPUT> <INPUT> <GIT-GUI-BUILD-OPTIONS>"
+	exit 1
+fi
+
+OUTPUT="$1"
+INPUT="$2"
+BUILD_OPTIONS="$3"
+
+. "$BUILD_OPTIONS"
+
+sed \
+	-e "1s|#!.*/sh|#!$SHELL_PATH|" \
+	-e "1,3s|^exec wish|exec '$TCLTK_PATH'|" \
+	"$INPUT" >"$OUTPUT"
+
+chmod a+x "$OUTPUT"
diff --git a/git-gui--askpass b/git-gui--askpass.sh
similarity index 100%
rename from git-gui--askpass
rename to git-gui--askpass.sh
diff --git a/meson.build b/meson.build
index 1cedc82..320ba09 100644
--- a/meson.build
+++ b/meson.build
@@ -38,14 +38,6 @@ version_file = custom_target(
   build_always_stale: true,
 )
 
-configure_file(
-  input: 'git-gui--askpass',
-  output: 'git-gui--askpass',
-  copy: true,
-  install: true,
-  install_dir: get_option('libexecdir') / 'git-core',
-)
-
 gitgui_main = 'git-gui'
 gitgui_main_install_dir = get_option('libexecdir') / 'git-core'
 
@@ -61,6 +53,20 @@ if target_machine.system() == 'windows'
   )
 endif
 
+custom_target(
+  output: 'git-gui--askpass',
+  input: 'git-gui--askpass.sh',
+  command: [
+    shell,
+    meson.current_source_dir() / 'generate-script.sh',
+    '@OUTPUT@',
+    '@INPUT@',
+    meson.current_build_dir() / 'GIT-GUI-BUILD-OPTIONS',
+  ],
+  install: true,
+  install_dir: get_option('libexecdir') / 'git-core',
+)
+
 custom_target(
   input: 'git-gui.sh',
   output: gitgui_main,
-- 
2.50.1.475.g795bb014d8

