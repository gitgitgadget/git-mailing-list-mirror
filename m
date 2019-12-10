Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3472C00454
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0ED12077B
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6xXv7Vq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfLJUAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:00:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38298 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfLJUAg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 15:00:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so21535211wrh.5
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 12:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RSA39FD61/54jfe87pt4sZEjUV+TsBmB9NCWY4MD0PM=;
        b=X6xXv7VqiarpNhWIo1V4ihiR+dKuiskw/H1vyISJygXlkYU/W91LfCMoMSX1drpV0c
         UOSHSFfH6QTRXdrotYyNLAL2eotFk36LAG3hr7hpDeKLFV1XgS3fOXUdOjXc+YfZ6vLt
         ipSq6DIcmMm3nJcAulKocjqITJLD817RiM/YCJZDk4nSMWW+ixLO5b/KZnYjuqOogAOq
         gpP9+UA91BkHPUPVMS7VhNqufgxuuTYsaGjZhcNGqvFQf/sREuzdJjNV4Jc0cZfjrjpN
         vhHCPaCh76LPWSuRmkq2+xABwmYVbVUBPuntavGtYeSn53Xw5kyZh1W1wWnzhclnQQSF
         cKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RSA39FD61/54jfe87pt4sZEjUV+TsBmB9NCWY4MD0PM=;
        b=W4VWR3BbI5WV2qRdDMHbATztMTba7I2BN7P73YvERRlN0UMIq8pC1P+rNu9irbZoR3
         AYQ30CbDytmRW4qfgg0kUlZdJaWIWumAvxwqYFJtYu8cK22EDGQK8DWTdD8Ls6004pAb
         psDdchXC28l8YFJ/rYpdMWrHcYMkjvhFLy959oJ84Bc5bg7/uoSMS+p4TLyz7mSgeMmk
         ZcLpEO4jfKOTCGKs/4tWkyFBoE3KIHVayT/ramS8sEEXyQTcK3PSa4mjyuQBlDBbfJ2v
         e4zwSyDFWOfyE4nKTZtxExMf8PRUCWD6DDpAfwx7uG5oSsCyDmfds+Do75MUrWf0pRNp
         usgg==
X-Gm-Message-State: APjAAAUgfs+SyoR/AsUh4cvISCO65w5WoVzNfe2fe2EEKz78vYbkfoA7
        w6q9+5JBFXK0Zt8moYpB8vDvoR80
X-Google-Smtp-Source: APXvYqytg45YlFRVICP9sjVCBxweCCwOY9KYRkvYsiUNZbZsTG5X9dmBxg9RD++e/CkL34Tq0gm02w==
X-Received: by 2002:a5d:4f90:: with SMTP id d16mr5031046wru.395.1576008034152;
        Tue, 10 Dec 2019 12:00:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i5sm4373703wrv.34.2019.12.10.12.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 12:00:33 -0800 (PST)
Message-Id: <9839aca00a10b16d96c47db631ac025281ffc864.1576008027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com>
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
        <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Dec 2019 20:00:25 +0000
Subject: [PATCH v2 6/8] dir: fix checks on common prefix directory
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

Many years ago, the directory traversing logic had an optimization that
would always recurse into any directory that was a common prefix of all
the pathspecs without walking the leading directories to get down to
the desired directory.  Thus,
   git ls-files -o .git/                        # case A
would notice that .git/ was a common prefix of all pathspecs (since
it is the only pathspec listed), and then traverse into it and start
showing unknown files under that directory.  Unfortunately, .git/ is not
a directory we should be traversing into, which made this optimization
problematic.  This also affected cases like
   git ls-files -o --exclude-standard t/        # case B
where t/ was in the .gitignore file and thus isn't interesting and
shouldn't be recursed into.  It also affected cases like
   git ls-files -o --directory untracked_dir/   # case C
where untracked_dir/ is indeed untracked and thus interesting, but the
--directory flag means we only want to show the directory itself, not
recurse into it and start listing untracked files below it.

The case B class of bugs were noted and fixed in commits 16e2cfa90993
("read_directory(): further split treat_path()", 2010-01-08) and
48ffef966c76 ("ls-files: fix overeager pathspec optimization",
2010-01-08), with the idea being that we first wanted to check whether
the common prefix was interesting.  The former patch noted that
treat_path() couldn't be used when checking the common prefix because
treat_path() requires a dir_entry() and we haven't read any directories
at the point we are checking the common prefix.  So, that patch split
treat_one_path() out of treat_path().  The latter patch then created a
new treat_leading_path() which duplicated by hand the bits of
treat_path() that couldn't be broken out and then called
treat_one_path() for the remainder.  There were three problems with this
approach:

  * The duplicated logic in treat_leading_path() accidentally missed the
    check for special paths (such as is_dot_or_dotdot and matching
    ".git"), causing case A types of bugs to continue to be an issue.
  * The treat_leading_path() logic assumed we should traverse into
    anything where path_treatment was not path_none, i.e. it perpetuated
    class C types of bugs.
  * It meant we had split logic that needed to kept in sync, running the
    risk that people introduced new inconsistencies (such as in commit
    be8a84c52669, which we reverted earlier in this series, or in commit
    df5bcdf83ae which we'll fix in a subsequent commit)

Fix most these problems by making treat_leading_path() not only loop
over each leading path component, but calling treat_path() directly on
each.  To do so, we have to create a synthetic dir_entry, but that only
takes a few lines.  Then, pay attention to the path_treatment result we
get from treat_path() and don't treat path_excluded, path_untracked, and
path_recurse all the same as path_recurse.

This leaves one remaining problem, the new inconsistency from commit
df5bcdf83ae.  That will be addressed in a subsequent commit.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c                                         | 54 +++++++++++++++----
 ...common-prefixes-and-directory-traversal.sh |  6 +--
 2 files changed, 46 insertions(+), 14 deletions(-)

diff --git a/dir.c b/dir.c
index 645b44ea64..9c71a9ac21 100644
--- a/dir.c
+++ b/dir.c
@@ -2102,37 +2102,69 @@ static int treat_leading_path(struct dir_struct *dir,
 			      const struct pathspec *pathspec)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int baselen, rc = 0;
+	int prevlen, baselen;
 	const char *cp;
+	struct cached_dir cdir;
+	struct dirent de;
+	enum path_treatment state = path_none;
+
+	/*
+	 * For each directory component of path, we are going to check whether
+	 * that path is relevant given the pathspec.  For example, if path is
+	 *    foo/bar/baz/
+	 * then we will ask treat_path() whether we should go into foo, then
+	 * whether we should go into bar, then whether baz is relevant.
+	 * Checking each is important because e.g. if path is
+	 *    .git/info/
+	 * then we need to check .git to know we shouldn't traverse it.
+	 * If the return from treat_path() is:
+	 *    * path_none, for any path, we return false.
+	 *    * path_recurse, for all path components, we return true
+	 *    * <anything else> for some intermediate component, we make sure
+	 *        to add that path to the relevant list but return false
+	 *        signifying that we shouldn't recurse into it.
+	 */
 
 	while (len && path[len - 1] == '/')
 		len--;
 	if (!len)
 		return 1;
+
+	memset(&cdir, 0, sizeof(cdir));
+	memset(&de, 0, sizeof(de));
+	cdir.de = &de;
+	de.d_type = DT_DIR;
 	baselen = 0;
+	prevlen = 0;
 	while (1) {
-		cp = path + baselen + !!baselen;
+		prevlen = baselen + !!baselen;
+		cp = path + prevlen;
 		cp = memchr(cp, '/', path + len - cp);
 		if (!cp)
 			baselen = len;
 		else
 			baselen = cp - path;
-		strbuf_setlen(&sb, 0);
+		strbuf_reset(&sb);
 		strbuf_add(&sb, path, baselen);
 		if (!is_directory(sb.buf))
 			break;
-		if (simplify_away(sb.buf, sb.len, pathspec))
-			break;
-		if (treat_one_path(dir, NULL, istate, &sb, baselen, pathspec,
-				   DT_DIR, NULL) == path_none)
+		strbuf_reset(&sb);
+		strbuf_add(&sb, path, prevlen);
+		memcpy(de.d_name, path+prevlen, baselen-prevlen);
+		de.d_name[baselen-prevlen] = '\0';
+		state = treat_path(dir, NULL, &cdir, istate, &sb, prevlen,
+				    pathspec);
+		if (state != path_recurse)
 			break; /* do not recurse into it */
-		if (len <= baselen) {
-			rc = 1;
+		if (len <= baselen)
 			break; /* finished checking */
-		}
 	}
+	add_path_to_appropriate_result_list(dir, NULL, &cdir, istate,
+					    &sb, baselen, pathspec,
+					    state);
+
 	strbuf_release(&sb);
-	return rc;
+	return state == path_recurse;
 }
 
 static const char *get_ident_string(void)
diff --git a/t/t3011-common-prefixes-and-directory-traversal.sh b/t/t3011-common-prefixes-and-directory-traversal.sh
index d6e161ddd8..098fddc75b 100755
--- a/t/t3011-common-prefixes-and-directory-traversal.sh
+++ b/t/t3011-common-prefixes-and-directory-traversal.sh
@@ -74,7 +74,7 @@ test_expect_success 'git ls-files -o --directory untracked_dir does not recurse'
 	test_cmp expect actual
 '
 
-test_expect_failure 'git ls-files -o --directory untracked_dir/ does not recurse' '
+test_expect_success 'git ls-files -o --directory untracked_dir/ does not recurse' '
 	echo untracked_dir/ >expect &&
 	git ls-files -o --directory untracked_dir/ >actual &&
 	test_cmp expect actual
@@ -86,7 +86,7 @@ test_expect_success 'git ls-files -o untracked_repo does not recurse' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'git ls-files -o untracked_repo/ does not recurse' '
+test_expect_success 'git ls-files -o untracked_repo/ does not recurse' '
 	echo untracked_repo/ >expect &&
 	git ls-files -o untracked_repo/ >actual &&
 	test_cmp expect actual
@@ -133,7 +133,7 @@ test_expect_success 'git ls-files -o .git shows nothing' '
 	test_must_be_empty actual
 '
 
-test_expect_failure 'git ls-files -o .git/ shows nothing' '
+test_expect_success 'git ls-files -o .git/ shows nothing' '
 	git ls-files -o .git/ >actual &&
 	test_must_be_empty actual
 '
-- 
gitgitgadget

