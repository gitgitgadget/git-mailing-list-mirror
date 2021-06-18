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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A54C49361
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC716611AC
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbhFRS2W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbhFRS2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:16 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E75FC061767
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:06 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso10578204otj.4
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F2gUZrJRZfmCPSCGiSJweliKvhao7YzSb8U9EkQCbCI=;
        b=c2/BM0w9zShHdSpXToD4mm7n0jYCcMKLU6spOlCsTYrZUYgQPCLMR/Fq1qdV+QxXZe
         Cv247I1C+TxEiwgkk4XVg0Z3ja3Gp31RnF7Slkmn6lgmB5kjNsLBJsSSAjk3evVeUW5W
         daUT5yLZC0Cl2YGqkc7OgNNn6vFlyo6kS7ojYrar1lgvrS+ZsY8kP/f3jBkPHBRJR56F
         yO3VS0hX/jtFTfeXvU1vrOWPk+RTJH0MX6OInBJP5rds5jNjVDw+TeE0uYD34zmFFbIL
         xRbeZ6BPnjUgMgsbo6Kha2/FcISbAXiJSit3pjO8fHqA5hPpqSh8tGTF9iouCPsUU7UN
         MkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F2gUZrJRZfmCPSCGiSJweliKvhao7YzSb8U9EkQCbCI=;
        b=pqEZ5s+vsak9P+S2qx9loNCZppH8NqPC3czxnN0MeESZOwfMHiuXWVuq5u1ZRNEkOX
         2EdIgz/3xpXPvn8Vd7ZBIdLsKfhXCBsyLb0welobtUmxqMTcANggPXT9puFkzReJlkMI
         9GZLSW6h08mmw/UXIBSoaYtveN4Ky9ll1KHBkSg9Et1+h7A0OIF6oQoBX3CKWhAuVeQD
         X46kHb6lhJhqYbiXuY9BRhWW4kJsf6JgR7CfUPg2qizIc53ODZL7djbAIeNwA6Vpq7Cz
         QqdxO0lzaJSBuAQiS8uKAUajK52rZRFgRKObia+mZKpe+psmWbjgf3hTzGAGMaDD7DZb
         /cwg==
X-Gm-Message-State: AOAM530+pSR5dGI51KXB3+gls2Zd9b+RO0GjWis4EbCPlwuSDndnxO60
        djOKDpLJiOLynDzdmsyDkxjq2KI79siUtw==
X-Google-Smtp-Source: ABdhPJyVeYL+c/Be3QdoOToJX5wML4OgHFyI3mdDBRzMvYOiHz7pbfxAxTqU0mhz1A3gkNC5ZNlHCQ==
X-Received: by 2002:a9d:17c5:: with SMTP id j63mr10529539otj.369.1624040765708;
        Fri, 18 Jun 2021 11:26:05 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id e23sm2176393otk.67.2021.06.18.11.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:26:05 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 23/45] completion: factor out check in __gitcomp
Date:   Fri, 18 Jun 2021 13:24:56 -0500
Message-Id: <20210618182518.697912-24-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This way we can reorganize the rest of the function.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 6 ++++--
 contrib/completion/git-completion.zsh  | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 366f255dfc..ad67abff36 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -330,9 +330,11 @@ __gitcomp ()
 {
 	local cur_="${3-$cur}"
 
+	if [[ "$cur_" == *= ]]; then
+		return
+	fi
+
 	case "$cur_" in
-	*=)
-		;;
 	--no-*)
 		local c i=0 IFS=$' \t\n'
 		for c in $1; do
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index b9c2c75c79..4dd0a4d821 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -56,9 +56,9 @@ __gitcomp ()
 
 	local cur_="${3-$cur}"
 
+	[[ "$cur_" == *= ]] && return
+
 	case "$cur_" in
-	*=)
-		;;
 	--no-*)
 		local c IFS=$' \t\n'
 		local -a array
-- 
2.32.0

