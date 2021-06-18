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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FDAC49EA2
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84DB3613ED
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbhFRS3Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbhFRS26 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:58 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B421DC0611DD
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:42 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id q5-20020a9d4b050000b029044ecc922d44so329564otf.7
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4rI21jrYd8T4dE8uKXchfmq24yIG4nfo4f1kTWqBYGI=;
        b=mGG4+Bul/rnMTqSC4mwB4V0vhKKqmKA9nCRLw4S6+jvy0ticN+nd5rvVLJ3PaFuHFY
         qB7MiVDUAreRvEU48W/5YnfTUW/ibZadp1/U+Y0FMJsCUckYv+fCOoHnLQJQt1OeR2AB
         GUNqRzZItPCIj19qgo1sACM5AQWmY7TvYvmoPQVQeKP8YiVDFYJjDBVJws2HZIVBG6mg
         Uq3mIPc+IkIBPxKDN3cpfU3JHaYmqq13uIOOYVzFo60VDrAD2NdAWjFu/odaDD0Ijz/O
         Kc+O9KJdvdnRw8cpMrWaOg/cPss7rtSh7t5SNMpSWsaqeid06tpSjsM72YZcJmFXqkqc
         tChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4rI21jrYd8T4dE8uKXchfmq24yIG4nfo4f1kTWqBYGI=;
        b=HjlJpBkADok31g+CxNk0USslDC6Y/3Q5G/y+ok+94G90cqkaBJEaar3qJGuY2noYDX
         xjjQidTX0dKD+B20bhOjWSJVtCOSNrqXH/pMMmVu4jhQuredCeRsU7cS7NI1n6cNYYbz
         aYyxTY7k2IhAW+/foQ1NJ5WjE+mET1QMJ1UUPF+mHWulzG5MhBRqx/TwHbWCyEPFPJgC
         GbGGuGV5RxGYKLKZ1Nz42PCy5piJVq2FP1Rbx1dgsW9CH4/BhCeWjJ0Jz96fK7DSawJd
         /I10u/us+BSFXbYaYxRLrE5Fx/Me1BhOOSb9hBmRJtm0fvFjvoMOwVJYODUhyjEL4WIT
         /jiA==
X-Gm-Message-State: AOAM53249gzapgCbZzp10Vn2i7bBDPqG0HfP775fL6lHZhqg1TJSg/C5
        WKt55jp8p77Fl20IEZQaipO3M7/x9V/XAw==
X-Google-Smtp-Source: ABdhPJw6cTckRoNI3Ccs/yDHqNu5N2MAJH5F2rgTZykmKkB2GlO+wghOFYxtaW2FP0J7JO794HtQfQ==
X-Received: by 2002:a9d:7f91:: with SMTP id t17mr6497589otp.22.1624040801943;
        Fri, 18 Jun 2021 11:26:41 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id a6sm1966473oon.20.2021.06.18.11.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:26:41 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 44/45] completion: bash: trivial cleanup
Date:   Fri, 18 Jun 2021 13:25:17 -0500
Message-Id: <20210618182518.697912-45-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The most typical case first (COMP_WORDBREAKS contains our wanted words).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0433713242..cef064795d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -355,9 +355,7 @@ _get_comp_words_by_ref ()
 	# Which word separators to exclude?
 	exclude="${COMP_WORDBREAKS//[^=:]}"
 	cword=$COMP_CWORD
-	if [ -z "$exclude" ]; then
-		words=("${COMP_WORDS[@]}")
-	else
+	if [ -n "$exclude" ]; then
 		# List of word completion separators has shrunk;
 		# re-assemble words to complete.
 		for ((i=0, j=0; i < ${#COMP_WORDS[@]}; i++, j++)); do
@@ -392,6 +390,8 @@ _get_comp_words_by_ref ()
 				cword=$j
 			fi
 		done
+	else
+		words=("${COMP_WORDS[@]}")
 	fi
 
 	cur=${words[cword]}
-- 
2.32.0

