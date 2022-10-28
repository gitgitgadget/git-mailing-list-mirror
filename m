Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5C4C38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 20:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJ1UPl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 16:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJ1UPI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 16:15:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C67C53A63
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 13:15:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v1so7959439wrt.11
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 13:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xv5jxGDqP4i8h4L7UXLO2UZHu0ST4taarwBqS9qr/rg=;
        b=Xx8mZT/X+S7ZDvNDwnLg8ZTXWaTZW0HNEwu3mwE9ONFPhpRSY9fSoMMo/etsBlO2En
         1lwTi+AXTYUhCRBKlmgtnUKh/13RVzXqEhhFLJgxV17xtfGiSRYoJjCW0kfVV6QlqXEG
         lA3B+JPXPlBuI6V5wswPI3RYN3XtzqW0MTNjdcs0vstgBPit3Ewy3JkQAsg1FIq+Zbk4
         GWCnCY45Z5yWhQMF0798aGcG59iDGouha/f9uU4np32pNRwf4ZOsyOpe5T7A8dQoJOop
         r0wi0/bgPzdubGdx3Ow8IAJYCHpWbcTuvD6yNlzZ9nI5jLWALDnZiTOqRPR8brOghRZ/
         o9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xv5jxGDqP4i8h4L7UXLO2UZHu0ST4taarwBqS9qr/rg=;
        b=ChqWX5Mw6wklSWRNTb5/j8cdPoWiifiB5LE43w7dPCYwEv0CFclQ4yEqbiAROOCDX9
         LxCkw1hXs2MQeBc7BMzTuPY1SAkFyeIjQAsQKWbpQ7BJBq2h6FBS8vCyUM/6+Y6BCDVU
         d4uPVFhS3wzwwz6YJnnmaOxf2mcNkNKqbX1wI/5nSKvG9MQbJBFJ7QrGSRmdnic0RMYn
         jvP7sEcZ/DDvUiNGMdxau29Witjq7EIi2ErcwTWqgMECs+gRcnwlHpHNb8rXi3fROq+m
         fw80laFxe3c/ZWGxrHZC2MfuBJ9x+PD6UbVJLrufVjK+sFWk1PiaasbUf3g03og41Q5D
         qgGw==
X-Gm-Message-State: ACrzQf2wAopv7H8VxxKLrAIHmgEgvGJBiZLIim773j+Zw7429qNVG2bp
        t3BJ9mFQNaZcpVcWuN9tkkCHNFHTGJg=
X-Google-Smtp-Source: AMsMyM73jevreLP/JUE40YtXK7UJHqXYpofnqQRjLoPA6enz8+j6mCjcx1S/zjcLtJluzgKsxFfbWw==
X-Received: by 2002:adf:f843:0:b0:236:9d21:4c79 with SMTP id d3-20020adff843000000b002369d214c79mr560010wrq.606.1666988104886;
        Fri, 28 Oct 2022 13:15:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h7-20020a5d6887000000b002356c051b9csm4245926wru.66.2022.10.28.13.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 13:15:04 -0700 (PDT)
Message-Id: <4e402b67145c6e33c13826f1daf1883a66cd9cd4.1666988096.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
References: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
        <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Oct 2022 20:14:55 +0000
Subject: [PATCH v3 7/8] submodule--helper: remove update_data.suboid
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

update_data.suboid's value is only used in update_submodule()'s call
chain, where it represents the OID of the submodule's HEAD. If the
submodule is newly cloned, it is set to null_oid().

Instead of checking for the null OID, just check if the submodule is
newly cloned. This makes update_submodule() the only function where
update_data.suboid is used, so replace it with a local variable.

As a result, the submodule_up_to_date check is more explicit, which
makes the next commit slightly easier to reason about.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 894be133b3f..ef76a111c7f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1918,7 +1918,6 @@ struct update_data {
 	const char *prefix;
 	char *displaypath;
 	enum submodule_update_type update_default;
-	struct object_id suboid;
 	struct string_list references;
 	struct submodule_update_strategy update_strategy;
 	struct list_objects_filter_options *filter_options;
@@ -2346,7 +2345,7 @@ static int run_update_command(const struct update_data *ud, int subforce)
 
 static int run_update_procedure(const struct update_data *ud)
 {
-	int subforce = is_null_oid(&ud->suboid) || ud->force;
+	int subforce = ud->just_cloned || ud->force;
 
 	if (!ud->nofetch) {
 		/*
@@ -2523,6 +2522,7 @@ static int update_submodule(struct update_data *update_data)
 {
 	int submodule_up_to_date;
 	int ret;
+	struct object_id suboid;
 
 	ret = determine_submodule_update_strategy(the_repository,
 						  update_data->just_cloned,
@@ -2532,10 +2532,8 @@ static int update_submodule(struct update_data *update_data)
 	if (ret)
 		return ret;
 
-	if (update_data->just_cloned)
-		oidcpy(&update_data->suboid, null_oid());
-	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD",
-				     &update_data->suboid, NULL))
+	if (!update_data->just_cloned &&
+	    resolve_gitlink_ref(update_data->sm_path, "HEAD", &suboid, NULL))
 		return die_message(_("Unable to find current revision in submodule path '%s'"),
 				   update_data->displaypath);
 
@@ -2570,7 +2568,8 @@ static int update_submodule(struct update_data *update_data)
 		free(remote_ref);
 	}
 
-	submodule_up_to_date = oideq(&update_data->oid, &update_data->suboid);
+	submodule_up_to_date = !update_data->just_cloned &&
+		oideq(&update_data->oid, &suboid);
 	if (!submodule_up_to_date || update_data->force) {
 		ret = run_update_procedure(update_data);
 		if (ret)
@@ -2583,7 +2582,6 @@ static int update_submodule(struct update_data *update_data)
 
 		next.prefix = NULL;
 		oidcpy(&next.oid, null_oid());
-		oidcpy(&next.suboid, null_oid());
 
 		cp.dir = update_data->sm_path;
 		cp.git_cmd = 1;
-- 
gitgitgadget

