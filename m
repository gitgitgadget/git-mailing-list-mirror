Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC3E393DD8
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498112; cv=none; b=BuuCLkKGWKdWFY4BoW8ukrUyGgBOionAapCUZvidvv45s0Va+z4/3Hl2NEJYCp+wf/3KCuBMMSQWBymxZ/eCEacoQ2G4l/eDIsj2ASua11a+DZYFg2+e3HCbMpTK2QRyE/aikB3YSMgMggFyvRMzdEndQBGxRnyfh1bCbd83vpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498112; c=relaxed/simple;
	bh=jcgDwukSC1DVSos1K65JQ8LumLuP+q4tiK46hKwGcgU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Dlov2PayMbKQyedKpjU/+Mq/Eo3DawfALReEMWSZGTZKaTwvSM7/Tt/1kfravDesk3+Qj5WD5SorXdcS50XskBn3mvUAVdAfPXwhLRFf4U99Put2x8r6Htm87Myg5rYQiSSJqaZ7u1igVFk03kMKhJcM+L+6V5roL/c+zyR+zOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQ8ZbgpI; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQ8ZbgpI"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso3844525eec.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 10:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775498110; x=1776102910; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtJtoOT4vLVqvqSvGza5m+d2MopKw+gtTn3DLzAHGPc=;
        b=RQ8ZbgpIoDxNjMNFri1YB/4YD58uNFpBqgnPt57jvg5BZbwh5d1/CCEyvXqBMixEhO
         O4urYHtMbCt8KYAFPewkHpQOxr/1V4OHwbTmj3oVaqf2KWeockiK6NoFstIV6yzgoZu1
         Vnf3Z9XP78dKudjpj7SdkiYgYW09e9RLaZEAP1EZ9yzZiITcBsYIm9E9/s+IgTl1SNxy
         yXAU9zBjy3TdUNhR/jer8YJhQ7RBMv0z+m+Th3Dgvo98xih0AGaq8bW3R6myBGfxingU
         u7TvxUS9RV1FvljbaW3M6OnVrwInHSO3KAhFErzfebwWUVve5O+MT/ZMvyKWg9OJVB3t
         6O1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775498110; x=1776102910;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WtJtoOT4vLVqvqSvGza5m+d2MopKw+gtTn3DLzAHGPc=;
        b=LyDcEVg4rT116bD3EPMcaqiMk/C444h5X+j76ZmOSxGLdJcVpcDB+parRP+43SCmEf
         2MfzPJW5clNL7sCMnaJHy5lVyGfIwmwbfuoul6htaiEBWr8h3oqCQEv6OAlnW+PZz3gK
         m2C+wBkDnnlkPc8W0pPsHFrtqIByvS04CjSLQAJsP8q4FeX7lhaeZvqZgKtqouBY7WXk
         JQ/h5rNqEzFi9uvKa3KwyOUEzZ6t99Ax/ODsCXXNQzYSMfIcUB6ZNgUhSfog8fK6aFrH
         PtaXw85EUKT4uHWg24a3mXVnqi4OT4YPD3n5tRutQm7JbDy+avwxCiahwIEpNk8aMQqJ
         3vLQ==
X-Gm-Message-State: AOJu0YwArkwiN4iH6/PJ5Uyv4phZaMrL1JH5c4JtmgbdCs6rEuN0/MB7
	ecnvu3yl6P4WuVYWAz2/5Mz1KaUpj2y8GRCeu9M43ok/o2JycgtitVMsH49rzw==
X-Gm-Gg: AeBDiet0f3tKexoxKU3sCpGNnHi54H5TMazcSfR9vZb6HXkY6MkELt//gIVxG8cmtlG
	ABI+NPX+p+k9hF7GZpi5tDkxkF3lG4Dk1vUQDCOodxrl3aQ7tc6ZPSA9d6T8AS2L1mOEQFxulZX
	LrB1gSyzo9Ba3VJuXI7cJ4faZ0LYP6VTyM13Gxut0HAEkyoxLm/Xtt9lFMiafEwY7ckbrCQ4YTI
	1X9HzDIA8vM/zzW3czdqme9PdPMtB7+Zph9Jq/1yC4XoPMcwvfIrvoZA83bQxh6HiZ41sfOlJvp
	ZQtOniNQ/W4mZjC2N5dqHhUd5ldCwD068ddUqtxBroEoJlWSmhm+Bh/BGj80MlUVly+99y6Owri
	y3Gn4Whbmi4GvCIHTRhwzGHHNtJUXx8EG0st87P2U39tjZ31GbDEGtbNvTWmYvlFGtbt488t2+i
	mQzHb8ekGSte0nUgrK4dbq2CiFijE=
X-Received: by 2002:a05:7300:d509:b0:2c7:2cac:8123 with SMTP id 5a478bee46e88-2cbf99ec1d3mr6285035eec.4.1775498109793;
        Mon, 06 Apr 2026 10:55:09 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c20c151sm14175600eec.19.2026.04.06.10.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:55:09 -0700 (PDT)
Message-Id: <e13d938ddbd42d4f3fd765655250b47e96f20749.1775498098.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
References: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
	<pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Apr 2026 17:54:52 +0000
Subject: [PATCH v13 07/13] fsmonitor: rename fsm-settings-darwin.c to
 fsm-settings-unix.c
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
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The fsmonitor settings logic in fsm-settings-darwin.c is not
Darwin-specific and will be reused by the upcoming Linux
implementation.  Rename it to fsm-settings-unix.c to reflect that it
is shared by all Unix platforms.

Update the build files (meson.build and CMakeLists.txt) to use
FSMONITOR_OS_SETTINGS for fsm-settings, matching the approach already
used for fsm-ipc.

Based-on-patch-by: Eric DeCosta <edecosta@mathworks.com>
Based-on-patch-by: Marziyeh Esipreh <marziyeh.esipreh@gmail.com>
Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 compat/fsmonitor/{fsm-settings-darwin.c => fsm-settings-unix.c} | 0
 contrib/buildsystems/CMakeLists.txt                             | 2 +-
 meson.build                                                     | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename compat/fsmonitor/{fsm-settings-darwin.c => fsm-settings-unix.c} (100%)

diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-unix.c
similarity index 100%
rename from compat/fsmonitor/fsm-settings-darwin.c
rename to compat/fsmonitor/fsm-settings-unix.c
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 6197d5729c..d613809e26 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -306,7 +306,7 @@ if(SUPPORTS_SIMPLE_IPC)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-${FSMONITOR_DAEMON_BACKEND}.c)
 
 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-${FSMONITOR_DAEMON_BACKEND}.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-${FSMONITOR_OS_SETTINGS}.c)
 	endif()
 endif()
 
diff --git a/meson.build b/meson.build
index 86a68365a9..4f0c0a33b8 100644
--- a/meson.build
+++ b/meson.build
@@ -1338,7 +1338,7 @@ if fsmonitor_backend != ''
     'compat/fsmonitor/fsm-ipc-' + fsmonitor_os + '.c',
     'compat/fsmonitor/fsm-listen-' + fsmonitor_backend + '.c',
     'compat/fsmonitor/fsm-path-utils-' + fsmonitor_backend + '.c',
-    'compat/fsmonitor/fsm-settings-' + fsmonitor_backend + '.c',
+    'compat/fsmonitor/fsm-settings-' + fsmonitor_os + '.c',
   ]
 endif
 build_options_config.set_quoted('FSMONITOR_DAEMON_BACKEND', fsmonitor_backend)
-- 
gitgitgadget

