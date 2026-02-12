Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8AA1D130E
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 21:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770930820; cv=pass; b=cZI87EAN/YncuzuFQJ+515OCDFDnvGXDl9LPgavmj3xxKQRb5Jz8TRJi7tDNBOwlIDb96ZFrBmp1xgOer9AdPnwNOObIr6wVMPRam77idreibfCDso03nzJVfkurD1cuUIJW9QbNlxul9sv8983uBqgtRFDJ0T8qcVEBL/dY/yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770930820; c=relaxed/simple;
	bh=H5M/m2aJ0OA2GVDg4x6apXkRu4qFNa2iisIMPMphHW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2VKA+KgdgOV/3NA/kJ0dg5IqWXhR6cjAIV9Ch6fsuQEPoiZ/puYfF2z68xZOGaqfGJnsYm7ssyIwYmpTbipyyTU2r90rvbFSqsmkp+rzoEETaobsTsCHXPI89N11hUQWVTfjP7zVQe9YE+H2BxWJFkAEoSJLC9GAxgxJmguScw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AX/MvlCs; arc=pass smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AX/MvlCs"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56750cb34c8so202629e0c.0
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 13:13:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770930818; cv=none;
        d=google.com; s=arc-20240605;
        b=RPU8hxVcTFfLRhvbjLvgufNl+AgX5AZFSqCAjaETYacBdG1eDnpLwb8RUqfksB0eAD
         PqMR7h6axcgpbQOz1d5ruvvMqXCBpsdfGwFfgg2i8xu4Tcnry+AURveAmQhvRZQ5pomR
         BsNrWqB0J+EA6i++JvuEgqgYQGIWLQN0QqC6Z87iHB08ergAp50u7E/LQUrUrL/nCrlS
         W6Em+vOC4U7FGpiAG96JQwFf+6g7acqFjmeGCkZTelA2asp65eCyK48Bl4oFGBTTMRs1
         H4E5c4A7Xt41CbQKBOmSCBiBSJKpxqevOpAoc3MzuHqFT8tCpWaU2IF1X4Wk2WL+DQlA
         LH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8MXjFjiMaImrCBKs3UL5blf/M6Yu/sZVEFEyxRIXyQA=;
        fh=392ryK1TiLXjQymH8YuTlaSLgmX4+VbMxfQfkGuHyGc=;
        b=N+eikUNiDnYiqgxp38pjjEAYwIcPyd2cwGWBvflU4DKqaW9/OdBjTAFSdj/i85lGYH
         BrLygdVjAgkIeC0xV8tkOxZawnFUPj7LAgLe2/rv1azLXNsyvvzpI3DQvO2FNV+Yrwfw
         1TLFMDG0PDVIr5zmrcX31NfzNGFM2VbvLcCDqyXOdE48tmxNck12uwWmUNcE8+VsSYzq
         2dDfM2/N427DtiTuCZaCXvrGOARLrbB6xvElK1xvEwn1Cabw/JZMJX/hsiTJKf3jFqp3
         iX9o1gfPSfBVhzTxQHj+B0PL5V8zJkZG76df5hH1/aJrX3FO5jq9ITftfTuO55KbTrij
         wZBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770930818; x=1771535618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MXjFjiMaImrCBKs3UL5blf/M6Yu/sZVEFEyxRIXyQA=;
        b=AX/MvlCsU8MODQv6o5SRw9qEmi0s2rxnIsDOIdD+zWVtMWIWtlppe+3xMxEEXGtD4N
         F7sTa/MzUvaWGGPl9yGxserCECCUH6dBTcP5xS/dq+b84SOcMMfKZ0KNdQJjUSw26vGD
         gWkAtdd1290B+7ABwnvziFwdwJFXR1oaLuscRs5jBM0ATPA/4Ox3qqY74vQ3Xz4k4TGW
         56NcdAkDtGt67MLgj04kfnWrxJqyL/2xPerg3WISz9LRSshXkjyaH9KGyLJtRKBW3ASY
         B1OchvlNEaELUaj8DFmrUkyxhamfuMAzEvpeIVVumlTCxU3UF9j17HIkg4KfEWkF3seR
         iivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770930818; x=1771535618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8MXjFjiMaImrCBKs3UL5blf/M6Yu/sZVEFEyxRIXyQA=;
        b=PB5fqUy3vvDTx2fr1v0Fk5P0B7pM7WDiYG+Dow9J5ads57pMJwS2MByBYyrnu8ON98
         m9V3Za7Fa8kOylCcjTdOXpBqoi+jNndNnVB1McA7JVlOf2EUcODD9Y69HC9c3rA6CgcH
         Juioc5f68GPzulkG6fvbiXg0Mfp7HbV8nv0/M8EaHvxO/SpuEZ8XDC7zcbggjccwVVwR
         tXzB2JneHe1wo493N9XqzEt9pj88aV8sQ06RpVU9Q9OHwjFIFtbD7o7Z13xhmnWVMGGN
         kZG6jLlPIbpeOCBeUUh84mwRjstdwu42wq9fWaGqCA45hA060WgwYSWOC0/Axg7n9SEO
         ngyw==
X-Gm-Message-State: AOJu0Yye1r8bklR8iUiwzAg/NFEOHAfBylBPGQdl7Sd2ZTFH2CUvjRV4
	W5KPxc6Obpeg1i9aBjMYN86B7WFGSsg/IR3AwhOYmOSodyEb2l3A3apf1WmfnCr38P+90A/Nb8A
	VNg7zhSUYd2g1I7wDpWjlGRghIjMyJNhBe9v72Nd9iA==
X-Gm-Gg: AZuq6aJzXLUk6RPUV4Us3FMZAz2Ke1+K645smV8lPM/x1PiLjVjmsWj7M5kJowlcR/I
	tI+3IQwFdpn7jq8jQI9r7dCusU7kSPQMOMpN2QkFBKebeFPYdqr9DGRXUw6xoFlX4fnL8fcY2L9
	n7njMuarLIkG2kwTCDv+GVjY/qmCtT8BFIFINz2U4Yc2LL+K0VxHVSya7idNBZjkVu8hI5YdSMO
	IiJasTpSSrp/LZ7Zh85PnpmT2KsroU9JAkRGGv0WGfaUwviDipsdgofO9Uh9ktcO7mvIoP8UbY6
	lkiovqHXKeTT
X-Received: by 2002:a05:6122:1b03:b0:567:4260:5244 with SMTP id
 71dfb90a1353d-567682c7108mr115526e0c.21.1770930817649; Thu, 12 Feb 2026
 13:13:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770390576.git.abrahamadekunle50@gmail.com>
 <24692afa3f0a67d3f3eba776cc745287c5d71e94.1770390576.git.abrahamadekunle50@gmail.com>
 <xmqqikc9ekzz.fsf@gitster.g> <CADYq+fa81Uki0ZVta80VO=-UG-f+Z8GAyzom-FLNXULartwwXA@mail.gmail.com>
 <xmqqtsvlq3gr.fsf@gitster.g>
In-Reply-To: <xmqqtsvlq3gr.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Thu, 12 Feb 2026 22:13:38 +0100
X-Gm-Features: AZwV_QhfyjK8QW-DrikMYWElZAymp7yOCcasM4uXlE85YZSVwoDfwk1XhJBu9_8
Message-ID: <CADYq+fab0FKncE8VFJcaHA5VmrTJbrSo79jxA6x+Y5dkZP+2RQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] add-patch: Allow interfile navigation when
 selecting hunks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 6:25=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Samuel Abraham <abrahamadekunle50@gmail.com> writes:
>
> > On Fri, Feb 6, 2026 at 8:21=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
> >>
> >> Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:
> >>
> >> > @@ -1566,11 +1589,14 @@ static int patch_update_file(struct add_p_st=
ate *s,
> >> >                                               : 1));
> >> >               printf(_(s->mode->prompt_mode[prompt_mode_type]),
> >> >                      s->buf.buf);
> >> > +             if (s->s.no_auto_advance && all_decided)
> >> > +                     printf(_("\n%s All hunks decided. What now? ")=
,
> >> > +                             s->s.prompt_color);
> >>
> >> This gives an ordinary prompt for the hunk and then another one
> >> after it if we notice everything has been decided.  I am wondering
> >> if it wants to be more like
> >>
> >>         if (!s->auto_advance && all_decided)
> >>                 say What now?
> >>         else
> >>                 ask the usual
> >>
> >> ?
> >
> > Hello Junio
> > Please just a small curiosity.
> >
> > If I do it this way, the user will not be able to see the options avail=
able
> > once they have decided on all hunks and want to rework the file.
> > The options for a hunk will not be visible if they navigate with say K =
or J
> > and want to change decisions on a hunk.
> > They will always be greeted with What now? without the available option=
s.
>
> Ah, OK.
>
> But then after deciding on all hunks and not telling the prompt to
> move to another file, the user will keep seeing this extra line of
> prompt?
>
> It somehow smells like a waste of a whole line just to remind the
> user that all hunks in the file have now been decided.
>
> There was a separate topic that added "(was: [yn])" to the prompt
> when the prompt asks about a hunk that already has been decided on.
> As we only need a single bit "all hunks decided", can we do
> something similar, I wonder?  At the beginning of the main prompt,
> we show which of the N available hunks we are currently at, e.g.,
>
>  (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?
>
> Perhaps we can add a third number to indicate how many of the
> available hunks the user has already decided, or something, that can
> be used to avoid this wasted line?  Or is it a good thing that we
> are loud in this case using a whole line to remind the user that it
> may be time to move on?  I dunno.

I thought of a suggestion where after deciding on all hunks in the
file, the user
will be able to see the "what now prompt", the options for the current hunk=
 and
also the previous decision on the hunk since at this point, all the
hunks would have been decided on.

I tried something like

What now? (was: n) [y,n,q,a,d,s,e,>,<,p,P,?]?

This does not show the number of the hunk we are currently at and the
"Stage this hunk" since the decision had been made initially but the "whatn=
ow"
prompt still provides a chance to change the decision, while showing
the previous
decision on the hunk by asking "What now?" instead.
The options have the default [y,n,q,a,d] and the remaining options are popu=
lated
from the permit set for the hunk. SO the user can still carry out the
normal actions on
the hunk.

In response to your earlier question, if the user decides on all hunks in a
file and does not go to the next file, he'll see the prompt above and
that is what will keep
showing if he remains in the file, no extra line.
If he navigates away, the hunk re-renders with the "what now" prompt
when he comes
back.
If he had made all decisions in a file and decides to split a
splittable hunk, then the normal
prompt shows for those hunks since they are now undecided.

What do you think about this?
Thanks

Abraham
