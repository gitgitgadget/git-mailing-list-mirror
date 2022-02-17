Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F02DC433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 22:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiBQW6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 17:58:24 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiBQW6X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 17:58:23 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941F522B734
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 14:58:07 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id de39so6217293qkb.13
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 14:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=w+c3gRijEUbjivQX8XdqI5sJkYm39GGdOiU1dvCWgj0=;
        b=ojVKXpg+aQDd8voc0LCauvslnkgJQJLBDWu0fSi9DEfOl3g40ufhlvJEfDP8RZ4ZCq
         HjVt8dwE4Kc8qYYaF1zqMdUg17V+6aVUqOjZVFFBpn8Bhvhq9Gtnwxtbpi5eTRs6wDtQ
         jDXgC2WHdyGNK4K57JCXSsdZ/Tw3j1h6ZcfMBVLUlMxe+PZ7kIdlBdyrqHohbRPhfa7W
         fRrfTGhHoTago9/pHDQ6Zhr9fWjBubpzX8O1L1uBN2VeKCZMxbxezfbI7hoLsYobaE+4
         M+8brhGkM+ViuhTwaAG0vhMwSi1HIhavLmcMtZEY9IA0cORV0ZSGMyhgvkKAmy0+ROTt
         Yzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=w+c3gRijEUbjivQX8XdqI5sJkYm39GGdOiU1dvCWgj0=;
        b=cNx+jjHis8naLdigdz+MtADP2/qGhT70V12eGcKIzb2KHOQgPS03qee0m1ejQBO28J
         7tKqDG5uTawG98vVFuqJrWCBJYd+lPL1AWia5nqUq3tcf6iwB4rvBgnl10lYLpR+s5/A
         o/DNmuiX2PbSLU9MZx1sP/465wMVcCnq6gbY35bjrEowDngM8N2oQUPFWqr8CYHh8Atp
         DsSGI7nVD5VZsgP72hToJUgwn8s+4rK1zGrR4TqcBMQAqLWhDZumfucnHZ4d5WFTbdd5
         a+9yLCOumoAFBG41cTXVU6CWHhcttNt3xK3JlBCrQjXQpnd+TiYz1PYaM68vmc0+06Kk
         UkGA==
X-Gm-Message-State: AOAM533ZvqB9n/plgZEyaWf3H176PtvnHyKP9D9GisACWfAGtBkAge0B
        fDFu5ENY05vu04nZXeZ9o+xJKqb/kxRyAMuR
X-Google-Smtp-Source: ABdhPJxf0snnms8HadbFc9xZ1t8U9t/pRjKwZwpJq9Uph+59kJ2pDEP5t0FAQr62Cs18YsYI9z6EHQ==
X-Received: by 2002:a37:9b84:0:b0:4e0:fb74:da92 with SMTP id d126-20020a379b84000000b004e0fb74da92mr3022479qke.245.1645138686670;
        Thu, 17 Feb 2022 14:58:06 -0800 (PST)
Received: from edef91d97c94 ([50.234.189.46])
        by smtp.gmail.com with ESMTPSA id bi5sm20000442qkb.116.2022.02.17.14.58.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Feb 2022 14:58:06 -0800 (PST)
Date:   Thu, 17 Feb 2022 22:58:04 +0000
From:   Edward Thomson <ethomson@edwardthomson.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git ML <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] xdiff: provide indirection to git functions
Message-ID: <20220217225804.GC7@edef91d97c94>
References: <20220209012951.GA7@abe733c6e288>
 <20220209013354.GB7@abe733c6e288>
 <220216.86wnhvvgeh.gmgdl@evledraar.gmail.com>
 <7e6385f8-f25d-69f5-edae-6f5d6f785046@gmail.com>
 <220216.86leybszht.gmgdl@evledraar.gmail.com>
 <20220217012847.GA8@e5e602f6ad40>
 <220217.86ee41izpq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220217.86ee41izpq.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 17, 2022 at 10:29:23AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> [I'm assuming that dropping the list from CC was a mistake, re-CC-ing]

It was; many apologies, I don't use mutt very often any more.  Thanks!

> As for the "new person to our codebase..." I don't think you're wrong
> there, but that's an asthetic preference, not something that's required
> for the stated aims of this series of dropping in compatibility shims.

Sure, but avoiding a prefix is also not a technical decision but an
aesthetic and ergonomic one.

Is using a prefix here great?  No, it's not great, it's shit.  But it's
shit that's easy to reason about.

If somebody sees a call to `xdl_free` in some code, they say "wtf is
this `xdl_free` nonsense?"  And they grep around and figure it out and
understand the way that this project handles heap allocations.  It's
very transparent.

If somebody sees a call to `free` in their code, they say "great,
`free`".  But it merely *appears* very transparent; in fact, there's
some magic behind the scenes that turns a `free` into a `git__free`
without you knowing it.  You've not learned the way that this project
handles heap allocations, but you also don't know that there's anything
that you needed to learn.  These are the sorts of things that you think
you understand but only discover when you _need_ to discover it because
something's gone very wrong.

In my experience, calling a function what it _isn't_ is the sort of thing
that a developer discovers the hard way, and that often leads to them
not trusting the codebase because it doesn't do what it says it does.

Cheers-
-ed
