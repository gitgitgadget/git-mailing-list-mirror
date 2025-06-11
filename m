Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011B1D299
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 13:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649596; cv=none; b=rTtukLlyZ7Zb+WY2q/O2FP31n4txQTx1oKAXkmNL5fSL1iu22TXydNMKpIlUaSn/gfYQVmvotC5rANOxBsM9AzxsterwYZgK455dmfeIw402kFwDAdcJWAIU9L84FPcyujbopmlDURygzbe5I3iW+yznsgOJ6Z629XJA/gOxsHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649596; c=relaxed/simple;
	bh=yPZyKr+Qv2vRvapSXHd33B4vGWgUp+fpCd10FMQey2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DiS0IV+5mgSeDl+a7W3JA+f6rfsoORjDkKTLdtHTcS8g/g9SwA2eK4Bi8iLOQOzbwFIutcovj/g1xIGLLf1jO71D59/9J+xQpF34g8f23OeOmx7fSZj7FpyheEnZFtPPrfErPIDXU+YsfeRks5mhVlgpQboARadhTTGdzjcHh24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TV0N9jBr; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TV0N9jBr"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-adb47e0644dso185126566b.0
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 06:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749649593; x=1750254393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdriCglUQoXkFLi4ZhMZiZhhUAR8uA7bFXNWHiPueC0=;
        b=TV0N9jBrMY8pkexUNthAyGXmjitnD/KpuA5/Ly+Gri38s9QbCavg0kCR5goecee2CT
         45pncqQyUqOHpoXIqS7v+2EekEMcnUz1PU1rqwNvKnag1JATEX7FeEJbT+PlnTPYp/I2
         0uCY+Ta5U9OOhThUiJ+ahKsl09r5zZhsrEUwijKwbfYNZ7KObqkdLmb2Qub5BCT3EPlg
         KXrMbu3p/sj5LoY9y4EJMullYn/MCne6YnNBzAMzsmBNV+pKpTFmSXbKBBVVltrnWdy6
         Gck07x2sD1eKyyhH3T03hQUH4NWoVena4RwMH+Xx4TMGwzOY9cxx4vJ2F0TCk8qzUKiP
         I4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749649593; x=1750254393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdriCglUQoXkFLi4ZhMZiZhhUAR8uA7bFXNWHiPueC0=;
        b=rEx4b1XRpMo6V+5mFfzInm15ovhqpO45nm1T0hJ2YD8KRlpb6DUrdxthRb+teF0gSF
         8CWvaphBEMHdZ37ZlMVrNtBSwyVW7YshqU7CCL7s/DpND4fEb8quZWwVl0Q9pK12rYm0
         Uf5jm/a4vOf9Z4V4XVTns9roKIAMna695F7AUa6ntC2mM5BmunAooE+14pnfPFll9c8V
         3bjJc55gSUubNU/jdIR4xuHCfOJWAvZI+mV1QlxQM0tqfZ7b8yW1KiQ6lAMRj4PEyLR2
         j7nb2ydjX5dUCNX6Qmx/K4JHTde/r21ZidxLetXTXfJoUxjWV4Ld94nP0Cq1eOOtjdXC
         w4Ig==
X-Gm-Message-State: AOJu0YzeK3gYObQ5tuCbl0GPvGJkg0y5C5GW2CNgrJNp2CMD9DySZWT6
	s4qBadaCAQeQwP+OHGe1xR91HmUuhUjfMglpiJVxSHzAPOuT3JYXTUGFSrqK0yDjFqEGy7+RgeO
	L4NpgdPlaYYwCcFB5dGJQ121in5cr1J0=
X-Gm-Gg: ASbGncuOjf8yGKcny5A9W/Ea2bXK/wnnJi/L2wbPH7KPDKZJzaZvKD+rjXYPVAjPm1b
	tXj1cXIjW5s6TOaFRH8iqdSHGYXVnGpw0jKn27PbCyMG4b1VViGa5kcllRRz8vf19YeIv8aFl26
	X9W/vNiHj3G55l+KkSG1fLhY8pyLQaWdZWim950pji1yXLYQ==
X-Google-Smtp-Source: AGHT+IHeoDY5r4ucc+bxCJqUdexKKGr/UfCm0PZHaLqNaDsFBW4ksBs3kE9uF4DfBadbbEDDpV8YvK+n/uOhiofJw70=
X-Received: by 2002:a17:906:eecd:b0:ad8:89c2:423f with SMTP id
 a640c23a62f3a-ade896e60damr327045466b.7.1749649593088; Wed, 11 Jun 2025
 06:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414160343.2216312-1-christian.couder@gmail.com>
 <20250429145243.992252-1-christian.couder@gmail.com> <20250429145243.992252-3-christian.couder@gmail.com>
 <aBsZBytP6TzMYCxl@pks.im> <CAP8UFD1+c11JgSKzs=A39-5EP2Senob-NxSXB7orU0usSLT83A@mail.gmail.com>
 <aDVu4JmTU7Wz32Z7@pks.im>
In-Reply-To: <aDVu4JmTU7Wz32Z7@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 11 Jun 2025 15:46:20 +0200
X-Gm-Features: AX0GCFtNl0F56hYRmBWohKclKpfYtYc72bbMF9eL5shBOhKqIOsrN99z9c-S8kM
Message-ID: <CAP8UFD3necac4PBYYN1ubss3h0T6fgFx=HO8S0F+o4haFFU6vw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] promisor-remote: allow a server to advertise more fields
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 9:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, May 19, 2025 at 04:11:18PM +0200, Christian Couder wrote:

> > I am not sure I understand what you mean. This promisor.sendFields
> > config variable is for the server side which advertises remotes. The
> > server advertises its remotes (if it wants to) before receiving
> > information from the client, so it cannot know what the client
> > accepts.
>
> In the current form you need to reflow this whole paragraph every time a
> new field is supported, and it's easy to miss the exact supported
> fields. So my idea was to maybe move the supported fields into a
> bulleted list. E.g.:
>
>     promisor.sendFields::
>          A comma or space separated list of additional remote related
>          fields that a server will send while advertising its promisor
>          remotes using the "promisor-remote" capability, see
>          linkgit:gitprotocol-v2[5]. The following fields are supported:
>     +
>     * "partialCloneFilter": contains the partial clone filter used for
>       the remote.
>     * "token": contains the authentication token for the remote.

Yeah, the doc uses a bulleted list in v4.

> > > Furthermore, should we maybe refactor this to match the restrictive
> > > design where valid fields are explicitly specified? In other words,
> > > should we have separate config keys for each of the accepted fields n=
ow?
> >
> > Maybe I don't understand what you mean with "accepted fields".
>
> I think I had a misunderstanding on my side. I didn't get that this is
> only configuring field _names_ that we'll end up sending to the remote
> side. So I thought that the user is expected to configure name-value
> pairs here that are then sent to the client, not only the name.
>
> I guess this is mostly because the config documentation talks about
> "fields", but that term is used elsewhere to indicate a name-value pair.

I see. I have tried to use "field names" instead of "fields"
everywhere it makes sense in the v4.

> > > Does
> > > it mean that this promisor remote should only be used in case we do h=
ave
> > > the exact same filter passed to git-clone(1)?
> >
> > It's up to the client to decide, but yeah it will likely work better
> > if the same filter is used. It should still work if a different filter
> > is used though. In case the promisor remote doesn't have an object,
> > there should be a fallback to ask the main server for that object.
> >
> > Also the filter mechanism already exists for a long time and this
> > series doesn't change how it works. It's already possible to have
> > different repos using the same promisor remote with different filters.
> > So documentation about what happens when they do that should not be
> > specific to this patch series.
>
> That's fair enough, but spelling this out somewhere and drawing the
> bigger picture helps the reviewer understand the vision that you've got
> here.

Ok, I have added the following to the cover letter of the v4 about this:

"Note that the filter mechanism already exists for a long time and this
series doesn't change how it works. For example, it has already been
possible for a long time to have different repos using the same
promisor remote with different filters. See the existing partial clone
documentation (like "Documentation/technical/partial-clone.adoc") for
more information on partial clone."
