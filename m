Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F1DC7EE23
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 02:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjB1CfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 21:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjB1CfH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 21:35:07 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402AD11648
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 18:35:06 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id a4so5351529ljr.9
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 18:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoNVoY3iGKAZBVJri6StSSBbyK9zmzM59wsORDFCwVU=;
        b=e05TbEd2A+GhkPpGCBiPehh8rqoKS2FbE+u6t6u7rgZgt+PkCDqquYE50xuMSHxiSX
         wCfHLG/L/GtHajBi9VyzQo4qaqXVGNno4nvVx7usl5Sl837SN+Ej8FZT0PdX7zEEYi3e
         nG5DE7aDX6hEcahhwdoOd+1/5ZYe/z4sMpJNZ5hcKGTYIUDoYsMSQfJFg81M4xwdjzAf
         E54g0u3VkDzwNzePJARdLvcrFNg4VRzyJELHbm719GhsPVP3nsIleYBnpfre5VAVAZgS
         F45KCedlsHXk5ZohRhH/snKaag5743W9SCliGxrUE+B+oVK8jfPwX9bgj0qSRoDvKbPW
         zYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoNVoY3iGKAZBVJri6StSSBbyK9zmzM59wsORDFCwVU=;
        b=UI0awPzf/Jfv2dfzQJxALJVvpo+mPIAcCDEyve6NWbZ6bVhtkmzJWqF7w6gJop+xSM
         ukpGNR5UXC6gcNJucX4JbBHitVKx3YWTqDbeo9imJTo4Mdv+rkyPgGipjhPiUYUnEdZk
         8KO8Pn/fm4/klHoT5E6sVvj1n1GzT9qUQwfkJQwMmi3s4HEQ8vMkUfqRiutiZOuhg7o8
         vMwa7g/QNPlLd/eHtWe06LVuIKXTd47d7zj7t+cAYuqIZjAANHyvjuw9IduqMkVsRcvp
         79USmaoRjCD23kVYCy3vYB6mGUIfddafxqz/xuiRT7axK2CjNVJie44ApHwHWnoZVJQj
         wrkg==
X-Gm-Message-State: AO0yUKWQWB16lL5hudGY5t/Vu6CaALjlZj0PaX2Xao3PmB/rdYWhEb/m
        KqadwQUnYD5NAuneGbEJIkNwPNsW10Y5XrA8Lu8=
X-Google-Smtp-Source: AK7set8O6eXuo6WVcFrBUNt86ii9lTn0WexvYpx+vbgLArTp4Fvm6y0lmXLbejViue0RqbTUya0MUuQ34OS1o2y3NsY=
X-Received: by 2002:a2e:aa1c:0:b0:295:a9bd:1be0 with SMTP id
 bf28-20020a2eaa1c000000b00295a9bd1be0mr273067ljb.6.1677551704150; Mon, 27 Feb
 2023 18:35:04 -0800 (PST)
MIME-Version: 1.0
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
 <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
 <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
 <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
 <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com>
 <c3ef69e0-c37a-01fe-a40a-c2940e329793@dunelm.org.uk> <CAPMMpogi_QoGKD824JW+85v_Sgaf5d3TAd_P55YyT5NF6AUJ=w@mail.gmail.com>
 <87a615vkqk.fsf@osv.gnss.ru> <CABPp-BH2XPB4BN5Oo=VnLav_wvAGGUAyZC4HRHRRmES5k75P1Q@mail.gmail.com>
 <87bklilnvp.fsf@osv.gnss.ru> <CABPp-BHRbKG_cXdwaPT0-Rj6QTkkJRcT4N0f45==i7oAqiTC+w@mail.gmail.com>
 <87fsatixnn.fsf@osv.gnss.ru> <CABPp-BF3JUg4jThS8Y_3v-tOEey55V_9KpXRZ3HvfaC3S2m=GQ@mail.gmail.com>
 <87lekklqpi.fsf@osv.gnss.ru> <CABPp-BGJ+jdwizBNyYr-st58F6BPbyrJ+DwRX81_0NjgU6LhzA@mail.gmail.com>
 <87pm9v6n9a.fsf@osv.gnss.ru>
In-Reply-To: <87pm9v6n9a.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Feb 2023 18:35:00 -0800
Message-ID: <CABPp-BHVLx+wikxsJqDjFM416PoC6CY-5L7RQDqJAdU7kOeDyA@mail.gmail.com>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>, phillip.wood@dunelm.org.uk,
        Alex Henrie <alexhenrie24@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note: I'm not talking about rebasing merges anymore in this thread,
but I thought there was a useful how-we're-communicating subthread
that's worth addressing to see if we can make that part work better...

On Mon, Feb 27, 2023 at 9:17=E2=80=AFAM Sergey Organov <sorganov@gmail.com>=
 wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Sun, Feb 26, 2023 at 1:29=E2=80=AFAM Sergey Organov <sorganov@gmail.=
com> wrote:
> >>
> >> Elijah Newren <newren@gmail.com> writes:
> >>
> >> > On Sat, Feb 25, 2023 at 7:15 AM Sergey Organov <sorganov@gmail.com> =
wrote:
> >> >>
> >> >> Elijah Newren <newren@gmail.com> writes:
> >> >>
> >> >> > On Fri, Feb 24, 2023 at 2:06 PM Sergey Organov <sorganov@gmail.co=
m> wrote:
> >> >> >>
> >> >> >> Elijah Newren <newren@gmail.com> writes:
> >> >>
> >> >> [...]
> >> >>
> >> >> > Please, go read at least [1] to see Johannes comments about how t=
he
> >> >> > prior proposals don't work beyond simple cases.
[...]
> >> Except the method discussed does achieve exactly that according to the
> >> evidence gathered at the time of debates, and here is confirmation (fr=
om
> >> Johannes himself) from the reference you provided:
> >
> > I'm glad you read it.  :-)
>
> In fact I didn't read it, I rather re-read it ;-)
>
> (I'm in the CC list there, so it should not have been a surprise I did
> read it then.)

I knew you were on the CC, I just didn't believe at the time that you
could have read that email and still claimed that "As for Dscho
results specifically, I've got an impression that he never
needed rebasing of merges in the first place", so I assumed you had
skipped that email or only lightly skimmed it.

I'm still quite surprised, but clearly my assumption that you read the
email was wrong.  Sorry about that.

> >> Setting this back into perspective, in comparison to blind re-merge,
> >> that fails to keep user changes even when no conflicts at all exist, a=
nd
> >> even when it's applied at the same place in the history, the discussed
> >> method is a *huge* step forward, especially if re-merge is kept as a
> >> fallback strategy.
> >
> > The use of superlatives and asterisks doesn't change my opinion; I'm
> > still skeptical that the given strategy is overall a step forward, let
> > alone a large one.
>
> You just repeat saying the same thing, without any further arguments?
> OK, thank you for your opinion anyway.

That exactly mirrors how I've felt about your emails in this thread.
You are right that I'm not going into detail either...but why would I?

  * I'm not trying to convince you to implement these ideas or change
your own implementation, especially since:
  * You've previously said you aren't even planning on working on this[1].

Of course, you can easily ask why I would think you might provide
details when I was not providing any.  Well, from my viewpoint:

  * You did say you were hoping someone else would work on this
problem[1,2,& end of this email], and I've expressed interest in
working on the problem space.
  * If you want someone to work on your ideas, using your particular
favored approach, for free, then you need to convince them that your
approach is worth investing in
  * I have read the old proposals, in detail, and stated I don't
believe in them.
  * You didn't try to address my concerns beyond simply reasserting
that the ideas in the original proposals were good, and seemed to be
more interested in discrediting or minimizing my concerns (e.g. asking
why I "hated diffs from merge to either parent") than in learning
about or addressing them.

I think your intentions are good (you're trying to solve a big problem
in Git), I'm just a little worried about the execution (e.g. brushing
aside my concerns so folks won't pay attention to them while  actively
recruiting eager contributors, with the plan to send them down what I
believe is a dead-end path).  If it was just you going down this path,
I wouldn't be so concerned.  Personally, I pursue a *lot* of my own
bad ideas, and learn in the process that they were bad.  Also, if you
showed some willingness to entertain that I might be right that the
old proposals are bad, and could communicate that to new contributors
and let them decide, I would have dropped out of the thread sooner and
just let you do your thing.

The way you've responded in this thread doesn't seem unique to our
interactions; it reminds me of an interaction you had with Junio at
[3].  He suggested there were some code issues.  You could have asked
what they were and maybe learned how to improve things.  Or maybe you
could have learned that he just had a specific misunderstanding which
could have been corrected if you asked some questions to find out what
he was thinking.  Instead, you simply asserted that things were fine
and dismissed his concerns.  I think it was a lost opportunity.

Now, it's fully possible here that I've misunderstood your purpose; if
so, I apologize.  The above was the understanding I was working off
of; maybe knowing that will help you understand my responses.

[1] stated in final paragraph of
https://lore.kernel.org/git/87zgkh9buq.fsf@osv.gnss.ru/
[2] hinted at in final paragraph of
https://lore.kernel.org/git/87bklilnvp.fsf@osv.gnss.ru/
[3] https://lore.kernel.org/git/87wna3jwx8.fsf@osv.gnss.ru/

> > (I do agree we have a huge problem and thus that a huge step forward
> > theoretically could be taken, I just don't see this as it.)
>
> It works. Really.
>

> > But I've stated that more than enough, and no one is producing patches
> > on this topic right now, so I'll drop out of this thread.
>
> OK, I participate only in hope that there will be somebody who actually
> cares enough to implement it. Maybe it will be me, maybe not, and I
> already got it that neither you nor the original author of git-rebase
> are interested.

Correct, I'm not interested in implementing it that particular way,
though I will be implementing it in what I feel is the right way.

Anyway, I hope something I said above helps in some way.  Even if not,
I wish you the best of luck on your efforts.
