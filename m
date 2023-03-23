Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E123C6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 23:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCWXzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 19:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCWXzm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 19:55:42 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE0A7DA0
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 16:55:41 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id y5so346051ybu.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 16:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679615740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLz6+3S3wsjbzqWYFbHPh9c2gAMExit9yVX7THQ2W38=;
        b=LyrQWbLPWuem0fA5Z1iBNkC1ffWdyzxaBSyjKu+6MBuY9yYjPqh5rgd8C/bWJy3n7w
         qc5mEW1dV2OL5CZalHO7PHnVVQJsl7IliEGGMtXuNFb0Cl8aeBlmPtMAMfLunjtpysED
         55nPn6soibRF3X7e73jIUfIg85wT0j6meVlRS0PNmtoUkQ9Mu+miNjXlgwWN/U/3LWAa
         cwxjGMR2BdYnPfLPMtTMB95OmKn5JlIjufuZ1JZ7jD3s4RAuQqvYHNOW6W8c2nIRO/C7
         vDlKX9/5K3Tniu3d7pLrC4D1+p692MOXWNDHl87Q9OfUJq6EOqIsUd2AzqBLObvHpol2
         zq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679615740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLz6+3S3wsjbzqWYFbHPh9c2gAMExit9yVX7THQ2W38=;
        b=QHVqOilWaLLdV8Y0Yk0RKe+v9iCuM/Jg9Bhi//WJittaePTiCm3G/9dJ8X3ErgNPEG
         AZS+2bURi7mbk8Ib7KIOIvTYn+jVZ5hbF74Slo89rXPUGAU52nCmvJ58Za/a1wv2QCBy
         WyKvQka6YWTb1yUmmvjq8WROPc7OwXsND23cWXdtaSG8pq/+wWPQEipLByIFERjtcYu/
         Wk6ruH+DrsjGl1kQdkPKvJdGa2Hl0MIvoGQ6O6hlTs7LMlP5MsjhIkJuafuqsgyxNDRp
         Jm8yMe7plLrMnwmc485m16D7GZjfI/pSB+lKSn8imi0a3RYk5vlWtbUEYpz4R5BT3JMK
         YerQ==
X-Gm-Message-State: AAQBX9fXc2dOEsGI7Z54hLOdfOtibPfntkxawryVOic0P8Hb0bL9gE3X
        0kSW89nMslNW2mj0fDpBn645/Spf2yF4rHTbcPg=
X-Google-Smtp-Source: AKy350YWIKKnZBXYL/46+4A/KnNrfAZptYEJbQyQ3GJSPR9Acx0TogYResxtWyH9sWYFCaE0RC8pT/zs5JfqhFg51Vg=
X-Received: by 2002:a05:6902:1083:b0:b69:ca6f:452c with SMTP id
 v3-20020a056902108300b00b69ca6f452cmr283790ybu.0.1679615740280; Thu, 23 Mar
 2023 16:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
 <xmqq3573lx2d.fsf@gitster.g> <CANgJU+XoT42u91WP7-p4V41w7q-UVhutL2LUfNkp3_BRCOn-FQ@mail.gmail.com>
 <4222af90-bd6b-d970-2829-1ddfaeb770bf@dunelm.org.uk> <CAMP44s1Qqd2cYcf7OGxz1-PY-8TF2KG+9jPEWMrnCaCfPe_1sw@mail.gmail.com>
 <008101d95ddf$7863d900$692b8b00$@nexbridge.com> <CAMP44s1X6LGpFfA_Zb_GakXehBJDeGrfFcehPgv+YM++xKHN3A@mail.gmail.com>
 <008201d95de1$359285c0$a0b79140$@nexbridge.com>
In-Reply-To: <008201d95de1$359285c0$a0b79140$@nexbridge.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 23 Mar 2023 17:55:29 -0600
Message-ID: <CAMP44s3Gk67rPEPjoAxLHS4KrCQBb6VoPJ6Rqm-FTK+8PTaRRQ@mail.gmail.com>
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

On Thu, Mar 23, 2023 at 5:43=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>
> On Thursday, March 23, 2023 7:35 PM, Felipe Contreras wrote:
> >On Thu, Mar 23, 2023 at 5:30=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
> >>
> >> On Thursday, March 23, 2023 7:22 PM, Felipe Contreras wrote:
> >> >On Sat, Feb 18, 2023 at 5:12=E2=80=AFAM Phillip Wood <phillip.wood123=
@gmail.com>
> >wrote:
> >> >>
> >> >> On 18/02/2023 01:59, demerphq wrote:
> >> >> > On Sat, 18 Feb 2023 at 00:24, Junio C Hamano <gitster@pobox.com> =
wrote:
> >> >> >>
> >> >> >> Emily Shaffer <nasamuffin@google.com> writes:
> >> >> >>
> >> >> >>> Basically, if this effort turns out not to be fruitful as a
> >> >> >>> whole, I'd like for us to still have left a positive impact on =
the codebase.
> >> >> >>> ...
> >> >> >>> So what's next? Naturally, I'm looking forward to a spirited
> >> >> >>> discussion about this topic - I'd like to know which concerns
> >> >> >>> haven't been addressed and figure out whether we can find a way
> >> >> >>> around them, and generally build awareness of this effort with =
the
> >community.
> >> >> >>
> >> >> >> On of the gravest concerns is that the devil is in the details.
> >> >> >>
> >> >> >> For example, "die() is inconvenient to callers, let's propagate
> >> >> >> errors up the callchain" is an easy thing to say, but it would
> >> >> >> take much more than "let's propagate errors up" to libify
> >> >> >> something like
> >> >> >> check_connected() to do the same thing without spawning a
> >> >> >> separate process that is expected to exit with failure.
> >> >> >
> >> >> >
> >> >> > What does "propagate errors up the callchain" mean?  One
> >> >> > interpretation I can think of seems quite horrible, but another
> >> >> > seems quite doable and reasonable and likely not even very
> >> >> > invasive of the existing code:
> >> >> >
> >> >> > You can use setjmp/longjmp to implement a form of "try", so that
> >> >> > errors dont have to be *explicitly* returned *in* the call chain.
> >> >> > And you could probably do so without changing very much of the
> >> >> > existing code at all, and maintain a high level of conceptual
> >> >> > alignment with the current code strategy.
> >> >>
> >> >> Using setjmp/longjmp is an interesting suggestion, I think lua does
> >> >> something similar to what you describe for perl. However I think
> >> >> both of those use a allocator with garbage collection. I worry that
> >> >> using longjmp in git would be more invasive (or result in more
> >> >> memory leaks) as we'd need to to guard each allocation with some
> >> >> code to clean it up and then propagate the error. That means we're
> >> >> back to manually propagating errors up the call chain in many cases=
.
> >> >
> >> >We could just use talloc [1].
> >>
> >> talloc is not portable.
> >
> >What makes you say that?
>
> talloc is not part of a POSIX standard I could find.

It's a library, like: z, ssl, curl, pcre2-8, etc. Libraries can be
compiled on different platforms.

--=20
Felipe Contreras
