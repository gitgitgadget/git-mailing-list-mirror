Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29E0C43331
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 13:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E7A20663
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 13:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZG8Y7vO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgCYNpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:45:14 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33559 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgCYNpO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 09:45:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id z65so2433485ede.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 06:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I1q73szehWh05yyuig3r+XLhfVW6Kqna5AbYqrHnrUo=;
        b=OZG8Y7vOKTfEZW/uUcxL5SwBrIzNp2OF7212hL0TqZPZYb4o761vmAQftTlf4MeEUh
         ZGky5GeODhgaW14Xk2v6OoSYgO9HDtcvo0uWbPquRbIWQCZBQZOsT5ootY8x5zo42XMH
         4psP0r3xlBxqiy1dgw1FYUe9o0WtAv0XkEUeC6vH1+y29CgP/aulAaJTbduEsGNKuyTJ
         dSF2bgGaRKoSBElBmL7Ku4S7Uj7yzl+cNLIxayFHt2M4HUaJqMTUZQoBtmtG63K/9Fq1
         3y2ZMJan3V9bVIcEUsm4mxgCJOpv9XSPFW59xfOoBoCP63T6czq7Vz1/2Dtx8LcLpjWH
         euKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I1q73szehWh05yyuig3r+XLhfVW6Kqna5AbYqrHnrUo=;
        b=BRrXNq0w/eEeBg7+yS+jMON0O4K+vMI+BNEBJ0Ck5f/4x4auDN+A3nC2M6CKa+O5ZF
         PsOy0p7CLE1LDctNTNoo3XJlc1eNnglSACBMnp95HBS4rf9rE+EL2On+OHu/gI1ZLoVV
         8DGjvCcJCccTtygx50C++mkspHlXCZ48OSOV5MblRhfoPq1s3kBMlY5k9Cc+/xZOdexp
         Vnzw7bQUx5YNz5Fe6PGliNxULiBRGlzxVi1jVFDlQ6I/z1zSsSfuh/+h5OwtGGmw+60Q
         IioJI5sLNKnplrK6jV3wu1+qN2P643LiLs3MrQQcgDVlo6ISPrQ9xZlfeOLS7qGpe0Fa
         kpWA==
X-Gm-Message-State: ANhLgQ2NJkiGt1Cdi/ChHIx/nl5ISXm4SZru/M5j/8P0/PeyNV+oqF16
        Np49GIGxtX/HNcCEWjIgt4szKbGx
X-Google-Smtp-Source: ADFU+vu3lsTe3uqfdagphS6vCTw2cgwFmGIOBGt7jVRMLkI/mRrgiev29eaoGgxiPO+ce3QyqIGccw==
X-Received: by 2002:a17:906:e297:: with SMTP id gg23mr3037909ejb.294.1585143911700;
        Wed, 25 Mar 2020 06:45:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id mu6sm375308ejb.25.2020.03.25.06.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 06:45:11 -0700 (PDT)
Message-Id: <pull.587.v2.git.1585143910604.gitgitgadget@gmail.com>
In-Reply-To: <pull.587.git.1584997990694.gitgitgadget@gmail.com>
References: <pull.587.git.1584997990694.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?Andr=C3=A1s?= Kucsma via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 25 Mar 2020 13:45:10 +0000
Subject: [PATCH v2] Fix dir sep handling of GIT_ASKPASS on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Andr=C3=A1s?= Kucsma <r0maikx02b@gmail.com>,
        Andras Kucsma <r0maikx02b@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andras Kucsma <r0maikx02b@gmail.com>

On Windows with git installed through cygwin, GIT_ASKPASS failed to run
for relative and absolute paths containing only backslashes as directory
separators.

The reason was that git assumed that if there are no forward slashes in
the executable path, it has to search for the executable on the PATH.

The fix is to look for OS specific directory separators, not just
forward slashes.

Signed-off-by: Andras Kucsma <r0maikx02b@gmail.com>
---
    Fix dir sep handling of GIT_ASKPASS on Windows
    
    On Windows with git installed through cygwin, GIT_ASKPASS failed to run
    for relative and absolute paths containing only backslashes as directory
    separators.
    
    The reason was that git assumed that if there are no forward slashes in
    the executable path, it has to search for the executable on the PATH.
    
    The fix is to look for OS specific directory separators, not just
    forward slashes.
    
    Signed-off-by: Andras Kucsma r0maikx02b@gmail.com [r0maikx02b@gmail.com]
    
    Changes since v1:
    
     * Avoid scanning the whole path for a directory separator even if one
       is found earlier as suggested by Junio C Hamano.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-587%2Fr0mai%2Ffix-prepare_cmd-windows-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-587/r0mai/fix-prepare_cmd-windows-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/587

Range-diff vs v1:

 1:  8fbfbec0d38 ! 1:  947931ac568 Fix dir sep handling of GIT_ASKPASS on Windows
     @@ -14,6 +14,47 @@
      
          Signed-off-by: Andras Kucsma <r0maikx02b@gmail.com>
      
     + diff --git a/compat/win32/path-utils.h b/compat/win32/path-utils.h
     + --- a/compat/win32/path-utils.h
     + +++ b/compat/win32/path-utils.h
     +@@
     + 	return ret;
     + }
     + #define find_last_dir_sep win32_find_last_dir_sep
     ++static inline int win32_has_dir_sep(const char *path)
     ++{
     ++	/*
     ++	 * See how long the non-separator part of the given path is, and
     ++	 * if and only if it covers the whole path (i.e. path[len] is NULL),
     ++	 * there is no separator in the path---otherwise there is a separator.
     ++	 */
     ++	size_t len = strcspn(path, "/\\");
     ++	return !!path[len];
     ++}
     ++#define has_dir_sep(path) win32_has_dir_sep(path)
     + int win32_offset_1st_component(const char *path);
     + #define offset_1st_component win32_offset_1st_component
     + 
     +
     + diff --git a/git-compat-util.h b/git-compat-util.h
     + --- a/git-compat-util.h
     + +++ b/git-compat-util.h
     +@@
     + #define find_last_dir_sep git_find_last_dir_sep
     + #endif
     + 
     ++#ifndef has_dir_sep
     ++static inline int git_has_dir_sep(const char *path)
     ++{
     ++	return !!strchr(path, '/');
     ++}
     ++#define has_dir_sep(path) git_has_dir_sep(path)
     ++#endif
     ++
     + #ifndef query_user_email
     + #define query_user_email() NULL
     + #endif
     +
       diff --git a/run-command.c b/run-command.c
       --- a/run-command.c
       +++ b/run-command.c
     @@ -31,7 +72,7 @@
      +	 * the command directly.
       	 */
      -	if (!strchr(out->argv[1], '/')) {
     -+	if (find_last_dir_sep(out->argv[1]) == NULL) {
     ++	if (!has_dir_sep(out->argv[1])) {
       		char *program = locate_in_PATH(out->argv[1]);
       		if (program) {
       			free((char *)out->argv[1]);


 compat/win32/path-utils.h | 11 +++++++++++
 git-compat-util.h         |  8 ++++++++
 run-command.c             | 10 +++++-----
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/compat/win32/path-utils.h b/compat/win32/path-utils.h
index f2e70872cd2..18eff7899e9 100644
--- a/compat/win32/path-utils.h
+++ b/compat/win32/path-utils.h
@@ -20,6 +20,17 @@ static inline char *win32_find_last_dir_sep(const char *path)
 	return ret;
 }
 #define find_last_dir_sep win32_find_last_dir_sep
+static inline int win32_has_dir_sep(const char *path)
+{
+	/*
+	 * See how long the non-separator part of the given path is, and
+	 * if and only if it covers the whole path (i.e. path[len] is NULL),
+	 * there is no separator in the path---otherwise there is a separator.
+	 */
+	size_t len = strcspn(path, "/\\");
+	return !!path[len];
+}
+#define has_dir_sep(path) win32_has_dir_sep(path)
 int win32_offset_1st_component(const char *path);
 #define offset_1st_component win32_offset_1st_component
 
diff --git a/git-compat-util.h b/git-compat-util.h
index aed0b5d4f90..8ba576e81e3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -389,6 +389,14 @@ static inline char *git_find_last_dir_sep(const char *path)
 #define find_last_dir_sep git_find_last_dir_sep
 #endif
 
+#ifndef has_dir_sep
+static inline int git_has_dir_sep(const char *path)
+{
+	return !!strchr(path, '/');
+}
+#define has_dir_sep(path) git_has_dir_sep(path)
+#endif
+
 #ifndef query_user_email
 #define query_user_email() NULL
 #endif
diff --git a/run-command.c b/run-command.c
index f5e1149f9b3..0f41af3b550 100644
--- a/run-command.c
+++ b/run-command.c
@@ -421,12 +421,12 @@ static int prepare_cmd(struct argv_array *out, const struct child_process *cmd)
 	}
 
 	/*
-	 * If there are no '/' characters in the command then perform a path
-	 * lookup and use the resolved path as the command to exec.  If there
-	 * are '/' characters, we have exec attempt to invoke the command
-	 * directly.
+	 * If there are no dir separator characters in the command then perform
+	 * a path lookup and use the resolved path as the command to exec. If
+	 * there are dir separator characters, we have exec attempt to invoke
+	 * the command directly.
 	 */
-	if (!strchr(out->argv[1], '/')) {
+	if (!has_dir_sep(out->argv[1])) {
 		char *program = locate_in_PATH(out->argv[1]);
 		if (program) {
 			free((char *)out->argv[1]);

base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
-- 
gitgitgadget
