Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1BEF1F462
	for <e@80x24.org>; Fri, 31 May 2019 19:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfEaTdr (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 15:33:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42820 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbfEaTdr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 15:33:47 -0400
Received: by mail-io1-f67.google.com with SMTP id g16so9170455iom.9
        for <git@vger.kernel.org>; Fri, 31 May 2019 12:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wn6EfMcJAxSBnKY7cwPoyIDm2ZK0OE3ptGfyPbBcwjo=;
        b=gbATV3VA+5FNrcip4HUiiHR+XLndfrWJCy5auSoD45me7ue7F5SPtzA1ezNCT0aNKL
         YaSODYcRKtep63XtQO2tEVHqWV2fWOs0iM5FrNX2OL6lwR+bnCZOkQKisXj+UStafzk6
         GPqGElyi0K5JPw3S6xQmKfPZn8iaZgg0VXbHfO0FF0fkNlpOZd/3EZBdg6WEikhrZTzE
         98K0DD3p9mNkYHe4gIB7gj9KucRvSIX2SIcEdvrmgzFWnWD5urz8LbULsIPgQbQoZ24a
         sbstHG+WUQ0aA1MJGuQLLIzW9VH5JQq47uwEWEPsuC+e2+/LQnYYsoQEJDmH2lQyV1ap
         rcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wn6EfMcJAxSBnKY7cwPoyIDm2ZK0OE3ptGfyPbBcwjo=;
        b=E2entLlEMmIX4XFrJfEvw/JO3XFMS9KcMTE3rm/fiPlO5NGiuhbBKjlWwKAouwL5pR
         eZzSxnDCt9fbN01VTT5ZCN8ifYuigEd4xbAW3kWXmUDIXtEhQOgvkgpRR2J0+74tboTw
         jMetE+99I4iikqFC2C117QSDjweCvkwPJBSxuFPSsbw0VnSi/i6LbMxnsShifwBXFEua
         6+cJhoMKpL1fQwURWgB7if7dEZUKqWgrhG6XtkAjGl7MueWcJFfCT3eQ3U1vNbmIQ6f6
         i3DZGlm6ED7C20i81CcycnMLS5mnzqkFQEamHLbdc5hzb15hswCGUkOedWTUdiFTTM4j
         9q9g==
X-Gm-Message-State: APjAAAXx9wLxaUYnzZdGK1RtD4VDVSDquWe6a+RN2KWnxcFGrfvMPks9
        nTyI09K7Xtsdx+fuu2v05ybm6a9X
X-Google-Smtp-Source: APXvYqxr6p7z9AYD37/yq+GyzYI3L8PlbeZJTY84Ni1/g7VywAODiegsFYZTZ77Wnb3iYNrqV3uELQ==
X-Received: by 2002:a5d:9b06:: with SMTP id y6mr7676192ion.149.1559331226223;
        Fri, 31 May 2019 12:33:46 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id a206sm397575itb.8.2019.05.31.12.33.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 12:33:44 -0700 (PDT)
Date:   Fri, 31 May 2019 15:33:42 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] config: learn the "onbranch:" includeIf condition
Message-ID: <3573995264441c50ea9529b3ee926d1ed3ec4ac8.1559330905.git.liu.denton@gmail.com>
References: <7b60e58ba554768fd915e4f5c00a97737707ed42.1559263024.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b60e58ba554768fd915e4f5c00a97737707ed42.1559263024.git.liu.denton@gmail.com>
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

Thanks for taking a look, Johannes. I've modified the patch to match
with wildcards now.

Changes since v1:

* Allow onbranch: to specify a pattern instead of just a static
  comparison

Interdiff against v1:
  diff --git a/Documentation/config.txt b/Documentation/config.txt
  index 3b9fbe1860..93aa4323c6 100644
  --- a/Documentation/config.txt
  +++ b/Documentation/config.txt
  @@ -145,9 +145,11 @@ refer to linkgit:gitignore[5] for details. For convenience:
   	case-insensitively (e.g. on case-insensitive file sytems)
   
   `onbranch`::
  -	The data that follows the keyword `onbranch:` is taken to be a
  -	name of a local branch. If we are in a worktree where that
  -	branch is currently checked out, the include condition is met.
  +	The data that follows the keyword `onbranch:` is taken to be a pattern
  +	with standard globbing wildcards and two additional ones, `**/` and
  +	`/**`, that can match multiple path components. If we are in a worktree
  +	where the name of the branch that is currently checked out matches the
  +	pattern, the include condition is met.
   
   A few more notes on matching via `gitdir` and `gitdir/i`:
   
  diff --git a/config.c b/config.c
  index 954e84e13a..48bb435739 100644
  --- a/config.c
  +++ b/config.c
  @@ -268,6 +268,8 @@ static int include_by_gitdir(const struct config_options *opts,
   static int include_by_branch(const char *cond, size_t cond_len)
   {
   	int flags;
  +	int ret;
  +	struct strbuf pattern = STRBUF_INIT;
   	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, &flags);
   	const char *shortname;
   
  @@ -275,7 +277,10 @@ static int include_by_branch(const char *cond, size_t cond_len)
   			!skip_prefix(refname, "refs/heads/", &shortname))
   		return 0;
   
  -	return !strncmp(cond, shortname, cond_len);
  +	strbuf_add(&pattern, cond, cond_len);
  +	ret = !wildmatch(pattern.buf, shortname, WM_PATHNAME);
  +	strbuf_release(&pattern);
  +	return ret;
   }
   
   static int include_condition_is_true(const struct config_options *opts,
  diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
  index 062db08ad9..05c7def1f2 100755
  --- a/t/t1305-config-include.sh
  +++ b/t/t1305-config-include.sh
  @@ -314,6 +314,7 @@ test_expect_success 'conditional include, onbranch' '
   		cd bar &&
   		echo "[includeIf \"onbranch:foo-branch\"]path=bar9" >>.git/config &&
   		echo "[test]nine=9" >.git/bar9 &&
  +		git checkout -b master &&
   		test_must_fail git config test.nine &&
   		git checkout -b foo-branch &&
   		echo 9 >expect &&
  @@ -322,6 +323,25 @@ test_expect_success 'conditional include, onbranch' '
   	)
   '
   
  +test_expect_success 'conditional include, onbranch, wildcard' '
  +	(
  +		cd bar &&
  +		echo "[includeIf \"onbranch:?oo-*/**\"]path=bar10" >>.git/config &&
  +		echo "[test]ten=10" >.git/bar10 &&
  +		git checkout -b not-foo-branch/a &&
  +		test_must_fail git config test.ten &&
  +
  +		echo 10 >expect &&
  +		git checkout -b foo-branch/a/b/c &&
  +		git config test.ten >actual &&
  +		test_cmp expect actual &&
  +
  +		git checkout -b moo-bar/a &&
  +		git config test.ten >actual &&
  +		test_cmp expect actual
  +	)
  +'
  +
   test_expect_success 'include cycles are detected' '
   	cat >.gitconfig <<-\EOF &&
   	[test]value = gitconfig

 Documentation/config.txt  | 12 ++++++++++++
 config.c                  | 21 +++++++++++++++++++++
 t/t1305-config-include.sh | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7e2a6f61f5..93aa4323c6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -144,6 +144,13 @@ refer to linkgit:gitignore[5] for details. For convenience:
 	This is the same as `gitdir` except that matching is done
 	case-insensitively (e.g. on case-insensitive file sytems)
 
+`onbranch`::
+	The data that follows the keyword `onbranch:` is taken to be a pattern
+	with standard globbing wildcards and two additional ones, `**/` and
+	`/**`, that can match multiple path components. If we are in a worktree
+	where the name of the branch that is currently checked out matches the
+	pattern, the include condition is met.
+
 A few more notes on matching via `gitdir` and `gitdir/i`:
 
  * Symlinks in `$GIT_DIR` are not resolved before matching.
@@ -206,6 +213,11 @@ Example
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
index 296a6d9cc4..48bb435739 100644
--- a/config.c
+++ b/config.c
@@ -19,6 +19,7 @@
 #include "utf8.h"
 #include "dir.h"
 #include "color.h"
+#include "refs.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -264,6 +265,24 @@ static int include_by_gitdir(const struct config_options *opts,
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
+	ret = !wildmatch(pattern.buf, shortname, WM_PATHNAME);
+	strbuf_release(&pattern);
+	return ret;
+}
+
 static int include_condition_is_true(const struct config_options *opts,
 				     const char *cond, size_t cond_len)
 {
@@ -272,6 +291,8 @@ static int include_condition_is_true(const struct config_options *opts,
 		return include_by_gitdir(opts, cond, cond_len, 0);
 	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
 		return include_by_gitdir(opts, cond, cond_len, 1);
+	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
+		return include_by_branch(cond, cond_len);
 
 	/* unknown conditionals are always false */
 	return 0;
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 579a86b7f8..05c7def1f2 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -309,6 +309,39 @@ test_expect_success SYMLINKS 'conditional include, gitdir matching symlink, icas
 	)
 '
 
+test_expect_success 'conditional include, onbranch' '
+	(
+		cd bar &&
+		echo "[includeIf \"onbranch:foo-branch\"]path=bar9" >>.git/config &&
+		echo "[test]nine=9" >.git/bar9 &&
+		git checkout -b master &&
+		test_must_fail git config test.nine &&
+		git checkout -b foo-branch &&
+		echo 9 >expect &&
+		git config test.nine >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'conditional include, onbranch, wildcard' '
+	(
+		cd bar &&
+		echo "[includeIf \"onbranch:?oo-*/**\"]path=bar10" >>.git/config &&
+		echo "[test]ten=10" >.git/bar10 &&
+		git checkout -b not-foo-branch/a &&
+		test_must_fail git config test.ten &&
+
+		echo 10 >expect &&
+		git checkout -b foo-branch/a/b/c &&
+		git config test.ten >actual &&
+		test_cmp expect actual &&
+
+		git checkout -b moo-bar/a &&
+		git config test.ten >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'include cycles are detected' '
 	cat >.gitconfig <<-\EOF &&
 	[test]value = gitconfig
-- 
2.22.0.rc1.169.g49223abbf8

