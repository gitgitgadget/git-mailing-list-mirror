Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727BBC433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 14:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbiI3OKq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 10:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiI3OKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 10:10:25 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EC1A220C
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 07:10:23 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x18so7071102wrm.7
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 07:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=xByOeG/pDvr/M8WXGQBjFg1YyFNoMZlxWf7hMxqxGq8=;
        b=KBp2JSEttirDtpnTPdTu256UZLRXTkaDQJwEqpT4x2UZAMInwqTKO8gR6B701/TLQW
         BEH+HZcSe6KcBYRD7Njgz3c0dMTHotGgXf9dWM45OfrcWtbfFkXiRIQQYL/BZidOF42t
         Ok0aSRWRTcOVr/Ntveoct8eznx6dhhykZiZRUA5TL3nVqFWWdoIcx1+J2v5ZzRX/8Kpm
         +cZgwc6GehSEXQeWASFnsGkJhY/nTT/zrRQ6M5O/iYjuJiWi+d7EJcgjLIx4ugK0VMZV
         EdYGR6rwhttyHxV4TE8BEvCgKUWiVVDDvEUTrw1TzC+H/0fzr7aARO28j0cNYMhxd/6Q
         H8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xByOeG/pDvr/M8WXGQBjFg1YyFNoMZlxWf7hMxqxGq8=;
        b=XpvJuF+t0C4MLeab8lD/VX6WOgFe3hTolEjAIcN0y9bAmw4L96dX8eul0caWNlSbgQ
         nH5k3YSEugJQk0vjR/vYDzincm4/0cOggR7NoCoHCE0oQlOPL2zSHX8aX2InFd/Qym5B
         3lAz2xbnQ9QLb1aRD+QIMwwE2KWJbOIgYFARL3xWpKv3eJHbCeVBYLZ3mZf6JqlUIybM
         cbTkTdZlp1mX8s54DoomHB929RiLwOgONSpo+hsULPKCpI1kI58m4YStjlpxsKimwU1s
         XW1bUjNei8nPjvfL+DhtI24JA1/yPemkmOki8phUchqkfxW76pY4pmkwGTQtiqYUz/Zv
         d9hA==
X-Gm-Message-State: ACrzQf3X2qzyMPM6fVAlR8SNiaIePoS0UHsdW7M935DwwtUrg/cEWx5B
        wkk1bx5ePjpu5zjx6Y7adY777C2xXyE=
X-Google-Smtp-Source: AMsMyM6gmjfE/vDVLu0pYHjB5WBW9unMALlMLo9plzMjxSUMEKw6Do6+eKA4muhOrP9pdbs4cVyLsw==
X-Received: by 2002:a5d:6dc3:0:b0:22a:bcc3:21c6 with SMTP id d3-20020a5d6dc3000000b0022abcc321c6mr6228736wrz.450.1664547021993;
        Fri, 30 Sep 2022 07:10:21 -0700 (PDT)
Received: from localhost (94-21-37-194.pool.digikabel.hu. [94.21.37.194])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d4bcd000000b00226dba960b4sm2154299wrt.3.2022.09.30.07.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 07:10:21 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 5/6] sequencer: duplicate the result of resolve_ref_unsafe()
Date:   Fri, 30 Sep 2022 16:09:47 +0200
Message-Id: <20220930140948.80367-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.542.g9b62912f7f
In-Reply-To: <20220930140948.80367-1-szeder.dev@gmail.com>
References: <20220930140948.80367-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 'git rebase -i --update-refs' generates the todo list for the
rebased commit range, an 'update-ref' instruction is inserted for each
ref that points to one of those commits, except for the rebased branch
(because at the end of the rebase it will be updated anyway) and any
refs that are checked out in a worktree; for the latter a "Ref <ref>
checked out at '<worktree>'" comment is added.  One of these comments
can be missing under some circumstances: if the oldest commit with a
ref pointing to it has multiple refs pointing to it, and at least one
of those refs is checked out in a worktree, and one of them (but not
the first) is checked out in the worktree associated with the last
directory entry in '.git/worktrees'.

The culprit is the add_decorations_to_list() function, which calls
resolve_ref_unsafe() to figure out the refname of the rebased branch.
However, resolve_ref_unsafe() can (and in this case does) return a
pointer to a static buffer.  Alas, add_decorations_to_list() holds on
that static buffer until the end of the function, using its contents
to compare refnames with the rebased branch, while it also calls a
function that invokes refs_resolve_ref_unsafe() internally [1], and
which overwrites the content of that static buffer, and messes up
subsequent refname comparisons.

Use xstrdup_or_null() to keep a copy of resolve_ref_unsafe()'s return
value for the duration of add_decorations_to_list().

[1] #0  refs_resolve_ref_unsafe (refs=0x555555a23d00,
        refname=0x555555928523 "HEAD", resolve_flags=0, oid=0x555555a23c78,
        flags=0x7fffffffc0cc) at refs.c:1781
    #1  0x000055555587a1d9 in add_head_info (wt=0x555555a23c50) at worktree.c:33
    #2  0x000055555587a446 in get_linked_worktree (id=0x555555a19c43 "WorkTree")
        at worktree.c:91
    #3  0x000055555587a628 in get_worktrees () at worktree.c:135
    #4  0x00005555556a7676 in prepare_checked_out_branches () at branch.c:385
    #5  0x00005555556a7a76 in branch_checked_out (
        refname=0x555555a12e9c "refs/heads/branch2") at branch.c:446
    #6  0x0000555555824f55 in add_decorations_to_list (commit=0x5555559efd08,
        ctx=0x7fffffffc3e0) at sequencer.c:5946

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 sequencer.c                   |  5 +++--
 t/t3404-rebase-interactive.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index fba92c90b1..f1732f88f3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5917,10 +5917,10 @@ static int add_decorations_to_list(const struct commit *commit,
 				   struct todo_add_branch_context *ctx)
 {
 	const struct name_decoration *decoration = get_name_decoration(&commit->object);
-	const char *head_ref = resolve_ref_unsafe("HEAD",
+	const char *head_ref = xstrdup_or_null(resolve_ref_unsafe("HEAD",
 						  RESOLVE_REF_READING,
 						  NULL,
-						  NULL);
+						  NULL));
 
 	while (decoration) {
 		struct todo_item *item;
@@ -5965,6 +5965,7 @@ static int add_decorations_to_list(const struct commit *commit,
 		decoration = decoration->next;
 	}
 
+	free((char *)head_ref);
 	return 0;
 }
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 7f0df58628..2e081b3914 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -2016,6 +2016,40 @@ test_expect_success REFFILES '--update-refs: check failed ref update' '
 	test_cmp expect err.trimmed
 '
 
+test_expect_success 'what should I call this?!' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit_bulk --message="%s" 4 &&
+		git branch branch1 HEAD^ &&
+		git branch branch2 HEAD^ &&
+		git branch branch3 HEAD^ &&
+
+		git worktree add WorkTree branch2 &&
+		git worktree list --porcelain >out &&
+		wtpath=$(sed -n -e "s%^worktree \(.*/WorkTree\)%\1%p" out) &&
+
+		cat >expect <<-EOF &&
+		pick $(git log -1 --format=%h HEAD^^) 2
+		pick $(git log -1 --format=%h HEAD^) 3
+		update-ref refs/heads/branch3
+		# Ref refs/heads/branch2 checked out at $SQ$wtpath$SQ
+		update-ref refs/heads/branch1
+		pick $(git log -1 --format=%h HEAD) 4
+		EOF
+
+		write_script fake-editor.sh <<-\EOF &&
+		sed -n -e "/^$/q;p" "$1"
+		exit 1
+		EOF
+		test_set_editor "$(pwd)/fake-editor.sh" &&
+		test_must_fail git rebase -i --update-refs HEAD^^^ >actual &&
+
+		test_cmp expect actual
+	)
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
2.38.0.rc2.542.g9b62912f7f

