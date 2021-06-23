Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6D0C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 19:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE3046120D
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 19:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhFWTLY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 15:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFWTLX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 15:11:23 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BBBC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 12:09:05 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id t40so4478316oiw.8
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 12:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=pzBPdU2vtnhlvUUN6uNYhIBHDliNoeKZ5c8R1M/4iWQ=;
        b=fAS28QjydRAFhkMiT9a230kn/nJMpu8oHgqeLopds54zZ5HSQYsDtqcOi8r/eKtpxF
         eeS8nwkuCqS2WQMo9SapfUU0XamsVjQkVCiN0vdKD8VYTHk+f+B5St+Y0lESTjOkle75
         sj5G3mGN6GWStW5OYynAxZC5Z6ywGqD4a21rg+jgigeKBs7lwPSfj6xPaDlrPkyuu3Ql
         0eL5KEUH3cNNbi/do8TzpZ51kHtE2OCAAMWqAREN5Xnr/5uUxQ5w0OJJa53Jo8DGyFC0
         t4XHcCj8Ce0sZ47mxW3fFUz+Hapwgz4ZvcpvBMK5mQHXt86Itk0az9JorgL18diJ05lq
         NnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=pzBPdU2vtnhlvUUN6uNYhIBHDliNoeKZ5c8R1M/4iWQ=;
        b=k3qfbOeNhcSvad8rONLnkn4eA/z4maORBOUoGmPs0bs5Ko5rv5/3eSD36IfB/kFTrX
         li9CU+JARqAbLZxpWIaUMyqfzxGnd/CRNeXtsFY8xsYKm9FzsTvSl65294+eFRdqYxQo
         ALUDCys3+rXr0Rf3vEgOkDY7lcPNoeE1YskZUHmgh4gxHZXCzwVZY72hcFAulWGCUoKz
         ZnC9CFI60NB91MfErtZjm0kfnBbG73gPFNKYGtnUd1R4rx3x1YPr4x+9He2Pig3omUwm
         TnrEFMTRKGUf+uZAswGKn7xEi2x2LLzjEp1G5W7A1Eg0FPiB8wfBG1Dn4NtndhsfjDKJ
         JByA==
X-Gm-Message-State: AOAM530Vhm/3gKhpXJcmAXRBYwHF93idc/UWx7/ADEm/Mjx1myB9KDrs
        SxL9QivN4pGzXMc75UCeTXU=
X-Google-Smtp-Source: ABdhPJxiqcEqC5BrTiVwur2vTVX4FC7YIqbSAOgCrJi/ZZWEGCWXKzOqWApHqOn4hRt2NLwrJXdKRg==
X-Received: by 2002:a54:4801:: with SMTP id j1mr1061070oij.62.1624475344744;
        Wed, 23 Jun 2021 12:09:04 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id l3sm134739oif.49.2021.06.23.12.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 12:09:04 -0700 (PDT)
Date:   Wed, 23 Jun 2021 14:09:02 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <60d386cecafeb_4290208e4@natae.notmuch>
In-Reply-To: <YNIBRboFiCRAq3aA@nand.local>
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
 <YNIBRboFiCRAq3aA@nand.local>
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau wrote:

> I do think that .DELETE_ON_ERROR is less robust when running "make" in
> one terminal and inspecting the result in another, but I'm also not sure
> how much we should be concerned about that. On the other hand, we lose
> a nice property of our existing Makefile which is that you can always
> run ./git and get a working binary. The new state is that you might see
> a half-written binary.

How would that happen? First, the git target isn't changed, and second,
gcc (and presumably other compilers/linkers) wouldn't write the binary
if interrupted.

-- 
Felipe Contreras
