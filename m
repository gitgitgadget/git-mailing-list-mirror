Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C45C77B73
	for <git@archiver.kernel.org>; Sun, 21 May 2023 13:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjEUNgS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 May 2023 09:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjEUNbP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2023 09:31:15 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C32818D
        for <git@vger.kernel.org>; Sun, 21 May 2023 06:29:01 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f3a166f8e9so3206916e87.0
        for <git@vger.kernel.org>; Sun, 21 May 2023 06:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684675740; x=1687267740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzSe/o5mZTXOLsDhBtnywboNv4l/Eb/JDdeNh3OWCIA=;
        b=WOlGmlzolqScMrEyI5G8m19/HKsb7swd57yaHCnT5FFqpsFi61rZ3xRQsO9qZJ2IBG
         YX0f5deT0EeXsGwWKvPlKwigD8hzwu3KJDuo2ZOqHDPh3pYZF+Vr1TUPVleAMKN3fIeX
         8Z2K1jSFXPPxIW+WzNocV9hehpPkzQFAzELUFNJyJrusk50COAYzeWwtGi3Bas1895Hd
         l8tKp44Clm/0ddOSWKOIej61cse3QahnPEyhilSyljX0L0kpw7f3FuH9HsDiVPrHGLGf
         2Fv96KIY0uPMMZF1zOwnrWAEy1Lnei8Npx5twPsj/LV11bg8Wrc0AnFkEOI5Fq2raqG2
         HjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684675740; x=1687267740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzSe/o5mZTXOLsDhBtnywboNv4l/Eb/JDdeNh3OWCIA=;
        b=jRhMasWcqcqeuaszzXRuy9rsUXkAHUc/SgDI5RJzTfePIG9+bhxr8WiZi91NRIrO28
         FlKC8PiSdfMIf7wF6hO9gJuSb6FCY1GS4vDTCBT8i9Sa+GFSE5ufyFE9XTjuvaP3l530
         4pJB6cieC235N6opcJ7dVR2mc6DLcy/k9LGIzbckzwu50/5qWMY3qiNKgBtqCZRJx+C5
         P/PuiCpjceWgCqY1yb3YQrRSaVy+xEIFpXp6FTebg7OyNODwBU5AwP0hfsnak7L0AYkV
         JwvN9U1Dw9HIZmyhM5LQg2YDQqTo5pSLbLNZFFBp685v10atpdzLb3LkzmIzi4BsT27+
         qDZA==
X-Gm-Message-State: AC+VfDw1B1kH5Y2IkzzFUTIqmhJ/Xr5EIz2gm18dju6aTydvuceCuxwT
        GQH+qcru9qJ8NYDmKwGX+rDmAQuaQpIXvOUY7vSa/5cyaAA=
X-Google-Smtp-Source: ACHHUZ7Z3A0ASoQ+4hlGG5tKdI+kEWHEJIOC9CVtEXA5G25GG9sHrok9q8Wvo7wXV3mw8h4GLtzEXMCEht2g3WCbZFI=
X-Received: by 2002:a19:f816:0:b0:4f1:4074:b4fd with SMTP id
 a22-20020a19f816000000b004f14074b4fdmr3165526lff.29.1684675739457; Sun, 21
 May 2023 06:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQx3AYx+sSD4REfTdQ0muY2zRgzE2nR7RgG7cxNgXvwzYzixg@mail.gmail.com>
 <xmqq353qk59y.fsf@gitster.g> <87zg5xq3es.fsf@osv.gnss.ru>
In-Reply-To: <87zg5xq3es.fsf@osv.gnss.ru>
From:   Minnie Shi <minnie.shi@gmail.com>
Date:   Sun, 21 May 2023 15:28:33 +0200
Message-ID: <CAOQx3Ab80NMGiMnX+XciYHfXkQG1-PEeuhYO6npP-koCQqsHww@mail.gmail.com>
Subject: Re: I think there is error in merge documents - current branch
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

What is the procedure to update the document to correct the error? As
I responded yesterday, see below. we need to change the error.

From: Minnie Shi <minnie.shi@gmail.com>
Date: Sat, May 20, 2023 at 11:41=E2=80=AFAM
Subject: Re: [PATCH] doc: merge: fix mention of `ORIG_HEAD`
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: <git@vger.kernel.org>, Kristoffer Haugsbakk <code@khaugsbakk.name>


Okay, i read one more time, i think it should be read as

Before the operation,
-`ORIG_HEAD` is set to the tip of the "current" branch (`G`)

instead of
Before the operation,
-`ORIG_HEAD` is set to the tip of the "current" branch (`C`)

Kind regards,
Mi

On Sun, May 21, 2023 at 2:23=E2=80=AFPM Sergey Organov <sorganov@gmail.com>=
 wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Minnie Shi <minnie.shi@gmail.com> writes:
> >
> >> in summary the sentence should be read as
> >>
> >> Before the operation, ORIG_HEAD is set to the tip of the current branc=
h (H).
> >> instead of
> >> Before the operation, ORIG_HEAD is set to the tip of the current branc=
h (C).
> >
> > Not C but G (i.e. the tip _before_ the history is updated).
> >
> > I notice that we overuse "current" there.  One is to refer to the
> > most recent commit on a branch, the other is to refer to the branch
> > that is checked out.  For the former, we say "the tip" in the other
> > sentence, and it probably will make it less ambiguous if used that
> > phrase.
> >
> >     Then "`git merge topic`" will replay the changes made on the
> >     `topic` branch since it diverged from `master` (i.e., `E`) until
> >     the commit at the tip of the `topic` (`C`) on top of `master`,
> >     and record the result
> >     in a new commit along with the names of the two parent commits and
> >     a log message from the user describing the changes. Before the oper=
ation,
> >     `ORIG_HEAD` is set to the tip of the current branch (`G`).
> >
> > My reading also hiccupped with "replay"; the first sentence to
> > explain the command says "incorporate the changes", and that may be
> > a less confusing expression; "replay" somehow makes me imagine that
> > the changes are cherry-picked one by one---it may be only me, so I
> > left it as-is in the suggestion above.
>
> For me "apply changes" or even "apply cumulative changes" works much
> better than "replay changes" in this context, especially provided we
> will apparently have "git replay" soon.
>
> Thanks,
> -- Sergey Organov



--=20
Kind regards
Min
