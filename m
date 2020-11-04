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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BA3C4742C
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16907206B7
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aV8Az+uq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbgKDRr2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 12:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730775AbgKDRr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 12:47:26 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCF8C0613D4
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 09:47:26 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id l36so12098074ota.4
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 09:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=83PgvcvU7eSvLs78eT0hKzmYz6NLov2wKU8Q35kGPHY=;
        b=aV8Az+uqlt2ahm3ISYDpn4x5Mkf1miRHjr+qEez0N0W1/1QLC8AG/gafLRk3hqS+KP
         jYEIuIXFANRSl45YOkBsaYx59X84t1VK2IaalQpRZ3pfNLz+3OYz9AEBBx8aOJIqdN68
         9EgfR1RsqbzPGRzVcfqObbTFm9qtkA+sy6f7Xr579yLjTyR1CK60mdE96y/RrFOrW+Pr
         +uDT7B6AXdiKofEN8+8Q8COPO8emdDXJc38tRjbC541sqn9tYzQ9NYxppdaByeFQkeXB
         rEu+NTYViJpk2sd7Q/RvaPjFzjSI14oAitX5DaGcMLADFqYuu3HT6WbLDccqx5gJiy3s
         8jHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=83PgvcvU7eSvLs78eT0hKzmYz6NLov2wKU8Q35kGPHY=;
        b=pxuoyIXFvaki7Ljnl1IeRObk5xoF8o2/GHJIf+jt1wzk5F8cJCCNr2aKe5CuKiS5ZV
         cmnlzlN/F7nky6DbwbAQYwIQz9H8soyMm2tldX6Sz/7Id87ZQ3M/c8B/jRc4ZSDzPyy/
         l3EP9roSzpSzu2NQdVtvQMYAJcHuhhLfSdsxlqdjMzKQsuDq+uxzr+hRhxfzLO0xFRfH
         87djXvwhGMXpWa829MdojpmGaX+phBvQv5K7rRjDkaV5C3pYP1PDtfl0+Lpr/vTUCD9Y
         tTlGCs6zHYmZtqKb0pf2V5a1uz7xgS7vALkKexsoegkTWA/p8T6GBg0XbGoZUCIHlMY+
         7Z7g==
X-Gm-Message-State: AOAM532GkSQLO7VZFqMXAk7NunuYF8Rgf7/1hhlXve76h1jxH3BjKi5R
        nbv50QKst9TCUT0umyvAu/VJ1Ph04FRSng==
X-Google-Smtp-Source: ABdhPJw0ES0ATcSI2gNBKsvEIl7+x4H6IlKn/1Y98g3WSacELWvhCGGhOS55Wh/t3jAiKyLISl8gmQ==
X-Received: by 2002:a9d:73cb:: with SMTP id m11mr20285956otk.128.1604512045643;
        Wed, 04 Nov 2020 09:47:25 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id l9sm621583otn.53.2020.11.04.09.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 09:47:25 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 04/10] completion: bash: get rid of any non-append code
Date:   Wed,  4 Nov 2020 11:47:10 -0600
Message-Id: <20201104174716.783348-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201104174716.783348-1-felipe.contreras@gmail.com>
References: <20201104174716.783348-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 80701749fa..9f384698f2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -315,12 +315,6 @@ __gitcompappend ()
 	done
 }
 
-__gitcompadd ()
-{
-	COMPREPLY=()
-	__gitcompappend "$@"
-}
-
 # Generates completion reply, appending a space to possible completion words,
 # if necessary.
 # It accepts 1 to 4 arguments:
@@ -448,7 +442,7 @@ __gitcomp_file_direct ()
 {
 	local IFS=$'\n'
 
-	COMPREPLY=($1)
+	COMPREPLY+=($1)
 
 	# use a hack to enable file mode in bash < 4
 	compopt -o filenames +o nospace 2>/dev/null ||
@@ -471,7 +465,7 @@ __gitcomp_file ()
 	# since tilde expansion is not applied.
 	# This means that COMPREPLY will be empty and Bash default
 	# completion will be used.
-	__gitcompadd "$1" "${2-}" "${3-$cur}" ""
+	__gitcompappend "$1" "${2-}" "${3-$cur}" ""
 
 	# use a hack to enable file mode in bash < 4
 	compopt -o filenames +o nospace 2>/dev/null ||
-- 
2.29.2

