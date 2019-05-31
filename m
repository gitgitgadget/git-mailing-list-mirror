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
	by dcvr.yhbt.net (Postfix) with ESMTP id 52FDB1F462
	for <e@80x24.org>; Fri, 31 May 2019 02:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfEaCBH (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 22:01:07 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44241 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfEaCBH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 22:01:07 -0400
Received: by mail-io1-f65.google.com with SMTP id f22so6821605iol.11
        for <git@vger.kernel.org>; Thu, 30 May 2019 19:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vfcyFyQCWQnxVpfKRbrhaXeMJdz8xihUyXBe/Ke3Gvs=;
        b=YlJJy7ZESy07sZdE95+sFQQZ1O5BbTJmAWDp+dwEqe02k3DeXXWha0QrjIx2DxUZg1
         SlXwsU2YQ9P9+vHxgfUWfqD6iC72JesH8i9nZpN4W2YqfFiDtX+WC66zCH8MZ9bvEaQR
         TzjPERXoOMroFG6o9a1AXlDZmaxIEMWJrm4Wtf+WKrwRY0+gw24aC7l1XLwf94ToF1jL
         TjUyxc3537UGz1wy3K42f5u4HuVxeZ6sjOOLNcXWpQJHXgfxc1OShgRIqjyjKqmOhWGa
         krT6D8XOUQu8FAXbRIn2huEsxiQEl24QIaKA0/9YB4ZUi66hmFIsPbowIR9M4wxGnqOi
         lwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vfcyFyQCWQnxVpfKRbrhaXeMJdz8xihUyXBe/Ke3Gvs=;
        b=XQ2jN2Kzw+S+Tp90cQyQ2WQOzRaQhhTmW/yiBnnGa1cznN+Q1kc+MBDq6QYka1h1EF
         S8M69S5xqKP8wt+08q5Qv0to29CFIPcsAw1OVrPIVq1HPcZ1jinQ/wXiifQ9+4B0VNvg
         NNp5JsCWqDFvl7vIla776QTM8EIEoXzUS2KENU7PVvSuaD9wJszfp/IKN5j55+OE6qRL
         /F5Nqah0ogMASGHf4T+TIlTqO0sOJkMyyyEftnl4t92d/qdljdIm1QrUrwGfEU2u64mG
         fcJycHjOYCEEOd0q8ALg/jxyjLkXrIbnmaBpm4f0iJtJRg9DqBY1lXLLgwH8GHkhD43X
         +3NA==
X-Gm-Message-State: APjAAAWuHqmY5MJ442UFGxGGy5oF7JhAm38qdN1osd6pyqK19mXQAS1C
        FX1ygUqqXfK6Be9HQ6GB3ePc++cz
X-Google-Smtp-Source: APXvYqygDd7BxiDAkcr8bckJS236gEoW3VgbfFb71RSRNnkL3NAsAX3Aab5qxgdH+uT98lNEeBRlqQ==
X-Received: by 2002:a5e:c705:: with SMTP id f5mr5459034iop.113.1559268065382;
        Thu, 30 May 2019 19:01:05 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-grc-01-76-68-140-144.dsl.bell.ca. [76.68.140.144])
        by smtp.gmail.com with ESMTPSA id w189sm1738801itf.39.2019.05.30.19.01.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 30 May 2019 19:01:04 -0700 (PDT)
Date:   Thu, 30 May 2019 22:00:59 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH] config: learn the "onbranch:" includeIf condition
Message-ID: <7b60e58ba554768fd915e4f5c00a97737707ed42.1559263024.git.liu.denton@gmail.com>
References: <xmqqh8a5k9bu.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh8a5k9bu.fsf@gitster-ct.c.googlers.com>
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
conditionally include configuration files if the branch is checked out
in the current worktree.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

I decided to go ahead and implement the includeIf onbranch semantics for
fun. For completeness, I'm sending it to the list but I'm not really
sure if this should get merged, since I don't really have a use-case for
this, especially if we go the branch-specific format-patch config route.

Another thing to note is that this change doesn't completely cover all
the use-cases that the branch-specific format-patch does. In particular,
if I run

	$ git checkout foo
	$ git format-patch master..bar

with the `format.bar.*`, we'd get bar-specific configs, whereas with
`includeIf "onbranch:bar"`, we'd fail to include bar-specific configs
and, more dangerously, we'd be including foo's configs.

But let's see how it goes.

 Documentation/config.txt  | 10 ++++++++++
 config.c                  | 16 ++++++++++++++++
 t/t1305-config-include.sh | 13 +++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7e2a6f61f5..3b9fbe1860 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -144,6 +144,11 @@ refer to linkgit:gitignore[5] for details. For convenience:
 	This is the same as `gitdir` except that matching is done
 	case-insensitively (e.g. on case-insensitive file sytems)
 
+`onbranch`::
+	The data that follows the keyword `onbranch:` is taken to be a
+	name of a local branch. If we are in a worktree where that
+	branch is currently checked out, the include condition is met.
+
 A few more notes on matching via `gitdir` and `gitdir/i`:
 
  * Symlinks in `$GIT_DIR` are not resolved before matching.
@@ -206,6 +211,11 @@ Example
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
index 296a6d9cc4..954e84e13a 100644
--- a/config.c
+++ b/config.c
@@ -19,6 +19,7 @@
 #include "utf8.h"
 #include "dir.h"
 #include "color.h"
+#include "refs.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -264,6 +265,19 @@ static int include_by_gitdir(const struct config_options *opts,
 	return ret;
 }
 
+static int include_by_branch(const char *cond, size_t cond_len)
+{
+	int flags;
+	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, &flags);
+	const char *shortname;
+
+	if (!refname || !(flags & REF_ISSYMREF)	||
+			!skip_prefix(refname, "refs/heads/", &shortname))
+		return 0;
+
+	return !strncmp(cond, shortname, cond_len);
+}
+
 static int include_condition_is_true(const struct config_options *opts,
 				     const char *cond, size_t cond_len)
 {
@@ -272,6 +286,8 @@ static int include_condition_is_true(const struct config_options *opts,
 		return include_by_gitdir(opts, cond, cond_len, 0);
 	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
 		return include_by_gitdir(opts, cond, cond_len, 1);
+	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
+		return include_by_branch(cond, cond_len);
 
 	/* unknown conditionals are always false */
 	return 0;
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 579a86b7f8..062db08ad9 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -309,6 +309,19 @@ test_expect_success SYMLINKS 'conditional include, gitdir matching symlink, icas
 	)
 '
 
+test_expect_success 'conditional include, onbranch' '
+	(
+		cd bar &&
+		echo "[includeIf \"onbranch:foo-branch\"]path=bar9" >>.git/config &&
+		echo "[test]nine=9" >.git/bar9 &&
+		test_must_fail git config test.nine &&
+		git checkout -b foo-branch &&
+		echo 9 >expect &&
+		git config test.nine >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'include cycles are detected' '
 	cat >.gitconfig <<-\EOF &&
 	[test]value = gitconfig
-- 
2.22.0.rc1.169.g49223abbf8

