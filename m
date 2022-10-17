Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E1DC433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 13:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiJQNSS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 09:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiJQNSK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 09:18:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF7B4D25B
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:17:56 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bv10so18432204wrb.4
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaHfzcKiw4cPzg+w4ZMcI22KFEYgkOy3WEfS5eM/jPw=;
        b=dFij8rOShyMEn/JKDVhUFGiHdjgAfNAexs3mZYlhZUXyvCmOIQFsNijKW48JJDKax5
         Y9JdZdtNvA/L+O3VDpGJqsHJo6v5dczYFOCyzv9VDin6osQh8hlXqG/pEwjP3GuxSwmK
         1HiM2aZW9BVTHHtLQwZzTIuPnNq4Za1I3wwtAyMEWezS7eJinDEBkkQpwXU+nmjFVvbb
         B6MfVeiPhbzYJxc1y2jXxZemneKfvoygAaIo2+pD+H6gBOFZcUshaX2SJUr/QfRPFPCT
         IcjPhTqUfYdCqbM/Vi50CJYi81onMz4i2MvrN8SBURLItVnXqdSmsLAJvskuiPm/tokZ
         O4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TaHfzcKiw4cPzg+w4ZMcI22KFEYgkOy3WEfS5eM/jPw=;
        b=aDw++ZxYeY8B+oaEYvdei0IzCpBrmsIGFrlajXYgcrSGBoH3D2DSjVcxWiXps4BJYJ
         oMCGu0u4/qAKjy7P+vy6SddIlltNMxcKMQH3he6DuHYf2lM3f48e8D+X3Y4q50n1qaCY
         aduPhc5CN5ymOiqlpq0jO8oRzLGveZB7NuWtZidrQ9Oa2rGtkHpgvPl3/X//NzKH43Vs
         TAMMZFeapGfmanLmir8q1djQV3oms9Qz2/+Fjgg0n5X6z9Rn4gUD9hgEPpYeGEmbzaix
         LNzLjzOxx0Tk5RU4W6glVYFR91VFvPBoHLMXNFHNh9HpWtPyd/tFxfcj2tmSlFBQ3mbl
         FSHQ==
X-Gm-Message-State: ACrzQf063wPqm8+dgrR2gLf7q++U2nm84LPiPbvpdh/xww1Lu5JcIrWv
        PrS0c10lU82MLny91dMA8s/Qk6266H8=
X-Google-Smtp-Source: AMsMyM7LvLrokXJjj0ggBmYiZG9PJ/WJFZA6QCkR6LOVUhk3d1j2SBhAWH8sABJguTLRxuHWww5vVg==
X-Received: by 2002:a05:6000:1541:b0:231:115e:9bb8 with SMTP id 1-20020a056000154100b00231115e9bb8mr6615914wry.51.1666012674369;
        Mon, 17 Oct 2022 06:17:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c314c00b003c3d8a4e47asm10686262wmo.2.2022.10.17.06.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 06:17:53 -0700 (PDT)
Message-Id: <656b9c9dab6f091f02008137f2da0f843882746b.1666012665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.v4.git.1666012665.gitgitgadget@gmail.com>
References: <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
        <pull.1323.v4.git.1666012665.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Oct 2022 13:17:45 +0000
Subject: [PATCH v4 8/8] rebase --keep-base: imply --no-fork-point
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
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
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
index d718b7fe888..b9164a30bff 100644
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
