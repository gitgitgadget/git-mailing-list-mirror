Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83029C47083
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 04:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BBC06115B
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 04:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhFDEmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 00:42:39 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:40684 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhFDEmh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 00:42:37 -0400
Received: by mail-wr1-f45.google.com with SMTP id y7so3270887wrh.7
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 21:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XJWwrTaPfgFkCZo4Cm8cocXwUYXasDT0h+1blPw6uCw=;
        b=oUOZ1egfc6UCcvS0T9qiQzrUxJqWIB/fuqSsi4hPRON1HKN2Ar6Ey1kKvmJ9mwVWvQ
         OK1RQcyEKu2g41qYxxIrHVvlAyjpShPxuj1pXEOybfDdIzsmPYRPs0yEXgQHwnR19eWB
         BxlpqjFAuXeDScUi3NrnYP8RIcNxRXPASMEqNAiGMdl7qvZ5qn6HRnLIxdFU7/LBcxjJ
         wI7I6v6OAR3/t9Jj402BFk68XlTq98/U0T+DKakU3xXvnbbW6p867PlrLiUICQ9jSKtU
         D0Ec6dGxko5nf/wJmdSGxD+XY2rwwxvn2mQVOQyJvmQzT9WD7w2UWfv/PVDiQPa+7ZIU
         ZhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XJWwrTaPfgFkCZo4Cm8cocXwUYXasDT0h+1blPw6uCw=;
        b=tnZdLcGqyUpbBm1hksxRWeqU2McfHHaP2CVkQqTX6MSGhzDgEPS+W+t/DeZRfvfmys
         mBj7v5wDOWsQfiuR4A1akZUJ7ZzC5iQYq0QppCexFDM3DPXA4JUiWCa6hUCb2dXhsewx
         g+ZAp2K0wg9ZaY5lXo0Y1ulpXO9Tw9Hk0E0n/MhglFxsxQf37+Eln9CMDm+lXJBSexjv
         FWjkSOIN6Yh8OPuChcn8s1AvAdwzwxNBOeyvdJY0WllDfPgxumv5Km2WCqN0nj1iufOa
         g8SYQyuUH6eGD0fIDNTFDnrZwFYR6xkZtuwKhfF0/PR+jass8lXSpPI8kAFwxyVSx/wU
         tVPA==
X-Gm-Message-State: AOAM532uCbcMsV/fb7TH3QTU6DawW8Ao5QSZ9y4NDOYl4NMSpph5iSTn
        /v4rpdBxO29Z9mgddCSJVDPx9CKH+nY=
X-Google-Smtp-Source: ABdhPJzEnvY1/33O+o00zLNug0ET0NobpOm9n7xJfYjTMmsI6vhXzxq6WWvWnq6hjokRrUFKe+BeTw==
X-Received: by 2002:a5d:4d05:: with SMTP id z5mr1589645wrt.127.1622781582319;
        Thu, 03 Jun 2021 21:39:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f5sm5864483wrf.22.2021.06.03.21.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 21:39:42 -0700 (PDT)
Message-Id: <01352fcdf3a96480ffa4e25a103a83a9e5d7f67a.1622781578.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.962.v3.git.1622781578.gitgitgadget@gmail.com>
References: <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
        <pull.962.v3.git.1622781578.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Jun 2021 04:39:38 +0000
Subject: [PATCH v3 4/4] merge-ort: miscellaneous touch-ups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Add some notes in the code about invariants with match_mask when adding
pairs.  Also add a comment that seems to have been left out in my work
of pushing these changes upstream.

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Derrick Stolee <dstolee@microsoft.com>
---
 merge-ort.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 2ec382e292a6..cfa751053b01 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -765,6 +765,7 @@ static void add_pair(struct merge_options *opt,
 	int names_idx = is_add ? side : 0;
 
 	if (is_add) {
+		assert(match_mask == 0 || match_mask == 6);
 		if (strset_contains(&renames->cached_target_names[side],
 				    pathname))
 			return;
@@ -772,6 +773,8 @@ static void add_pair(struct merge_options *opt,
 		unsigned content_relevant = (match_mask == 0);
 		unsigned location_relevant = (dir_rename_mask == 0x07);
 
+		assert(match_mask == 0 || match_mask == 3 || match_mask == 5);
+
 		/*
 		 * If pathname is found in cached_irrelevant[side] due to
 		 * previous pick but for this commit content is relevant,
@@ -3477,6 +3480,8 @@ static void process_entry(struct merge_options *opt,
 	 */
 	if (!ci->merged.clean)
 		strmap_put(&opt->priv->conflicted, path, ci);
+
+	/* Record metadata for ci->merged in dir_metadata */
 	record_entry_for_tree(dir_metadata, path, &ci->merged);
 }
 
-- 
gitgitgadget
