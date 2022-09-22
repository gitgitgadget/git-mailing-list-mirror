Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07C1C54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 22:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiIVWht (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 18:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiIVWhr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 18:37:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89376EFA7C
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 15:37:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o5so7698266wms.1
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 15:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:from:to:cc:subject:date;
        bh=yWH0xE843CcpG6E8mHov07nQ9EuLUm0UGzSfgzP89LA=;
        b=amrSrgUp3dsb/aKxSOwERkkVaVKUzzbWbqtc69BqmV2QdHOq3JrvmhEXh7vGme7Vc5
         T5lsexn6hRe0nGUeeg8TVEUCXMbq6P9eh29VIs7AyhHzHll/TtbZ47fulMvV03gAye5M
         rlVhlrS0ebb7xlzY9/IUShcD8skywj6uSuJsSVyHFw2u5uehWo9rCMb0Lo3mUHvZq3F8
         7Oh4jJ0ZSTiGx/chk40SVo0/fQmXhmuVJQ3x3mR6qwaNZqrOol5zxHJr9/MXHDQE8X1B
         rCNY7tCF2+R01v/3dNh62z8euiEiyqSImy/Q1yqk38eicwltBKnL5R+BDTHOXjmwN4ev
         Fbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yWH0xE843CcpG6E8mHov07nQ9EuLUm0UGzSfgzP89LA=;
        b=tpqVxiXdmpK5m1NfM9yMzY+Y5deliP6nJEwsU9CMxjpvQLxi6fzybwfF6Ly0XVbfyM
         joEaXy/yu5AiXJTM0YZUhnpRh2Yw2fj3sXFHG/1AgUXDOI8/RBQsVbbJGN/aA++UH0e6
         nGrRq8su1V8Gjr+rPGgznHQZzh2FRTcBJn4oGUw2bdYHvhIdD88AdeISgDykdZmyTkpR
         5HOC9KjaeBFqoBZsVHU/VJlT4E0qX7S+Q3VhKhroXE3S4ZODWyxtEAoypyM3LRs+D1ZO
         +IveEU5zIc48V8x6GdhfT51R39MaMKKdYgbv5NmO/p+E96x3AeoVy9aNW/E4Db8DrqOY
         lWrw==
X-Gm-Message-State: ACrzQf2dxG2a8capo8PEtnoWtrxVnows+F43zOwsZMAUfPUirdLn/yTY
        Cx8k7skrPZhtAlM+xpMmFTcplm0KSfQ=
X-Google-Smtp-Source: AMsMyM6Wdl56/TFsHgiUNFjj1iamg58SYd/dNY5Q6RLayiEmQkGG2m+nX30msWCYQcXjzeSDsCav5g==
X-Received: by 2002:a05:600c:1d26:b0:3b4:a677:ccc9 with SMTP id l38-20020a05600c1d2600b003b4a677ccc9mr10761398wms.121.1663886265112;
        Thu, 22 Sep 2022 15:37:45 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id p10-20020a5d638a000000b0022b0064841esm5954003wru.59.2022.09.22.15.37.44
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 15:37:44 -0700 (PDT)
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH] branch: description for non-existent branch errors
Message-ID: <c333cc4b-12a1-82b6-0961-1c42080dad15@gmail.com>
Date:   Fri, 23 Sep 2022 00:37:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the repository does not yet has commits, some errors describe that
there is no branch:

    $ git init -b first

    $ git --edit-description first
    fatal: branch 'first' does not exist

    $ git --set-upstream-to=upstream
    fatal: branch 'first' does not exist

    $ git branch -c second
    error: refname refs/heads/first not found
    fatal: Branch copy failed

That "first" branch is unborn but to say it doesn't exists is confusing.

Options "-c" (copy) and "-m" (rename) show the same error when the
origin branch doesn't exists:

    $ git branch -c non-existent-branch second
    error: refname refs/heads/non-existent-branch not found
    fatal: Branch copy failed

    $ git branch -m non-existent-branch second
    error: refname refs/heads/non-existent-branch not found
    fatal: Branch rename failed

Note that "--edit-description" without an explicit argument is already
considering the _empty repository_ circumstance in its error.  Also note
that "-m" on the initial branch it is an allowed operation.

This commit makes the error descriptions for those branch operations
with unborn or non-existent branches, more informative.

This is the result of the change:

    $ git init -b first

    $ git --edit-description first
    fatal: No commit on branch 'first' yet.

    $ git --set-upstream-to=upstream
    fatal: No commit on branch 'first' yet.

    $ git -c second
    fatal: No commit on branch 'first' yet.

    $ git [-c/-m] non-existent-branch second
    fatal: No branch named 'non-existent-branch'.

---

Hi all.

I would appreciate some guidance here.

This patch is based on master but there is already in 'seen' a patch
submitted for 'branch' that produces conflicts with this.  I don't know
if it is more convenient to submit this patch based on 'seen'
considering that.

I submitted that other patch too and prefer to keep the changes separate
but maybe it's better not to and do a rollup with this on that other
patch.. I don't know how disturbing it is to submit a new patch when it
is "waiting for review".

Another approach?

Thank you.


Un saludo.

 builtin/branch.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 55cd9a6e99..5ca35064f3 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -538,6 +538,13 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 			die(_("Invalid branch name: '%s'"), oldname);
 	}
 
+	if (copy && !ref_exists(oldref.buf)) {
+		if (!strcmp(head, oldname))
+			die(_("No commit on branch '%s' yet."), oldname);
+		else
+			die(_("No branch named '%s'."), oldname);
+	}
+
 	/*
 	 * A command like "git branch -M currentbranch currentbranch" cannot
 	 * cause the worktree to become inconsistent with HEAD, so allow it.
@@ -805,7 +812,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!ref_exists(branch_ref.buf)) {
 			strbuf_release(&branch_ref);
 
-			if (!argc)
+			if (!argc || !strcmp(head, branch_name))
 				return error(_("No commit on branch '%s' yet."),
 					     branch_name);
 			else
@@ -848,8 +855,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die(_("no such branch '%s'"), argv[0]);
 		}
 
-		if (!ref_exists(branch->refname))
+		if (!ref_exists(branch->refname)) {
+			if (!argc || !strcmp(head, branch->name))
+				die(_("No commit on branch '%s' yet."), branch->name);
 			die(_("branch '%s' does not exist"), branch->name);
+		}
 
 		dwim_and_setup_tracking(the_repository, branch->name,
 					new_upstream, BRANCH_TRACK_OVERRIDE,
-- 
2.36.1
