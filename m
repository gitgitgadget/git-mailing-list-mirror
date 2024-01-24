Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870F02919
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 04:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706069754; cv=none; b=R7yuRdGJuNat1++8Ya59qrVQbDMxH+xusKHML50qRn54lU7og1IyX2bIb5D2L14g4eEfzE/nQ4GK74aLPS20FatDXu1p0rX6w0pJT8L3WsbpKQrtFmSwKHc6kq8XXqScJI/kcF25Ctb+KrpfOExCq2pEkCracGRVAHz9wjd8Sgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706069754; c=relaxed/simple;
	bh=NGR0ZlcASu7arCthntmsvj0qQrdLfDL0bh0CvdeGjgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzMAAwl8HBQS7WTiTMMhqoGb0bij60YRdSC5KtLLor+mS3l/JNuMLFb/aXjmW3XN43NTHit3+Gc9fwo+k2QnCgn+3kp+jnEhRmutsk65vXGVcVI1/shVRBqfG7gXMrUV+5emb9as6pkkOkRREqod7PXU3JRBavrhfprpX/GMxtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrymU9Co; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrymU9Co"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50eabfac2b7so6421793e87.0
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 20:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706069750; x=1706674550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjp0wlcmq9x1Rw6vO+h/o+YMhQ/eFmdGgeCfrDHixMI=;
        b=BrymU9CoMeSWeqaPO+ona1fcsKvhCuP8WSjL0XmoUAQqxdP2ksQBPMfUcCum/JMvLQ
         KuCe9JgAOAGVVHIp8KjoSwgGIP5FZKdUkAkCpr6YSbdKpcr+FSeipaWUQYkyqDRMSysA
         8y9LRhxSdx6jqe5i16rLuZ7UWOyfqL+Rf8RPdxYpot5RtAHpC3TbWw0IrL0ELgO36eq1
         MvfJRlU3ECg4ERiUidPeg9XPf59ffDKO2xYEPX/QtVT4dkKz/ouM6KsR/gWHmjeWYGtC
         Q1ABwu5n3OlaXHbe0UEgWwqeseAuWYk3Gs9mMoUJqNEiXRX9Jvt8D6WeeGJ7ZFRThEfy
         Mhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706069750; x=1706674550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjp0wlcmq9x1Rw6vO+h/o+YMhQ/eFmdGgeCfrDHixMI=;
        b=WgUnUf3OG0Dn6EOg2VYiS9NeyV91Qqw4II5NHP7m+i4QSAb+VSuE1zwIyxbbP/8HVM
         CkN+Nf47Phe/fRRbcmCmSHZPo8BshpiBSW+7BZ8Kt7Em1WghdHLUjnQ5CG371ljgDNYj
         bqn3Y6RxOKQyWIE7RRk/9ztlJ7GIdGQUiVBHsLLIyKeZ6tRB5+1xjSVNPsDsTKKIpzng
         beofkJQP36VKyntmQyqEiIQs+Htsr7ylY5Gb7iF2vpNcMfDDdoHO10GUFfZxfJ0zuVkV
         YDBwwlpcManIlWyyaWS8rdRQvJEcAq0woQSgDWdMaEA6npY073RLaq6YBSOcX2yaM7zz
         NoCg==
X-Gm-Message-State: AOJu0Yx4JKHG9SPhR9WVgBl8d/s8xxF/ChaETmpZb1fC1nEo1AhfgNVP
	IX/4xz4IR0U932SRg3XmzZ6W71s5oCkGz0L64sWwEMuGjoi775QoQ6Nn0CcVCSbtVSwN4SDNpyg
	89VcAZ/OErsJfgclcGzF+MpHD850=
X-Google-Smtp-Source: AGHT+IG0XRv5IWhOYsCO7bp0VVa20VBaWHm4zCk6r4WfMsLuYeOk7gVsMSw2gIlA3e+J4DyRpRNdxpaPH9OrLG1Nzc4=
X-Received: by 2002:a05:6512:2387:b0:510:1195:e68e with SMTP id
 c7-20020a056512238700b005101195e68emr98764lfv.135.1706069750244; Tue, 23 Jan
 2024 20:15:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZ77NQkSuiRxRDwt@nand.local> <b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org>
 <CABPp-BH3sva=CNtx8YFGP4Egyau-hR+7njZPFEd-DRTw91BK2w@mail.gmail.com>
 <f5b9a57b6e2b513f1d79a93c6f0ccf45@manjaro.org> <CABPp-BFWsWCGogqQ=haMsS4OhOdSwc3frcAxa6soQR5ORTceOA@mail.gmail.com>
 <45bfda3a350b4040a28a25993a2b22e0@manjaro.org>
In-Reply-To: <45bfda3a350b4040a28a25993a2b22e0@manjaro.org>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 23 Jan 2024 20:15:37 -0800
Message-ID: <CABPp-BGfPXKtdHaz0u5273AwUfBnYRKfMa2VHPFohv5fOtwJtg@mail.gmail.com>
Subject: Re: [DISCUSS] Introducing Rust into the Git project
To: Dragan Simic <dsimic@manjaro.org>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dragan,

On Wed, Jan 17, 2024 at 1:30=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> On 2024-01-11 17:57, Elijah Newren wrote:
> > Hi Dragan,
>
> I apologize for my delayed response.

No worries; I'm often hit or miss on my responses these days as well.

> > On Wed, Jan 10, 2024 at 9:39=E2=80=AFPM Dragan Simic <dsimic@manjaro.or=
g>
> > wrote:
> >>
> >> On 2024-01-11 01:33, Elijah Newren wrote:
> >> > On Wed, Jan 10, 2024 at 1:57=E2=80=AFPM Dragan Simic <dsimic@manjaro=
.org>
> >> > wrote:
> >> >>
> >> >> Thus, Git should probably follow the same approach of not convertin=
g
> >> >> the
> >> >> already existing code
> >> >
> >> > I disagree with this.  I saw significant performance improvements
> >> > through converting some existing Git code to Rust.  Granted, it was
> >> > only a small amount of code, but the performance benefits I saw
> >> > suggested we'd see more by also doing similar conversions elsewhere.
> >> > (Note that I kept the old C code and then conditionally compiled
> >> > either Rust or C versions of what I was converting.)
> >>
> >> Well, it's also possible that improving the old C code could also
> >> result
> >> in some performance improvements.  Thus, quite frankly, I don't see
> >> that
> >> as a valid argument to rewrite some existing C code in Rust.
> >
> > Yes, and I've made many performance improvements in the C code in git.
> > Sometimes I make some of the code 5% or 20% faster.  Sometimes 1-3
> > orders of magnitude faster.  Once over 60 orders of magnitude
> > faster.[1]  Look around in git's history; I've done a fair amount of
> > performance stuff.
>
> Thank you very much for your work!
>
> > And I'm specifically arguing that I feel limited in some of the
> > performance work that can be done by remaining in C.  Part of my
> > reason for interest in Rust is exactly because I think it can help us
> > improve performance in ways that are far more difficult to achieve in
> > C.  And this isn't just guesswork, I've done some trials with it.
> > Further, I even took the time to document some of these reasons
> > elsewhere in this thread[2].  Arguing that some performance
> > improvements can be done in C is thus entirely missing the point.
> >
> > If you want to dismiss the performance angle of argument for Rust, you
> > should take the time to address the actual reasons raised for why it
> > could make it easier to improve performance relative to continuing in
> > C.
> >
> > Also, as a heads up since you seem to be relatively new to the list:
> > your position will probably carry more weight with others if you take
> > the time to understand, acknowledge, and/or address counterpoints of
> > the other party.  It is certainly fine to simply express some concerns
> > without doing so (Randall and Patrick did a good job of this in this
> > thread), but when you simply assert that the benefits others point out
> > simply don't exist (e.g. your "Quite frankly, that would _only_
> > complicate things and cause fragmentation." (emphasis added) from your
> > first email in this thread[3], and which this latest email of yours
> > somewhat looks like as well), others may well start applying a
> > discount to any positions you state.  Granted, it's totally up to you,
> > but I'm just giving a hint about how I think you might be able to be
> > more persuasive.
>
> I totally agree with your suggestions, and I'm thankful for the time it
> took you to write it all down.  I'll take your advice

Great!

> and refrain myself
> from expressing my opinions in this thread.

...but that's not what my advice was.  My advice was that you'd be
more persuasive if you expressed your opinions differently.  Some
possible examples:

  * Stating that you are worried about the codebase becoming more
complicated or more fragmented (without dismissing the points Taylor
raised)
  * Arguing that you believe various points others raised aren't as
much of an advantage as they perceive, or even potentially aren't even
an advantage at all, not by mere assertion but by providing additional
details on the topic (statistics, anecdotes, war stories,
counter-examples, old commit messages, etc.) that back up your point
  * Stating that you don't understand why others think that advantages
they state are as significant as they pose and ask for clarification.

I think there's potentially some good points behind your positions,
and I don't want to discourage them.  I want to encourage lively,
friendly debate so that we can have the best information possible when
decisions are made.
