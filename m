Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12726C2D0D9
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27B620643
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="thWeUZGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfLWSuS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 13:50:18 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35645 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfLWSuP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 13:50:15 -0500
Received: by mail-ed1-f66.google.com with SMTP id f8so16145275edv.2
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 10:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9sAEBp03VN0hczQ7xTOnrpthh2uvCvr5S6eq/9p4q/4=;
        b=thWeUZGus07AbpyAxWaGZdcRTYhPU50PYJ4axqw7nFvAL/4Zcbh2c1jvbTnXtizm0X
         HkIVKBf98gKx/1lx3RdReVypJUzWF7jOcXnavVRKD30Ablyr5AVhLKx5uajND/jHWgaJ
         8x1cNSoH0TRANwV7UDAFOwHS2rxzXqqoydJj39/lX7/GWSnVg1Bum+9YTUlyVCRgObKm
         c5kN2c2mYWmL4BIYRc4QPEvf7Z6EF6Zbcgbc0uGNNZLUTBAalODWDYpJ1s7ceGEZKtta
         hgkBrc2Oxr/oMhJy2rlHTo6Uts7fB31eFIFy2/Kw13aNF3ziyLH20jJsokpzPQDcOonC
         JMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9sAEBp03VN0hczQ7xTOnrpthh2uvCvr5S6eq/9p4q/4=;
        b=j17JqL26kDkw8kdvuueetz2u4LOFPi3ZUgOLj9KskyNxCoRGUAzFC0Ko9Eh/tPs4q/
         3FyK3fJzYOnTI8hF1/KCaK7+bNBAQj1/xAcyOLP3NtBn+5ujw4AiqCmIiGqXsWvlVW8e
         iz6xcX5ZhQEv7kq9VnlFBm5LmYR4zsKR67+VkKhG4zKpmmCZf3uJiru7tWeIcsVweEBs
         QHJrIgX1sOmsif8IXs2Fd+ql1+ewe1eiHL9WNgFRlHUskffIo+PxAvaZi5uuuIscn92v
         uH3vEU0znQrYtELZ0KmEYhY3JVsUS7mMMYu/L2ic5/qgXWicVpedfbFEYP7q2KzdwF2c
         qo3g==
X-Gm-Message-State: APjAAAVzocT9khRuzTe5IUNs29WbvNAjESNxNVhLK7nt2HEzmvilwvHM
        AO/bLlN8lZO6OCkzhW83hgNoZEeY
X-Google-Smtp-Source: APXvYqyZya9L/V2JLq+NqOFsHiA7lncJSJGvn7icl/r2tVseiMxjO4U3ZyfVxDczOlk9uV74cTRSyQ==
X-Received: by 2002:a17:906:1cc6:: with SMTP id i6mr884752ejh.31.1577127012034;
        Mon, 23 Dec 2019 10:50:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i21sm2327679edj.33.2019.12.23.10.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 10:50:11 -0800 (PST)
Message-Id: <7adcbc0bc5822ff91b8a0021adaf1382aff582b2.1577127000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
        <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Dec 2019 18:49:59 +0000
Subject: [PATCH v2 15/15] rebase: change the default backend from "am" to
 "merge"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
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
index cf1ac2e359..e819889a31 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -309,7 +309,7 @@ See also INCOMPATIBLE OPTIONS below.
 --merge::
 	Use merging strategies to rebase.  When the recursive (default) merge
 	strategy is used, this allows rebase to be aware of renames on the
-	upstream side.
+	upstream side.  This is the default.
 +
 Note that a rebase merge works by replaying each commit from the working
 branch on top of the <upstream> branch.  Because of this, when a merge
diff --git a/builtin/rebase.c b/builtin/rebase.c
index d602b2da4c..938a8840b1 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -104,7 +104,7 @@ struct rebase_options {
 #define REBASE_OPTIONS_INIT {			  	\
 		.type = REBASE_UNSPECIFIED,	  	\
 		.empty = EMPTY_UNSPECIFIED,	  	\
-		.default_backend = "am",	  	\
+		.default_backend = "merge",	  	\
 		.flags = REBASE_NO_QUIET, 		\
 		.git_am_opts = ARGV_ARRAY_INIT,		\
 		.git_format_patch_opt = STRBUF_INIT	\
@@ -1945,7 +1945,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
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
