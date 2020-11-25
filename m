Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116B2C2D0E4
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 02:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C52462075A
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 02:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fd7A6uGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgKYCOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 21:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKYCOe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 21:14:34 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB94AC0613D4
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 18:14:34 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id w187so883268pfd.5
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 18:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OKFz1LNtjumdWTj/raQu3x8J3GkRc3LyhvPVn/OMEmo=;
        b=fd7A6uGYxACCXS/4T7amGLnT/iG/auJ4F9PyW8FF0VcnX0PZ1qc15y4ANzPmlrVVha
         yCJrUTBCNeKDFvrYwiANh0AbmrQ+tgY7S2pTKZyfz66oSIn+zHDglDqvGGlihETLqpWJ
         hAEPiTMmZ5EQ55s8jVg/NbbiKD32PlThxjexyrb5oheRKmd6VCBAB9U4WtlHZ6aTY3Vf
         n3UxKCjG5AResGvcwzCTvkKt6rxPtr7d9u/9syOJ/bNbIjkavapF7zq0Sv7fx4Msq0Ok
         6g6+xZQNhojbA4iwLHU5bUZ6y9EGhodX5uL+5ZxDwEc13Lyc9IUiI3Ti/03osoi6XSlU
         tVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OKFz1LNtjumdWTj/raQu3x8J3GkRc3LyhvPVn/OMEmo=;
        b=qdcPfu/czxbUt2FdrctXhtP7J9Bt3dc1uIxIj7mBaMqNvUzQ8Lu0XUpSSpYNdAUrVX
         6kDJKd4l83ndB/1sYEfKSZRVKZw8943R7Q1t3PHaPrdNwgEjFezDqii6nx4/k9RubXH5
         UgqzjKDnvEccIAB7Elb5iz79JzZoKVsymrBJIAkGJsCkxAEg1ff8rndCoOOJ9cALPE1x
         Y6smrHbFDhkgA6WKb9U4adW8yV7ragrUvaIsflJYgue0uHgDxLwpFxcjgYQkQq1mEh0z
         HC38wBXf+zlmrYotl07aVCwcIUEeESRwvzRJSPIskbXn/emcxpKM7133gMQoq7L5VhzW
         8B4Q==
X-Gm-Message-State: AOAM533yJu/AAnhJyOJKrdaogp784pjoJkJtkFUtfIYZKbtL9Fv5P9in
        qVaOcrm/wSOPWmgcvZuPnjmjL9TkUNGUxQbj
X-Google-Smtp-Source: ABdhPJwbHQ6Rqe1lOIAzI+Tm4Vp+CBmaXGjNtNPPUpvxUXhvrGEXb/f26O7qYMYl4TslygivT8HE1A==
X-Received: by 2002:a62:e901:0:b029:197:ca81:4bb9 with SMTP id j1-20020a62e9010000b0290197ca814bb9mr527338pfh.26.1606270473884;
        Tue, 24 Nov 2020 18:14:33 -0800 (PST)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:5900:961c:3398:e348:1cc1:ced7])
        by smtp.gmail.com with ESMTPSA id 23sm426050pgs.19.2020.11.24.18.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 18:14:32 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, felipe.contreras@gmail.com, gitster@pobox.com,
        ray@ameretat.dev, peff@peff.net, vondruch@redhat.com, tytso@mit.edu
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [RFC 1/2] pull: warn that pulling will not merge by default in Git 3.0
Date:   Tue, 24 Nov 2020 19:09:30 -0700
Message-Id: <20201125020931.248427-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/pull.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 17aa63cd35..4d80efe5b7 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -345,13 +345,14 @@ static enum rebase_type config_get_rebase(void)
 		return parse_config_rebase("pull.rebase", value, 1);
 
 	if (opt_verbosity >= 0 && !opt_ff) {
-		warning(_("Pulling without specifying how to reconcile divergent branches is\n"
-			"discouraged. You can squelch this message by running one of the following\n"
-			"commands sometime before your next pull:\n"
+		warning(_("Starting in Git 3.0, the default behavior of `git pull` will change\n"
+			"when it is not specified how to reconcile divergent branches. You can\n"
+			"squelch this message by running one of the following commands sometime\n"
+			"before your next pull:\n"
 			"\n"
-			"  git config pull.rebase false  # merge (the default strategy)\n"
+			"  git config pull.rebase false  # merge (the current default)\n"
 			"  git config pull.rebase true   # rebase\n"
-			"  git config pull.ff only       # fast-forward only\n"
+			"  git config pull.ff only       # fast-forward only (the future default)\n"
 			"\n"
 			"You can replace \"git config\" with \"git config --global\" to set a default\n"
 			"preference for all repositories. You can also pass --rebase, --no-rebase,\n"
-- 
2.29.2

