Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E131CCB4E
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036019; cv=none; b=DUgadiJw9Wn4nTYmLoLB/S2SxviFW/lfya58RHhmeUOyJb+wGF3rQiLH8VCP+At5ZsnrIBaz59oju0AEICPtfNMuQcXUkSMf/614Uy4F2U3tghHMMx3BZOW2XNLrAJEoMMr81C2OfWe8ggv46sS7Ajo5ed/xiWxPL/zzsGYCq/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036019; c=relaxed/simple;
	bh=qyIXQQgEdccsxxErORMdW5Fx4n5/q6yU9a7vKdP8uMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgzH0d1jra1hdj0XdvFGpbg/IByuzifKtQlJrT7cLkPXMm9vw5SK36Wo8zgMb+QH0KjClALKJI9eaT9SxqJ8A+Tm+G6F9awgGdM7xUhpCvZHvoCQuWJJO5EiqMdjI2kFBKxrERWxgV0N/MmnBTY/tCOhiboEjTQLHSNOGnzQD44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdvqiGPj; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdvqiGPj"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-29680f21217so780548fac.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 09:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732036017; x=1732640817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQ8mVagSiMXfVfZOL3zenIjuHawAaUobNRmSpbF9OiQ=;
        b=PdvqiGPj3qwCYIOoRcfa19B0OWwFZ0mDpbpOr9cH0RA88vZSXzcxHY22evJCRjn3nI
         +JWIYKY9JwuPA447muFN8/kNLLdJ1PKVxV61oKArWeIKH/TXI0Wk4BnSN/kchN0OH+/b
         6sGArMogSdsEdqqNP8SF+bU9Z2cPqdajlf7bsAEOPL1/F490fbttNwGQ39BABzGbdW62
         3tTOcO0dqWE12O9agFGPql9mPW7JkpMthFEdm3Ri+xbMtOV6AsH7h1cTPn8mhIFzooAs
         Ehix21boUMExGDuvVql6vGcrUMxs47dRtS5pWaD7squ9rWGhu6PES79gt9c8HC5502Op
         5GVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732036017; x=1732640817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQ8mVagSiMXfVfZOL3zenIjuHawAaUobNRmSpbF9OiQ=;
        b=Hgsn3ya672hKhJDD3kFafyiuxhKuMZ2pdNmciMhqUQ2qterrozmFfBFOkn/E7J+XC/
         rUKPsqDmGB11t/hyAb5PWgpMDPY+ehwF24MTXC9kYspTpTV0Yz5ciMGTelZ8iV9VLyBQ
         gYTgcnhpVNFWPSCHcq0UJJDnEY9JGOrj2HH3QnRk/tIGuY+zJoa/L6H0DUlMMDAA+V9A
         O3JFtqfh86U0EqIIgN4LmNRt8P8x0RWbcV5q1IR97YYis6XoYJnhs3DmYdclizxg3rHQ
         NgSx60mz2FZ40Iq301MWyjD78XGzmuxfpjtUEVPgzY5OnTSoNlZVx3l/bfvSPsV5ANbW
         7xFw==
X-Forwarded-Encrypted: i=1; AJvYcCXll7Rz8iaER8WAj5It/9XF5G/x05+ycBL2+heK5RNHf77gyMasbGmCOAzQJzcHt3WTIQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSDpw2CiEbqh/1hcqPO/LqdvUCaaqitfxgSfvneLQVAAULlpRw
	eHP52wS0HilLgkjI5rEjp6chT6JErz8+SKltY6gsNwf5WLmL81LrT6Sbh7U5X40ffRB5pgBPljG
	Wr/vBdaVcHLptrqugaoBkqf3OOa4=
X-Google-Smtp-Source: AGHT+IEiAXc3WpiPTMdbOjuJ48tDB5KRrrGrGO83k/OPWrAgVph+PgLmxB8LZaStTSoZvqX/BR63HYEORslwF2gRJao=
X-Received: by 2002:a05:6870:5d8e:b0:270:205a:4070 with SMTP id
 586e51a60fabf-2962dd3bbf8mr15477764fac.14.1732036016999; Tue, 19 Nov 2024
 09:06:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAHKNRGv19rhnqCkJMpE2FomNQBHvSS36aC=fh0UwO+9-6RRfA@mail.gmail.com>
 <20241116033616.GB1782794@coredump.intra.peff.net> <D5NOZMMISX44.2PTTMY57J5EM6@ferdinandy.com>
 <CAAHKNRF8JDUTH-QzPG1b4-wafzU+MXaMNinfBRu3JfCssfwGUw@mail.gmail.com>
In-Reply-To: <CAAHKNRF8JDUTH-QzPG1b4-wafzU+MXaMNinfBRu3JfCssfwGUw@mail.gmail.com>
From: Caleb Cushing <xenoterracide@gmail.com>
Date: Tue, 19 Nov 2024 12:06:21 -0500
Message-ID: <CAAHKNRF4AnvceiTDLdpNS94yRnoZYMSD0Wkg7V+4YBwSej7NSA@mail.gmail.com>
Subject: Re: git remote set-head automatically
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A little more progress on what I'm going to have to do, github action,
without set-head the ref/HEAD isn't present

- uses: actions/checkout@v4
  with:
    ref: ${{ github.event.workflow_run.head_branch}}
    filter: "blob:none"
    fetch-depth: 0
- run: git remote set-head origin --auto # fixes otherwise the cat
will not find a file
- run: cat .git/refs/remotes/origin/HEAD

https://github.com/xenoterracide/gradle-convention/actions/runs/11917790368=
/job/33213687888

My problem of course isn't what *I* have to do, it's explaining to
other people what to do and why; as it feels like this could set-head
implicitly.

/usr/bin/git -c protocol.version=3D2 fetch --prune
--no-recurse-submodules --filter=3Dblob:none origin
+refs/heads/*:refs/remotes/origin/* +refs/tags/*:refs/tags/*
+e1f39782ea2c90f5a9657ae88369599518b22a51:refs/remotes/pull/57/merge

On Tue, Nov 19, 2024 at 10:40=E2=80=AFAM Caleb Cushing <xenoterracide@gmail=
.com> wrote:
>
> sounds great. I think I realized why I didn't have it. It's not done
> by `git remote add <origin> https://...`  my experiment was `git
> remote rm origin` and then `git remote add origin ... ; git fetch
> --all --prune` I think I also tried without the prune option. git
> version 2.46.1
>
> What I want mostly is for that HEAD ref to always exist. As far as
> there being ways to configure it, that's all good but I don't want to
> explain doing that to consumers of my code. I'd rather it just work
> for them, on clones, and add remotes or fetch if it's missing.
>
> I'm not super worried about it being updated as I feel like if that
> ever happens it's something loudly communicated, and I'm more willing
> to find it ok to make that an FAQ, if this breaks because that changed
> you can manually update that. Mostly I'm of the opinion that what I'm
> doing needs to work in various CI environments out of the box.
>
> Thanks for the info, hopefully soon (tm).
>
> On Sat, Nov 16, 2024 at 10:02=E2=80=AFAM Bence Ferdinandy <bence@ferdinan=
dy.com> wrote:
> >
> >
> > On Sat Nov 16, 2024 at 04:36, Jeff King <peff@peff.net> wrote:
> > > On Fri, Nov 15, 2024 at 09:34:28AM -0500, Caleb Cushing wrote:
> > >
> > >> Context: recently I've been trying to develop a feature for my Gradl=
e
> > >> plugin that derives a semantic version from git describe.  In order =
to
> > >> achieve my next level of feature I need the HEAD Branch. Now, I can
> > >> get this branch using git remote show <remote> and parsing the outpu=
t.
> > >> I'm a firm believer that it should be possible for me to write code,
> > >> long term even, without the internet; I did this once with my job wh=
en
> > >> I needed to go home to my parents who were very rural and didn't hav=
e
> > >> internet; I was able to keep working without access. I want that for
> > >> anyone that uses this tool.
> > >
> > > You should use the refs/remotes/<remote>/HEAD symref instead (or its
> > > alias, just "<remote>"), which is more convenient and doesn't hit the
> > > network. Which is exactly what...
> > >
> > >> Problem: I don't want to have to do a network request every time I d=
o
> > >> a build, in fact I'd rather almost never have to do a network reques=
t.
> > >> Gradle makes reducing the network request to less than once per buil=
d
> > >> something ... unsupported. jgit doesn't expose support for fetching
> > >> this information. Then I found out that you could do `git remote
> > >> set-head <remote> <branch>` which appears to behave exactly how I'd
> > >> want and expect. It doesn't easily solve my problem though because I
> > >> want my solution to be generally applicable.
> > >
> > > ...set-head will set. So OK, but...
> > >
> > >> Ideal Long-Term Solution: git remote set-head happens automatically =
on
> > >> lone, and even fetch if it's not set. Explicit setting would overrid=
e
> > >> any automatic setting; and it might be a good idea to automatically
> > >> unset if the HEAD branch disappears from the remote.
> > >
> > > We already do the equivalent of set-head on clone. If you do:
> > >
> > >   git clone https://github.com/git/git
> > >   cd git
> > >   git symbolic-ref refs/remotes/origin/HEAD
> > >
> > > you should see it pointing to "refs/remotes/origin/master" (and like =
you
> > > can refer to "origin/HEAD" or "origin" from git-log, etc). Are you no=
t
> > > seeing that?
> > >
> > > We don't update it on fetch. That has been discussed, but there are s=
ome
> > > questions about when it should overwrite what's available locally. E.=
g.
> > > this thread:
> > >
> > >   https://lore.kernel.org/git/D3HBD7C1FR14.74FL1Q1S9UCB@ferdinandy.co=
m/
> >
> > That part we already have pinned down: fetch will only update remote/HE=
AD if it
> > doesn't already exist. So running "init && remote add && fetch" should =
end you
> > up in the same place as "clone" (although fetch will report if the remo=
te has
> > changed HEAD compared to what you have for transparency). If you _alway=
s_ want
> > to have the latest head you'll need to run "fetch && remote set-head --=
auto
> > [remote]" every time.
> >
> > Something like
> >         git fetch --all && git remote | xargs -i git remote set-head -a=
 {}
> > covers everything.
> >
> > >
> > > There have been some patches in that direction but I have not kept up
> > > with the current state:
> > >
> > >   https://lore.kernel.org/git/20241023153736.257733-2-bence@ferdinand=
y.com/
> >
> > There's definitely going to be another round, but I think (hope :)) we'=
re not
> > very far off from finishing.
> >
> > Best,
> > Bence
>
>
>
> --
> Caleb Cushing
>
> Appointments https://calendly.com/caleb-cushing
> https://xenoterracide.com



--=20
Caleb Cushing

Appointments https://calendly.com/caleb-cushing
https://xenoterracide.com
