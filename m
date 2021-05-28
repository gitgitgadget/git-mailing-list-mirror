Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5249C4707F
	for <git@archiver.kernel.org>; Fri, 28 May 2021 03:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F8B3613D4
	for <git@archiver.kernel.org>; Fri, 28 May 2021 03:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbhE1Das (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 23:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhE1Dar (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 23:30:47 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBCAC061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 20:29:12 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so2226630otc.12
        for <git@vger.kernel.org>; Thu, 27 May 2021 20:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=B1e0tsy3Asjw3k7eXYOLjDvRHiq7Y6Cad5shEI6l0l4=;
        b=hOSeb5qHMFYjU1n3gc+uh8w+4IltTkcrsji2mev2GO+eFngZ1SyJJ+FwJu/yQ0rZbW
         T1oC3b0ixwvAkMFZVqVbfcx2Wh+T+ViB0XMiqhPXHLjoiIFie7PmkHi44EbFs6zsoCvM
         HKf1yWfzJHeQg4e9dkjYEOR0JyFSW466TJ8nhw3K8/c0hRNOfnC9dZdCNj3Xe1rBwyu0
         UZyTZZwXwb0N0GFc4RIN5js5lqgI4JDZMFKboRSLC2Sc/d3YOaIoSPd+lty0ZsY1k4Z/
         fjyTj2jLZLnq2O2f+592sGw/DSlJ/gh3MfG8Taj83hibbAmEfSS2ZsORYVFCoRi2/8n9
         bVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=B1e0tsy3Asjw3k7eXYOLjDvRHiq7Y6Cad5shEI6l0l4=;
        b=BiKbaSlRaVGJq5vRLux2m6nOvlqMTWKf7vp8Y7H52dWKO0XOQp5HBuzMKUZNikpzW3
         xscbZoWxddNxJfC3PdJhjMo3KkP1TFk84M5+kxIEBYAg0IS/7G9aLAl9c0HwEULfdF7L
         Un1dB3GIn3WTKxU4XXuRzLQObOUzPn9iuEyS9/iiBk6wWyZIfwLtEsYZ+6XrFomqBbg/
         bm//SFur8O5e1ogL6z+/zv/dD1kCvJRg0YWW2e2hQzn1Zn2ERnbznshmbhTw8UuhteBt
         F4NwCz5L/NEU0BsAmgtqsvm9fy8HkPvFBkRNNL9y6xx+bO1JBxiBxI5371q5zjiyJIi3
         SuAw==
X-Gm-Message-State: AOAM531Qb9TpFU13r/UZW+4tTZ9wWEmeRcrDYn8MR3gbOJsLnSX0aX7B
        +85pSpEydBRsHaOPo/5JXx8NuOqQn0jYSQ==
X-Google-Smtp-Source: ABdhPJwKrpV6WgE92K5smsfKr5Wu1DWO3TCbECyuT5ddy9anKjRcFOFYz+w4C54TZyf9qysFpdeMTA==
X-Received: by 2002:a05:6830:1ac7:: with SMTP id r7mr5215257otc.167.1622172551718;
        Thu, 27 May 2021 20:29:11 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id i4sm920526oth.38.2021.05.27.20.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 20:29:11 -0700 (PDT)
Date:   Thu, 27 May 2021 22:29:10 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?SmFuIEtyw7xnZXI=?= <jk@jk.gs>,
        Kevin Daudt <me@ikke.info>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>
Message-ID: <60b0638618044_49b58208a4@natae.notmuch>
In-Reply-To: <YLBJJEQEUW8MVJm8@nand.local>
References: <CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com>
 <YKViF9OVLeA95JPH@google.com>
 <20210520071141.GZ8544@kitsune.suse.cz>
 <YKaaBj0KmJ3K5foC@coredump.intra.peff.net>
 <YK6XvmrtrdkJvsnI@nand.local>
 <YK6o/j7P0JIGW0Q0@alpha>
 <7e9683aee2c0fea2ff77b82bfa547e15@jk.gs>
 <87im33ltqr.fsf@evledraar.gmail.com>
 <60b046dd3f5f2_40592208df@natae.notmuch>
 <YLBJJEQEUW8MVJm8@nand.local>
Subject: Re: Should we do something with #git-devel on Freenode?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau wrote:
> On Thu, May 27, 2021 at 08:26:53PM -0500, Felipe Contreras wrote:
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> > > I don't see why we'd advertise #git@liberachat and not #git@freenod=
e in
> > > order to achieve that goal, the latter doesn't seem to be a graveya=
rd
> > > and is probably still more active. I don't see why we'd need to pic=
k
> > > between the two, any more than we'd pick between advertising
> > > #git@liberachat and the git-users mailing list. Both currently seem=
 like
> > > useful venues for git users to go to get help.
> >
> > Agreed.
> >
> > The primary purpose of an IRC channel should be to help users, and if=

> > right now the person that could help a user is on freenode, so be it.=

> >
> > If the people with some political alignment want to emphasize
> > LiberaChat, that's fine, but keep mentioning freenode.
> =

> git-scm.com was updated recently to mention LiberaChat instead of
> Freenode [1]. That was done to reflect the reality of [2]. I suspect
> that will have been the right decision, but in case it isn't (and
> there are still people hanging around in #git on Freenode), then I'd
> be in favor of mentioning both.

As of this moment (2021-05-27T22:20:00-0500) there's 324 people on
Libera.Chat, and 762 on freenode.

So yeah... I'd say there are still people hanging around in #git on
freenode.

> For what it's worth, I also do not care about the Freenode versus
> Libera (or vice-versa?) debacle. That said, I do think having one
> central place for people to hang out is better than two (if for no
> other reason than it's fewer places to check or go to if you want
> help), but I would be fine if the status-quo were that there is an
> active #git channel on both Libera and Freenode.

Sure, one would be better than two, but rarely can we pick the reality
that is better... Reality just is.

Cheers.

-- =

Felipe Contreras=
