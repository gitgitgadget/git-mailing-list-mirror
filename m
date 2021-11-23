Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD7CC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 19:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbhKWTvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 14:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbhKWTvb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 14:51:31 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DD5C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 11:48:22 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id bf17-20020a17090b0b1100b001a634dbd737so1913055pjb.9
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 11:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=k9VlgjwvCCWzYt2EeaKpnCLUhlTPBr9iOn+WLz9gTlc=;
        b=aDx8uiSVrnX08VjQ45nWcqeXir3ka1mFAsii01dXrU1R182sqGTtMjOj8ym6hKy3VV
         O/xmlaF8LNk0WugMBpfZzRZIZV/DS5EFk9K7KyYnZIXQRhECIA5zmmMh0ivbHNx65fpo
         is8m9iI6o7lwMwcvm/hmqHYO9KmzZs/boL6oWvvkRKv2FZJE/JWagXYRZ/Qc5NJWHRi0
         sjxX07xlEKdTiMVWMvN4GT4IX2dTKY0sbY3vrnNpImsr0IFmYH7sk79OnXVVZ2LntqBB
         1Rh08p82uQ0AELasnApdgNW+8Ffy8sgTsaWCT7H7YLwhaYzMFCvj2o8TJcG4F8lhgddz
         4VRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k9VlgjwvCCWzYt2EeaKpnCLUhlTPBr9iOn+WLz9gTlc=;
        b=D4DlytzopxlYYW8Uto3i44KAUXwqfzlY9tGd++IvURQgRRyEpOag4MeuvjEnTGlOY5
         RUQfdzpjV0hxubl3dTcrBx+KawkKt8YYlEeb9MW63Ip6KoxKRZiSVZHaVRbRuUj8vli0
         WjPtXon4VIHIw6BQxbx1UtOSgouV/OLAjR3PJedglwgl7HvzMYdKKnT/wboNsSdCfbKb
         Z137L4L6RJL0FSD/lMYBuaYe5QUAS8JLouwFw9Hc1RRPLf7K43CPazvR5brdNyj/qbkE
         c8PG7LwkHSSbkiIindJvztFWIo21Tr0bhaHEtCEDycPK2x5/XZ0ZKquhLadIn64ofEGF
         vQbw==
X-Gm-Message-State: AOAM531grrrJ1nsZxmNXWJR4kadyHzTxiNCH87qZmz4AfFlpVSG9BRLc
        A3Zo+Qj2wqw3aApWO93aEje3MCtw/zCQ/g==
X-Google-Smtp-Source: ABdhPJyiaXzCpA0Sn5YAwAP30RzbPY/8HTVHBIFPjqfytB+MCDs5l/pK4gEHkiNE6FaPr1t/pLph1drd3XBUTQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:aa43:b0:143:e20b:f37f with SMTP
 id c3-20020a170902aa4300b00143e20bf37fmr9995451plr.65.1637696902301; Tue, 23
 Nov 2021 11:48:22 -0800 (PST)
Date:   Tue, 23 Nov 2021 11:48:20 -0800
In-Reply-To: <20211123021223.3472472-1-jonathantanmy@google.com>
Message-Id: <kl6l35nmvekb.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211122223252.19922-2-chooglen@google.com> <20211123021223.3472472-1-jonathantanmy@google.com>
Subject: Re: [PATCH 1/4] submodule-config: add submodules_of_tree() helper
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, steadmon@google.com,
        emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> I think that tree_entry() doesn't recurse into subtrees, but in any case we
> should test this. (I looked at patch 4 and I think that the submodules are
> always in the root tree.)

I've tested this and indeed it doesn't work. I've attached my test case
below.

> This reminded me of a similar thing when fetching submodules recursively and we
> needed the "before" and "after" of submodule gitlinks. You can look at the code
> (collect_changed_submodules_cb() and the functions that use it in submodule.c)
> but it may not be useful - in particular, that uses diff since we need to see
> differences there, but we don't need that here.

Thanks for the hint. If that fails, I could also implement it via the
helper methods in submodule--helper.

---- >8 ----

diff --git a/t/t3207-branch-submodule.sh b/t/t3207-branch-submodule.sh
index 14ff066e91..0e086f716d 100755
--- a/t/t3207-branch-submodule.sh
+++ b/t/t3207-branch-submodule.sh
@@ -11,11 +11,15 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 test_expect_success 'setup superproject and submodule' '
 	git init super &&
 	test_commit foo &&
+	git init sub-sub-upstream &&
+	test_commit -C sub-sub-upstream foo &&
 	git init sub-upstream &&
-	test_commit -C sub-upstream foo &&
-	git -C super submodule add ../sub-upstream sub &&
+	git -C sub-upstream submodule add "$TRASH_DIRECTORY/sub-sub-upstream" sub-sub &&
+	git -C sub-upstream commit -m "add submodule" &&
+	git -C super submodule add "$TRASH_DIRECTORY/sub-upstream" sub &&
 	git -C super commit -m "add submodule" &&
-	git -C super config submodule.propagateBranches true
+	git -C super config submodule.propagateBranches true &&
+	git -C super/sub submodule update --init
 '
 
 cleanup_branches() {
@@ -26,7 +30,7 @@ cleanup_branches() {
 		git checkout main &&
 		for branch_name in "$@"; do
 			git branch -D "$branch_name"
-			git submodule foreach "(git checkout main && git branch -D $branch_name) || true"
+			git submodule foreach "cleanup_branches . $branch_name || true"
 		done
 	)
 } >/dev/null 2>/dev/null
@@ -37,8 +41,9 @@ test_expect_success '--recurse-submodules should create branches' '
 	(
 		cd super &&
 		git branch --recurse-submodules branch-a &&
-		git rev-parse --abbrev-ref branch-a &&
-		git -C sub rev-parse --abbrev-ref branch-a
+		git rev-parse branch-a &&
+		git -C sub rev-parse branch-a &&
+		git -C sub/sub-sub rev-parse branch-a
 	)
 '
 
