Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FC7C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 20:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A1160202
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 20:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhBXUXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 15:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhBXUXM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 15:23:12 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458D1C061574
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 12:22:32 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id s23so2128001pji.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 12:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+rzyvvCCfOzmJxjLXBLtOCsviu2AOAxSpS5vZUHP/0I=;
        b=JBtlkjQJmDKgAa4/Z3z+cX0ELTUZi7jhvaLjDAW3TLltMfejRhUzygvGXafzPAeVg8
         3ehPB/+qK0BOZqeHIPZBqOsehOqO7ijRaj++lR1g9AjOLhQz4NlWzKtImHjeICfBhtRM
         mjD4o2kgUdbYUf/nPa6QtrA5D1he7ZANFjiRj6dIPWCAiW+sNiREuPjddYBHaM8r7Lqo
         htXJNeq6jA/VBveuVEWGUli6tOVqsFxSgCXAH5fWtuLHzCRbDIZMyMvk6hOC62aMolCd
         r+/B+W9g/HiAWS5B9NoXjqIO8WgqPVTMo7quXI/y8U1FsSX8cDXJdwcUiqJJsfZQLkyn
         hV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+rzyvvCCfOzmJxjLXBLtOCsviu2AOAxSpS5vZUHP/0I=;
        b=c1BaBMNMNsxbc+oLQ65zeSRAyqGwcI3AMw68vZwNmtOfz1xbYzHGEWYgTgFixAHjgl
         zZBp692joRsbaB9tsiZErFkRSv7hXL3BKWI4LqeeQ1unShz+7qb+oXEDEbnxO1UieOZ5
         2cFM+7nAwy5TiPl1MsrY0vR5YkWjCAU+Ux69hQ1nmSxa5rCtWKPCicrPj80lDUGHIqJA
         txnEXz44ZAY3+6LeXd8MgyzAYLKVVv1yz/PdsxKeIDoV7qwrQUycfwboE58ZKEApgS05
         g/34pXsP1o51rVsT1i9KiGx21VicO1UQzboFLmbMqiK8jdTLga14khajOvCajs0ykarc
         Qoow==
X-Gm-Message-State: AOAM530Xv2u8zJ/Aj+Gv4j42Ywmpf00SHrs32zlMDuPTLkudUsO3D7dJ
        osgADKWCdEmsCin/lwWpFJC+w71iJHhQD5jxWt0=
X-Google-Smtp-Source: ABdhPJwcN2xkOdZa3L9qFrm06v6AUX8C46kDqfIOK3qOJvdDJ0LE55Fbtfc8KubrkFQtWkRGjtsR/HoEEIWcF6OT/D4=
X-Received: by 2002:a17:90a:fe02:: with SMTP id ck2mr1090085pjb.136.1614198151664;
 Wed, 24 Feb 2021 12:22:31 -0800 (PST)
MIME-Version: 1.0
References: <CAGgn8PdU1GE_CZdGUpJWKzygd0O+Yn2BnAFGmPfKAxFpoVoqUA@mail.gmail.com>
 <YDROhhrM5qJti1ir@coredump.intra.peff.net> <YDVo0kGYODP0JjqT@coredump.intra.peff.net>
In-Reply-To: <YDVo0kGYODP0JjqT@coredump.intra.peff.net>
From:   Yaron Wittenstein <yaron.wittenstein@gmail.com>
Date:   Wed, 24 Feb 2021 22:21:55 +0200
Message-ID: <CAGgn8PcPtLNtZTmMqKKTmH3KOezkr-jY7aTEDA-0dvYWuzid9A@mail.gmail.com>
Subject: Re: [QUESTION] Tracking HEAD changes?
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That indeed seems to do the trick.
I've done a little experiment and saw that when doing git reset the
hook gets called.

However, when switching branches the hook doesn't execute :(

I don't understand if it's intentional, since when I've moved to a new
branch HEAD pointed to another commit id.
The only workaround I see here is using the post-checkout hook in addition.

Thank you very much for helping me. I really appreciate it!!
     Yaron

On Tue, Feb 23, 2021 at 10:42 PM Jeff King <peff@peff.net> wrote:
>
> On Mon, Feb 22, 2021 at 07:38:30PM -0500, Jeff King wrote:
>
> > On Mon, Feb 22, 2021 at 11:12:11AM +0200, Yaron Wittenstein wrote:
> >
> > > Is there any possible way to track changes to HEAD using hooks?
> > >
> > > Being able to listen using hooks to events such as pre-head-checkout
> > > and post-head-checkout would be the best option (from my perspective).
> > >
> > > To my knowledge, the only possible way to do that today is by adding a
> > > file watch over the refs directory.
> >
> > No, I don't think there is currently a better way.
>
> Actually, I completely forgot about Patrick's recent ref-transaction
> hook. See the "reference-transaction" section of githooks(7). They do
> more than you'd need, but you should be able to write a hook that just
> looks for updates to HEAD, or updates to the ref that HEAD is pointing
> at.
>
> The code was introduced in 6754159767 (refs: implement reference
> transaction hook, 2020-06-19), so you'll need Git v2.28.0 or later.
>
> -Peff
