Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34C3C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 18:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B79DB61029
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 18:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbhIPScY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 14:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343589AbhIPSbv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 14:31:51 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CFFC05BD36
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 09:49:16 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id w1so7298935ilv.1
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 09:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=upvP61WWN51rME1dKM68hxUGscMW63IwTUwA1W7conk=;
        b=IkpEO/oGM+ViPH3QulCBcKf3z4vo5KWyi5IgJCbZUq/0bp0MFNd+VgGHOq3rO4GdNV
         wdVTEjMLp9diH8SBeNx5dGp7VyzAZGiLwcvBeZVfINUzVbBhmkclfEObqTC2+Kdi03Zp
         g6F7LnIACwyE4ETfqPIpbz8dwoE5GmS8iy4EbM+GoM0AGAoTR8Ae2Cz6hR+fXHmFVBtf
         oVBxpN25FdiILV8DFmVt6SLFwXlaxS4Fw2EB7qtHW18eWLjw22+Rnx3zJ4WHOUYQshfI
         4VjR2Qi9swQTNbRGh79TSJ900dz/WwoiWCj5zxuL+Vo72ea6Lj7ehoKoiwtSzv8ziKVq
         A0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=upvP61WWN51rME1dKM68hxUGscMW63IwTUwA1W7conk=;
        b=mGZQH7UOBFYXCte3LmC1N8zAbci0Kwd4IQMvA+ojRvY/lLTOAd41GOPsfzJVIPu9xS
         ve+ztZzaRLgXWrQ/Bl2dPbBWBFYynsISpnMSkC6eqXL1eEwRJWa6nPv7Xfamp/h1IA96
         fSoTH40z4IGq6fh55/h/AEwUfMPvvRidOSuJnGoA+jh12C9iH6GFbTfT4RLGls7juR4U
         PPc8tttOmj16oOATHs9adKlLG9Kgdub3GfFibecW4A20CUcYV7edi/LIIpfQC7g+WbxQ
         r8+xnG4tcNC1oe61FDncn8kkVRqNV0e4yrMei37HeuzdBY4JWUCY468q1eO0rn7bWaB5
         WU8g==
X-Gm-Message-State: AOAM532OvEFTNQnKYIHhUkCJRbCgqASXtPgXUH69vSnxPXPo/BBATMq+
        fuq0BGL3vo6MAjo84MkqBljAP6wyopeV7OVq
X-Google-Smtp-Source: ABdhPJw27Ac9JxxquYNRfJOz6FmPJuICDcJbXHjPMslGPIDWmcxTJkHVrM0S8XOECl+3Ikgh2yfeOA==
X-Received: by 2002:a92:b301:: with SMTP id p1mr4489396ilh.10.1631810955669;
        Thu, 16 Sep 2021 09:49:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a21sm1987366iot.43.2021.09.16.09.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 09:49:15 -0700 (PDT)
Date:   Thu, 16 Sep 2021 12:49:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 2/2] t0000: avoid masking git exit value through pipes
Message-ID: <YUN1igX4f4hLUMvA@nand.local>
References: <20210916023706.55760-1-carenas@gmail.com>
 <20210916023706.55760-3-carenas@gmail.com>
 <YULUS3kYkB4RXv2K@nand.local>
 <xmqq8rzxujhb.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8rzxujhb.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 11:23:28PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> +	tree=$(cat out | sed -n -e "s/^tree //p" -e "/^author /q") &&
> >
> > In this and the below tests which had a similar transformation, the
> > first invocation does not mask its error, since it's on the right-hand
> > side of a pipe.
> >
> > But piping "git show" to sed will mask the exit code of the former. So
> > that makes sense. But I would like to see us avoid an unnecessary
> > cat-into-pipe and instead redirect out into sed, like "sed -n -e ...
> > <out".
>
> [...] or for commands like "sed" that takes its input from files
> listed on the command line, you should be able to write it without the
> input "<" redirection.

Even better, thanks for noticing the flaw in my suggestion.

Thanks,
Taylor
