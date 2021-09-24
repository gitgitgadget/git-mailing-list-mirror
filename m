Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C96C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0A1F6124C
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347128AbhIXPlP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 11:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347182AbhIXPk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 11:40:59 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902A7C0613E2
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 08:39:24 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t8so28892038wri.1
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 08:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IqTNWyRXSwlJyMHaVGmitQJJcss5hdQINHnB6QXcZhQ=;
        b=Aw3T3VOvgZdiDqv4rH50moVmeld0jWoSNyUy1FpvpqYRduIFq9K30UpJUywbPGCx5J
         ByVj5ywhyjI71RmlhYtRrXNRU9+64vEpxN6jK0DHwYwyNkGrAd5HW+06gL6GqV1Fo69A
         MkEktTAUh/9Dcqu3MMx9OQB2WUaznKnv5ZXP488xMqWEy8KqjbRxZmrCZIypnnGxfyri
         4F3WGcVktY+zEuhaIdCgmHiwRTnPLzePFp12JDpzb5AEKlnQ+YkD56qGvyfSVYBAxRjS
         J6RNQnAXthwJNwtC3vVaZv1sQSyq641uEZI1pztf7aTTkYkxl0mYzl+k6fVsz9xaCu0c
         vcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IqTNWyRXSwlJyMHaVGmitQJJcss5hdQINHnB6QXcZhQ=;
        b=ADMnOyMxvG4QwOOsdDF+7sgiq+MORcZ+H2xvxPnp/vVhA+eR8nKfNpimtGb7Huk4Qv
         lk2C+Z4M7MWB2lpjNnLzMMxl1kY9pmCkjWeEXWs4XSeHZgRSLYwrV7OKPmzAugBMoRtf
         lU4O1sAvPSVnPvWnQf5Md7tIOyltnu7fvW4LUG671FGV+cHrPRaVEfe+0riTODUNAe6d
         DB2NYEjG9eFQIEm/ieyq6IzJ0G2DT8YfA+iajtyJ0ETB+b9i4bfW9DKnT8kAd3Z3L15e
         6rDWNDARpZghpOJwCbCjjG62vQJVNVlM4PIOZ3l1ZhDz+plasCMyC5e240HvrNh1Rfej
         N4ZQ==
X-Gm-Message-State: AOAM530xdV1KYIezXaxrPgSeo2KZxW6O/zqT8pkDYrCT4xXOMg8+ymvj
        sIQlP2IQInDa9IxkpPQmeXwdJ69Z91s=
X-Google-Smtp-Source: ABdhPJz7Q5Xz33Ni4CPmWDXEy/nfa/zmLye82X9ShYAycsldyLpJqM47WL/IoEs/vkkgonPAl8w+Hg==
X-Received: by 2002:a5d:4d92:: with SMTP id b18mr12019300wru.245.1632497963170;
        Fri, 24 Sep 2021 08:39:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v10sm9073516wri.29.2021.09.24.08.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 08:39:22 -0700 (PDT)
Message-Id: <9fbc88ee0dab830bdc34575e9808b8f2a04a59e9.1632497954.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
References: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
        <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 15:39:14 +0000
Subject: [PATCH v4 13/13] advice: update message to suggest '--sparse'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The previous changes modified the behavior of 'git add', 'git rm', and
'git mv' to not adjust paths outside the sparse-checkout cone, even if
they exist in the working tree and their cache entries lack the
SKIP_WORKTREE bit. The intention is to warn users that they are doing
something potentially dangerous. The '--sparse' option was added to each
command to allow careful users the same ability they had before.

To improve the discoverability of this new functionality, add a message
to advice.updateSparsePath that mentions the existence of the option.

The previous set of changes also modified the purpose of this message to
include possibly a list of paths instead of only a list of pathspecs.
Make the warning message more clear about this new behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 advice.c                       | 11 ++++++-----
 t/t3602-rm-sparse-checkout.sh  |  9 ++++++---
 t/t3705-add-sparse-checkout.sh |  9 ++++++---
 t/t7002-mv-sparse-checkout.sh  |  9 ++++++---
 4 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/advice.c b/advice.c
index 0b9c89c48ab..713fff49ee3 100644
--- a/advice.c
+++ b/advice.c
@@ -293,15 +293,16 @@ void advise_on_updating_sparse_paths(struct string_list *pathspec_list)
 	if (!pathspec_list->nr)
 		return;
 
-	fprintf(stderr, _("The following pathspecs didn't match any"
-			  " eligible path, but they do match index\n"
-			  "entries outside the current sparse checkout:\n"));
+	fprintf(stderr, _("The following paths and/or pathspecs matched paths that exist\n"
+			  "outside of your sparse-checkout definition, so will not be\n"
+			  "updated in the index:\n"));
 	for_each_string_list_item(item, pathspec_list)
 		fprintf(stderr, "%s\n", item->string);
 
 	advise_if_enabled(ADVICE_UPDATE_SPARSE_PATH,
-			  _("Disable or modify the sparsity rules if you intend"
-			    " to update such entries."));
+			  _("If you intend to update such entries, try one of the following:\n"
+			    "* Use the --sparse option.\n"
+			    "* Disable or modify the sparsity rules."));
 }
 
 void detach_advice(const char *new_name)
diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
index 5f92b60a56a..ecce497a9ca 100755
--- a/t/t3602-rm-sparse-checkout.sh
+++ b/t/t3602-rm-sparse-checkout.sh
@@ -11,12 +11,15 @@ test_expect_success 'setup' "
 	git commit -m files &&
 
 	cat >sparse_error_header <<-EOF &&
-	The following pathspecs didn't match any eligible path, but they do match index
-	entries outside the current sparse checkout:
+	The following paths and/or pathspecs matched paths that exist
+	outside of your sparse-checkout definition, so will not be
+	updated in the index:
 	EOF
 
 	cat >sparse_hint <<-EOF &&
-	hint: Disable or modify the sparsity rules if you intend to update such entries.
+	hint: If you intend to update such entries, try one of the following:
+	hint: * Use the --sparse option.
+	hint: * Disable or modify the sparsity rules.
 	hint: Disable this message with \"git config advice.updateSparsePath false\"
 	EOF
 
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 339ec0ed2d6..5b904988d49 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -44,12 +44,15 @@ test_sparse_entry_unstaged () {
 
 test_expect_success 'setup' "
 	cat >sparse_error_header <<-EOF &&
-	The following pathspecs didn't match any eligible path, but they do match index
-	entries outside the current sparse checkout:
+	The following paths and/or pathspecs matched paths that exist
+	outside of your sparse-checkout definition, so will not be
+	updated in the index:
 	EOF
 
 	cat >sparse_hint <<-EOF &&
-	hint: Disable or modify the sparsity rules if you intend to update such entries.
+	hint: If you intend to update such entries, try one of the following:
+	hint: * Use the --sparse option.
+	hint: * Disable or modify the sparsity rules.
 	hint: Disable this message with \"git config advice.updateSparsePath false\"
 	EOF
 
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 07dbfeb6d17..545748949aa 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -11,12 +11,15 @@ test_expect_success 'setup' "
 	git commit -m files &&
 
 	cat >sparse_error_header <<-EOF &&
-	The following pathspecs didn't match any eligible path, but they do match index
-	entries outside the current sparse checkout:
+	The following paths and/or pathspecs matched paths that exist
+	outside of your sparse-checkout definition, so will not be
+	updated in the index:
 	EOF
 
 	cat >sparse_hint <<-EOF
-	hint: Disable or modify the sparsity rules if you intend to update such entries.
+	hint: If you intend to update such entries, try one of the following:
+	hint: * Use the --sparse option.
+	hint: * Disable or modify the sparsity rules.
 	hint: Disable this message with \"git config advice.updateSparsePath false\"
 	EOF
 "
-- 
gitgitgadget
