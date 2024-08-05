Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46329155351
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877954; cv=none; b=EPxjrxIba3zazmGmDqvgopqS5zcDqDjJSDlvGhz2Wxg0ZPbwWqr/128TshKwjWW+wylS2oiDve4Fc4qfDNxHGftAOS53qxar+3918JOwIQdFaHfILDafUbXoyFWDyuXIyM9jE56djvXqrmqddBRtSfPj3JK7+biNDJ64rABR4qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877954; c=relaxed/simple;
	bh=Vb7mlP5QixngKEngn2c9rkTveXIbPErqJMZmxICj89A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nagf9Jr5eQ17iAP1XEPho0iaSynQdXYEJGcgb/d3jyobaHCTgqNMNfgp8oRHZwWl2mTfscr53zNUn8bI0onPtR55e/yTHxGPQpj/NUpnp9DZW6RS92O20cgyW9qBp28lhlTzAl5bcTcSV57Tb6gx89FUHLhqFW74hfLWpEHgQDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M3uyMyMv; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M3uyMyMv"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5d829d41a89so446799eaf.3
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 10:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722877951; x=1723482751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3B4VmTJNsizadoXUs1QWG8nvCSfIMLiZuoakQmDDPI=;
        b=M3uyMyMvEBKj55rvJbIDTq6A+aio0VnLQ3YuAq14T7EglPcDazMt0/qvVTYFSj2d8a
         Y/odt7wD1lS1Zhln382r3DQNNtxaSHGD94AdOYIEjcIw0289dJuaSXO3Y0uyl6tMcyo+
         +cWTdL6I9seyuIEvdbx/Hd0hYESUk0fiJzbgNVZBPLUHHsYkh25EHd+Ak+wpITo/Cp4e
         FY6UexupqRqRYBlEaLGN5vwITJCpBPKZSRwnrguT9wRGxo5cmsIugewId22qX8f8pyD9
         ZWGm9EZHAHs7Tcv+rbyov3vMthC9s9pcS+rgF8kdXis7ya0dDwbqWFTEqjhWxtZu4VB/
         M0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722877951; x=1723482751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3B4VmTJNsizadoXUs1QWG8nvCSfIMLiZuoakQmDDPI=;
        b=dxhtyRfLaCbxrKpAstaEfEPo4I9maY/gA8j4ExmiZp6InWLBej3CJS85p3GY6g9JkP
         a07atwY0yjIY8OEXB1siKcYER/cUQipdCU4eWF3TmwTwFJbAyf3MhK6Gscw1+FbhIO3+
         ECDXMPFt3AgIuVk85rkS7f95UDGqqryusbHhxyFmaIyfs5SDED6rtnLwHQ9Ux0kSVKyu
         +dV5x1PxyJRkBTD/ECyvDUFEVNeibXpr0sh39aZ57x6OOM1ZcHMEIGOLkabDT1nr4wrp
         hS4NB7CpIueE+nBimNELA8DDFtinFvhQtcCscHVHzRK+LRAzITLTsp3KLcH9r3UBK+6p
         7y/g==
X-Forwarded-Encrypted: i=1; AJvYcCU6X2Uh5gD7j/snxkCvryoxF89lfLY+RNlJrzHP2rRkWo4ECsQ7lAZmAh+mUUXG8sa7uQP3XC2Eu+HKFxDPNQOdyWXR
X-Gm-Message-State: AOJu0YzGpt94pD4B6LGHqK3vaIL5wDaGwuuvmJ2FZLwIxraKNxsJ2mut
	pSoxRYu+scQa07imD87wdWzOHYxNGkeeGt7sjEk2SFuESjr1/TqWzttl+OCtnmtAiqThG7mEg6+
	Fp2IABJLoL3wwIQ6IRA/y1xU1URXo7GkUbmQ2
X-Google-Smtp-Source: AGHT+IGFL3mgE4IqGlQuqurFtGbyqoQ0BR9WULBI84Nqjky/ikQF89Oueur7UsCQ7/N1AwVDIO2lHftQ+MXCZdQONSc=
X-Received: by 2002:a05:6820:612:b0:5ce:f75b:1755 with SMTP id
 006d021491bc7-5d6636d2be4mr14728725eaf.4.1722877951157; Mon, 05 Aug 2024
 10:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
 <pull.1756.v2.git.git.1722632287.gitgitgadget@gmail.com> <0ed09e9abb85e73a80d044c1ddaed303517752ac.1722632287.git.gitgitgadget@gmail.com>
 <xmqqv80ia9wf.fsf@gitster.g> <CAO_smVjYYaE3UZd0M28j+=uYMLdDPRAN08X1Yb_=5+nU4GrkSA@mail.gmail.com>
In-Reply-To: <CAO_smVjYYaE3UZd0M28j+=uYMLdDPRAN08X1Yb_=5+nU4GrkSA@mail.gmail.com>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 5 Aug 2024 10:12:09 -0700
Message-ID: <CAO_smVhr0YVXCDiaUcdov+o40=znSVSHsZiJegLOZezFjzWGfA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] strbuf: set errno to 0 after strbuf_getcwd
To: Junio C Hamano <gitster@pobox.com>
Cc: Kyle Lippincott via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 4:51=E2=80=AFPM Kyle Lippincott <spectral@google.com=
> wrote:
>
> On Fri, Aug 2, 2024 at 2:32=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> >
> > "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > From: Kyle Lippincott <spectral@google.com>
> > >
> > > If the loop executes more than once due to cwd being longer than 128
> > > bytes, then `errno =3D ERANGE` might persist outside of this function=
.
> > > This technically shouldn't be a problem, as all locations where the
> > > value in `errno` is tested should either (a) call a function that's
> > > guaranteed to set `errno` to 0 on success, or (b) set `errno` to 0 pr=
ior
> > > to calling the function that only conditionally sets errno, such as t=
he
> > > `strtod` function. In the case of functions in category (b), it's eas=
y
> > > to forget to do that.
> > >
> > > Set `errno =3D 0;` prior to exiting from `strbuf_getcwd` successfully=
.
> > > This matches the behavior in functions like `run_transaction_hook`
> > > (refs.c:2176) and `read_ref_internal` (refs/files-backend.c:564).
> >
> > I am still uneasy to see this unconditional clearing, which looks
> > more like spreading the bad practice from two places you identified
> > than following good behaviour modelled after these two places.
> >
> > But I'll let it pass.
> >
> > As long as our programmers understand that across strbuf_getcwd(),
> > errno will *not* be preserved, even if the function returns success,
> > it would be OK.  As the usual convention around errno is that a
> > successful call would leave errno intact, not clear it to 0, it
> > would make it a bit harder to learn our API for newcomers, though.
>
> I'm sympathetic to that argument. If you'd prefer to not have this
> patch, I'm fine with it not landing, and instead at some future date I
> may try to work on those #leftoverbits from the previous patch (to
> make a safer wrapper around strtoX, and ban the use of the unwrapped
> versions), or someone else can if they beat me to it.
>
> Since this is wrapping a posix function, and posix has things to say
> about this (see below), I agree that it shouldn't set it to 0, and
> withdraw this patch.

Dropped this patch in the reroll that (I think) I just sent.

>
> I'm including my references below mostly because with the information
> I just acquired, I think that any attempt to _preserve_ errno is also
> folly. No function we write, unless we explicitly state that it _will_
> preserve errno, should feel obligated to do so. The number of cases
> where errno _could_ be modified according to the various
> specifications (C99 and posix) are just too numerous.
>
> ---
>
> Perhaps because I'm not all that experienced with C, but when I did C
> a couple decades ago, I operated in a mode where basically every
> function was actively hostile. If I wanted errno preserved across a
> function call, then it's up to me (the caller) to do so, regardless of
> what the current implementation of that function says will happen,
> because that can change at any point. Unless the function is
> documented as errno-preserving, I'm going to treat it as
> errno-hostile. In practice, this didn't really matter much, as I've
> never found `if (some_func()) { if (!some_other_func()) { /* use errno
> from `some_func` */ } }` logic to happen often, but maybe it does in
> "real" programs, I was just a hobbyist self-teaching at the time.
>
> The C standard has a very precise definition of how the library
> functions defined in the C specification will act. It guarantees:
> - the library functions defined in the specification will never set errno=
 to 0.
> - the library functions defined in the specification may set the value
> to non-zero whether an error occurs or not, "provided the use of errno
> is not documented in the description of the function in this
> International Standard". What this means is that (a) if the function
> as defined in the C standard mentions errno, it can only set the
> values as specified there, and (b) if the function as defined in the C
> standard does _not_ mention errno, such as `fopen` or `strstr`, it can
> do _whatever it wants_ to errno, even on success, _except_ set it to
> 0.
>
> POSIX has similar language
> (https://pubs.opengroup.org/onlinepubs/009695399/functions/errno.html),
> with some key differences:
> - The value of errno should only be examined when it is indicated to
> be valid by a function's return value.
> - The setting of errno after a successful call to a function is
> unspecified unless the description of that function specifies that
> errno shall not be modified.
>
> This means that unlike the C specification, which says that if a
> function doesn't describe its use of errno it can do anything it wants
> to errno [except set it to 0], in POSIX, a function can do anything it
> wants to errno [except set it to 0] at any time.
>
> What this means in practice is that errno should never be assumed to
> be preserved across calls to posix functions (like getcwd). Also,
> strbuf_getcwd calls free, malloc, and realloc, none of which mention
> errno in the C specification, so they can do whatever they want to it
> [except set it to 0]. That I was able to find one single function that
> was causing problems is luck, and not guaranteed by any specification.
>
> Kind of makes me want to try writing an actively hostile C99 and POSIX
> environment, and see how many things break with it. :) C99 spec
> doesn't say anything about malloc setting errno? Ok! malloc now sets
> errno to ENOENT on tuesdays [in GMT because I'm not a monster], but
> only on success. On any other day, it'll set it to ERANGE, regardless
> of success or failure.
>
> >
> > Thanks.
> >
> > > Signed-off-by: Kyle Lippincott <spectral@google.com>
> > > ---
> > >  strbuf.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/strbuf.c b/strbuf.c
> > > index 3d2189a7f64..b94ef040ab0 100644
> > > --- a/strbuf.c
> > > +++ b/strbuf.c
> > > @@ -601,6 +601,7 @@ int strbuf_getcwd(struct strbuf *sb)
> > >               strbuf_grow(sb, guessed_len);
> > >               if (getcwd(sb->buf, sb->alloc)) {
> > >                       strbuf_setlen(sb, strlen(sb->buf));
> > > +                     errno =3D 0;
> > >                       return 0;
> > >               }
