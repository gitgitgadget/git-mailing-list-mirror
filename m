Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01582B9A4
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752599859; cv=none; b=lPc5i5aQeLXOMaS6aVd6Yfy9jnhyKPHTjyAm6tWwbktEx6aeMeqDPdIt8UwLYJw/e1fK6+IYmI68ytWQ2MDsU5YAf3o4KkcSJeGXRQBRNFW6WDaVzyz3lvF1mIP46j4MdljsmnE48TQKfTE9Camr5wLq+fbePU4Pm8ILRcgaPVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752599859; c=relaxed/simple;
	bh=q3kp+mO1n3Ked9zoRiRDAHPTBM4hRH+8xP+HNXuo4OE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vB15ORwEHpWveqMFLBTGP7lUv7SgbDYHca2wzJajhtrCU0zAgTftDZh6unLP+VBW0uhBgyaHHDj2h9xJqB580kcNeglyUbs03BGv0cnAs1SkA73kXKKUcGdO5H5k9H8g0UW+XwZqm2enphqE0spB1esPN9WVUv4t1qsUEVL1m48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apd0jgUe; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apd0jgUe"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3df210930f7so397955ab.1
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 10:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752599857; x=1753204657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqWeVxemptccnS06GC9DqRkk/r8nTe+IaECCsyj7Fiw=;
        b=apd0jgUeZAPdpv1AnrVTVgggUsTIHRkpToQVMxWhx/E7E0lJuBy01g+FG8nQtSt7m7
         ExkVwuieAENmYYuHN2m/K6y1pEuadmain6Rv1CHHC/mTg6SGEouflQfaxLDuiI9gCu7c
         aVFm2C/KOieB0f4FuPQTvtW95TMoikT1VtoOO3Ce7GPWGBAKdZde7O/fno5iW0gRZr7T
         4zAp+OrG3QQ1bGUqlnoM9w11rkcwdrLuJKdejP8dHbCXwNwPBiTMWUFTepBwIRnYGUbA
         o6G4Z9b1X4fcz0TH9oVW3WZOKa28eFMg04fAuA27vd+6TJtTi1Egmb0IXRW9ZK2OtXpc
         fENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752599857; x=1753204657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqWeVxemptccnS06GC9DqRkk/r8nTe+IaECCsyj7Fiw=;
        b=iDgXY3Tj/nrq/Aym885j7tbAf8hvzuxaV2i27vmp9LlsIPsIoWIqeT1gdzQ7eFry/9
         TcwQI1i0SZw23yyHa9Eru+DRh1D6koXZLTfX4ehdeGaNZs+ARZavkC8JLTEQSX4gbT9u
         WI2gyepb0/o0Dtespsq54JoTeo7RDNxk1ND/cL58bmC1pZiW66vrnRa3GEuqge6/iC2b
         35RwuhZI9ZEKcT5iRXHAOHhSJAL6J/Uu4t8+g8oxqdrvxAozpqYitpd59VdgEwHOKU9K
         bAZcL6/cAwlZxB5AigiayAf60oPD1UytBd7Xa1FJV+CEwQPvvAArySe4xksj24gx/UWb
         v8Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVUk/7mSZ5EKzdKeUysC5DJbyFQr2ESA59xTX8KDRpVT5T1u9muO3Kr3vU/Cgy6SKd2+ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwyegEhpkFZyFHkjfZ9TMMCU+HAVx0sxuyH6H1F76SE1xRtI93
	iQn/UqGlAW5upx0DK1zbuY6uC4RHiayrjca6oPBRUPGwnRIFsFamPaAMbwFYaT9foX5wo1KOrYJ
	uesx47RoFl5Y6STMGomsNRE28QptkhVk=
X-Gm-Gg: ASbGnctyU5L6BOqyIQIH3/ZFA93HyerZeVN1WhN2k7qaSaH44S+n05TB7Dh2sefipPr
	QiikUUievhbmxXjyKJw9zGGM4bMD+GiPNeaVXRONRCbMIA3rDRjjYySVjSEjyPb2tXHVZl6DFOi
	KyIQAt5tS5/FmklDLnMHlZO66lMNP73edl1lyGndoBA+gR8T4I0UTgDaWWSXZkMHebj7vsoYKtF
	pTh+n7oXy5ruHg4R1Z4eiBWXRmuOGa7frrYq28Qjw==
X-Google-Smtp-Source: AGHT+IEZUbFFahRYLmW7OkgMHJrtrfe0L+4qWTWkHePAsTFtdnJigCSKom8hpto5UHbyAgTUayJ2uP1yAj9wHcUmVZk=
X-Received: by 2002:a05:6e02:4510:b0:3e2:8159:ab81 with SMTP id
 e9e14a558f8ab-3e28159ad51mr6935835ab.8.1752599856694; Tue, 15 Jul 2025
 10:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
 <49418e8ec8a4c3e0ce9c65aa700042b6f3f3f4d7.1751973594.git.gitgitgadget@gmail.com>
 <CABPp-BH_JGbtDsne_tKBoqDr9LzL==gs0E5xyPdbqygyXs8+vA@mail.gmail.com>
 <492244b9-2402-4e8e-8599-8bcd5d27e2f8@gmail.com> <CABPp-BFO3Mx9LHPxjbdm2ayvfs2gx9nC9vJnW=zuARgCYrQzNQ@mail.gmail.com>
 <1af54798-12d0-4ff4-978c-254d9d0312b6@gmail.com>
In-Reply-To: <1af54798-12d0-4ff4-978c-254d9d0312b6@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 15 Jul 2025 10:17:24 -0700
X-Gm-Features: Ac12FXzlIO0-zn3SvfCQ-OCXFKc8Vlm3OgIu3ZEcr4WiFIpsian4OU-sAt1Xn5A
Message-ID: <CABPp-BEROPjoi8DcfCoPX+2GoS2eysdZK1eiMO3=knYz5VAnqw@mail.gmail.com>
Subject: Re: [PATCH 2/3] sparse-checkout: add 'clean' command
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 6:38=E2=80=AFAM Derrick Stolee <stolee@gmail.com> w=
rote:
>
> On 7/9/2025 1:35 PM, Elijah Newren wrote:
> > On Wed, Jul 9, 2025 at 9:13=E2=80=AFAM Derrick Stolee <stolee@gmail.com=
> wrote:
> >>
> >> On 7/8/2025 5:43 PM, Elijah Newren wrote:
>
[...]
> > Right, for cone mode without the sparse index turned on, this new
> > subcommand seems to be a silent no-op (other than burning some
> > computation time),
>
> No, it works without the sparse index off. The sparse index config
> is about whether or not Git _writes_ the index in the sparse format.
>
> This command works even if the sparse index is not enabled for the
> written format, since we can manipulate the in-memory index for the
> purpose of discovering which tracked directories should be sparse
> and thus not in the worktree.

Ah...manipulating the in-memory index despite the sparse-index not
being enabled was the detail I was missing.  Thanks for explaining.

[...]
> So your concerns here should not be a problem, since the command
> _does_ do the expected action even if index.sparse=3Dfalse.

Yep, thanks for straightening me out on this point.

[...]
> > If someone resolves the conflicted merge or rebase and commits (long
> > before running this `git sparse-checkout clean` command), what happens
> > to those paths?  Do these materialized paths persist in the worktree
> > after the commit?
[...]
> I have a TODO to add test cases around this behavior, so we can
> have concrete expectations. I'll incorporate them into the existing
> test cases around merge conflicts.

Thanks.

> This may be another example of Git leaving files around that should
> be deleted in order to efficiently work with a sparse index.

Deleted...whether or not they have unstaged changes?

[...]
> One thing to keep in mind is
> that the SKIP_WORKTREE bit does some amount of ignoring the worktree
> by not modifying what is there, and that may include some issues
> around reporting the changes in 'status' or staging the changes in
> 'add'.

Not sure I follow.  SKIP_WORKTREE bit will be cleared for files that
are present in the working tree before 'git status' or 'git add' ever
perform their core logic (due to 82386b44963f (Merge branch
'en/present-despite-skipped', 2022-03-09)), so isn't this point you
raise moot, or am I misunderstanding something here?

> A lot of your concerns seem like they would be satisfied by providing
> a verbose file-by-file output of what would be deleted and potentially
> having --dry-run be the default mode.

I think that'd be helpful, but primarily I wanted either the commit
message to explain why tracked-but-unmodified files and
tracked-with-unstaged-changes files under the intended-to-be-sparse
directory aren't expected to ever happen in practice, or for the
manual to explain what the clean command does with such files.

[...]
> > Oh!  Based on this hint, I went and looked up the code for this; it's
> > from convert_to_sparse_rec(), right?  I see something interesting
> > there; does the present-despite-skipped checks (from 82386b44963f
> > (Merge branch 'en/present-despite-skipped', 2022-03-09)) cause this
> > collapsing to also fail for unstaged entries?  I.e. this part of
> > convert_to_sparse_rec():
> >
> >                 if (ce_stage(ce) ||
> >                     S_ISGITLINK(ce->ce_mode) ||
> >                     !(ce->ce_flags & CE_SKIP_WORKTREE))
> >                         can_convert =3D 0;
> >
> > The `ce_stage(ce)` part of it is what prevent it from collapsing when
> > there are conflicts, and I think the `!(ce->ce_flags &
> > CE_SKIP_WORKTREE))` would prevent it from collapsing any tracked files
> > whatsoever, whether modified or not, due to the
> > present-despite-skipped checks.  Does that sound right?
>
> This matches my expectations.

Cool.

> > In other words, perhaps your clean command as implemented really does
> > only handle untracked and ignored files, and if the user also has
> > tracked-but-unmodified or tracked-with-unstaged-changes or
> > tracked-with-staged-changes then this command won't actually restore
> > performance for them until they _also_ run `git sparse-checkout
> > reapply` ?
>
> Worth adding testing to be sure, though I believe 'git sparse-checkout
> clean' would help if they stage any changes (resolving conflicts, if
> any) and commit those results. The files won't get cleaned by 'git
> commit' but the clean operation should work after that.

Wait, what?  Doesn't this contradict what you just said above about my
explanation matching your expectations?   ...or by "work" are you just
comparing to when we previously talked about how the clean command
would abort early when there are conflicts, so by "work" you just mean
that when conflicts are resolved, the clean command will then "run
without aborting even though it doesn't actually clean up these
tracked files either"?

[...]
> Thanks for the careful review of these fine details!

Thanks for working on this series, being willing to dive into these
details, and patiently explain stuff when there were details I
misunderstood!
