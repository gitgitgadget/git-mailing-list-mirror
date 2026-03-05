Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AA3313558
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 06:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772693730; cv=none; b=dvKIkYW79v660IMZcvofINr7XTVsejrnq8iqF0FY7VZpNSeZd54+eVMrUFqraC8TPu5I2j1pC4+7j36jV7HkZOZqclEnm+YZDYrzPFPLG5S8zUvrQW+iHzA0hGuDVXI9nOJHT4cgwj3XIYxzX2mvVAweOlqzZ6+Pix3oxdSXg8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772693730; c=relaxed/simple;
	bh=jcgDwukSC1DVSos1K65JQ8LumLuP+q4tiK46hKwGcgU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jwWCOswz8sjfv8CYZqAbPxnEVAJEtxCJrLHPhJ2XHmW9K0AasE4PBvV1uPGt89ZGMRVw6mkiDk3TQmS9oi9XZt+EHQqn6dL4gx1+4L6eTvu+M0M4XpcBoUQJqwU7gBQCuxFRO0qc3L9PP/hVXbV+7z1NwmY8Bg1wGyi8F5lfK2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cvdi0ASV; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cvdi0ASV"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b6b0500e06so9506303eec.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 22:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772693728; x=1773298528; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtJtoOT4vLVqvqSvGza5m+d2MopKw+gtTn3DLzAHGPc=;
        b=Cvdi0ASVKEj6TcdBAyUvcIu/R6syH2UeK85Sb8Vv57hp5nNxiuCxZjlmrZP5P54Fvh
         LlpWrX7QgbP4zBWVVoe8kHUX4UuYI4hl7zIOAvAv6G28fbhcM+5WlJyg1Jf8kv3QGZw1
         LHBz0iIl0DGrOsb35nXGn6G5Gn0FBdP+SDXkdr4NPb6aG15/5KBr5+Ps3j/p9VYxozj1
         T8KGaBi/vUcBBY/3bnvw0NPRHoDhtBsRlZiM7LOB//Che2y10PjZyB08tPesWKmZH6xH
         EQdavc6X4ht5ZtOiYgIOP/zqIXxp4zDI5HaLVh3C9jucISvXfiQupnBme5frCeoGjfUm
         0frA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772693728; x=1773298528;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WtJtoOT4vLVqvqSvGza5m+d2MopKw+gtTn3DLzAHGPc=;
        b=BiiRqGKpywoVF1xr1RM3v/kgq3c7BjnmDSURvsjV1g2MWDZAblNnsLAykfZdmcjnje
         VV7FHpRfBuFSrrmPAVfkqHMNL7or8oP2K1duAiMocbgNePxF80+ThNOoN/8mjukLbJTZ
         ofv9syjAQw2arkOtbfLE+GZA8ubKRy/J1SE2zIMbpYt+X1zGq3sTLtdGI+dEroZ0MXQJ
         FkLb94jjfmsLoQ6LfmpQ1kfL4PR5+FbaeasLxd68ykFZbggQXCFzQ9lykALnCwjh6YZn
         FyWkdzRwEU3I2/4hHiHRR0VL9Seqfwh7DyAa88I2ol5cC7sBYoJt3UgJKJbhl876r5mI
         0udQ==
X-Gm-Message-State: AOJu0Yz712yo2nm0XCRgpaZftHsSdJ0Xbhd0G3xCmgcpWhBbpOZ/aNG6
	O4mh54i0ZspRU2LdEEMN+tY6j7CbwVwzrsN3gXiEW2a+/7isaBkq9vrlSktifg==
X-Gm-Gg: ATEYQzwpkvajRrj5cZ24NUnNBjtTIOo21Vizi+gcKx/90ZFIp19lXv2wyPGKhW6ASoJ
	0PUczGp6+orFjn3WmRLr/ymdQ5fEfF1JTkXvpjWEQcjRGXJWtinXmg7iB2CVjrp+XT/m8Z7uln3
	OR5AzgKEx5CsvWBVkQTIvxwEt3qmcjy/GIm+PesVCkb9sKaCoDW6p3zgSzt9K3XdbW43F87e4pc
	iw91g8oOhAWxtj2PnTi0GEGQNmewMJiB9UCPw5FN3pkhriVwwd16aHfXJGQy+6KwBOgijFC5O2E
	NkZYXILiMI5k6vLrgSD5Fj6m2Sgha3d9/5MV5M6eUB3AfVuVQ9vSh4fRb+qHWsGI3vFNVgJ1YJZ
	cYxGPPToHS2XUMMNLTbIGc/lvqBZgJd8d64Nq3fLe0JIrQg4EoxkaaEfvbGEr/Apltqoxf0AcHl
	d/+qcSceUu9vy7dg4WPwvQ440dIQ==
X-Received: by 2002:a05:7022:689d:b0:11e:65b5:75ce with SMTP id a92af1059eb24-128b707d63dmr2130733c88.10.1772693727793;
        Wed, 04 Mar 2026 22:55:27 -0800 (PST)
Received: from [127.0.0.1] ([52.190.182.112])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a43885sm25499672c88.12.2026.03.04.22.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:55:27 -0800 (PST)
Message-Id: <b2aaadb4aea37729989c6cd08838d7aee5b9dc4c.1772693712.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
References: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
	<pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 06:55:06 +0000
Subject: [PATCH v11 06/12] fsmonitor: rename fsm-settings-darwin.c to
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

