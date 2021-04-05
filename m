Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876E9C433B4
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 23:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38610613AE
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 23:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241948AbhDEXmk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 19:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241939AbhDEXmf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 19:42:35 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47E8C06174A
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 16:42:26 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id o126so19892659lfa.0
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 16:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hw+/XVekFi+UNXrSlRMSGO3PUsAWRQZAiUgktNmc7a8=;
        b=tS99lweevA3xsolsJhwIqfRiRVxdRBk0y8U4upp+LCQcKfbS3Ejf2nJUnc63d+qszC
         PHpxqstuv8VsGJLYvwxw2PsP+ItUspdPNPEH/o43z7g+0u0rSWXZNdrAw5Ph+kvC5TkB
         z5osxPhwPf6W3/eJIJRncU65xC+QgiIcAkFawbFQymrZrHLrQebP5iMfvtNXPaHTU5or
         R99YUUvlLuh6yqm5kziv5nf9uer5hq8C0t9Hyh8HPUIskWkr3vmP85BAKvIpSBiJQQax
         Gr3afX0N7AIIpD2gbaheH0hm0SSH7pviEZXuITRhMxMNpuA6zWyJraFqNoBEBV8irCZX
         b/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hw+/XVekFi+UNXrSlRMSGO3PUsAWRQZAiUgktNmc7a8=;
        b=g1PeltUzGjx10DBFhssnd8/TZTs9HFazejKDcIF1MmnlgtRIC8D7Otb5u896rRSPT4
         GzwThF+tt1m/IKZC2VvuZKghcUu3ETJKrW6feUem9RHbN6KJTjH+CBkMYifINwbNPR7p
         9IDPu1GHaoNRWa9WBl+akyYeSSyuknR/g8ShVKJrGR+kc7WVlfNWQyFsOgfVcm3Ch6n4
         Iadfuojpb07KT8gPkvQBbdCpvyH/0AgCUkSotAkjZtWhpl5O8yK2H8HO2+DtzjBspzue
         jaHE+oQqKMLL+Md5G20nEe9gOiK053cZ1secNBqVRFR+IIs3Wdb6mEvuD4D9ZJOwzs74
         P0jQ==
X-Gm-Message-State: AOAM530n8Z8ZDgy8e6xRXPWguPeccKpP53TVuZ0jegfAjsgds2UBr7LM
        VvBWHuL71N2ac+ovJ4dEZ6HBgW4TV/XjAUopp0w=
X-Google-Smtp-Source: ABdhPJwYhMkzwOEzN5//9/HCvCkJXQjeW8MlZmwtewNPyG9yXu5M0i/HQu8qhYe3t7NGXoymqVMUv6w4yER9HwyMo4Q=
X-Received: by 2002:ac2:4883:: with SMTP id x3mr18544203lfc.419.1617666145251;
 Mon, 05 Apr 2021 16:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
 <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com> <8735w9knx4.fsf@evledraar.gmail.com>
In-Reply-To: <8735w9knx4.fsf@evledraar.gmail.com>
From:   Albert Cui <albertqcui@gmail.com>
Date:   Mon, 5 Apr 2021 16:42:14 -0700
Message-ID: <CAMbkP-TL3f9V4bGp3bDq_7=E47JKdh5ua2giRZKaUrvODOPWew@mail.gmail.com>
Subject: Re: [PATCH v2] hooks: propose project configured hooks
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Albert Cui via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 2, 2021 at 2:59 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Fri, Mar 26 2021, Albert Cui via GitGitGadget wrote:
>
> > From: Albert Cui <albertqcui@gmail.com>
>
> Formatting nit:
>
> > +Git has https://git-scm.com/docs/githooks[hooks] functionality to allo=
w users to
> > [...]
> > +local checks of code e.g. linting. As documented in
> > +https://git-scm.com/docs/gitfaq#_hooks[gitfaq], in some cases, server-=
side
> > +checks may be more appropriate, especially since developers can always=
 skip
>
> This should be a linkgit:* even in the technical/ directory, should it
> not? We build docs on git-scm.com (among others), but in our source tree
> we should be using linking syntax, not linking to our own already-built
> docs on some website.

Yes, thanks. Good catch.
