Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09AE224882
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828548; cv=none; b=f5x49+Z6GgM3FUEdH3W4kJYnJ2bbKwrPw5CMq8RCAlLWmJQrSgeGeUACEPXmlpvgfaLCassYw778GAnPsO0p0FM1HdCRKoieLthd5bPK9KgeFwaXiM/cne5JMqppXQJfNTzlvk3MuNbBNXu36e4Z8LiuisOS+UooIWJZnyc7SAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828548; c=relaxed/simple;
	bh=fUE9x28XtDPzfxfthohHbNdWcib6i/ljrEpkExO42uU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uaO8QqNr/+Lat4oJLLJYZpjKXuhRNWJaMpl3IoLeGSJY2VjHVYm+mXPG+BKElvB51znK/fIEYUuNh+3rzXIOQ8Q6aiOE8Nt1t+TF2r+MwnrDuYF9Fxy/pDMOpO2o94x5Iri7trZxChqXvt7ye3HFHc313xs60cag//jo6O0K4p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlB0O7no; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlB0O7no"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-851c4f1fb18so19902239f.2
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 23:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738828546; x=1739433346; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDl5L7480AFot5dI9E57UFoFFYBxHUlF68KKEcdRHAg=;
        b=GlB0O7no0u/joaS7oxlfa2hxyGt9edoh4hTCNCor09lnF7czu0Zk7AXdCpfwRCNaNG
         IzRGv43EVJSgai7PHNtU95enPNHB0VDB4jWOJMgl/4Kw+3LTxrzNeiGnguCAvFNN9nws
         uEv/e17ZMKuPa6UXmma1JSBcNuxS7gU5mc6OkasJzsHL9vEFFF0Jk9IIrCREyn6AykQP
         cHuaT9SWNiIFK58c7aZ7mgpTKPRoV/xokmaYMvX53AIV2yWwOJV9SuCTbiPguqXg3ixX
         Jld4bZehLmEoQNIL5qsm2ZZLUm1Prbd6rvNvgGew1Al5zIvBo4rYh0k/l08wLMxHtC6R
         sWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738828546; x=1739433346;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDl5L7480AFot5dI9E57UFoFFYBxHUlF68KKEcdRHAg=;
        b=NZwv0dcNl3WZfa5WyXQYRIQwf+F0/8XEobO4LuSzcrWlyGWVFfIIMgVGUg9CMb+MYh
         y9/WSZqPsUm/aUFdYKZ/+WxScQ8dLpbjkVYtRupYv6dOcxc9fnz/4T1ki+BxLb8r4BKm
         /grklR1QDNH6OZXHXD24bjGq4kBTP8MjRPBkeXqth2BIATD9c/hmJaF7l3k2MyltccWy
         gnET9xlO5G9MwNOj3xpxsiZyoSmK/Le7VjKZvSIWSHZHX2WW27VPQfUppzT+bC/1kwN1
         /kyFGvDTxQGUgOjEZzPVTEF5ml9xHByPamO0jYeNvi25xOJXLoqRkF93sNURSB+PNDkW
         MpJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW65SdD72I1/oDQ2EaFqCRi6E2425ODxMGGxIKJ2v+0qr7NEgBKg3wNPteonHiVq6Tzzb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo3M6mXnK6EdCf19PRpW694Le9V9eV5Npc453BDb8ZSnnzPfDN
	jK+qERh9/gSu4BEeaK09zYpuW6cWX7qNUfslN8cBZmNCRwgUDEBxNXa1tfQCKT3Mxbwu+q8CMr7
	XXQFaQtsr0NVmhkT8TjZJ5hkNW6kINVMm
X-Gm-Gg: ASbGnculkA61UiY4TOdmvnMlIJpi+k9BA4gQJNX69bmYXA+RChA/97/D3PO1BErASS/
	xvG5cYe0Rdtddtq14BMWQB8XGhpLEt84amhY7IKCRs8oxOtHVakjTddCLhcTEjBZS7fAWzjFo/P
	2qs2yWvYBJvOc=
X-Google-Smtp-Source: AGHT+IFNt4UMeuvvphOqVBAv4L9t+jLbnGRj7tVLEBKLRFDdv0GT/HvPXF1hzKIysLVrwxVSuXCva8Sa1Vg5YhTnkpU=
X-Received: by 2002:a05:6602:6a87:b0:84a:4f3a:fa2a with SMTP id
 ca18e2360f4ac-854ea42d6a0mr605866939f.1.1738828545652; Wed, 05 Feb 2025
 23:55:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205214726.GA30202@raven.inka.de> <Z6PsXGnxM3UBR3nM@tapette.crustytoothpaste.net>
In-Reply-To: <Z6PsXGnxM3UBR3nM@tapette.crustytoothpaste.net>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 5 Feb 2025 23:55:34 -0800
X-Gm-Features: AWEUYZnSnswCAyYO0iiB3IqwPp2tO4EMeCB7uXVpQ3Qy9QtBUwmvjUuYsQHptHQ
Message-ID: <CABPp-BHkUW7NVatPOVeBPybwSq9s-HjJ1FTgwU0eZRStatfXMA@mail.gmail.com>
Subject: Re: renormalize histroy with smudge/clean-filter
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 2:55=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-02-05 at 21:47:26, Josef Wolf wrote:
> > Hello all,
> >
> > I have set up clean/smudge filters to normalzize files from an applicat=
ion to
> > reduce the pain when those files are tracked by git.
> >
> > The clean/smudge filter work well on new commit and the result of
> > smudge+smudge+clean is the same as the result of a simple clean, so the=
 filter
> > should be fine IMHO.
> >
> > But whenever I do any operations which introduce not yet normalized com=
mits, I
> > keep getting errors.
>
> Yes, this is known to occur.  It notably happens with Git LFS, which
> uses smudge and clean filters, and suffers from this same problem.
> Renormalizing is indeed the right solution.
>
> > So to get rod of those errors, I'd like to also renormalize the history=
:
> >
> >   $ git rebase --root --strategy renormalize
> >   error: Your local changes to the following files would be overwritten=
 by
> >   merge:
> >         foo/bar/baz
> >   Please commit your changes or stash them before you merge.
> >   Aborting
> >   $ git add foo/bar/baz
> >   $ git commit -m renormalize foo/bar/baz
> >   $ git rebase --continue
> >   git: 'merge-renormalize' is not a git command. See 'git --help'.
> >   error: could not apply abcdef... Foo Bar Baz
> >   [ ... ]
> >
> > Huh? I never entered a command "merge-renormalize"
>
> When you use command like `--strategy foo` with a custom strategy, Git
> calls a binary called `git merge-foo` to implement that strategy.  So
> while you didn't explicitly invoke that, when you used the nonstandard
> strategy `renormalize` (which, by the way, does not exist), Git invoked
> it when you rebased, since rebases by default use merges under the hood.
>
> > BTW: It does not make any difference whether I add "-c merge.renormalze=
=3Dtrue"
>
> That option also does not exist.  Can you tell us where you found such a
> recommendation?  If we've been misleading people in our documentation,
> I'd like to fix.
>
> > What would be the proper way to renormalize history?
>
> The command that needs to be done is `git add --renormalize .`  I think
> you probably want to do is something like this: `git rebase --root -x
> 'git add --renormalize . && git commit --amend --no-edit'`.
>
> You might also be able to use `git filter-repo` to do this in a nicer
> way, but I'm not aware of how to do that.  I've CCed the maintainer,
> however, in case he or anyone else can provide an answer.

`git add --renormalize .` requires a full checkout and an index.
filter-repo was written to not require checkouts or an index; it
should be able to operate in a bare repository as well.  So, these
simply don't go that well together.  If we had a way to ask git "how
would renormalization modify this buffer if it were at this path" we
might be able to provide something (though that might require having a
whole bunch of .gitattributes contents available, which might also
make it tricky).  Folks have requested it
(https://github.com/newren/git-filter-repo/issues/375), and the final
commenter provided a workaround that might be good enough for you, but
I kind of think we need a way to ask git "how would renormalization
modify this buffer if it were at this path" short of creating a full
index and checkout.
