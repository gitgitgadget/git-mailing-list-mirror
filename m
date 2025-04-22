Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C41297A49
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 20:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745353038; cv=none; b=Qzavxy8GjNk/kgQkWoc1Fb3/H+c5V1gSGgtD0h/bzf3DbqzIlPYqeIoL963pcOsEvkRkoeCYVt75wYTxVeMMKCG+ogT598d0xrGyulEP79IUPBUWgwnY/Y4ONGWQPYx9TNzt4/q2cicNVWtQg51/j+qE/ZU9cKmBbzQ6e0hPqXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745353038; c=relaxed/simple;
	bh=zlHlNFObEubwCbGdy8pRZV+5a5SZ/dT/GumKqFCA/08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGZkJdRiQc6VV5DX9VA0InX3yUf2h5OTJ5H9UHu5bxzlwPP13VRcJiFp/z1VSfVnJzOp3TeFAh4hsxbl0Ztia70jBvMHEmtWZ8c2PxLVIa15XcEcedwN+z1h+CQMg87QCwvM3rjb4TQeYDRa/z8qdkHsosMIL/Y6lEbOKFhuXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COla+lWF; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COla+lWF"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5f6222c6c4cso7772569a12.1
        for <git@vger.kernel.org>; Tue, 22 Apr 2025 13:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745353034; x=1745957834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOP4ZycpkHGmNicxcmysrMkRcoPkpl9/OIUdMjG/dF8=;
        b=COla+lWFWdao/bbNs9ASXnL54Lf43VrGq+W5PHvE950/Zp7JA6GSN96pVsigJa18vt
         7NmXqeYnoovUEeruXc5bNwH+S7OEsfQzyhfM6DibjlcnlL3cQSSqftkISNpbLbvB167V
         G1zS3dL0WSf8REtFcqn4druHGvTPKm6Qpc2PBwI+NElIJRKeXz4VaeyltZsxN4Nc5DuF
         Ai1XvntxAVJIjgh0I7c0L/YKTfFxMyCUAaoQ+xx4hOLC3GUhCT4MID1zdi/kqOh2hsMT
         VDXN5muHoLW4V5wtnN7VlUi4/MmHqThiPTqk3j827gVl9s7GoLamWxE6a0JWNG7TZl6b
         bQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745353034; x=1745957834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOP4ZycpkHGmNicxcmysrMkRcoPkpl9/OIUdMjG/dF8=;
        b=HUwDtSz7WAD+qfyT8nLj6AUipVYIZB19X2RuD2azrEUHxCmslJiX5cG5GKrYpoX/M5
         y2z1nTviszFCvO1jFjaTeRCM/IGnoGR123RO+D0TrACFBvjh07LwL7yl+tHbqaUHezzk
         jAOtSqUlSGFncRUJIAzIU0in371L4TiKMHnpgvY5jjbpNg/u28NyKEQ6x5e/9XJo0St6
         FxhL80E7rpZyrWPliHDN5+efbRw3GWnjWwQhVAQYqadR6ZwdGfAqvjHI8tSII1VAGL77
         h5pqsm8Kl4RripBHBGDKgNbbRBdycg4LfZUFyrI9kB5FoOHihMLv9p1R32HX5JD/zL4t
         Gw4A==
X-Forwarded-Encrypted: i=1; AJvYcCUPCnAbsDy4QTefSFF0oooxCXAnidOOtVjXuRzwEVMsA5sInzdTziO1yarS62HcymjNKak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXN1DB3qhWZqlNNbcT6LFboG8vM4Z5aHwhIHKZDxYxR4estgb1
	A25aRG214nD8+g1QAxsYLG1NyjFG5QSnF+3acojcD9ejMFOC+z8m+JFRH+j/B57ubGpXsUMetJG
	HM8MpSs1vuugtdsW7SQJ7UmK0hsc=
X-Gm-Gg: ASbGncvNTlJo7KR5JhZ6q0k02aebtQKbwZm7rijusVHCSB5R1fOk8mkgj+E6Q5J2feN
	/oki6KR8loUHEO19VPRxz1mnY369CaxSrzCEt3Bt3FXTIPtc/o2ztE5RIHugRzzkzILTT9B67Bm
	E3Gna4neQXapBkpLDK0S5X7gWDS3+eJEYX9xiXi6mWH3LhUbNUUEsxq/4=
X-Google-Smtp-Source: AGHT+IFawLlhbEGOz3NihKJJoWtf2Y/I+mbX+W20DQ6psew1be2D+lHR7s5bsqur/atVZ39Y7FS5W/hqz6BPZUN80oA=
X-Received: by 2002:a05:6402:2111:b0:5ec:c990:b578 with SMTP id
 4fb4d7f45d1cf-5f62855ada7mr15234368a12.19.1745353034293; Tue, 22 Apr 2025
 13:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g> <Z/RFQY433muaCW44@ubby> <20250408125521.GA17892@mit.edu>
 <Z/VGYrrVZYQ13TLj@ubby> <20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby>
 <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com> <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev>
In-Reply-To: <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 22 Apr 2025 16:17:03 -0400
X-Gm-Features: ATxdqUGg4duAo_M8wpRD7MAG6PCWcP2gui9ALfFvtCaAH24XVCXcTroK9hKTdIw
Message-ID: <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
To: Remo Senekowitsch <remo@buenzli.dev>
Cc: Nico Williams <nico@cryptonector.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Junio C Hamano <gitster@pobox.com>, Martin von Zweigbergk <martinvonz@google.com>, 
	Git Mailing List <git@vger.kernel.org>, Edwin Kempin <ekempin@google.com>, 
	Scott Chacon <scott@gitbutler.com>, "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 7:36=E2=80=AFAM Remo Senekowitsch <remo@buenzli.dev=
> wrote:
>
> On Mon Apr 14, 2025 at 9:54 PM CEST, D. Ben Knoble wrote:
> > On Wed, Apr 9, 2025 at 12:56=E2=80=AFPM Nico Williams <nico@cryptonecto=
r.com> wrote:
> >> Let's nail down the semantics of these change ID headers.  Here is a
> >> proposal to bang on:
> >>
> >>  - change IDs get preserved on cherry-pick and on `pick`s in rebases
> >>
> >>  - users can manually remove or change these change IDs, naturally,
> >>    though generall they would not
> >>
> >>  - the actual change IDs are either free-form or they are URIs -- pick
> >>    one, but if they are URIs they should be URIs to CRs, and approved
> >>    CRs should perhaps have links to integration reports etc.
> >
> > Using URIs [to code reviews] looks to me like it makes some
> > assumptions about what creates or consumes these headers, right?
> > Especially since the URI should point to a code review=E2=80=A6 Is ther=
e a way
> > to do that which is downstream-agnostic?
> >
> > Further, and maybe this is my ignorance of Gerrit showing: how would
> > you attach a URI to a local commit when authoring it? You don't have
> > the review URI when running `git commit`, do you? (Maybe I
> > misunderstood; I'm seeing an odd chicken-egg problem here.)
> >
> > Which begs another question: what/who applies the initial change ID to
> > a commit and when?
>
> These are all great questions, which the originally proposed format
> (fixed-width reverse-hex) has answers to. I think a URI would be
> strictly worse.

Well, I think we still missed "what/who applies the initial change ID
to a commit and when."

But the treatment below is something I agree with and failed to
convey, I think: namely, URIs seem to encode too much
"unportable"/"specific" information in Git. I feel like the current
design is not really "tool-agnostic" as much as "built on a universal
core." That seems valuable and prone to more longevity.

>
> * Using a reverse-hex ID makes no assumptions about what consumes these
>   headers. There can be multiple different consumers which treat the ID
>   differently with different URI schemes.
>
> * Attaching a reverse-hex ID to a local commit when authoring it is
>   trivial: you generate it randomly.
>
> This is one of those cases where being maximally restrictive about the
> format will enable maximal flexibility downstream.
>
> One example: GitHub has a URL scheme that looks like this:
> github.com/org/repo/compare/<ref1>..<ref2>
>
> This doesn't work if the refs contain slashes, as branches sometimes do
> (e.g. feat/foo, username/bar). If the change-id is a URI, this type of
> URL scheme doesn't work reliably.
>
> That is not to say we should design the change-id around GitHub, it's
> just an example how making the format more free-form (URI is more
> free-form than fixed-width reverse-hex) makes it more difficult to get
> stuff working downstream.
>
> And lastly, laser-etching the URI scheme of one particular tool into
> your commit history means the history is at great risk of degrading
> over time. URI schemes change, domains change, tools become outdated
> and are replaced.
>
> Adding some ephemeral configuration to a tool that constructs a URI out
> of a reverse-hex ID on the other hand is trivial.

Yep.

> > PS This discussion feels somewhat related to the classic GitHub
> > problem of not presenting interdiffs/range-diffs: GitHub shows a
> > too-flat source diff on force-pushes. Perhaps better web UI tooling
> > about interdiff review (which I think is one of the things Gerrit
> > does/wants to do?) makes change IDs less necessary, since interdiffs
> > help connect evolutions of commits?
>
> I think it's the other way around: Building a code review UI built on
> git and centered around interdiffs today is _hard_, that's why we don't
> have it yet. Adding change-ids to commits will make it much easier,
> paving the way for these tools to be implemented.
>
> Remo

Fair point, although GitHub's detection of force-pushes makes me think
it could split a PR into versions at that point, cross-link backwards
and forwards by one version (from the force-push detection), show
range-diffs between versions based on the target branch of the merge,
and even follow the cross-links to show an overall sequence of
versions.

But I don't work there, so presumably it's harder than that :)

I sincerely hope to make it easier if it's really that hard! And,
though my opinion matters little, I'm having a hard time piercing the
conversation to see a "universal core" that solves the desired
problem. Maybe I'm not reading carefully enough, and maybe a summary
would help. I greatly appreciated the work of previous folks to
summarize the current thread status.

--=20
D. Ben Knoble
