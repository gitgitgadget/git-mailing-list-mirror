Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A7C25EFBE
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 00:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772065657; cv=none; b=TNs4vBaIxPVrNydzZFZC3iCXfkoJ3QI5HoD8JXPUwMvnFWwQq0Hkfrxa9y0otk0n/cHs/s1maQkGpZqBFxPGiADrovQnUJw3k+Rh5bF8eCP/UEOgPV/ATLXcJ/yhc2vIJFxVQ0YbJ73A8jMsHRdou2R5tven7FYF673MNh3ijgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772065657; c=relaxed/simple;
	bh=b5JjZWtnJOLPuxMiP25CgypABZO1yhKkVewEbbkepr8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qBFyKkkJa7KFotDNkTltxfZ2ws7+CsdHqbI/BLKgMkUT6IYWf9D1moLKRmffosX+wgAMqfCrVkDrHw9VJ2gacZbvnTIac4hkKrxJ5L+e937ZDG9QezQqdIAecwrH7OI1fzuveL9VAPYngfArbpUA0vm5H4jeQA9+wDb1DMlC394=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DysBkxVt; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DysBkxVt"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so511247eec.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 16:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772065654; x=1772670454; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NotBGRxlLc9dBySx/9QXHxZ2HtUYaaZl3BsMnsgSiuw=;
        b=DysBkxVtPSzVRokOW00O6DURCeney5rOKzFGWnAzmgo1rqhIw7vUdJG+GuaGzv9tzn
         oP9G826D3W7GngxqCmmK4aKQ62P/3EFAusqXtzN4fjOGuMsK0evMsl+60xdB5iz7941X
         cEsI+68M7dF0wzQaitybPnEYBT1oSJZF/l1Myq8LarlPD0zraEf+GeIpJDl5MXYMPM8H
         bQgpjvuOJfPwaJ0ev3KdMq+N1jmaIf1AY+fo345CZPTV9cDSwhwv2upCXdpQb4d2cD5e
         Lh5Vg33sMIas+1ug2cNRV/2apA44X07tBAa8G7wL4Yr/qQCYXEEuhRIKUFHlip2QkjMd
         fDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772065654; x=1772670454;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NotBGRxlLc9dBySx/9QXHxZ2HtUYaaZl3BsMnsgSiuw=;
        b=l9ZIIvB9huALVdPX7ZIwtXDCVKAVOoVCEEtB68OVXLk8NC6Cjau++vXo6T2VGTeGVC
         rH1+Q9aPgDdRVDiJTL5yi+UyF4ZMDA1lYgZogN708LSw1Jb7BgIkrCrSYGOmPq2DlBCz
         kl0wO3jSCAbQS5zN+3zyvbdH7QVtxgVoKh/CJ61XCUpb/sfYySEmhygIRZvtz0PRQNP6
         wJMsu4HqTenJ12lErgmi0G48vskhzx26V2jIyyTuNAfW8lP2acZ9ik5OwhZ18qYaq62L
         MCoZu6ApJ3vqJbE4x997C28DxNZ6orEMvpEC+01MDlXf89MuljGSc32jS6k4mkBiIr/U
         QZ3g==
X-Gm-Message-State: AOJu0YyjdFqqV8nqxD9DWQ8tn2d7XLItF20l6dHDAHpViCuS8DCWWOa/
	vUyZKSIy325L5HedQt0/1dGwLaymcPkXsOS/IqT0ipRm8EwlsRatEZa5wArl3ZTY
X-Gm-Gg: ATEYQzyYT1qGWbtm1J0S9+VK+RxF8EAHLrv6Au/Ze1RJBZjWwj2mCRmSKo67kwkqBYB
	vFHRCWMADRpcmb6wN4JP/6xOpUsprKA8r1Q6UYrXQjNHmz/lNg8RbIX5ML90J+eBxs1xwUTqTmY
	BiuiDeJ5hugjhoj3W+yHIRPCIU61I+VIo4CcCPpluM4yZSDd7KCfmWGiJ53P9xGrsSuMSNzWi81
	Zuq8Lka7pB/Edl75VNv9TKstJ1fr9zKbQDBdemxfa06+J6vbkfmbmprNVgR982g9UxAMBzzHfdR
	XKB19dngc402SnBsNNDSYrkuTYZ2ThZuqq/YM6ox2fbNbHYCzNj09CdOsFwcT6PdYBUOwRQBYIg
	i89mnaMbpDbfquPu3m+bPVrjijCCrTyyxSTgzBg8QhIp3L6UPPRHNX0rv3C7ls4Bwbcvwz5Sa56
	NOru/cDEa3X8jG+F9YHmS27l4BeA==
X-Received: by 2002:a05:7300:4348:b0:2b4:5b59:af52 with SMTP id 5a478bee46e88-2bdd301cbc8mr180531eec.29.1772065654477;
        Wed, 25 Feb 2026 16:27:34 -0800 (PST)
Received: from [127.0.0.1] ([52.159.229.150])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f45e23sm496780eec.24.2026.02.25.16.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 16:27:33 -0800 (PST)
Message-Id: <037ae2a03f8576a73feb889cd61220ba69d97fea.1772065643.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
References: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
	<pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 00:27:18 +0000
Subject: [PATCH v7 05/10] fsmonitor: deduplicate IPC path logic for Unix
 platforms
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The macOS fsm-ipc-darwin.c is applicable to other Unix variants as
well.  Rename it to fsm-ipc-unix.c and add a worktree NULL check
(BUG guard) that was missing from the macOS version.

To support this, introduce FSMONITOR_OS_SETTINGS which is set to
"unix" for both macOS and Linux, distinct from FSMONITOR_DAEMON_BACKEND
which remains platform-specific (darwin, linux, win32).  Move
fsm-path-utils from FSMONITOR_OS_SETTINGS to FSMONITOR_DAEMON_BACKEND
since the path-utils files are platform-specific.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 Makefile                                              | 8 ++++++--
 compat/fsmonitor/{fsm-ipc-darwin.c => fsm-ipc-unix.c} | 4 +++-
 contrib/buildsystems/CMakeLists.txt                   | 2 +-
 meson.build                                           | 7 ++++++-
 4 files changed, 16 insertions(+), 5 deletions(-)
 rename compat/fsmonitor/{fsm-ipc-darwin.c => fsm-ipc-unix.c} (96%)

diff --git a/Makefile b/Makefile
index 8aa489f3b6..7480ce3e1d 100644
--- a/Makefile
+++ b/Makefile
@@ -2365,13 +2365,17 @@ ifdef FSMONITOR_DAEMON_BACKEND
 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
 	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
 	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
-	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o
+ifeq ($(FSMONITOR_DAEMON_BACKEND),win32)
+	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-win32.o
+else
+	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-unix.o
+endif
 endif
 
 ifdef FSMONITOR_OS_SETTINGS
 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_OS_SETTINGS
 	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
-	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
+	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_DAEMON_BACKEND).o
 endif
 
 ifdef WITH_BREAKING_CHANGES
diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-unix.c
similarity index 96%
rename from compat/fsmonitor/fsm-ipc-darwin.c
rename to compat/fsmonitor/fsm-ipc-unix.c
index fe149a1b37..d34a6419bc 100644
--- a/compat/fsmonitor/fsm-ipc-darwin.c
+++ b/compat/fsmonitor/fsm-ipc-unix.c
@@ -27,13 +27,15 @@ const char *fsmonitor_ipc__get_path(struct repository *r)
 	if (ipc_path)
 		return ipc_path;
 
-
 	/* By default the socket file is created in the .git directory */
 	if (fsmonitor__is_fs_remote(r->gitdir) < 1) {
 		ipc_path = fsmonitor_ipc__get_default_path();
 		return ipc_path;
 	}
 
+	if (!r->worktree)
+		BUG("repository has no worktree");
+
 	git_SHA1_Init(&sha1ctx);
 	git_SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
 	git_SHA1_Final(hash, &sha1ctx);
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 28877feb9d..32ef6ebe1b 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -303,7 +303,7 @@ if(SUPPORTS_SIMPLE_IPC)
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-darwin.c)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-darwin.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-unix.c)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-darwin.c)
 
 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
diff --git a/meson.build b/meson.build
index dd52efd1c8..8de795f9d4 100644
--- a/meson.build
+++ b/meson.build
@@ -1332,11 +1332,16 @@ if fsmonitor_backend != ''
 
   libgit_sources += [
     'compat/fsmonitor/fsm-health-' + fsmonitor_backend + '.c',
-    'compat/fsmonitor/fsm-ipc-' + fsmonitor_backend + '.c',
     'compat/fsmonitor/fsm-listen-' + fsmonitor_backend + '.c',
     'compat/fsmonitor/fsm-path-utils-' + fsmonitor_backend + '.c',
     'compat/fsmonitor/fsm-settings-' + fsmonitor_backend + '.c',
   ]
+
+  if fsmonitor_backend == 'win32'
+    libgit_sources += 'compat/fsmonitor/fsm-ipc-win32.c'
+  else
+    libgit_sources += 'compat/fsmonitor/fsm-ipc-unix.c'
+  endif
 endif
 build_options_config.set_quoted('FSMONITOR_DAEMON_BACKEND', fsmonitor_backend)
 build_options_config.set_quoted('FSMONITOR_OS_SETTINGS', fsmonitor_backend)
-- 
gitgitgadget

