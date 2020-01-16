Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D694C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695012073A
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZOeZPo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387725AbgAPUWC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:22:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41761 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAPUWB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 15:22:01 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so20500517wrw.8
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 12:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TwbjQvu7IBEGTOpaw4N0EEswmTdli9u7uVELwz5WYU4=;
        b=BZOeZPo8Egigw+ODB+FcenpzuNOLfpSZBz6Zi3tTU6ipGcyZPIeING7pZAXqeeaN+8
         BHiNo4cL9Z0P2S3DN/KgqKDS+DYNSjwFtHTTvx1IokTSA9ZeHm2cOehuQa12dKK8KHlb
         2Yax+el/fVyOVcuNcVhEVaizQegwa7rH3qHnPNS7waXxA7jFxkirwzBn3xNH5/h4iElZ
         oRnVAD3cqKOYyQCCq4Hx1zwGGLfI/EKy4V1/X+GeM30BdlB+9YbwmKRXS8bViuL2xRAv
         008T3NHmVCWmFf2PTzr1nXMDnC6hv6iQ3bbfrNmSdFuK6QsAN2Hjk77WDIudzQ/bE9lk
         PTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TwbjQvu7IBEGTOpaw4N0EEswmTdli9u7uVELwz5WYU4=;
        b=fO15e0vargjRaOJIcvdfCoCnxAjUvTwL+MDWcG9SrOa9NVLzLu7iCBh+2k4d+mEw6l
         YDDDves39CxwYFEW142SSrUjzTWIiKqDCyQPa3CzBoKGZ4I/EC6ZZ4CmnoQ+Y1rEtJVv
         psTqmLQzsN+TXbSy/ZE7McdcSXPFo/Ie8a3fXE5dtgXdBGkw9JrEWFrk7C0OkfC64vSI
         IWGGDg6sayVw2ryP/PtrSXWeMFV8T+8rFeS4j7vdBK9RC6pltz8sryZVyK8oYkvCgHqp
         dXRfyX2wfyMhwvSXOjb+8Ou1hytsCnCwTgEAtai0TcWxoVPK9YWLhMFSQ1kz9cCv6wow
         D90Q==
X-Gm-Message-State: APjAAAWM1IfdVlk7cu/OMzkLyACp7WLPpwrVpofWJEbjV/zQcdehn296
        8S0G9g7OCBPvkObdNm4+TYYl/qhF
X-Google-Smtp-Source: APXvYqxt7wyIChqWzfeQM0O3dBWkcJ+DhMBvkp+8ZgftCS1yBwMVvc+mv09YRSSx8nGhleji9QjAwQ==
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr4921445wrr.32.1579206119149;
        Thu, 16 Jan 2020 12:21:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s19sm6115993wmj.33.2020.01.16.12.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 12:21:58 -0800 (PST)
Message-Id: <ea95186774762a5e1cf3cb882cff45fc904e3bf6.1579206117.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.692.v3.git.git.1579206117.gitgitgadget@gmail.com>
References: <pull.692.v2.git.git.1579098078501.gitgitgadget@gmail.com>
        <pull.692.v3.git.git.1579206117.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 20:21:54 +0000
Subject: [PATCH v3 2/4] dir: treat_leading_path() and
 read_directory_recursive(), round 2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>,
        Kevin.Willford@microsoft.com, Kyle Meyer <kyle@kyleam.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

I was going to title this "dir: more synchronizing of
treat_leading_path() and read_directory_recursive()", a nod to commit
777b42034764 ("dir: synchronize treat_leading_path() and
read_directory_recursive()", 2019-12-19), but the title was too long.

Anyway, first the backstory...

fill_directory() has always had a slightly error-prone interface: it
returns a subset of paths which *might* match the specified pathspec; it
was intended to prune away some paths which didn't match the specified
pathspec and keep at least all the ones that did match it.  Given this
interface, callers were responsible to post-process the results and
check whether each actually matched the pathspec.

builtin/clean.c did this.  It would first prune out duplicates (e.g. if
"dir" was returned as well as all files under "dir/", then it would
simplify this to just "dir"), and after pruning duplicates it would
compare the remaining paths to the specified pathspec(s).  This
post-processing itself could run into problems, though, as noted in
commit 404ebceda01c ("dir: also check directories for matching
pathspecs", 2019-09-17):

    For the case of git-clean and a set of pathspecs of "dir/file" and
    "more", this caused a problem because we'd end up with dir entries
    for both of
      "dir"
      "dir/file"
    Then correct_untracked_entries() would try to helpfully prune
    duplicates for us by removing "dir/file" since it's under "dir",
    leaving us with
      "dir"
    Since the original pathspec only had "dir/file", the only entry left
    doesn't match and leaves nothing to be removed.  (Note that if only
    one pathspec was specified, e.g. only "dir/file", then the
    common_prefix_len optimizations in fill_directory would cause us to
    bypass this problem, making it appear in simple tests that we could
    correctly remove manually specified pathspecs.)

That commit fixed the issue -- when multiple pathspecs were specified --
by making sure fill_directory() wouldn't return both "dir" and
"dir/file" outside the common_prefix_len optimization path.  This is
where it starts to get fun.

In commit b9670c1f5e6b ("dir: fix checks on common prefix directory",
2019-12-19), we noticed that the common_prefix_len wasn't doing
appropriate checks and letting all kinds of stuff through, resulting in
recursing into .git/ directories and other craziness.  So it started
locking down and doing checks on pathnames within that code path.  That
continued with commit 777b42034764 ("dir: synchronize
treat_leading_path() and read_directory_recursive()", 2019-12-19), which
noted the following:

    Our optimization to avoid calling into read_directory_recursive()
    when all pathspecs have a common leading directory mean that we need
    to match the logic that read_directory_recursive() would use if we
    had just called it from the root.  Since it does more than call
    treat_path() we need to copy that same logic.

...and then it more forcefully addressed the issue with this wonderfully
ironic statement:

    Needing to duplicate logic like this means it is guaranteed someone
    will eventually need to make further changes and forget to update
    both locations.  It is tempting to just nuke the leading_directory
    special casing to avoid such bugs and simplify the code, but
    unpack_trees' verify_clean_subdirectory() also calls
    read_directory() and does so with a non-empty leading path, so I'm
    hesitant to try to restructure further.  Add obnoxious warnings to
    treat_leading_path() and read_directory_recursive() to try to warn
    people of such problems.

You would think that with such a strongly worded description, that its
author would have actually ensured that the logic in
treat_leading_path() and read_directory_recursive() did actually match
and that *everything* that was needed had at least been copied over at
the time that this paragraph was written.  But you'd be wrong, I messed
it up by missing part of the logic.

Copy the missing bits to fix the new final test in t7300.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c            | 4 ++++
 t/t7300-clean.sh | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 7d255227b1..5d4c92d3aa 100644
--- a/dir.c
+++ b/dir.c
@@ -2383,6 +2383,10 @@ static int treat_leading_path(struct dir_struct *dir,
 		    (dir->flags & DIR_SHOW_IGNORED_TOO ||
 		     do_match_pathspec(istate, pathspec, sb.buf, sb.len,
 				       baselen, NULL, DO_MATCH_LEADING_PATHSPEC) == MATCHED_RECURSIVELY_LEADING_PATHSPEC)) {
+			if (!match_pathspec(istate, pathspec, sb.buf, sb.len,
+					    0 /* prefix */, NULL,
+					    0 /* do NOT special case dirs */))
+				state = path_none;
 			add_path_to_appropriate_result_list(dir, NULL, &cdir,
 							    istate,
 							    &sb, baselen,
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 782e125c89..cb5e34d94c 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -737,7 +737,7 @@ test_expect_success MINGW 'handle clean & core.longpaths = false nicely' '
 	test_i18ngrep "too long" .git/err
 '
 
-test_expect_failure 'clean untracked paths by pathspec' '
+test_expect_success 'clean untracked paths by pathspec' '
 	git init untracked &&
 	mkdir untracked/dir &&
 	echo >untracked/dir/file.txt &&
-- 
gitgitgadget

