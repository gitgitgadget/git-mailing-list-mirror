Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098811E9B1D
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 06:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739257004; cv=none; b=QqQl1iBpxmGqsd1zpYlvwdvWu3xq89e6qT/r7y4JdFaMsbivKbN+9+0VLiB/2ZRlnPkdCtCMF0PibDSeQOFzs687RYEk8/PP9bhtfNUVvUY00cGZzqWsn3a7RlUMaboUQBR1IJeaON4XabmXyZZbbJ2vjU9HE0U2W5lGBFE4kiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739257004; c=relaxed/simple;
	bh=vanoeJ/gf1NUVWPsrZ7HQtOfPOLIF+4hGjB7xEZttBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYycqfPH9qJ4O97zTrhX0tkPjCeDYDklrCsGnPbgoMvjQX27NX1yd4TMRVpDxFrBqdkrIJxnfA3iU7K21MENPqaxb34iGUTQgJyFBXJm7krw+UspKO4dLew1s48q8r773V7PaDpOVwS9Ajo+r6Df8oFujHHWWQ8tjsn4ftNzbeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNfkLLIz; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNfkLLIz"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e4419a47887so4084997276.0
        for <git@vger.kernel.org>; Mon, 10 Feb 2025 22:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739257001; x=1739861801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vanoeJ/gf1NUVWPsrZ7HQtOfPOLIF+4hGjB7xEZttBA=;
        b=XNfkLLIzB8oKcJD6f86LI+hz8eFIQbkyM0QEZjK9JCMOdqjR94djj3MNg7PctgAlv0
         0FoxNbmlAe0U5jvB9UKN34ajSiWYw1JbeENd6qBdm1csc810DPZZlCppV96Y9kAD4sN9
         w9CnHdQ9/b2ZV/yTchUXB2z0uK4eU6BkfPj7yeFCA0xnMrxAbKmNJyw6zgd8dJf4Ebm5
         VhW8dLoTnKPAhhj6bwDRedgWqZR6wTwmEvR0M8IgyuiOV5KsPWoELm70jPxEfpnPcIRH
         fkLUiH2PLki3kSwkGCR/WCF7OFOlFyQu1HrS9DMtAIMlLLw3b09iGtI3zEQMDJCLR22V
         UKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739257001; x=1739861801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vanoeJ/gf1NUVWPsrZ7HQtOfPOLIF+4hGjB7xEZttBA=;
        b=sBkQEOVcVJQwSCzy2fliXf4jlDMBytJxq2orOQyYOiMbRGfpf9z0f7y+3vq9U/NdBh
         SG0lac2aM+F6ykY4pVa376JFafonh3M+pDFnfpa5Fj8qth7QEXWPWhuKZhU68b4233j5
         cUdIGSaNQ3n7KJbjm97rjiKf7rGwqnlKJ9sFQmStmU7m4CBVlWS0O/X462lbvYCgGR4T
         3qEubTThraLt5XZvVGQLlymwZDS+im/M+rL3YdK8g3fNg+N5MkQWY76I0Y+nfQKLtpdM
         GjXOUvggugFC+aL/DC9ML+P5Isuge23nhR/K1apxHCZOIyLtB5p8dc3HBtBkMMKZFHtf
         EMvA==
X-Forwarded-Encrypted: i=1; AJvYcCWhIj1uzHh05895E8N2cKG7im2hugupSguukuV01/gnHbW9YS6H4kd2IVY+b5ppPr/BDQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPlDTVDE/ozgycSxGIYMi+FNsU4DkX72Tmznu/L+A/1I2pVmn9
	6Ck0cO6Iyf8tzNKTAx0LtmZdf1I5PMMzC8fQ9TDQwMuNnMkTNStjKX52Dz5BsHjTptVPMagg7XM
	UdppOc/7S8yuU2HXji28DnQEHMag=
X-Gm-Gg: ASbGnctgvhdxBEAEzmEcCOVl/GCS101mI6z0mKccnzN4Xh4H9hX4mivlMP5zoEzSElG
	1Ts9VLEd4RUlbA6zNA9vI9nxDPwNtyA8t982J1qq1Qksn6zZ9sK7Yr6d0cvKl6NLRId8WUR0rGO
	wonl/FKX7J7tUbMz1njA/WjLbXSlg5
X-Google-Smtp-Source: AGHT+IHZNBBqJJeH2pSYcssvTKZyHB8DsTVYPntBRSN7gl0K3Tcu5+61jj2dCxm5RNFLkifkIEZVQIkyzO8KSyGgcAA=
X-Received: by 2002:a05:6902:3487:b0:e5d:929f:773a with SMTP id
 3f1490d57ef6-e5d929f77cemr3656788276.25.1739257000967; Mon, 10 Feb 2025
 22:56:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205030642.95252-1-ben.knoble+github@gmail.com>
 <xmqqbjvgr11y.fsf@gitster.g> <CALnO6CA_vF4huxMx6jSS4SVjS4+EO9K16Msco-vMUDzSoYRDOg@mail.gmail.com>
 <xmqq34gsp9tr.fsf@gitster.g> <CALnO6CC71A_Bn+RhyXfmhiNCn2vFGJ+WCs8+dAnpQvGFyNZyfA@mail.gmail.com>
 <CAMMLpeQvJUZJuwvK-H=M_FFedpgazGOPH=7wvPCg3U8RrxEtkA@mail.gmail.com> <CALnO6CDZ=rq_eZESzi++VFk081ddosHMpKQV4QHNFJbnsOMAzg@mail.gmail.com>
In-Reply-To: <CALnO6CDZ=rq_eZESzi++VFk081ddosHMpKQV4QHNFJbnsOMAzg@mail.gmail.com>
From: Alex Henrie <alexhenrie24@gmail.com>
Date: Mon, 10 Feb 2025 23:55:00 -0700
X-Gm-Features: AWEUYZmAeRLcEJwcL5bfDsQtf_uaO3vMwuipsaKx8OjSVrJ86HRLwXVMY7x9IqM
Message-ID: <CAMMLpeSgSTU+SVeU6A_9LJvjVbho+QC8HpNQtKJvFic98xKvJQ@mail.gmail.com>
Subject: Re: [PATCH] pull: allow branch.<name>.rebase to override pull.ff=only
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Felipe Contreras <felipe.contreras@gmail.com>, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 1:26=E2=80=AFPM D. Ben Knoble
<ben.knoble+github@gmail.com> wrote:
>
> On Thu, Feb 6, 2025 at 9:36=E2=80=AFPM Alex Henrie <alexhenrie24@gmail.co=
m> wrote:
> >
> > On Tue, Feb 4, 2025 at 8:11=E2=80=AFPM D. Ben Knoble
> > <ben.knoble+github@gmail.com> wrote:
> > >
> > > When running "git pull" with the following configuration options, we
> > > fail to merge divergent branches:
> > >
> > > - pull.ff=3Donly
> > > - pull.rebase (unset)
> > > - branch.<current_branch>.rebase=3Dtrue
> > >
> > > Yet it seems that the user intended to make rebase the default for th=
e
> > > current branch while using --ff-only for non-rebase pulls.
> >
> > You make an interesting point. The idea is that more specific options
> > override less specific options. In this case, "fast-forward only" is
> > more specific than "rebase" (because rebasing might or might not
> > fast-forward), but "my branch" is also more specific than "all
> > branches". So which option should win? =F0=9F=A4=94
>
> Precisely! I think "my branch" is most specific here, but Junio's
> argument is (if I understand it) that pull.ff=3Donly is _stronger_,
> regardless of specificity.

I can see it both ways here, though in general when the user's intent
is ambiguous, I think Git should default to the more conservative
operation.

> > On Wed, Feb 5, 2025 at 2:14=E2=80=AFPM D. Ben Knoble
> > <ben.knoble+github@gmail.com> wrote:
> >
> > > Is there, then, an existing combination that means roughly to treat
> > > `git pull` with no other options like this:
> > > - if not rebasing, forbid merging and be equivalent to --ff-only
> > > - if rebasing is requested (because of branch.name.rebase or --rebase
> > > or =E2=80=A6?), allow it
> >
> > I think what we're missing is a branch.<name>.ffOnly option to make a
> > particular branch fast-forward only. Such an option would be
> > especially useful for the master branch, but you could set it on all
> > of your branches except the ones that you want to rebase. We could
> > even have a branch.autoSetupFfOnly option to turn on ffOnly
> > automatically for new branches.
>
> That is probably something that is missing, and might solve the
> problem, but I don't know that these in particular are something I
> need (read: want to implement).
>
> How do you (and Junio, and others) feel about
> pull.ff=3DonlyUnlessOverridden? The meaning would be "like --ff-only
> except when branch.<name>.rebase says otherwise."
>
> The name of the value can be workshopped (I initially thought of
> "override" as a short value, but it may be too short to convey its
> intended meaning). Perhaps "onlyOr[Branch]Rebase"?
>
> I think this would be a smaller change that meets my needs without
> changing the meaning of ff=3Donly.

In my opinion, the matrix of which pull options override which pull
options is already too hard to understand. Rather than add a new
dimension to pull.ff, I would much prefer to fill in the gap that is
the lack of a per-branch fast-forward setting. It might be more work
in the short term, but it's an investment:
pull.ff=3DonlyUnlessOverridden would only address your particular use
case, but a per-branch setting could address many others. For example,
the user could set branch.autoSetupRebase=3Dtrue to make every branch
rebase by default, but override it with branch.master.ff=3Donly to make
the master branch fast-forward only. Or the user could have
branch.<name>.rebase set to either true or false as appropriate for
each branch, but temporarily set branch.<name>.ff=3Donly when they are
in the middle of work on a branch and don't want to accidentally bring
in upstream changes that would interrupt their work.

If you think that you can write the patch to implement
pull.ff=3DonlyUnlessOverridden on your own, I think you're capable of
implementing branch.<name>.ff=3D(true|false|only) and
branch.autoSetupFf=3D(true|false|only). Use the code for the existing
branch.<name>.rebase and branch.autoSetupRebase options as a guide,
and people like me are available on the mailing list to support you.

-Alex
