Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B60DC4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 09:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiKYJYL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 04:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiKYJX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 04:23:56 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206A931F9C
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:23:46 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y4so3498209plb.2
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W0iKq/HUK6wjnBERBLJf65elNbpK9Fmk4ojZi1XwGts=;
        b=A7Ausc8e8HAXDCK8xCWl54OXiTR6IjNtmA/wyZEK/TYb+XEBXeO5dDfE/Q6H2vRjT6
         7fk4r/+zcoMQ7FAjkjLjoAQP9iGSPEQTNr60wDqcYZUNFekEGzE4fkLqoaMYCzdN9lO9
         0Q3hUPwHXkvxryMFGDxWsGeACTDPesW+kCBU9skQ5e+WlERxu32YZlwxSDlc8m9x4MhT
         56enAk5LUWDRDSaXv4c3uG6FTgsdONjUdvds9DEmePQIZv6WvBGQQK64kaEpMQrIuCgd
         g7+6s7ADZHR4pbHU9z0fs057Wr1jqU4aKm3KO9/LPQ7abawaHOk2RodlvmghDBVtTCPY
         IaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0iKq/HUK6wjnBERBLJf65elNbpK9Fmk4ojZi1XwGts=;
        b=PkWpUNi5owtzHqBD8rVlR2gTGD9faOd6deQlTjU9tyeX9i0dqT7OmV/GiJG6lYLKQ1
         ZUUllZuxi5NaXAtmtWjGa5mjnq3QBBjlGwAlsHQTVEw9iGXyvUZs7ljV+niPR2wlHOXk
         gOeYcqszNAUqmlFB2srF//HkfvNZsNlmZCpRGrjTpKWJ6+93+Nz0Ldf75XOc9NJia68e
         NALkn0ASTxs1J5NQPO76EGxV2SYSPIIfYoiuumz7V6wbGBafAAJqOJqL2nv981pMXb6s
         KZsYaspLcNyLGWk//gKsDI/G7c6HIV8ztNSY0HMiGr/gT2E9WGeefZa7AHO2Z7lq1rPD
         GBnw==
X-Gm-Message-State: ANoB5plPUaRKNXhvU/6vvdcZJPN0QPJORf5Yvl2zbC8laF01TxWVAL3L
        nKrY18y0w3aR1BSaM2SFUO7VffIM+AI=
X-Google-Smtp-Source: AA0mqf7NyXz8cJjqKtkPPuAxCOJU3fNpGyZ77WW8a/p1mp3JUi/+KT5RohrjCKrj+Gu8gaIurWVLcg==
X-Received: by 2002:a17:90b:f04:b0:218:8ec2:a4e2 with SMTP id br4-20020a17090b0f0400b002188ec2a4e2mr32505430pjb.174.1669368225573;
        Fri, 25 Nov 2022 01:23:45 -0800 (PST)
Received: from debian.me (subs03-180-214-233-19.three.co.id. [180.214.233.19])
        by smtp.gmail.com with ESMTPSA id r8-20020aa79628000000b00573eb4a9a66sm2652696pfg.2.2022.11.25.01.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 01:23:45 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 0395810428D; Fri, 25 Nov 2022 16:23:41 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: [PATCH] git-compat-util.h: Fix build without threads
Date:   Fri, 25 Nov 2022 16:23:39 +0700
Message-Id: <20221125092339.29433-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Fabrice Fontaine <fontaine.fabrice@gmail.com>

Git build with toolchains without threads support is broken (as reported
by Buildroot autobuilder [1]) since version 2.29.0, which traces back to
15b52a44e0 (compat-util: type-check parameters of no-op replacement
functions, 2020-08-06):

In file included from cache.h:4,
                 from blame.c:1:
git-compat-util.h:1238:20: error: static declaration of 'flockfile' follows non-static declaration
 static inline void flockfile(FILE *fh)
                    ^~~~~~~~~
In file included from git-compat-util.h:168,
                 from cache.h:4,
                 from blame.c:1:
/nvme/rc-buildroot-test/scripts/instance-0/output-1/host/arm-buildroot-linux-uclibcgnueabihf/sysroot/usr/include/stdio.h:806:13: note: previous declaration of 'flockfile' was here
 extern void flockfile (FILE *__stream) __THROW;
             ^~~~~~~~~
In file included from cache.h:4,
                 from blame.c:1:
git-compat-util.h:1242:20: error: static declaration of 'funlockfile' follows non-static declaration
 static inline void funlockfile(FILE *fh)
                    ^~~~~~~~~~~
In file included from git-compat-util.h:168,
                 from cache.h:4,
                 from blame.c:1:
/nvme/rc-buildroot-test/scripts/instance-0/output-1/host/arm-buildroot-linux-uclibcgnueabihf/sysroot/usr/include/stdio.h:813:13: note: previous declaration of 'funlockfile' was here
 extern void funlockfile (FILE *__stream) __THROW;
             ^~~~~~~~~~~

To avoid this build failure, check if flockfile is available before
defining flockfile, funlockfile and getc_unlocked.

Link: http://autobuild.buildroot.org/results/d41638d1ad8e78dd6f654367c905996b838ee649 [1]
Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
[Bagas: Rebase to current main, resolve minor conflicts, and slight rewording]
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Makefile          | 5 +++++
 configure.ac      | 6 ++++++
 git-compat-util.h | 3 ++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index b258fdbed8..2a8831a9ad 100644
--- a/Makefile
+++ b/Makefile
@@ -149,6 +149,8 @@ include shared.mak
 # Define NO_STRUCT_ITIMERVAL if you don't have struct itimerval
 # This also implies NO_SETITIMER
 #
+# Define NO_FLOCKFILE if you don't have flockfile()
+#
 # Define NO_FAST_WORKING_DIRECTORY if accessing objects in pack files is
 # generally faster on your platform than accessing the working directory.
 #
@@ -1826,6 +1828,9 @@ endif
 ifdef NO_SETITIMER
 	COMPAT_CFLAGS += -DNO_SETITIMER
 endif
+ifdef NO_FLOCKFILE
+	COMPAT_CFLAGS += -DNO_FLOCKFILE
+endif
 ifdef NO_PREAD
 	COMPAT_CFLAGS += -DNO_PREAD
 	COMPAT_OBJS += compat/pread.o
diff --git a/configure.ac b/configure.ac
index 38ff86678a..3a4c230529 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1094,6 +1094,12 @@ GIT_CHECK_FUNC(setitimer,
 [NO_SETITIMER=YesPlease])
 GIT_CONF_SUBST([NO_SETITIMER])
 #
+# Define NO_FLOCKFILE if you don't have flockfile.
+GIT_CHECK_FUNC(flockfile,
+[NO_FLOCKFILE=],
+[NO_FLOCKFILE=YesPlease])
+GIT_CONF_SUBST([NO_FLOCKFILE])
+#
 # Define NO_STRCASESTR if you don't have strcasestr.
 GIT_CHECK_FUNC(strcasestr,
 [NO_STRCASESTR=],
diff --git a/git-compat-util.h b/git-compat-util.h
index a76d0526f7..034f564614 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1470,7 +1470,8 @@ int open_nofollow(const char *path, int flags);
 # define SHELL_PATH "/bin/sh"
 #endif
 
-#ifndef _POSIX_THREAD_SAFE_FUNCTIONS
+
+#if !defined(_POSIX_THREAD_SAFE_FUNCTIONS) && defined(NO_FLOCKFILE)
 static inline void flockfile(FILE *fh UNUSED)
 {
 	; /* nothing */

base-commit: c000d916380bb59db69c78546928eadd076b9c7d
-- 
An old man doll... just what I always wanted! - Clara

