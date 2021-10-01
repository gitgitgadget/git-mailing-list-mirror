Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4ECC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C5A6134F
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhJAKHK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353348AbhJAKG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 06:06:57 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD6AC06177E
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 03:05:13 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id j27so6839504wms.0
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 03:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3kTtfa/DmY9ZtEc0Lvb3lNHSoshMcsAlDzPm3Fhv4a4=;
        b=cuV66aC3qcyRAKfaYzAN+AiugWs1a86JbY+T8XyNZfWLQPtiNHly85bDLdaFwpGq4K
         GxQxw6T6jlceBPnDvtUGrFI4DcGh/aY8Ys+KdX9sFj5NBD8sibkeRMW0JaYMdB1hTiiy
         vE8gYkwc5DnwOBo4UPptFtClE1907F+HGUS9qAIcgAX8giORFkpBg8FTiihzhEYftlyz
         AnRUehPxwfGVvTRN31Fed7b5B0EIsQvMqbn3Vlf5vGf3PF+rp+8zD5xYVwYAxXOlb9Oh
         ZLPOrw76bK8esGOWhR12JoT5oyDfge5C6En9vCJyfrLBcntoFpX5HbOMCTsFHrtoQyKA
         d4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3kTtfa/DmY9ZtEc0Lvb3lNHSoshMcsAlDzPm3Fhv4a4=;
        b=JlkyRdrtfQQNAxTDahoiFdZbbjHlPDUicON/mAwub5pYAwGlpDqjqEWBbpVoxc62PN
         WorTzutw/I5Pdx8s4Hm6VT7t5e5VNvcFb0MW/nbYiutS+JmqlaUW61aqauE/N+1gAuTm
         g2OljSO023Xi/A5/1CnLzpcSAfulVIBt4L3Zm2X9J7VLJvvQ64K/NctbpchwZ4xtE2RH
         JK2OMy+gwIyWdZ04Dxb3T9zDPvdBY0z2bpKbLmQMH2sFsrQ0xmzd29EmfjEnB8w4+nh2
         4EKIPwco2TUd+JT/4i2TwlCreRoN3d7mpMekpCFVChUe2M4tvxEWZg7uUzSpKPXakFf7
         WpjA==
X-Gm-Message-State: AOAM5331hLk4h96Hks6ZmM42cd7WGewUd06JunXwDDZ77wobjTettL1b
        5x24zKZPYHnE0fpNIt6NvzJhUrsCVbc=
X-Google-Smtp-Source: ABdhPJylGrGr7GIQUyIaUbhSS5J9r09Zu0qnyVM8g3rubaBipewJlPA0kk5qiSm6ZtV3RZR7gKaQlQ==
X-Received: by 2002:a05:600c:350f:: with SMTP id h15mr3460727wmq.123.1633082708679;
        Fri, 01 Oct 2021 03:05:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17sm5379633wrr.49.2021.10.01.03.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 03:05:08 -0700 (PDT)
Message-Id: <5ffc7e64ff1cb306dc96abf3b0fa65c0662994d8.1633082702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Oct 2021 10:04:58 +0000
Subject: [PATCH 07/11] rebase: cleanup reset_head() calls
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If ORIG_HEAD is not set by passing RESET_ORIG_HEAD then there is no
need to pass anything for reflog_orig_head. In addition to the callers
fixed in this commit move_to_original_branch() also passes
reflog_orig_head without setting ORIG_HEAD. That caller is mistakenly
passing the message it wants to put in the branch reflog which is not
currently possible so we delay fixing that caller until we can pass
the message as the branch reflog.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 1a6af508f49..89b348ffa75 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -881,7 +881,7 @@ static int run_am(struct rebase_options *opts)
 
 		reset_head(the_repository, &opts->orig_head,
 			   opts->head_name, 0,
-			   "HEAD", NULL, DEFAULT_REFLOG_ACTION);
+			   NULL, NULL, DEFAULT_REFLOG_ACTION);
 		error(_("\ngit encountered an error while preparing the "
 			"patches to replay\n"
 			"these revisions:\n"
@@ -2082,7 +2082,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			options.head_name ? options.head_name : "detached HEAD",
 			oid_to_hex(&options.onto->object.oid));
 		reset_head(the_repository, NULL, options.head_name,
-			   RESET_HEAD_REFS_ONLY, "HEAD", msg.buf, NULL);
+			   RESET_HEAD_REFS_ONLY, NULL, msg.buf, NULL);
 		strbuf_release(&msg);
 		ret = finish_rebase(&options);
 		goto cleanup;
-- 
gitgitgadget

