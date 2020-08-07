Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D30BC433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 14:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CD0622C9F
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 14:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6FZ4mo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgHGOz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgHGOzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 10:55:25 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85120C061756
        for <git@vger.kernel.org>; Fri,  7 Aug 2020 07:55:25 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c2so1466604edx.8
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yp9Klanfp3LZcXBZq49Flne7Io6qhunm8dJLiWzKO30=;
        b=T6FZ4mo6Ja9lCcLbA0aOET8I0llX+ltR7oaKOEc3p1RA+OeDEapm7S9ZXJFc8hMc+g
         2uUkPzbJRkqc1TrmHZPPyeTwt8PBCqZ447fEcSkDs+D1sOgthFw7qc65mafrSTPMOPTp
         SzCmKNXVrR4TSgrCVdXwnPj6vrYVm21kV8rBcIn8SXB/b1uM5mh/M29r/PJBZmHEduDr
         n7OKV2T65FOXbPmzATvFoO6ibhsqM3p4qkwqdvXKZoskAGpOqWZuC0v1mXE+2ZOe50gY
         50bGm62mljOWWIx/ZaMhpHtdam00yxfh1sKBlQlcd82HaNcjtrYB8cDAUHk3qWY4xqwz
         VzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yp9Klanfp3LZcXBZq49Flne7Io6qhunm8dJLiWzKO30=;
        b=QUESU5PNzQVZXWR7kCop/DkN3Omt+sAVCNpZCXbFuDu3yFTsNGTvmQz5kBwJwolFax
         30JNiw95ffHIAWMQsNgstyizGSbHbeuY7rvS15Uz6e0xE4mzK4+Sw5tDTvu2DMaYPOHN
         THQmLMyJ3uRd9Mm9iyTUrLAp8RxdoDO4EaezOl5PnR1oYx6Lj3IuiOVKj/Z7kjllIs27
         WAu51NRBY8fXykHkkg8OvCRkDZMQjnmB3Y13/mTjAOFK/9AbBBQt43zIQZfBu+ofVq8p
         +JiN3PrtjJ/nENXuBW1gacKZeC3sWjloMblQOG+Wto2BSi3FsPMhJSMvOg0yXcOsR/Sq
         v2Rw==
X-Gm-Message-State: AOAM532D46XW3UD4XoHwxUQpFjlla9nEhupDOEnIv/9X96ywZ/59it/H
        ldG5x3DHo3Fgjpx2tUGnRQIQgIr3OwhFuBwDSpkFlWUn4zA=
X-Google-Smtp-Source: ABdhPJxo+MELPF7jO6zm7wxVmoKu/bE26wcVYZjwcfU07JSAo+dhkk5WMnKxiZ4MrNTCHNXjiuLx7CiupRp2c08ufPE=
X-Received: by 2002:a05:6402:1bc1:: with SMTP id ch1mr9298372edb.142.1596812124157;
 Fri, 07 Aug 2020 07:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
 <20200805174921.16000-5-shouryashukla.oo@gmail.com> <xmqqy2msn5b2.fsf@gitster.c.googlers.com>
 <20200806112702.GA15343@konoha> <xmqqa6z7jx7q.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa6z7jx7q.fsf@gitster.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 7 Aug 2020 16:55:11 +0200
Message-ID: <CAP8UFD21i6UOwSA8hoCbF9kbRaaQzmN4e0t+pPrF1fW+SSJwww@mail.gmail.com>
Subject: Re: [PATCH 4/4] t7401: add a WARNING and a NEEDSWORK
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 6, 2020 at 11:11 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Shourya Shukla <shouryashukla.oo@gmail.com> writes:
>
> > On 05/08 02:36, Junio C Hamano wrote:
> >> Shourya Shukla <shouryashukla.oo@gmail.com> writes:
> >>
> >> > Add a WARNING regarding the usage of 'git add' instead of 'git
> >> > submodule add' to add submodules to the superproject.
> >>
> >> Is that a warning worthy thing?  As far as I know, using "git add"
> >> to register a gitlink is perfectly fine and a supported way to start
> >> a new submodule.  It may have to be followed by other steps like
> >> "git config -f .gitmodules" (e.g. when operations that needs to use
> >> the contents recorded in the .gitmodules file are to be tested), but
> >> writing tests using lower-level ingredients for finer grained tests
> >> is not all that unusual, is it?  I dunno.
> >
> > The thing is that 'git submodule {init,deinit}' fail when there is no
> > .gitmodules. I can initiliase the .gitmodules separately using 'git
> > config -f .gitmodules' but I think it will be better to use 'git
> > submodule add' throughout the script rather than worry about it all the
> > time.
>
> On the other hand, we do want to make sure that the workflow using
> lower-level tools continues to work, so that is a balancing act.

Yeah, that's the reason why we suggested to add the new tests in a new
test script t7421:

https://lore.kernel.org/git/20200806164102.6707-5-shouryashukla.oo@gmail.com/

> > But again, if the warning seems unnecessary, then I can obviously use
> > 'git config' to initilaise the submodules and change this commit. What
> > do you reckon?
>
> If you need "git submodule init" etc. to work in this test, yes, you
> can change the test to either use "git submodule add" instead, or
> "git config -f .gitmodules" in addition.  If you don't, there is no
> need to change anything, no?

In t7421 "git submodule add" is used, so that we can perform the new
tests we want there. The purpose of this patch adding a WARNING and a
NEEDSWORK was to tell explicitly that this test script (t7401) is not
necessarily the best test script for "git submodule summary" tests
because it is very old fashioned as it has a lot of boilerplate stuff
outside test_expect_{success, failure} and it uses "git add" instead
of "git submodule add".

I think we might want to just add the NEEDSWORK in this patch series
and add the WARNING, or perhaps just a NOTE, about "git add" vs "git
submodule add" in the other patch series when we introduce t7421.
