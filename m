Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A9815E86
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446440; cv=none; b=t6gxnesIOrnOjGFP4omo8/x0S2z5ZpIhYu/Rmwb79bFuZdyS1Hdqwu2tDD2T5/Y2fedblo8WLR2Dnw+nuqogYiWMhsaObpnCERkYkonIfRQxZQtp+XK941Uhm3W/7+KRFNYO/9e7QuKmkpZXLYX5upvjfdBawKV5T4tvjddt4no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446440; c=relaxed/simple;
	bh=l/4LjHJW5fd91zGfGIozhGS61XrF1A5EUhw3enV5Tlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkNa0qtWrSDjj1oootQDRH5I3UG7RvI6ybwOfygv+ealU9rO6kuxJBhCb6Il0vfezwP7mCn2btjo2ttE//VlJ2mDCRlt2hdPXGrr1o5LuzI//LySGu83fTWIvofPn99OLt/iZ3eYqguzMO+l44inrIaKjI5M45fM5dL3Xuo6j1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4RKTweGa; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4RKTweGa"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44fdc70e695so515831cf.0
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 10:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722446437; x=1723051237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzpYaTUR7eyrIbHP+83mTzPXFDK0ApdzHr831xJn6Pw=;
        b=4RKTweGaHHkQggkXo6BSybojb+O679E3o7o1ISLFHs/US+WTAYa6s8P88nuO3VAm0V
         eSr9E7JYZ2AZqpeq2ECBixMEpBJ64s1Z6eb41CAfKQEC3VK4e+EGitLzrv/G66vRz9t6
         /u3Pp65YIzHyXchQHCXFXNqyrMKyDvIspKuv4Fcmk28NQn0FTdAoTJpGOxLq7aZnOvSj
         aAZW3QVTDIgHwnwkCE4ZTpo/uxC4fu1jx0yUQ6XYq8fYLoxgKs5LEOR/UF8Lotvh2Fdh
         qNwCjHe7pPeC40Dc0II/z5Rvf+zk5ABvXj4aLfkJMyw0ES+S1tV5r5xxFN/BYhYsVL73
         dMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722446437; x=1723051237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzpYaTUR7eyrIbHP+83mTzPXFDK0ApdzHr831xJn6Pw=;
        b=JmoNDpHb2Bj/7hJo4Vay2Sq8fGg4MzGyjZEvMGxJFu8HjpeagX73tK09KHC72g7xds
         mkJT72ZilIpzuj9Bqm3ksiWhNZE3lk2QsU0rb1VXRQEWlCC5vUTkaoeGKhRwEaBdQE7W
         NJ8vQUHi2AdmIhHKuTdfBxZhhxICR4EQGhSlHIosYzt2XnhckKGOLRxA0USXHLdcNigR
         ZSVqnMtZS8+DNgQgAMtOAqIXtdTF5vZxxfwWiSIdPSDt49bEFlZ9gdUQy7dFfo4x88XD
         YGsIChCF8zz0iG17gvOulIp+tkIHHrnSmQGrlK21x7/grcLGMrn9B2evd/aLs+H1Oo23
         auFw==
X-Forwarded-Encrypted: i=1; AJvYcCXCPoUDy2x7E/ATNXq5Lv79JoD6+cBSC7sk0SnzghbDy/lbdCubkW809zgpg361C+Gt5EPumecf0J5URpcS7ot8hjzr
X-Gm-Message-State: AOJu0YyPxtncuyKquOjQJ3C7HinN4k9CVTEBbZ/BYYeHpPJ9bYyQrJNX
	U7b4phEwwoaLMuZVGfwEzorQpZ/FVRsRTiVU0N/qJt3Ii4lWOJZVoty6eTExRwk2R0641qlVct7
	eg5v47VqO7mSBsWO22jryrAUAHvtoicqqmrIn
X-Google-Smtp-Source: AGHT+IHSM+IlGIXlBwNMaWlVDYGrLI9cNJmvQ5cI0aqbTeuuVdnhk4x5mUxuSCGkm/jhEanyPkDmfTaTMSRB0zrgtTw=
X-Received: by 2002:a05:622a:1902:b0:44f:9db1:7fca with SMTP id
 d75a77b69052e-45041a485e1mr4743791cf.28.1722446437080; Wed, 31 Jul 2024
 10:20:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730175448.1727373-1-emilyshaffer@google.com>
 <xmqq7cd2bs0q.fsf@gitster.g> <CAJoAoZn57LMCz9dmU3u+2HS1urOcoY1HQA6axh0cWoGchS_KFA@mail.gmail.com>
 <xmqqttg6a7zj.fsf@gitster.g> <000001dae2d1$85ce8f40$916badc0$@nexbridge.com>
In-Reply-To: <000001dae2d1$85ce8f40$916badc0$@nexbridge.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Wed, 31 Jul 2024 10:20:23 -0700
Message-ID: <CAJoAoZnw_vmGpShXc-tcC03JSsxwy+S1cD-p+Ja2J09trkR4Kw@mail.gmail.com>
Subject: Re: [PATCH v4] Documentation: add platform support policy
To: rsbecker@nexbridge.com
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 3:40=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>
> On Tuesday, July 30, 2024 5:25 PM, Junio C Hamano wrote:
> >Emily Shaffer <nasamuffin@google.com> writes:
> >
> >>> > +Note that this document is about maintaining existing support for
> >>> > +a platform that has generally worked in the past; for adding
> >>> > +support to a platform which doesn't generally work with Git, the
> >>> > +stakeholders for that platform are expected to do the bulk of that
> >>> > +work themselves. We will consider such patches if they don't make
> >>> > +life harder for other supported platforms, and you may well find a
> >>> > +contributor interested in working on that support, but the Git com=
munity as a
> >whole doesn't feel an obligation to perform such work.
> >>>
> >>> The part after "... and you may well find" reads a bit muddy.  I
> >>> couldn't tell if it is talking about the initial port, or continued
> >>> support, or both.
> >>> ...
> >> I like that message, but what I was trying to say with that sentence
> >> was "if you get lucky, some volunteer might want to help you with the
> >> initial port".
> >
> >FWIW, I do not quite like that message; I agree that it would be good to=
 tell them
> >that they may not entirely be on their own, if they ask nicely, but no p=
romises ;-).
> >
> >> It seems worth at least pointing out that that would be the exception,
> >> not the rule, but I probably already do that well enough with the
> >> previous sentence ("the platform stakeholders are expected to do the
> >> bulk of the work"). Let me reword the last sentence, then:
> >>
> >> "We will consider patches that port a new platform if they don't make
> >> life harder for other support platforms or for Git contributors. Some
> >> Git contributors may volunteer to help with the initial or continued
> >> support, but that is not a given. Support work which is too intrusive
> >> or difficult for the project to maintain may still not be accepted."
> >
> >OK, at least that clarifies the point I was puzzled about.
>
> Pulling in a paragraph from earlier on:
>
> > >This is hard to understand and I wonder if we can clarify.  I get what=
 you want to
> > >say: suppose we rely on library X that is getting regular feature and =
security updates
> > >in reasonable cadence, say every 6 months there is an upstream release=
 of library X,
> > >but a niche platform has ported the library only once long time ago, a=
nd hasn't
> > >updated it ever since.  Now the Git project may consider helping a por=
t to such a
> > >platform if the initial port of library X was 8 years ago, but will no=
t if it was 12 years
> > >ago.
>
> This is a tough one. If a library is actively maintained and subject to s=
ecurity fixes, OS providers
> like the NonStop team will, as a general practice, provide security fixes=
. It might not be as frequent
> as I would personally like, but a 12 year old library with security holes=
 would not really survive
> to be a problem. Others, where stability is well established, let's say i=
conv (a bad example, I
> know), will not get the attention to have it fixed until there is a custo=
mer reported issue (or
> me stomping up and down a lot). I think that the 8 vs. 12 year difference=
 is fairly arbitrary
> and might not be appropriate.
>
> In some situations, if functionality is provided by an existing library, =
and is augmented, the
> platform maintainer could provide another compatibility component to supp=
ly the capabilities.
> It would be a strain, and in some cases impractical, but might be possibl=
e.
>
> I think a bigger issue is where there are dependencies introduced that ar=
e either not
> generally portable or depend on infrastructure that is also not portable.=
 There is a long list
> of projects that are all interrelated and specific to the Linux space - a=
ll of which scare me
> as adding any of those would exclude git from platforms where those are n=
ot possible to
> port. Rust and GO, which have difficult-to-port code generators are two (=
Rust itself is
> problematic as one needs consent from the Rust maintainers to even add a =
platform, if you
> read deeply enough into the "porting" documentation). Products that must =
use gcc or
> clang with unavoidable syntax features that are not supported by ANSI C c=
ompilers and
> libraries are also things that keep me up at night because there really i=
s no way to work
> around those. In some cases, some JSON and YAML libraries ended up having=
 to be forked
> and are now (not happily but) maintained by my team - not a git issue.
>
> Ultimately, my goal as a platform maintainer is to be able to sleep at ni=
ght without
> worrying that git support will be completely turned off by a feature that=
 uses some
> incompatible library as part of the git core. Git LFS has had to be put a=
side because of
> the GO dependency, but because LFS is not core git, it is survivable. I t=
hink that if such
> incompatibilities are introduced, there should be a mechanism to isolate =
them, and
> exclude them from the git core.
>
> Please remember that git is now a central component to a vast number of o=
rganizations
> that depend on it for serving features to customers. To be blunt, it is n=
ot 2007 anymore,
> and git exists almost everywhere of significance. That point needs to be =
stressed. The
> pervasiveness of git has dramatically increased over the past 5 years, mo=
re than I think
> most people realized. On NonStop, 5 years ago, there was perhaps <10% par=
ticipation.
> If you look now, the number has gone up, probably to somewhere around 60-=
70%. We
> cannot ignore that - I sincerely hope not anyway. There are even companie=
s that will
> look at your GitHub footprint exclusively as your definitive resume for h=
iring purposes - I
> actually think that is really interesting and do not want to put that at =
risk either (although
> admittedly entirely beside the point of this thread).

I can understand the need for something that speaks the Git protocol
and enables developers to develop. However, I guess I don't understand
the need for that to be the latest version of Git, or even the C Git
client to begin with. The protocol changes from time to time, but
we're very careful - even compared to how careful we are about
scripting compatibility on the C Git CLI - to provide backwards
support for clients speaking older Git protocol. Why does it matter to
NonStop, then, which client is being used or if it's sparkling brand
new?

Git is a central component to lots of things, you're right - at Google
it's incredibly important, and our serving infrastructure is based
around JGit, not C Git. It's integrated into lots of development tools
like IDEs and notebooks and design software, and most of those use
JGit or EGit or libgit2 or something.

My point isn't "just fork Git" or "just use a different library", my
point is "are you sure it's correct to worry about the Git client more
than you worry about the Git protocol?"

Anyway, I think we've gone pretty far afield. Let me resummarize my
understanding of your thoughts on this patch so far:

* Given the constraints that currently apply to NonStop, based on this
doc, you are planning to run daily (or at least more frequent than
weekly) tests against `next`, write detailed reports to the list as
soon as you discover a problem (that is, before the problem series
hits `master`, in most cases), and provide fixes yourself or work
closely to test fixes others write in response to those reports.
* Also given the constraints that currently apply to NonStop, a hard
age limit on library dependencies would disqualify NonStop from
explicit support assistance.

v4 of this series drops the hard age limit on library dependencies. As
written currently, is it still objectionable to you?

 - Emily
