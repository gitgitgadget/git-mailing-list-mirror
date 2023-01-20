Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C143C38159
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 05:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjATFKO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 00:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjATFJv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 00:09:51 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2715AD24
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 20:57:11 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l8so3126132wms.3
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 20:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxanLLgJw6l0LWQXcf7/GjCDecn9EyhVgm1EHLXQUJI=;
        b=Pni7tUnxZvsTV1mrFukHRNgHlr/MjhzfiG43IBCEO+aPH1b8CAxlwDGEKNbaR43/HE
         acGcOCgAXBK/mTxaFTTiJ+suhBh/z8sE/1Do5JPZNN9MFnZEB77CIOa3hpOAVastnZFr
         U/bWSVWImlEfBSoCxh/riK0CLPOO4n0IBuLtKm/qQK1xbgLAA5+zZJ/oKTRJrGqjRSAB
         yFfPFir8b6QCrZTlwE++RDVkMHGVNjSeMekmf9rxYI0fiTq3aS1WH7EMbFz+1dHk+tJi
         43pAYx0KpF+pybuLgt4/CBbP8HMriMLx6Wx8bouc3bRBvA+lXd3VuBcUv19/aNkOZMwE
         faJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxanLLgJw6l0LWQXcf7/GjCDecn9EyhVgm1EHLXQUJI=;
        b=pogg0l7UXx4FDgDf2jTh00gIqaGh1FMdTr6jJ3HRijmgy/ghSo4o7d8h7zEVlit3Cg
         lHGQYJo7ZXRTRT3Togd8UV+jJMKvDQYyv42efIJKUh54oVn2cuqdBJdA6XcegogffDM2
         1f1ptZx7YmLYZXngLJ+oBAaKEZfTkQHoRTcm6x7APWYgrBF4+jlrtPAAHZUiHsuZFGmY
         8sLJLPjZ/fvN4q6mV2Q0mhkpKOXA+tAqni2x8weTgZJdqEV1oxvtwc8fB9Lp9t7OoLHw
         NZuZ8nNdP5Q8VrKICbKO2yLTMEtL46to7r6enSii0CAOyX609C7eiEJ2AsUaAHxbBFM3
         MGQw==
X-Gm-Message-State: AFqh2kr3YUBtH207mmR6msVLZPlATNHHB8+flijLVb6mSQWu+ogcicsz
        71phEkmtEJ3vber45W2lbzsoXkMXXqo=
X-Google-Smtp-Source: AMrXdXuBh+Tr0aTXLV4bhB0YYX7VUSETt0VdJKjkoFk6Gw2FPEtcJpyfTdhIwbMYzoci/Ghn8bMK5Q==
X-Received: by 2002:a05:600c:4a27:b0:3da:fae5:7e2f with SMTP id c39-20020a05600c4a2700b003dafae57e2fmr12768051wmp.3.1674190576379;
        Thu, 19 Jan 2023 20:56:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c021100b003dafb0c8dfbsm1225361wmi.14.2023.01.19.20.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 20:56:16 -0800 (PST)
Message-Id: <a0f8f5fac1c3f79cd46b943e95636728677dffef.1674190573.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com>
References: <pull.1466.git.1674106587550.gitgitgadget@gmail.com>
        <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Jan 2023 04:56:12 +0000
Subject: [PATCH v2 1/2] rebase: remove completely useless -C option
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The `-C` option to rebase was introduced with 67dad687ad ("add -C[NUM]
to git-am", 2007-02-08).  Based on feedback on the patch, the author
added the -C option not just to git-am but also to git-rebase.  But did
it such that the option was just passed through to git-am (which passes
it along to git-apply), with no corresponding option to format-patch.

As per the git-apply documentation for the `-C` option:
    Ensure at least <n> lines of surrounding context match...When fewer
    lines of surrounding context exist they all must match.

The fact that format-patch was not passed a -U option to increase the
number of context lines meant that there would still only be 3 lines of
context to match on.  So, anyone attempting to use this option in
git-rebase would just be spinning their wheels and wasting time.  I was
one such user a number of years ago.

Since this option can at best waste users time and is nothing more than
a confusing no-op, and has never been anything other than a confusing
no-op, and no one has ever bothered to create a testcase for it that
goes beyond option parsing, simply excise the option.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt           | 9 ---------
 builtin/rebase.c                       | 9 +--------
 t/t3406-rebase-message.sh              | 7 -------
 t/t3422-rebase-incompatible-options.sh | 1 -
 4 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f9675bd24e6..412887deda7 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -416,14 +416,6 @@ include::rerere-options.txt[]
 	Allows the pre-rebase hook to run, which is the default.  This option can
 	be used to override `--no-verify`.  See also linkgit:githooks[5].
 
--C<n>::
-	Ensure at least `<n>` lines of surrounding context match before
-	and after each change.  When fewer lines of surrounding
-	context exist they all must match.  By default no context is
-	ever ignored.  Implies `--apply`.
-+
-See also INCOMPATIBLE OPTIONS below.
-
 --no-ff::
 --force-rebase::
 -f::
@@ -631,7 +623,6 @@ The following options:
 
  * --apply
  * --whitespace
- * -C
 
 are incompatible with the following options:
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 1481c5b6a5b..ace8bd4a41c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1067,8 +1067,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			 N_("ignore author date and use current date")),
 		OPT_HIDDEN_BOOL(0, "ignore-date", &options.ignore_date,
 				N_("synonym of --reset-author-date")),
-		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
-				  N_("passed to 'git apply'"), 0),
 		OPT_BOOL(0, "ignore-whitespace", &ignore_whitespace,
 			 N_("ignore changes in whitespace")),
 		OPT_PASSTHRU_ARGV(0, "whitespace", &options.git_am_opts,
@@ -1390,12 +1388,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (!strcmp(option, "--whitespace=fix") ||
 		    !strcmp(option, "--whitespace=strip"))
 			allow_preemptive_ff = 0;
-		else if (skip_prefix(option, "-C", &p)) {
-			while (*p)
-				if (!isdigit(*(p++)))
-					die(_("switch `C' expects a "
-					      "numerical value"));
-		} else if (skip_prefix(option, "--whitespace=", &p)) {
+		else if (skip_prefix(option, "--whitespace=", &p)) {
 			if (*p && strcmp(p, "warn") && strcmp(p, "nowarn") &&
 			    strcmp(p, "error") && strcmp(p, "error-all"))
 				die("Invalid whitespace option: '%s'", p);
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index ceca1600053..c8dca845dd7 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -78,13 +78,6 @@ test_expect_success 'rebase --onto outputs the invalid ref' '
 	test_i18ngrep "invalid-ref" err
 '
 
-test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
-	test_must_fail git rebase -Cnot-a-number HEAD 2>err &&
-	test_i18ngrep "numerical value" err &&
-	test_must_fail git rebase --whitespace=bad HEAD 2>err &&
-	test_i18ngrep "Invalid whitespace option" err
-'
-
 write_reflog_expect () {
 	if test $mode = --apply
 	then
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index 6dabb05a2ad..ebcbd79ab8a 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -63,6 +63,5 @@ test_rebase_am_only () {
 }
 
 test_rebase_am_only --whitespace=fix
-test_rebase_am_only -C4
 
 test_done
-- 
gitgitgadget

