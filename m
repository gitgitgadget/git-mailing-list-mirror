Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A691C54E76
	for <git@archiver.kernel.org>; Wed,  4 Jan 2023 21:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240368AbjADVzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Jan 2023 16:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240340AbjADVys (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2023 16:54:48 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B253D124
        for <git@vger.kernel.org>; Wed,  4 Jan 2023 13:54:48 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id j1-20020aa78001000000b0057d28e11cb6so16407264pfi.11
        for <git@vger.kernel.org>; Wed, 04 Jan 2023 13:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RUdisve4gZWbsO7A2yUrvfD/yW1XxoGAj1HL6Sg3nEw=;
        b=cPobUe75znJ4wV/tcN55OXEYgws6ySy/GjbJuM7LpUXIQ9TsRPldLATpN2SdkEwS5D
         mSETIBqs/wQZXQPxIn6FtVqkTtTgHpzpJTS1i8JmOr+TlSD2WyIB6oABLgGG90yCnPau
         OZyuyeMlS+2pMHQI5mEC6C3IwgJSoVQENw+fTig0AWjWt5N/1G+AlHJTpT55FPQ2f/G7
         97qYx9PS9miba6nNhjdJdjQLc6tAVnpHtU0Q+v0Ql5VHwSaRP9IG7wwCs1yzYbAbSxyv
         W1y2jD9qZskKBwodQixbkQcIsyOg6BXF7m51oLtWY7mLcfb3AGiENpGlR6Uke1oJhN7q
         QKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUdisve4gZWbsO7A2yUrvfD/yW1XxoGAj1HL6Sg3nEw=;
        b=0jFFxTeOaIyBDuZdqHQQDi3ZsoUotuioLORWdaI8tXT+VcUlvxKsX54a+n/TsH8cwo
         UXt1LLElhAUTbGW3ZaZWHR9LUIHBqing5buh0FdIpMzo/W0NGw/N3MYUwlU6DP2JDBQg
         eX3aJlF46A8qm9qPsoMs4tqrq7YVvLVDuTkcq/oX23B7tZGMU3bxdbArzWqXU9hgFtyb
         XPDTwjtD0Hcre7ciO5jM53ECf3ppeR3maYeA7KAAxmLm+hu52yFBscoYw466wkHJsd1m
         BiWXkDkXwf3WJnk2WVeLA0fdmvWBT5y+rA+CxyyJWyFtwGrckuiNk27uERq1urxjxPPL
         pFqg==
X-Gm-Message-State: AFqh2ko3VZRsoPsQGlWhqXa/hCV84eQv0SFhGFhZ82tT8/vFhX0UPR1c
        vdJN3p9IsPl4mOk9b4edT39TbUOEpFIWW6KhZA7EHD9Cw0mZhDKGFn/jkyz3kMAl6kxwfE4y1eo
        fZOPFtwNbgoyAQKpz6D1nGaZGoq4ByBTTOVqvgC91NWbhZbasIQQSKg5GpBXKdBXrwA==
X-Google-Smtp-Source: AMrXdXsKWcxiskND/XKZVURIInJoIJ/1pgvwW5+ZkplaFah8L/vST5Vl/vHN4Ozq5lCRR+EloU++sBC8dUFbcT8=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a62:1558:0:b0:581:aeb8:4316 with SMTP id
 85-20020a621558000000b00581aeb84316mr1713748pfv.33.1672869287693; Wed, 04 Jan
 2023 13:54:47 -0800 (PST)
Date:   Wed,  4 Jan 2023 21:54:13 +0000
In-Reply-To: <https://lore.kernel.org/git/20221108184200.2813458-1-calvinwan@google.com/>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20221108184200.2813458-1-calvinwan@google.com/>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230104215415.1083526-5-calvinwan@google.com>
Subject: [PATCH v5 4/6] diff-lib: refactor match_stat_with_submodule
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com, chooglen@google.com,
        newren@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Flatten out the if statements in match_stat_with_submodule so the
logic is more readable and easier for future patches to add to.
orig_flags didn't need to be set if the cache entry wasn't a
GITLINK so defer setting it.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 diff-lib.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index dec040c366..64583fded0 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -73,18 +73,24 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 				     unsigned *dirty_submodule)
 {
 	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
-	if (S_ISGITLINK(ce->ce_mode)) {
-		struct diff_flags orig_flags = diffopt->flags;
-		if (!diffopt->flags.override_submodule_config)
-			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
-		if (diffopt->flags.ignore_submodules)
-			changed = 0;
-		else if (!diffopt->flags.ignore_dirty_submodules &&
-			 (!changed || diffopt->flags.dirty_submodules))
-			*dirty_submodule = is_submodule_modified(ce->name,
-								 diffopt->flags.ignore_untracked_in_submodules);
-		diffopt->flags = orig_flags;
+	struct diff_flags orig_flags;
+
+	if (!S_ISGITLINK(ce->ce_mode))
+		return changed;
+
+	orig_flags = diffopt->flags;
+	if (!diffopt->flags.override_submodule_config)
+		set_diffopt_flags_from_submodule_config(diffopt, ce->name);
+	if (diffopt->flags.ignore_submodules) {
+		changed = 0;
+		goto cleanup;
 	}
+	if (!diffopt->flags.ignore_dirty_submodules &&
+	    (!changed || diffopt->flags.dirty_submodules))
+		*dirty_submodule = is_submodule_modified(ce->name,
+					 diffopt->flags.ignore_untracked_in_submodules);
+cleanup:
+	diffopt->flags = orig_flags;
 	return changed;
 }
 
-- 
2.39.0.314.g84b9a713c41-goog

