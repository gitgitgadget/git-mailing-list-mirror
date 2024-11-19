Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599BE1CCB35
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030897; cv=none; b=anFWggN4R2z3jLpGmNXpk42SrTGgpsCo+nEsBv+SKy5o522qfD3Am0VwVfu2JM4WjzOCt/28aSJsW2xl4DQMvO8uZD8d7yZ0MfVcn0Bzb3YNYVHtc9HOpYRGGVdmAxF9P0REWjuW61kytl1DMqmxLOiUYSA+FVBDQZg3DgAPCAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030897; c=relaxed/simple;
	bh=7gRn8v4h7cyjKfzMo5K1qorI7FQn1D06bF11c5jRMDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BsQHIdpOSdTEDhjnARAxMxquT00BzTtBRnAjWlzNbuH/n3/lAGyY+XqYPsPNTImpfRWdUL0Z0l7bevjbQDNXt7vDcSa+CpBUERUv7ynZZBUaSly2yhFU5N4edGBvlYvTiNvDUWWW0aLaHXKRr/vYA2+9UInHbF9ZJArp2bYLZoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0z4XFNL; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0z4XFNL"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-296bf028170so229957fac.3
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 07:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732030893; x=1732635693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68XdLUbRhusPeHw3XDNwBQAV9SiZijLJ5dDlLIOGWOs=;
        b=X0z4XFNLPQOs6Kf4WO/xR+HGLQDWg9mx0JqkxTHla+e3UDSI78vmt5mnXRb7KKNrHE
         4jNf7vh6XSOualOmbBMkshuymjVqeGBDOvd3+QBBW6gaSHCZtAE1/N0zNlX7VtueCm+v
         tmF53SAjd1p/cLZqVzOqT+0no17UNHBMf1ZaqUn9XR9qBa1SdnRTOGtUWPos4ESb7op6
         ToABsuZz6eI0mUAfWZGXh8nyi3ukgPrJAm1L+hNvWZihZqUsSCK3HV3P4gKg/ChS6Ix+
         bbiIYkpl/TJCuHnCJ8JnOYNfLPtnySfok0fQQyOBaLqqIGA3VpF1JwS71gjbg2IYp5to
         l39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732030893; x=1732635693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68XdLUbRhusPeHw3XDNwBQAV9SiZijLJ5dDlLIOGWOs=;
        b=dqjmpW6pAI4MEY0MGJzKO5C3vcjmt34jsmHmh+cqrKTpv0yQDOgHW1OkAtb8qgxCE5
         uSGjAYbDGB8XOyOnWPAUryvMj7LSTGU1kQu7wiqZy2nkQ8kM6dVDyWV7bmuP76ewje1W
         2OykpmGZ5hEjVMohOKoYsYTBmCqcc7NoA2+5Nred18ttcvQUS+BqrndHaEDSzvFOAinC
         pOvBuh+Z8frQAioRFxkHdFHug+7f6AfysEPvStMYBlUhlvy2AFbEJ045iKqG+Arcojsf
         T8A7ciOrNOvPutQmCkVmTIF+RM1FREDDFLXPxh8+FfwDxWhDKdZlaoTwUi07fEGnpR8A
         C8qw==
X-Forwarded-Encrypted: i=1; AJvYcCX/3Rzual3vgm1Ny5+ohxUmicQlBFpWjwvnO1/5IRY5Bk8yXYu3ys2WVvc+eu35tyGDrgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgiisRflXtrq9SQLgT8nsJnhFg5r3Td3hIIOS/zj82l+kjhIFn
	5LicJXgC/y+Egu1H4naVgqFgMf4fRkQtspiHYwRzyUpQAy2J+NstIXqzFCb3RyZluepQIqU0DZh
	7TpC2auADol46MWjdKfbX9sqZu6TI7RvY
X-Google-Smtp-Source: AGHT+IF9z8U/Efdv+VWfZvz2QAuOV3f0vV18mxvTwP87Wj1W1nz0gCIROCWmgswC74e4kC3j/+y8P26giYEE5XC6/uY=
X-Received: by 2002:a05:6871:113:b0:277:da52:777 with SMTP id
 586e51a60fabf-2962dd837e1mr13445224fac.11.1732030891913; Tue, 19 Nov 2024
 07:41:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAHKNRGv19rhnqCkJMpE2FomNQBHvSS36aC=fh0UwO+9-6RRfA@mail.gmail.com>
 <20241116033616.GB1782794@coredump.intra.peff.net> <D5NOZMMISX44.2PTTMY57J5EM6@ferdinandy.com>
In-Reply-To: <D5NOZMMISX44.2PTTMY57J5EM6@ferdinandy.com>
From: Caleb Cushing <xenoterracide@gmail.com>
Date: Tue, 19 Nov 2024 10:40:55 -0500
Message-ID: <CAAHKNRF8JDUTH-QzPG1b4-wafzU+MXaMNinfBRu3JfCssfwGUw@mail.gmail.com>
Subject: Re: git remote set-head automatically
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sounds great. I think I realized why I didn't have it. It's not done
by `git remote add <origin> https://...`  my experiment was `git
remote rm origin` and then `git remote add origin ... ; git fetch
--all --prune` I think I also tried without the prune option. git
version 2.46.1

What I want mostly is for that HEAD ref to always exist. As far as
there being ways to configure it, that's all good but I don't want to
explain doing that to consumers of my code. I'd rather it just work
for them, on clones, and add remotes or fetch if it's missing.

I'm not super worried about it being updated as I feel like if that
ever happens it's something loudly communicated, and I'm more willing
to find it ok to make that an FAQ, if this breaks because that changed
you can manually update that. Mostly I'm of the opinion that what I'm
doing needs to work in various CI environments out of the box.

Thanks for the info, hopefully soon (tm).

On Sat, Nov 16, 2024 at 10:02=E2=80=AFAM Bence Ferdinandy <bence@ferdinandy=
.com> wrote:
>
>
> On Sat Nov 16, 2024 at 04:36, Jeff King <peff@peff.net> wrote:
> > On Fri, Nov 15, 2024 at 09:34:28AM -0500, Caleb Cushing wrote:
> >
> >> Context: recently I've been trying to develop a feature for my Gradle
> >> plugin that derives a semantic version from git describe.  In order to
> >> achieve my next level of feature I need the HEAD Branch. Now, I can
> >> get this branch using git remote show <remote> and parsing the output.
> >> I'm a firm believer that it should be possible for me to write code,
> >> long term even, without the internet; I did this once with my job when
> >> I needed to go home to my parents who were very rural and didn't have
> >> internet; I was able to keep working without access. I want that for
> >> anyone that uses this tool.
> >
> > You should use the refs/remotes/<remote>/HEAD symref instead (or its
> > alias, just "<remote>"), which is more convenient and doesn't hit the
> > network. Which is exactly what...
> >
> >> Problem: I don't want to have to do a network request every time I do
> >> a build, in fact I'd rather almost never have to do a network request.
> >> Gradle makes reducing the network request to less than once per build
> >> something ... unsupported. jgit doesn't expose support for fetching
> >> this information. Then I found out that you could do `git remote
> >> set-head <remote> <branch>` which appears to behave exactly how I'd
> >> want and expect. It doesn't easily solve my problem though because I
> >> want my solution to be generally applicable.
> >
> > ...set-head will set. So OK, but...
> >
> >> Ideal Long-Term Solution: git remote set-head happens automatically on
> >> lone, and even fetch if it's not set. Explicit setting would override
> >> any automatic setting; and it might be a good idea to automatically
> >> unset if the HEAD branch disappears from the remote.
> >
> > We already do the equivalent of set-head on clone. If you do:
> >
> >   git clone https://github.com/git/git
> >   cd git
> >   git symbolic-ref refs/remotes/origin/HEAD
> >
> > you should see it pointing to "refs/remotes/origin/master" (and like yo=
u
> > can refer to "origin/HEAD" or "origin" from git-log, etc). Are you not
> > seeing that?
> >
> > We don't update it on fetch. That has been discussed, but there are som=
e
> > questions about when it should overwrite what's available locally. E.g.
> > this thread:
> >
> >   https://lore.kernel.org/git/D3HBD7C1FR14.74FL1Q1S9UCB@ferdinandy.com/
>
> That part we already have pinned down: fetch will only update remote/HEAD=
 if it
> doesn't already exist. So running "init && remote add && fetch" should en=
d you
> up in the same place as "clone" (although fetch will report if the remote=
 has
> changed HEAD compared to what you have for transparency). If you _always_=
 want
> to have the latest head you'll need to run "fetch && remote set-head --au=
to
> [remote]" every time.
>
> Something like
>         git fetch --all && git remote | xargs -i git remote set-head -a {=
}
> covers everything.
>
> >
> > There have been some patches in that direction but I have not kept up
> > with the current state:
> >
> >   https://lore.kernel.org/git/20241023153736.257733-2-bence@ferdinandy.=
com/
>
> There's definitely going to be another round, but I think (hope :)) we're=
 not
> very far off from finishing.
>
> Best,
> Bence



--=20
Caleb Cushing

Appointments https://calendly.com/caleb-cushing
https://xenoterracide.com
