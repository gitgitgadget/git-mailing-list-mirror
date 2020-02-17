Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACF4C34022
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 16:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB7420801
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 16:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aS5VO614"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgBQQPK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:15:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44506 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbgBQQPI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 11:15:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id m16so20395121wrx.11
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 08:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Oqg/fG0vPNpfJBAOow+4bxUoQhWuPL9IpHgxTrtI39k=;
        b=aS5VO614m74uQhT9G6LGLpV+50W7+1Hn6tsSKsdtpuo6ioC1eWpyTorULxALBkrm6u
         OwGb+DkQgDNmlRpvcCaDzhGuv7xVvKlGMzl1VYYZ849UWz1O5z/34Ls8kOxEsNehL/uN
         C3Xn/ZbmXHHbF7y+J3bhVvNBFg3s/NvkO+FZRKmzUC556bOIa33d97Zz+lHnM7e3/dm/
         7uPOu3ruciEgvWg02y3wmk41gCjs3jTqiKoNcgOVSL9v9HUv5idrwpPyHAaHD6t+PyUA
         yYYwbDsuNpYXs3DCN1Lk4tTN+v429N/ELlg1coCs5qioOqfNuQdvCquw2hNH2dV4xinq
         Xp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Oqg/fG0vPNpfJBAOow+4bxUoQhWuPL9IpHgxTrtI39k=;
        b=HyDMASoY2gyAVbFIbFnYuQ/SucnaAUO8B62yNhv6pwEapI4ZwoAaL7TIybITm7+fWn
         WJFtwvJL6QNWvjs/EQZoXZwrwYxp37E4a6XDdev0VLJnN8EqOhIFXmup/rihm3ddYynH
         TPocsnkCotM70VR07uwMRmBiA6TQ23FeWQ1a9rOcMVsR6mPXB8ljM47F0NkbzfjVdqAd
         dsCF5V+FWSfyRd3K3AvpbF673wrTMn0qUSqVvroHtKwkIT+OeNYO+YkQ/0wjvsLJBhUR
         oV3ehmnBJ3odc1BJ5fejsXNPTP5MVIqKwPGbA+sbUlpqQ67NnM461LOc/Y9Qq/WTTd8C
         SkPQ==
X-Gm-Message-State: APjAAAV3UyyNPUVK+C2EOmnWEKhTU3ViuV2dT9hpUFFXta1i7tNmWRLZ
        hujmkboOLi/dgtJZffND3UfH7BLg
X-Google-Smtp-Source: APXvYqxlmh40KYGSAiDnww5adBhap+C3I/lQzL985Kr1/z+j6suGSKPrT7NYR7RHanbCAEu63Kd+8g==
X-Received: by 2002:a5d:40d1:: with SMTP id b17mr22034627wrq.93.1581956107113;
        Mon, 17 Feb 2020 08:15:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l6sm1596625wrn.26.2020.02.17.08.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 08:15:06 -0800 (PST)
Message-Id: <pull.711.git.git.1581956106255.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Feb 2020 16:15:06 +0000
Subject: [PATCH] check-ignore: fix handling with negated patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

check-ignore was meant to check ignore rules the same way git status and
other commands would, and to report whether a path is excluded.  It
failed to do this (and generated a few bug reports), however, because it
did not account for negated patterns.

Commands other than check-ignore verify exclusion rules via calling

   ... -> treat_one_path() -> is_excluded() -> last_matching_pattern()

while check-ignore has a call path of the form:

   ... -> check_ignore()                    -> last_matching_pattern()

The fact that the latter does not include the call to is_excluded()
means that it is susceptible to to messing up negated patterns (since
that is the only significant thing is_excluded() adds over
last_matching_pattern()).  Unfortunately, we can't make it just call
is_excluded(), because is_excluded doesn't return the pattern in
question and part of check-ignore's functionality is not just checking
whether one of the patterns matches but returning which one does.

Further, check_ignore() is supposed to handle a --verbose mode, which
was ill-defined for the case of negated patterns: check-ignore was
documented to print just the excluded paths, whereas the --verbose mode
was there to document which patterns were matched by paths.  A path
which matches a negated exclude pattern is NOT excluded and thus
shouldn't be printed by the former logic, while it certainly does match
one of the explicit patterns and thus should be printed by the latter
logic.  Adjust the definition of --verbose to state that it is about
matching patterns INSTEAD of about showing which paths are excluded in
order to resolve this discrepancy.

Finally, also adjust a few tests in t0008 that were caught up by this
discrepancy in how negated paths were handled.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    check-ignore: fix handling with negated patterns
    
    Make check-ignore do what it claims to do: report whether the paths
    specified to it are ignored.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-711%2Fnewren%2Ffix-check-ignore-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-711/newren/fix-check-ignore-v1
Pull-Request: https://github.com/git/git/pull/711

 Documentation/git-check-ignore.txt | 12 ++++++---
 builtin/check-ignore.c             |  3 +++
 t/t0008-ignores.sh                 | 39 ++++++++++++++++++------------
 3 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index 8b2d49c79e1..85ef46e2eff 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -30,9 +30,15 @@ OPTIONS
 	valid with a single pathname.
 
 -v, --verbose::
-	Also output details about the matching pattern (if any)
-	for each given pathname. For precedence rules within and
-	between exclude sources, see linkgit:gitignore[5].
+	Instead of printing the paths that are excluded, for each path
+	that matches an exclude pattern print the exclude pattern
+	together with the path.  (Matching an exclude pattern usually
+	means the path is excluded, but if the pattern begins with '!'
+	then it is a negated pattern and matching it means the path is
+	NOT excluded.)
++
+For precedence rules within and between exclude sources, see
+linkgit:gitignore[5].
 
 --stdin::
 	Read pathnames from the standard input, one per line,
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 5a4f92395f3..ea5d0ae3a6a 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -108,6 +108,9 @@ static int check_ignore(struct dir_struct *dir,
 			int dtype = DT_UNKNOWN;
 			pattern = last_matching_pattern(dir, &the_index,
 							full_path, &dtype);
+			if (!verbose && pattern &&
+			    pattern->flags & PATTERN_FLAG_NEGATIVE)
+				pattern = NULL;
 		}
 		if (!quiet && (pattern || show_non_matching))
 			output_pattern(pathspec.items[i].original, pattern);
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 1744cee5e99..370a389e5c5 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -424,9 +424,24 @@ test_expect_success 'local ignore inside a sub-directory with --verbose' '
 	)
 '
 
-test_expect_success_multi 'nested include' \
-	'a/b/.gitignore:8:!on*	a/b/one' '
-	test_check_ignore "a/b/one"
+test_expect_success 'nested include of negated pattern' '
+	expect "" &&
+	test_check_ignore "a/b/one" 1
+'
+
+test_expect_success 'nested include of negated pattern with -q' '
+	expect "" &&
+	test_check_ignore "-q a/b/one" 1
+'
+
+test_expect_success 'nested include of negated pattern with -v' '
+	expect "a/b/.gitignore:8:!on*	a/b/one" &&
+	test_check_ignore "-v a/b/one" 0
+'
+
+test_expect_success 'nested include of negated pattern with -v -n' '
+	expect "a/b/.gitignore:8:!on*	a/b/one" &&
+	test_check_ignore "-v -n a/b/one" 0
 '
 
 ############################################################################
@@ -460,7 +475,6 @@ test_expect_success 'cd to ignored sub-directory' '
 	expect_from_stdin <<-\EOF &&
 		foo
 		twoooo
-		../one
 		seven
 		../../one
 	EOF
@@ -543,7 +557,6 @@ test_expect_success 'global ignore' '
 		globalthree
 		a/globalthree
 		a/per-repo
-		globaltwo
 	EOF
 	test_check_ignore "globalone per-repo globalthree a/globalthree a/per-repo not-ignored globaltwo"
 '
@@ -586,17 +599,7 @@ EOF
 cat <<-\EOF >expected-default
 	one
 	a/one
-	a/b/on
-	a/b/one
-	a/b/one one
-	a/b/one two
-	"a/b/one\"three"
-	a/b/two
 	a/b/twooo
-	globaltwo
-	a/globaltwo
-	a/b/globaltwo
-	b/globaltwo
 EOF
 cat <<-EOF >expected-verbose
 	.gitignore:1:one	one
@@ -696,8 +699,12 @@ cat <<-EOF >expected-all
 	$global_excludes:2:!globaltwo	../b/globaltwo
 	::	c/not-ignored
 EOF
+cat <<-EOF >expected-default
+../one
+one
+b/twooo
+EOF
 grep -v '^::	' expected-all >expected-verbose
-sed -e 's/.*	//' expected-verbose >expected-default
 
 broken_c_unquote stdin >stdin0
 

base-commit: bfdd66e72fffd18235757bedbf355fd4176d6019
-- 
gitgitgadget
