Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71D2305976
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766142337; cv=none; b=dapcLkQPtokGJ7k2ThPykWGnogxp/ZFd8jL+k9QJoIV3kK6lv27T78QdpxNWCChm9NGhKLpLUL8dbIXrHX17w/AGzbT2HLmeqjqOQ6kNIjhRUyhPDWptN/R22LBT47lIjw5dTemjvUPol38Ia6CIeb3xsyeIZHmvMX1g+il+5og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766142337; c=relaxed/simple;
	bh=uUwwbfbx0gBbCk6THljxf4vNe4ZIVJ2TUr+eynAu2cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMUYnqBFiS2m1RlXfrkZp8Y6aB6dYzXXFIq2mALSic//xDwPERwe0kY0AXB6KXt/HV/FhskuxK0GQRA7mIIJfIDKvoDErp8eVOXEU7rjRfdESIeAfkCy6Gpc/jDEVNiZDI5lRwgq0yJ1XfzOWp75+jvxfnRQ6RAFwMkvJWLZXss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDVC3r8p; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDVC3r8p"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-597d57d8bb3so1323497e87.3
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 03:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766142334; x=1766747134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUwwbfbx0gBbCk6THljxf4vNe4ZIVJ2TUr+eynAu2cM=;
        b=fDVC3r8p2ywoeJsNfeGOCPIYNOhn21JzFEb2gQ3CnIZdNIw4KZrVKuzbm7p/4Xp4yS
         UlB31PF4Na2xM2zvcOv+2mjhJUnjPw41S1PkXRCbWDZId0AecpFFl0mVWEG0F6kS1dqT
         vEsfS1+8usz8naR6EitaFuLAb1UwN4ljgMj+1leqwg/uEhRqleo2EJBdvHDeQ/zleLah
         gYePOL81MGKT6Kg4JrrFhqwWsvQEsdFEFUdqfi98VKBge+fYbZMYtOYY1F7+rkp/2kqC
         YXuwwgdDSG5b7Q6XVZfm0LH4+4zuiWWMpEs6emoOREhPAbvzKmg/CiCnOvSOufgxQkcM
         U1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766142334; x=1766747134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uUwwbfbx0gBbCk6THljxf4vNe4ZIVJ2TUr+eynAu2cM=;
        b=IvrKQVPykfdOVpUITr4RF3kN7luUYtQvkdUwxQJvyxij1d6p5Fr4r+LWPawXUm20Fv
         rmGAbuOkwrICL9dViwlRHEPEzUf/dDodrcySVRlvPUu87I3nlhDLsXGwYAAgFW5OE4Ol
         gnLmJl7K6Xm+AvusyEDtOXtrlGtab9ROzlebv3aw3Cq33GqAbN7s8SZ7mgtiGExp2J33
         NSATKN7DIjwiY7k123wWog8ZjqhlYbsBgFltxinUhqcGORphThrU4CHkyTZXMtRA429W
         ikFvBMolRycdzICmse1SIlwR6XEkau5GNYFxGwDbWdLkdHOSiNuEE0aSvTzZhNKDObgE
         oKGg==
X-Forwarded-Encrypted: i=1; AJvYcCWRcA8rWIVmqAFInKWP7ouT93CJjYB2qLqhjWOREEEojyewanf0zx92+Xnfns1kJkcFrgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG+JbWxx/SSmwDzoJOMHED2i7nYMTu3nV46kIHdDHWz8XWJpoa
	cUk41qONIZAbvchGIyI/tkGXWAqgedBztqNFuFld1DCM3UelyT8KWefkEQrmWvFKo3olZbysMxz
	ji1K5ZuXFxG5WFDXcAHxG0bJFnU/1UNi7a8jr
X-Gm-Gg: AY/fxX668cX3Rkm7FTeUKt/0xeB/8wvStCQ8e4gjmyBnvLd8NNT+AK8UBQSUKaarlf6
	hG3x9zV1ShTd8EIjCff2P8NLRpcl14H4ZYr4+MHWnevkOH74uSWKGFX9N4TUe951jneHm9h/qd/
	SUjIDDeTDaps0VPLDXmEQqCJgkoh3hPo1XO6MSrYIGQPcTj14DSWyYWpwJCSp0MUgZus+8SwE0y
	G/aQ3ZA8cWfJhe7cnGFKfWHQ4qAkW88Lk8PxC4HXRPj62ccHsFPxFfbryPY8b9ga7oPIo62
X-Google-Smtp-Source: AGHT+IHyROkJ6EjucyCwfZTYccIKmsCGsxQNMxrd44n6nVGGcxDe44wUDyFsXhJszZDIF1WM7ScH/lgzCnp0sZh3lO0=
X-Received: by 2002:a05:6512:3991:b0:598:dea9:4f4d with SMTP id
 2adb3069b0e04-59a17d68066mr814957e87.53.1766142333485; Fri, 19 Dec 2025
 03:05:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG-pPd-4StfLAsassx-fqzavHJkAmi8P5UkgvqE3Yz-yGJ7GUw@mail.gmail.com>
 <03034879-2d8e-4ab1-96ff-ff125e7d059e@gmail.com>
In-Reply-To: <03034879-2d8e-4ab1-96ff-ff125e7d059e@gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Fri, 19 Dec 2025 03:05:21 -0800
X-Gm-Features: AQt7F2r5tNufn7MSjiiWasqcMJ_JbfXkqNT9htCnqv5wkSjokOVK9FjEAfTTcEU
Message-ID: <CAPx1Gvfuacq0rt-6LymiEUUdeKsE0+s8x2x66_zD=zatWui0RQ@mail.gmail.com>
Subject: Re: changes for adding new features --snapshot,
To: phillip.wood@dunelm.org.uk
Cc: Abdullah <abdullahindo888@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 2:41=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
> It would be helpful if there was a commit message explaining what this
> new feature is and why it is needed. There are some comments in the code
> explaining what it does but not why it is useful. Given that a commit is
> a snapshot of the working copy I'm not sure why you'd want to save an
> additional copy.

To be a bit more precise, a commit is just a little bit more than
a snapshot of all staged files: it consists of a *tree object*, which
is this snapshot, plus a *commit object*, which contains metadata
to explain who made the commit, when, and why, and what
commit(s) come immediately before the new commit.

The sample code itself makes copies of some (but not all)
staged files, rather than a complete snapshot of all staged
files. Abdullah is probably under the impression that Git
saves only *changed* files, and that the staging area therefore
contains only these changed files, but that's not the case: every
snapshot contains *every* file.

This takes no extra disk space because of Git's clever method
of storing snapshots. The code in the diff does not make use of
this clever method; instead, it makes clumsy actual copies,
which generally do take up extra disk space. That's presumably
why there's a `--name-only` diff here:

>> git diff --name-only --cached | xargs -I{} cp --parents {} \"%s\"

To make a Git-style snapshot containing all files but using
no extra space, we could more simply run `git commit-tree`,
which produces the tree hash ID; we'd then save that somewhere
that Git can find it so that Git won't garbage collect the tree
later. The obvious place to save it is in a tag-like reference
(perhaps an actual tag, perhaps some new `refs/snaps/`
space or similar). But it's probably superior simply to create
an actual commit, without putting it on any branch, in the
same way that `git stash` makes commits but puts them on
no branch.

In any case, you (Phillip) are right that this doesn't explain
the use case for these extra "snapshot" commits or trees.
I rather suspect that the intended use is better-served simply
by making a branch (as often seems to me to be the cases
for which people use `git stash`...).

Chris
