Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95033C001DF
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 10:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjHCK2g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 06:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjHCK2X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 06:28:23 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0951BFD
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 03:28:22 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31765aee31bso631203f8f.1
        for <git@vger.kernel.org>; Thu, 03 Aug 2023 03:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691058501; x=1691663301;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8L6CLXAcrjTUtmEErrIJ6QOMMmLmOcIbzawBae09ak=;
        b=SpbuvcKwYqwUHCnS4PYfpKFNdpmZ88s77u79Rq7Qv0FUFwUeWko0SrFfG4O4QUBaIc
         VlzwOKuWb2easyddyKMT7JbeffjeWwho4fQhMzcP8KpkIGCUdD5q70JEZZQ0Mdz3XsN4
         lotKgue+H8vLe+gaAD7MwVUkv3ektaL9P5Eoxr/G64FUjAhcjVgPYh16YThDRAjpMxNU
         MeiVH64WMRLI5xzsaTQavKp5quCU1G2CsaM7EsfSsigEhzNKtRLFjtmr4QFfoZ9qkqLm
         Is5mxDp8Il9h8Lw6fJyKF29VrYIv3Wwuqk2sqephW4NRr+HfEb9COcpSJ1xVTEPToJMc
         SjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691058501; x=1691663301;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8L6CLXAcrjTUtmEErrIJ6QOMMmLmOcIbzawBae09ak=;
        b=CiwuZRwD1+BmoeBXVQ9yROnEoDqylmr4EXxdyIfdBGHr/moyJ8jr6ii6buerZqXk5D
         acp3chhRzdZgD8XTIoAcMz9OQPN+I9VlvTNX9mVmxU9YMObmjd6F8YzZqvPmnvgpmXmN
         j/y4dendGWGVliRkWZw0YCh2BBC95MdgpPw/+JA1RSlO1F8uzBCNQkOdrF9PfHUqPEZl
         cTpa7TgilvNy9QXiJUKWUQYAqryWSPc7Ej2c4yRE8F6zjQ3brS8sY0W1X4iCKl1gEDus
         Zc1mgRmjLgsLqw1YMTuDCJOsQQIEOXscdKGOBav5co3EI/FrUzmYABPlVPVyF0GI5Nsh
         FK8g==
X-Gm-Message-State: ABy/qLZhNz3BbWcatQJarK75LxxfAMyq1NsVQT4d9X/oK1NeWz9wKb2m
        upeKVH6sYdiZDsBUHN64CyGaN83SXEM=
X-Google-Smtp-Source: APBJJlGTwXKf2KDmcV/hRrTjhelnFeAuAxXhzwxVaQ+1hJzXuuFQcD8H1Ygoyx4T1puXx7Tprp2O3A==
X-Received: by 2002:adf:e848:0:b0:30a:f030:8637 with SMTP id d8-20020adfe848000000b0030af0308637mr6829793wrn.22.1691058500622;
        Thu, 03 Aug 2023 03:28:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z8-20020adfec88000000b0031773a8e5c4sm21371307wrn.37.2023.08.03.03.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 03:28:20 -0700 (PDT)
Message-ID: <6ed968e128897ad75fb09a69395ee3571bb40677.1691058498.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1560.git.1691058498.gitgitgadget@gmail.com>
References: <pull.1560.git.1691058498.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Matthias=20A=C3=9Fhauer?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 03 Aug 2023 10:28:16 +0000
Subject: [PATCH 1/3] compat: make path_lookup() available outside mingw.c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Louis Strous <Louis.Strous@intellimagic.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

Rename it to mingw_path_lookup() to avoid leading future contributors
to believe this would be portable.

This is in preparation for a patch to teach locate_in_PATH() and
exists_in_PATH() in run-command.c to work on windows.

Signed-off-by: Matthias Aßhauer <mha1993@live.de>
---
 compat/mingw.c | 20 ++++++++------------
 compat/mingw.h |  6 ++++++
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index d06cdc6254f..5d3368b1705 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1316,11 +1316,7 @@ static char *lookup_prog(const char *dir, int dirlen, const char *cmd,
 	return NULL;
 }
 
-/*
- * Determines the absolute path of cmd using the split path in path.
- * If cmd contains a slash or backslash, no lookup is performed.
- */
-static char *path_lookup(const char *cmd, int exe_only)
+char *mingw_path_lookup(const char *cmd, int exe_only)
 {
 	const char *path;
 	char *prog = NULL;
@@ -1515,7 +1511,7 @@ static int is_msys2_sh(const char *cmd)
 		if (ret >= 0)
 			return ret;
 
-		p = path_lookup(cmd, 0);
+		p = mingw_path_lookup(cmd, 0);
 		if (!p)
 			ret = 0;
 		else {
@@ -1533,7 +1529,7 @@ static int is_msys2_sh(const char *cmd)
 		static char *sh;
 
 		if (!sh)
-			sh = path_lookup("sh", 0);
+			sh = mingw_path_lookup("sh", 0);
 
 		return !fspathcmp(cmd, sh);
 	}
@@ -1646,7 +1642,7 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
 
 	strace_env = getenv("GIT_STRACE_COMMANDS");
 	if (strace_env) {
-		char *p = path_lookup("strace.exe", 1);
+		char *p = mingw_path_lookup("strace.exe", 1);
 		if (!p)
 			return error("strace not found!");
 		if (xutftowcs_path(wcmd, p) < 0) {
@@ -1801,7 +1797,7 @@ pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **deltaenv,
 		     int fhin, int fhout, int fherr)
 {
 	pid_t pid;
-	char *prog = path_lookup(cmd, 0);
+	char *prog = mingw_path_lookup(cmd, 0);
 
 	if (!prog) {
 		errno = ENOENT;
@@ -1812,7 +1808,7 @@ pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **deltaenv,
 
 		if (interpr) {
 			const char *argv0 = argv[0];
-			char *iprog = path_lookup(interpr, 1);
+			char *iprog = mingw_path_lookup(interpr, 1);
 			argv[0] = prog;
 			if (!iprog) {
 				errno = ENOENT;
@@ -1841,7 +1837,7 @@ static int try_shell_exec(const char *cmd, char *const *argv)
 
 	if (!interpr)
 		return 0;
-	prog = path_lookup(interpr, 1);
+	prog = mingw_path_lookup(interpr, 1);
 	if (prog) {
 		int exec_id;
 		int argc = 0;
@@ -1890,7 +1886,7 @@ int mingw_execv(const char *cmd, char *const *argv)
 
 int mingw_execvp(const char *cmd, char *const *argv)
 {
-	char *prog = path_lookup(cmd, 0);
+	char *prog = mingw_path_lookup(cmd, 0);
 
 	if (prog) {
 		mingw_execv(prog, argv);
diff --git a/compat/mingw.h b/compat/mingw.h
index 209cf7cebad..af1ff4be320 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -626,3 +626,9 @@ void open_in_gdb(void);
  * Used by Pthread API implementation for Windows
  */
 int err_win_to_posix(DWORD winerr);
+
+/*
+ * Determines the absolute path of cmd using the split path in path.
+ * If cmd contains a slash or backslash, no lookup is performed.
+ */
+char *mingw_path_lookup(const char *cmd, int exe_only);
-- 
gitgitgadget

