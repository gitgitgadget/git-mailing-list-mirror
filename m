Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAD3C6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 23:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjCWXfK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 19:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjCWXfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 19:35:09 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD9C24127
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 16:35:08 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id i6so287182ybu.8
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 16:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679614507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNyp0jq5uQ5hPtb4wEBa7KIN/R9ouGjwDqPMqDQzfv8=;
        b=UOhVarNIYigx9PXzAlTCg8RNt5Uec0fXLxikFDfkW7ZSntUCXUm+SIg7d0nZ36WuLO
         E1n0bPLIVdUcBzNybm7uTr4h0kmeHtd0Q4mzUlEn/E4/fkRB95WpPLlYhkIVZYRQYs70
         BKjBtLhgaZVtQbFGDkOEWAlmIz9Dl9ps859/TyeKieBZzBUApLlvRSrmyVaMP+nXg0Hr
         FCCUGolUve5tDxBlH6EKuZ4wfkFZyX0gGbCxzJ5NBM9jbyEuCwMn3anuZOT2j/SqW2QT
         +dK5Ispm53vlr+Qou0bjX31A4GTaIZ6J1andf1Q8uYVB1sXXrs0Fa1IKfWQ02H7tmXpo
         NG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679614507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNyp0jq5uQ5hPtb4wEBa7KIN/R9ouGjwDqPMqDQzfv8=;
        b=LIH1xjUCffWcbCKP1SlM9ZoFAtnTqVPy7l/A2r1+T1HtUr0TammBcNQ4G3SPqJc/39
         n0meFlPW5ofqMCKNVG3ifHp20y0JujW6wq+1OjjnjqwJF9O+ROEXWo+iZvX8/todAydM
         JPnpuSk0ANZTuSoi5iuf9SvVb6HbyWItasqwR/0gc8xHIzJPOk5RJUzsqP+n/RylfJr9
         Ak3WuhKWsNzzsV/aCPC9qR8OzpnwEdn/s/lntx44VHyAA2kFd3pvGHG7u0j9qppWfh71
         VqsGKAllRvEQuYrTDRS6OEHRZr2ZthF5asyGIxaZrUvpIsdxLPqNdAv8YqTYLGLsYLXR
         3OnQ==
X-Gm-Message-State: AAQBX9dFfxOyEuh5v0DEYfTTZf4I4uqhSs2vMcr6bIennpmN3TE8i5YV
        BofTjet/X8hPtAH1H5PcwMK92bj1b0GMDagBuRI=
X-Google-Smtp-Source: AKy350bsllrP+nRXIOIEXZhc12Skk/gOdPbq5H3hCsj2JCiMSbcglJX4xK+yDmYagtb2P/6s3GsLwkWoleexv71mMKs=
X-Received: by 2002:a05:6902:70d:b0:b45:5cbe:48b3 with SMTP id
 k13-20020a056902070d00b00b455cbe48b3mr243145ybt.0.1679614507515; Thu, 23 Mar
 2023 16:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
 <xmqq3573lx2d.fsf@gitster.g> <CANgJU+XoT42u91WP7-p4V41w7q-UVhutL2LUfNkp3_BRCOn-FQ@mail.gmail.com>
 <4222af90-bd6b-d970-2829-1ddfaeb770bf@dunelm.org.uk> <CAMP44s1Qqd2cYcf7OGxz1-PY-8TF2KG+9jPEWMrnCaCfPe_1sw@mail.gmail.com>
 <008101d95ddf$7863d900$692b8b00$@nexbridge.com>
In-Reply-To: <008101d95ddf$7863d900$692b8b00$@nexbridge.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 23 Mar 2023 17:34:56 -0600
Message-ID: <CAMP44s1X6LGpFfA_Zb_GakXehBJDeGrfFcehPgv+YM++xKHN3A@mail.gmail.com>
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
To:     rsbecker@nexbridge.com
Cc:     phillip.wood@dunelm.org.uk, demerphq <demerphq@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2023 at 5:30=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>
> On Thursday, March 23, 2023 7:22 PM, Felipe Contreras wrote:
> >On Sat, Feb 18, 2023 at 5:12=E2=80=AFAM Phillip Wood <phillip.wood123@gm=
ail.com> wrote:
> >>
> >> On 18/02/2023 01:59, demerphq wrote:
> >> > On Sat, 18 Feb 2023 at 00:24, Junio C Hamano <gitster@pobox.com> wro=
te:
> >> >>
> >> >> Emily Shaffer <nasamuffin@google.com> writes:
> >> >>
> >> >>> Basically, if this effort turns out not to be fruitful as a whole,
> >> >>> I'd like for us to still have left a positive impact on the codeba=
se.
> >> >>> ...
> >> >>> So what's next? Naturally, I'm looking forward to a spirited
> >> >>> discussion about this topic - I'd like to know which concerns
> >> >>> haven't been addressed and figure out whether we can find a way
> >> >>> around them, and generally build awareness of this effort with the=
 community.
> >> >>
> >> >> On of the gravest concerns is that the devil is in the details.
> >> >>
> >> >> For example, "die() is inconvenient to callers, let's propagate
> >> >> errors up the callchain" is an easy thing to say, but it would take
> >> >> much more than "let's propagate errors up" to libify something like
> >> >> check_connected() to do the same thing without spawning a separate
> >> >> process that is expected to exit with failure.
> >> >
> >> >
> >> > What does "propagate errors up the callchain" mean?  One
> >> > interpretation I can think of seems quite horrible, but another
> >> > seems quite doable and reasonable and likely not even very invasive
> >> > of the existing code:
> >> >
> >> > You can use setjmp/longjmp to implement a form of "try", so that
> >> > errors dont have to be *explicitly* returned *in* the call chain.
> >> > And you could probably do so without changing very much of the
> >> > existing code at all, and maintain a high level of conceptual
> >> > alignment with the current code strategy.
> >>
> >> Using setjmp/longjmp is an interesting suggestion, I think lua does
> >> something similar to what you describe for perl. However I think both
> >> of those use a allocator with garbage collection. I worry that using
> >> longjmp in git would be more invasive (or result in more memory leaks)
> >> as we'd need to to guard each allocation with some code to clean it up
> >> and then propagate the error. That means we're back to manually
> >> propagating errors up the call chain in many cases.
> >
> >We could just use talloc [1].
>
> talloc is not portable.

What makes you say that?

Either way, there's multiple libraries that do the same thing, and of
course one could be implemented within Git. It's not that complex.

--=20
Felipe Contreras
