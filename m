Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BE8BE4A
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 04:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743739755; cv=none; b=deg1kv7BvkrpkxGyCW8SLRzzmhre9REC2gwPMkFVdaiJNQMJrW/gjDHNnRJUAbJ9lkT5R+t66xX0Mm/cEx1mzHg2dnB+EEvLXa4KC+TB/OvcZ5UODpQsFjgNmaPPFvbHBrouAWILs7xhpa4XSAPsynq6qGby/wETIRwte3QNLFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743739755; c=relaxed/simple;
	bh=YEOXfwLUm5o0ULRBPpGIzuNWO48n5ZN8TNLt0hlZeBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDE3fotJ8FLEYvS5yj8nto+uPlowA0NuNBGFPLcvXpTzPl3nZG99EwM4cqzlbObkqzrR5Vmyr4eVEkTnhmIly8pHFBK0LBbVbMaxp2XpjTgmzJcikSLA0RvzDl6t8cUtgpePfP1txy0WAqExxH9hw9A+1AkCTEz71/uiViwLyiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iufFUef0; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iufFUef0"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f09f2b3959so5792a12.0
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 21:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743739751; x=1744344551; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F7vTLpD1QeXv7tgvZ3CJf6OyIy4SqUUgOmL3ybYAJTQ=;
        b=iufFUef0B+XCwtPUNoXWbgfmJLd/i7i7jqKmWpc8igSRqyR17aOLgSEnv2nunTFSaQ
         0OgVEOqJr4KZzXp8uv8psT2GyQYaG7EIxEXd1iErjeXNQyKRt5vRLXc27xfzBAY2pyvn
         dyzEJB4Lye8zg6eYNt3Bkr/h3DrRRmAKvoI+wN1pNp5+eWtFrNchy7NZXm/qesLfzSkU
         PCcKpkxUVE5jRxbb335QYthZZbl0kdbu9gLZDnP2DfD9JTk2ccOa4vSkMWtwCuKVGSmo
         aJEtw88NznXQzWgJUPXObxaTFZuyqMEe8zAMywlAaupqk14g5G+mM7lnGA547oyEklNK
         9pOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743739751; x=1744344551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F7vTLpD1QeXv7tgvZ3CJf6OyIy4SqUUgOmL3ybYAJTQ=;
        b=nMt2ecoFYdBV9DrkmWWuhOjA+yAaR2PKpOA4YkdqMDp1pGllr8h/JgPat1yYNDkI1t
         2g6j24hJTXl1tOGbFs1STXBRgwjkc6M3LcYO9X+fDlanFzUG1hYwKckwOGHElj7VTRsy
         O+P4gkKHbwm3/FfTG/UxY6QErcG3ItZUiFgAgG5dGWUaoiqUhOOYqS65VpLFjOTJYE5K
         iMuuARwXmkTESpNfi8E/EW3j5yT7hiD0LO9zTdfkq5uCoR2gqXvus8ktPyhEo/Fl+k8C
         52arJwDXxKyu+gJPY25XBqzKw2B0U8w5Wm4lhPPMY7uP8rVuREis6CK/6QREDiG3YXk9
         KH9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHkjY3cde6cUTALzrQdSPkE6dCcIhj5xiZpxhJZ3KDTkrxZxJyhz4keuxWeu3NY/zJvDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH05rsYWpnRRkH27G05ph7XsAem0LwIbrBGXJOD7JCwdk/qP4Y
	54eScMrOcXYSTplkD72lZJvUrJ1t3zDyhUXLbqq9NIClQc4SzKjvSDEqw3yZNbB0wkCF7l8JBR2
	LXHxKIBaZhdDSFrMpCAr1J+YbNxLTqoiLzzsU
X-Gm-Gg: ASbGncsEe4K6f4OjIf3roR//I2OwxEXniAkmzRnCPamAkqqamuyZ6g9T9LL14Maug1e
	4joU5mGpTeIJVrRSxT4v68t151scCWMzg0WgwqLtxcDogNXZRZNdMB5KhH9D96HPd+vUM+xn0o8
	CfXh1aABhSH4wcHUDa0sX4NyYmjJD2M1zncOMy
X-Google-Smtp-Source: AGHT+IHa8WgvfRRDZrLg/rVPAdwXEt7gzTsNJYshGH9EtwOxaxdiymRLdylUen9qczqLZR6ik58jbWVGnhkU0oe8mcg=
X-Received: by 2002:a05:6402:6d3:b0:5dc:ccb4:cb11 with SMTP id
 4fb4d7f45d1cf-5f0b4945f88mr62076a12.4.1743739751086; Thu, 03 Apr 2025
 21:09:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com>
 <Z+7PDi5y4wXJBK4r@ubby> <CAESOdVAd+X=6nEULHtKKotH_W5yNaJAcUajRU79EuG+0SF3m1A@mail.gmail.com>
 <Z+8IF67AC8gSouYc@ubby> <CAESOdVAWWP=Rte4bx3zUZc6p0XiZaJS2OZr8ezRPkfq8K1TYfw@mail.gmail.com>
 <Z+9N2REkYZhrbkzb@ubby>
In-Reply-To: <Z+9N2REkYZhrbkzb@ubby>
From: Martin von Zweigbergk <martinvonz@google.com>
Date: Thu, 3 Apr 2025 21:08:59 -0700
X-Gm-Features: ATxdqUFNq5QpBIInQZUJ0DiF5CDuCN6LzaQ3dMB7XqhqqrA3cnmaYIfMZ-cEshQ
Message-ID: <CAESOdVCekFDxOWTTF71dpH1id_H2t9SaNo6buJ1MbvTnaENY7g@mail.gmail.com>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
To: Nico Williams <nico@cryptonector.com>
Cc: Elijah Newren <newren@gmail.com>, Git Mailing List <git@vger.kernel.org>, 
	Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev, 
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Apr 2025 at 20:11, Nico Williams <nico@cryptonector.com> wrote:
>
> On Thu, Apr 03, 2025 at 03:47:30PM -0700, Martin von Zweigbergk wrote:
> > I think part of the problem is that I didn't consider that Git doesn't
> > really like to work in detached HEAD mode and doesn't automatically
> > update refs pointing to rewritten commits. This does take away a lot
> > of the usefulness, unfortunately. It would still be a bit useful as an
> > argument to readonly commands.
>
> I work in detached HEAD mode almost all the time.  And yeah, Git won't
> update refs when in detached HEAD mode because... what ref should it
> update?  The whole point of detached HEAD mode is that it does not.

Jujutsu (and Mercurial) keep track of the set of visible heads. There
can be branches but they are not necessary. When you rewrite a commit,
Jutjutsu always rewrites all descendants. It also updates all branches
pointing to those commits automatically. For example, if you update
the description of some commit with `jj describe -m 'new description
--revision xyz', then commit xyz and all its descendants will be
updated, and any branches pointing to any of the rewritten commits
will be updated.

I think this is getting off topic. I can provide more detail to you in
a private message if necessary, or maybe we should start a new thread.
I don't know what the convention on this list is. Or join the Discord
channel [1], or the #jujutsu channel on Libera.Chat.

> > > What would `git switch <change ID>` do?  `git switch` switches between
> > > branches, but a change ID can't possibly identify a branch since many
> > > commits could exist with the same change ID all in different branches.
> >
> > Yes, the same change id *can* exist on many branches, but it's pretty
> > uncommon. It might happen after cherry-picking, depending on what we
>
> The whole point of change IDs for me is that if I need to backport bug
> fixes [0] then I can identify the bug fixes by change ID and then
> cherry-pick them onto support branches, which means that yes, there will
> be many commits with the same change ID, each on different branches.

I agree that that can be one reason to use change IDs but I disagree
that it's the only reason. Having a stable way to refer to an evolving
commit is also important.

> Besides backports another use case that leaves multiple commits with the
> same change ID is when I'm working on multiple different approaches to
> implementing some feature on a complex codebase.  I might have two or
> three branches exploring different ways to implement some feature, and
> of course I would want to use the same change IDs for similar commits
> even if I didn't use cherry-pick to create all but the first.

This sounds more like the idea of "topics". It's an interesting
discussion, but it seems off topic for this thread.

> and even then still not workable because Git might
> have to search _many_ branches to find commits matching the given change
> ID.  (Fossil could have an index on change ID and trivially make that
> search possible, but for Git adding an index is more complicated.)

Yes, I understand that it would be significant work to add support in
Git. I hope that Git can gain the feature eventually, but we have no
expectation that it will be implemented soon, especially not the UX
part (the preservation-on-rewrite part should be simpler, I think).

[1] https://discord.gg/dkmfj3aGQN
