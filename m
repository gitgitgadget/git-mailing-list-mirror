Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB593C33CB8
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E6820728
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hi5dNXeI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbgAPGO5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:14:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44857 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730333AbgAPGOw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 01:14:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so17875223wrm.11
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 22:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d2F4nMD+L9T9a5UV3CAfpfg3L7t5iWdoj8bC1I16fiE=;
        b=hi5dNXeIiMX9m0Ou3DpGsMhhmf5Nf3To2426hrDCbygZX29+grm9GzSy3Jmv2PymML
         R5KF2vYSbMXVn3sO+plWAL+DWUaTU9sBKUdjE04snxFb6PTeuI1t9fIhhGcueWwfCX10
         3eEOXlbC9CPM1qEeQqAT3bbivGdOz5zLVg/v68L6TJVg+Q++etF/MxJvy+8t2dOWFGs5
         PZGYfK/o6a/hXutvrTP88eZIzKBUrQ5pWgTA2ZpWFX2RfXXCrGvAKn6XGYlRJ96S9YL8
         7getTXUjcBnLjvwGb52ZlYYxSfB8iXXsRN3RHE+kyf+uQp8b+MiVLzu/ZlGBlhBPijaA
         rxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d2F4nMD+L9T9a5UV3CAfpfg3L7t5iWdoj8bC1I16fiE=;
        b=bYcQqTf3uq4sTPc1FKMFb5RwwvAiRhspU+6Svs3vOestms1WVpSkcv+QThuDGU8fWM
         d0ZocMxRnAE5K3NAgDvamNNW6TybCvY0WFMPWdA5HTD5VfntaFfvl82EXxKiR1fiQHx0
         8SuBOdCxcc1QbQ+eVKAdAyxj4jd9nZvhVhcRJFNNxsKnKDLKPDetWMcLexNDGNn+nNU6
         IZ+J87nmtkycYT4On3kYLyJSreKNF58nEV/qrJVTxyE8ut6g7pogewBZr/i/XutplW6Z
         /S9fAVRk49LZ1ANXg+Qhh2r13bGrWx4ksey+Xwc3eNNUhYw8QFf4NT0+z5mSnR3r8ErD
         wCzQ==
X-Gm-Message-State: APjAAAWyQWeo0JF2LhxC6wYafnYRnQwiFCTFnHRfDHWRCK/A6rYnX8tk
        49PfqX+u5xmMc1B67YbyCVuU+G3H
X-Google-Smtp-Source: APXvYqxlLsOLUJMcB36GKDpCwxv36lD2qD+WHR45Lg1BzPN/e0QBgTaYY+h9jaqCrQbrJ4T2PY4Gpg==
X-Received: by 2002:adf:df8e:: with SMTP id z14mr1295837wrl.190.1579155290080;
        Wed, 15 Jan 2020 22:14:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f1sm27915912wru.6.2020.01.15.22.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 22:14:49 -0800 (PST)
Message-Id: <859a4a94d7f30629886cbe1b55501b1d7371ebd2.1579155274.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
        <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 06:14:33 +0000
Subject: [PATCH v4 19/19] rebase: change the default backend from "am" to
 "merge"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The am-backend drops information and thus limits what we can do:

  * lack of full tree information from the original commits means we
    cannot do directory rename detection and warn users that they might
    want to move some of their new files that they placed in old
    directories to prevent their becoming orphaned.[1]
  * reduction in context from only having a few lines beyond those
    changed means that when context lines are non-unique we can apply
    patches incorrectly.[2]
  * lack of access to original commits means that conflict marker
    annotation has less information available.

Also, the merge/interactive backend have far more abilities, appear to
currently have a slight performance advantage[3] and have room for more
optimizations than the am backend[4] (and work is underway to take
advantage of some of those possibilities).

[1] https://lore.kernel.org/git/xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com/
[2] https://lore.kernel.org/git/CABPp-BGiu2nVMQY_t-rnFR5GQUz_ipyEE8oDocKeO+h+t4Mn4A@mail.gmail.com/
[3] https://public-inbox.org/git/CABPp-BF=ev03WgODk6TMQmuNoatg2kiEe5DR__gJ0OTVqHSnfQ@mail.gmail.com/
[4] https://lore.kernel.org/git/CABPp-BGh7yW69QwxQb13K0HM38NKmQif3A6C6UULEKYnkEJ5vA@mail.gmail.com/

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt           |  2 +-
 builtin/rebase.c                       |  4 ++--
 t/t5520-pull.sh                        | 10 ++++++----
 t/t9106-git-svn-commit-diff-clobber.sh |  3 ++-
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 5230084be9..880e8bff5a 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -313,7 +313,7 @@ See also INCOMPATIBLE OPTIONS below.
 --merge::
 	Use merging strategies to rebase.  When the recursive (default) merge
 	strategy is used, this allows rebase to be aware of renames on the
-	upstream side.
+	upstream side.  This is the default.
 +
 Note that a rebase merge works by replaying each commit from the working
 branch on top of the <upstream> branch.  Because of this, when a merge
diff --git a/builtin/rebase.c b/builtin/rebase.c
index b96de5809e..5c5526f42e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -101,7 +101,7 @@ struct rebase_options {
 #define REBASE_OPTIONS_INIT {			  	\
 		.type = REBASE_UNSPECIFIED,	  	\
 		.empty = EMPTY_UNSPECIFIED,	  	\
-		.default_backend = "am",	  	\
+		.default_backend = "merge",	  	\
 		.flags = REBASE_NO_QUIET, 		\
 		.git_am_opts = ARGV_ARRAY_INIT,		\
 		.git_format_patch_opt = STRBUF_INIT	\
@@ -1917,7 +1917,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if (options.type == REBASE_UNSPECIFIED) {
 		if (!strcmp(options.default_backend, "merge"))
-			options.type = REBASE_MERGE;
+			imply_interactive(&options, "--merge");
 		else if (!strcmp(options.default_backend, "am"))
 			options.type = REBASE_AM;
 		else
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 3fff6a06fa..4f9e7f7ff6 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -340,7 +340,7 @@ test_expect_success '--rebase with conflicts shows advice' '
 	test_tick &&
 	git commit -m "Create conflict" seq.txt &&
 	test_must_fail git pull --rebase . seq 2>err >out &&
-	test_i18ngrep "Resolve all conflicts manually" out
+	test_i18ngrep "Resolve all conflicts manually" err
 '
 
 test_expect_success 'failed --rebase shows advice' '
@@ -354,7 +354,7 @@ test_expect_success 'failed --rebase shows advice' '
 	git checkout -f -b fails-to-rebase HEAD^ &&
 	test_commit v2-without-cr file "2" file2-lf &&
 	test_must_fail git pull --rebase . diverging 2>err >out &&
-	test_i18ngrep "Resolve all conflicts manually" out
+	test_i18ngrep "Resolve all conflicts manually" err
 '
 
 test_expect_success '--rebase fails with multiple branches' '
@@ -774,8 +774,10 @@ test_expect_success 'git pull --rebase does not reapply old patches' '
 	(
 		cd dst &&
 		test_must_fail git pull --rebase &&
-		find .git/rebase-apply -name "000*" >patches &&
-		test_line_count = 1 patches
+		cat .git/rebase-merge/done .git/rebase-merge/git-rebase-todo >work &&
+		grep -v -e \# -e ^$ work >patches &&
+		test_line_count = 1 patches &&
+		rm -f work
 	)
 '
 
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index dbe8deac0d..aec45bca3b 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -92,7 +92,8 @@ test_expect_success 'multiple dcommit from git svn will not clobber svn' "
 
 
 test_expect_success 'check that rebase really failed' '
-	test -d .git/rebase-apply
+	git status >output &&
+	grep currently.rebasing output
 '
 
 test_expect_success 'resolve, continue the rebase and dcommit' "
-- 
gitgitgadget
