Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D077F20248
	for <e@80x24.org>; Wed, 13 Mar 2019 10:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfCMKQf (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 06:16:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38776 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfCMKQe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 06:16:34 -0400
Received: by mail-ed1-f67.google.com with SMTP id h58so986299edb.5
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 03:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nXbixarFTJIsDWT6KZkXO4Oe6c8i9qu2CnhVwhoglVQ=;
        b=roGl6hJzLT154ZNsZrNtLAc9oLKSD90CaN5tZm/5NkTzd2f/BcAMfVkBfvoGLMOIGP
         RDqiZZ24UCO+nQNgO/ZiWNWR/sxpCJSNTPPV0/FZ+/ddk+DkNGQKjj4DQ3Jm/uS1UM0f
         JdoVHiw7+JA9akMMrM34jzhFDK7LWfCQoDkevrnqH5SPzxp03Kx76bEnK+RuyD5SbPBh
         L76VBzX6bSF4X2er4zE1br/5A/TPHRIpvOBLQp4SztbZwhkhCnvDrGbezXku/QTghmSi
         K0Z9nMNqNN9J8z+HQjpqb5yjowq1lvZUg8zk7L+MOiWtMlm8VUKVqtfxEqLPg4vjstqH
         dUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nXbixarFTJIsDWT6KZkXO4Oe6c8i9qu2CnhVwhoglVQ=;
        b=VVmL7rVyKlvW/8fzH4vV/uH8b+oNorlU6DZaaZmDv7Qc1+vWvXGtNfW9UE5OwKiMfg
         hH4XKqWLG1uygpRPB7GwzX4+Yv9ZymGwc/zvTQoTplO2K8/GTqbSOlfrIvxzUTnT5uxi
         l1V+uJ6niEEn0matvZaEV/pocUxlCoQ43vmRGlPeYB8G1H1bMGipQFKda3my6goKZA05
         bcU+7LNyJhWVkH268CTtii9EvujHTU7Q48NY0ZrUsGdzSwGgCpwo2sQls030z9NmqmNp
         oB+64EBAvZ/JZ9YbtzMNuHK5oSHBOAPqBZp8Jdc2C/pW+2FfoUJ4of55oq4qBWVmuAPG
         u60Q==
X-Gm-Message-State: APjAAAVdUfJLc6Kin0d002LZZE52PZ3Mfeq2cFbnxCQc/3KIHclZkwGz
        01RN1HrldYeEzhyKDTp755eqiNIM
X-Google-Smtp-Source: APXvYqyHZ5GhqjkKB5VDsXGog1cIwPd0av8PgltgXrVjb4fDOV9qLBbIRwHJpXv4xUcBtcTr35HWQw==
X-Received: by 2002:a50:b7b6:: with SMTP id h51mr6810087ede.277.1552472192127;
        Wed, 13 Mar 2019 03:16:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b1sm460250edc.28.2019.03.13.03.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 03:16:31 -0700 (PDT)
Date:   Wed, 13 Mar 2019 03:16:31 -0700 (PDT)
X-Google-Original-Date: Wed, 13 Mar 2019 10:16:26 GMT
Message-Id: <b3fcd377652103584b6f307c6ee209980b44529f.1552472189.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.161.git.gitgitgadget@gmail.com>
References: <pull.161.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/4] rebase -i: demonstrate obscure loose object cache bug
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We specifically support `exec` commands in `git rebase -i`'s todo lists
to rewrite the very same todo list. Of course, we need to validate that
todo list when re-reading it.

It is also totally legitimate to extend the todo list by `pick` lines
using short names of commits that were created only after the rebase
started.

And this is where the loose object cache interferes with this feature:
if *some* loose object was read whose hash shares the same first two
digits with a commit that was not yet created when that loose object was
created, then we fail to find that new commit by its short name in
`get_oid()`, and the interactive rebase fails with an obscure error
message like:

	error: invalid line 1: pick 6568fef
	error: please fix this using 'git rebase --edit-todo'.

Let's first demonstrate that this is actually a bug in a new regression
test, in a separate commit so that other developers who do not believe
me can cherry-pick it to confirm the problem.

This new regression test generates two commits whose hashes share the
first two hex digits (so that their corresponding loose objects live in
the same subdirectory of .git/objects/, and are therefore supposed to be
in the same loose object cache bin).

It then picks the first, to make sure that the loose object cache is
initialized and cached that object directory, then generates the second
commit and picks it, too. Since the commit was generated in a different
process than the sequencer that wants to pick it, the loose object cache
had no chance of being updated in the meantime.

Technically, we would need only one `exec` command in this regression
test case, but for ease of implementation, it uses a pseudo-recursive
call to the same script.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3429-rebase-edit-todo.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t3429-rebase-edit-todo.sh b/t/t3429-rebase-edit-todo.sh
index b9292dfc2a..862f229c87 100755
--- a/t/t3429-rebase-edit-todo.sh
+++ b/t/t3429-rebase-edit-todo.sh
@@ -11,4 +11,26 @@ test_expect_success 'rebase exec modifies rebase-todo' '
 	test -e F
 '
 
+test_expect_failure SHA1 'loose object cache vs re-reading todo list' '
+	GIT_REBASE_TODO=.git/rebase-merge/git-rebase-todo &&
+	export GIT_REBASE_TODO &&
+	write_script append-todo.sh <<-\EOS &&
+	# For values 5 and 6, this yields SHA-1s with the same first two digits
+	echo "pick $(git rev-parse --short \
+		$(printf "%s\\n" \
+			"tree $EMPTY_TREE" \
+			"author A U Thor <author@example.org> $1 +0000" \
+			"committer A U Thor <author@example.org> $1 +0000" \
+			"" \
+			"$1" |
+		  git hash-object -t commit -w --stdin))" >>$GIT_REBASE_TODO
+
+	shift
+	test -z "$*" ||
+	echo "exec $0 $*" >>$GIT_REBASE_TODO
+	EOS
+
+	git rebase HEAD -x "./append-todo.sh 5 6"
+'
+
 test_done
-- 
gitgitgadget

