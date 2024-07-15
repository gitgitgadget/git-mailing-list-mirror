Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADEC14036F
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 22:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721082505; cv=none; b=Jx+vchbE/uc+huwh9QA/yHRK5zu3egb3FCuZkyHY5+uq9u+Ey6MhxTk66oRuquzJACVSzbVqd2Kt7YHO2IvlAHaoW+mxJD1DVJhY5dZgl5pVa7ub1geLCNBDg5Ovu7/DRF7lsJCvHJekMnd29hOaVMhR9iB+EhOM2Vm4Zttyzxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721082505; c=relaxed/simple;
	bh=daDohF02ABy4qJCqFRr5XtEtLULQfkf+AJ8OHmemHk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YwjSHMRfDQe8ksrnVsK8+coIA/L9PLxAjWhCLWpurj/eMnc8v/nvrjkEd8CJbe7F78otqANZWclwCDEpgaiNzPQoiY/BjSK/RkEfHbK8QfrQ0xjgD/Bzf60B7+V6hkdDosfRGoBiUZc/cTBJHJeTx58/xFaKHhL1EqeQj+L1xLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dl0fVRuf; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dl0fVRuf"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-447f8aa87bfso150291cf.0
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 15:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721082502; x=1721687302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyxFWUHJcqWy7m/WjIDAOMiSWWB3jlDJqXsPDzbuMsc=;
        b=dl0fVRufuNhEiVg43GSBX+LFv4sbLaJWWY0JCIY0B5oQ8V5mPzKwJQj+6X550ewrNr
         8ec1dvd/PKY1BTgJ9NGzezi52kXhNTqdhOpCWiK3aGM4OmeYNz6QgL4eg4sZiHnZ34tY
         QKwX1DUz/CXfxBGbpcq36ZOHTVjPtr02KgIU57kUBsuX59c9mhZNTF9yqr4J11d7fPUD
         6uZcLBBFSfv72Sl9QwPO9SbUzHC1rne/EfGwt+iQJeXpN1QUL9tMbUEhsfJhPstxt7bw
         3oojoJl4n6HjpA4coS4vSS4kRdEMsRjceVr8YNgA/pui6VmmJRmG3lO49IaQ42sGyE/I
         zqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721082502; x=1721687302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyxFWUHJcqWy7m/WjIDAOMiSWWB3jlDJqXsPDzbuMsc=;
        b=DgSLFPqHLPvQpTi9HXqkMaG/P5R7mfoma27loFQJ20oAq3DtjRiRyDDhCoR7nSrQ1s
         w/MTfIOFw8Ggnza0X6lxTea0qCnVBMkSc5rambYKg82LFXB7nO8ZsPRojB1z0woxT+uc
         Tvo9In+6uLEXMDSwFgvqvfT/YVJRxbCu4ggHhKfTckhUofztfdWr/XwNdvH+hSbXwLby
         kUiac6iMhxKNAZjYyutyGZC9LIeHlGtvNS6z6YhlfgQTcIwd8SwuMjXwLIQeBSS4bFXn
         g5sAt1stkv0SRqmaLeS1eQ1cAYWXfnpSnJX8WOHIQKYLPi1Akaq2B7FwY50bsiFkWEyp
         fpkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP8eTpR7V5bCDBQYj6nCfNK4yb7cpGamObPDiuMNsUlG/X3ooHMa3aBF0JFI3IMVefluCffnRx/mUyPnNuDFQ1CVXV
X-Gm-Message-State: AOJu0YzVZ8dXmu9BbtBRVUMXEJKRguP5sq9VYcu7EHwxKiBmtdvCKJWY
	ryX4r1ooaZLnAvj15J7HgkkuKBjc/zxjWbNeLPa8z3tKlpIYMF8odnOFu/OFWchfOpC9xTFdLLW
	GJDxdRthJTUK9Ph2hWr9EnHV6xtBGz8u//mmT
X-Google-Smtp-Source: AGHT+IGlKU4SHM2UeOIkkQiKTo81rpCNSSbbM2Oq/ElPfCu5aVF0WlJftrmI6k9vemjsmqnDP71UtjPB+mnTcWwzu9E=
X-Received: by 2002:a05:622a:5287:b0:447:e8bd:2fbe with SMTP id
 d75a77b69052e-44f7b8fdcabmr539271cf.1.1721082502462; Mon, 15 Jul 2024
 15:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709225042.2005233-1-emilyshaffer@google.com>
 <Zo3EvvSI999ngrLn@tapette.crustytoothpaste.net> <CAJoAoZmq=TyQxnVJvGxqKJj7XqvOxX4osa5Q5K4=w1NMWECBOQ@mail.gmail.com>
 <ZpBbgXYQlpHZa3xR@tapette.crustytoothpaste.net> <CAJoAoZn+R3qhoVA=av8NMcCAJyRHOe6QTXV=pyjs80JmV0mVzw@mail.gmail.com>
 <ZpGFHWZTWAQUXGCe@tapette.crustytoothpaste.net> <01b101dad494$3ad61d50$b08257f0$@nexbridge.com>
In-Reply-To: <01b101dad494$3ad61d50$b08257f0$@nexbridge.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Mon, 15 Jul 2024 15:28:11 -0700
Message-ID: <CAJoAoZnYxfg_uU96Dr5T3GJYMsx1n7YyQrKGha=MEEHMa2UaRw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: add platform support policy
To: rsbecker@nexbridge.com
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 12:46=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>
> On Friday, July 12, 2024 3:34 PM, brian m. carlson wrote:
> >Subject: Re: [PATCH] Documentation: add platform support policy
> >
> >On 2024-07-11 at 23:15:35, Emily Shaffer wrote:
> >> On Thu, Jul 11, 2024 at 3:24=E2=80=AFPM brian m. carlson
> >> <sandals@crustytoothpaste.net> wrote:
> >> > Some older OSes require kernel features that aren't compiled in by
> >> > default, so containers are out.  For example, CentOS 6 won't run on
> >> > a modern kernel because it lacks whatever the predecessor to the
> >> > vDSO was (which can be recompiled into the kernel, but nobody does t=
hat).
> >>
> >> Is this hinting that we should mention a minimum kernel version for
> >> Linux-kernel-based OSes?
> >
> >This is actually a feature that still exists in the kernel and could be =
enabled for newer
> >kernels, but because distros don't use it (they use the vDSO instead), t=
hey don't
> >compile it in.
> >
> >I'm not sure a minimum kernel version is helpful, because most of the LT=
S distro
> >kernels backport features, like Red Hat backported getrandom for example=
.  In the
> >interests of getting to a useful agreement, I think for now we should ju=
st punt on
> >this and having a 10 year lifespan will probably do the trick, and we ca=
n determine
> >in the future if we need to apply more stringent measures.
>
> When looking at the "exotics", many have their own kernel lifespans. When=
 worrying about NonStop, for example, the Kernel version stays around about=
 5 years under full support, then goes another few until retired. I think i=
t is important for people to know the compatible versions of the kernel bui=
lds have. I do track those for the platform.
>
> >> > We also don't really want to be on the hook for trying to support
> >> > OSes Ubuntu is still derived from Debian.  It is likely that things
> >> > which work in one will work in another, but not guaranteed.
> >> >
> >> > I mention Debian is because it has a large variety of supported
> >> > architectures.  I absolutely don't want to say, "Oh, you have MIPS
> >> > hardware, too bad if Git doesn't work for you."  (I assure you the
> >> > distro maintainers will be displeased if we break Git on less common
> >> > architectures, as will I.)  In fact, MIPS is an architecture that
> >> > requires natural alignment and can be big-endian, so it's very
> >> > useful in helping us find places we wrote invalid or unportable C.
> >> >
> >> > The reason I'm very hesitant to require that we run everything in
> >> > GitHub Actions because it only supports two architectures.  ARM64
> >> > and RISC-V are really popular, and I can tell you that running even
> >> > a Linux container in emulation is really quite slow.  I do it for my
> >> > projects, but Git LFS only builds one set of non-x86 packages (the
> >> > latest Debian) because emulation is far too slow to build the normal
> >> > suite of five or six packages.
> >>
> >> Does that restriction apply to just GitHub-hosted runners, though?
> >> Would it be possible for an interested party to set up self-hosted
> >> runners (configured via GH Actions) that are using AMD or POWER or
> >> whatever? (For example, I think it would be quite feasible for Google
> >> to donate some compute for this, though no promises).
> >
> >Self-hosted runners on public code are very hard to secure.  You're basi=
cally letting
> >arbitrary people on the Internet run code on those machines and make out=
going
> >network connections (due to the fact that you can push whatever into a P=
R
> >branch), with all of the potential for abuse that that involves (and as =
my colleagues
> >can tell you, there's a whole lot of it).  GitHub has taken extensive pa=
ins to secure
> >GitHub Actions runners in the cloud, and while we use self-hosted runner=
s for some
> >internal projects, they are absolutely not allowed for any public projec=
t for that
> >reason.
>
> I'm not sure this applies to some of the exotics. NonStop cannot run the =
Google CI code.


I assume you meant the GitHub CI code?

> While we could, in theory, connect to via SSH to run builds, my system is=
 behind a VPN/Firewall, which would make the builds impossible. I do build =
using Jenkins based on an SCM poll. It's not perfect and some tests do not =
run correctly in Jenkins but do outside. I would like to provide the feedba=
ck to the git team, somehow, on what built successfully or not, outside of =
the mailing list.

I hope that the overall intent - you need to give us *something* that
we can self-serve issue reproduction on, or else you can deal with
lower quality of service - is clear and understood. It sounds like
this puts NonStop squarely into this second category, running against
`next` or `seen` on a nightly cadence and publishing breakage reports,
then working closely with developers to make fixes as appropriate (or
making them yourself). (By the way, is this doc something you can
point your manager chain to to explain why Git issues appear and how
to stop them from doing so? Maybe that would make your life easier,
even if the answer to that conversation is "we can't provide what Git
is asking for, so we'll be OK with lower quality of support"...)

>
> >I would be delighted if Google were willing to do that, but I think you'=
re going to
> >need help from teams like Google Cloud who are going to be used to deali=
ng with
> >abuse at scale, like cryptocurrency miners and such.  Unfortunately, the=
re are many
> >people who act in a less than lovely way and will exploit whatever they =
can to make
> >a buck.
> >
> >I will also note that the official Actions runner is in C# and only runs=
 on a handful of
> >platforms due to the lack of portability of C#.  (It might theoretically=
 run on Mono,
> >which would increase its portability, but I must profess my complete ign=
orance on
> >anything about that code.) I also know of an unofficial one in Go[0], wh=
ich I'm for
> >obvious reasons unable to endorse, encourage, or speak about authoritati=
vely in
> >any way, but that would still exclude some platforms and architectures w=
hich don't
> >support Go.
>
> We don't have C# or Go, nor are likely to any time soon, so that is a pro=
blem.
>
> >
> >> The appeal is not "because GitHub Actions are great!" for me - the
> >> appeal is "because most Git developers run the CI this way if they
> >> remember to or use GGG, and Junio runs it on `seen` all the time". If
> >> there's some other recommendation for self-service CI runs that don't
> >> need some careful reminding or secret knowledge to run, I'm happy with
> >> that too. (For example, if someone wants to set up some bot that looks
> >> for new [PATCH]-shaped emails, applies, builds, runs tests, and mails
> >> test results to the author after run, that would fit into the spirit
> >> of this point, although that sounds like a lot of setup to me.)
> >
> >Yeah, I understand what you're going for.  If there were some super easy=
 way to get
> >everything running in an automatic CI, I'm all for it.  I think CI is th=
e easiest way to
> >make sure we don't break anything.
> >
> >I think it's worth trying to get CI set up for whatever we can, and if C=
I is a possibility
> >somewhere, it becomes a lot easier to say yes.
> >
> >> Should have a reroll in the next 30min, it was ready to go and then I
> >> got this mail :)
> >
> >Sounds good.  I don't think anything in this email should affect that re=
roll.
> >
> >[0] https://github.com/ChristopherHX/github-act-runner
> >--
> >brian m. carlson (they/them or he/him)
> >Toronto, Ontario, CA
>
> --Randall
>
