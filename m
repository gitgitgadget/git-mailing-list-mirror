Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70E361F406
	for <e@80x24.org>; Wed,  3 Jan 2018 22:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbeACWSS (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 17:18:18 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:40498 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeACWSR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 17:18:17 -0500
Received: by mail-qt0-f177.google.com with SMTP id u42so3944241qte.7
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 14:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=K9YYxb/YLBMfdCbASoJmaWI7sEunYnkYKx92/mItTB0=;
        b=lreflPAPdqq/n/66ct5RAXrWwK7UgV7qCbwdFIB1Zq0fqdtFweqOaT+ohb795qiyRE
         5m/uRVgTVosp/rkug/UE1PXWpIgLGhHr+nfBBJRaZA46XIcWCcWD0+Pcqu7p0t2Cj/di
         SlN98gO92X1McsLgWaQfTl499H/iyXvzZ75uySVGVw4XnnHl0+jfDcaAfqrGL5Eh8YT7
         IdzkQWdhwbQ4B2TemRNmanOAMx1v/oMRar3F5K/TpAk/gMvNCy/L5U1U7FAj9/fp+sSL
         W1peDlUgd3NqsuBVfyZZc+GOeBCaJY95JdwvmQJljWDBJ/r64X0xlfaH92oOHzeSd8UN
         fGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=K9YYxb/YLBMfdCbASoJmaWI7sEunYnkYKx92/mItTB0=;
        b=FYEYfFWoqskiQZzQhJAv0A7QHOgYLmVObBX8+vRcov+D8f3e3zxsbLvvqgDVlkc8wG
         KVRfj6P4GfA4TXp9yINx/FmAFHCdM/gSyyxNL66AhY/xUkwbRLnP8GLHRLfPdlqrNnc5
         nXHyVh9jUQFyqTpFkzdBPkfJ0BwGZqcJcbggybdgy+T96D8bsDx6qG/ZGpZJnKR8z8S3
         mCNxoNdhDqEELgQQKWrFca1d5vT59Y7rE5auGF2u91+k9vWJFuKyCxc/Xx1nY+dDrr03
         MXWweXtTDSIhsIicAjzj6Rw3kQ99+2IXXDVWnMD+JOhPSGIDlr3katU6gwKuxk7ax8os
         cFew==
X-Gm-Message-State: AKGB3mJ8qBeghNt/V/fwNml8nJMG/f1Zf4MZiTZMqTMoM1M0H7lFtwLL
        sWR6bYgdBvwuWIJHUaob1BtyQrlOSAqdvShYSJayMVpBFU8=
X-Google-Smtp-Source: ACJfBotzxxAWniGZbeSJonHcUqRGx5u+C56Mk/XAP8VWvhO1xtzXKCFbTYPlT2gIkzcDqAe+xCjicvz7wHeyFlwUwQs=
X-Received: by 10.200.36.22 with SMTP id c22mr3837527qtc.207.1515017896826;
 Wed, 03 Jan 2018 14:18:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Wed, 3 Jan 2018 14:18:16 -0800 (PST)
In-Reply-To: <xmqq7esyh9ym.fsf@gitster.mtv.corp.google.com>
References: <20180103004624.222528-1-sbeller@google.com> <20180103004624.222528-6-sbeller@google.com>
 <xmqq7esyh9ym.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 3 Jan 2018 14:18:16 -0800
Message-ID: <CAGZ79kaef93BVM+Xaihad7cij-tc6DvWAgwo+Ps1zt_3Jn84Tg@mail.gmail.com>
Subject: Re: [PATCH 5/5] diff: properly error out when combining multiple
 pickaxe options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 3, 2018 at 2:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
> ;
>> +     count = 0;
>> +
>> +     if (options->pickaxe_opts & DIFF_PICKAXE_KIND_S)
>> +             count++;
>> +     if (options->pickaxe_opts & DIFF_PICKAXE_KIND_G)
>> +             count++;
>> +     if (options->pickaxe_opts & DIFF_PICKAXE_KIND_OBJFIND)
>> +             count++;
>> +     if (count > 1)
>> +             die(_("-G, -S, --find-object are mutually exclusive"));
>
> I thought the reason you defined pickaxe-kind bitmask was so that
> you can mask this field to grab these (and only these) bits.

Originally I only wanted to mask out the 'case independency'
bit and keep it future proof for any similar bits.

> Once you have that mask, you should be able to use HAS_MULTI_BITS()
> on the masked result without counting, no?

Oh, what a nice macro! Thanks for pointing at it.

As soon as I figured out the right place where to put this check,
I saw the lines above, whose style I imitated.
(I guess there is just no mask defined for "--name-only, --name-status,
--check and -s", nor would it make sense to do so; though that given
macro should work just fine even for non-continuous masks)
