Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593FDC43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9DE20836
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnHvGgJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfLJUAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:00:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52205 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfLJUAh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 15:00:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id d73so1335465wmd.1
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 12:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QlQlvIUb7pVmcwx0APSrUZaVTcp4QONqDKymM3daESw=;
        b=fnHvGgJhrjd1XijPU0fcwqcRZH2iW1HaYvdPHWthY5Asuu61mcGZTAX3FEyrwtKxRj
         T7BGKZcUTudS6p6hJCc+YDCP4o6JVg13TvoY3twlsaV7Z+V8WRIkc5BDDA5Y93RCDinG
         oui4L3/7J0S10oaN6MWGGyQ82+Ij8OdVtHIF2zuwSkpJ2CldO8xzLkNgnJR7HKHflr5M
         efBD0UpViYVsSUSqnff/Kino0yCA4Mn+soHWqiTxN8jWJL2JxOsnEXtzOoHq6+NTqBVN
         AC/bw6AseBdHu0ayzFAb5QZ5h9eCWdoVzRNoC3l7mJTXsP1gS2wT1RS8Jv+r8lAQUqnr
         as3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QlQlvIUb7pVmcwx0APSrUZaVTcp4QONqDKymM3daESw=;
        b=UEJGqpw44VGA2kh9FxkrRHvFf/4dCQw9BaOkQiAV/5E1oqQJvPQFwnaNzHsnxTGll2
         +3RT/n3m/NEjB4Ar8zy3LSVoi5jGz2bEzodvFCMoSM336SGQ5v93MYVfa5g96IijcVGT
         hwXtQ3gOibOaXolvmb+NYKKFZ097N848UKyjdBqeFZaXEvGGjaL9FQY5wvzXVllAafDa
         zbniWUSQlShQtdU+WaciYvvMezri/g/ChJ27/cpZcPb+FSulMn3HAPU1KgurfQTmZzp6
         ZU58xsUUotyhWhfXXYQChffcTjoUI8p1cXHTiCtgmbcmJkM5V8ViNzt/0Z9GMGFcN0+t
         ZHzw==
X-Gm-Message-State: APjAAAVaP/WBzxuveYzsAlQf7eRo1cRq9uUXAV1lNjBetQkjAGWyWQWh
        IyKhmaMCO9/i9sOZQ56etF8ANdBb
X-Google-Smtp-Source: APXvYqzfNlxPb7+f80OVx6bUpMMnuBOHYvqT+unWFmj/3ciSoGpxA9LIJLcLtRq3GacUxKL8yb6GbQ==
X-Received: by 2002:a05:600c:214f:: with SMTP id v15mr7215977wml.110.1576008035207;
        Tue, 10 Dec 2019 12:00:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s82sm4323098wms.28.2019.12.10.12.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 12:00:34 -0800 (PST)
Message-Id: <df7f08886a73f24095376c5d1a5454794f329dfa.1576008027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com>
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
        <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Dec 2019 20:00:26 +0000
Subject: [PATCH v2 7/8] dir: synchronize treat_leading_path() and
 read_directory_recursive()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     blees@dcon.de, gitster@pobox.com, kyle@kyleam.com,
        sxlijin@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Our optimization to avoid calling into read_directory_recursive() when
all pathspecs have a common leading directory mean that we need to match
the logic that read_directory_recursive() would use if we had just
called it from the root.  Since it does more than call treat_path() we
need to copy that same logic.

Alternatively, we could try to change treat_path to return path_recurse
for an untracked directory under the given special circumstances that
this logic checks for, but a simple switch results in many test failures
such as 'git clean -d' not wiping out untracked but empty directories.
To work around that, we'd need the caller of treat_path to check for
path_recurse and sometimes special case it into path_untracked.  In
other words, we'd still have extra logic in both places.

Needing to duplicate logic like this means it is guaranteed someone will
eventually need to make further changes and forget to update both
locations.  It is tempting to just nuke the leading_directory special
casing to avoid such bugs and simplify the code, but unpack_trees'
verify_clean_subdirectory() also calls read_directory() and does so with
a non-empty leading path, so I'm hesitant to try to restructure further.
Add obnoxious warnings to treat_leading_path() and
read_directory_recursive() to try to warn people of such problems.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c                                         | 30 +++++++++++++++++++
 ...common-prefixes-and-directory-traversal.sh |  2 +-
 t/t7061-wtstatus-ignore.sh                    |  2 +-
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 9c71a9ac21..bb6e481909 100644
--- a/dir.c
+++ b/dir.c
@@ -1990,6 +1990,15 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 	struct untracked_cache_dir *untracked, int check_only,
 	int stop_at_first_file, const struct pathspec *pathspec)
 {
+	/*
+	 * WARNING WARNING WARNING:
+	 *
+	 * Any updates to the traversal logic here may need corresponding
+	 * updates in treat_leading_path().  See the commit message for the
+	 * commit adding this warning as well as the commit preceding it
+	 * for details.
+	 */
+
 	struct cached_dir cdir;
 	enum path_treatment state, subdir_state, dir_state = path_none;
 	struct strbuf path = STRBUF_INIT;
@@ -2101,6 +2110,15 @@ static int treat_leading_path(struct dir_struct *dir,
 			      const char *path, int len,
 			      const struct pathspec *pathspec)
 {
+	/*
+	 * WARNING WARNING WARNING:
+	 *
+	 * Any updates to the traversal logic here may need corresponding
+	 * updates in treat_leading_path().  See the commit message for the
+	 * commit adding this warning as well as the commit preceding it
+	 * for details.
+	 */
+
 	struct strbuf sb = STRBUF_INIT;
 	int prevlen, baselen;
 	const char *cp;
@@ -2154,6 +2172,18 @@ static int treat_leading_path(struct dir_struct *dir,
 		de.d_name[baselen-prevlen] = '\0';
 		state = treat_path(dir, NULL, &cdir, istate, &sb, prevlen,
 				    pathspec);
+		if (state == path_untracked &&
+		    get_dtype(cdir.de, istate, sb.buf, sb.len) == DT_DIR &&
+		    (dir->flags & DIR_SHOW_IGNORED_TOO ||
+		     do_match_pathspec(istate, pathspec, sb.buf, sb.len,
+				       baselen, NULL, DO_MATCH_LEADING_PATHSPEC) == MATCHED_RECURSIVELY_LEADING_PATHSPEC)) {
+			add_path_to_appropriate_result_list(dir, NULL, &cdir,
+							    istate,
+							    &sb, baselen,
+							    pathspec, state);
+			state = path_recurse;
+		}
+
 		if (state != path_recurse)
 			break; /* do not recurse into it */
 		if (len <= baselen)
diff --git a/t/t3011-common-prefixes-and-directory-traversal.sh b/t/t3011-common-prefixes-and-directory-traversal.sh
index 098fddc75b..3da5b2b6e7 100755
--- a/t/t3011-common-prefixes-and-directory-traversal.sh
+++ b/t/t3011-common-prefixes-and-directory-traversal.sh
@@ -195,7 +195,7 @@ test_expect_success 'git ls-files -o consistent between one or two dirs' '
 
 # ls-files doesn't have a way to request showing both untracked and ignored
 # files at the same time, so use `git status --ignored`
-test_expect_failure 'git status --ignored shows same files under dir with or without pathspec' '
+test_expect_success 'git status --ignored shows same files under dir with or without pathspec' '
 	cat <<-EOF >expect &&
 	?? an_untracked_dir/
 	!! an_untracked_dir/ignored
diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index 84366050da..e4cf5484f9 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -47,7 +47,7 @@ cat >expected <<\EOF
 !! untracked/ignored
 EOF
 
-test_expect_failure 'status of untracked directory with --ignored works with or without prefix' '
+test_expect_success 'status of untracked directory with --ignored works with or without prefix' '
 	git status --porcelain --ignored >tmp &&
 	grep untracked/ tmp >actual &&
 	rm tmp &&
-- 
gitgitgadget

