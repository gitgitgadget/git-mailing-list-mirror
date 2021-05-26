Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C86AC47088
	for <git@archiver.kernel.org>; Wed, 26 May 2021 23:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F272D61009
	for <git@archiver.kernel.org>; Wed, 26 May 2021 23:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbhE0ABA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhE0ABA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:01:00 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70CFC061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 16:59:26 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u11so3334605oiv.1
        for <git@vger.kernel.org>; Wed, 26 May 2021 16:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ycD6IxxPAO/xTpcqTmqTjAvw+9AZFbj+Wx7C1f4cByw=;
        b=sxwfnX1nIYDPCVvXIPRHGqjGdez0RSElDpohVB86igRYYQbRijyAaDWYUGl5SBV1fh
         PEojSrOd+kRRVYdXjym2d8DhkitCpO3MNHPXTunvFQZlQDeDfxRQOATiYACYfP9OvKIw
         Izct6kzMnPjhTV4K6ettBXWaKlbclAVK/o8Y7L/vlUbB6m6WyMZpjBS+HmmIR1ubbzoK
         O0cDPEs0Yen55pcBDJKWTSnG+7MEhxrKTyZ8zkAqH+B2XwVppF62QGjdjRy7Yp1rr9Z7
         kg1ne++B3jMW73BCT6+dGAdqj82Qza7Y8iRN2i9gRYsJER22HJP1YPi6/tkVMgRq9Jnz
         Ouug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ycD6IxxPAO/xTpcqTmqTjAvw+9AZFbj+Wx7C1f4cByw=;
        b=UZhaqHpbJyBGSbYIBmijElehlLKdUXgGhskPYqzIbiYnxYKEqhke32k+3BNh3PK9Xj
         BpNiNOaNcbxR6L6EqgZCsbO2qjPV9+0+LEKo5+jMek/LtzWxZX+p1Z64Nkl7Dwko4pK1
         my2bkJbLsZsTK7P5icnWsZrzwYWGSNkOFu8bMMy1ZKLQh46MggmW7upN/rss3UheMRhI
         w10v7QjdifN87+QlbNnt720AcaSecEbpVjjVYMfr57+wqiUMa1PoBRZDKEENVzgPCnTK
         TDbxxB+QwVMfWyDuZUa6KIW4UrO7nrfgLkm7nkICLlwQFUcdIEfUHsvLHdBZmZGBC53r
         OQZQ==
X-Gm-Message-State: AOAM532DTnL4L2otD/qpkgJkbYzmRWdwUcyMe2ZqD83Kh9NEp23Kn2eg
        8dK0l4uR8roov00fccQ3oX8=
X-Google-Smtp-Source: ABdhPJxPtN1EzVoLanBCEQn57ojvd7HSDpXRmZyfgWvZORLa8Xx9jQNPfemXNQ1LvOGrfGhA5J/WHg==
X-Received: by 2002:aca:670c:: with SMTP id z12mr3706913oix.131.1622073566145;
        Wed, 26 May 2021 16:59:26 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id d1sm168780otu.9.2021.05.26.16.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 16:59:25 -0700 (PDT)
Date:   Wed, 26 May 2021 18:59:24 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?SmFuIEtyw7xnZXI=?= <jk@jk.gs>
Message-ID: <60aee0dc3a6b0_75dc20855@natae.notmuch>
In-Reply-To: <875yz5m5hd.fsf@evledraar.gmail.com>
References: <CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com>
 <YKViF9OVLeA95JPH@google.com>
 <20210520071141.GZ8544@kitsune.suse.cz>
 <YKaaBj0KmJ3K5foC@coredump.intra.peff.net>
 <60a7fe0b2dd8d_558062087@natae.notmuch>
 <875yz5m5hd.fsf@evledraar.gmail.com>
Subject: Re: Should we do something with #git-devel on Freenode?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Fri, May 21 2021, Felipe Contreras wrote:
> =

> > Jeff King wrote:
> >> Of course there's value in coordinating. Everybody _can_ hang out on=

> >> their favorite venues and eventually talk to each other, but it's mu=
ch
> >> easier if everybody agrees where to go. :)
> >
> > I don't think it works that way.
> >
> > I "everybody" agrees to move to Discord, many old-timers won't. Same
> > with Gitter. And if most people were on IRC, many youngsters wouldn't=

> > come.
> >
> > There's a limit to how many chat applications you are willing juggle,=

> > and adding one more just to chat with git developers is something man=
y
> > people won't do.
> =

> In the case of IRC though there's many IRC-to-X gateways that allow you=

> to somewhat have your cake and eat it too, e.g. there's one for
> discord[1].

I have tried some of them, they don't quite cut it for me.

> I haven't tried it, but I use another channel that has an
> irc-to-Telegram (the app) gateway[2]. It works quite well. Aside from
> the Freenode v.s. Librechat question I wonder if there'd be interest in=

> having such a thing running for #git or #git-devel.

I think that would be very nice (if it works correctly).

-- =

Felipe Contreras=
