Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51472C63798
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 19:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D337D22227
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 19:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uB8aBCFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgKRTFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 14:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgKRTFH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 14:05:07 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D4EC0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 11:05:06 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p1so3213300wrf.12
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 11:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F0R4lvrwypDbHxr5Ujo9Iwj0dNmlzM5dcGCNlK8rHYg=;
        b=uB8aBCFDO6GznkBB8fN0d0JCCoB9qt5o73ErSYvxYYDYGNtgRhNYJlvX04yyKeCJv7
         RsVoaCd6qwd+OSuxNfd6dU67GJVS6AKDGut3NH/9rogUGO7jEy9mp50ZroEYWlDtqHJ0
         /qPxhiWsJdkWivqeyjXOh6tDh+wHC/m6PzRDU2RvE2UEO2TJOwzh8lmDWzeC8RcEsVqT
         p6+8xm90SSQQqnI4ATIfbgIk4YclfkQ7TBPePVoAqIY6Mnp5btdRTfUyyvpaLoyjaUx5
         40P2ewKo/XEVKebgr7yWKevL6YgWavz+R3jRLOkfCl1YEf1h47yF79R1zlyhFWGE6T05
         er3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F0R4lvrwypDbHxr5Ujo9Iwj0dNmlzM5dcGCNlK8rHYg=;
        b=HSMVF1Yy2zVMuY5ExByqF0jUKURr4x7mmKD7BUl8+q5s+Ra/v2yVGggUCPaNgLYpct
         yOvMjNqHPnAmwpkxEfhd9UHISqK2k85zrEiHyvjdalmLCmWgR5oTnrPWpGF6v5zP7wQw
         hP1+lM/wrz9qChX+RhiWpMXulizgD98+GLQhAwdEG7k5D0vEkvA24z2g1RvRjG3/6Lh3
         TmFP8/8VghADIeSEu3/c/BH58YUtok0IHdS4xtAByioH0B4N22+UwjwWE0NIUkn19ogH
         y7fKKE+iftNQm9i4hN4Oa1ov/Y/vWlgoTPL2JZ6kFtqitiIvP7z0cok3mOtFD7RhjcK9
         Fddg==
X-Gm-Message-State: AOAM530zO8yu2n60HvC/26YC4XE+nux+zTyKko089fb7IKareY1qZX4Z
        +WdK6xY+iv2ZcP+QhCiP9Bbw/WU6sRw6iKZqTDnkFFDy2xlKHg==
X-Google-Smtp-Source: ABdhPJzRyFuNqJomNxEyrewIzBUD+eDGeI3yzkKiXNXNwvUy12u8UhceCCNsRnKlXkkUBdbRysqxsJKTspJvXNlmCW8=
X-Received: by 2002:a5d:4349:: with SMTP id u9mr6194387wrr.319.1605726305711;
 Wed, 18 Nov 2020 11:05:05 -0800 (PST)
MIME-Version: 1.0
References: <20201118091219.3341585-1-felipe.contreras@gmail.com>
 <87wnyjdnb3.fsf@evledraar.gmail.com> <xmqqwnyi3bml.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqwnyi3bml.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 18 Nov 2020 13:04:54 -0600
Message-ID: <CAMP44s0Wvb_czYs6jaG=iwSOuGWvjksNo_sjjg3EKx18Ex2Fig@mail.gmail.com>
Subject: Re: [RFC/PATCH] Add fetch.updateHead option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Dominik Salvet <dominik.salvet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 18, 2020 at 9:53 AM Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> > I haven't taken much time to re-think through the patch/implications of
> > this, but I remember running into this and going through some pre-patch
> > investigation at some point.
> >
> > It's really annoying in some cases that "clone" isn't creating the same
> > state as "remote". IIRC I was doing some heuristics to figure out the
> > remote branch name etc.
> >
> > Isn't this something we can just change without an option? There were a
> > bunch of cases in clone/fetch that were different for no different
> > reasons, IIRC I patched one or two of those in the past. But I haven't
> > gone through the history of the feature and checked if it was
> > intentional.
>
> I think what Peff outlined earlier was reasonable.  "remote add -f",
> since it talks with the remote, should be able to learn where their
> HEAD points at and set it up.  "remote add" that does not talk to
> the remote cannot do so and "fetch" could help but we should not
> touch existing refs/remotes/$name/HEAD by default [*1*], as the
> symref is meant to indicate the local choice of which one of their
> branches is significant to _us_ and what "clone" does is merely to
> give it the initial value.

The new suggested behavior (fetch.updatehead =3D missing) is that "git
fetch" touches $remote/HEAD *only* when it doesn't exist.

So if you set $remote/HEAD manually, you would not affected.

However, that behavior is clearly not ideal in the long term, since it
seems basically nobody uses that feature.

Either way I see no argument against adding this option, and making
the default fetch.updatehead =3D never, which doesn't change the current
behavior at all.

> But when interacting with a remote whose choice of HEAD is always
> what the local user wants to follow, letting "git fetch" update
> refs/remotes/$name/HEAD to a newly observed value would be a welcome
> optional feature.

That would be fetch.updatehead =3D always.

Cheers.

--=20
Felipe Contreras
