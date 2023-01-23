Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A864AC05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 16:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjAWQST (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 11:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjAWQSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 11:18:16 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C490113D3
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 08:18:06 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-4a263c4ddbaso179707007b3.0
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 08:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4V+M3nv1i59azj9M45e+L4AHNlikmv0/a9pyFv8sDt4=;
        b=Ukw5UILya4vShFiFhVL1U1CqefHQ3wCZYnS2Pn2YPsdITjSUovRJDc8q9dSjTjB3v3
         bmsj3Iul1uAd66H03tu3A60ps55MARx8TF6CpphK0yTUtHw3NOeJ+WxjUfr6OLzjKMdf
         w/1pX0tNAlBgRd0yZFs1RGXJhFMxmY/wK3MAt84tnwPYGDNMSH32bK4E2P/4QsD9dix6
         73zmpTKCFybnLSUiB5u0QJ0+0907k+tg1zaDBAf6vfoiB3S81mFBecXclUu9+bfXS1vp
         dWl6B1UMzaN6dNOdtjH3/F6FUWIheHvdzrzDBueEcbO2nsipo1h0gD2wIME5bLLLrrS9
         caDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4V+M3nv1i59azj9M45e+L4AHNlikmv0/a9pyFv8sDt4=;
        b=ISZEr5M108F2lITQrRi6e7S5iTIeNI9tpAunEKl4KlkXkzz7nXHD7MDlsbGj/aTP6n
         p/5cHmSgQIHkqTVjzNnJiEDD2C7ghGCfrppjQXM/roKOBDYa3YSm5z7kDpKvYTu9SwQ/
         dAcXloaWO6yIong5X+l/L0cAsQdSaqdR3aHzg6PllEYnSeF6q6v78KnFzZcNPocpTtwQ
         iFHJZCC2KiMLZcLjx+hhD+JX1DPOnJ4dmNFvA3icua3pY1P1aesjCluPcH6f968dSIYB
         T0sznFobEGOlewNJPg1vAvJqhDcuFDDoJ55yEBhQk8ULaeZutn+ZID1yiMZ1BNT4WZJ7
         SYoA==
X-Gm-Message-State: AFqh2kqgdyLrY3BGy4gECsu11W0k9hmAVxVtaYP5ruHng3F3hh82yGC0
        FJtbPcImNJYEgaBT2JvwljgilYXc/I8Q9f5pZs8CvCaxiszQEg==
X-Google-Smtp-Source: AMrXdXsWW1hetPdATixiqO1KykOGMzzbU0H+KbMCpGgmqBA2/Pb/9HprzJdvOQkP0u0swOsfAd3ZlM4u7ORS4gqqsdE=
X-Received: by 2002:a0d:cb44:0:b0:500:d985:6c45 with SMTP id
 n65-20020a0dcb44000000b00500d9856c45mr1122024ywd.175.1674490686079; Mon, 23
 Jan 2023 08:18:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.1270.git.git.1674029874363.gitgitgadget@gmail.com>
 <abec912c-065d-2098-962e-41f9646dd046@dunelm.org.uk> <8025d5c7-ab55-c533-1997-05b4c7339d61@dunelm.org.uk>
 <CAEroKagqxC86X0SD8=tK0w+yXL7QecZ+z_7sja-K6ajs0=Z=BQ@mail.gmail.com>
 <55282dec-825f-8c4b-1fb0-6e26ec326db1@dunelm.org.uk> <20230120090331.37dxkko6bgxbjae7@fs>
 <6e57bef8-7387-3341-5ed5-4bcfa7ded7a0@dunelm.org.uk> <20230123100245.3qbscxkgvbnh7ilt@fs>
In-Reply-To: <20230123100245.3qbscxkgvbnh7ilt@fs>
From:   Adam Szkoda <adaszko@gmail.com>
Date:   Mon, 23 Jan 2023 17:17:30 +0100
Message-ID: <CAEroKaifs8uLnOCsAhqJkEpkpEfRd+HTnTG3i+6syZZ7Ex3dVA@mail.gmail.com>
Subject: Re: [PATCH] ssh signing: better error message when key not in agent
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     phillip.wood@dunelm.org.uk,
        Adam Szkoda via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!  I've pushed a patch that adds `-U` conditional on is_literal_ssh_key()=
.

According to the OpenSSH issue ([1]), that option is backward compatible:

> It should be safe to use -U even for older versions. It won't require the=
 agent (as openssh-9.1 will) but it won't cause an error.

[1]: https://bugzilla.mindrot.org/show_bug.cgi?id=3D3429

Cheers
=E2=80=94 Adam


On Mon, Jan 23, 2023 at 11:02 AM Fabian Stelzer <fs@gigacodes.de> wrote:
>
> On 23.01.2023 09:33, Phillip Wood wrote:
> >On 20/01/2023 09:03, Fabian Stelzer wrote:
> >>On 18.01.2023 16:29, Phillip Wood wrote:
> >>>Hi Adam
> >>>
> >>>I've cc'd Fabian who knows more about the ssh signing code that I do.
> >>>
> >>>On 18/01/2023 15:28, Adam Szkoda wrote:
> >>>>Hi Phillip,
> >>>>
> >>>>Good point!  My first thought is to try doing a stat() syscall on the
> >>>>path from 'user.signingKey' to see if it exists and if not, treat it
> >>>>as a public key (and pass the -U option).  If that sounds reasonable,
> >>>>I can update the patch.
> >>>
> >>>My reading of the documentation is that user.signingKey may point
> >>>to a public or private key so I'm not sure how stat()ing would
> >>>help. Looking at the code in sign_buffer_ssh() we have a function
> >>>is_literal_ssh_key() that checks if the config value is a public
> >>>key. When the user passes the path to a key we could read the file
> >>>check use is_literal_ssh_key() to check if it is a public key (or
> >>>possibly just check if the file begins with "ssh-"). Fabian - does
> >>>that sound reasonable?
> >>
> >>Hi,
> >>I have encountered the mentioned problem before as well and tried to
> >>fix it but did not find a good / reasonable way to do so. Git just
> >>passes the user.signingKey to ssh-keygen which states:
> >>`The key used for signing is specified using the -f option and may
> >>refer to either a private key, or a public key with the private half
> >>available via ssh-agent(1)`
> >>
> >>I don't think it's a good idea for git to parse the key and try to
> >>determine if it's public or private. The fix should probably be in
> >>openssh (different error message) but when looking into it last time
> >>i remember that the logic for using the key is quite deeply embedded
> >>into the ssh code and not easily adjusted for the signing use case.
> >>At the moment I don't have the time to look into it but the openssh
> >>code for signing is quite readable so feel free to give it a try.
> >>Maybe you find a good way.
> >
> >Thanks Fabian, perhaps the easiest way forward is for us to only pass
> >"-U" when we have a literal key in user.signingKey as we know it must
> >a be public key in that case.
>
> Yes, i think that's a good idea as long as the `-U` flag is ignored in ol=
der
> ssh versions and shouldn't be too hard to implement. And it should work j=
ust
> as well when using `defaultKeyCommand`.
>
> Best,
> Fabian
>
> >
> >Best Wishes
> >
> >Phillip
> >
> >>Best regards,
> >>Fabian
> >>
> >>>
> >>>Best Wishes
> >>>
> >>>Phillip
> >>>
> >>>>Best
> >>>>=E2=80=94 Adam
> >>>>
> >>>>
> >>>>On Wed, Jan 18, 2023 at 3:34 PM Phillip Wood
> >>>><phillip.wood123@gmail.com> wrote:
> >>>>>
> >>>>>On 18/01/2023 11:10, Phillip Wood wrote:
> >>>>>>>the agent [1].  A fix is scheduled to be released in OpenSSH 9.1. =
All
> >>>>>>>that
> >>>>>>>needs to be done is to pass an additional backward-compatible opti=
on
> >>>>>>>-U to
> >>>>>>>'ssh-keygen -Y sign' call.  With '-U', ssh-keygen always interpret=
s
> >>>>>>>the file
> >>>>>>>as public key and expects to find the private key in the agent.
> >>>>>>
> >>>>>>The documentation for user.signingKey says
> >>>>>>
> >>>>>>  If gpg.format is set to ssh this can contain the path to either y=
our
> >>>>>>private ssh key or the public key when ssh-agent is used.
> >>>>>>
> >>>>>>If I've understood correctly passing -U will prevent users
> >>>>>>from setting
> >>>>>>this to a private key.
> >>>>>
> >>>>>If there is an easy way to tell if the user has given us a public ke=
y
> >>>>>then we could pass "-U" in that case.
> >>>>>
> >>>>>Best Wishes
> >>>>>
> >>>>>Phillip
