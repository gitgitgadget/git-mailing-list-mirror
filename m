Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727C1C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3525B2074D
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEU2f1H7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgC0Ags (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:36:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37399 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgC0Ags (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 20:36:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so9478483wrm.4
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 17:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Z46YMUAB+5psh01yU9gDdzg4en/xuO0zBIlz2lksvFo=;
        b=JEU2f1H7G6wAGUVlkSOMUE+PzzOxSoSpBHFpLYcyRkBNaSMAa4Hv12Ie+LFSlg1/gC
         sillhqkBgLJjRxWVIgpjqru5q07x78AcyvdI4cr8lz3jZP4V0K6RNbOu23ZPol2FiQ66
         h1HUUxJp/fE+lFRKEFbJ+3b9Fi5MeuizoYlrFTvLyT3TnlZa8ZQVr1wBal2wqtNV5H/J
         hEVZgskWAJ5iwS4myPXyrlBJMZXZ+Hvfm4vozAnwGkjF+R1pc4mX8zgqT1O/DEHEm8mL
         hT9zqbf86HunewAGzRAL+Ca6VwxOWZxS8WpOlu+ETxveIUr45JCLatszuxKIrHstyZQc
         sYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Z46YMUAB+5psh01yU9gDdzg4en/xuO0zBIlz2lksvFo=;
        b=TkFP2mV0I4HpJ1xpSO7ehZnZzq6kCWQUQBZKGNZ9WFw5nNYe9wcMCAYxNiJ8MM+QK4
         42vVGDwrzRYaRk4d2KQpZNFNeDsvVaD7HB0mQfVN19QDGLQh5+KPYQbY+DpKy8RwlRBd
         LW9LOR+OavQTFcx3HDftvzCTEvpz140itxbwLiOXIOaFT38luoFBLiDL+UKKYbvucvrI
         ra6w/BTJ8c0w+zlXdBVw8xgCh1mPAJsigfzt72nCru7+NC/JAhZZ8W3XqbQE1Ew7S/Nf
         p0XXeSJr/ANrXqqs9J0H5sW5AGLyIjsMyrwqgxx0Z3z5IZHInuM5rr+a0Pa99UJ5I85q
         p8Eg==
X-Gm-Message-State: ANhLgQ11bh+WOyAnxwHptDFN3HVDarKUDopVLa6Ew+DJcgh6UjloA5fA
        kYuM6XmbOaWVQDz7eUCamowY7anm
X-Google-Smtp-Source: ADFU+vuLw1lOLenSYkhEquxuPHVbS94H9Y2WYGWHYcewC+hRjhJ7vm3QuLOToDffHd7LjQhEwHmUTw==
X-Received: by 2002:adf:a2d8:: with SMTP id t24mr11882007wra.366.1585269404959;
        Thu, 26 Mar 2020 17:36:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8sm5888029wrb.41.2020.03.26.17.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 17:36:44 -0700 (PDT)
Message-Id: <pull.587.v3.git.1585269403947.gitgitgadget@gmail.com>
In-Reply-To: <pull.587.v2.git.1585143910604.gitgitgadget@gmail.com>
References: <pull.587.v2.git.1585143910604.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?Andr=C3=A1s?= Kucsma via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 27 Mar 2020 00:36:43 +0000
Subject: [PATCH v3] run-command: trigger PATH lookup properly on Cygwin
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

On Cygwin, the codepath for POSIX-like systems is taken in
run-command.c::start_command(). The prepare_cmd() helper
function is called to decide if the command needs to be looked
up in the PATH. The logic there is to do the PATH-lookup if
and only if it does not have any slash '/' in it. If this test
passes we end up attempting to run the command by appending the
string after each colon-separated component of PATH.

The Cygwin environment supports both Windows and POSIX style
paths, so both forwardslahes '/' and back slashes '\' can be
used as directory separators for any external program the user
supplies.

Examples for path strings which are being incorrectly searched
for in the PATH instead of being executed as is:

- "C:\Program Files\some-program.exe"
- "a\b\c.exe"

To handle these, the PATH lookup detection logic in prepare_cmd()
is taught to know about this Cygwin quirk, by introducing
has_dir_sep(path) helper function to abstract away the difference
between true POSIX and Cygwin systems.

Signed-off-by: Andras Kucsma <r0maikx02b@gmail.com>
---
    run-command: trigger PATH lookup properly on Cygwin
    
    On Cygwin, the codepath for POSIX-like systems is taken in
    run-command.c::start_command(). The prepare_cmd() helper function is
    called to decide if the command needs to be looked up in the PATH. The
    logic there is to do the PATH-lookup if and only if it does not have any
    slash '/' in it. If this test passes we end up attempting to run the
    command by appending the string after each colon-separated component of
    PATH.
    
    The Cygwin environment supports both Windows and POSIX style paths, so
    both forwardslahes '/' and back slashes '' can be used as directory
    separators for any external program the user supplies.
    
    Examples for path strings which are being incorrectly searched for in
    the PATH instead of being executed as is:
    
     * "C:\Program Files\some-program.exe"
     * "a\b\c.exe"
    
    To handle these, the PATH lookup detection logic in prepare_cmd() is
    taught to know about this Cygwin quirk, by introducing has_dir_sep(path)
    helper function to abstract away the difference between true POSIX and
    Cygwin systems.
    
    Signed-off-by: Andras Kucsma r0maikx02b@gmail.com [r0maikx02b@gmail.com]
    
    Changes since v1:
    
     * Avoid scanning the whole path for a directory separator even if one
       is found earlier as suggested by Junio C Hamano. Changes since v2:
     * Rephrased the commit message based on Junio's suggestion.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-587%2Fr0mai%2Ffix-prepare_cmd-windows-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-587/r0mai/fix-prepare_cmd-windows-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/587

Range-diff vs v2:

 1:  947931ac568 ! 1:  fd3cbd51635 Fix dir sep handling of GIT_ASKPASS on Windows
     @@ -1,16 +1,30 @@
      Author: Andras Kucsma <r0maikx02b@gmail.com>
      
     -    Fix dir sep handling of GIT_ASKPASS on Windows
     +    run-command: trigger PATH lookup properly on Cygwin
      
     -    On Windows with git installed through cygwin, GIT_ASKPASS failed to run
     -    for relative and absolute paths containing only backslashes as directory
     -    separators.
     +    On Cygwin, the codepath for POSIX-like systems is taken in
     +    run-command.c::start_command(). The prepare_cmd() helper
     +    function is called to decide if the command needs to be looked
     +    up in the PATH. The logic there is to do the PATH-lookup if
     +    and only if it does not have any slash '/' in it. If this test
     +    passes we end up attempting to run the command by appending the
     +    string after each colon-separated component of PATH.
      
     -    The reason was that git assumed that if there are no forward slashes in
     -    the executable path, it has to search for the executable on the PATH.
     +    The Cygwin environment supports both Windows and POSIX style
     +    paths, so both forwardslahes '/' and back slashes '\' can be
     +    used as directory separators for any external program the user
     +    supplies.
      
     -    The fix is to look for OS specific directory separators, not just
     -    forward slashes.
     +    Examples for path strings which are being incorrectly searched
     +    for in the PATH instead of being executed as is:
     +
     +    - "C:\Program Files\some-program.exe"
     +    - "a\b\c.exe"
     +
     +    To handle these, the PATH lookup detection logic in prepare_cmd()
     +    is taught to know about this Cygwin quirk, by introducing
     +    has_dir_sep(path) helper function to abstract away the difference
     +    between true POSIX and Cygwin systems.
      
          Signed-off-by: Andras Kucsma <r0maikx02b@gmail.com>
      


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
