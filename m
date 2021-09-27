Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC46BC433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E0C6103B
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbhI0QgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 12:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbhI0Qfl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 12:35:41 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA980C061770
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:33:55 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id b204-20020a1c80d5000000b0030cd967c674so351829wmd.0
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HTuOzR5JByGoTcKS7MpQdfwDOj0Z8IxDv5TAv4cmJYc=;
        b=a7PTa8xMtAQyXXySo6GcHMLSwYdmw7BmUcA//m650VFiQSP83GAgNH1fuZ/ghFHUq/
         SlFxtsGReJUV3Tf7vM00jzF+hV6tuvhNul+DqMhlSPZXTHtyBOOXZQOLvWmktpoVwr7M
         5S/TUgEOFt+JWF9wLPGAmM1V4uy+3k/W65i7K14//V3hSgySDYTfjFr77V6eBd2AyUmF
         gZ1HNxr+J7Z2ukfNHGEeXAno92CJ1UDSzV1yVBr5jHXTuErcZN/WNpebolGriI+4nWZE
         8miME7k5N7642wZr8MP8OXC2Hv3DltCWz7PZIUL6Y3jpXTAmdZPBpz2dJejzh9Wi7Xn4
         xj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HTuOzR5JByGoTcKS7MpQdfwDOj0Z8IxDv5TAv4cmJYc=;
        b=doogsHUYhJ22hb9dW8vKoE12omYt/jVBUHZffRUd6StohuVbJxSQZTwKSNg0eS0bGo
         3rLuUJ38TT4btrLG6q0sbrqccvX0502LRV7BbhWDFdIWYomWCtm2HNw+o8S+bw+QxnTN
         EypWlD2d6jmANr/Pop8vCJG6izoMMmTd30LNoFanR6JFBFqLvYO3IHA64aTdcGpOewzM
         2nP+0f1Ddnx2f/fm2ChdO+QhEmwO1Yaik8kkW+ikgf0l1HeCV5O7IEID604ywWyrM8bg
         ownJ3uXSm7w0QrmsphcW14wDXjL2ZhkMUMChN+TN9iX7zctKvdune4wz1KOmIoKKF2A8
         HnNw==
X-Gm-Message-State: AOAM532zGOLoZjp2PeXneYTNAJmmKiH+K2PdMftjjXzt4PfNSwEST2UG
        1nh+THXkbyEHXXwXl7UCR82ieXSlmDA=
X-Google-Smtp-Source: ABdhPJyhGShoUcaD0ZNNtEZ+nxYicCi3VjSktn3bZ0TbWwWXJEJm+AfmP0hgIlmf4FtMwxP1mZXitQ==
X-Received: by 2002:a1c:f703:: with SMTP id v3mr13172400wmh.177.1632760434652;
        Mon, 27 Sep 2021 09:33:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm15795498wmb.41.2021.09.27.09.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:33:54 -0700 (PDT)
Message-Id: <1a770681704691e32722f1abbe292e8523c7f455.1632760428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
        <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Sep 2021 16:33:46 +0000
Subject: [PATCH v3 09/11] unpack-trees: avoid nuking untracked dir in way of
 locally deleted file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t2500-untracked-overwriting.sh | 2 +-
 unpack-trees.c                   | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t2500-untracked-overwriting.sh b/t/t2500-untracked-overwriting.sh
index 5ec66058cfc..5c0bf4d21fc 100755
--- a/t/t2500-untracked-overwriting.sh
+++ b/t/t2500-untracked-overwriting.sh
@@ -218,7 +218,7 @@ test_expect_success 'git am --abort and untracked dir vs. unmerged file' '
 	)
 '
 
-test_expect_failure 'git am --skip and untracked dir vs deleted file' '
+test_expect_success 'git am --skip and untracked dir vs deleted file' '
 	test_setup_sequencing am_skip_and_untracked &&
 	(
 		cd sequencing_am_skip_and_untracked &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 080118f2325..a7e1712d236 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2411,7 +2411,10 @@ static int deleted_entry(const struct cache_entry *ce,
 		if (verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_REMOVED, o))
 			return -1;
 		return 0;
+	} else if (verify_absent_if_directory(ce, ERROR_WOULD_LOSE_UNTRACKED_REMOVED, o)) {
+		return -1;
 	}
+
 	if (!(old->ce_flags & CE_CONFLICTED) && verify_uptodate(old, o))
 		return -1;
 	add_entry(o, ce, CE_REMOVE, 0);
-- 
gitgitgadget

