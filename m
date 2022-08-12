Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FE0C3F6B0
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 15:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbiHLP2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 11:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239046AbiHLP2l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 11:28:41 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616CA7C769
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 08:28:40 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e13so1737125edj.12
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 08:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=EVU7LmRm8C52Rrx4hDu17SM1268DlFbj92D/0Il7Df0=;
        b=V1ebY7Bw+dNv+PvrBFMTAFdtvGRmis8abzUhK6xPf7MKKLtYH+wEYNaEtxA1hqrNIe
         QCh+NZmOso50xM7/P2TdNBy5AVD7DTt0kamknAScVuPv1U+7E9BrBwvHYi3AMsMLfJDW
         MYSfWBnQM+1y/k2TpXixDquoryRvzHOTq1ME0rQc2EPPKmJrM28TIly1v5l2vBoqB9uY
         qjiZX3gTtUsYGpqWYn9bfY9zOUGCDopQJFMA2DGbrnbqE0T945HqGLf4I4EftuRBZ+QC
         COn45Dy4PrMTXkh6NCm9/9f5zX/CTxoxnAvLp3EomgxV/Y/5rquXRSwrqCFdQZT6G8iP
         4SoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=EVU7LmRm8C52Rrx4hDu17SM1268DlFbj92D/0Il7Df0=;
        b=tyoofqIW3unYWuhNpHHM9EL51yHezwB5uX9MFBp7P8yWq0e91MKgMorZ95JP1sda6Q
         0ukjCZQW5CtX7Y9Jz2V62ABN3IxM7+U16Vf5wtdB6GIqcvTgXdFFlgkwTBJaurEvBztY
         EsizfDPrfzmVz/uLaHPioHWSzkuXqtxw59Iigtsb3Ea3va0vZ81KoWnqLMDvj72Obbkj
         1BTdLaQ+LV/Y2wezIMTCKUn9sPLHB5XavvnvAVzWUUh/VRCweJUeHCbmV6XDfyeilqj8
         teYY0jZYby2ADHMYKdi7+WiKmQoYdhvxZmzmMa7vtI72KGGzkPjyO2PUDMINasIitAyA
         eYDw==
X-Gm-Message-State: ACgBeo0bNTVKsqkSvAIyaesAM2yzkchi/e/zNbs83dAo+2AxQlRblIaR
        /Xjn/jr5/W+OWZf4ePrWdS8=
X-Google-Smtp-Source: AA6agR5tVg3Qiv9KmdVNowhaLe7Jo3W1QTvhD41QGAOKpPZSPWaXlbfLfoB8oIieZYzorh8MFTwEkw==
X-Received: by 2002:a50:ee85:0:b0:43d:3e0:6157 with SMTP id f5-20020a50ee85000000b0043d03e06157mr4170466edr.19.1660318119007;
        Fri, 12 Aug 2022 08:28:39 -0700 (PDT)
Received: from localhost (94-21-58-102.pool.digikabel.hu. [94.21.58.102])
        by smtp.gmail.com with ESMTPSA id h14-20020a1709063c0e00b007313a2575d2sm884746ejg.104.2022.08.12.08.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 08:28:38 -0700 (PDT)
Date:   Fri, 12 Aug 2022 17:28:37 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 01/20] git.c: update NO_PARSEOPT markings
Message-ID: <20220812152837.GC3790@szeder.dev>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220725123857.2773963-2-szeder.dev@gmail.com>
 <220725.86mtcxp8ib.gmgdl@evledraar.gmail.com>
 <20220802173754.GA10040@szeder.dev>
 <xmqqsfmefjja.fsf@gitster.g>
 <20220803213430.GB10040@szeder.dev>
 <xmqq8rnuea60.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8rnuea60.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 11, 2022 at 02:35:03PM -0700, Junio C Hamano wrote:
> Yes.  I thought this series was mostly ready, except for a minor
> nits in the way things are explained in the proposed log message
> in [09/20].  How would we want to proceed from here?

Please wait for the reroll.  v2 is getting along, ever so slowly, I
think I'll be able to submit it over the weekend.  Thanks.

