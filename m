Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8611D5AB5
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744660478; cv=none; b=sJ7u7XX7yaBo8MdjL2+oZRP5dyLHXRBLLafQ0un4eoodHwRfabJUW7Ost9jVvARzXID8yImcyJXr6dQ6oTLqrclAOlPMCcI6X+deQ1YA+1UgWssX6eMVop5m2h8k63pdcukfMoBZM40BEARDzXQ+mFBxPHL76MT0zyMzJhBCb2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744660478; c=relaxed/simple;
	bh=vDSq2nxSrKsWkcyXxvlsCE2qJwagj3Ts6m8fW/UvK+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EqaXsaOQYlihiEuTGwcXvjQIZxATSYiwzpaGATPa9f+D0GiMrF5OlNupKMs9JZ3qJB2xwFI/RCUEa6T/suwFKRlCm5QK2kdIR7JluDiMvfo7XqFBCpvRC6VNI73V2dpYZ9t6guvYVi08gcyxKSNm6VKNNiGch3k+hcQNmmj9r7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBypElEa; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBypElEa"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so7274175a12.3
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 12:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744660474; x=1745265274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SPuEH/FQnM+bVIc7CLP3gcCuxFQg0o+r4N1H7NfeEI=;
        b=lBypElEavxa6us9wnBKttPMb7E/8zOU6ANer6/sHNdMA2xBed713vSGj/yR76vtkca
         UJZkRNa985Dj12iF1PTburcpVjAHP/a+I4g10CzecXBlOVdJ063pdEgKzwe6pSmGMlFI
         nLBPphSMFgrjM40BPoK9n15dQXjW/HyJzcE/UsYg3dChIHkeqhxys36cTVfVzBhvdbGg
         +QoX/n4uFsqdHQoOdwNC/bJBWz8SRqEb9s+E4jYzYRLxo7ybQom0UvoU21i0s248b2P8
         QDpW79smBKDZ/eTPLDva+rLa9wEbxIE/43f+xSKqzOpy60flOCTViBwmrL7tTHZAAOVM
         o0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744660474; x=1745265274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SPuEH/FQnM+bVIc7CLP3gcCuxFQg0o+r4N1H7NfeEI=;
        b=mZHtCySeGtQarUqH2VctqxvPy7I26KgX3LuwUfNUc+odZoYT/34kLf0nOolg/dpBoj
         45ryFLk/YGdn9iAn/8KKojtwcqDeFWsGq3xiJYJk6dVWA1iqaEhJFceHxxRKsX/zotZj
         fj5h4CDSDmq0/BaVHQexgTRh8PodwRwG59lXbBAL7ThpSWB2c0Fn/tz/dz4dT3fxVCNy
         /5lpgpLGwMK83TdAL5E0cvRKEWk+D72DjkzJarFhVchXrkowXXWrLQp/eutHSI/jpD+d
         rHZO5m5PKlzjfS3lEBZcOAEDImgS1+9mVWiS1S63kV56AlBQQcrPtaOoiR4rdBL+dRTv
         NHWw==
X-Forwarded-Encrypted: i=1; AJvYcCVKTRz7RNa4MMdiZPhGSAmoL4Wi8/Uo/JNNUZ/vXEKuPxwgUpOQXD9GKJSpY6pP9vXSJJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUN9uicqQjv5/5ZBmyJjnEaIFPv1f/BfiQ8Ya7IgTj1BHH0bJU
	p7418fUDFXqKT5CpnZcpMb4Ayop8UjKR4DgBqJWx6xOEEM/JtuO+2hAEoWuE9GHcM7BJc+KzgnR
	pk310ANQweu6l4jWludkFHCtY/10=
X-Gm-Gg: ASbGncsY25N73xaYLURkdlHvqPSY4zpEPJYmEI+ocia7X4XQErEDukgj9QzxWvLj9Yg
	PYJ0ghphX7tlQ4Sqq3EvYOPvBg5PlCMbAeVwdZjid2G+CMyZgFhscOnMGM1d27VpWLcY5FAFaGk
	pTGEe5g6Nn9LESYiXrwMTTKCW4nPLndftqE9GkaRww++7T5X8GF8LyT78=
X-Google-Smtp-Source: AGHT+IHfyjM9zSgg67yv31on2jn7Kxey4TIM6hm77jOQUjmCQoSlOPVo8L2yZDWJbdYcsTheCDab69GDLMHhtBMfTZg=
X-Received: by 2002:a05:6402:274c:b0:5dc:7643:4f3d with SMTP id
 4fb4d7f45d1cf-5f36f50b36fmr10652407a12.1.1744660474299; Mon, 14 Apr 2025
 12:54:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g> <Z/RFQY433muaCW44@ubby> <20250408125521.GA17892@mit.edu>
 <Z/VGYrrVZYQ13TLj@ubby> <20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby>
In-Reply-To: <Z/amMj/eg0RbXdkS@ubby>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 14 Apr 2025 15:54:23 -0400
X-Gm-Features: ATxdqUHa1TYG3weTwErKYVM9g6FSPsdEh1c3qhYQ9TO7xnpEWDXUXd26FbEjy-8
Message-ID: <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
To: Nico Williams <nico@cryptonector.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>, 
	Martin von Zweigbergk <martinvonz@google.com>, Git Mailing List <git@vger.kernel.org>, 
	Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev, 
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 12:56=E2=80=AFPM Nico Williams <nico@cryptonector.co=
m> wrote:
>
> On Wed, Apr 09, 2025 at 08:19:24AM -0400, Theodore Ts'o wrote:
> > On Tue, Apr 08, 2025 at 10:53:06AM -0500, Nico Williams wrote:
> > > I'm not keen on CR tools "intuiting" from.. similarity checks.
> > > [...]
> >
> > I'm not keen on fields that can have essentially random semantics.
> > Part of this is because today Change-ID is in the footer, and so
> > humans can randomly set it to any value they like.  Sometimes they cut
> > and paste footers, and so completely unrelated commits have the same
> > Change-Id which show up when you do a Gerrit lookup by Chnage-Id.
> > Admittedly, this aspect gets better if we shove it into the git commit
> > header.
> >
> > Part of it is because some tools will edit the Change-Id when doing a
> > cherry-pick.  [...]
>
> I was only proposing to leave some details out, not to have completely
> undefined semantics.  The particular details we might want to leave out
> are about resolving change IDs to URIs.  In particular this editing of
> change IDs on cherry-pick you mention has to not be permitted, or
> perhaps a new change ID could be added -- i.e., are these headers
> single-valued or multi-valued?
>
> Let's nail down the semantics of these change ID headers.  Here is a
> proposal to bang on:
>
>  - change IDs get preserved on cherry-pick and on `pick`s in rebases
>
>  - users can manually remove or change these change IDs, naturally,
>    though generall they would not
>
>  - the actual change IDs are either free-form or they are URIs -- pick
>    one, but if they are URIs they should be URIs to CRs, and approved
>    CRs should perhaps have links to integration reports etc.

Using URIs [to code reviews] looks to me like it makes some
assumptions about what creates or consumes these headers, right?
Especially since the URI should point to a code review=E2=80=A6 Is there a =
way
to do that which is downstream-agnostic?

Further, and maybe this is my ignorance of Gerrit showing: how would
you attach a URI to a local commit when authoring it? You don't have
the review URI when running `git commit`, do you? (Maybe I
misunderstood; I'm seeing an odd chicken-egg problem here.)

Which begs another question: what/who applies the initial change ID to
a commit and when?

[=E2=80=A6]

I've skimmed most of the discussion, and I think a unique ID for an
in-flight series could be useful for ergonomics and to support more
tools that link between versions of the series.

Re-reading the original post [1] (which didn't mention this kind of
ID?), I'm having a hard time seeing the problem statement. There's a
lot said here about the specifics of the solution, and some other neat
things it might unlock=E2=80=A6 meanwhile, I'm wondering if all the
consternation about change IDs is because the problem being solved is
underspecified for a core Git feature? (That might tie to Ted's
initial concerns about semantic meaning, on which I think I concur:
the parent and committer/author headers have unambiguous meaning to
Git, independent of anything else.)

It looks to me, an outsider, like the problem is some combination of
"I want to track a commit's evolution" and "I want to see related
commits in review, esp. when it's an identical and already-approved
commit." But I might be misreading, and clarifying the problem
statement might help bring us to a better core solution?

[1]: https://lore.kernel.org/git/xmqqh62tm5fo.fsf@gitster.g/T/#m038be849b9b=
4020c16c562d810cf77bad91a2c87

Cheers,
D. Ben Knoble

PS This discussion feels somewhat related to the classic GitHub
problem of not presenting interdiffs/range-diffs: GitHub shows a
too-flat source diff on force-pushes. Perhaps better web UI tooling
about interdiff review (which I think is one of the things Gerrit
does/wants to do?) makes change IDs less necessary, since interdiffs
help connect evolutions of commits?
