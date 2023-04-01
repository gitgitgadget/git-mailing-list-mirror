Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C8DC76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjDAIt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDAIs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:48:58 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACA42544D
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:34 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-17ac5ee3f9cso25620378fac.12
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gT1CU6EZWwx8W3GKw+UVigE449TynC1T+rJxjyNa0zM=;
        b=dSmsSFaueI3zsIWFvLuCduCXyBDxPbJ3u0X17/3o8QZzEW8WPTqYGpe5oPAXcIYBRw
         BSTanbkclY8RaGpaqO7QdT940gQBb3VufTpquHHTbx7ZSZPfyWZobq56r4EpQoDiOuGH
         qwMt3ZMdieM+Uf4oqfbQ+0zpRdmSNeT69lgxpxUgnwMgwIJR0Q9WOnqw62jY1Sxx2/jd
         cocDIZ0gL4+Z3UbFJsigi08Ls3XIwuOvn/qZ/Y16p0B473OLvLaXq29PeiXDbeD1al86
         d0dgDHt12DxsekL6ab30P+1fvS09NCS5ObZzhVxxXrNI7sRNssDo96Fgk0KfsDwLFXGH
         aJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gT1CU6EZWwx8W3GKw+UVigE449TynC1T+rJxjyNa0zM=;
        b=F/iImDC11UCzZlG52+B+aaBMXC53dySJptXqDjgtpuTRusOr3D/0ENGsgcds56ho+q
         PLsMSc6/T1SGIcKdx0PPu8tkcJIkjxmD3TpYtmLh/37IrnPDQaOR+pvMdP2BBAopVgr5
         dOZOeriMmiupcTf+HMVKmQ3lG3BcFZgi5z/vhGNzp0Utvr1pPDGXegLQVOuy+a6Aol4u
         fUOIMkrVltHbYFWA8nHXl5omvQuga+6ux9sPBaULDBhFrhVoBFM5Z2E7V8s7nvBdNqLp
         2udrXuhOCbIFG4he69kqcHtb+KI+3Ea+2Yhzsk+2g3M4a2Scu3G2UUbuz1wFsng6DYPo
         fhAQ==
X-Gm-Message-State: AAQBX9dXjC66d+6QjhDhYeiwhx8G/5W2s7xjPPiKwprNyLoSEjY2Kr3E
        H6SXCV8zFLXNikNEwBLoFev2hgC6hPg=
X-Google-Smtp-Source: AKy350bPlN0MqKA5J+tsq0R2XCI+TYXe9un9/AYFWQ8+AmVRpMjXEamXh0p/Aqypjrm3xUTUQUzjHg==
X-Received: by 2002:a05:6870:1fcd:b0:172:5de5:785 with SMTP id gp13-20020a0568701fcd00b001725de50785mr19854004oac.6.1680338853515;
        Sat, 01 Apr 2023 01:47:33 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id vj12-20020a0568710e0c00b001762ce27f9asm1743123oab.23.2023.04.01.01.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:47:33 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 48/49] completion: bash: trivial cleanup
Date:   Sat,  1 Apr 2023 02:46:25 -0600
Message-Id: <20230401084626.304356-49-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
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
index 1b594f01cb..912e9bace0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -366,9 +366,7 @@ _get_comp_words_by_ref ()
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
@@ -403,6 +401,8 @@ _get_comp_words_by_ref ()
 				cword=$j
 			fi
 		done
+	else
+		words=("${COMP_WORDS[@]}")
 	fi
 
 	cur=${words[cword]}
-- 
2.33.0

