Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA9EC433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 23:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241722AbiF0XU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 19:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241117AbiF0XUY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 19:20:24 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401A52408F
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 16:20:23 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so8374201wma.4
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 16:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qBDa1j6tjIudbPwVuTOWST5afbkWAt1ljAD8RMfo12Y=;
        b=n8p9+ItEQfcIfsXs6sy4cCSpZj9QfRos6/fIrQ6i/jH1LCc2voPcID4+w/BUSVOsEH
         0vaDlbO8XCTo+R26XR61lTABSN6x9wwTcpO46iSfbh9ADZSmJhHkg5ivIjVdHnVQeM46
         7FCq4CbVMmBlILEY+g+c162yw0wwKDVzCbJWf4FcCLYwXEJTdVHFTUk+Y1d0UKtjDAj2
         t7KXngVyOwtaE0KRYyekbQg6uNVNd+xlWnDjm7JkZr/Z1bf9PhjV0Us9jysyu/SFBem4
         gcQTwdU0H6uOPpTSKeQjYXXJfKiBQWk3DYebyTmHtJFUdUa/vTsI68GjyerA5Lvenbyk
         89vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qBDa1j6tjIudbPwVuTOWST5afbkWAt1ljAD8RMfo12Y=;
        b=xyjQq3i7eorJpJYst2zB3shO1I+x0lvsM1ZlDejYu3zq/zqdUVRw/ZZtTeA9uq1bJy
         fzFuVS4um+hJkSAoaWduRXwEs5d9xNvRkIn0ekSjzM9BnQQHDJ5Y1OV7w3dphpD9Bclu
         xsynBMJxaVn8pm/3rQj8Z/G8B1pKvh3XPAYTeDF5qd9qEi+w4VenvOTATXmN21GM18/0
         074ABewNTQfdvR8SSaKcSEg+Y13AunWkEZtpQ4ha7YMyQmTaZkxDq65GyXuKCXvnc8cm
         ZErGb4ha3lBz+p89Tl4jet3VbuINPZOug6X6gHZZWHollJacy+g72zhKH7GnGV5tv27+
         OgUw==
X-Gm-Message-State: AJIora/Q6jHfGCktznJCi5nsT9iFFQhHqriKWPI34O03QT2KcekCPd6r
        0oaaYPf6twZrU5Ixj79A2IEd0Bu7L1f/vg==
X-Google-Smtp-Source: AGRyM1uerk6POzvchSNIjiX9f8DA43g9X+iipFq9cEWebq5VXbiNnvelHQgagicFFyG6e5f5NqEgGw==
X-Received: by 2002:a1c:cc1a:0:b0:3a0:39b1:3408 with SMTP id h26-20020a1ccc1a000000b003a039b13408mr17847356wmb.157.1656372021561;
        Mon, 27 Jun 2022 16:20:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k31-20020a05600c1c9f00b0039c5642e430sm15327274wms.20.2022.06.27.16.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 16:20:21 -0700 (PDT)
Message-Id: <7cd1c46f350bf26216814dcf9dd4b8002a91467a.1656372017.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 23:20:15 +0000
Subject: [PATCH 3/5] submodule--helper: use correct display path helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Replace a chunk of code in update_submodule() with an equivalent
do_get_submodule_displaypath() invocation. This is already tested by
t/t7406-submodule-update.sh:'submodule update --init --recursive from
subdirectory', so no tests are added.

The two are equivalent because:

- Exactly one of recursive_prefix|prefix is non-NULL at a time; prefix
  is set at the superproject level, and recursive_prefix is set when
  recursing into submodules. There is also a BUG() statement in
  get_submodule_displaypath() that asserts that both cannot be non-NULL.

- In get_submodule_displaypath(), get_super_prefix() always returns NULL
  because "--super-prefix" is never passed. Thus calling it is
  equivalent to calling do_get_submodule_displaypath() with super_prefix
  = NULL.

Therefore:

- When recursive_prefix is non-NULL, prefix is NULL, and thus
  get_submodule_displaypath() just returns prefixed_path. This is
  identical to calling do_get_submodule_displaypath() with super_prefix
  = recursive_prefix because the return value is still the concatenation
  of recursive_prefix + update_data->sm_path.

- When prefix is non-NULL, prefixed_path = update_data->sm_path. Thus
  calling get_submodule_displaypath() with prefixed_path is equivalent
  to calling do_get_submodule_displaypath() with update_data->sm_path

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7a963a967b8..fa8256526e9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2445,19 +2445,11 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 
 static int update_submodule(struct update_data *update_data)
 {
-	char *prefixed_path;
-
 	ensure_core_worktree(update_data->sm_path);
 
-	if (update_data->recursive_prefix)
-		prefixed_path = xstrfmt("%s%s", update_data->recursive_prefix,
-					update_data->sm_path);
-	else
-		prefixed_path = xstrdup(update_data->sm_path);
-
-	update_data->displaypath = get_submodule_displaypath(prefixed_path,
-							     update_data->prefix);
-	free(prefixed_path);
+	update_data->displaypath = do_get_submodule_displaypath(update_data->sm_path,
+								update_data->prefix,
+								update_data->recursive_prefix);
 
 	determine_submodule_update_strategy(the_repository, update_data->just_cloned,
 					    update_data->sm_path, update_data->update_default,
-- 
gitgitgadget

