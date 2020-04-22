Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9369C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 15:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C555C20776
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 15:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDkHugln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgDVPk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgDVPk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 11:40:28 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF3DC03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 08:40:28 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n24so1065046plp.13
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 08:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7Fa1eqJveotSoQB67d+xppePvVImOl4eA5JWWLLaKTs=;
        b=JDkHuglnHFh0+iQK12miFTXW3T9/vysLbeWuXfVGiGbJi2OyRjvmTJmAfAVE/LoOCV
         Xyfd1mrB2/hvHfr56f2YSnTsOXaVrd6nAbk5psn6Jblm1jnrF/Hb/pcT1w0NTK3duCiy
         dNnSlEfEHpH+7c4CjgM9sfESyv6fzfcqNwb9/D0el5ROvOFJpjGIRKKW58Wr6O1PYbiw
         GWdA228QaTU+hLZ0EtZhP5hUgRafQbj8MryTYc+QnzosrENkdfizlkYZSDjEKSCs8XiC
         RbrIOtMpn6EiWCMvxpaYJq/OsxyxrC1o6phJslYUOO7CAJAGyZvwBOrzs8Ofio351USN
         QDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Fa1eqJveotSoQB67d+xppePvVImOl4eA5JWWLLaKTs=;
        b=HLeISAfIj87B7DuWvqPrqmEW0JTTkC0g6HLr0MDP9N2sRTGZDCG7p90LCaPX65EG8v
         guioppM3eh5jM7p5Wt5xY4ya0n844XGyF5xeMWyhqgG3KJ9VfOyrxj0YVTboWRZFiGA4
         X3JcCElpQLKV4jXp2U643gLWFqWOLyavoDrSbhRSL6F8/Tk2klxv0UL0QCvE3EX6mVRe
         UCIzoweLEUGm5g+HpIGHrlR7b2y/M/eolkSvseBH+h8EWL/puYsckwf8kfueRndgpDjD
         0LxP0Eq8xi+9VtsedATHyBSGVcCtpX/Yg72AROALquLUkj5UxLbSKukdEz/H5bquVPTD
         8/8A==
X-Gm-Message-State: AGi0PuaDnnIK4WcyStBMeKkIoqnT4XMSYCcOEbajohI4YDAOZuSkgrja
        ZdNVggqW+q/E+KBIwrcZxuxtzH7l
X-Google-Smtp-Source: APiQypI7yG/gnBoslvHOrdAxJsZMU0muP6APJ1xe+2JFQiGkynj027T5d6F3opgZzAWUofSQXf1m8A==
X-Received: by 2002:a17:90a:1da6:: with SMTP id v35mr13297978pjv.44.1587570027474;
        Wed, 22 Apr 2020 08:40:27 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id a16sm5477576pff.41.2020.04.22.08.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 08:40:26 -0700 (PDT)
Date:   Wed, 22 Apr 2020 08:40:25 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Git 2.26 fetches many times more objects than it should, wasting
 gigabytes
Message-ID: <20200422154025.GA91734@google.com>
References: <20200422084254.GA27502@furthur.local>
 <20200422095702.GA475060@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422095702.GA475060@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+cc: Jonathan Tan)
Hi,

Jeff King wrote:

> Here's a recipe based on your fetches that shows the problem.
>
>   # start with an up-to-date regular clone of linus's tree; I had one
>   # lying around from https://github.com/torvalds/linux, but the source
>   # shouldn't matter
>   rm -rf repo.git
>   git clone --bare /path/to/linux repo.git
>   cd repo.git
>
>   git remote add next git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next
>   git remote add xo git@github.com:hackerspace/olpc-xo175-linux
>   git fetch --all
>
> The "next" fetch grabs about 30MB of objects. But the xo one downloads
> 1.5GB from 7.4M objects. That's using v2.26.2, so protocol 2.

Thanks!  I'll give it a try.

[...]
> There are a few data points we've been wanting to collect:
>
>  - does setting fetch.negotiationAlgorithm=skipping help? Yes, but not
>    as much as the v0 protocol does. It sends 84k objects, 33MB.

That's pretty good.  Tightening it further would require changing the
protocol to allow the client to say "please don't send me a pack; I want
to continue with negotiation".

>  - does the same fetch over v0 stateless-http have similar problems? No,
>    swapping out the second "remote add" for:
>
>      git remote add xo https://github.com/hackerspace/olpc-xo175-linux
>
>    results in the same 48k, 32MB fetch. The v0 conversation involved 10
>    POST requests. The v2 conversation only took 6 (and generates the
>    same big response as the ssh session, unsurprisingly).
>
> So it really does seem like something in v2 is not trying as hard to
> negotiate as v0 did, even when using stateless-http.

Interesting!  So it sounds like some refs that are not being fetched
are important here to the negotiation.  And the default (non-skipping)
negotiation algorithm is doing a bad job of exploring that part of
history.

Will take a closer look.

I think this still suggests that we should go ahead and switch
negotiation algorithms, both because it avoids this MAX_IN_VAIN and
because it reduces the number of rounds needed to make progress.

I'd also be tempted to get rid of MAX_IN_VAIN.  If we're at the point
of giving up, shouldn't we error out instead of having the server send
a copy of the entirety of history?

Jonathan
