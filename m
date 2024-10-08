Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219322AEFE
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728423371; cv=none; b=LD4LqjojnAUoIQueEAOBF59VGYzwYw0PNKpI8KRTCkEW3jfu3pUtjRByn/0ZVvAxoy5FpQ/NGFFIhFSYiReZXayx0AmYonbK0VGYBQo+aeIntvaSEgmqyp7nn8XqXUpN4rhvcwWsPva5mNOMUBEuL6Wd6Nq7X+s9O5Wit9MVRKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728423371; c=relaxed/simple;
	bh=iJP/yDx9xrC5PDKNpJZBQI91s/+XxXFK2w3a8e48DmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgrPwXOAx0FOXOnzDMI27KZWzOHf8L6PivI74J0zKRRcGQQSrfPBs+I/mYOzSfMx6Q+ajAdvwbJfl643dudTq5xKvl7qzKeKOfH8EktyYYn1asCrLDVHUzRN+5i4xuQOIjIMzE+XG9DZt8uiLNcoCeSb2bX6itybAExFj+Zx9Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2BogQMqi; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2BogQMqi"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42f6995dab8so91305e9.0
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 14:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728423368; x=1729028168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/+oDfyI3uWPqfQhVtwpYAbZkDQyC2u5Ik4MN26OLrw=;
        b=2BogQMqivXIkKFwJZJDhKWabzS2QaRB2LaW9mo6YfQnWC+QsJBxJ+wYNfqe19YBeDF
         Lo6dDfzrsDPjoVKs/DzK7qCaDmcwNkTLcVk2KhgZSntoks0iB3j8FIxZAMfvOXHa7ZVI
         ZSpa0n8uEyqbRd6S6LNY+aHzYOYNhHYru8AuVBVN1akCSGinyib/Z80OaFgkJCB6oNTU
         0P61hYOdjbfG4FKRmaCVpoxLsoc9utXdVWGLfdaNKLnzFISmZlVyhd63Z2LD9jE8hsXl
         VyZOfk3nATHhs4d8aQUiAcfVPE2VdCDARaYoAn5aULM6tEhvEGGuZ7E7XwjOeuYIgUKr
         AC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728423368; x=1729028168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/+oDfyI3uWPqfQhVtwpYAbZkDQyC2u5Ik4MN26OLrw=;
        b=BwsAWlGohvQikV8o4BKmu/IzLsdPQ5DetDtH4ep37w2H1ydFeF92iLbLjoXw/ejrhE
         H2Xo45ez6LcwUfwCLD6gyc8ty3T3qyAW53QN1lEJ66ZiAA+H8JniAAcl6N5YnJRfQjMc
         OY9HT78ekW+JH/f947mQvVIpNTZY6Iq3z/H5NENkGBgonDOIXvrYrGI0L08TXtGukovN
         aW52WHzLfu5ciQwbGzzzW1YQQXKTd8AnYy7Am5XePq3qt3gHdoQQ3LfnqicQHF3Gq49j
         WljIAZN6JychNC/K2xNQ8pgS/pij5qXqtdO629/vRtkXaHHivlL/05AmtVBFLW36LErH
         m+vw==
X-Forwarded-Encrypted: i=1; AJvYcCWT4psEqA3f2XgLE6vzGyMVYcuBDd0G6KMyjC21h8EV6AKKTirm0W57GcFJgR7aQb5MNi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBPYymFjSfEk5i1iY+AfOA2y0ABIAdeZBfwLFvg2KRyLmZMeD8
	Tzgw6fjRI6jhEOUgM3+GT1NtQ/yOTwP5nG5wPKENXQ9C9I6FVEfmS+gesnK/9Qwd3j/Se3f53jt
	ZiLygQBdFcIiNmYNsW3A+Tt6sXYBO4VuZu4Zv
X-Google-Smtp-Source: AGHT+IH1VHE71/lHwhzb/iKA535tctnYgWJ2tyPLQHN033vMoho30MnYYNcQ3Od1eJvJie4Wjzje9Sne4POA6936oCE=
X-Received: by 2002:a05:600c:1e22:b0:426:68ce:c97a with SMTP id
 5b1f17b1804b1-430c3aa66f9mr363245e9.7.1728423368256; Tue, 08 Oct 2024
 14:36:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001191811.1934900-1-calvinwan@google.com> <xmqqo743qkn9.fsf@gitster.g>
In-Reply-To: <xmqqo743qkn9.fsf@gitster.g>
From: Calvin Wan <calvinwan@google.com>
Date: Tue, 8 Oct 2024 14:35:56 -0700
Message-ID: <CAFySSZCyoaKCGycYgJjCJGJ2mV1yfg+gVFb7RytGKmkjupkNkQ@mail.gmail.com>
Subject: Re: Missing Promisor Objects in Partial Repo Design Doc
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <chriscool@tuxfamily.org>, Han Young <hanyang.tony@bytedance.com>, 
	git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Enrico Mrass <emrass@google.com>, sokcevic@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 7:54=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> True.  Will it become even worse, if a protocol extension Christian
> proposes starts suggesting a repository that is not lazy to add a
> promisor remote?  In such a set-up, perhaps all history leading to
> C2b down to the root are local, but C3 may have come from a promisor
> remote (hence in a promisor pack).

Yes if we and consequently Git considers this state to be problematic.

> > Bad State Solutions
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Fetch negotiation
> > -----------------
> > Implemented at
> > https://lore.kernel.org/git/20240919234741.1317946-1-calvinwan@google.c=
om/
> >
> > During fetch negotiation, if a commit is not in a promisor pack and
> > therefore local, do not declare it as "have" so they can be fetched int=
o
> > a promisor pack.
> >
> > Cost:
> > - Creation of set of promisor pack objects (by iterating through every
> >   .idx of promisor packs)
>
> What is "promisor PACK objects"?  Is it different from the "promisor
> objects" (i.e. what I called the useless definition above)?

Objects that are in promisor packs, specifically the ones that have the
flag, packed_git::pack_promisor, set. However, since this design doc
was sent out, it turns out the creation of a set of promisor pack objects
in a large repository (such as Android or Chrome) is very expensive, so
this design is infeasible in my opinion.

>
> > - Refetch number of local commits
> >
> > Pros: Implementation is simple, client doesn=E2=80=99t have to repack, =
prevents
> > state from ever occurring in the repository.
> >
> > Cons: Network cost of refetching could be high if many local commits
> > need to be refetched.
>
> What if we get into the same state by creating local C4, which gets
> to outside and on top of which C5 is built, which is now sitting at
> the tip of the remote history and we fetch from them?  In order to
> include C4 in the "promisor pack", we refrain from saying C4 is a
> "have" for us and refetch.  Would C2 be fetched again?
>
> I do not think C2 would be, because we made it an object in a
> promisor pack when we "fixed" the history for C3.
>
> So the cost will not grow proportionally to the depth of the
> history, which makes it OK from my point of view.

Correct, the cost of refetching is only a one time cost, but
unfortunately creation of a set of promisor pack objects isn't.

>
> > Garbage Collection repack
> > -------------------------
> > Not yet implemented.
> >
> > Same concept at =E2=80=9Cfetch repack=E2=80=9D, but happens during garb=
age collection
> > instead. The traversal is more expensive since we no longer have access
> > to what was recently fetched so we have to traverse through all promiso=
r
> > packs to collect tips of =E2=80=9Cbad=E2=80=9D history.
>
> In other words, with the status quo, "git gc" that attempts to
> repack "objects in promisor packs" and "other objects that did not
> get repacked in the step that repack objects in promisor packs"
> separately, it implements the latter in a buggy way and discards
> some objects.  And fixing that bug by doing the right thing is
> expensive.
>
> Stepping back a bit, why is the loss of C2a/C2b/C2 a problem after
> "git gc"?  Wouldn't these "missing" objects be lazily fetchable, now
> C3 is known to the remote and the remote promises everything
> reachable from what they offer are (re)fetchable from them?  IOW, is
> this a correctness issue, or only performance issue (of having to
> re-fetch what we once locally had)?

My first thought is that from both the user and developer perspective,
we don't expect our reachable objects to be gc'ed. So all of the "bad
state" solutions work to ensure that that isn't the case in some way or
form. However, if it turns out that all of these solutions are much more
expensive and disruptive to the user than accepting that local objects
can be gc'ed and JIT refetching, then the latter seems much more
palatable. It is inevitable that we take some performance hit to fix this
problem and we may just have to accept this as one of the costs of
having partial clones to begin with.

>
> > Cons: Packing local objects into promisor packs means that it is no
> > longer possible to detect if an object is missing due to repository
> > corruption or because we need to fetch it from a promisor remote.
>
> Is this true?  Can we tell, when trying to access C2a/C2b/C2 after
> the current version of "git gc" removes them from the local object
> store, that they are missing due to repository corruption?  After
> all, C3 can reach them so wouldn't it be possible for us to fetch
> them from the promisor remote?

I should be more clear that "detecting if an object is missing due to
repository corruption" refers to fsck currently not having the
functionality to do that. We are "accidentally" discovering the
corruption when we try to access the missing object, but we can
still fetch them from the promisor remote afterwards.

> After a lazy clone that omits a lot of objects acquires many objects
> over time by fetching missing objects on demand, wouldn't we want to
> have an option to "slim" the local repository by discarding some of
> these objects (the ones that are least frequently used), relying on
> the promise by the promisor remote that even if we did so, they can
> be fetched again?  Can we treat loss of C2a/C2b/C2 as if such a
> feature prematurely kicked in?  Or are we failing to refetch them
> for some reason?

Yes if such a feature existed, then it would be feasible and a possible
solution for this issue (I'm leaning quite towards this now after testing
out some of the other designs).
