Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BCFC3F2D9
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 20:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE6F21556
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 20:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0z67/6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgCBUCI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 15:02:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33969 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBUCH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 15:02:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id z15so1440138wrl.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2020 12:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4QwYhLwk1OVcwgGoGeBesl7RZC9vvn/QDtTtNHl5AG4=;
        b=A0z67/6TDFLiAFQunn5i/Ay4ypf9zQridIHz7tu2XqL5HKJjzJoi2GO39AtA06FIK9
         t3pfg7kG10FvUODqvQRSLK2vWY3EKwH6KmG1AsuvHzQ4gYnY0a4NBEIWQ6w2uksLrL5X
         YoKrKUGw9LFRcnw523U3ImqISJlSnMKk9gtgcTA1IfQwfHVlFY/a9Fi2onTM2amgoRFz
         Iz8iyKIBhvA5EqvTBWJh7WK7Fqazo4dZC3iTKBvSmu0mjVO++pvczD/gm9oDeGrn/B5n
         unDu41RTzgyYFDamS01UKCK/SqeIsMmwyTkf0lTSslbEqw1qURyzkRoPkncfttwRp/Ie
         URkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4QwYhLwk1OVcwgGoGeBesl7RZC9vvn/QDtTtNHl5AG4=;
        b=soHybxpFqk8jAD2NPvKNNK4L7qm4qOMM58u8u3YHEITCvl0Too071npJlHj9yu/xCy
         ox9RumiKKFqXU4n+r+Ab+GHW2wBF1ftsKsInV6Tc58djQItkZwuq85RbQnx2LZoAdiJn
         1nriDtd9yyErsYTyRUAvR7gDyJ4AikatctmBVsWs/2lt4IMbZsk++J2lwIV6heMUHds1
         AkF3uJsogAaXS9asTkb4pOmVHvxdRg8MtgesioTKGKR8THdmW6k2lGtgf+0QNhkbiCj6
         wILPgRF2kHMpGSHd8Yd6EcE6FZ9Ps1rn8QuL8Ilffcf/SdQAsisLwQTURwZj+scpiy5+
         z8wA==
X-Gm-Message-State: ANhLgQ09Y9ZK0e7RkbLouE37iYiAMUT8TuLW1KHgkTuTmfQuBoR4eeDQ
        LunMo3brpwX9LWvaKC5N/7DEMyU7
X-Google-Smtp-Source: ADFU+vs65winLoF8UG8/ic5KUSmae+I3Xg8ISCkQ4TaHLXSL6ThZWPZvFL0slZe0JThCfyHhRWsx7w==
X-Received: by 2002:a05:6000:1046:: with SMTP id c6mr1110082wrx.411.1583179325571;
        Mon, 02 Mar 2020 12:02:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a70sm134492wme.28.2020.03.02.12.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 12:02:05 -0800 (PST)
Message-Id: <3e213cb59b7237fda0f3cea125155e961b6a462e.1583179320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.548.v7.git.1583179320.gitgitgadget@gmail.com>
References: <pull.548.v6.git.1582778112.gitgitgadget@gmail.com>
        <pull.548.v7.git.1583179320.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Mar 2020 20:02:00 +0000
Subject: [PATCH v7 4/4] tag: use new advice API to check visibility
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
index 9814d6cdfd8..ef4bef65d8c 100644
--- a/advice.c
+++ b/advice.c
@@ -29,7 +29,6 @@ int advice_ignored_hook = 1;
 int advice_waiting_for_editor = 1;
 int advice_graft_file_deprecated = 1;
 int advice_checkout_ambiguous_remote_branch_name = 1;
-int advice_nested_tag = 1;
 int advice_submodule_alternate_error_strategy_die = 1;
 
 static int advice_use_color = -1;
@@ -89,7 +88,6 @@ static struct {
 	{ "waitingForEditor", &advice_waiting_for_editor },
 	{ "graftFileDeprecated", &advice_graft_file_deprecated },
 	{ "checkoutAmbiguousRemoteBranchName", &advice_checkout_ambiguous_remote_branch_name },
-	{ "nestedTag", &advice_nested_tag },
 	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
 
 	/* make this an alias for backward compatibility */
diff --git a/advice.h b/advice.h
index d72ab4a06c1..77cbe5c6b36 100644
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
