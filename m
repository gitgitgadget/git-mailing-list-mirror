Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DFDC004D4
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 17:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjASRHc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 12:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjASRHb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 12:07:31 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC39B8C913
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 09:07:28 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id b7so2525761wrt.3
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 09:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5l+IUvDSrltGfJAanPXO9kQtvR+29NxtIOMH4OF0IpQ=;
        b=Re7EA+N9Ymr9u3Fs7kioGkkvmlQUVV3S2O6a3hlM1KGANPGy71p9GrLpECbuxxtTqP
         7nj2e3x0C7SXbyLmFxrF2J2jAxqbOZzBJ74zTuaXe1jTPYJ4p/861XEUr34BK+i5rYoM
         gu14djqGIHI/VG+ZQ0DLrYWhFon46QNE2RPRq5eIVZpUW9kTKgV6N/EhKKWBYk1/1x31
         zzydFVuMiEDMHam9ztQQcFusMHabsg3FaeaAFn2pSz0LXzVeTOaG65NkGenam9EG3n8V
         tSEz4AHm+B4oSthPf/KqeYotT1LviB+SPNGl2I7BsJa3aS31UNO39HgUaJDI45B7jxig
         MTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5l+IUvDSrltGfJAanPXO9kQtvR+29NxtIOMH4OF0IpQ=;
        b=kc3iFVY58NSsSi1eF0l8T8/roTcHKBfx/CNW15OSAzbJcPafGV9nD0EmhYyI2VU+x4
         Ce3ORoC3XXQlNTTEtapKme07ZICJHvkl/Jw8Rvv/hBanLI62KM1N5dYEXxXZROM99/SG
         oVIlE/YB4ghwwx8BhzbmI1Hp0Fiiv7gDOZWB4MINkQDPR6ps9Kvr+DUzS+fLKfIWDF7C
         7niWffyGmBqk/JA9gZoFIP+7z5cnE8y/h/gK3qyE9Y7g3+kHusC8/e5eBw/tyJupiPvq
         2twKZ+hZnf1Vh3PeuuskP4RwoK9rKZv2v8TCAWcDpC7UFHHOpFq8xVDmVc2UU3b/neZf
         +asg==
X-Gm-Message-State: AFqh2krdAaaWnmcAAz4mttodB4l7oOVOGvQBf1P8lSi891S6ZwY0HvUG
        3H/1mOhMknbWXNnSJBOqdZcjnvSJd2M=
X-Google-Smtp-Source: AMrXdXv4DM6JSTAYZWT1IqewtKRVN9IFgOwvIrrPAAaHqM2VnFb7GohcnK+20BYyyWuVpWGuL4q/DA==
X-Received: by 2002:adf:ec49:0:b0:2be:512e:283e with SMTP id w9-20020adfec49000000b002be512e283emr735324wrn.56.1674148047021;
        Thu, 19 Jan 2023 09:07:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d534a000000b00272c0767b4asm34680498wrv.109.2023.01.19.09.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:07:26 -0800 (PST)
Message-Id: <pull.1438.git.git.1674148045970.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Jan 2023 17:07:25 +0000
Subject: [PATCH] mingw: replace deprecated GetVersion with RtlGetVersion
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

RtlGetVersion is the correct way to get the Windows version now.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    mingw: replace deprecated GetVersion with RtlGetVersion
    
    GetVersion has its behavior changed in Windows 8 and above anyway, so
    this is the right way to do it now.
    
    The previous way returns the wrong value in Windows 8 and up, returning
    the manifest Windows data as opposed to the actual Windows data.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1438%2FAtariDreams%2Fmingw-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1438/AtariDreams/mingw-v1
Pull-Request: https://github.com/git/git/pull/1438

 compat/mingw.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index af397e68a1d..ebd5850002a 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3081,15 +3081,36 @@ int wmain(int argc, const wchar_t **wargv)
 	return exit_status;
 }
 
+/*
+ * For RtlGetVersion in uname
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
+	OSVERSIONINFOA version;
+
+	RtlGetVersionInternal.procaddr =
+		GetProcAddress(GetModuleHandleW(L"ntdll.dll"), "RtlGetVersion");
+	if (!RtlGetVersionInternal.procaddr) {
+		die_message_errno(
+			"Could not get handle to RtlGetVersion in ntdll.dll");
+	}
+
+	version.dwOSVersionInfoSize = sizeof(OSVERSIONINFO);
+	RtlGetVersionInternal.procGetVersion((PRTL_OSVERSIONINFOW)&version);
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

base-commit: a7caae2729742fc80147bca1c02ae848cb55921a
-- 
gitgitgadget
