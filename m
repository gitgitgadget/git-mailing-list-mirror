Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C3FC433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 18:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B289220936
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 18:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="kWFFAvHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgH1SJm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 14:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbgH1SJk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 14:09:40 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB58C061264
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 11:09:40 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id s15so31172qvv.7
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 11:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lnWM1R7yk677Qta9uEV0onlehLiqa92bnYzCsq3CTyU=;
        b=kWFFAvHWXcSDF2zVaw8MyDLUj0jVxjENAlLTdTv9NQ/jhOzhNpyP1h0gja10WzB248
         sK2bPSRMOif+86yeWq594EUtBOiPIp5QQiU6HDkPzNq24HmiJd3dXUvwZy/TYbviJ16p
         QAV51BJ8JTTc/CUPJSQjBNXKvUg3ZwvfH/AB3mj+dV8aZnpWF4GFRfjZ+e3HBjvBpRF1
         gnIVwwQd6W5EycdSdnfHO5bCgtvVTf/0GcfIeFvnzhSOCl0PW6EupghlNM0p0ZGVxeTx
         pujZiIkYhe70+1TbmAE6JHvKM0OP0YE5UHDWqw/eLUf3vmU4xzlwnDeY0S6pkwG6BAva
         VJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lnWM1R7yk677Qta9uEV0onlehLiqa92bnYzCsq3CTyU=;
        b=XUegiwxHqUuU0TogKWlZALJ4Fn2LB3UM2ovZBqcT1U8EZzBFY2O07uVF9RORIq8VNz
         7wIyJwknMLcZOtc/FkCHuhi0j9YHsDIbXwxCKABXQViVFB1bgjCPtFZGSKsw8G0KsKjH
         Rm/X6tFllC/QHbP8SORbP1dZgUGkNaUzHTrA3AuZL/ihbcZ2dTLIPBeHJsFKK1t2xDpE
         6toy2OTxmF11jAoCnYplQ3sxTIgPOOczKPA78MjmpOHeEWhuzXqYLE2TuKm5C8NXBLRc
         fDNkHYcD49IE5fh4eHkQ7+O3x2qLfZfl4ab7EB2nmDFB1iB6v+kX7PBuhRe+oLrE22xA
         O2og==
X-Gm-Message-State: AOAM531TXbltQgCyj2mo1yajz82eevL7j1OS4xVix6Mr3nwN5WNcMrrQ
        GCaIxOKWMatO10NA+vM4F9rspQ==
X-Google-Smtp-Source: ABdhPJw6MoTNgMbjcd6/ZgSCKBCnRLA1geRTx63mmufAWl9l96BcrtYR4Wk4hnYO5EnivsnGn9UkBA==
X-Received: by 2002:a05:6214:1454:: with SMTP id b20mr3061365qvy.35.1598638179485;
        Fri, 28 Aug 2020 11:09:39 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:f08e:2c2d:3ae3:2fac])
        by smtp.gmail.com with ESMTPSA id f3sm1490267qth.56.2020.08.28.11.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 11:09:38 -0700 (PDT)
Date:   Fri, 28 Aug 2020 14:09:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #07; Thu, 27)
Message-ID: <20200828180935.GB19328@nand.nand.local>
References: <xmqqh7snpxy1.fsf@gitster.c.googlers.com>
 <20200827233454.GA3973432@coredump.intra.peff.net>
 <xmqqzh6foe44.fsf@gitster.c.googlers.com>
 <20200828003940.GA80266@syl.lan>
 <20200828062619.GA2100989@coredump.intra.peff.net>
 <20200828083125.GA2139751@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200828083125.GA2139751@coredump.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 28, 2020 at 04:31:25AM -0400, Jeff King wrote:
> On Fri, Aug 28, 2020 at 02:26:19AM -0400, Jeff King wrote:
>
> > On Thu, Aug 27, 2020 at 08:39:40PM -0400, Taylor Blau wrote:
> >
> > If I'm understanding midx_contains_pack() correctly, then the code
> > looking for ".pack" could never have matched, and we would never have
> > deleted a midx here. Which makes me wonder why the "repack removes
> > multi-pack-index when deleting packs" test ever succeeded.
>
> Sorry, this is all nonsense.
>
> I forgot about the hackery added in 013fd7ada3 (midx: check both pack
> and index names for containment, 2019-04-05). And anyway, the patch
> above is totally bogus because we need the ".pack" form in the buffer
> when we call unlink_pack_path().

Yeah, 013fd7ada3 is definitely a hack, but what you have is definitely
incorrect.

> So there's definitely something more odd going on in that failing test.

It's the funky order that we load the MIDX chain in (which is that the
MIDX belonging to the deepest alternate shows up *first* as
'r->objects->multi_pack_index', and that the local MIDX shows up as the
last thing when traversing '->next').

I sent what I consider to be a little bit of a hack in [1], but it's
definitely enough to fix t7700.6.

> -Peff

Thanks for reporting it.

Taylor

[1]: https://lore.kernel.org/git/20200828180621.GA9036@nand.nand.local/T/#u
