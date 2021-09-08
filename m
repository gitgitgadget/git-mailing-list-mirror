Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8027AC433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E81161041
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352118AbhIHPde (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 11:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344656AbhIHPdM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 11:33:12 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4514C06175F
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 08:32:03 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id y6so4229426lje.2
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 08:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ta1RhGpvPJAOefwucxP2LFW2woWhfz98jVLHs6zOxUY=;
        b=LwSaB1ak0y0qPKa/T+opF0Gi5MYG0C2Ea/yqsuTzmb6krhEBDB0f6cpNZ3Ux2Ej5H3
         8IvWS+2/VZdiAqsWHuA5rYXr//CefCQYwC+OXsbUR8/+Y68DEBxk6MphzNjOFKmg2dcb
         2t+p+Yevvper6HsvydFGvS1VRku/PZEiL3dS5A7TtdmX8UuoZnGfE6H7xdRElviA47yg
         Fd0iy5wW+W9ZTHFiHloUmOUzI8rqKuQ71pNPZfTsMrvsXaQr0aghqodZWms9tEHyV7qB
         1PZpxiffgMQgzQKfjr5vlMZvGXalyqVyQSoK3WakmdNeWBBzKzoGmGIypQGG6f1CGWzc
         J8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ta1RhGpvPJAOefwucxP2LFW2woWhfz98jVLHs6zOxUY=;
        b=E/eS5DvL17n6x+9BFDRWTwZvNJLYAnpz9feE0L7Ej/G/166Q7ljkMN6FlfjKy3fWRy
         tp/p8/XPkkv6dSfXYhf5ObrVLXX9We0uaadl6AmuIEveLWxd2KFrSB8DWEhqTDFFiAMT
         JTNtGXql7fq9eb/heQyT0D1P4CWHF+vlTjaxjo8MQjBWaSGEHC77NIA7ZIMMeAvw4s8T
         XNrkb79Ny2wxhDmXZMTNmimtvEr9gAW4TdBjBFnMdn3r73JEh/SYqf59q3SQPwShKtwo
         HMre3fOMPyBE91aYuUWT3ppo49iq3TTzKEE6SbPEUrTGPcFU4zqP6VCGyhVNhqBv2s9h
         BGfw==
X-Gm-Message-State: AOAM530JVzIoNTZ6e/y57rsfsKwdO4SvfnOTR9EJH0quRyTxOGrkdjfd
        mCHTHBhDuzoPcYBK2vhJeqI1VpYb0NLiGxl2ZxMJbA==
X-Google-Smtp-Source: ABdhPJzUfi0RlqOGk36YbcGLGggfYcLqunY24a/6YEYGFEzv/RORLQeEUq6XOScesqT9wiU24i9L9r4QKN2HaU1JweE=
X-Received: by 2002:a2e:8808:: with SMTP id x8mr3436460ljh.220.1631115122155;
 Wed, 08 Sep 2021 08:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com>
 <cover.1629148153.git.jonathantanmy@google.com> <xmqq8s079al1.fsf@gitster.g>
In-Reply-To: <xmqq8s079al1.fsf@gitster.g>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 8 Sep 2021 12:31:51 -0300
Message-ID: <CAHd-oW5VBzZ+mgzsQ65eTD70q53+-Yri=pFW7ffvt95AmC7rVQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] In grep, no adding submodule ODB as alternates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 7, 2021 at 9:26 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jonathan Tan <jonathantanmy@google.com> writes:
>
> > Thanks for reviewing, everyone. Here are the requested changes.
> >
> > Jonathan Tan (8):
> >   submodule: lazily add submodule ODBs as alternates
> >   grep: use submodule-ODB-as-alternate lazy-addition
> >   grep: typesafe versions of grep_source_init
> >   grep: read submodule entry with explicit repo
> >   grep: allocate subrepos on heap
> >   grep: add repository to OID grep sources
> >   submodule-config: pass repo upon blob config read
> >   t7814: show lack of alternate ODB-adding
>
> I didn't see anybody comment on this round (and do not think I saw
> anything glaringly wrong).
>
> Is everybody happy with this version?  I am about to mark it for
> 'next' in the next issue of "What's cooking" report, so please
> holler if I should wait.

I think it's ready for 'next'. Jonathan addressed all my comments
from previous rounds; I also just read the patches again and all
looks good to me. Feel free to include my:

Reviewed-by: Matheus Tavares <matheus.bernardino@usp.br>
