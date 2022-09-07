Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134CCC54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 14:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiIGOiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 10:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiIGOiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 10:38:09 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC0F78595
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 07:38:03 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k9so20750101wri.0
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 07:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=gz8Q6j9kb9vhYj1GfcqE2ha6v900eQwAd3kfKvvXRpw=;
        b=LXx73Bn/ExKPjWQZJVPRW/HdPF8XQ7EeFrpLeKbYJBP5pF8gyqxqnvNpWoRAaGJQ96
         Ka/KnXuYyP1usjrMFj1nnAPFz1kpW7BKsDxLaln9nvc5MaufDdHiXcaZG5zjecM5k9F9
         xPSgJ5nz+Fk5XFUQtX1k5Leh6WRf46X8BrJiImmjlVS748OOm94WcLuNJ/OW6Ge1V6Kn
         hxvtdnTPFQ3e4X6u+4lW/8v9XEmpIphk3CfTfHcATrFsnmsI2TC4Wv/yf5Ro6vlnH8EX
         9WblLPi8rmUfDaNAyzAipVgZIlHxDsJYKfOcPqM8svR8Djp9rand/Ja3bN0mVHahM4me
         BbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gz8Q6j9kb9vhYj1GfcqE2ha6v900eQwAd3kfKvvXRpw=;
        b=QYCATfxcBujXqZ6vN/1sHD8nlmUesMDfVkgq0blDg4Vbi6bKvm93fdWAkL43Uwb2xP
         LmBmiOvBH4Q1TMCxA5f1mM97Gdbotod1DkV6QoTWakegUrObIOK+P5FWTkTJwx2dLo/I
         WepI/0stIumKVZ3u6gtF6LKM4yA8DLHTkPA624o4TfGtvd/2lyEuj2prNk6E7WBJy7QY
         mryqocoNOx9+DFy9SSVi/EEs+l3d10wwOe6S4rtq4u4BvANhSZlN+1+5lzMboFqcyoy3
         cjjJrOAE0x9Dd+YU2Zv4ICVuWwSerC6s6d+uNvUNRjHCfMI3CVC949hOHuFDMiDGa/3m
         zMFg==
X-Gm-Message-State: ACgBeo3dkTz1UKKjOzCVcZjTJfia/i1OeCN9UWEFcG1S3Iu/oVVhQkoA
        sir5hIdHQLLjrNGG/hIWhYq7E+GKCyI=
X-Google-Smtp-Source: AA6agR7bECvPH3rYEohsWG0tAjzu/5PLJCVjCuNHdmECidEf+tWoeu6E2BpCL8/fE8wRFexWGs5vaQ==
X-Received: by 2002:a05:6000:912:b0:229:9bc1:27ed with SMTP id bz18-20020a056000091200b002299bc127edmr1501927wrb.546.1662561481462;
        Wed, 07 Sep 2022 07:38:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c3b9300b003a846a014c1sm27798621wms.23.2022.09.07.07.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 07:38:00 -0700 (PDT)
Message-Id: <6410b101d7f4ad97f87faec93703370a0493aa4a.1662561470.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
        <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Sep 2022 14:37:50 +0000
Subject: [PATCH v2 7/7] rebase --keep-base: imply --no-fork-point
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Given the name of the option it is confusing if --keep-base actually
changes the base of the branch without --fork-point being explicitly
given on the command line.

The combination of --keep-base with an explicit --fork-point is still
supported even though --fork-point means we do not keep the same base
if the upstream branch has been rewound.  We do this in case anyone is
relying on this behavior which is tested in t3431[1]

[1] https://lore.kernel.org/git/20200715032014.GA10818@generichostname/

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-rebase.txt | 8 ++++----
 builtin/rebase.c             | 6 ++++++
 t/t3431-rebase-fork-point.sh | 2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index ee6cdd56949..1e2d543ced9 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -218,7 +218,7 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 	merge base of `<upstream>` and `<branch>`. Running
 	`git rebase --keep-base <upstream> <branch>` is equivalent to
 	running
-	`git rebase --reapply-cherry-picks --onto <upstream>...<branch> <upstream> <branch>`.
+	`git rebase --reapply-cherry-picks --no-fork-point --onto <upstream>...<branch> <upstream> <branch>`.
 +
 This option is useful in the case where one is developing a feature on
 top of an upstream branch. While the feature is being worked on, the
@@ -452,9 +452,9 @@ When `--fork-point` is active, 'fork_point' will be used instead of
 <branch>` command (see linkgit:git-merge-base[1]).  If 'fork_point'
 ends up being empty, the `<upstream>` will be used as a fallback.
 +
-If `<upstream>` is given on the command line, then the default is
-`--no-fork-point`, otherwise the default is `--fork-point`. See also
-`rebase.forkpoint` in linkgit:git-config[1].
+If `<upstream>` or `--keep-base` is given on the command line, then
+the default is `--no-fork-point`, otherwise the default is
+`--fork-point`. See also `rebase.forkpoint` in linkgit:git-config[1].
 +
 If your branch was based on `<upstream>` but `<upstream>` was rewound and
 your branch contains commits which were dropped, this option can be used
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 204155bb25b..3065e6f082b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1239,6 +1239,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			die(_("options '%s' and '%s' cannot be used together"), "--keep-base", "--onto");
 		if (options.root)
 			die(_("options '%s' and '%s' cannot be used together"), "--keep-base", "--root");
+		/*
+		 * --keep-base defaults to --no-fork-point to keep the
+		 * base the same.
+		 */
+		if (options.fork_point < 0)
+			options.fork_point = 0;
 	}
 	/*
 	 * --keep-base defaults to --reapply-cherry-picks to avoid losing
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 1d0b15380ed..70e81363569 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -50,7 +50,7 @@ test_rebase () {
 
 test_rebase 'G F E D B A'
 test_rebase 'G F D B A' --onto D
-test_rebase 'G F B A' --keep-base
+test_rebase 'G F C B A' --keep-base
 test_rebase 'G F C E D B A' --no-fork-point
 test_rebase 'G F C D B A' --no-fork-point --onto D
 test_rebase 'G F C B A' --no-fork-point --keep-base
-- 
gitgitgadget
