Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC22C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiJLJf2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiJLJfW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:35:22 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C190942E4D
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:35:19 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n12so25347257wrp.10
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ym2AjMjoUDx0dWGfr7DyY/Iq92p8LkDIY83/P8cBkhI=;
        b=Lsa/T42Ef1j8H3IXVg84PXAQUqExoSdIXnzmRQRw42ip88weE3YmdjPVuagqoMeqHY
         5aPbkshhXhp9bm3u9LsXQoJwiZnfPoAqOpmhLlk8yK5pobkL30kA0K5XIvqiqKSOm1Nv
         VcRMq2BuqRrPvG5/p6eWnI8Q1xow11+2cED1+QOeIyTtMamplIfXswXzIooIwf4YUI+K
         Y/xAOuEL1qyRZCc6jU2bVqNceV3noRQQy6/C6iCljzDAoSGwU9T0gaQ9V3/vbDj57tKq
         0IQrAQGcfwJXhrhQ2AHWBOj/cE5a8yO81U2IxrFKliFORrGrzdPeq1jwdMsX5m9yyijj
         EPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ym2AjMjoUDx0dWGfr7DyY/Iq92p8LkDIY83/P8cBkhI=;
        b=o/EfA3HaZ5xrRxjx4ocTKbCzu0hEb2FQJ/zpGQwm3DRePv1J4nmbgxzpX+gwNg7K+I
         pF04C/BIpcvHOvb1sPilQuCZOQs2ehCMZ4plk9O1DRzfX4E9gq5qhGInRdmMZ0RoVIbR
         o+L6ibe+Ruk/ECIOdHeslch+bvmVRk90p6WVBW1KwulG76rUonwLbHC+fzWc4aRQ56lW
         Kq042vmmD+xkYpAsl2fPLjSV0MTrn2IlvF2obXJqTHEWUvM2RBFYjmtqWkTyz9Bl45yv
         MoAeFrD/CL1kgTRmZa2ANxD0jGLqVvlJ/HMmRCpMf3Xwd/FfRaLoC3z5CiS7gL+el8ae
         L4KQ==
X-Gm-Message-State: ACrzQf0chCJ1MArGgVx8GswDHxJN4D5Qc6otYUuDoS9yDJfK2g6SjXQW
        WjYkmYXgYi5ZhAq3JOGwZlodARCXQc0=
X-Google-Smtp-Source: AMsMyM4Iu6kv7iNAiQdLi9cpGTP2gNbC3mataG/wR9XSePI/JZeYLKTyJVWMonizDq8UOG1f2oJeAA==
X-Received: by 2002:a5d:47a8:0:b0:231:ca77:ac57 with SMTP id 8-20020a5d47a8000000b00231ca77ac57mr2775587wrb.384.1665567318029;
        Wed, 12 Oct 2022 02:35:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g13-20020adfe40d000000b0022e3d7c9887sm12922543wrm.101.2022.10.12.02.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:35:17 -0700 (PDT)
Message-Id: <225ff4baef75e5a8429608d174cde8ff6edb0ccc.1665567312.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
References: <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
        <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 09:35:08 +0000
Subject: [PATCH v3 4/8] rebase --merge: fix reflog message after skipping
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The reflog message for every pick after running "rebase --skip" looks
like

	rebase (skip) (pick): commit subject line

Fix this by not appending " (skip)" to the reflog action.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c          |  2 --
 t/t3406-rebase-message.sh | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 488e6bdfd3e..9a40a5e27f8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1297,8 +1297,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
 		options.action = "skip";
-		set_reflog_action(&options);
-
 		rerere_clear(the_repository, &merge_rr);
 		string_list_clear(&merge_rr, 1);
 		ropts.flags = RESET_HEAD_HARD;
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 3ca2fbb0d59..8aa6a79acc1 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -163,6 +163,30 @@ test_reflog () {
 	# check there is only one new entry in the branch reflog
 	test_cmp_rev fast-forward@{1} X
 	'
+
+	test_expect_success "rebase $mode --skip reflog${reflog_action:+ GIT_REFLOG_ACTION=$reflog_action}" '
+	git checkout conflicts &&
+	test_when_finished "git reset --hard Q" &&
+
+	(
+		if test -n "$reflog_action"
+		then
+			GIT_REFLOG_ACTION="$reflog_action" &&
+			export GIT_REFLOG_ACTION
+		fi &&
+		test_must_fail git rebase $mode main &&
+		git rebase --skip
+	) &&
+
+	git log -g --format=%gs -4 >actual &&
+	write_reflog_expect <<-EOF &&
+	${reflog_action:-rebase} (finish): returning to refs/heads/conflicts
+	${reflog_action:-rebase} (pick): Q
+	${reflog_action:-rebase} (pick): P
+	${reflog_action:-rebase} (start): checkout main
+	EOF
+	test_cmp expect actual
+	'
 }
 
 test_reflog --merge
-- 
gitgitgadget

