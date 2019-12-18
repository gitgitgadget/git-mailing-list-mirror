Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35726C2D0CD
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0293020674
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+rtrp7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfLRT37 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:29:59 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39313 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfLRT34 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 14:29:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id 20so3069865wmj.4
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 11:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iz3flYHLH4WCewAEiphQi64vnf4FcOU8YCswG+AOn/Y=;
        b=Q+rtrp7K4zDBNAC2V3j4VuqI/Q44LiBBmjS14PftuKwhksfRXlpMmY+ghOi3sOv8MP
         OSHnwxdH8maUJWdo+FbG17CXyOToG9Na85kPi93Ec4H9pJZC5e2eAPX2GfNnPujG76gv
         WhNwOKZptrOzetw+orE+lRf9o8oCXJ/nqzxbEMUnJC9Zo3nxIH9BXWMAMl3+v3qnNeHN
         VkNkY9pk2maQ4m6yFHO4qozkuHgjZFKvAN/dC9hqvJcyY7LsJ+Qba0vZ6Y4FOu8Y8DxF
         1wAOFYFCA+evSihwKoh0I8GmegPpLierc0d7f9BBvFNDhDQfGeOuduvLdbtGgbwojFHN
         bcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iz3flYHLH4WCewAEiphQi64vnf4FcOU8YCswG+AOn/Y=;
        b=hHfN9tpIrJRznEF2lddN1Tc0wFwF1py7ZGKnOz2+VOpvTsevaDNuZpB63iQfNEtQM3
         8xNDsHqKIfqnOYllirU9nU3IV7Epd8Nd41vXoUk2IHcBUYnT5yJ4Yk0oMmd/b3/4Ozt3
         dmYJ8nCpl5cNcyYdLtBlLPV8JeVV9ck/IqZmeTF17zr2Rg5ulGmxzptEJLcz9AifCt9d
         xi3fThvh3UvJ5Si8qF4wvFPMSLsffhYEGSc7LtuPKBQ6i9iNqUT4PKxVFAuerxIB49A4
         2HjkvlW9llYyptN5zyHKgtW9FG891zDw0u04RW0hUSwCeCp8HhNhkeotZA/vk3+9OCBr
         1xTw==
X-Gm-Message-State: APjAAAXoYIJVvi88c3SXSI2PmVGbdKFUdR+RxKAQjA4zrgKkoLAsTw2i
        GZgsAnPBsBwgOzqfBsJ7vKA5QW/q
X-Google-Smtp-Source: APXvYqx0FMmKft+lRUQXI17suerzzjDrM2d6pxQJ9vhPVz+6gPpOnynzUPJeTdaF5i3t+ZqbGmseWQ==
X-Received: by 2002:a1c:ed0e:: with SMTP id l14mr4969391wmh.74.1576697393894;
        Wed, 18 Dec 2019 11:29:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17sm3596250wrt.89.2019.12.18.11.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 11:29:53 -0800 (PST)
Message-Id: <542c6e57927b968d58e4309e3a09f85914af0408.1576697387.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
References: <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
        <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Dec 2019 19:29:45 +0000
Subject: [PATCH v4 7/8] dir: synchronize treat_leading_path() and
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
index 1de5d7ad33..f500fd9279 100644
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
@@ -2156,6 +2174,18 @@ static int treat_leading_path(struct dir_struct *dir,
 		de->d_name[baselen-prevlen] = '\0';
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

