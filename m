Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08EEC20A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 23:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbeLGXyt (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 18:54:49 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:49531 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGXys (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 18:54:48 -0500
Received: by mail-pl1-f201.google.com with SMTP id v12so3853706plp.16
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 15:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cc3kru8ux31P+oWpr5+lj/FGTffzPrTb7rPkrwpsBIE=;
        b=E071rlr31XTJQcmPEvFrRKWIujL2uh5/AHITJMdAFRcz5aqTtsq/QTFq9HNivfMJyA
         WBbzLsq23kUVPBLwBj0MDI4Q03E9hL+u0q/TPBdliehbzndU0HhDQLX2rlXS5Z0AqtEl
         5//FRpBBnYnAL0TULa8tHibKVlfmCcFlAxxx1rPMtwKmKlmGEbN76w5jtcmswfmyMCvp
         j5NHwXS17ey1KyT75UgxTvKLEIe132+lvJLRGCixBzVtWd0NESzcT2d4lL7fsu3oXHdc
         AQH/rf01x3tqEuDYYkOIRw+8A6qezyxth0jXr6sMAQJupyMdmd+rnvWOSD2i1N/Bkj0h
         rjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cc3kru8ux31P+oWpr5+lj/FGTffzPrTb7rPkrwpsBIE=;
        b=EpAU6/JPzgDySUSGKg9EPoLhdqJZQBHqFfljR0Iv4GyYq9pZTt/dAcHeAkgvvRP6m6
         LNjZvklc4zGXhlEVUMGhxsa1wdJctcDkONtYMGl7gbNLKaD/hq/fRvmfQ4DIO3wewFXQ
         onBD5Irk11HSEv9VduGiJRRrv+UgPAqk4uS0mamrCW7hPVNM4alz078JDit8MnRZn7Ho
         BdNGe2KIsu+ifBDZK5qymOke+gDTLkJJlH1+ZAmgZOSozPMU+Y5CK3cA6hojhOXw3XAP
         D+M51CfDuaWNsihAvQMKJcqn5paK8QZp8qrGZdb959pc86Ubf2UMEyKKuSflOVM8IHLJ
         ngig==
X-Gm-Message-State: AA+aEWbL+ikqmv0M+IJaZs41/P8ygRTNk7SvUnpCs7ybR1n6OJOxf/Vq
        SqpBVBKRuSazaoKtMWmKn7zfB03dXuzJdgLVC4H6id0cDsyplRwz1TTJSOtgDyo7s767QjxxDPP
        l6FriGCNc6NKEzIbCrUL8utFYTH2sI3bUum25IFrZxJgeBKwKlhaL1+ItjFd1
X-Google-Smtp-Source: AFSGD/XM4EENAfk6KIshEihJYNmEEVRPcAlgimooRXT7CJLJ5JsFRChEnL+Hg9YLDRXBQvN4cgvLJXTlDGss
X-Received: by 2002:a65:520d:: with SMTP id o13mr2122130pgp.7.1544226888093;
 Fri, 07 Dec 2018 15:54:48 -0800 (PST)
Date:   Fri,  7 Dec 2018 15:54:25 -0800
In-Reply-To: <20181207235425.128568-1-sbeller@google.com>
Message-Id: <20181207235425.128568-5-sbeller@google.com>
Mime-Version: 1.0
References: <20181207235425.128568-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH 4/4] submodule deinit: unset core.worktree
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This re-introduces 984cd77ddb (submodule deinit: unset core.worktree,
2018-06-18), which was reverted as part of f178c13fda (Revert "Merge
branch 'sb/submodule-core-worktree'", 2018-09-07)

The whole series was reverted as the offending commit e98317508c
(submodule: ensure core.worktree is set after update, 2018-06-18)
was relied on by other commits such as 984cd77ddb.

Keep the offending commit reverted, but its functionality came back via
4d6d6ef1fc (Merge branch 'sb/submodule-update-in-c', 2018-09-17), such
that we can reintroduce 984cd77ddb now.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 2 ++
 t/lib-submodule-update.sh   | 2 +-
 t/t7400-submodule-basic.sh  | 5 +++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 31ac30cf2f..672b74db89 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1131,6 +1131,8 @@ static void deinit_submodule(const char *path, const char *prefix,
 		if (!(flags & OPT_QUIET))
 			printf(format, displaypath);
 
+		submodule_unset_core_worktree(sub);
+
 		strbuf_release(&sb_rm);
 	}
 
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 51d4555549..5b56b23166 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -235,7 +235,7 @@ reset_work_tree_to_interested () {
 	then
 		mkdir -p submodule_update/.git/modules/sub1/modules &&
 		cp -r submodule_update_repo/.git/modules/sub1/modules/sub2 submodule_update/.git/modules/sub1/modules/sub2
-		GIT_WORK_TREE=. git -C submodule_update/.git/modules/sub1/modules/sub2 config --unset core.worktree
+		# core.worktree is unset for sub2 as it is not checked out
 	fi &&
 	# indicate we are interested in the submodule:
 	git -C submodule_update config submodule.sub1.url "bogus" &&
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 76a7cb0af7..aba2d4d6ee 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -984,6 +984,11 @@ test_expect_success 'submodule deinit should remove the whole submodule section
 	rmdir init
 '
 
+test_expect_success 'submodule deinit should unset core.worktree' '
+	test_path_is_file .git/modules/example/config &&
+	test_must_fail git config -f .git/modules/example/config core.worktree
+'
+
 test_expect_success 'submodule deinit from subdirectory' '
 	git submodule update --init &&
 	git config submodule.example.foo bar &&
-- 
2.20.0.rc2.403.gdbc3b29805-goog

