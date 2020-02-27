Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CF7C4BA24
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 04:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B9E24679
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 04:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tez3Je+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgB0EfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 23:35:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37082 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbgB0EfU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 23:35:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id a141so1837048wme.2
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 20:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=84cMjJqcEgXT8/eV1R/cjmS56zGIs68p3bDX5hFFweY=;
        b=tez3Je+mU7DSColnls4v0n/SAGWShP7wWHCf8DJSTy4sP0K/DPBPwa9fTLJ1Q7nofJ
         10EYKoHIUkPv23DNF+Oa9ZVii6b+dIfVIFbog+4qThST6kDxpKYX7KtJWoww4dooLQzy
         2JLvSlTcyetLch0OzMYdxU8SWgGAIAGCcb+5im5YBBX2aS9tXg9HBtTnZYBPZGvtgdPu
         tb2JwWgF/syf2k8wwjKZICF1KzHeFQuaO4rfDOoEUeOoAaUITsTVpFP/T4Fwnui7hnpV
         MLDk9Zzuai46AOkZltyaM3l80CEqhCYHzg5bAAqzWkAbkz11GQ5R6ggi7mXxCBUeGHSi
         iwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=84cMjJqcEgXT8/eV1R/cjmS56zGIs68p3bDX5hFFweY=;
        b=M463daznO1Sc5dr8Ox3PGZpKd0SyR6H6XQYY/OxMf8CD46wDNychQ0AfGkB5T23bAB
         GdIDpTNO7vCPbm9jbwKOJ0gNhNQflm2hPG1I4tX76bp3E3aqLJp53e/A1gOze4j3boxS
         gTRkJ7L6z5mwCTQfLqRYf8/JdHAUh8iWhwrTFtyda6UTbYWsO+f1KNVUbX9LbrGwnOgK
         JoXYQrTKy2NUxtug6FGgsVKU8XsfgUULsNB/v5LbQDgEq7zhIKNUTVv8rgyGRXp6AO3z
         qSEkMD/eo3lxggT6Po9rdS08fyZi3HCe218MF4VSxixlTdgMreSaLJ3fkI6q7nvyHGlA
         Se5Q==
X-Gm-Message-State: APjAAAUviBu8QMQRhFbcQ4wZYJX4jOtBpyb/sTIUwcOzHQQjrsZOWzBz
        uVpWPSUQvstZ4rcAFI7LLZ4QTIy1
X-Google-Smtp-Source: APXvYqxlpv5hRtbvbrWPD9EAsiwnPaCMm8gdZ6sDOKBHyj4TEnW0Mr2ITJIMKv8U9iD+q4H4q+1ONA==
X-Received: by 2002:a05:600c:2104:: with SMTP id u4mr2681289wml.93.1582778116602;
        Wed, 26 Feb 2020 20:35:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3sm4513983wmc.42.2020.02.26.20.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 20:35:16 -0800 (PST)
Message-Id: <2dee0abd452188addc93959af6e67e6f585de300.1582778112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.548.v6.git.1582778112.gitgitgadget@gmail.com>
References: <pull.548.v5.git.1582628141.gitgitgadget@gmail.com>
        <pull.548.v6.git.1582778112.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Feb 2020 04:35:11 +0000
Subject: [PATCH v6 4/4] tag: use new advice API to check visibility
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

change the advise call in tag library from advise() to
advise_if_enabled() to construct an example of the usage of
the new API.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 advice.c       | 2 --
 advice.h       | 1 -
 builtin/tag.c  | 5 +++--
 t/t7004-tag.sh | 1 +
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/advice.c b/advice.c
index 8d9f2910663..07edd04e6c4 100644
--- a/advice.c
+++ b/advice.c
@@ -29,7 +29,6 @@ int advice_ignored_hook = 1;
 int advice_waiting_for_editor = 1;
 int advice_graft_file_deprecated = 1;
 int advice_checkout_ambiguous_remote_branch_name = 1;
-int advice_nested_tag = 1;
 int advice_submodule_alternate_error_strategy_die = 1;
 
 const char ADVICE_ADD_EMBEDDED_REPO[] = "advice.addEmbeddedRepo";
@@ -123,7 +122,6 @@ static struct {
 	{ "waitingForEditor", &advice_waiting_for_editor },
 	{ "graftFileDeprecated", &advice_graft_file_deprecated },
 	{ "checkoutAmbiguousRemoteBranchName", &advice_checkout_ambiguous_remote_branch_name },
-	{ "nestedTag", &advice_nested_tag },
 	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
 
 	/* make this an alias for backward compatibility */
diff --git a/advice.h b/advice.h
index 78905c7ad57..e68c3e807a0 100644
--- a/advice.h
+++ b/advice.h
@@ -29,7 +29,6 @@ extern int advice_ignored_hook;
 extern int advice_waiting_for_editor;
 extern int advice_graft_file_deprecated;
 extern int advice_checkout_ambiguous_remote_branch_name;
-extern int advice_nested_tag;
 extern int advice_submodule_alternate_error_strategy_die;
 
 /*
diff --git a/builtin/tag.c b/builtin/tag.c
index e0a4c253828..cc30d346f5d 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -231,8 +231,9 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 	if (type <= OBJ_NONE)
 		die(_("bad object type."));
 
-	if (type == OBJ_TAG && advice_nested_tag)
-		advise(_(message_advice_nested_tag), tag, object_ref);
+	if (type == OBJ_TAG)
+		advise_if_enabled(ADVICE_NESTED_TAG, _(message_advice_nested_tag),
+				  tag, object_ref);
 
 	strbuf_addf(&header,
 		    "object %s\n"
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 6db92bd3ba6..74b637deb25 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1726,6 +1726,7 @@ test_expect_success 'recursive tagging should give advice' '
 	hint: already a tag. If you meant to tag the object that it points to, use:
 	hint: |
 	hint: 	git tag -f nested annotated-v4.0^{}
+	hint: Disable this message with "git config advice.nestedTag false"
 	EOF
 	git tag -m nested nested annotated-v4.0 2>actual &&
 	test_i18ncmp expect actual
-- 
gitgitgadget
