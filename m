Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9B0C47088
	for <git@archiver.kernel.org>; Wed, 26 May 2021 16:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103EE613C9
	for <git@archiver.kernel.org>; Wed, 26 May 2021 16:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbhEZQuO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 12:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbhEZQuO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 12:50:14 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFD0C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 09:48:42 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id e8so1059569qvp.7
        for <git@vger.kernel.org>; Wed, 26 May 2021 09:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tCwHOAs6EXb1N8Np2rzFfi/syb592WSsA6BFIfIMSgM=;
        b=2IjXdCAMx44aiPN4NSNSZrEUZq8xPHauCveBr5r5urmjcYrOVIMXSjUVSduFQzaxjH
         1YinHhUlvZ6gf1q+HR2ysUFMae4LNDPe2lPSygniqwJb3Si/VslVWE1wfT7KQ6opI6Np
         95P9VSDuskzsuaTLWK7AaM9QcCgO5WkCFoiM30lfK1GnUQ7PuhAKdrq3i2evPBsJWAq9
         voj6dH78/eUUKUfs+fpm3laezmwq/u1voKA+1t/5VpPcy+oBaSyT0R8BNgSVa7dz3IVR
         1K3JXKRrtMFwd08utXSugWXFcTML+pWdkVN4ACDrOgO1lOSjMtvW7WdE0roNT7hXUaKQ
         7b9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tCwHOAs6EXb1N8Np2rzFfi/syb592WSsA6BFIfIMSgM=;
        b=qN/6lnk85fpSmIpYaKIfv6ooFQCPl0gmKMty+pW9Cdn458ihmrzvZ0PQOE++CnvWlv
         8e+A7VHg/4kQu65lVKB7OJTkc6tjUbLnoUixH0d8ZHnoU9V4PbT/87DmHCCDQN2Ldgwy
         mFf6wmDZ6X7cCasIs0N3lt092S6e5UTB9vcukUIFDvTeRVc0BPC9mzZ3w6pFFoFPoiBN
         8rL6m2LFHSn4UpRUuEFhX89JlfbNxoRiMxC7M8vr03m7h0MJut+vD5At9EsnfvCibhhu
         b51CfgQsQDUpLl/RU8e2qhnhRDJFn1G8IQ72g1bDZqQ8U4DuyRfFVY2QwsvKAy9y3Vgj
         QUJQ==
X-Gm-Message-State: AOAM533ZbGz+LBE38SpjSlqKAng/DcJQ96Nnx/MFTCfr08fMSvloOqyz
        bOkVGkNZ0c0MdfSuKw5ymmAcpQ==
X-Google-Smtp-Source: ABdhPJxDbsZ2ZkC3nzTMjEljZZPEoVlVDrXTqtAoNwHRnmZ0l0VLs/gUFk5TxqCvfBGwzBQyUbcNDw==
X-Received: by 2002:a0c:efcf:: with SMTP id a15mr43053497qvt.55.1622047721726;
        Wed, 26 May 2021 09:48:41 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:fd7b:5b8e:7238:b804])
        by smtp.gmail.com with ESMTPSA id p10sm1862829qkg.74.2021.05.26.09.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 09:48:41 -0700 (PDT)
Date:   Wed, 26 May 2021 12:48:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Avar =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: CI: 'seen' minus a few passes tests, eh, almost
Message-ID: <YK5754JqOUXL/+/L@nand.local>
References: <xmqqcztecuy7.fsf@gitster.g>
 <xmqqzgwiawm4.fsf@gitster.g>
 <YK5dubBcSwm9c4Ta@nand.local>
 <YK5u/qxFJUr9d/qS@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YK5u/qxFJUr9d/qS@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 26, 2021 at 11:53:34AM -0400, Jeff King wrote:
> On Wed, May 26, 2021 at 10:39:53AM -0400, Taylor Blau wrote:
>
> > On Wed, May 26, 2021 at 02:32:19PM +0900, Junio C Hamano wrote:
> > > Just with a hunch, I further excluded tb/multi-pack-bitmaps from
> > > 'seen', in addition to these four topics.  It seems to pass the
> > > whole test suite on both 32- and 64-bit build combinations.
> > >
> > >     https://github.com/git/git/actions/runs/877225207
> > >
> > > Except that vs-build sometimes fails to download the sdk, that is.
> >
> > Thanks for letting me know. I have accumulated a few local changes that
> > I wanted to include in a reroll of that topic, but I was waiting on
> > other reviewer eyes before sending it.
>
> I think the best thing in a situation like this (where reviewers like me
> have been very slow to respond) is to repost it explaining the
> situation. That makes it clear what the current state is, and brings it
> to the forefront of the list's attention (both reviewers you'd expect to
> look at it, but people in general). Doing that too often can be
> obnoxious, of course, but after 6-8 weeks saying "hey, this didn't get
> attention; can anybody take a look at it?" is perfectly reasonable.

Indeed, but I had been putting even doing that off. I've had some
sporadic time off in the last few months (as you know) and so usually by
the time that I'm back enough other stuff has accumulated that I don't
feel like adding more to the list by encouraging further review.

So the topic (and my participation on the list in general) has kind of
languished, but I'm hoping that since things have mostly cooled down for
me outside of work that I'll be able to participate and submit patches
more consistently.

Thanks,
Taylor
