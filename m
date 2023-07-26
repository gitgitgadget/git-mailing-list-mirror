Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A79EB64DD
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 02:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjGZClV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 22:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGZClU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 22:41:20 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896412689
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 19:41:19 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2682e33509bso1293265a91.1
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 19:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690339279; x=1690944079;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/OgFhZBtOjI5qdKBpdprRwNoGAvh9EAkCgTvWXE7UpM=;
        b=llaIwmvbNggMBxaIK5qkZPWucycE9uIQEsVLuMeqbOWpDSEUmSTFJJbcmLt4LrunaT
         9o7rAtCLRLO9rsEmxRlnU29HakBsBydkT2S04zC//+Fet2gncIriuUdBGidNNPFMXVAG
         VFvowUl0z65mDufV6IYsAf6fasPxfq8VotS1FsQYKWqfMlYzrC+IWsyMpTS16B4J2Cj9
         RlrV70+FuRCsel1k1+iUktRCWhN3RBZPyPXlrBGhH9fqnIHQPiNs1mEPTfJfPMlzv7ba
         oITUHNUUrOuVCCfMSri0KEE8LKL2grfWHlkVYZjNbJUsN8bH9ezB1CaFA9RSFpzOB3og
         nEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690339279; x=1690944079;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/OgFhZBtOjI5qdKBpdprRwNoGAvh9EAkCgTvWXE7UpM=;
        b=L2k8LL+p+tG14al9oiqN3pL1ILnTHqeJu+ZVcztvu2k7bm/EoGwSU2jzKhUB2imoVX
         kRH7pFQL4F0lD7voakpcvX9mb6AsQXE9/i4IEF2tIN0XsFbdpOSUi86uIxvyQud3NU4Q
         et+YWYUXj0rUtiehDvbFVxOGg9/u1SCe8YrpbQvcQJl0pMuZs8KdYn3oYuk+ACI2fWEa
         9K+dshphb9h6TbWhMire/0uaFW8GA1I1PQXuyzVYYJsCJbZxzn9rerrvsm85XY14GbKq
         9GZngPO7IWFnFZdrv2raQRfdfFgFl2VeQn/zUeysQ5EadEeVGDMMLvkH/xmZ/pw8syEx
         aI6Q==
X-Gm-Message-State: ABy/qLYhB7tCG3oh4aEmlpMKDZcy7O6skTBI1uEjMt++BmCcSmTh9RqX
        Hal+bIKsRlzQC5KTdMbqrDw=
X-Google-Smtp-Source: APBJJlHnhR2Ls3fRaxBGgznZVlnFcgWUCFohVcI4RE4ivnh7D+kTPmyneWjYBKH72nNLqMRxiGxv8Q==
X-Received: by 2002:a17:90a:3fcf:b0:268:99f:b2c1 with SMTP id u15-20020a17090a3fcf00b00268099fb2c1mr882128pjm.26.1690339278879;
        Tue, 25 Jul 2023 19:41:18 -0700 (PDT)
Received: from five231003 ([49.37.158.10])
        by smtp.gmail.com with ESMTPSA id t2-20020a17090ad50200b00267eead2f16sm216017pju.36.2023.07.25.19.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 19:41:18 -0700 (PDT)
Date:   Wed, 26 Jul 2023 08:11:13 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2023, #05; Tue, 25)
Message-ID: <ZMCHybvLPQ5_MVuR@five231003>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzg3jhd8v.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> Nah, that is not worth it, as I've already done ! -> test_must_fail
> fix locally yesterday.

Oh, thanks.
