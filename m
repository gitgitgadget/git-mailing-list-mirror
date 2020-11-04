Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2CEC4741F
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FCBA206B7
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LY0FIi24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbgKDRr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 12:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731194AbgKDRrY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 12:47:24 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66D5C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 09:47:24 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id q1so827189oot.4
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 09:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hND/JECgqF1QaVlTxCzjJX+h0Q4eNFhd8tsBiwEFwZ4=;
        b=LY0FIi24OgYdUTwuR64OANMVaYrNAoyvmlE8k9nYDjB86GyQZv24uiC04II3ZT/OeQ
         QCU5vw48VKmqYaYaArVe/KMmd7Mbvilqzv8ZUjnjLf0GwwipKJPbS2jGYSzWBF4GrmrB
         kYqtQppYWlrgJt38gJmrCPS4b2eYBYle/h/sLOszRdbbB7Ev+C40SgxcqYzXo590XV73
         KyKjK7/BRY6GcMRJN+ImYovrFULAp3pcJ7wX9NOVAQ3vZbhY9sqKkTyE5nZ2ahHQTANo
         ZTBQivuuFQoh+eRM+5ZaoYdKZDca9QEkeAbLHzl/G57s4UNUoTbLLI0KY+pNItdHhyrh
         fwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hND/JECgqF1QaVlTxCzjJX+h0Q4eNFhd8tsBiwEFwZ4=;
        b=bvcvPhTVu2tQePKdXx2XGAEKZglBrdB1dOyXsf4JrNOE5hCJTTdG8MF3XiI2+gmYrw
         CnKoh1Hd2Mtcmeam0AfBZnHsgUyCA/L+oxphGOFHdCDgi9pSLVERxTqiFrGFYwzFkdiA
         wZYpnfsvo4TvBiewfhxX9JAMpotGNYUbiv0DG4wST/adFhsFuQAw5aq3x+Q6HfwB8+5a
         7e8GrxdnDavbPQvxXHJ2VQ86aZNOSAe1eKsf3AvbX8SELhamK2ayEii514XWW5+ISBvw
         dvPVSJxgO/m9vijSG7uHo+PrSI9A1xYqqymHY+91Sw6675rCi9q08SpNVTa1T1NJRMV5
         tUqg==
X-Gm-Message-State: AOAM532laHMEBKZ4a9UDEqB3EzJz3LI+x1sduUmLpchMO8lf2lXTMM0b
        /kmBlW/bVqiCtmYbLepvdy27aBv142BAfA==
X-Google-Smtp-Source: ABdhPJwRprhXEDWTx6hhszJd9uPj2Zx9pw8IfNkMWEiJI4CHlHsKJE4vWBlBW8wNh7Lr5GHmMuUESg==
X-Received: by 2002:a05:6820:345:: with SMTP id m5mr19752244ooe.59.1604512043908;
        Wed, 04 Nov 2020 09:47:23 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id l204sm589848oia.32.2020.11.04.09.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 09:47:23 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 03/10] completion: bash: get rid of _append() functions
Date:   Wed,  4 Nov 2020 11:47:09 -0600
Message-Id: <20201104174716.783348-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201104174716.783348-1-felipe.contreras@gmail.com>
References: <20201104174716.783348-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to have duplicated functionality.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 35 ++++++--------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 87762dc33e..80701749fa 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -292,8 +292,7 @@ _get_comp_words_by_ref ()
 }
 fi
 
-# Fills the COMPREPLY array with prefiltered words without any additional
-# processing.
+# Appends prefiltered words to COMPREPLY without any additional processing.
 # Callers must take care of providing only words that match the current word
 # to be completed and adding any prefix and/or suffix (trailing space!), if
 # necessary.
@@ -306,19 +305,6 @@ __gitcomp_direct ()
 	COMPREPLY+=($1)
 }
 
-# Similar to __gitcomp_direct, but appends to COMPREPLY instead.
-# Callers must take care of providing only words that match the current word
-# to be completed and adding any prefix and/or suffix (trailing space!), if
-# necessary.
-# 1: List of newline-separated matching completion words, complete with
-#    prefix and suffix.
-__gitcomp_direct_append ()
-{
-	local IFS=$'\n'
-
-	COMPREPLY+=($1)
-}
-
 __gitcompappend ()
 {
 	local x i=${#COMPREPLY[@]}
@@ -437,16 +423,8 @@ __gitcomp_builtin ()
 	__gitcomp "$options"
 }
 
-# Variation of __gitcomp_nl () that appends to the existing list of
-# completion candidates, COMPREPLY.
-__gitcomp_nl_append ()
-{
-	local IFS=$'\n'
-	__gitcompappend "$1" "${2-}" "${3-$cur}" "${4- }"
-}
-
 # Generates completion reply from newline-separated possible completion words
-# by appending a space to all of them.
+# by appending a space to all of them. The result is appended to COMPREPLY.
 # It accepts 1 to 4 arguments:
 # 1: List of possible completion words, separated by a single newline.
 # 2: A prefix to be added to each possible completion word (optional).
@@ -456,7 +434,8 @@ __gitcomp_nl_append ()
 #    appended.
 __gitcomp_nl ()
 {
-	__gitcomp_nl_append "$@"
+	local IFS=$'\n'
+	__gitcompappend "$1" "${2-}" "${3-$cur}" "${4- }"
 }
 
 # Fills the COMPREPLY array with prefiltered paths without any additional
@@ -843,7 +822,7 @@ __git_complete_refs ()
 
 	# Append DWIM remote branch names if requested
 	if [ "$dwim" = "yes" ]; then
-		__gitcomp_direct_append "$(__git_dwim_remote_heads "$pfx" "$cur_" "$sfx")"
+		__gitcomp_direct "$(__git_dwim_remote_heads "$pfx" "$cur_" "$sfx")"
 	fi
 }
 
@@ -2615,7 +2594,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur%.*}."
 		cur_="${cur#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	guitool.*.*)
@@ -2665,7 +2644,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl "pushDefault" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	url.*.*)
-- 
2.29.2

