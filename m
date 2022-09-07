Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609FFECAAA1
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 02:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiIGCLZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 22:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiIGCLY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 22:11:24 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97094895FC
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 19:11:23 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q63so12228339pga.9
        for <git@vger.kernel.org>; Tue, 06 Sep 2022 19:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=FxPPDVOMtQ/8qtYP/R46s0jJ/Tz8uV3XTZ3G5J/st6s=;
        b=OCeFlobqJ1vimb/D9lHirk1muZ8bMecHpAw1DPhwaWomCnF3qeibGYiWsGNWv28GYW
         n2jyjiEw4QWEBw4D6cET3cNn2ipKb+pFyuALouwLZ4HO3oQJnXMEQxfQ1GCXTtd7jOFn
         FxxN1q8dy8xqcIfsnVWwG4woOkGqPsyjqIHKVDchKx4q1yspe38qpCLsMPqwmcV758qZ
         XyXvrksi/qECwmPBG0R7oz6mi+rHjHcTenFBPLk2eXScOPHK4cysb+go9jVL1uBhFs4V
         HSeuVbF6TR0PgEOkCjN178zO9jRrxRcZcBo5LK5/8JRrRuwV2THHOg3WeJwFNWsWwaY6
         BKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FxPPDVOMtQ/8qtYP/R46s0jJ/Tz8uV3XTZ3G5J/st6s=;
        b=dYPb0zKb8o3oeqEou0k2CoZgtPbEkYEWpihrMDdOrND04EX5rV8uqKZDbdlKZF0jsv
         FAySfjVTiqDMTxc7oISPdViO9skpxiQ/SrfZ0q/se0eHS8q8Gks+S0l/dPe4EEdmsUdH
         Mo6EkCVfp9Ob17UU4lU9K3fTHOZOzMt2hZo6aLrXwOseeBA09FVKHm1F3H9EWUMoDJTz
         2AcWXT6rqTz+a/DcYNvQD7wMgsWMhuTkOptghoAOlb+i6c9h89MPYJb9afazeP6RBGRc
         ioQPRHhPzheVwiv3pDRTdQyJ7Wr39LGzO6tXZcEN+FbeJfzcBYlFpR6omsuceRFlfi+C
         40fA==
X-Gm-Message-State: ACgBeo0Iu3nPoa1R0J5FoG621EmH+KcfZODaeubX0Ew1Siyohj8DHdA1
        KOc9iwYWxoE16tzmI3b1KBY=
X-Google-Smtp-Source: AA6agR6ouWaEqDP4hIb5ieGSEJ2QcK723lC7cgVHIFp0tSE+Ya1PhdlebcEBkDXXtQFi59+LR6cm6A==
X-Received: by 2002:a65:6e45:0:b0:42b:7e3b:754e with SMTP id be5-20020a656e45000000b0042b7e3b754emr1368062pgb.26.1662516683074;
        Tue, 06 Sep 2022 19:11:23 -0700 (PDT)
Received: from localhost ([113.172.46.62])
        by smtp.gmail.com with ESMTPSA id j4-20020a63fc04000000b0040caab35e5bsm9306293pgi.89.2022.09.06.19.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 19:11:22 -0700 (PDT)
Date:   Wed, 7 Sep 2022 09:11:20 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Lana Deere <lana.deere@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: 2.37.2 can't "git pull" but 2.18.0 can
Message-ID: <Yxf9yETBi3k6Wasl@danh.dev>
References: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com>
 <YxKo2l5nBoOa9Jfa@coredump.intra.peff.net>
 <CA+4x=b-GYMnZygHXOfNb3CdSRoxUeT80n=gSCLyfCA9WsB0wEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+4x=b-GYMnZygHXOfNb3CdSRoxUeT80n=gSCLyfCA9WsB0wEw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-09-06 15:37:45-0400, Lana Deere <lana.deere@gmail.com> wrote:
> This is the final output from git bisect:
> 
> $ git bisect good
> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> [d8d3d632f4165955da49032d50279c20cfbde2e5] hooks--update.sample: use
> hash-agnostic zero OID
> 
> Does that offer any hint about what is going on?

It is still bisecting, can you continue to bisect until it says
something like:

	first bad commit is ...


> 
> Incidentally, some but not all of the pulls produced additional
> output.  Maybe it's a clue?
> 
> $ ~/tmp/git/install/bin/git pull
> warning: Pulling without specifying how to reconcile divergent branches is
> discouraged. You can squelch this message by running one of the following
> commands sometime before your next pull:
> 
>   git config pull.rebase false  # merge (the default strategy)
>   git config pull.rebase true   # rebase
>   git config pull.ff only       # fast-forward only
> 
> You can replace "git config" with "git config --global" to set a default
> preference for all repositories. You can also pass --rebase, --no-rebase,
> or --ff-only on the command line to override the configured default per
> invocation.

This is a hint in some version of git for 2 modes of pull, you can
ignore it.

-- 
Danh
