Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDD21758B
	for <git@vger.kernel.org>; Sun, 15 Dec 2024 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734282562; cv=none; b=Xx5W/vOFrau/kc38MCObyCpxr87PobQvGFhD+OFhNW4G1hgKhQJbdsyAvCfKi6weuDr6hX+optRIRVWHUadDgqvM+uDL1WAJRKWEkyghkdP3mqWfaWALV2pA+4TIDP54hWy4DYGAxlyMNWmdNuviR/ztlHRI5xmPr95pWD4EbXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734282562; c=relaxed/simple;
	bh=hMVwQmaiWh8uf9cRwp/9CBfMHjaqIGXMqDw4Ywnjqqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpTgJ91LgSgGB6SxV5hmQztgaS/8c4JivfkA6+F8cD9hG5O7Sw2pBbdFkzkZdyWKRYOQpunQ8t7zt7ldJ9vukFBeAPrimok3ZyRkaR/x/iwzWCsA5FqTMMeZVElYQ4jopZPLTPFGUmzdSMTYuk9Uh2i2/mrAtl3gdQ7efKDkBkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5x6/+Ku; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5x6/+Ku"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso2260001a91.1
        for <git@vger.kernel.org>; Sun, 15 Dec 2024 09:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734282560; x=1734887360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMVwQmaiWh8uf9cRwp/9CBfMHjaqIGXMqDw4Ywnjqqc=;
        b=e5x6/+Kuec+J8Um5cV9qDtbUCQjgB92nwW5FoVg+jYxsWlAjUmnLNYydGY/VDeZuOV
         oaZdu54Ck4Ma5eqJkTqYfUAeD7aCvSH7YASeffHqfO1rn1YqfreaidmekX5yOd/0vJik
         xK8pXYGa2/Ne1IAWlS91RzF29ZuY/h2M2eVPTLGDI13uDUyxHPmgWtbvsXFbk++Yw5Qf
         nTnMGI+Keb80IbkznsccHOcrHj6PzgktkctA6LGCZpAEdPabUB58qxXxR0boWfVSCVT4
         RG/p/JCL+t7ViYyJzbeF7EY3BoM35GpxSJ9d9kEsgFqWyPoBVLbUq7BSdjvp0veJUKCs
         Hw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734282560; x=1734887360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMVwQmaiWh8uf9cRwp/9CBfMHjaqIGXMqDw4Ywnjqqc=;
        b=Ce0CoKqfYKUMaHZBPpA7Wk1gcCRsK2Bp0Wdd8hZOSnL5yUkIPcevbuizbaskM+xNpQ
         usSfGvBRoug3gb0T2TW6+913DOc0sRVfBGdTw2KzRkfbP1Z1yLUsNEFgzbkElLgs16kA
         c21j4l372nAZ01ARD2JFWyAm5lsNhVHKGMOYNoQC1RN/MQgqzwjgfL1+c8MeouE87ul+
         odCkygpRJVllAxS0WxeBy3FvZe0XKCoxRC3LjKAF84q07Q6rV9lg7D7bTdBmRl0ky5wl
         oHBQ7UVXqj5WNwvbZNCAO4bijK5tJyqwkP0py100WPDTZTd8xeXDSjsSIl+WaBWpTuG9
         yQCg==
X-Forwarded-Encrypted: i=1; AJvYcCU1fTBZmPXSZ46u5PdY0Mmqmf0h7pyWXvkADsl9P4QwGRNaiEw7UyGH8s6cHeOL4pVOjrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtmV6VhF0imDKUW7t0WVSfo/cmGYCRAdCLRRaAaQaK6WQ7R194
	d3AtURfc/6OQcCngOBWxLL3fpWvR7ikKLkMd3zmBUW4yOMiMG/BqXei5I3TjHLB/P+yfZHrykkA
	7CsGvNYcYstSgAv8kEn69O1nsY+Y=
X-Gm-Gg: ASbGncuoXHh1KzAJmyCWNiC8n9JVh5AGPXXuJx2Q528k32Z/j+Hyz+mWJiF/hRxQzjL
	YwyK1KMgThrT39QGo9xZrOCf9sKunHzHKxHcp2g==
X-Google-Smtp-Source: AGHT+IFVvcu8v48ZQ4Dzs3jNHBH2lbbm4MfFpweCwlYR7IwAEsaG4A1mkHTLAdLrHCuejxQElKyamwZxRgWgzcawh4Q=
X-Received: by 2002:a17:90a:ec84:b0:2ee:f80c:6889 with SMTP id
 98e67ed59e1d1-2f290dbce03mr14918442a91.33.1734282559463; Sun, 15 Dec 2024
 09:09:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
 <20220718173511.rje43peodwdprsid@meerkat.local> <kl6lo7xmt8qw.fsf@chooglen-macbookpro.roam.corp.google.com>
 <20220720192144.mxdemgcdjxb2klgl@nitro.local> <CANiSa6gou27CH-y8Yy7FX8xu2Kr66BM9ghvM9nDQkq0mkP0-QQ@mail.gmail.com>
In-Reply-To: <CANiSa6gou27CH-y8Yy7FX8xu2Kr66BM9ghvM9nDQkq0mkP0-QQ@mail.gmail.com>
From: Martin von Zweigbergk <martinvonz@gmail.com>
Date: Sun, 15 Dec 2024 09:09:08 -0800
Message-ID: <CANiSa6gwup5vXU235mG+Ybbc+P=SbwoNFEmuhg=iYu0yGvSXVA@mail.gmail.com>
Subject: Re: Feature request: provide a persistent IDs on a commit
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Glen Choo <chooglen@google.com>, Stephen Finucane <stephen@that.guru>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I just noticed that my message from almost 2.5 years ago got blocked
by the HTML filter, so here's a very late reply. I'd like to continue
this discussion, but maybe I'll start a separate thread later if you
prefer.

On Wed, Jul 27, 2022 at 1:26=E2=80=AFAM Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
>
>
> On Wed, Jul 20, 2022, 21:47 Konstantin Ryabitsev <konstantin@linuxfoundat=
ion.org> wrote:
>>
>> On Mon, Jul 18, 2022 at 02:24:07PM -0700, Glen Choo wrote:
>> > > I just started working on this for b4, with the notable difference t=
hat the
>> > > change-id trailer is used in the cover letter instead of in individu=
al
>> > > commits, which moves the concept of "change" from a single commit to=
 a series
>> > > of commits. IMO, it's much more useful in that scope, because as ser=
ies are
>> > > reviewed and iterated, individual patches can get squashed, split up=
 or
>> > > otherwise transformed.
>> >
>> > My 2 cents, since I used to use Gerrit a lot :)
>> >
>> > I find persistent per-commit ids really useful, even when patches get
>> > moved around. E.g. Gerrit can show and diff previous versions of the
>> > patch, which makes it really easy to tell how the patch has evolved
>> > over time.
>>
>> The kernel community has repeatedly rejected per-patch Change-id trailer=
s
>> because they carry no meaningful information outside of the gerrit syste=
m on
>> which they were created.
>
>
> Since I didn't see a mention of it yet in this thread, I thought I'd poin=
t of some possible ways that Git itself could use a change ID:
>
> * By allowing change IDs to be used for specifying a commit, you could do=
 e.g. `git rebase main <change ID>; git checkout <change ID>` without requi=
ring the user to look up the hash of the rewritten commit.
> * Can be used for identifying rewritten commits that still have descendan=
ts (because you would have multiple reachable commits with the same change =
ID). That could be used for suggesting which descendants to rebase to where=
 (a bit like Mercurial's `hg evolve`).
> * Can be used by `git rebase` for skipping commits that are already in th=
e destination.
> * Can be used by `git cherry` for identifying commits that have been reba=
sed. However, for `git cherry-pick`, we'd have to decide if we want to keep=
 the change ID or generate a new one. We would not want to reuse the change=
 ID if we consider multiple reachable commits with the same change ID a (so=
ft) error.
>
>> Seeing a Change-Id trailer in a commit tells you
>> nothing about the history of that commit unless you know the gerrit syst=
em on
>> which this patch was reviewed (and have access to it, which is not a giv=
en).
>> This is not as opaque as it used to be now that Gerrit provided ability =
to
>> clone the underlying notedb, but this still fails on commits that were
>> contributed to an upstream that doesn't use Gerrit.
>
>
> Yes, that's a good point. There's the old "git evolve" proposal [1] that =
may be a good solution for the problem of tracking rewrites across multi-re=
mote exchanges.
>
> [1] https://public-inbox.org/git/86d0spzoi1.fsf@gmail.com/T/
