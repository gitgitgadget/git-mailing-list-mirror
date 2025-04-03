Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA2B2E62BA
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743720465; cv=none; b=UHUZ7SQH8U3XW586pHj3dHgSDUz2oxPYAHkFtQR1fIOsj4n3gMswHczMPGy+Ju6cU+2zonHUhgorSewYeCr2CBSPcqnPGJLBbObQH1DSTAmSoO68y3hVGnVNjZLwRrJ+eQoL+OjtcgWMDjiudT0jikmOa0Div7ibZjaLbXwx2bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743720465; c=relaxed/simple;
	bh=V/3MnxanhirQRNwmQyKVrFWlmOC4Dft+/NRi79xbqmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlqYsW646OXPibYOL5Hvcuvc45I7G08LzIakAmy7bAhTYkKYLy3Fw8HB+2doHMN4JYgwuxYKemTSML9u57ZL9kAP7AAPEIg/gzrKtv77/hdcandRNbXsTwPrvLQX8BU90cJp8j8gWWXIyK6ryLpEUmoe1K0QZvjO9kMWao/n150=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D9dJFPCS; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D9dJFPCS"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so4232a12.0
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 15:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743720462; x=1744325262; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+FUYJooZ8qJn7zl2cNuJP6mX11SyXuhZELxH4IaiVBA=;
        b=D9dJFPCScpRH0osldVibhyW8a/3SJwJISF2vXGdfvK7jNGG1G6dLCY/l9Df9TzgtK9
         SZlRyOUDsi3CFYfP3l5480ZQKFBrN8ljlF8WvSjXj6qJ3e84vwRuW22vTtGgRiunb1yU
         7BvSEzTlXEq4lZlcFkPlRABvj3+p/5Fwdu4hrqEx4ybaO3VVaFzjDAEfTd81/l9YDFcZ
         iGSLfcVl0yrXQD/T2+KHOgVQNvmIWn6zpu/QlUTfudOkJ8U+z6wrbH6r3YPH/7jgKOAl
         jHRCJ3v6V7EQmlNqDmMsHcCGgvMdLHG1ddVdNJYi5WayTE47SNlcN/sYUP2ORHQ4U9/a
         AH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743720462; x=1744325262;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FUYJooZ8qJn7zl2cNuJP6mX11SyXuhZELxH4IaiVBA=;
        b=WWknmBgTqbAe8yWNnvLIw0kjMgyWFadPS0h1qYNqzZIoME1gyplDj2IMWTfuMQmLLF
         iuHv81Q4cFBRb1pFEts4NAIrcQVz1eG1kvitKnGEw4CPRuKqJd1dcsj2llesz8r7v4UA
         ZWSqv65rt1lnLz+F8H0vIDKwHW3GE4QfKBZ130hcSILzm+06SzKZNj1A7tjsrkktRbTq
         n0qVU2kLk2KKj+2+mVi6J/ljwHQXhieR9MRY8ipfm3z55/oLiOhW0v5wiGO1cvSbFhhV
         dMmPmL9EpficPQf2c/V9q5zYJH3gyWIa+L1re8cc4MXL8C1TSmImpxWomtYnZYFVM/b6
         xi6g==
X-Forwarded-Encrypted: i=1; AJvYcCWQWRFXwQ2GfieMcV3f4PGMmy+Gg4HMHMd5WcMCIJ2v44GLMtJHWOYZXx56YwOJ0zAHZzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoGbzaB0JlKC3r2n0mIvp1IbN9Y7TPjdEhuqa78WaApVCPvxuJ
	mUWvp11+7uFH9FrKmjHKPvjIKxCtsnAQ169Eo/zd2ZsJEEJ0K/zEOHvXJSdZiUMkW5MUISNZlxu
	ciYtBzzPGKtSh2NKSoLiOk23XGJ233GCfNG8BERhUbEVcu7npgSeq
X-Gm-Gg: ASbGncuR2y8PztDQYIS4LVWlG5i03IyYYIq5cK/IkaxiC9HXxvr4jJM5j5F29wJc7Go
	qNwl26xhr53m7KoWbkJIzKNxtaqnk7qY2UjEEyro7/vf7tXkfgnbpAQDWgfzD7zLqxIrKHm4lDr
	8nSqQJyYRULEB9Q7iR2uuaCY4AiLlyv5AEwXa/W2Uq9BV6q/cM005hk+/9
X-Google-Smtp-Source: AGHT+IHP8pUkLPmgT6V4l2pVkV9VSsgOJXYdAVI9lXxK0nPU/fsKJt9pwMWYxBqiDsluyBU9iHsELQSDvt+ryPqTMyU=
X-Received: by 2002:a05:6402:1858:b0:5eb:5d50:4fec with SMTP id
 4fb4d7f45d1cf-5f0b32e46b3mr44100a12.0.1743720461376; Thu, 03 Apr 2025
 15:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com>
 <Z+7PDi5y4wXJBK4r@ubby> <CAESOdVAd+X=6nEULHtKKotH_W5yNaJAcUajRU79EuG+0SF3m1A@mail.gmail.com>
 <Z+8IF67AC8gSouYc@ubby>
In-Reply-To: <Z+8IF67AC8gSouYc@ubby>
From: Martin von Zweigbergk <martinvonz@google.com>
Date: Thu, 3 Apr 2025 15:47:30 -0700
X-Gm-Features: AQ5f1JpqZucRDX2K9D_tTU7Cs0ontmbQvdqBD_r9Wkpz6X45gJGP0tsELqUx_ak
Message-ID: <CAESOdVAWWP=Rte4bx3zUZc6p0XiZaJS2OZr8ezRPkfq8K1TYfw@mail.gmail.com>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
To: Nico Williams <nico@cryptonector.com>
Cc: Elijah Newren <newren@gmail.com>, Git Mailing List <git@vger.kernel.org>, 
	Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev, 
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Apr 2025 at 15:13, Nico Williams <nico@cryptonector.com> wrote:
>
> On Thu, Apr 03, 2025 at 03:05:41PM -0700, Martin von Zweigbergk wrote:
> > On Thu, 3 Apr 2025 at 11:10, Nico Williams <nico@cryptonector.com> wrote:
> > >
> > > I agree that `git rebase main <change ID>; git switch <change ID>` is
> > > not a good UI, and I wouldn't want it even though I want change IDs.
> >
> > Why do you think it's not a good UI? Is it because the change ID isn't
> > meaningful? That's correct, but they are also very convenient. The
> > unique prefix is usually two letters or so, depending on how many
> > "local" commits you have in your repo. That makes them easy to type. I
> > basically never refer to a commit by a branch name anymore.
>
> What would `git rebase main <change ID>` do?  I assumed that it would
> find a commit `<change ID>` in the current branch and rebase it onto the
> main branch.  That seems workable, I suppose.  It would be akin to
> `git cherry-pick --from $branch --change-id $change_id`.

I think part of the problem is that I didn't consider that Git doesn't
really like to work in detached HEAD mode and doesn't automatically
update refs pointing to rewritten commits. This does take away a lot
of the usefulness, unfortunately. It would still be a bit useful as an
argument to readonly commands.

> What would `git switch <change ID>` do?  `git switch` switches between
> branches, but a change ID can't possibly identify a branch since many
> commits could exist with the same change ID all in different branches.

Yes, the same change id *can* exist on many branches, but it's pretty
uncommon. It might happen after cherry-picking, depending on what we
decide there, but it should very rarely happen in other cases. When
you rewrite a commit, the old commit usually becomes unreachable, so
if your change id resolved to one commit before the rewrite, then it
will resolve to one commit after the rewrite. I know Git often leaves
descendant branches until you manually rebase them, but at least
that's probably typically a pretty short-lived state. I had a script
for this back when I used Git.

> > > > And if it does work, isn't it expensive since you'd need to walk
> > > > history to find it?  Or do you keep an extra lookup table on the side
> > > > somewhere?
> > >
> > > Worse: since there can be many commits with the same change ID they
> > > can't be used as refs because Git can't possibly be expected to find
> > > _the one_ you really intend -- how could it?  I suppose Git could let
> > > you pick from a list, but that's not likely going to have enough
> > > context.  Maybe Git could give you a list of named branches in which it
> > > found some change ID's commits to pick one branch from, or maybe one
> > > could `git cherry-pick --from $some_branch $cid` and have Git find the
> > > commit(s) on `$some_branch` that match change ID `$cid`.
> >
> > See my reply to Elijah. There's usually just one visible commit with a
> > given change id a repo.
>
> s/a repo/in a repo/ ?
> s/a repo/in a branch/ ?

The former.

> I'd expect many commits with the same change ID in a _repo_, but at most
> one in a _branch_.

There may be multiple commits with the same change ID in a repo if you
had cherry-picked the commit, depending on what we decide to do with
the change ID on cherry-pick. But cherry-picks are not very common
anyway. Or maybe it's common in some workflow? Oh, are you thinking of
a scenario where you cherry-pick your own commit to see if an
alternative approach is better? Sure, if cherry-pick preserve the
change ID, then you would have multiple commits with the same change
ID in that case.
