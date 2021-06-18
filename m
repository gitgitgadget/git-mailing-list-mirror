Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B93EC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 19:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2874661264
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 19:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbhFRTGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 15:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhFRTGX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 15:06:23 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8659FC061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 12:04:12 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so10687968otk.5
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 12:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=HQoO9XpypAxqYs4d0MAya4zmwkwBZLwbgm7Gt39/q3s=;
        b=PbCiZgtlsvPI9/x5d/D7QsTq0MDn9TLtPEZm+E8rWMyDe3Iw3BdVJQ2qxAFjvMtZnG
         EjGde2jn+MQ6UcA2dB7BT9OP7AXaT4fdldRjzTaXqla0lpD96tuOsNGha9FtXa23uhD7
         Ttqcz/NuTG4YqupWQnvttTqbz559LhxGkPUniZtoRgOH/IVfyY39apbQMVLENP0qTw1P
         lKS5m/vechCggBRpljwXNY3BENxIdWvsjbZQDDfsqLZx2ewLeUOZp3KbkNGCny8QzFJM
         rZap7fQIuDenYdOdrFK7DYyukULy/kTa96K4PEhHSEZABSuikmdws/DbpN4nKurIGAN3
         En6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=HQoO9XpypAxqYs4d0MAya4zmwkwBZLwbgm7Gt39/q3s=;
        b=pn1hyn25lNKej4IC+0ONxHsgH0TX8QuIXWuWvJ2GXkoBUnLSpThP+baAx3dzKopAXs
         1b03vDuiImtLq+/7ScWqVWGHiiG/rKEWkcJUDXeJ55aqRQzGduCBaIyOJIBYPxnrSBDg
         ztS73uMJWJtMlKx2MF3atwAYYGN5H2rx4NRpz7knPROqgaZt4CK1MAdS+KvBcNbIwDGb
         3gQWjYSkXt2sp9T21uUzeK/HzbNlKo1FCDLfj2kQLqLiEgmTWa6+AWzWcQkC0bRdHCc2
         9dlnNzmkCePa5R+RswLSvMMfMXc2ZYQ3iwVKvj1ud7/nu0yQIr2iKafUpX45aIHSAzuo
         vChw==
X-Gm-Message-State: AOAM533ZFCFntOuD/FTV3TX+rJ9AcOJkPlxxui8evd7F1o5mAI+m326V
        PMHt5zA8DaiHNWaNEJqCDxI=
X-Google-Smtp-Source: ABdhPJxDAnBrVVNkj7bVm4Ny8dNnJZDJ621rGcnQvmQBG7voHyRCxezUPCEefsLtd+QqsOwSS2jA9w==
X-Received: by 2002:a9d:5c16:: with SMTP id o22mr10867272otk.319.1624043051975;
        Fri, 18 Jun 2021 12:04:11 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id h193sm1973222oib.3.2021.06.18.12.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 12:04:11 -0700 (PDT)
Date:   Fri, 18 Jun 2021 14:04:10 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Harrison McCullough <mccullough.harrison@gmail.com>
Message-ID: <60ccee2a48c07_ab0ea20894@natae.notmuch>
In-Reply-To: <20210618182518.697912-2-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
 <20210618182518.697912-2-felipe.contreras@gmail.com>
Subject: RE: [PATCH v2 01/45] completion: fix __git_cmd_idx regression
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -3511,7 +3511,7 @@ fi
>  
>  __git_func_wrap ()
>  {
> -	local cur words cword prev
> +	local cur words cword prev __git_cmd_idx=1

I just realized this isn't 100% correct thanks to Fabian Wermelinger.
If we use __git_complete then the index should be 0. The above fixes the
annoying errors, but some commands don't complete correctly (e.g.
git_fetch).

I've sent an updated fix [1].

[1] https://lore.kernel.org/git/20210618185832.700477-1-felipe.contreras@gmail.com/

-- 
Felipe Contreras
