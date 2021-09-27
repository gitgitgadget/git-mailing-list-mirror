Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5610FC433FE
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 408EE60EE2
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbhI0QgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 12:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbhI0Qfl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 12:35:41 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931B4C061771
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:33:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g16so53029569wrb.3
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4flcDxnWAKshHJowklyWsYUv/4ql0eXm7FSKYXZjCq8=;
        b=YcCqAUxc/RSw2fcoA8n2p+GaImBIA4LpoP/zaiKWEixKJCnXTPHJNbAJgiz74gn2lr
         Aa6onHKhLxp5S3zQnemMO91PPuMK81A70EvYab9dBzxCLELz+T05Jz1fCgItFIzr2CVw
         e8rcsaUrQ2XQIOnnRJ93OiTdA47/IYm2P8MGRwczuTt5PuKa1EDbJt/fOAbHkOsIu0FV
         TRrzHxTECbEPjZ0+vKIybgf+yeHH0nA7Wtgcr8NGtA80RpjrhjoxMtFlWglwjgBvMP5i
         ZYmG5Q781O0mHSmn1MOmPyvikSsugiVv6xH/tlOWeM4COM/s+oZovExSz3vF/GW4vP5U
         nsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4flcDxnWAKshHJowklyWsYUv/4ql0eXm7FSKYXZjCq8=;
        b=aE9CFydV0JIsI+z+tUzIJO7ObI7dYq5bORPAs2Ek44Ev9slJJsHEW5XsSAVD2bJ3Ex
         r0DcsGSgeXKFHSRdydNl4oHW8KD3E8PCsaVKS0nl7FR6Oma0O5P5jwF73D5TqC5be68d
         PJ4Is7qkDuRbqQOOZzYIKom/LV88eAFHi52HABj1wIp/bQcukwwZea5vw5S1WoDQdPQV
         xV3s+Uxht948G9aJe9p+M0rgcjuUqieaxA7/yTmyw6s1gngxiyhkrFgJQQc7JYsZwFI/
         qdgCJfHdmA8dEZCcemk4N3m8rlwc/y2AohpDwBVLVCn5rWy/OjaVwljSLEZBWYgLlVig
         Y+PA==
X-Gm-Message-State: AOAM532NQRVuElhGOjmyVq+detPvmgObHuhxbIC2TXsbyU1DG2opCCKm
        6o7FpAaWpoAPzWgZbL6NUoHY701Wx5A=
X-Google-Smtp-Source: ABdhPJzA2zmiPCBWhqw+/Kr/uIDIbpudcrAc4JBnmvjsIIES+PxGcUAow5/WVDf0lILeWj5HYwTzhw==
X-Received: by 2002:a05:6000:18a:: with SMTP id p10mr863941wrx.161.1632760435256;
        Mon, 27 Sep 2021 09:33:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g21sm15429wmk.10.2021.09.27.09.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:33:54 -0700 (PDT)
Message-Id: <6b42a80bf3d46e16980d0724e8b07101225239d0.1632760428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
        <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Sep 2021 16:33:47 +0000
Subject: [PATCH v3 10/11] Comment important codepaths regarding nuking
 untracked files/dirs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
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
---
 builtin/stash.c             | 1 +
 builtin/submodule--helper.c | 4 ++++
 contrib/rerere-train.sh     | 2 +-
 submodule.c                 | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 0e3662a230c..aa31163a5a1 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1521,6 +1521,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		} else {
 			struct child_process cp = CHILD_PROCESS_INIT;
 			cp.git_cmd = 1;
+			/* BUG: this nukes untracked files in the way */
 			strvec_pushl(&cp.args, "reset", "--hard", "-q",
 				     "--no-recurse-submodules", NULL);
 			if (run_command(&cp)) {
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5336daf186d..e13f2a0bcd0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3090,6 +3090,10 @@ static int add_submodule(const struct add_data *add_data)
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
index 78aed03d928..c8ba93cc708 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1908,6 +1908,7 @@ static void submodule_reset_index(const char *path)
 
 	strvec_pushf(&cp.args, "--super-prefix=%s%s/",
 		     get_super_prefix_or_empty(), path);
+	/* TODO: determine if this might overwright untracked files */
 	strvec_pushl(&cp.args, "read-tree", "-u", "--reset", NULL);
 
 	strvec_push(&cp.args, empty_tree_oid_hex());
-- 
gitgitgadget

