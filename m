Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C40CC433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 14:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61CAF61421
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 14:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242156AbhDUOho (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 10:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbhDUOhn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 10:37:43 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBD8C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 07:37:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id q22so4743085lfu.8
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 07:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=80hG2VOQLYRwnffRSF9q3XtmIcdmTVVTdPoQCpWqMGc=;
        b=E+1Twz2WIEraKpALf29dH5ZbSTQfHiVzUYJC+jq2a7rSxK8beRsYYBlUlr0SOS4S6A
         laCa48QxOgaT2eXgDRA0kc8uVIybfQ3tG3yDr3tRuUpvMItw9O9m0DhYA+SkGrOFEEWG
         anVM3nQfEzApctVCfjLgmCjxMdcZHQRTOCxck7sf+XLgUq+LvrbUi1sZP1/BV/2shdAL
         9SLij9qWLbW6pWApqH9Jdf59fWRa/V5glQBTyxO3VTPqft66ISNoFQzsFexsFxFQsBcs
         L5bZJ4Sp59f7I3av5GBJTjW1y1HRaUyWG4nrl1un1AVsNa2OLY2oze2AbDWeKsnEzspE
         r1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80hG2VOQLYRwnffRSF9q3XtmIcdmTVVTdPoQCpWqMGc=;
        b=cjlJKx3+506yfQrdikG8tApr5a9yvApIsGzjGETPz30+IETmSGz/SuWhWTNcD2xCpD
         wlM9PYxpMAZcYAQBuZYz08RnoHz4wpN11REuDS1nWxjoVej0DBeNlAiAh4TPvYKpMwpR
         zOKapLN/D1zq66RQZL8vnVwWBepF6qkjQ70dOJEvpEsXZdlhx0JUDmrPUv2+JB1kSsz6
         tXXi/z7SouKCl99t/eM6x6vMPane/aIC9qhJG5/hPt6wdZZA6aOdCT6sS9hG79XwAu2A
         LYhimvG8h8WIY4eOMB3f51xaOUd/deGtwdXcwIoHWckJnYqWRW6MKgFEX8GuGVrIGINu
         RowA==
X-Gm-Message-State: AOAM533WO+l4knEfYDFwDpLii0RXfswrvpHn0tap8w0b9uLPmzzg27gU
        JpUkLJAs8wpfXv17br/26F+1ix+BRofWhIDIaCvkCohOBtTcW86U
X-Google-Smtp-Source: ABdhPJzc8rkwZh7HwRSaq6388l71mazYTwAevC0LfAgK02ERxB7ni4WjpXt+dK8L6rkp7bWjEIMz52CH+YmlQPDevoc=
X-Received: by 2002:ac2:53b4:: with SMTP id j20mr20805948lfh.390.1619015826672;
 Wed, 21 Apr 2021 07:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAGP6PO+6MA9J1LRgGn4rcz8DBcW-hht92p-ahFaM9g6tcNFh-Q@mail.gmail.com>
 <YIA10O/BVrP3z/LK@nand.local>
In-Reply-To: <YIA10O/BVrP3z/LK@nand.local>
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Wed, 21 Apr 2021 22:36:55 +0800
Message-ID: <CAGP6POKTTBfrtsXEKi2P+xg0DLPNzo4+jRY+ySmJ0wOQFPdZpw@mail.gmail.com>
Subject: Re: The meaning of the '+' before the submodule hash.
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 10:25 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Wed, Apr 21, 2021 at 10:19:25PM +0800, Hongyi Zhao wrote:
> > What's the meaning of the '+' sign at the beginning? Why do some
> > submodules have this symbol, but some submodules don't?
>
> There are three symbols, 'U', '-', and '+'. From the documentation [1],
> they mean:
>
>     Each SHA-1 will possibly be prefixed with `-` if the submodule is not
>     initialized, `+` if the currently checked out submodule commit does not
>     match the SHA-1 found in the index of the containing repository and `U`
>     if the submodule has merge conflicts.
>
> [1]: https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt-status--cached--recursive--ltpathgt82308203

Thank you very much for pointing out this document information to me.
The above submodules status for my case were achieved by the following
command:

$ git submodule update --init --recursive --remote

As you can see, this will cause the status denoted by '+', i.e., the
currently checked out submodule commit does not match the SHA-1 found
in the index of the containing repository. I'm not sure if this is
harmful.

HY

> Thanks,
> Taylor



-- 
Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Polytechnic University of Science and Technology engineering
NO. 552 North Gangtie Road, Xingtai, China
