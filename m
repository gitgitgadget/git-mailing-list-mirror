Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEB9C38141
	for <git@archiver.kernel.org>; Sat, 21 Jan 2023 20:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjAUUE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Jan 2023 15:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjAUUE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2023 15:04:27 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B727422A1F
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 12:04:25 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so5935707wms.2
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 12:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=635tptHN5xDofEb7JyPgFkugYZzkGuVaXNmv7iWm0n0=;
        b=fE0zcrK66KE8itPZesxthjn+Zk4U3My0kgCk3kXZhBuppXUzRTqKbgCg+NP8b/XhPI
         2k8Rt6vcKXp+ZuI91EKTZLMaDGxnATEVtmjZ1geBpNRNqJaYj6+sIW5GwvafS1KnxPE2
         x8eojMF8MXDG6eH/ZxL+Whx7jkOgfzlJ+jYy/eiA4Y9jKZLY4P3xb2teLrKyy4Owxrfn
         6QmavvIZ6jV7dYYpyn1UBSPiLApdGTF8J3IEGQ909T26Lg7Cvenh65iM5yZ0JwoazxNZ
         25U3/WlZZEYS9LQ8MsMz6ranL/MSM4kiryJuRX3WHJDD4MNDuyaObRsT6AiM1+djy1zr
         19+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=635tptHN5xDofEb7JyPgFkugYZzkGuVaXNmv7iWm0n0=;
        b=d8RJeDmx3G/WBQZbcoBEvAXbHSzzIxXz0InAlcqBjHLuVrX45YCtihgrXhyPf8CRFg
         eLhlOWwB0+2mzTC4QTUQXWc8TOPyYix24ZAmbPEwt4X36Ft3KNGYzIhq88nXKMIMI7it
         3OZpo0za10+z6FoLF4uEi51YmQnESwIK9SWbWLgSH/ewhA7N1W+Qp6vYHIscM4CKJRGg
         jjFfSp1vZ/RiMkg1pNM232JmE4QVAp0nSek2KYU+23ne25kbzfcvT4yss/Tt1WJggdYl
         EJJsTqTc9L4LNV2C+txtgTNAsNOiByD6DG0xEk27zed4517vLz+LF23WETB7vfV4ShGB
         vcpg==
X-Gm-Message-State: AFqh2kqgcCFCBY72sHDzjoiev3yrY44oE28TkPoDjEuZ5eBM+x8JXukp
        r4RpxjLwd7hnulCYfvehv6LejDKXJ+w=
X-Google-Smtp-Source: AMrXdXtAN3E9HwUSHWGxWBJKUt1yvmUtOSDlvoX8I3qnoIulNXe9owOoEfyXaN0wjxPJtTt3wVVj6g==
X-Received: by 2002:a05:600c:4fd3:b0:3cf:7197:e68a with SMTP id o19-20020a05600c4fd300b003cf7197e68amr15031907wmq.18.1674331464045;
        Sat, 21 Jan 2023 12:04:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p19-20020a1c5453000000b003db09692364sm6033563wmi.11.2023.01.21.12.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 12:04:23 -0800 (PST)
Message-Id: <pull.1438.v4.git.git.1674331462560.gitgitgadget@gmail.com>
In-Reply-To: <pull.1438.v3.git.git.1674330625069.gitgitgadget@gmail.com>
References: <pull.1438.v3.git.git.1674330625069.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Jan 2023 20:04:22 +0000
Subject: [PATCH v4] mingw: prefer RtlGetVersion over GetVersion
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

The previous way is deprecated and returns
the wrong value in Windows 8 and up,
returning the manifest Windows data
as opposed to the actual Windows data.

RtlGetVersion is the correct way
to get the Windows version now.

Note: ntdll does not need to be
manually loaded into the runtime,
as this is the one special library
that is automatically loaded upon launch.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    mingw: prefer RtlGetVersion over GetVersion
    
    GetVersion has its behavior changed in Windows 8 and above anyway, so
    this is the right way to do it now.
    
    The previous way returns the wrong value in Windows 8 and up, returning
    the manifest Windows data as opposed to the actual Windows data.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1438%2FAtariDreams%2Fmingw-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1438/AtariDreams/mingw-v4
Pull-Request: https://github.com/git/git/pull/1438

Range-diff vs v3:

 1:  31f778a6b34 ! 1:  8293e868970 mingw: replace deprecated GetVersion with RtlGetVersion
     @@ Metadata
      Author: Seija Kijin <doremylover123@gmail.com>
      
       ## Commit message ##
     -    mingw: replace deprecated GetVersion with RtlGetVersion
     +    mingw: prefer RtlGetVersion over GetVersion
      
          The previous way is deprecated and returns
          the wrong value in Windows 8 and up,


 compat/mingw.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index af397e68a1d..b1d75c93cfe 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3081,15 +3081,42 @@ int wmain(int argc, const wchar_t **wargv)
 	return exit_status;
 }
 
+/*
+ * for RtlGetVersion in uname
+ */
+
+typedef NTSTATUS(WINAPI *RtlGetVersionPtr)(PRTL_OSVERSIONINFOW);
+union winprocaddr {
+	FARPROC procaddr;
+	RtlGetVersionPtr procGetVersion;
+};
+
 int uname(struct utsname *buf)
 {
-	unsigned v = (unsigned)GetVersion();
+	union winprocaddr RtlGetVersionInternal;
+	OSVERSIONINFOW version;
+
+	memset(&version, 0, sizeof(version));
+	version.dwOSVersionInfoSize = sizeof(version);
+
+	/* RtlGetVersion always gets the true Windows version, even when running
+	 * under Windows's compatibility mode*/
+	RtlGetVersionInternal.procaddr =
+		GetProcAddress(GetModuleHandleW(L"ntdll.dll"), "RtlGetVersion");
+
+	if (RtlGetVersionInternal.procaddr) {
+		RtlGetVersionInternal.procGetVersion((PRTL_OSVERSIONINFOW)&version);
+	} else {
+		/* Should not happen, but just in case, fallback to deprecated
+		 * GetVersionExW */
+		GetVersionExW(&version);
+	}
+
 	memset(buf, 0, sizeof(*buf));
 	xsnprintf(buf->sysname, sizeof(buf->sysname), "Windows");
-	xsnprintf(buf->release, sizeof(buf->release),
-		 "%u.%u", v & 0xff, (v >> 8) & 0xff);
-	/* assuming NT variants only.. */
-	xsnprintf(buf->version, sizeof(buf->version),
-		  "%u", (v >> 16) & 0x7fff);
+	xsnprintf(buf->release, sizeof(buf->release), "%lu.%lu",
+		  version.dwMajorVersion, version.dwMinorVersion);
+	xsnprintf(buf->version, sizeof(buf->version), "%lu",
+		  version.dwBuildNumber);
 	return 0;
 }

base-commit: 904d404274fef6695c78a6b055edd184b72e2f9b
-- 
gitgitgadget
