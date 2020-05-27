Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8516C433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 21:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BDDD20723
	for <git@archiver.kernel.org>; Wed, 27 May 2020 21:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTz12ZY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgE0Vyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 17:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgE0Vyk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 17:54:40 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02ABC05BD1E
        for <git@vger.kernel.org>; Wed, 27 May 2020 14:54:39 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g9so21538735edw.10
        for <git@vger.kernel.org>; Wed, 27 May 2020 14:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hHbR40Yufio2nnvVQOJxuHBxE7HfYoaWuyGN3TpeKPs=;
        b=ZTz12ZY94FnYskgueoO8Q+5ycl12OOR7DIVFC4Hpb84g8WStY6GQYHIXuBi/XCu3HU
         1AY87l9YRz1Of0uwORAPDR8LvPL88f+6fZSTLWMdMyOk13jJOn6u8cTzd0yHp9a3X6n6
         URxe/aAMKxQhAmhT4VS/hZPAo5hl48YIbvLb8sa0oe1d30gSIx513sDj3ghG2rvQxlBG
         1ZCDv5kwyt6/34H9X2Dz/emQHKn4Uq0smMsKnSdFb/fC73DHBTKnSgWv7cDlEl6p568R
         y5TDE3BdMng5R9GBdJ7Dwlo8YZkmnMwUQr3xTt/Ycbd0TIOxWoI4Od2FI4ihkKURvns9
         VUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hHbR40Yufio2nnvVQOJxuHBxE7HfYoaWuyGN3TpeKPs=;
        b=sp5XdGByRcAm0plO6KANdND3CsROsNpJ8dd85cy3wTZZg4V9BiGOFudyYkbeAlSaOn
         ZAseqCTg/NBZPld9iU4COOWwqTuBpQLONha0O635jhyVIe4KrhK0tzhDJc8afitnM+JV
         3ZXyoyV2dGfIpewjyx96kQzgHYcu1IRiOx0JZaIQ2bOHh+/UQhRKOt4ENhxECIIBLRxr
         REfQ8xzWmbwRXpcIzIpw78Ob/5UVDDoBaRfmqX0vw/2LS28Wnt9Lul8f5CqudDgDj6aH
         X9xtz78HOvU5MiXIsHod4VJ3ry7oMC5cajSDgodNXHEBfNDZQx6NqbBhMt6FUQ3ann9o
         dCXA==
X-Gm-Message-State: AOAM531xYLNvCyqA9iVUOLxFR3MLcUpodVIFfTctNH9IYK8Ad58nEJqW
        NLklcSwxiRLribGfIabwqyEp6oEQ8W+1kwb5skc=
X-Google-Smtp-Source: ABdhPJzh8R5nvc15LiYyWZuPRigrN5Cd/3rwTu3kEpB8O6qAtpbUR71awgFMIWeuSeGsOagoJHwJDTFtPmigR/1F5ik=
X-Received: by 2002:a05:6402:645:: with SMTP id u5mr170406edx.273.1590616478201;
 Wed, 27 May 2020 14:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD3MvaAPMUwc=hW-bayDbNpxSX3jtMiPQro4b2Ai17GkNg@mail.gmail.com>
 <20200527211140.qbgbbitoxr4mx7gk@feanor>
In-Reply-To: <20200527211140.qbgbbitoxr4mx7gk@feanor>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 27 May 2020 23:54:27 +0200
Message-ID: <CAP8UFD1t8e+7_fMPhAFFBQSZ3G1Xxvw+=+mwfX4LB4uKJZek6A@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 63
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Hariom verma <hariom18599@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 27, 2020 at 11:11 PM Damien Robert
<damien.olivier.robert@gmail.com> wrote:
>
> From Christian Couder, Tue 26 May 2020 at 19:10:32 (+0200) :
> > A draft of a new Git Rev News edition is available here:
> >   https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-63.md
>
> > # Reviews
> > remote.c: fix handling of push:remote_ref
>
> Wow! I don't know who was motivated enough to go through the history of this
> series, but I am impressed. I just sent a pull request with some
> suggestions.

Thanks! I merged your pull request and then reformatted the result a bit.

> This series was a complete mess, a lesson learned is that I should stay
> focused on the original scope of the series, rather than try to extend it
> mid-way when I find other bugs in adjacent areas. And instead fix the new
> uncovered bugs in other series.

Yeah, I hope that this lesson can be learned by others reading the article.

> In "What's cooking in git", the series is marked as stalled, so I think Junio
> is waiting for a reroll. I haven't forgotten about this series, but with
> the current situation I did not have time to rework on it.

Yeah, no worries about that. It's ok to take your time.

> Meanwhile, the version v8 in 'pu' does not detect triangular workflows (since
> I ejected that patch).
>
> The version v6 in 'next' does, but there it has the corner case of
> a branch 'foo' which has a pushRemote=foobar but no remote and 'origin'
> does not exists. In this case %(push:remote_ref) detects a triangular
> workflow but `git push` does not.
>
> So this is really a minor corner case (and I actually think its `git push` which
> should be fixed here), so it is not too bad that this version is
> in 'next', especially since there are still other bugs in the ref-filter
> machinery anyway
> (see eg
> https://public-inbox.org/git/20200418173651.djzriazxj5kbo6ax@doriath/ and
> https://public-inbox.org/git/20200416152145.wp2zeibxmuyas6y6@feanor/).

Yeah, I think both versions v6 and v8 are already significant
improvements over the current situation.

Thanks,
Christian.
