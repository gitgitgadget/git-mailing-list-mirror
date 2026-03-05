Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758301632C8
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 00:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772671934; cv=none; b=cOSQ7YCdEgWQMXKDFeEsSyoT6aiJuhYUsx7hox1eGEfqyDiPjDIgvlcxn7hjSnBXwJcyVZziFasHyya8oFYrKFhJU3LMPn5F6x82nIu6J0jCb/bnXuMkXnJajgUnrVPr608ce4AR+O3jvEMVH277a5tFBwmc3Cd2J8tjSeTK6JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772671934; c=relaxed/simple;
	bh=jcgDwukSC1DVSos1K65JQ8LumLuP+q4tiK46hKwGcgU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=l27svDrNv/jJ3Ga3RlL31CXBeLSRmrCoENzD3E1rYil/A+wEdhcR0hO9FeSTUIvqZ5L4CVd3HuCoGA3nG1x+sCWMZ9NU5GpA+G63aSA/oMgpGn2dTh3F8nrkLe7VozMtk8/ywrkz+omB6BR8nglzkHY/ZV/1qsXpAlTUYZwjUio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhCtLG8q; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhCtLG8q"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b4520f6b32so8609154eec.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 16:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772671932; x=1773276732; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtJtoOT4vLVqvqSvGza5m+d2MopKw+gtTn3DLzAHGPc=;
        b=FhCtLG8qnHPSMdcuuPUSuSgf9kZYXk574QXd4ivwZsIGM6wwhWOQoHyxRugIfJQCbr
         L2ArVYLu3qzhX4+OBmh7tJZhLNttDWvSq0sK1Eb6KBrgvWQ0HaBRRC3ZDXTF/hTi+60F
         Ddf6v5GB+sgyQGYBV6adimb8w135X64d1BD8mtRAQlK/EjvyjcYNZMspd8elRvLmeszM
         qHmoy6903nDRQMHgFWF7NnjPl+Q4q92mXYOX3a96Kg0HwkcxQRaz695jOUkmeDjSpyOn
         VELrLctZSE72l9k6BDdsQBp8ZDGEMdyVVBa7rTVbzlFpQVg6t55ga6XKu/8Fe3JpUlU+
         FDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772671932; x=1773276732;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WtJtoOT4vLVqvqSvGza5m+d2MopKw+gtTn3DLzAHGPc=;
        b=gtiF6cjGsOIbAG4Pit/uxuwUcRCgo4etfLgRjYzy2n5gH/3Kmdz82u6rL+gh2VgEyG
         pKN5WNHOv7T+q95ipUmrse3ZHYO14/cYATiXQwhO98wn6EsP8MGPNBFVbzD+8VzxgIsj
         QhhJwOCcM1SKDeThav2fjr7oFobHGIwGUsqBwiO0HIDrf+4tfg8kk2NBawSTgPeimLl8
         UhT4zPlGiVRALh1wWS8kW0QF7y7VmM0DRsxty4Xs7yQ7o0MNpVUQxD8FeBGolbWMNnvn
         LfKLzq27xk6N+FPnlHELMK2kMHoGWSDurzZdt1AON+mUgn1nFkTH3Ee+QUWlFANyfyBQ
         MFZg==
X-Gm-Message-State: AOJu0YybGHeJOgGgIs1AZ8YFFOicToSTjD81wESQU9L5cgI4kiSoJuaw
	jOD9c9x+GOPUPpNSFDbLgvyh+ARoMAvewt0vCmOqpc5TjBLG6wrcYUkaw91ecg==
X-Gm-Gg: ATEYQzxMBXC15G/e6JYr5ewQQ6zF36lyMGt0obn/kEYun5r9CzWiOj80eVExBO6ZPYL
	b+meZ8+9jUkrQFh8LmAzSmMA7Jv3q83mhPn8GDoF4B1XbVloQqW2SeRWa71u3wBCiTdeniytWmb
	3s1Ws2yH4Z0/3uaXb70FJntGqQ2UrU8UBuDKw55RFvy2YbHjt2/NLKf8fMk0P8oNxG2zdTfPwP3
	Bw+QtfeMxkrB8d7DZxrVKmaDFk/en3yrcQqZuhOw1CktWZ0lrMl2WFbXj2xzrAz45FIXIDOuphw
	0ndpXRBhEu0mzxK8FjgOEzMLg0/xhADu7cryg3p4/GwTYu10+5WHaM1h88vu6c8JT22m8TneTzN
	hg9JftV3VZAvX/8HrXIvcIb+b703oy/5Y90nzmDD4UrkmGq9MTFbIuOK+WVJVPxAYGXVrcLmcLP
	X8WSMtVw5IHtyWwBcLlpk4aEEDCSC2B8JO4VQ=
X-Received: by 2002:a05:7300:1495:b0:2bd:e892:b075 with SMTP id 5a478bee46e88-2be30fd2fb4mr1413937eec.9.1772671931975;
        Wed, 04 Mar 2026 16:52:11 -0800 (PST)
Received: from [127.0.0.1] ([68.220.62.148])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f7e955sm16229652eec.32.2026.03.04.16.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 16:52:11 -0800 (PST)
Message-Id: <b2aaadb4aea37729989c6cd08838d7aee5b9dc4c.1772671920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
References: <pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
	<pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 00:51:54 +0000
Subject: [PATCH v9 06/12] fsmonitor: rename fsm-settings-darwin.c to
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

