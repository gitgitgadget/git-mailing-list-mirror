Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5272FC00140
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 17:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240208AbiHXRdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 13:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240213AbiHXRdM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 13:33:12 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FE47E306
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 10:33:11 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id j21so29490136ejs.0
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 10:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=oxh1v8n68rd2gtYQE+xlAZpNrBCVeb/+23gMYHPvI/I=;
        b=QUIddHy0QMch+TpqQYc+jsxdRQceuNAEu22t3p63OJN9oAIDNqpr38vHPbq0Y+eIAH
         CQ3i0+rD/C3w07lnVr7R6j4pewBoBOFBESDaw20Atki/w+KwCZfEENSKd+2Ayn94EcOs
         YXKQ/vQS0kqKL69468zCuJXz+6WJD3rvwu6pHIWlE+Z42PCznxCvtf95oX24EFdkapk0
         P5nmEkwq+TtdQbkIgcCv8t9WniHk08o+Xp1ob03fv52aqMUoDxEBZ5/9bPfhRHKodter
         S4H7nXaTodMCQn6MUD6YyGwYZQ2vBHQitzzEwrwEQgmk5HO0Ee8du1nIDX1Fyjq49UsC
         Lpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=oxh1v8n68rd2gtYQE+xlAZpNrBCVeb/+23gMYHPvI/I=;
        b=hWgMyHj5ATTINpzFe2B8ZJZmu8oahFZJkn4ToTjJugT8LzUwvCaU1kGBvGcRuUpxo5
         CqGPJqq6Ghluzqf+8NErES7k7GTTdtWtHw0Har1U4cCxTrcbn4uVaESB6Rbf41AeWocN
         8JYDciVe7QoC0f3/gVPHqsYlwSecjmbIFMZsPkg2qFURAoOHWJaYYU4D51eJUD3UfT6N
         ohRG6aP8Wyj9Ih82iCipxwIG88dghf+nCfcS/pZQkbMWkfNBMZbBZdHWzlpOtJMe6IsI
         mBwMIP01VHH0ggVVvCiWIeEtS2LgVR+q4aI9uCfAXACcIJ+MBnE0PBw0jngtQUezIAKd
         quTQ==
X-Gm-Message-State: ACgBeo3Ix1nV7o+NOiAM3+kgQdRdtBOOexkt2wnUFCv+rvzwK3kFwoXU
        BEV7Y20wbqGskea3XoF4ZUw=
X-Google-Smtp-Source: AA6agR7AObYidWUblTVm3p2GuKO3fkuODz/fhc/xcFfMvqrobZ/fI9SGtEIDCS+1UDCRdX7twBkv/Q==
X-Received: by 2002:a17:906:fe46:b0:73d:939a:ec99 with SMTP id wz6-20020a170906fe4600b0073d939aec99mr18474ejb.169.1661362390010;
        Wed, 24 Aug 2022 10:33:10 -0700 (PDT)
Received: from localhost (78-131-17-114.pool.digikabel.hu. [78.131.17.114])
        by smtp.gmail.com with ESMTPSA id kz3-20020a17090777c300b0073dafb227c0sm1388989ejc.161.2022.08.24.10.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 10:33:09 -0700 (PDT)
Date:   Wed, 24 Aug 2022 19:33:07 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] promisor-remote: fix xcalloc() argument order
Message-ID: <20220824173307.GF1735@szeder.dev>
References: <20220822213408.662482-1-szeder.dev@gmail.com>
 <20220823095733.58685-1-szeder.dev@gmail.com>
 <xmqqwnax8wgy.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqwnax8wgy.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2022 at 08:58:21AM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > Patch generated with:
> >
> >   make SPATCH_FLAGS=--recursive-includes contrib/coccinelle/xcalloc.cocci.patch
> >
> > Our default SPATCH_FLAGS ('--all-includes') doesn't catch this
> > transformation by default, unless used in combination with a large-ish
> > SPATCH_BATCH_SIZE which happens to put 'promisor-remote.c' with a file
> > that includes 'repository.h' directly in the same batch.
> 
> Our default SPATCH_FLAGS is actually
> 
>     SPATCH_FLAGS = --all-includes --patch .
> 
> and I am wondering how "--patch ." part (or droppage thereof due to
> overriding it from the command line) affects the outcome.

'--patch .' is not part of SPATCH_FLAGS anymore, and for a good
reason, see the recent 7b63ea5750 (Makefile: remove mandatory "spatch"
arguments from SPATCH_FLAGS, 2022-07-05).

