Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3B315CD6E
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718384759; cv=none; b=l+utsOukkDUaHB4Kkw/dUg/Vggiubl3UyCOTdy1OB9Z9tz0bHwv7zXFJpGxtFIkE0oSAQ6QyPtB+u8dxzNe+CwbWrsKJxtda2QtH5hnU5vlP5aMzjeZl0zz7o/xEcyLF3HLzvgvFMA6IotdZptqH3puw+bGnj27nXSUpViP5RkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718384759; c=relaxed/simple;
	bh=dOFeFHSLooSByfoBQkdPIM6OFVHI84CdsKyaZ5S10mM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dwjWkB2yrhoNHEbfTkxKoZS+kBQEDq3SEj2w42oieDiYeOxNeUO0VwaWb5K3NqqoW0piswOnYV5ppyX1GGNb983XGt5Xr/m8/KPyRFPKPJetf5Wet42AL4kB/V+lLmaGyE3P1se8Zj68o3+EeygN+1DgR9ZdjiuUesbPksZCd9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nH+pip7l; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nH+pip7l"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57cbc66a0a6so2294894a12.1
        for <git@vger.kernel.org>; Fri, 14 Jun 2024 10:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718384755; x=1718989555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3skx02oc1L6QkP+c42ktFwUt1R1WQs90H8pzxt0wBI=;
        b=nH+pip7lZbUD9cFrViAKrEU0HB3ufpJl1x9UmSLjn2nJDHhRWcoEJZTFXFZJ9WLanb
         OInxOXxfsPYS1SRCYsVLdLkpM3D7fLDr0EWMi3Sj15aFFixeab5naAF+GIN40mMHbiKY
         7/XebyNTU9HJN+wYjCkqLthsDYu6sCgFLwV+yWXt9CjkHqetNiSt6JlYW7wlN31IxAf0
         nqgtKzNyheDRX7LFA/JdC08GNjNJHeg6NH55aaOs1200mHX1ZDcKf/TqwvhlMuUWR1Y1
         btOEj+v3zkh0MoY6P581Bvnx36nPPC6cw4SnmV/+DmzUHZhBV6BepqxzSD8ytNDFR7ib
         a87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718384755; x=1718989555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3skx02oc1L6QkP+c42ktFwUt1R1WQs90H8pzxt0wBI=;
        b=TM2ZDgBn/1CoKt7sSdaoVkLqafnsxPFR3Ip5zvEMqnO8co1qw66uruZeopSMyuXoYP
         N791Cwes0gLCNhMe7DN6weVYhhVwA0PAsV0WGpx+ewTNq8cXGGoaVg/+LS5jL1HVwTnB
         TPstKhAnqghCxJtmahtQv6fmRTCliMlTHP3BE63ykgHpfiCu4bdcEmeqRr4WNjLKagEm
         VQD3Fo3l2qDNAEGsBCyQyCV3bbs5IE9d1EEh/CBT68TuNaypA3/UWLgxaOTGUJ/ylrAX
         jrQVE/7sxBztKkOJSmUc6pVudttFp3Z/gfcsUm2q7ShTXNWLe/PV7QDUVACjMLGBdy9G
         jYJg==
X-Gm-Message-State: AOJu0Yw1wgqo6wO9Mp90rnavEaWTBvUl2zMXHhB9rTuX/r7d1a9PDegM
	Nb8wgWyfUyQfj7OkLsuz2YqAzZfq4Hi6kc6GDZxaQ3aI3juxz9duQxyqzeoh+qRjYMiSWUZX7DF
	qdQMbpj2YdJo1KEi3acD2qTucGtk=
X-Google-Smtp-Source: AGHT+IF0sZ/wWTP6VFZ4+kSQgRsmS9cnRZfsp5PT6Dp3eBx9ynZlxb67HZ9BGzBfoBEmDwNqu+Aage8BpCbgxKeQufA=
X-Received: by 2002:aa7:d153:0:b0:578:6360:aa11 with SMTP id
 4fb4d7f45d1cf-57cb4bb0d59mr4751353a12.5.1718384755231; Fri, 14 Jun 2024
 10:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530122753.1114818-1-shejialuo@gmail.com> <20240612085349.710785-1-shejialuo@gmail.com>
 <20240612085349.710785-8-shejialuo@gmail.com> <xmqqr0d0iqey.fsf@gitster.g>
 <ZmvTI73P2fQ6AkOp@ArchLinux> <xmqqo783im5k.fsf@gitster.g>
In-Reply-To: <xmqqo783im5k.fsf@gitster.g>
From: jialuo she <shejialuo@gmail.com>
Date: Sat, 15 Jun 2024 01:05:43 +0800
Message-ID: <CAH-kW5f0u1uFH7Y83e4Vp8avM_7MPLkDG7v9NPV1nL=wZ--wmw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 7/7] fsck: add ref content check for files backend
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes=EF=BC=9A
>
> shejialuo <shejialuo@gmail.com> writes:
>
> >> > +static int files_fsck_symref(struct fsck_refs_options *o,
> >> > +                       struct strbuf *refname,
> >> > +                       struct strbuf *path)
> >>
> >> This does not take things like HEAD or refs/remotes/origin/HEAD to
> >> validate.  Instead, the caller is responsible for either doing a
> >> readlink on a symbolic link, or reading a textual symref and
> >> stripping "ref: " prefix from it, before calling this function.
> >> The "refname" parameter is not HEAD or refs/remotes/origin/HEAD but
> >> the pointee of the symref.
> >>
> >> So I'd imagine that renaming it to fsck_symref_target or along that
> >> line to clarify that we are not checking the symref, but the target
> >> of a symref, would be a good idea.
> >
> > That's not correct. The "refname" parameter is EXACTLY the symref
> > itself.
>
> Yeah, but the story is the same.  We are not really checking
> anything about the symref (i.e. the thing in "refname") being funny.
> We are checking what is in "path" (like "does it exist?") and the
> "refname" is there only for reporting purposes (i.e. "we have a
> symbolic ref REFNAME, that points at PATH which is a wrong thing").
>

Yes, I agree, will rename the function in the next version.

> >> > +{
> >> > +  struct stat st;
> >> > +  int ret =3D 0;
> >> > +
> >> > +  if (lstat(path->buf, &st) < 0) {
> >> > +          ret =3D fsck_refs_report(o, refname->buf,
> >> > +                                 FSCK_MSG_DANGLING_SYMREF,
> >> > +                                 "point to non-existent ref");
> >> > +          goto out;
> >> > +  }
> >>
> >> Is that an error?  Just like being on an unborn branch is not an
> >> error, it could be argued that a symref that points at a branch yet
> >> to be born wouldn't be an error, either, no?
> >>
> >
> > The reason why I choose "danglingSymref" and warn severity is that I le=
t
> > the code be align with "git checkout". When we use "git checkout" for a
> > dangling symref. It would produce the following output:
> >
> >   $ git checkout branch-3
> >   warning: ignoring dangling symref refs/heads/branch-3
> >   error: pathspec 'branch-3' did not match any file(s) known to git
> >
> > So I prefer to warn severity.
>
> If you do this from that situation,
>
>     $ git branch branch-3 master
>
> what happens is that the pointee of branch-3 is created at the
> commit pointed at by 'master'.  No error.  No warnings.
>
> In a freshly created respository, HEAD is a dangling symbolic ref,
> and that is not an error.  You can create a root commit from there
> just fine.
>

I am totally shocked by the fact that it will create the pointee file. I am
a little curious about the design here. I know when creating a new repo,
HEAD is a dangling symbolic ref. When we do first commit, it will
create the pointee file. But HEAD is a special file, it should be treated
differently. Why we treat the other symrefs the same way.

> If there is anything that needs improvement in your example, it is
> that "checkout branch-3" should be taught to either (1) not warn
> about dangling symbolic link and just give the error, which is in
> line with how "git checkout HEAD" in a freshly created repository
> behaves, or (2) just like unborn 'master' pointed at by 'HEAD' is
> perfectly happy to be checked out, allow the unborn 'branch-3' to be
> pointed at by 'HEAD', and arrange the first commit (which will be a
> root commit) you create in that state to be pointed by the ref
> 'branch-3' points at.
>

Should we really improve this? From my perspective, a user will get
more information when this warn message shows up. The
"error: pathspec 'branch-3' did not match any file(s) known to git" is
less informative.

Maybe the pro git users do not use git command to write to the git file
system. However, this is a bad way to do this. We always want to
the user to use the command to handle with git file system.

Instead, we should warn about the user when using

  $ git branch branch-3 master

It will create a new pointee here, I suppose we should warn the user
here except HEAD ref. The user could get the dangling symref by
deleting the pointee ref. For example:

  $ git symbolic-ref refs/heads/main master
  $ git checkout -b master-copy
  $ git branch --delete master

Should we warn this for user in git-fsck(1)?

> So from all of these reasons, I do not think missing target should
> be treated as any error worthy event.  Not even warning.
>

Yes, if git-branch implicitly creates the pointee ref file. We should not
handle such case. But I think giving a warning here except HEAD
ref is worthful.

> On the other hand, the target of the symref in "path" must be
> checked, even if it does not currently exist, for its validity, the
> same way an existing ref gets checked (lives inside refs/, passes
> check-ref-format, etc.).
>

Yes!

> > I intentionally ignored the "escape" situation. Actually, the path coul=
d
> > be either absolute or relative. It may be a little complicated. I will
> > find a way to support this in the next version.
>
> Yes, if this wants to claim to be part of "FSCK", it should catch
> all the errors the regular runtime would complain about, and
> "escape" thing is one of the first things that you need to get
> right.  Whatever refs.c:read_ref_internal() for S_ISLNK(st.st_mode)
> case takes as legit should be considered legit, the "fallback - read
> through the symlink as if it were a non-symlink" case probably wants
> to be warned.  refs.c:resolve_ref_unsafe(), which is used at the low
> level from object-name.c:get_oid_basic() via refs.c:repo_dwim_ref(),
> has further checks to see if a refname that a symref resolves to is
> valid and the runtime sanity relies on these checks.
>

Thanks for your help! I will look at these codes to implement the
"escape" check.

> Thanks.
>
