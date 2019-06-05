Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36FA21F462
	for <e@80x24.org>; Wed,  5 Jun 2019 21:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfFEVWF (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 17:22:05 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43216 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFEVWE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 17:22:04 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so119696ios.10
        for <git@vger.kernel.org>; Wed, 05 Jun 2019 14:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Y7/sGBv2uXuMyL1VHqNKk99BvJU4gDiyMqwuf1bGNA=;
        b=YkvxJNIPZmdyTab6HphGjcplvuK27LT2F1HXZJERnhJVsx4wv6vdBoVPD5LvRoasub
         HgUwYT1d/G+znNeOZ4n0Cnuvgzb/+BMs/WmAVDFzC0FSFUAE54zjV9YOhi7NkfieVjmD
         lsXmDdT7bwWrkrycDwAxE82sEL+k4aqS1BWhB2Rkp6/MZqzbt0r06+MfHUSUYF1flbUo
         evohieuk/WBaAAyoucr+rzhCSzUn1phHtES2cFV4/9FZJJ65++d5RE/giGq+Vv6gkWUE
         y0K6j3R6B3JtFuTel598uHB5NzsjN0gOZ8w7RsCSZPoxMKKGMxPbGcTSsfkTcHW8eVL3
         Pb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Y7/sGBv2uXuMyL1VHqNKk99BvJU4gDiyMqwuf1bGNA=;
        b=Lt0Z6DHTPQiydvJsGVm+aQg7Ug6js9M1qI63jJb4fxQyZYrTIXgArtJBo5Q8IMINrJ
         Wsci+Br3YzBUdcQCJOv6L8YfgPZOCAw2RE2TcANWsi5hS0S61MW5ded04fwYrNuhb6XU
         2hqqrj7d2IefbcSelw0GsmI1gFMkpGORV9VOIrLtYL5XXWObjFm45PT/GnRwvPokUfnb
         X9MRA5/R6ABIaAGjZgOyrhorA1l7p8aNkP46zFqnvHdARUmDAur0gKOWfJRynjDI7kdt
         EC5q+GVptJOwtj2PAoFiOIFFDczd29Hm/EcfWq3fUXeSJw3GsGo/SoOm9ZZUzLZTFS2F
         WntQ==
X-Gm-Message-State: APjAAAXhf+kjL/8Y0QRMpbZg3zLAKa/5B5Df209QsETwg+au7ZwouuH/
        i/vRgiKQIFWBLjEYbPG4lCsN8wGd
X-Google-Smtp-Source: APXvYqw3w287lR9c20j/ZCvxE7IxDDIpxhoPNEa7/ojxQhczv639bVcZOiIW0essfSv5hYcg1E6Mgw==
X-Received: by 2002:a5d:88c6:: with SMTP id i6mr12345990iol.107.1559769723359;
        Wed, 05 Jun 2019 14:22:03 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id p23sm7175202ios.65.2019.06.05.14.22.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 14:22:02 -0700 (PDT)
Date:   Wed, 5 Jun 2019 17:21:59 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v3] config: learn the "onbranch:" includeIf condition
Message-ID: <49e22269d5a66d1975fca71a300e9099f46e1c40.1559769658.git.liu.denton@gmail.com>
References: <3573995264441c50ea9529b3ee926d1ed3ec4ac8.1559330905.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3573995264441c50ea9529b3ee926d1ed3ec4ac8.1559330905.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, if a user wishes to have individual settings per branch, they
are required to manually keep track of the settings in their head and
manually set the options on the command-line or change the config at
each branch.

Teach config the "onbranch:" includeIf condition so that it can
conditionally include configuration files if the branch that is checked
out in the current worktree matches the pattern given.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

Thanks for the review, Johannes and Duy. I've incorporated both of your
suggestions into this round.

Notes:
    Changes since v2:
    
    * Run test-cases outside foo/ since the subdirectory is not necessary
    * Implicitly add `**` when there is a trailing `/`
    
    Changes since v1:
    
    * Allow onbranch: to specify a pattern instead of just a static
      comparison

Interdiff against v2:
  diff --git a/Documentation/config.txt b/Documentation/config.txt
  index 93aa4323c6..e3f5bc3396 100644
  --- a/Documentation/config.txt
  +++ b/Documentation/config.txt
  @@ -145,11 +145,18 @@ refer to linkgit:gitignore[5] for details. For convenience:
   	case-insensitively (e.g. on case-insensitive file sytems)
   
   `onbranch`::
  -	The data that follows the keyword `onbranch:` is taken to be a pattern
  -	with standard globbing wildcards and two additional ones, `**/` and
  -	`/**`, that can match multiple path components. If we are in a worktree
  -	where the name of the branch that is currently checked out matches the
  -	pattern, the include condition is met.
  +	The data that follows the keyword `onbranch:` is taken to be a
  +	pattern with standard globbing wildcards and two additional
  +	ones, `**/` and `/**`, that can match multiple path components.
  +	If we are in a worktree where the name of the branch that is
  +	currently checked out matches the pattern, the include condition
  +	is met.
  ++
  +If the pattern ends with `/`, `**` will be automatically added. For
  +example, the pattern `foo/` becomes `foo/**`. In other words, it matches
  +all branches that begin with `foo/`. This is useful if your branches are
  +organized hierarchically and you would like to apply a configuration to
  +all the branches in that hierarchy.
   
   A few more notes on matching via `gitdir` and `gitdir/i`:
   
  diff --git a/config.c b/config.c
  index 48bb435739..ad4166e243 100644
  --- a/config.c
  +++ b/config.c
  @@ -171,6 +171,12 @@ static int handle_path_include(const char *path, struct config_include_data *inc
   	return ret;
   }
   
  +static void add_trailing_starstar_for_dir(struct strbuf *pat)
  +{
  +	if (pat->len && is_dir_sep(pat->buf[pat->len - 1]))
  +		strbuf_addstr(pat, "**");
  +}
  +
   static int prepare_include_condition_pattern(struct strbuf *pat)
   {
   	struct strbuf path = STRBUF_INIT;
  @@ -200,8 +206,7 @@ static int prepare_include_condition_pattern(struct strbuf *pat)
   	} else if (!is_absolute_path(pat->buf))
   		strbuf_insert(pat, 0, "**/", 3);
   
  -	if (pat->len && is_dir_sep(pat->buf[pat->len - 1]))
  -		strbuf_addstr(pat, "**");
  +	add_trailing_starstar_for_dir(pat);
   
   	strbuf_release(&path);
   	return prefix;
  @@ -278,6 +283,7 @@ static int include_by_branch(const char *cond, size_t cond_len)
   		return 0;
   
   	strbuf_add(&pattern, cond, cond_len);
  +	add_trailing_starstar_for_dir(&pattern);
   	ret = !wildmatch(pattern.buf, shortname, WM_PATHNAME);
   	strbuf_release(&pattern);
   	return ret;
  diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
  index 05c7def1f2..9571e366f8 100755
  --- a/t/t1305-config-include.sh
  +++ b/t/t1305-config-include.sh
  @@ -310,36 +310,42 @@ test_expect_success SYMLINKS 'conditional include, gitdir matching symlink, icas
   '
   
   test_expect_success 'conditional include, onbranch' '
  -	(
  -		cd bar &&
  -		echo "[includeIf \"onbranch:foo-branch\"]path=bar9" >>.git/config &&
  -		echo "[test]nine=9" >.git/bar9 &&
  -		git checkout -b master &&
  -		test_must_fail git config test.nine &&
  -		git checkout -b foo-branch &&
  -		echo 9 >expect &&
  -		git config test.nine >actual &&
  -		test_cmp expect actual
  -	)
  +	echo "[includeIf \"onbranch:foo-branch\"]path=bar9" >>.git/config &&
  +	echo "[test]nine=9" >.git/bar9 &&
  +	git checkout -b master &&
  +	test_must_fail git config test.nine &&
  +	git checkout -b foo-branch &&
  +	echo 9 >expect &&
  +	git config test.nine >actual &&
  +	test_cmp expect actual
   '
   
   test_expect_success 'conditional include, onbranch, wildcard' '
  -	(
  -		cd bar &&
  -		echo "[includeIf \"onbranch:?oo-*/**\"]path=bar10" >>.git/config &&
  -		echo "[test]ten=10" >.git/bar10 &&
  -		git checkout -b not-foo-branch/a &&
  -		test_must_fail git config test.ten &&
  -
  -		echo 10 >expect &&
  -		git checkout -b foo-branch/a/b/c &&
  -		git config test.ten >actual &&
  -		test_cmp expect actual &&
  -
  -		git checkout -b moo-bar/a &&
  -		git config test.ten >actual &&
  -		test_cmp expect actual
  -	)
  +	echo "[includeIf \"onbranch:?oo-*/**\"]path=bar10" >>.git/config &&
  +	echo "[test]ten=10" >.git/bar10 &&
  +	git checkout -b not-foo-branch/a &&
  +	test_must_fail git config test.ten &&
  +
  +	echo 10 >expect &&
  +	git checkout -b foo-branch/a/b/c &&
  +	git config test.ten >actual &&
  +	test_cmp expect actual &&
  +
  +	git checkout -b moo-bar/a &&
  +	git config test.ten >actual &&
  +	test_cmp expect actual
  +'
  +
  +test_expect_success 'conditional include, onbranch, implicit /** for /' '
  +	echo "[includeIf \"onbranch:foo-dir/\"]path=bar11" >>.git/config &&
  +	echo "[test]eleven=11" >.git/bar11 &&
  +	git checkout -b not-foo-dir/a &&
  +	test_must_fail git config test.eleven &&
  +
  +	echo 11 >expect &&
  +	git checkout -b foo-dir/a/b/c &&
  +	git config test.eleven >actual &&
  +	test_cmp expect actual
   '
   
   test_expect_success 'include cycles are detected' '

 Documentation/config.txt  | 19 +++++++++++++++++++
 config.c                  | 31 +++++++++++++++++++++++++++++--
 t/t1305-config-include.sh | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7e2a6f61f5..e3f5bc3396 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -144,6 +144,20 @@ refer to linkgit:gitignore[5] for details. For convenience:
 	This is the same as `gitdir` except that matching is done
 	case-insensitively (e.g. on case-insensitive file sytems)
 
+`onbranch`::
+	The data that follows the keyword `onbranch:` is taken to be a
+	pattern with standard globbing wildcards and two additional
+	ones, `**/` and `/**`, that can match multiple path components.
+	If we are in a worktree where the name of the branch that is
+	currently checked out matches the pattern, the include condition
+	is met.
++
+If the pattern ends with `/`, `**` will be automatically added. For
+example, the pattern `foo/` becomes `foo/**`. In other words, it matches
+all branches that begin with `foo/`. This is useful if your branches are
+organized hierarchically and you would like to apply a configuration to
+all the branches in that hierarchy.
+
 A few more notes on matching via `gitdir` and `gitdir/i`:
 
  * Symlinks in `$GIT_DIR` are not resolved before matching.
@@ -206,6 +220,11 @@ Example
 	[includeIf "gitdir:/path/to/group/"]
 		path = foo.inc
 
+	; include only if we are in a worktree where foo-branch is
+	; currently checked out
+	[includeIf "onbranch:foo-branch"]
+		path = foo.inc
+
 Values
 ~~~~~~
 
diff --git a/config.c b/config.c
index 296a6d9cc4..ad4166e243 100644
--- a/config.c
+++ b/config.c
@@ -19,6 +19,7 @@
 #include "utf8.h"
 #include "dir.h"
 #include "color.h"
+#include "refs.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -170,6 +171,12 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 	return ret;
 }
 
+static void add_trailing_starstar_for_dir(struct strbuf *pat)
+{
+	if (pat->len && is_dir_sep(pat->buf[pat->len - 1]))
+		strbuf_addstr(pat, "**");
+}
+
 static int prepare_include_condition_pattern(struct strbuf *pat)
 {
 	struct strbuf path = STRBUF_INIT;
@@ -199,8 +206,7 @@ static int prepare_include_condition_pattern(struct strbuf *pat)
 	} else if (!is_absolute_path(pat->buf))
 		strbuf_insert(pat, 0, "**/", 3);
 
-	if (pat->len && is_dir_sep(pat->buf[pat->len - 1]))
-		strbuf_addstr(pat, "**");
+	add_trailing_starstar_for_dir(pat);
 
 	strbuf_release(&path);
 	return prefix;
@@ -264,6 +270,25 @@ static int include_by_gitdir(const struct config_options *opts,
 	return ret;
 }
 
+static int include_by_branch(const char *cond, size_t cond_len)
+{
+	int flags;
+	int ret;
+	struct strbuf pattern = STRBUF_INIT;
+	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, &flags);
+	const char *shortname;
+
+	if (!refname || !(flags & REF_ISSYMREF)	||
+			!skip_prefix(refname, "refs/heads/", &shortname))
+		return 0;
+
+	strbuf_add(&pattern, cond, cond_len);
+	add_trailing_starstar_for_dir(&pattern);
+	ret = !wildmatch(pattern.buf, shortname, WM_PATHNAME);
+	strbuf_release(&pattern);
+	return ret;
+}
+
 static int include_condition_is_true(const struct config_options *opts,
 				     const char *cond, size_t cond_len)
 {
@@ -272,6 +297,8 @@ static int include_condition_is_true(const struct config_options *opts,
 		return include_by_gitdir(opts, cond, cond_len, 0);
 	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
 		return include_by_gitdir(opts, cond, cond_len, 1);
+	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
+		return include_by_branch(cond, cond_len);
 
 	/* unknown conditionals are always false */
 	return 0;
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 579a86b7f8..9571e366f8 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -309,6 +309,45 @@ test_expect_success SYMLINKS 'conditional include, gitdir matching symlink, icas
 	)
 '
 
+test_expect_success 'conditional include, onbranch' '
+	echo "[includeIf \"onbranch:foo-branch\"]path=bar9" >>.git/config &&
+	echo "[test]nine=9" >.git/bar9 &&
+	git checkout -b master &&
+	test_must_fail git config test.nine &&
+	git checkout -b foo-branch &&
+	echo 9 >expect &&
+	git config test.nine >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'conditional include, onbranch, wildcard' '
+	echo "[includeIf \"onbranch:?oo-*/**\"]path=bar10" >>.git/config &&
+	echo "[test]ten=10" >.git/bar10 &&
+	git checkout -b not-foo-branch/a &&
+	test_must_fail git config test.ten &&
+
+	echo 10 >expect &&
+	git checkout -b foo-branch/a/b/c &&
+	git config test.ten >actual &&
+	test_cmp expect actual &&
+
+	git checkout -b moo-bar/a &&
+	git config test.ten >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'conditional include, onbranch, implicit /** for /' '
+	echo "[includeIf \"onbranch:foo-dir/\"]path=bar11" >>.git/config &&
+	echo "[test]eleven=11" >.git/bar11 &&
+	git checkout -b not-foo-dir/a &&
+	test_must_fail git config test.eleven &&
+
+	echo 11 >expect &&
+	git checkout -b foo-dir/a/b/c &&
+	git config test.eleven >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'include cycles are detected' '
 	cat >.gitconfig <<-\EOF &&
 	[test]value = gitconfig
-- 
2.22.0.rc1.169.g49223abbf8

