Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAD0C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 00:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A30E223C6
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 00:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j40HqpDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbgKDAKN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 19:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgKDAKN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 19:10:13 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8FFC0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 16:10:11 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id v5so876607wmh.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 16:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8WiItp/JxQyY/F4r1GbqWOYTouXEKwgZIH2SNtHt/oo=;
        b=j40HqpDs4o/Lp+jC4rtHJvFrK1znLGlmJkraYb+P+r9m+7r14PgvNTtlQdtmGgRlPk
         2mLXejCHH9FVgBu6hD6TS/WaWvD3nyDA83aDoJa7i6JpVlMs9SBMytrfKrhKeGJOt8hz
         ZwwPZvodrVfS0ZL5TVXepiyHc7MQqQZYkDAnFhqytD8fBzXBOSf70aio+ev7aDPeFxYP
         63zZ0dOJEBHS/ojtFdc5CiDVw3Ziv0Iw06GeGFvAxhlyKjt+9d21kRRrZvi3+Eoey51t
         gnnt1q0nSx/jhuLCBLUHLlnKZctiJS0xJkpBvBvehwV1FFAWp58o0agzwsM4y1RqErwM
         RtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8WiItp/JxQyY/F4r1GbqWOYTouXEKwgZIH2SNtHt/oo=;
        b=Y/kSgdopBDIBeb7y6t84xURQfVcRhodh4vo103G4D8WM9B17SNyJcyBuNPAdaGPYim
         RS8W/gHpXqoTTcd3F18ewikkp5IhrOqietpcqou2gh8C1kZoK/5H9IUuqZUHqzI7FFUg
         ygs/s1Jtqbco+xFqU5kMxZtqMPfwc41AQrBbAJDUuUDybOcSjRLgb75kk5mBMS26k7MR
         mV1WqJLMp6n35YQDhUOGJGyGUS/k/X6CwQHC6qazQuMnZ5hC7ga1JM6zIqNfHFNXLiU1
         cr+oHhjLbZ9PVOA4bef4Z7l/cCnojhsnaPhP8f9LwEtWTXyCc+MtbVOjie0oDuAFS+pR
         eTNQ==
X-Gm-Message-State: AOAM530sOKlhuAlFSsco4JzUuSFuEfCxYs2QMwXZI9nn5SaPtxsrMDH7
        LRb0iUE9mWXAsFwrtpfIAQWiTR5OmX17N0wUqHA=
X-Google-Smtp-Source: ABdhPJwHoFKDGOXrniUx5vpYRvR7LbNebTprDntjYz8sbD5yFAUU2mZzyAbZ5AmV/0F5q5LecE9fzBAd/Kx2JkjkmD4=
X-Received: by 2002:a1c:9a8d:: with SMTP id c135mr1569967wme.173.1604448610068;
 Tue, 03 Nov 2020 16:10:10 -0800 (PST)
MIME-Version: 1.0
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
 <xmqqk1cz0zz1.fsf@gitster-ct.c.googlers.com> <CAMP44s3wqxTmgQpMgk2cM33EvtwrvvXYv4_90GKGmHb8yJHAKg@mail.gmail.com>
 <xmqqk0vbbep5.fsf@gitster.c.googlers.com> <CAMP44s13nip2_Z1OOFb9iVcrSxQbyJW4cH86J3Ah1p4SmTQWQQ@mail.gmail.com>
 <xmqqr1pj9rf0.fsf@gitster.c.googlers.com> <CAMP44s0nxQ8jxxw7wSPOMv9Nx1P7ww3S6dGv27xNVQ_aHTaPng@mail.gmail.com>
 <0ec43318-bf83-25c4-a817-a150e2e47546@haller-berlin.de> <CAMP44s0+TMhmPYM7omoFhcebMLhZyh6v77WUFNrscRtPNEDNHQ@mail.gmail.com>
 <xmqqeelh7y23.fsf@gitster.c.googlers.com> <xmqq361x7xj5.fsf@gitster.c.googlers.com>
 <CAMP44s2bgZbKde-UFL7+sR-7QgEv5Oiho2LTi3RG7S4BD0iuaw@mail.gmail.com> <xmqq7dr3nr9h.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dr3nr9h.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 3 Nov 2020 18:09:58 -0600
Message-ID: <CAMP44s1RS2-8rOvZLidRjkB=dkBGRpPzhpwpQByDRObP7UMLFw@mail.gmail.com>
Subject: Re: [PATCH 00/14] completion: a bunch of updates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Haller <lists@haller-berlin.de>, Git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 2, 2020 at 7:49 PM Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

> > There's a reason people prefer to use Git's official completion, and
> > there's a reason I wrote the wrapper.
>
> Do you mean by "the wrapper" the 'gitfast' one you offer in the
> oh-my-zsh collection?  If so, yes, I agree that 'gitfast' as "maybe
> less complete but usably faster auto-completer" is a good thing for
> end-users to have as an alternative to the Zsh default.

No, I mean the Git Zsh wrapper that I wrote.

It's in three locations right now:

1. https://git.kernel.org/pub/scm/git/git.git/tree/contrib/completion/git-completion.zsh
2. https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/gitfast/_git
3. https://github.com/felipec/git-completion/blob/master/git-completion.zsh

All these are the same thing.

If git was installing this wrapper by default, there would be no need
for the gitfast plugin, nor the git-completion project.

> But that was not the point I was raising.  I was saying that it was
> not making life better for them that we are posing as a valid third
> choice in that competition.
>
> Your "wrapper" can still be updated regularly to the latest to grab
> the bash completion part from "git.git".  To the Zsh audience,
> however, it would be more straight-forward if the choices were
> "there is Zsh default completion, but if you want to use a
> different/better version, grab 'gitfast' from the oh-my-zsh
> collection" than "you can use Zsh default, or you can install
> 'gitfast' in the way Zsh users are accustomed to from the oh-my-zsh
> collection, or you can manually install from git.git".  After all,
> the latter two would give them the same thing.

The default is by definition not a choice. You make a choice to move
away from the default.

And the gitfast plugin is not different from what was in contrib, in
fact I wrote a script to update it directly from there [1] (I changed
it recently to fetch from the git-completion project).

> It may be a good idea to leave a message in contrib/completion that
> nudges people toward 'gitfast' as an alternative for thowe who want
> to use something other than the default Zsh autocompletion.

If we are going to leave a message it would have to be for
git-completion, since not all zsh users use Oh-MyZsh (maybe most
don't), and gitfast is nothing but a copy of git-completion.

> Doing so would remove one level of unnecessary middleman (that is
> us) from the picture and make it simpler for end-users by reducing
> the number of choices from three to two.

This would break the experience of Homebrew users, and possibly Linux
distributions that do package this wrapper by default.

But if you are not going to consider graduating the scripts, we might
as well break the experience for everyone, so everyone is at the same
level.

> > They prioritize completeness over usability.
> > ...
> > No. Those people don't care if their completion is unusable.
> > ...
> > This is not possible, as the Zsh maintainers don't care about usability.
>
> I think our code of conduct applies to derogatory statements made on
> even those who do not regularly appear in this community.

To state the opinion of a person is not a derogatory statement. This
is literally what they said:

> > > Now, how about you make a compromise between "correctness" and
> > > usability?
> >
> > No.

I'm not doing anything but repeating their stated opinion. It is a
fact. If you don't like their stated opinion, feel free to talk to
them.

Cheers.

[1] https://github.com/ohmyzsh/ohmyzsh/blob/d69bad8eb4157e5fd5c1a4ce98f93cf522477a8c/plugins/gitfast/update

-- 
Felipe Contreras
