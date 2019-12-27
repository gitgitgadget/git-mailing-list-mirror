Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FF7C2D0C6
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 18:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4204520722
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 18:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyo2EKut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfL0Srx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 13:47:53 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35553 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfL0Srw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 13:47:52 -0500
Received: by mail-ed1-f67.google.com with SMTP id f8so26130795edv.2
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 10:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SA9Pe/NQ7Vek/Vj0ZABDpV+B4AD+1eXcvdh9cCxQpFU=;
        b=qyo2EKutsyuUAcV+L3k6uhjqexao1634kgeXVzPz3Cuq5G/5ahhlJJ/8UZgcW3PTbC
         tX+Ah6w6vkgioujNeH8i6OMGrJdYVJcNqzrP+/M0kutvzDh1iN/ykDBaXQp0TOpNh3IM
         i4MAii9dsJNR5FzJK3NWFqmRoT75ow/LL0mmPgnjtPkFIyDw0FJnmY4kpUxxD3Fi9hMo
         EcG+lISFlD5rWiQhx0Zv3bVvyCiWeRd/one0VnsELNtMqXAN83EgKTc097gMbhqQjkKW
         SiQGo9amjc8FUi/wqLD4V6vooOzvOSlnwNE3ho6li0Tnw//qwZcQ5prENeJVjQJR9fVW
         KxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SA9Pe/NQ7Vek/Vj0ZABDpV+B4AD+1eXcvdh9cCxQpFU=;
        b=W2XF/xMA+0hXhnrld88pzQStKJErl8wUD6+oQJODilclqZAO/3EXyMQPeeUQvOiNax
         v8T2bSsAZE1kYr2azpO31hB7ShibKtbXbyQf1glq1IUX2DMHxl6Kw4rl/1ku9AFMbQSK
         u4bmtCJU1Tt41lN78mA0jqI7LV91g6l9UgqYu6tlxb5hnq5RAxRfQfA3JBaV7wQ7xpAP
         BkOlCM9Oui69qOaoRFasjlCA8Y0D3YHJF2mSLMueVRQ9tYO2FdOUfifuwJZg7aPnC5kX
         ymkk0ERMzYhgNcIaaSF8A51rvkEfihKPPzIxsoUfVtxnZnDLLMxP8U4L1rYrwLdD9w+p
         GLSw==
X-Gm-Message-State: APjAAAV6OwNXQ8GC6MP9p52Iipnr0W68KIjqe/ir/NpmGlvZdX/iAjVZ
        PSB4fiJ9fR+3DYiKklYjQ3nc/rha
X-Google-Smtp-Source: APXvYqziZz/yADul/Z/bx92Ar817Yauo/c6DPSr86VSM2AyLsBPnF/oSOgBjgaiX/AHMqR36UaHG6Q==
X-Received: by 2002:a17:906:ce38:: with SMTP id sd24mr54630025ejb.237.1577472470583;
        Fri, 27 Dec 2019 10:47:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r13sm4202119ejb.27.2019.12.27.10.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Dec 2019 10:47:49 -0800 (PST)
Message-Id: <pull.500.v2.git.1577472469.gitgitgadget@gmail.com>
In-Reply-To: <pull.500.git.1577393347.gitgitgadget@gmail.com>
References: <pull.500.git.1577393347.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Dec 2019 18:47:46 +0000
Subject: [PATCH v2 0/2] sparse-checkout: list directories in cone mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When in cone mode, "git sparse-checkout set" takes a list of folders and
constructs an ordered list of patterns for the sparse-checkout file. The
"git sparse-checkout list" subcommand outputs the contents of the
sparse-checkout file in a very basic way.

This patch changes the behavior of "git sparse-checkout list" when
core.sparseCheckoutCone=true. It will output the folders that were used in
"git sparse-checkout set" to create the patterns, instead of the patterns
themselves.

I believe this was requested in the initial review, but I cannot find that
message now.

I was going to include this as part of a longer follow-up series, but I
think this may be worth considering for the 2.25.0 release. Hence, it is
included by itself.

Update in V2:

 * Fixed typos/word choice in commit message.
   
   
 * Added a second commit including clarification on interactions with
   submodules.
   
   

Thanks, -Stolee

Derrick Stolee (2):
  sparse-checkout: list folders in cone mode
  sparse-checkout: document interactions with submodules

 Documentation/git-sparse-checkout.txt | 21 ++++++++++++++-
 builtin/sparse-checkout.c             | 21 +++++++++++++++
 t/t1091-sparse-checkout-builtin.sh    | 39 +++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 1 deletion(-)


base-commit: 761e3d26bbe44c51f83c4f1ad198461f57029ebd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-500%2Fderrickstolee%2Fsparse-checkout-list-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-500/derrickstolee/sparse-checkout-list-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/500

Range-diff vs v1:

 1:  07be7b8dda ! 1:  d6f4f40486 sparse-checkout: list folders in cone mode
     @@ -3,9 +3,9 @@
          sparse-checkout: list folders in cone mode
      
          When core.sparseCheckoutCone is enabled, the 'git sparse-checkout set'
     -    command taks a list of folders as input, then creates an ordered
     +    command takes a list of folders as input, then creates an ordered
          list of sparse-checkout patterns such that those folders are
     -    recursively included and all sibling blobs along the parent folders
     +    recursively included and all sibling entries along the parent folders
          are also included. Listing the patterns is less user-friendly than the
          folders themselves.
      
 -:  ---------- > 2:  331bb7d6fb sparse-checkout: document interactions with submodules

-- 
gitgitgadget
