Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F3AC4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 22:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A8C3206B2
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 22:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzdeQyC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832284AbgJ0WTX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 18:19:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37047 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1832259AbgJ0WTT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 18:19:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id w1so3621806wrm.4
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 15:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=04G5ON9CyRpRFFa8XO0JOpD858+zHK5bBrXRKJB3S1c=;
        b=MzdeQyC1YdCdiI7KEWBzt/3QfPn/v5RCHbku+pdY8xX0tp+lzkGbNIC4Gx7vz6eddZ
         o6pH3ajAwgNJ1kPNA0KEi3FTX9XhRo1+U6rq1Gvn2who5ycDgeJqRnntHc1DBFo1dJFI
         NAriW4AG9EsqQ7tcTTA2/+q6PKeo7X/LQBLUJstqQkD3DErb5U6NuHWwS8x+vWecCURo
         sV094VP5pFyoiJ3sswHy1ziSchid8sigSFcziPSu4Ghv9SJxcJ5kxB8J9orqMxRLc5Q1
         SleP8yYfI1qAm0K7B6xZCI4uJoedP9s6jqR1uE/NKd2LvKemczrArFWgm3Ru0YW4sbeC
         F2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=04G5ON9CyRpRFFa8XO0JOpD858+zHK5bBrXRKJB3S1c=;
        b=gxt0u68pD0EVH/U/RWMQMkSPqyRK03ZmgXaAj5sPb84dQis5x5Ri6xxiMFjFLO+9pa
         rCHEakaRVB38AE5qCI8U6HXFANdEgcdE8R5W+QeOfRjdoMJnB+/knqEMbEm3B4cx25ur
         Qfv2K2whiPWhVpFw0ej9lu94+2BvMFb+RuWyK/wXh2GEDCXhZNltBgBfIq4rRhO46R4C
         WB7x54BshdZ+CYXG9zb+Fb1HmFKDVdaKMgiaZO/s5DdTOu/okxV4pqRD7WjPAGRAHW6n
         X3vbEKlYTF9Ah7RGoyFH1cvSTfe/0hNO5d0ct1nFvNcGWOdBU4LUNFAtqtLpgzGUUbDm
         OzXQ==
X-Gm-Message-State: AOAM531lMjmyqN3HfsR6XdY9+mXYUw8rCsXoYjImiw3AtxtiYxN/OtBd
        rAq5zD6uJemldMF3zh8R4KHalf0fwH9g3GiGSSM=
X-Google-Smtp-Source: ABdhPJySx/CbMvlIK2UjsNPnfvqc3RsDw6e+l3d2L1pXw2eYjLwL/Fkx50XbKFKeYA1HHNyb2GptG1ukC44umVRdgHw=
X-Received: by 2002:adf:ff8e:: with SMTP id j14mr5464107wrr.255.1603837157118;
 Tue, 27 Oct 2020 15:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
 <xmqqk1cz0zz1.fsf@gitster-ct.c.googlers.com> <CAMP44s3wqxTmgQpMgk2cM33EvtwrvvXYv4_90GKGmHb8yJHAKg@mail.gmail.com>
 <xmqqk0vbbep5.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk0vbbep5.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 27 Oct 2020 16:19:05 -0600
Message-ID: <CAMP44s13nip2_Z1OOFb9iVcrSxQbyJW4cH86J3Ah1p4SmTQWQQ@mail.gmail.com>
Subject: Re: [PATCH 00/14] completion: a bunch of updates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 27, 2020 at 2:23 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:

> > You are asking in the wrong forum.
> >
> > I would gladly point you to *dozens* of issues reported in Stack
> > Overflow and Oh-My-Zsh if you don't believe me.
>
> Oh, no, there is no "believing" needed.
>
> Have you fed your patches to those folks who have dozens of issues
> and the patches made their life better?

Yes.

> It does not help much to
> make me look at these forums; we need some way to make those in
> these forums aware of your improvements, try them out and report
> success,

They already are, and they already have. In those forums.

> (they will get
> their zsh/git completion from their distros---I am assuming that the
> distros get theirs from us in contrib/completion/).

I don't know of anyone that relies on the zsh completion shared by
their distribution.

> > Or you could just install zsh and see the issues for yourself.
>
> No, thanks.  I am not a zsh user, and have no plan to become one ;-)

You don't need to become a zsh user to test a patch. I often test bash
completion patches on bash, even though I'm not a bash user.

Cheers.

-- 
Felipe Contreras
