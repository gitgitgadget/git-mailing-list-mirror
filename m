Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF61C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 13:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A268C20848
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 13:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="bO6DgiTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgJENNf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 09:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJENNf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 09:13:35 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FCEC0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 06:13:34 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 184so2139780lfd.6
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 06:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=srahM4/JzVXkTz+NdrWN9Yhmk/q1Otsz2/ji3cvwkiY=;
        b=bO6DgiTdAe0KDsM270X0ycN5vb7X8rYgQhdzZg2D0SkUNSkYxEC+NALpPnlW1mli81
         CzMQae//f5t45tOZIp0eCsSnuNOtLMaffJ27GpNnACHRh/oxQfM+2eVmPIICqVh44Wih
         ikzzxw680Wufqt11LL7P3EUlMNXQbUqunZlx5m02bHokxvdu7+DO+LZuDdKrrYTalTif
         6uENTjD56/xn8sh8Hu4bvlmXAESBWlTN0ndZP/3WoYxFcdGRX4ab7x0TOo2h8fTc1xaJ
         eHHrprpRGU865b4ZzcvxrPsaFytOegc1Mk4I29ekf0KEysW08p1t5nmxBl3zcsjHwQu1
         iHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=srahM4/JzVXkTz+NdrWN9Yhmk/q1Otsz2/ji3cvwkiY=;
        b=Z+gyCJbMLqDLaL6sAKnZ86D7Y04Kac3qPm0tO71ihNom4jrtWql4wgCZDSOetHNnL5
         M9733WuB6mV1AWwrtaSJEoLlDqRJc6rmuBuPl9RJNi2YGjFwYeDQG/xT9JvfkOc5ByOz
         ZkhQblJmdZ959nPEzyY8TFFIm2fugs9gB52CMss0GItk1xr/DOunGjdwPj5gEsfDQ+Ta
         d6ma/I+LuRBr3mtUMo9kj5JmShSmlNtyim/5bl7nUeMIY7hky7pTOYMvf2J6FeDU9RCz
         TutEM/ATXKrzsP/ShMFrZOpkAfsLdjNMRvqjIhuScAPmIXP7+EXI1RW+yjQLZXtZbush
         H5rg==
X-Gm-Message-State: AOAM533iJMh+hA1X7HDbbxkW7T4MZoWV8qJ4lPHb243r6yE0piGYS1H2
        BsFhgxXbLD6uQsWU5EwSd53JaXSCXO0L3RjpAJFLoeC9UEYfTQ==
X-Google-Smtp-Source: ABdhPJyh9oAVetuARMl7e/67J8FsJBc9Grb2miShEqWWu0qVdr5F/MSt0f1CfNZvrw5+qw6QQ+cWj2NazRc7f9u45T8=
X-Received: by 2002:a05:6512:70f:: with SMTP id b15mr5498790lfs.39.1601903613051;
 Mon, 05 Oct 2020 06:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600814153.git.matheus.bernardino@usp.br>
 <af0d790973b1e52da0fc9c4bed95e93d995d68da.1600814153.git.matheus.bernardino@usp.br>
 <20201005061732.GA2288306@coredump.intra.peff.net>
In-Reply-To: <20201005061732.GA2288306@coredump.intra.peff.net>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 5 Oct 2020 10:13:21 -0300
Message-ID: <CAHd-oW5=ipx9RY_W44GFUSO=O1eDwWirfrjJfpv-xy8yqe6L4w@mail.gmail.com>
Subject: Re: [PATCH] parallel-checkout: drop unused checkout state parameter
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 5, 2020 at 3:17 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Sep 22, 2020 at 07:49:24PM -0300, Matheus Tavares wrote:
>
> > +static int write_pc_item_to_fd(struct parallel_checkout_item *pc_item, int fd,
> > +                            const char *path, struct checkout *state)
>
> The "state" parameter is unused here. Maybe this on top of
> mt/parallel-checkout-part-1?
>
> -- >8 --
> Subject: parallel-checkout: drop unused checkout state parameter
>
> The write_pc_item_to_fd() function takes a "struct checkout *state"
> parameter, but never uses it. This was true in its introduction in
> fa33dd99f0 (unpack-trees: add basic support for parallel checkout,
> 2020-09-22). Its caller, write_pc_item(), has already pulled the useful
> bits from the state struct into the "path" variable. Let's drop the
> useless parameter.
>
> Signed-off-by: Jeff King <peff@peff.net>

Good catch, thanks.

I was going to suggest squashing this into fa33dd99f0, but I noticed
that mt/parallel-checkout-part-1 is already in next. We don't re-roll
series that are already in next, right?
