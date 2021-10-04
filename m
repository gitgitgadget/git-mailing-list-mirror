Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C940C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85BCE6115B
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhJDBOM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 21:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhJDBOF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 21:14:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAC9C061788
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 18:12:11 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r18so309392wrg.6
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 18:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Va3OCSs1QcDZyg3510+KU2IW6XAx9EG+z6fMGugxZKc=;
        b=WwjEFRdAetTLhPg9JlNiZYqIW7feyk3SQZmwxkV6tdFfGtsIf681dfcYw6+9bBzpf1
         GwcZ30qLxFCd47MATGE5jvtHTwyqqnDhDccHXfhjSk2D/xK15TmnnzIQ1V5/AkqFltld
         57XyVBAFn8YmN70Kws9mLSHl9ZvvZ4RMjNarGlvMurjEo484wGT3UKeFldkFFSRUVwKJ
         zgEB4z+i8ssVIsrsybr4uHmURH96Gbi0AwipoI+n7GOTxh6uzVCmadEYP/oFDREF2IhK
         lkr5dpw7LjDCY6vaXq/hXA9mYSFDQNMSkrIzvtq4H2E3rw68sOw7aQV+IOxtWBB8Jww0
         SscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Va3OCSs1QcDZyg3510+KU2IW6XAx9EG+z6fMGugxZKc=;
        b=M8o+hJh1hN8fa7gth81g/m9sY/gcxa9Xh5q+puuXfuoYs6le8M09El+y+qUQjrO0wk
         ZZHGvvZHzQox7I59H4dlw+8Bv9ajDAHnHJs7SlzZnbhtBgbgnsfCAA8lmK/gUQZJo7Zt
         jYZtVKBkYyV9PX9zOg+zoCmKJ6BI2NZ3pzh0623qrPd6Ys3JVwUe+qjzlhk0vKutLtZm
         tgSVhg3LGHc/ofNBX+f+9m7JxRWYOLgkDdjkIKskT5ZpBHEm4xm7P+9wj0qPdqsrydIQ
         BHp5vSULRq+dmOZdIVJBZxTMvN3vsaFIZYh+aDf1EbT2SCs4AlMkGBbNezrGzJ9+2VpY
         94Og==
X-Gm-Message-State: AOAM5309vLOFYAcg0hguiOqo7sqWl0l7obJHaD+/mR/Ln4rYPZucaBVF
        2oCPOjdNEA9M7O22+i0gKiIEgV4sDp9DyQ==
X-Google-Smtp-Source: ABdhPJzMo97sU2UzPDQQP3TCKqHyMwTreJTMc13pVrdwyRm7kXtteqlI3jJjMnMNJ3f4caQEyVPnmw==
X-Received: by 2002:a5d:648f:: with SMTP id o15mr11104694wri.338.1633309930156;
        Sun, 03 Oct 2021 18:12:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q3sm12384317wmc.25.2021.10.03.18.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 18:12:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v4 09/10] Comment important codepaths regarding nuking untracked files/dirs
Date:   Mon,  4 Oct 2021 03:11:58 +0200
Message-Id: <RFC-patch-v4-09.10-b2f27d961a9-20211004T004902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g83021034c5d
In-Reply-To: <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
References: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com> <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In the last few commits we focused on code in unpack-trees.c that
mistakenly removed untracked files or directories.  There may be more of
those, but in this commit we change our focus: callers of toplevel
commands that are expected to remove untracked files or directories.

As noted previously, we have toplevel commands that are expected to
delete untracked files such as 'read-tree --reset', 'reset --hard', and
'checkout --force'.  However, that does not mean that other highlevel
commands that happen to call these other commands thought about or
conveyed to users the possibility that untracked files could be removed.
Audit the code for such callsites, and add comments near existing
callsites to mention whether these are safe or not.

My auditing is somewhat incomplete, though; it skipped several cases:
  * git-rebase--preserve-merges.sh: is in the process of being
    deprecated/removed, so I won't leave a note that there are
    likely more bugs in that script.
  * contrib/git-new-workdir: why is the -f flag being used in a new
    empty directory??  It shouldn't hurt, but it seems useless.
  * git-p4.py: Don't see why -f is needed for a new dir (maybe it's
    not and is just superfluous), but I'm not at all familiar with
    the p4 stuff
  * git-archimport.perl: Don't care; arch is long since dead
  * git-cvs*.perl: Don't care; cvs is long since dead

Also, the reset --hard in builtin/worktree.c looks safe, due to only
running in an empty directory.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/stash.c             | 1 +
 builtin/submodule--helper.c | 4 ++++
 contrib/rerere-train.sh     | 2 +-
 submodule.c                 | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 061237cf9a4..fabfb63632e 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1525,6 +1525,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		} else {
 			struct child_process cp = CHILD_PROCESS_INIT;
 			cp.git_cmd = 1;
+			/* BUG: this nukes untracked files in the way */
 			strvec_pushl(&cp.args, "reset", "--hard", "-q",
 				     "--no-recurse-submodules", NULL);
 			if (run_command(&cp)) {
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 57f09925157..e40e4b6aacc 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3091,6 +3091,10 @@ static int add_submodule(const struct add_data *add_data)
 		prepare_submodule_repo_env(&cp.env_array);
 		cp.git_cmd = 1;
 		cp.dir = add_data->sm_path;
+		/*
+		 * NOTE: we only get here if add_data->force is true, so
+		 * passing --force to checkout is reasonable.
+		 */
 		strvec_pushl(&cp.args, "checkout", "-f", "-q", NULL);
 
 		if (add_data->branch) {
diff --git a/contrib/rerere-train.sh b/contrib/rerere-train.sh
index eeee45dd341..75125d6ae00 100755
--- a/contrib/rerere-train.sh
+++ b/contrib/rerere-train.sh
@@ -91,7 +91,7 @@ do
 		git checkout -q $commit -- .
 		git rerere
 	fi
-	git reset -q --hard
+	git reset -q --hard  # Might nuke untracked files...
 done
 
 if test -z "$branch"
diff --git a/submodule.c b/submodule.c
index 03cf36707ae..9f3d9b7ee73 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1910,6 +1910,7 @@ static void submodule_reset_index(const char *path)
 
 	strvec_pushf(&cp.args, "--super-prefix=%s%s/",
 		     get_super_prefix_or_empty(), path);
+	/* TODO: determine if this might overwright untracked files */
 	strvec_pushl(&cp.args, "read-tree", "-u", "--reset", NULL);
 
 	strvec_push(&cp.args, empty_tree_oid_hex());
-- 
2.33.0.1404.g83021034c5d

