Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7517238C1F
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 21:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753220246; cv=none; b=D7KbMVMPTOqOlqyUzmyFiihNCZCxCHYUA614FLRJhYLQ7tmwO8PFKP2Jkk3IyqDp4bB6L9ety9W6y6MCjwRJlOZ7q0fB0f4RdclGm+xW8jrDpNQrJ7pzIjFwrc+gZyCzk7o6ltnzK35hPvOPRmCMPWmQmEsgOEbYy6cjgC87NlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753220246; c=relaxed/simple;
	bh=LaxrYXPxrcUEdloykDLSPpFGndqu9Vw6CSmAgm+q6Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvWU+X54iNaJSKTwt1v3nNQ+svyJm87CLoQfGnyuzCd3TXdRGuEG0WxhGmBsEoHM9j1PqwlxZ4mzIfGooMRZxRzBZYoXdgx6syCtwIWfEzwqivPDw6dVQuv1PgPdBbe5gpwKloFhq0/7PlhIL0Y4REzctwE32lvCHq5DcpVlCuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReoDHMCE; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReoDHMCE"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-87c32f46253so101374739f.1
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 14:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753220244; x=1753825044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tx557sHL1e2Di5e8XIXqDBNF4VIPEiq2w5/l07U4jL4=;
        b=ReoDHMCEuqldlM+VtM0GTH0b00TKD5R8noYBqHJCYwAV3oKZXXlUnSJjAu8uZX8W+H
         IWqu8o+bCF63XIIJL1+IJd3w1pF2OMkhdMyiYDIDX0z7iXJieGkEQ+CQFwAUGyVSUdQ/
         MCgW9bz0IGwiVaOr1HmS32AFu7dX0dsVMLONXp6IseHcC4cWTh7reCDxM254ThLpGiZa
         mKttGX/wqVsv9JAPVEuobChBj3fntcqzu7+/p4uQXXFu66GDmnoRf7rlBywGSEF1tUkq
         19+lAUn0RxQl7OI6Ir8d3MDgaprD8mMetvSYWXeVDHtYPrRPJZXz+DDQcGwjqgrPV7wQ
         +cgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753220244; x=1753825044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tx557sHL1e2Di5e8XIXqDBNF4VIPEiq2w5/l07U4jL4=;
        b=oCQuD4rlLwwrnpCZX58Fhsry1nF8mPs5T/V/YCG1PUq7HWSb2/c+C/MtZIHqB7H/W8
         31cTgubwIM/mU2P4SRYaVtkbqo32rIt8D3Z5z66uq+4Ic4AAmSGZIMH31CXnGS5sOUf8
         wqOcZ7UZnEZodzNRir/D5ElHIBcyC8iUuRpkqMIeN6mfGYzzvfjhHtflv8IRv2H9oTHG
         iCSXnb8+FPHlmwHV+Z3ysjjCjJpVPRy0uYUlqBFluuIgiHRd7HXfycmnYdeQG84A6UBc
         tDqrhsqgE5cAZ3TJj7jDUxEGZgC/HODMgAtn6b31oNVeXgmY2mLqV2r8Lr0obnUTpRD6
         G32Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5beGXH/YEQ8jMGsXAB031dttohj4w1To6XySC9rNVjBX8nbiqt372OWjVbqfJdFiLtyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO+WjrxZijZTtUWWapYTXEwCGQhqPd5en+A1QXxxDfZkDQIBsU
	Sg5g+EmzhwcFX8rlHPMd1bzcf7yTItCkEgl2mWGNASW4KYBkpuxGo7dI+j7ttMX8RIuGQXxEzge
	3F/inTpO2KyXh1ODllKQxerDa+mJtvWNLur22
X-Gm-Gg: ASbGncv9ll4m8anEb28+J8C8iTAbQH2gztX+TxIRTXb5YmzEJckHM8NcfSp9ui2Jnfo
	Y5Jz1Pvos70ax/aMJVNFO60k7MUXyvgbGG+APpnA3r5v/7UrC8Vd61lnlyL5FavxR1P4m9EPPkB
	nzEG2IbMvBZuLyTnnq6HoikzjOu9R2oUwIP+DP0HaULa3Ep7q/UwyXr74Y5CNPogb/s8n4uIaam
	84OIZjzD5JMXI1+R2xc98jsG+ISFORS5tvrsg65bZ3ijdLNFNE=
X-Google-Smtp-Source: AGHT+IH64BaM+EysKHGbUchv8Sx+nX5viDqsqJiSY6s9hzuUcoYONvITY0TGbUhJNQuIV88qpoTysIWg94skg6kel+U=
X-Received: by 2002:a05:6602:6414:b0:876:a7cc:6eb7 with SMTP id
 ca18e2360f4ac-87c64ff4d1dmr144102039f.9.1753220243876; Tue, 22 Jul 2025
 14:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aHl4U98BBvpA5eKF@nand.local> <87seiofc0x.fsf@gentoo.org>
In-Reply-To: <87seiofc0x.fsf@gentoo.org>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 22 Jul 2025 14:37:11 -0700
X-Gm-Features: Ac12FXx8xrpyCSNAVn5Z8ZttM88ZW2gC9l6PrSwi6iaCaztWmXnbMKTazlFqfXs
Message-ID: <CABPp-BEf2O12jx-wN5ig941SyoL=X2OJkQY26bac=8+v+jx8ZQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
To: Sam James <sam@gentoo.org>
Cc: me@ttaylorr.com, ezekielnewren@gmail.com, git@vger.kernel.org, 
	gitgitgadget@gmail.com, sandals@crustytoothpaste.net, 
	Eli Schwartz <eschwartz@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 22, 2025 at 9:03=E2=80=AFAM Sam James <sam@gentoo.org> wrote:

First of all, thanks to all the Gentoo folks for chiming in and
providing specifics about platforms and their state.

> > I am far from a Rust expert, but I think that a more modern, memory-saf=
e
> > language will attract newer contributors who may have a fresher
> > perspective on the project, and I think that's a good thing.
>
> Aren't they likely to contribute to gitoxide? There, they get a clean
> slate without having to deal with the least-fun part (bidings).

I'm sure some are.  But clearly there are others where the draw is
improving git itself because of its installed base; in fact, we need
look no further than this exact series we are commenting on to find
proof of that -- one such new contributor submitted patches to use
Rust in git, and found a significant speedup while doing so.

Further, there's considerable interest from existing git developers to
use Rust in git as well; last year at the Git contributor summit,
usage of Rust in git was not only one of the topics of discussion, it
was the top voted topic (meaning, the topic that the greatest number
of git contributors wanted to discuss).

> > It is also not the Git project's responsibility to ensure that every
> > platform is Rust-friendly.
>
> That's true, of course. And nobody is entitled to indefinie updates, but
> on the other hand, there's still some implicit contract with users. I
> really don't think git would have the adoption it does today if it had
> adopted a Rust-like language in the same state Rust is now from the
> start.
>
> (In exactly the same way, git doesn't gratuitously break compatibility
> every release either. Can it? Yes, and git can change the platforms it
> runs on, but it's something to be taken seriously.)

This feels kind of close to a false dichotomy between breaking
compatibility every release and indefinite update entitlements.  There
is certainly some middle ground: discussing reducing the breadth of
platform support in order to gain other benefits, then gathering
feedback, making a plan, and announcing the upcoming change, etc.

And we're already pretty deep into it.  Concerns about losing out on
some platforms have repeatedly slowed us down from adopting Rust years
ago.  Yet, the desire for Rust adoption keeps coming up anyway; see
the threads starting at

  * https://lore.kernel.org/git/ZZ77NQkSuiRxRDwt@nand.local/
  * https://lore.kernel.org/git/Zu2D%2Fb1ZJbTlC1ml@nand.local/
  * https://lore.kernel.org/git/20241128-pks-meson-v10-22-79a3fb0cb3a6@pks.=
im/
(search for "Rust")
  * https://lore.kernel.org/git/cover.1723242556.git.steadmon@google.com/

The discussion has also been picked up and reported outside the Git
mailing list, e.g. https://lwn.net/Articles/998115/.

And so, in addition to the optional contrib/libgit-rs and
contrib/libgit-sys Rust components that have already been merged into
git, and a new build system added in part to make it easier to adopt
Rust, we now have the first patch series that proposes a hard
dependency on Rust.

Further, I'd like to comment a bit on the support of our users from
another angle.  We're also responsible for security for our users, and
feel Rust would help (see e.g.
https://litchipi.github.io/infosec/2023/01/24/git-code-audit-viewed-as-rust=
-programmer.html
and https://github.com/bk2204/git/commit/fbeb1180c7473635a964daed2da642c534=
87782d).
We're responsible for performance of Git for our users, and feel Rust
would help (see the email that started this thread,
https://lore.kernel.org/git/CABPp-BFOmwV-xBtjvtenb6RFz9wx2VWVpTeho0k=3DD8ws=
CCVwqQ@mail.gmail.com/,
and brian's notes about [CPU multi-]threading elsewhere in this email
thread we are in).  And there are other benefits from using Rust that
we believe would benefit our users.  Thus, it's not just a question of
responsibility to our users, because such a responsibility pulls us in
different directions regarding usage of Rust.  So we need to figure
out how to weigh the needs of our different users.  For many of us,
and forgive the geeky comparison, we'll probably weigh those needs
with something more akin to an L2 norm (most good for the most users)
rather than an L-infinity norm (maximal difference in usability for a
single user), which probably isn't to your liking.

Anyway, there's been lots of discussion already.  We can certainly
still discuss more about exactly how to announce, when to adopt Rust,
whether we'll support an existing C-only version of git for a longer
period of time than normal, and even whether to continue to delay
adopting Rust for a little longer.  But my personal guess is that
attempting to stop adoption of Rust is unlikely to win at this point.

> > Hopefully the platforms that we currently support but won't after this
> > patch series have niche enough workloads that they do not need the
> > absolute latest-and-greatest Git release at all times.
>
> I mention this in my other email, but it's not just about ancient
> platforms. It's also about new ones, or ones where Rust supports them
> poorly despite them being relevant.

This feels like you're trying to push the decision for a given
platform to be a dichotomy between latest-and-greatest-Git or
no-version-of-Git-at-all, despite the fact that Taylor suggested an
alternative and you even quoted him.  Can you comment on that
alternative?  Why would using the last C-only version of Git[1] until
gccrs bridges the gap be a problem for these platforms?

Thanks,
Elijah

[1] Well, C-only other than optional Rust components like
contrib/libgit-rs and contrib/libgit-sys that have already been
released.
