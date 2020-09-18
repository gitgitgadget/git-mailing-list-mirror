Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B31BC43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BF2421741
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="E7O2aTAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgIRR6l (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 13:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRR6l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 13:58:41 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D620C0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 10:58:41 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n133so7119450qkn.11
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 10:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7jivVNFIneHsWThciHlaAdBpMJX9doAZzYF9LCsR/gU=;
        b=E7O2aTAi4g61KHu4o8i7pN0GBDHRH7ll/CljX2FR8ljRFlHIsT1G9H3fMGecovNjZD
         ncHARZeeyYwdE0YPFBOc2/RMea0iQJnfVFVLB1LJp3yVw4AW40FFwws3PC5ZaEHo8sM6
         GZU8/Ie3XMpLV4BIWxgKGgjIX0VpxmuTLGIR3fel70aqeLWSOyT2GRLDAQBbBjl0W2+v
         9IDwnyJF0kktNP1HI8mMXPByCjy6sTtVSXmB0bou4WnNLRdVWGXUFZwhFIWVbypXnTEg
         NQflXzG7AllBu4TKvE/CQohgwVPlVI2yo6+jQB1mJYn6fL2pPjIZF2FAw3ppAne5iyoJ
         YeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7jivVNFIneHsWThciHlaAdBpMJX9doAZzYF9LCsR/gU=;
        b=gc9CFjWn1rBjxhJxiHujYBnGHO1FjQ+DGv1ZDkJi7aZcuaIas0Eh/8Rqkfb/56rgaR
         YGIswy7tIClrJO940vQEzhf4RmnPGvc1sKOxUf5xtph3/nMVkHaYJuOndHJrt3IuEJwG
         V5dt9MysAfhhtL/u6DyqMxr4f3ZORkMhGZDdv28D93m/fgBgf5MxgUmYXspMszRUuYfH
         2FH6GB6yw+5oxpR/F6IjWEOAqjnnGiP702BKVjOsAO8H0elk1Tj4cY7kCJl/n1bhqyjO
         3J7aRq+ptKo9QYlci9r4WRIOxBFEI480NzaJCNLQxXInZ0gV/QiELueMsHiCcr/Ri6tc
         XfTQ==
X-Gm-Message-State: AOAM531mkq+7WwxpQR+z9/sTKGwjICKdjv3UXExi06LjwvjnyIv6jGZB
        oXPZDrtkx7j5JUd9w/P5ddMsDg==
X-Google-Smtp-Source: ABdhPJzxIGLDL5kPi9rnv07vsB6lCCgxbUMEHAHqjbsU4lbM2ov4JF/ZqGYIp3o+ku7VU3euvDtrcg==
X-Received: by 2002:a37:67d2:: with SMTP id b201mr33852711qkc.96.1600451920403;
        Fri, 18 Sep 2020 10:58:40 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:bcd8:3baa:a5e5:d0e6])
        by smtp.gmail.com with ESMTPSA id n144sm2551592qkn.69.2020.09.18.10.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 10:58:39 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:58:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Thomas Guyot-Sionnest <tguyot@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Thomas Guyot-Sionnest <dermoth@aei.ca>
Subject: Re: [PATCH 2/2] Allow passing pipes for input pipes to diff
 --no-index
Message-ID: <20200918175836.GA149847@nand.local>
References: <20200918113256.8699-1-tguyot@gmail.com>
 <20200918113256.8699-3-tguyot@gmail.com>
 <20200918143647.GB1606445@nand.local>
 <CALqVohfFjsh-2jZLNNwON_V95Dfh-aEh1aMb53t4NQrM0qz1tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALqVohfFjsh-2jZLNNwON_V95Dfh-aEh1aMb53t4NQrM0qz1tQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Fri, Sep 18, 2020 at 12:34:48PM -0400, Thomas Guyot-Sionnest wrote:
> Hi Taylor,
>
> On Fri, 18 Sep 2020 at 10:36, Taylor Blau <me@ttaylorr.com> wrote:
> > On Fri, Sep 18, 2020 at 07:32:56AM -0400, Thomas Guyot-Sionnest wrote:
> > > A very handy way to pass data to applications is to use the <() process
> > > substitution syntax in bash variants. It allow comparing files streamed
> > > from a remote server or doing on-the-fly stream processing to alter the
> > > diff. These are usually implemented as a symlink that points to a bogus
> > > name (ex "pipe:[209326419]") but opens as a pipe.
> >
> > This is true in bash, but sh does not support process substitution with
> > <().
>
> Bash, ksh, zsh and likely any more moden shell. Other programming
> languages also setup such pipes. It's much cleaner than creating temp
> files and cleaning them up and in some cases faster too (I've ran
> diff's like this over GB's of test data, it's very handy to remove
> known patterns that would cause needless diffs).

Oh, yes, I definitely agree that it will be useful for callers who use
more modern shells. I was making sure that we would still be able to run
this in the test suite (for us, that means making a new file that
sources lib-bash and tests only in environments where bash is
supported).

> Now you mention it, maybe I could do that stat first, rule this out
> from the beginning... less work for the general case.
>
> *untested*:
>
>     if (!lstat(name, &st)) {
>         if (!S_ISLNK(st.st_mode))
>             return(0);
>         if (!stat(name, &st)) {
>             if (!S_ISFIFO(st.st_mode))
>                 return(0);

I still don't think I quite understand why FIFOs aren't allowed...
>
>             /* We have a symlink that points to a pipe. If it's resolved
>              * target doesn't really exist we can safely assume it's a
>              * special file and use it */
>             struct strbuf sb = STRBUF_INIT;
>             strbuf_realpath(&sb, name, 0);
>             /* We're abusing strbuf_realpath here, it may append
>              * pipe:[NNNNNNNNN] to an abs path */
>             if (stat(sb.buf, &st))
>                 return(1); /* stat failed, special one */

By the time that I got to this point I think that what you wrote is much
easier to follow. Thanks.

>         }
>     }
>     return(0);
>
> TL;DR - the conditions we need:
>
> - lstat(name) == 0  // name exists
> - islink(lstat(name))  // name is a symlink
> - stat(name) == 0  // target of name is reachable
> - isfifo(stat(name))  // Target of name is a fifo
> - stat(realpath(readlink(name))) != 0  // Although we can reach it,
> name's destination doesn't actually exist.
>
> BTW is st/sb too confusing ? I took examples elsewhere in the code, I
> can rename them if it's easier to read.

No, it's fine. I think anecdotally I read 'struct strbuf buf' more than
I read 'struct strbuf sb', but I guess that's just the areas of code
that I happen to frequent, since some quick grepping around shows 462
uses of 'sb' followed by 425 uses of 'buf' (the next most common names
are 'err' and 'out', with 191 and 121 uses, respectively).

> > > +test_expect_success 'diff --no-index finds diff in piped subshells' '
> > > +     (
> > > +             set -- <(cat /dev/null) <(cat /dev/null)
>
> Precautions/portability. The file names are somewhat dynamic (at least
> the fd part...) this is to be sure I capture the names of the pipes
> that will be used (assuming the fd's will be reallocated in the same
> order which I think is fairly safe). An alternative is to sed "actual"
> to remove known variables, but then I hope it would be reliable (and
> can I use sed -r?). IIRC earlier versions of bash or on some systems a
> temp file could be used for these - although it defeats the purpose
> it's not a reason to fail....

OK.

> I cannot develop this on other systems but I tested the pipe names on
> Windows and Sunos, and also using ksh and zsh on Linux (zsh uses /proc
> directly, kss uses lower fd's which means it can easily clash with
> scripts if you don't use named fd's, but not our problem....)
>
> Thanks,
>
> Thomas

Thanks,
Taylor
