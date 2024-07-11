Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077FA18E20
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720728775; cv=none; b=jEseRurEf9vyPXH772UffIy9gytds5rXCxMvOYwAVFQaonXEIyb2YM8gk6wNszup5nNVKsHkQ1r2ermVucpPZ/y/e7ufTr+NgIk+EtJiqUGidUaiM+Ih6COpgy6Bkm961jUhy42QhFmFrV09iZiH67tn/T8P5mrK5HWQQSZ0aDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720728775; c=relaxed/simple;
	bh=00OG6kbq+eEWCW/+A6pddUHH2anH4ZH0jownjqbNfQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqNDEmaJqvpoLeOJgB1IMyvH2EA7gIoiGBDfpn5UZHHaPBfW+JIiD7j0FTnwQGAmuu/DKGE/X4Sv6VF0jC26phEjmVF36K7uxtAbkbfSaq8gigPP1xy6H/6yTYLh6aCwVnNBiHJPWGUg+nwLlEDSE3BZoEr5R2yCSwkVsHrnQWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EF9Xb4k7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EF9Xb4k7"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52ea7bdde68so1451566e87.0
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720728772; x=1721333572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYhbNb5eQu6IgAcMABX/mib/ynT8koZkELjUEtu5Sno=;
        b=EF9Xb4k7Ma5KuuxINK4OMHkmX63Ou0BiTXh+qevYaPpp5e6L4RdA1PRc/OW9ksZWpe
         mqJ6IhynKhjU/RWZpsSveqfXeHokMqztsTVDDLSl1coREB0gxbVuOOVP06WSiC3Zp7jw
         9V0xOTAF8vubvjQ8SeCtr6nZVr33D+9HHDM3wW6zJVf42fYxe6/h9yLXGbGagzK2Y5oX
         gtI0cQdbDfcaxwc20ugmTMQ9uyThuhs0+n8N3A7GIlMAuDs2OTiTB+XM8qBjSjCR6pY+
         bb82tHX9tccSWXgMdtpTtNZaaEkCWUSm0z2XBXOmEaWpyFEOjPD6AWIDTe/3Eyx8fFoT
         kooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720728772; x=1721333572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYhbNb5eQu6IgAcMABX/mib/ynT8koZkELjUEtu5Sno=;
        b=BnwssS4Px+fJLG/nO1DiPgq01BXwHXPLijxEBgcbuKapKhBZBMpKPBbQgekdn1A5hG
         27yKQ8/9trpAykaLMJIdJOz3t+v8couVcK0XzTpw6RFOUH6huzxTwMrR6S9sP3ZjjFYI
         YFgWbfKIL0j3W6rCiznqdz1f3+k6hPr824xekaKbTw1VPFm1oiWJxzpsDV55Q1Zrnnk+
         8SxQY773qaXxjmGVcLLMb2hMe/O4esQdgkxwBccH6XTG74BBmuq6NS01+20oOfu4XFRo
         woShwD1wd6rAVPow3RAAasHlZQsoFdzY33MI6poQR4QcRYgEYZTzR4aEcbJoRKoEo9Gq
         Hiqw==
X-Forwarded-Encrypted: i=1; AJvYcCUl3hkdvExCEhtPEqlsaGk+YbAcxPEvhlJZtbXL714BsOEFbrFxqQojHoHP0SBqWHXMxyWHeiDko9lMLjXPDTn/nEKk
X-Gm-Message-State: AOJu0Yxt9VvT2qcIytqDoiY6T6tCMg7vUiDLc0xkRAvYeFQJp8k35Ybp
	9yN0hNuUxuvS1isN4mKtgHQL18+pF08wbxSx6UUGrsxC90Oa9K7VQPnm8/CffSttB1zkGwV4xys
	AZfouek/I4kxm1c2wEC3nxsL3zYnoav53k5ng
X-Google-Smtp-Source: AGHT+IH+6ff1oBKbN6/eqS7wwQElcgAHm2/DxUTmSIJCvPkHwWKLY44hAWMgShUGpFVlZdHLA1f8FiXJraIXl2Z2eck=
X-Received: by 2002:a05:6512:3f14:b0:52c:dea7:f22c with SMTP id
 2adb3069b0e04-52eb9990e9dmr7189814e87.2.1720728771846; Thu, 11 Jul 2024
 13:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709225042.2005233-1-emilyshaffer@google.com>
 <Zo3EvvSI999ngrLn@tapette.crustytoothpaste.net> <CAJoAoZmq=TyQxnVJvGxqKJj7XqvOxX4osa5Q5K4=w1NMWECBOQ@mail.gmail.com>
In-Reply-To: <CAJoAoZmq=TyQxnVJvGxqKJj7XqvOxX4osa5Q5K4=w1NMWECBOQ@mail.gmail.com>
From: Kyle Lippincott <spectral@google.com>
Date: Thu, 11 Jul 2024 13:12:34 -0700
Message-ID: <CAO_smViKbb5pKKsfEV9nMLNJEjJ34HU0fUZmG8EPJjXq2fnviQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: add platform support policy
To: Emily Shaffer <nasamuffin@google.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Emily Shaffer <emilyshaffer@google.com>, 
	git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 11:15=E2=80=AFAM Emily Shaffer <nasamuffin@google.c=
om> wrote:
>
> On Tue, Jul 9, 2024 at 4:16=E2=80=AFPM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > On 2024-07-09 at 22:50:42, Emily Shaffer wrote:
> > > Right now, this doc talks about "guarantees." I used that phrasing ba=
sed on
> > > what I've observed to be an implicit expectation that we guarantee su=
pport; it
> > > could be this isn't actually a guarantee that the community is willin=
g to make,
> > > so I am hoping we can discuss it and come up with the right term.
> >
> > I think it might be helpful to look at what some other projects do. Rus=
t
> > has a concept of tiered support, and it requires platforms to have
> > maintainers who will commit to support an OS.  I don't think we
> > necessarily need to be so formal, but if nobody's stepping up to monito=
r
> > an OS or architecture, it may break at any time and we won't be able to
> > consider it when deciding on features we require from the platform (suc=
h
> > as Rust, C versions, or POSIX versions).
>
> It took me a little time to find it, so here's the link for others:
> https://doc.rust-lang.org/nightly/rustc/platform-support.html
>
> I do think it's interesting that while Rust splits their tiers based
> on how much of it will definitely work (definitely builds+tests,
> definitely builds, probably builds maybe), which is different from how
> I sliced it by time (works on release, works on stable, works on
> unstable). This kind of lines up with what you mentioned next about
> the tests (or some subset) working, which I hadn't considered, either.
>
> >
> > I think it's also worth discussing what we require from a platform we'r=
e
> > willing to support.  For example, we might require that the platform
> > pass the entire testsuite (ignoring irrelevant tests or tests for thing=
s
> > that platform doesn't use, such as Perl) or be actively pursuing an
> > attempt to do so.  We may also want to require that an OS be actively
> > receiving security support so that we don't have people asking us to
> > carry patches for actively obsolete OSes, such as CentOS 6.  Finally,
> > some sort of time limit may be helpful, since some Linux vendors are no=
w
> > offering 15 years of support, and we really may not want to target
> > really ancient versions of things like libcurl.
>
> I sort of wonder how much of this is taken care of by expressing
> "fully supported" as "can run in GitHub Actions". Even if an LTS
> distro is 12 years old and using ancient curl, will GitHub still be
> able to run it in a VM/container? Maybe there's no such guarantee,
> since you can hook up self-hosted runners (which sounds more appealing
> if someone's got something weird enough it doesn't run well in a
> container).
>
> I'm not sure which of these requirements we'd want to enumerate - but
> does it make sense to tack it onto the end of this doc? Something
> like:
>
> """
> Minimum Requirements
> ------
>
> Even if tests or CI runners are added to guarantee support, supported
> platforms must:
>
> * Be compatible with C99
> * Use curl vX.Y.Z or later
> * Use zlib vA.B.C or later
> ...
> """

My concern with actually listing what the minimum requirements are is
that we then need a process for raising the minimum requirements. For
C specification, I can see that rightfully being an involved
conversation and achieving consensus that this is the right time to do
it. For things like library versions, I'm less comfortable with it
because if we have to raise the minimum bar for some urgent reason,
there's the potential for additional friction with these platforms
claiming that we stated we'd support them (ex: we say you need to be
able to use libfoo v3.x.x (v4.x.x had some breaking changes, but
coexists with v3, so we just stuck with v3), and some security fix
that we need to receive only exists on the v4 version, so now we need
to port to using v4 so that we get the security fix).

I think it's probably fine to list minimum requirements, as long as we
have something conveying "and possibly other criteria". I don't want
this interpreted as a "do this, and we will try hard to not break
you", it should be interpreted as "if you can't do at least this, we
won't even look at patches/tests/CI to unbreak you/keep you unbroken"

>
> >
> > At the same time, we do have people actively building Git on a variety
> > of platforms and a huge number of architectures, including most Linux
> > distros and the BSDs, and we will want to be cognizant that we should
> > avoid breaking those environments when possible, even though, say, the
> > porters for some of those OSes or architectures may not actively follow
> > the list (due to limited porters and lots of porting work).  I imagine
> > we might say that released architectures on certain distros (Debian
> > comes to mind as a very portable option) might be implicitly supported.
>
> Are they implicitly supported, or are they explicitly supported via
> the GH runners? Or indirectly supported? For example, the Actions
> suite tests on Ubuntu; at least once upon a time Ubuntu was derived
> from Debian (is it still? I don't play with distros much anymore); so
> would that mean that running tests in Ubuntu also implies they will
> pass in Debian?
>
> (By the way, I think we should probably just add a BSD test runner to
> Actions config; we test on MacOS but that's not that closely related.
> It seems like it might be a pretty easy lift to do that.)
>
> >
> > > +Compatible on `next`
> > > +--------------------
> > > +
> > > +To guarantee that `next` will work for your platform, avoiding react=
ive
> > > +debugging and fixing:
> > > +
> > > +* You should add a runner for your platform to the GitHub Actions CI=
 suite.
> > > +This suite is run when any Git developer proposes a new patch, and h=
aving a
> > > +runner for your platform/configuration means every developer will kn=
ow if they
> > > +break you, immediately.
> >
> > I think this is a particularly helpful approach.  I understand the Linu=
x
> > runners support nested virtualization, so it's possible to run tests in
> > a VM on a Linux runner on OSes that Actions doesn't natively support.  =
I
> > do this for several of my Rust projects[0] on FreeBSD and NetBSD, for
> > example, and it should work on platforms that support Vagrant and run o=
n
> > x86-64.
> >
> > That won't catch things like alignment problems which don't affect
> > x86-64, but it does catch a lot of general portability problems that ar=
e
> > OS-related.
> >
> > I'm in agreement with all of your suggestions, by the way, and I
> > appreciate you opening this discussion.
> >
> > [0] An example for the curious is muter: https://github.com/bk2204/mute=
r.
>
> Neat :)
>
> > --
> > brian m. carlson (they/them or he/him)
> > Toronto, Ontario, CA
>
