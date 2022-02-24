Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47D5C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 09:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbiBXJqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiBXJqO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 04:46:14 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A4C27DF31
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:45:44 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d3so2069105wrf.1
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CHO3b+gzF10EA/23VddWYWYEc6YiXFZ678veEngIMvY=;
        b=cpGoBsUfNerTDlfuYVgYWKdzoLewwmloRRc91t/tendUpALjw9P4CFcFmMt97T9Iyv
         WtHwPhkGZQndKfCNF+3ZsHx5safKrm17DBOW0E6D6tJIdsZx6OCCbQXiLsJ2bIL/+594
         mP238jU7v2V84Ugsfz9cq0GZqTHGS+RYiebiuxuKHC9vNT/8u+yIDA/aARwaJLhv2ErH
         KdD8txwTXhuAiU78yxaKEcbTDaf/293yX7UM4OlKqkDTdbzbY6nDg1HMNcZDa7HgkbpB
         RoVdssD0T0sROGw7w2E/Uphs0H6/M8KYYTPoa/bIyyeoYUWkvJ5b1wgveEOGuXs6b/da
         R9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CHO3b+gzF10EA/23VddWYWYEc6YiXFZ678veEngIMvY=;
        b=8A2JvnOO9v8tJUNjZnldJ3UVZ2xcyE7M6j9fk32Zs4rU/JD99dP3pXp0iYjbwfjo8S
         hNjp3ioZXML8gQ5UWCePtc9m24s3qhU+lfBnQJcgnpnAiMGq6P88NMQHDlw3CinPibsg
         OB8vEG3ScunOuRIWZI9pdxq4BWF4hmSuLQdhVasQJ558uCsfPP11j3hmFW1iB16E9K2K
         XP9MbYwxTKJ7u7ztbjRX71sYjPM5cZIeepEHXHvEAPM7vs1pzlK/g7VlleogT+js8jVE
         UTasf1qYP93D/TkoDCpAXJaRV42/nq4iBDQ9QD4klau92mYxQfc5hCHPvm2H49byPyDG
         ppfA==
X-Gm-Message-State: AOAM5325pgb4M6QwAuHVqY5TVrrpQiGRe63dUEYi820zhkr97XBiwJrW
        bGeZvPWryk+Lg//UPgQhCO71jqaULj0=
X-Google-Smtp-Source: ABdhPJxyHcvZraSmdlCNew8WMArXyzM28VdI6RFhFMfNM4+6X188aosDaVFm5y9gHvfSPm79CzNXeA==
X-Received: by 2002:a5d:5265:0:b0:1ed:9df7:a09 with SMTP id l5-20020a5d5265000000b001ed9df70a09mr1530709wrc.614.1645695943389;
        Thu, 24 Feb 2022 01:45:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l5sm2172685wmq.7.2022.02.24.01.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:45:43 -0800 (PST)
Message-Id: <3fa56f1d2a0dfbb41df2a38a6b0ea26333915eda.1645695940.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1161.git.1645695940.gitgitgadget@gmail.com>
References: <pull.1161.git.1645695940.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 09:45:39 +0000
Subject: [PATCH 2/3] t3200: tests for new branch.autosetupmerge option
 "simple"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

In the previous commit a new autosetupmerge option was
introduced. Here the existing branch tests are extended
with three new cases testing this option - the obvious
matching-name and non-matching-name cases, and also a
non-matching-ref-type case.

The matching-name case needs to temporarily create
an independent repo to fetch from, as the general
strategy in these tests of using the local repo as
the remote precludes locally branching with the same
name as the "remote".

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 t/t3200-branch.sh | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 7a0ff75ba86..15cc58f1e64 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -886,6 +886,41 @@ test_expect_success 'branch from tag w/--track causes failure' '
 	test_must_fail git branch --track my11 foobar
 '
 
+test_expect_success 'simple tracking works when remote branch name matches' '
+	test_create_repo otherserver &&
+	test_commit -C otherserver my_commit 1 &&
+	git -C otherserver branch feature &&
+	git config branch.autosetupmerge simple &&
+	git config remote.otherserver.url otherserver &&
+	git config remote.otherserver.fetch refs/heads/*:refs/remotes/otherserver/* &&
+	git fetch otherserver &&
+	git branch feature otherserver/feature &&
+	rm -fr otherserver &&
+	test $(git config branch.feature.remote) = otherserver &&
+	test $(git config branch.feature.merge) = refs/heads/feature
+'
+
+test_expect_success 'simple tracking skips when remote branch name does not match' '
+	git config branch.autosetupmerge simple &&
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch my-other local/main &&
+	test -z "$(git config branch.my-other.remote)" &&
+	test -z "$(git config branch.my-other.merge)"
+'
+
+test_expect_success 'simple tracking skips when remote ref is not a branch' '
+	git config branch.autosetupmerge simple &&
+	git tag mytag12 main &&
+	git config remote.localtags.url . &&
+	git config remote.localtags.fetch refs/tags/*:refs/remotes/localtags/* &&
+	(git show-ref -q refs/remotes/localtags/mytag12 || git fetch localtags) &&
+	git branch mytag12 localtags/mytag12 &&
+	test -z "$(git config branch.mytag12.remote)" &&
+	test -z "$(git config branch.mytag12.merge)"
+'
+
 test_expect_success '--set-upstream-to fails on multiple branches' '
 	echo "fatal: too many arguments to set new upstream" >expect &&
 	test_must_fail git branch --set-upstream-to main a b c 2>err &&
-- 
gitgitgadget

