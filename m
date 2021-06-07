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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA5EC47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 16:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E90060FEF
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 16:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhFGRA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 13:00:58 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:36846 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhFGRA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 13:00:57 -0400
Received: by mail-wm1-f45.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so124345wmk.1
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 09:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rlU16Argot/ypcOGcNIltKha5884Rr4csMMq3SHgObo=;
        b=YWTSuIQvDjKxRvIW9uhuIVnMXgzRoWkqNRH9gQY9uYZ5f2oHosFsNDJxvtAPILPB48
         TGCQxsQO/BkTMSHwcbTLvHP0Wx0hpwO9HdZYglW9tjiAiQ8wYO0UycbLaTvtgw3BuIam
         z9zUDWzGY/FQzbOuJtXN1obabOSiAmTr2312OVoqCDjEH3kHBNIFO375Jvt7Eq2ahLOA
         sZ9f6S5KL+L2Tr4gIcKa5F5K5kK0FZH+YVRfR+rae4R8dWKS8UTKVQC++oEFvjv07764
         5cXGAepE6vmkFr9M485MQ8seUWKfwzwldeERgVky78ZBq0q7aCoH/UCT7XEh4sBDeju1
         lDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rlU16Argot/ypcOGcNIltKha5884Rr4csMMq3SHgObo=;
        b=b1l3+FPq15wg6ahjYzNI/o/s5sfvTB4yMeT3I36izr+Ovub4teS5MLxz1jiimEVgRo
         6ZwKKYCcbSS8vyMvx6qUquY4LQ22od3Bwn71pOqhJgGh6XLn3wHXkgHh9ucKIX381CW1
         JxVH3QsT2XC3DmE3rhmMk+aHMZWWNPutPzNwLWlNxe2iPWkxs48TDPcAImuM57qkyf0g
         fjd5ytJLQ/tkgYm2Dw0kL9Nol1GeI7AVjMGxLS9EIvu+LyWzoVUaufhyyt207+OzKGT6
         SeXYG9I7wBVlym0Z2HU0Q4kMHzXL98YZbMzfKRa0HeSYqcTr9ERjkmBEuHZ+Ib5rXHy2
         P3dg==
X-Gm-Message-State: AOAM532/+x+TjlbTGWF3zfwKz3DgNl0yAXzduswRBLmw7GtxIKre9Z59
        LwkEPhqy11V6E+Bg1Hybn7M3Wo6LIeU=
X-Google-Smtp-Source: ABdhPJyHmWhNUQXMprpOCl+nGyD0Bnoth9wV9sJghXg7sgF200gFi4Y3w4ALsvj1AV1BVtBum515QA==
X-Received: by 2002:a05:600c:2248:: with SMTP id a8mr18227867wmm.5.1623085072206;
        Mon, 07 Jun 2021 09:57:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a16sm14621452wmm.3.2021.06.07.09.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 09:57:51 -0700 (PDT)
Message-Id: <c40ad4a058a75d57adc97b8252ad0f57600b8d86.1623085069.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.975.git.1623085069.gitgitgadget@gmail.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Jun 2021 16:57:47 +0000
Subject: [PATCH 3/4] *: fix typos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

These typos were found while searching the codebase for gendered
pronouns.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 config.c               | 2 +-
 t/t9300-fast-import.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index f9c400ad3062..7bb96f8f7124 100644
--- a/config.c
+++ b/config.c
@@ -2837,7 +2837,7 @@ static void maybe_remove_section(struct config_store_data *store,
 	begin = store->parsed[i].begin;
 
 	/*
-	 * Next, make sure that we are removing he last key(s) in the section,
+	 * Next, make sure that we are removing the last key(s) in the section,
 	 * and that there are no comments that are possibly about the current
 	 * section.
 	 */
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 5c47ac4465cb..7039b5c6028d 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1538,7 +1538,7 @@ test_expect_success 'O: comments are all skipped' '
 	commit refs/heads/O1
 	# -- ignore all of this text
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	# $GIT_COMMITTER_NAME has inserted here for his benefit.
+	# $GIT_COMMITTER_NAME has inserted here for this benefit.
 	data <<COMMIT
 	dirty directory copy
 	COMMIT
-- 
gitgitgadget

