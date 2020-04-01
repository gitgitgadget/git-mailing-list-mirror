Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D28C10F26
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4AB2077D
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cApTgQOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731751AbgDAESB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 00:18:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38346 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731735AbgDAER7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 00:17:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id c7so2855004wrx.5
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 21:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2IzG7HdVnwM0/c9l1e6G4khfou1KztyP0nlPwTuj7Ac=;
        b=cApTgQOrCOaNWnxUo59AzQ1iYRDn62AtjueoesezGBs3HxwMKUMuxA12BBPX3yK0J9
         PI5cWQi3royU6nMjvDJ4tMoCveNZtLgn6r9uU9cno+JUZfqL4MyAqG8JnsOz3QCPsR3Q
         z4N1z80FYWXbjwXklg4yOeUHxmiQQ2iwhWnK0F1Vmk6hhF0Cul8nr7AbqDGIZUzJfLhc
         TQ6KxP1lwdtpbnL3j6zUZN0ZGoItZD1bxUSyi3iL628wamdRPGnoCZQK/ghL3+s8T3XB
         04BqLSXa+KBf9Z9BNok+1c9347YXP45k7I9O4oriktePa/3pLooUfW/iG5JcKmtUuzoQ
         UhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2IzG7HdVnwM0/c9l1e6G4khfou1KztyP0nlPwTuj7Ac=;
        b=LLMNbJAJygskm0Pnd1oTi7lZr87/9UsTk9CQxqxSxf220Zz4vMXaXZcO1MVJULfTfb
         5LhDDa+jcfi3QHKTpsTyZejqhgIP20WwC0XY+qxyOXC1t+tmeLvGLqdrDSoQMb3RJU+s
         P0Gs5Z3R8AkBaUGNCYmuNzCsEpIG3POUvseGp4n2uqGRdTn+RRehqWGhkhp3THDnGtvP
         NXXxoSBd/Qwzb0PkyBv7fFQxBOClZAPt7masZKUVW60SotvpHxYhBSFtnG/cv9uwN9Pt
         4NT4QXKro6v0nVXD0PqEkgTDjcL8buDVaB++32trDjgjmeEYk3s+cLFPSVW8iOBq7VAE
         JS2g==
X-Gm-Message-State: ANhLgQ0stlIrmCXac3wt5l85j5WvSCiMgKFu+xHlezb44rEhQ0w3TlFT
        wQdyGVf5ggsZlIQm/g0pWW8NUe4Z
X-Google-Smtp-Source: ADFU+vuPAIEjZHJWWF1bBKTTdf328iYI/RnnrISCo5GS4DKB83nWdcAtCzQXSKfi5lg0+LtyJDCFVw==
X-Received: by 2002:adf:fa51:: with SMTP id y17mr24743467wrr.280.1585714676282;
        Tue, 31 Mar 2020 21:17:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 189sm966045wme.31.2020.03.31.21.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 21:17:55 -0700 (PDT)
Message-Id: <cee74871e43444ee4b85499f52dd58ed0cf07f0f.1585714667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com>
References: <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
        <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 04:17:44 +0000
Subject: [PATCH v5 10/12] dir: replace double pathspec matching with single in
 treat_directory()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

treat_directory() had a call to both do_match_pathspec() and
match_pathspec().  These calls have migrated through the code somewhat
since their introduction, but we don't actually need both.  Replace the
two calls with one, and while at it, move the check earlier in order to
reduce the need for callers of fill_directory() to do post-filtering of
results.

The next patch will address post-filtering more forcefully and provide
more relevant history and context.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/dir.c b/dir.c
index 8be31df58c2..a67930dcff6 100644
--- a/dir.c
+++ b/dir.c
@@ -1665,6 +1665,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	 *          you CAN'T DO BOTH.
 	 */
 	enum path_treatment state;
+	int matches_how = 0;
 	int nested_repo = 0, check_only, stop_early;
 	int old_ignored_nr, old_untracked_nr;
 	/* The "len-1" is to strip the final '/' */
@@ -1677,6 +1678,22 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	if (status != index_nonexistent)
 		BUG("Unhandled value for directory_exists_in_index: %d\n", status);
 
+	/*
+	 * We don't want to descend into paths that don't match the necessary
+	 * patterns.  Clearly, if we don't have a pathspec, then we can't check
+	 * for matching patterns.  Also, if (excluded) then we know we matched
+	 * the exclusion patterns so as an optimization we can skip checking
+	 * for matching patterns.
+	 */
+	if (pathspec && !excluded) {
+		matches_how = do_match_pathspec(istate, pathspec, dirname, len,
+						0 /* prefix */, NULL /* seen */,
+						DO_MATCH_LEADING_PATHSPEC);
+		if (!matches_how)
+			return path_none;
+	}
+
+
 	if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
 		!(dir->flags & DIR_NO_GITLINKS)) {
 		struct strbuf sb = STRBUF_INIT;
@@ -1724,13 +1741,8 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	 * 'subdir/some/deep/path/file' or 'subdir/widget-*.c'), then we
 	 * need to recurse.
 	 */
-	if (pathspec) {
-		int ret = do_match_pathspec(istate, pathspec, dirname, len,
-					    0 /* prefix */, NULL /* seen */,
-					    DO_MATCH_LEADING_PATHSPEC);
-		if (ret == MATCHED_RECURSIVELY_LEADING_PATHSPEC)
-			return path_recurse;
-	}
+	if (matches_how == MATCHED_RECURSIVELY_LEADING_PATHSPEC)
+		return path_recurse;
 
 	/*
 	 * Other than the path_recurse case immediately above, we only need
@@ -1850,18 +1862,6 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	if (state == path_none && !(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
 		state = excluded ? path_excluded : path_untracked;
 
-	/*
-	 * We can recurse into untracked directories that don't match any
-	 * of the given pathspecs when some file underneath the directory
-	 * might match one of the pathspecs.  If so, we should make sure
-	 * to note that the directory itself did not match.
-	 */
-	if (pathspec &&
-	    !match_pathspec(istate, pathspec, dirname, len,
-			    0 /* prefix */, NULL,
-			    0 /* do NOT special case dirs */))
-		state = path_none;
-
 	return state;
 }
 
-- 
gitgitgadget

