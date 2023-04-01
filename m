Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C08C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjDAIrT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDAIrA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:47:00 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A2720C29
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:46:44 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id f4-20020a9d0384000000b0069fab3f4cafso13135084otf.9
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIpnDUOgGlPCgKXX0oLBp3OIzqLY1SOFKqnWWMhtFjE=;
        b=WRkUnJ9BRxQNkT3wo9bNyhiRrBLwKBac4rsB6QxulbLKA/YIyyh6DTuFOsfCkrhcFo
         7MuwStPgXbk8HgLbLmMIaqLmDohm+AfVt7cVihf6gyU7eDQ2I5bjCNy9D0nCwJSEpLZm
         VGJ0yyk//IetMF/N5dNxrNHt+YliyIxMKaUr4+WAaVJXW7KT1mb1xeaYqTQ4l88RY7tX
         4knGkGQqKl0rOBgf8cpF9XvJZQRDPJxwQSY9jaUoeXd1dLrH6LtnkjqhKxcRFfKdprg/
         DOGhWg2YLmZv9i1h6XspnVHJvVHNz7iJ9stl4h1koGrJFTWyNGjpZYQyMdnAB+EHoSXl
         UktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIpnDUOgGlPCgKXX0oLBp3OIzqLY1SOFKqnWWMhtFjE=;
        b=wXtjX+Oy2Y8qavMCuBy6KBcAruqlNhEugdnZsWAtwj/JHtwca5/l18k6qk+CRCq4ZA
         NVvUZD9LZ2dur4xZ/YLPHNl+8kAGvY1kHRzQZUuekLMZ92m6luvNxbjvLWK/5TSELBl7
         Mq69CagXXwS+mFl2xWSvQw9pcH0yCtIiVflwxxcPV9vwWV8IoXdxnNsJfDzkcNPqjjbL
         qNxtCgJL+M7KYKLuUHD1lxfe45JiogM9WP/s3mKmoURyvsbLs/ZBR2CwHlwJKKBz2ukG
         /6CnOdwQxKfiYbYoyQTsOTMplk9XWgRg21aXYwkXdl3E1qIKuspdV8OpCc2sW8Za0nQz
         qWyw==
X-Gm-Message-State: AAQBX9dWwS6BIiiXrwFlRQvdrguQzrmt0t5qm/I7O9LGVYQhjAgb/P87
        7zwdWDQZRdk8E2l7oCJeyzC5kTktsDc=
X-Google-Smtp-Source: AKy350b0Rsn5CpcU18yLk1wPV8/oLeZCDrQ5ICfjI98ntoceFuZKq+27lF3p83B/MqDAdiJLIZUs7Q==
X-Received: by 2002:a9d:6d05:0:b0:6a3:780:5848 with SMTP id o5-20020a9d6d05000000b006a307805848mr868908otp.25.1680338803400;
        Sat, 01 Apr 2023 01:46:43 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id u3-20020a4a5703000000b0053e3da7f810sm1773562ooa.25.2023.04.01.01.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:46:43 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 11/49] completion: zsh: trivial improvement
Date:   Sat,  1 Apr 2023 02:45:48 -0600
Message-Id: <20230401084626.304356-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$words has basically all the words we need, except the first one: git.

Lets simply add that instead of passing the original, which contains
options we don't want to pass downstream (like -c and -C).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 13809f7894..790879e319 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -215,9 +215,6 @@ __git_zsh_main ()
 {
 	local curcontext="$curcontext" state state_descr line
 	typeset -A opt_args
-	local -a orig_words
-
-	orig_words=( ${words[@]} )
 
 	_arguments -C \
 		'(-p --paginate --no-pager)'{-p,--paginate}'[pipe all output into ''less'']' \
@@ -257,7 +254,7 @@ __git_zsh_main ()
 
 		(( $+opt_args[--help] )) && command='help'
 
-		words=( ${orig_words[@]} )
+		words=( git ${words[@]} )
 
 		__git_zsh_bash_func $command
 		;;
-- 
2.33.0

