Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F211C48BC2
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 00:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D4561289
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 00:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFXA3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 20:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFXA3T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 20:29:19 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9920AC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 17:26:59 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id f13so5332161ljp.10
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 17:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cMhZOiaOncuQOibksraLJ5vogIJa/d8S/ON8Z+fk/s0=;
        b=B334yv2CTtsNBgaNfKXxZS/H4H73aW7Z0f2A1h/LVLJ0o8Fve/cOuGC/JpY2BrZiQF
         jDlMYcgW1PcQsYGQLN+dHuU1gdCbh6XZNDvemfnxZCmfnnVkQKjILy30RCOmqqpHVreX
         Kh90INiHm8x5MZJQbQT1BecaaWDTFaNLYI+2v37NyeUdb2XQR/6YoesJwOnHfqtYSlCS
         VpHQSVgl262mSXqJFhf9VGbe+S1Q5iPXULt+GH/gWFamaBIEA/dYsVoM/0LpLeWYvNsJ
         ZX9QHS282szDsqlUEY6iyHlPOHpQHy3NeurLcPExacwBuyWGNOlviv33G1l5b0lM61TZ
         xiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cMhZOiaOncuQOibksraLJ5vogIJa/d8S/ON8Z+fk/s0=;
        b=Fk9I29WMlUsP+dkgBhS9i0Z3W8HtvHLQLZ5fneaPf6cVIChKXgJO75qvwZLnbc0ZxI
         DUepuByY7hNe4MS0KYmB0CDTwQ4fCvamHMzKESGz5HHK9f8/tpDsf/8uhTHGtFQFxVIT
         gxv9cL30snM3v47Gbmb7iz+6EpfyUxtPZgvMMXZo7YiRAXFpj+eDPI+kKSU6MzvZJSVj
         FelALGtyjVckjYo0NwgahEliSIp3/ir/bbKWKLu0yv+3HT9X99CwnGd8poebX6s7eL/A
         /TPnZGdNxkr4PFuOiBQ1yecqQZhSrzBGeZQte/rxdLj61GlZhTMjvcUDXaVHf2J/xKpH
         XR4g==
X-Gm-Message-State: AOAM530uH/YDqM4sCUqqwcYEQBI8lXG4l0IztpwT9VS0nvv0S/V21WHG
        mnTw8KhkcVYn+4knnZJvfap2ipVQp3IrQ+R3nNUsBagAnIZ8wp4htfs=
X-Google-Smtp-Source: ABdhPJyt47dg6UF0AqAF9dJwQhO2T7Fygq9w8yenrDNSc5fxsSbnssVQ6t0FjDO/1yKpOYkEdG6makh6YwpE9zvBG7Q=
X-Received: by 2002:a05:651c:b0d:: with SMTP id b13mr1688665ljr.481.1624494417995;
 Wed, 23 Jun 2021 17:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAGP6PO+hnvAdYuMKQG15-fhRVdDBCCn2xfnLP5=exPcs4GHJVQ@mail.gmail.com>
 <YNPPkQrK8PtPAr8C@coredump.intra.peff.net> <YNPQcAnIh8APLFxk@coredump.intra.peff.net>
In-Reply-To: <YNPQcAnIh8APLFxk@coredump.intra.peff.net>
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Thu, 24 Jun 2021 08:26:46 +0800
Message-ID: <CAGP6POL6EOMgKWZUneHoveJnX3dn7YjF4303+RGo6Lkm17-5mw@mail.gmail.com>
Subject: Re: Where does the variable GIT_HOSTING comes?
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 24, 2021 at 8:23 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jun 23, 2021 at 08:19:30PM -0400, Jeff King wrote:
>
> > On Thu, Jun 24, 2021 at 07:30:29AM +0800, Hongyi Zhao wrote:
> >
> > > On Ubuntu 20.04, see my following relevant git variables settings:
> > >
> > > $ env |grep GIT
> > > GIT_SSL_NO_VERIFY=1
> > > GIT_HOSTING=git@git.domain.com
> > > GIT_DISCOVERY_ACROSS_FILESYSTEM=true
> > >
> > > I don't set the `GIT_HOSTING' variable at all. Then where does it come
> > > from and what's the function of it?
> >
> > This variable is neither set by nor respected by Git. It may be set by a
> > system file, or perhaps a snippet you copied into your user setup at
> > some point. Try:
> >
> >   grep GIT_HOSTING ~/.bash* /etc/bash*
> >
> > (that's not an exhaustive list of places the environment may get set up,
> > but it contains the likely ones).
>
> Looks like you might have "bash-it" set up:
>
>   https://github.com/Bash-it/bash-it/search?q=GIT_HOSTING

Exactly. I forgot this. You're absolutely right, see below for more
detailed info:

$ grep -B1 GIT_HOSTING ~/.bash* /etc/bash*
/home/werner/.bashrc-  # Your place for hosting Git repos. I use this
for private repos.
/home/werner/.bashrc:  export GIT_HOSTING='git@git.domain.com'

HY
-- 
Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Vocational University of Technology and Engineering
NO. 552 North Gangtie Road, Xingtai, China
