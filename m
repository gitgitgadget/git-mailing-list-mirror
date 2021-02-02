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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA793C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 14:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D94064F4D
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 14:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbhBBOzP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 09:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbhBBOyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 09:54:09 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77414C061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 06:53:28 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id f19so24283917ljn.5
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 06:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QXCD3WWktQ4mci5Vby6PXoyASpTcfcfq5qKDRdcX9yA=;
        b=jknYkAPpaUETjxZEI9kgphVimnUpctdSMc95YWnjGczybwDl5TtfG3HiNCTS/3QSCv
         aGhUARMNk1A8VJyqdzlIrdpmdS1JBFpNpa/Wq9FcgUQFAlkJfwQJraysDmyi0rZXy2zM
         L7NVGplU5E3DD187YHoE6q9K91RR/+oOp7DKB5yVtb+9gdM5I3Wacv/KfRITMlNtHPG/
         CsMhq+lGWqqdzpjZpMDh6BJHbpW72f+fFvVBW1tLjhTvlIhcBsFwDNvKMl4w5quG3oqP
         +HjgnpMoquiEbak3DjPVbv2rxM8GO8/LJ3i44ED69hq+R4ZU4hf8WZPtwIETEwC6jBN5
         Am5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QXCD3WWktQ4mci5Vby6PXoyASpTcfcfq5qKDRdcX9yA=;
        b=QwkJCGm90ZOWXuRvrIkT17Xx+WlCx5opNk9SBD4w+xIF/cPGcyLOOViBfwRo877wWX
         gl6udYnDLNGgaQGvO7AYF4pNlrXMiAJDJw6AJLzi0tuZirp31pj8fOG1j5Y2RXS7LHrb
         m10EwSG6wN+X5TDXo9bvulYTxxuepcl5VWbNISPGyr+/wRXQ/GNSydUACH4KmaOhQaf6
         k9JIMVqI3unW6aK4othZp3/Cl1TGCGoIbvANlkrqZu7Ry3kwi5MDuSfwQzw2Cp+INKAe
         VNA7hJKhasU7vh95U1HNr/uqcrOBw+b5Qv9K4gNVP4nm7mbsfls6SCfOsLouSjunpjLk
         yOFg==
X-Gm-Message-State: AOAM533vqlssiiLEMHH3tKeyltafPLH18FBvBWgV3VnLmiFLADoWHc+g
        sE3Yo6V7EAV4Fy0NdTqbJLrU3ormDaLpky4NWl0=
X-Google-Smtp-Source: ABdhPJx3g1a68Vs46dN7ejaSyOcMPOKWZaOv2ZyNdfYN7+8C5Quv1eUuYYmVgkjorwvsnvUjECHCXZ8OQxV6oiUGcj4=
X-Received: by 2002:a2e:7213:: with SMTP id n19mr12765453ljc.320.1612277606008;
 Tue, 02 Feb 2021 06:53:26 -0800 (PST)
MIME-Version: 1.0
References: <CAGP6POK1s5fdzY74HyE9=0CV_B+HpbM9gU2qKuYtQAaPuc7XgQ@mail.gmail.com>
 <CAPc5daUtOMQB9YqOTQL4mrHpfyATe=FM01cW9Ngd1iy8aWwMmg@mail.gmail.com>
 <CAGP6POJeg4EB1Lx8NN0+PP-nxystKtLT_FH2UdQhoF13TjWvXg@mail.gmail.com> <CAHd-oW5KmK1JgaMmDBWA87oxG=U7MdA3GBpzA9P5NYbBOfZqCA@mail.gmail.com>
In-Reply-To: <CAHd-oW5KmK1JgaMmDBWA87oxG=U7MdA3GBpzA9P5NYbBOfZqCA@mail.gmail.com>
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Tue, 2 Feb 2021 22:53:13 +0800
Message-ID: <CAGP6POKiNCmNYEWL+dZw8Cm5cLS5kqB5d_Lnq9tT6eowY1PO3g@mail.gmail.com>
Subject: Re: Only receive the topics I participated in or initiated on this
 mailing list.
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 2, 2021 at 10:28 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Tue, Feb 2, 2021 at 6:02 AM Hongyi Zhao <hongyi.zhao@gmail.com> wrote:
> >
> > On Tue, Feb 2, 2021 at 1:41 PM Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > You can,  on _your_ end, filter incoming messages that are sent via
> > > vger.kernel.org and do not have your address on To or Cc.
> >
> > Thank you very much for your comment. It seems that the following
> > Gmail filter will do the trick:
> >
> > From: *@vger.kernel.org
> > To or Cc: -hongyi.zhao@gmail.com
> >
> > But I can't find the Cc field on the filter panel.
>
> Maybe you can use the "Doesn't have" filter field. (It doesn't have
> the same meaning, but perhaps it is close enough for your needs.) I
> have this set on my Gmail account:
> https://matheustavares.gitlab.io/posts/first-steps-contributing-to-git#filters

Thanks a lot for your notes and I applied the setting rules suggested
by you now.

BTW, I'm not sure whether the following two formats are equivalent or not:

list:(<git.vger.kernel.org>) and list:(<git@vger.kernel.org>)

Regards
-- 
Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Polytechnic University of Science and Technology engineering
NO. 552 North Gangtie Road, Xingtai, China
