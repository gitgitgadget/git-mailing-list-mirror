Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35BBC43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD58206A5
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEMPTIzp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfLRT35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:29:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45331 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbfLRT3z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 14:29:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so3510542wrj.12
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 11:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=90a8hTYzo1NrhO4e2Whvq4/bM4YvPykArFGr5qCbY7Y=;
        b=XEMPTIzp99H6fcfgott/HfDmE2EWwgY6KMx5T7mXbaFeTKzJ6HFgftfKYu1qyOiAsN
         qSinCCfZ7Lud9KLpAKeSQwUo2l496Gmubz1NoaHv4A2ujFZ/4g1crU2R7mxacArEmp+T
         xK8foR514qWUBjIB1xRhVQlqYqh0ZOLGO+Pfv8bB7PPdYF0ANp5M8I/KfKjAyrlSjF10
         n1712Jr4Zi9pyGae37oZNkUhyKAP9Ve0bcWEul+trfDmpHKORCg8ukGK0lPxrgAebU8k
         xsC7LhZBMFZb23dkSG4uRy1hewPTl+Aj5o/oaJFDBDAGByMA+9V/oLqAlKkiYlFGKxbq
         BN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=90a8hTYzo1NrhO4e2Whvq4/bM4YvPykArFGr5qCbY7Y=;
        b=r1mUy/qm5c27EM0F4263jsEhX1g+9/eB0NAFGVpvOPKH43mgdDkN65BMFROoZqe0R8
         mZNcXYK0v59hM+wGHyLn72Cs2NNPOjMTGoj39PO+GWgRWnaICPoF22gS1p5V8n54bhhD
         gwP096FDML3fmaNO1f5WYmMvrTTYa8awby4TPEb/TWD+KNV1s0L+OqjBwNQvSv9iB9ty
         Fn9sXbvD5i8LRTfYA6NwYKr5bel4p9qscAFwr4kXmxz0VZe6CFNe54HptDQtiGwHHuND
         mlxv/kCErBQ8pj5EAINyUhY4I/SUsNYPoOsGP7A8nHBEYfQV2JY+JTKpchgI6SN42YS3
         mw+A==
X-Gm-Message-State: APjAAAUT5hATxYnlKNVeVmWHtJn3ym5hsoQJw7Mbe1MM1NPOuS60q/kH
        4QxDwJ7wFfbuQOuWWWbFAvx7Ffm2
X-Google-Smtp-Source: APXvYqw5e+oleIbj5oNLhEg73m47gKtqVXmSUx6CkxkqPD8BHsHWVVTKKisabm4QBKtcLG1McUbw7w==
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr4836398wrw.25.1576697392968;
        Wed, 18 Dec 2019 11:29:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e16sm3544086wrs.73.2019.12.18.11.29.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 11:29:52 -0800 (PST)
Message-Id: <1f3978aa461929923eeb5037e69be6569f0ba331.1576697386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
References: <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
        <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Dec 2019 19:29:44 +0000
Subject: [PATCH v4 6/8] dir: fix checks on common prefix directory
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
 dir.c                                         | 57 +++++++++++++++----
 ...common-prefixes-and-directory-traversal.sh |  6 +-
 2 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/dir.c b/dir.c
index 645b44ea64..1de5d7ad33 100644
--- a/dir.c
+++ b/dir.c
@@ -2102,37 +2102,72 @@ static int treat_leading_path(struct dir_struct *dir,
 			      const struct pathspec *pathspec)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int baselen, rc = 0;
+	int prevlen, baselen;
 	const char *cp;
+	struct cached_dir cdir;
+	struct dirent *de;
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
+	de = xcalloc(1, sizeof(struct dirent)+len+1);
+	memset(&cdir, 0, sizeof(cdir));
+	cdir.de = de;
+#if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
+	de->d_type = DT_DIR;
+#endif
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
+		memcpy(de->d_name, path+prevlen, baselen-prevlen);
+		de->d_name[baselen-prevlen] = '\0';
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
+	free(de);
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

