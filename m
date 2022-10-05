Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BADC433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 13:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJENJH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 09:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiJENJE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 09:09:04 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF7550718
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 06:09:03 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r17so729eja.7
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 06:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dUI1DHTldYaNmkxO40VtkjEvr1U6rqk9EC7U9PjRIXI=;
        b=p4k5Wn2zlDzbxExfbWxvu0ZDRhPmaKocfv39RRA9e22x8QqJ484mT/+MPoMWI6mD/i
         eOxZDhSy2w65b6a4V65skBvzLOHfHoqbQ3AT0l+j+oOQV9h3xK1AecT7cRxACqkaJKr1
         10L9wTOUChNtuOlZCMj6GP4j+En1zZHrrDIFDb27HGugZMdjersgFX26nXQ4KpZpVqYa
         YQWkGfYeLJ2heSxKnTHfRNFPp8bt0TpFqTi9iNMDjp35N4WgqGaihrOvuz7tLVsPUVVf
         jl9rboPHlC/divEwC9vSEskpcOydWlr0BlSrwbg4ii5eefGl9q4S6FdJYLr1vojIh3Fu
         zaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUI1DHTldYaNmkxO40VtkjEvr1U6rqk9EC7U9PjRIXI=;
        b=bjOIQzpqPMVawrGn3wIzVP2idXwyrMctECjj/gdOfUMAv66C1Uj4SdPo1IPK+oo0LA
         EaON8HdM1Hd2yeHRMPpggV0A4DlnJ270cj7XcySZvHOET5+1xzzO6i//hoadK4P1hYyl
         oCsnO7ol1Q0nnUkT4MqoIYxLN58f/jOj0wIH/IoKCp+7KphAM9Q4854gyMf8KlVyDhpf
         bLgh9N0FbsLIkFwFAybxOTCu81uAfz7lfZuxKebb0UivEFwwKqL574u4x6TTB1E7gLA6
         lnVqmjzEFJm/9eACzPODRLjGHYvZJqVzxYBe0fKeQleEt92/Ti17iIv7bpaUFk36iWYc
         v5uQ==
X-Gm-Message-State: ACrzQf2aBJ1R98nJHkpM4xGmoFIc7DWeZwHKlHpUX86PWARUTZkNX5qe
        IrwFD4eEhd0KhzK/VEJ5wrw=
X-Google-Smtp-Source: AMsMyM4tsVkFfw06Sm3D8DGWcN85W+fhsVI7S5jy3CyOjiikGLjkpciJkojWuo1hunDbyJPQ6gSSNg==
X-Received: by 2002:a17:906:8449:b0:78b:74c1:ca32 with SMTP id e9-20020a170906844900b0078b74c1ca32mr11985351ejy.46.1664975326492;
        Wed, 05 Oct 2022 06:08:46 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b0073d7bef38e3sm8574403eja.45.2022.10.05.06.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:08:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1og48i-002YIC-1p;
        Wed, 05 Oct 2022 15:08:44 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 0/9] Trace2 timers and counters and some cleanup
Date:   Wed, 05 Oct 2022 15:04:33 +0200
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
Message-ID: <221005.86tu4is9ib.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 04 2022, Jeff Hostetler via GitGitGadget wrote:

> This patch series add stopwatch timers and global counters to the trace2
> logging facility. It also does a little housecleaning.
>
> This is basically a rewrite of the series that I submitted back in December
> 2021: [1] and [2]. Hopefully, it addresses all of the concerns raised back
> then and does it in a way that avoids the issues that stalled that effort.
>
> First we start with a few housecleaning commits:
>
>  * The first 2 commits are unrelated to this effort, but were required to
>    get the existing code to compile on my Mac with Clang 11.0.0 with
>    DEVELOPER=1. Those can be dropped if there is a better way to do this.

This seems like a good thing to have, but there's no subsequent changes
to those two files on this topic, so is this just a "to get it building
on my laptop..." stashed-on?

I think if so it makes sense to split these up, and as feeback on 1-2/9:
Let's note what compiler/version & what warning we got, the details
there for anyone to dig this up later are missing, i.e. if we ever want
to remove the workaround syntax.

>  * The 3rd commit is in response a concern about using int rather than
>    size_t for nr and alloc in an ALLOC_GROW() in existing trace2 code.

This small bit of cleanup also could perhaps be submitted separately?
It's unclear (and I read the concern in the initial thread) if this is
required by anything that follows.

