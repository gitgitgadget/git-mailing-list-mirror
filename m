Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D760C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 20:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241132AbiC2UDP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 16:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241122AbiC2UDI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 16:03:08 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220911AD3A5
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 13:01:25 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u16so26375064wru.4
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 13:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=t7GnSLc+pI6GaxopJymczxyH+mLm0OF8F51/b8HmDrM=;
        b=hlKadGbT1USlDif75kdVQWlSs7TJ5P9qAOilk66TrbZbetWGQg1y5G/Zxp2tAuUA6M
         kjyap9vBWTfR2he/ZzSXFiNCga0aKBdUqRYLbTk3T/OqfygM3tlzwBzw7I8hWtB5xj8F
         iMv5AzOQxySceLZNzbOVyCu8biYOzxr6eG8NA5m+rOPZniHYdP7oh7wBIBO8eD9wWoH9
         6DvdbFitffxbbaQNt3Orm7lJ1HbtFb/6FfI05OSwLx1kLBxWIXnLwUQO7R4Qrz8enPCV
         DN3a/ZCzRzyI9kYtdu/j3h7+CUImjfgvDfDsqwLJFtAPuz1oV8w+29rSTsUJQc0+W2Wn
         SnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=t7GnSLc+pI6GaxopJymczxyH+mLm0OF8F51/b8HmDrM=;
        b=lHKq+AH/RmHCenRncBzm7f6n6Lh8ukm08zxr15n4FvxzGlfhKboCHAX5vOB1ZkS0QW
         x+C80L0Gmk0Cmwv6WG1rzP2bYZmW/J6lcF/TypDkVS4dqIcmfMQOYchf8Ke0jOSOOKhv
         ZKxokXGwhdD4nUqlwPL7jWzqB/PxttpjGuwLHxrNZBM8uA0AZ2AzokYB9PUovcrH5ITo
         ME15da44KMGuNwm9DhcuLUy2gKhD+KvtHMVQxVdKMVek+WUz7fuWcYnx1MYaVmUfZVET
         M+qlsnJKA+GqAdXqe/4mnx/Ses4ez4Ds4xpwUUlKug2EfcIHlXt5qaXS08Yh65S3ZYEO
         +2hw==
X-Gm-Message-State: AOAM531OUvtKzMkfh48lWkYNyrNxY74KVLLg+ytl92gA+hEtho7q3cFW
        1Bp9eTfnGog643LmJ2nFdJ0gQPQYktc=
X-Google-Smtp-Source: ABdhPJwa1vxKL1vb8zLVXtDgHwopxWw1UGoUhYGYNIK+UUnKf6MCEBmr8XKfSrkSianlTIOf34eOPQ==
X-Received: by 2002:a05:6000:2c9:b0:204:1675:843e with SMTP id o9-20020a05600002c900b002041675843emr32903396wry.699.1648584083449;
        Tue, 29 Mar 2022 13:01:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d6d8d000000b00203d77cf7b0sm17598486wrs.74.2022.03.29.13.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 13:01:23 -0700 (PDT)
Message-Id: <8e6ea3478b376b24835f3a3fef7fca39bed0afec.1648584079.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1190.git.1648584079.gitgitgadget@gmail.com>
References: <pull.1190.git.1648584079.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 20:01:18 +0000
Subject: [PATCH 3/4] branch --set-upstream-to: be consistent when advising
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

"git branch --set-upstream-to" behaves differently when advice is
enabled/disabled:

|                 | error prefix | exit code |
|-----------------+--------------+-----------|
| advice enabled  | error:       |         1 |
| advice disabled | fatal:       |       128 |

Make both cases consistent by using die_message() when advice is
enabled (this was first proposed in [1]).

[1] https://lore.kernel.org/git/211210.86ee6ldwlc.gmgdl@evledraar.gmail.com

Signed-off-by: Glen Choo <chooglen@google.com>
---
 branch.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index 133e6047bc6..4a8796489c7 100644
--- a/branch.c
+++ b/branch.c
@@ -389,9 +389,10 @@ static void dwim_branch_start(struct repository *r, const char *start_name,
 	if (get_oid_mb(start_name, &oid)) {
 		if (explicit_tracking) {
 			if (advice_enabled(ADVICE_SET_UPSTREAM_FAILURE)) {
-				error(_(upstream_missing), start_name);
+				int code = die_message(_(upstream_missing),
+						       start_name);
 				advise(_(upstream_advice));
-				exit(1);
+				exit(code);
 			}
 			die(_(upstream_missing), start_name);
 		}
-- 
gitgitgadget

