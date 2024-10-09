Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BA818C92A
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728498900; cv=none; b=Z5HmwH/5zt9Y6wsDA1DRP/JinoOKvapzyRppBfYCHw7GjCGKq+MbjbLGLoY91zsCIv2pgxANkBOA7/agBKxwc0sErFwSfylzQ5Dgd8HBgVzUTsjfg8QUKn6iAtqQJZfaaJY9ep0kK43bYu9PWylBNx6rviVr0kQ/+987bCeqhzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728498900; c=relaxed/simple;
	bh=NZMSS/K22xfi8buPK8s2JzmLAFrA7K2nLNUNvdFpxcM=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=akYfqwxocSeP/7NETwrmJrjqDefq4vuUJ9HhLWcSCNubK+y7X2gI6+JweGZThOQFt8mALVCTC2g/FcuMX+8Voj/w8SS+qE+agxhyaeE8ARdlsODLxzDMzWepCTWWVb3eKNzItkZNc7sRBCzAjRWPfkuTz5AfGh9WfQUlZD2XAZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pQegiBUR; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQegiBUR"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28fc60660dso219380276.0
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 11:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728498898; x=1729103698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfPg2pCmBno9bewTXDrw6AhHNVs5CsAN2aWt8X4EX30=;
        b=pQegiBURRMjrZ9OhGFPKZcG/bcrLfvFJChXO5j9gGQvYN1HeOYltfYNVqHZS2qJZoA
         Bdcu+yh1dxPM1StPb1kT2InECWAyhGuzGKGQ+K8lfvYL9pwtnIUBvaW8TARufySjKGh8
         azmvMwnbrBNWJlHh1Qv7ogXtZQLfwjoKnIhG+ezKhkGfYaLymBXjBPNOVVMLI/0I/W3r
         715armO2DcHTLhazrSGnZEczt9OasaIO8hDgxRGWIPRKydFn5SoONdgbnM/qGgBNAHv3
         j+QKCD9B3aKLPnubBfmrkSuOC3VGw2tx0dasPVK5D+Zid55QMrtQRUi0fZacHR5Gxalu
         l+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728498898; x=1729103698;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jfPg2pCmBno9bewTXDrw6AhHNVs5CsAN2aWt8X4EX30=;
        b=iKiNOqa9TsNG0H06vCnaabFF0ou+Pw0j/ca6BqC2JdElaQfT7tJnCXZWgzMvplau7u
         01h2NZcYHj5W9YZmC8uRn5S0vjUutQPLRXHeO5Efdpb/oo8m4Y39A0Xw9pSa3dxv+Dv6
         pL/evyvvPtzM1q30bCIh/GpgOpnaGapuHrOPtDSh+5pnKZokyFcEzWYVQNrjOqIYvGaf
         oi6F2VYqQYSxClgqOsGg3A11B7cAGLz7CsgK5l+Yojvvc3EyQAHniO+IHQOHa+kAb/Aw
         0kIsmNhnypjKwlJrCo+H2GhrNmb7Gt78JES1wCYUREiBvNC+v8GjJZuRkk2pb7JdFvrU
         UMjA==
X-Forwarded-Encrypted: i=1; AJvYcCX3Q2x2Cx7wF7ZcMtOAyBTgTBy3b/kWC6nkADu8ec1O1KpfzdbbyWBp6QeIyv+sGgZnV8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaQx8+niG+GkfBqUJGYQA78I60IYnH2+QFYq1MZt6rr0TRt5jT
	rBPQ4R5d+/ouC/X2ThE/Jd8IxhKd6viFT/Q8uV1wqbOjzHQN/rbkl7fVOqE0JoQY97o2flm4K7B
	U6c3hC6M3Ii7E5Xza8y63jrpyjlPgyg==
X-Google-Smtp-Source: AGHT+IFSbtU16ih9/YwvoSTT249ZfhhziuGw6JcSlQdHMWmLeIV0zyuAqZxhugJDNC1eszzE4aemTizCiAGE+gR4YPCg
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:424d:d3f9:36a6:1e7d])
 (user=jonathantanmy job=sendgmr) by 2002:a25:83c3:0:b0:e20:1596:87b8 with
 SMTP id 3f1490d57ef6-e28fe473b09mr60486276.11.1728498898020; Wed, 09 Oct 2024
 11:34:58 -0700 (PDT)
Date: Wed,  9 Oct 2024 11:34:53 -0700
In-Reply-To: <CAG1j3zGcdfd6YRb=Fb1Aqt5kLajueagV+6upt6vwsGW9RxaR7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009183455.164222-1-jonathantanmy@google.com>
Subject: Re: [External] Re: Missing Promisor Objects in Partial Repo Design Doc
From: Jonathan Tan <jonathantanmy@google.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, Calvin Wan <calvinwan@google.com>, 
	Junio C Hamano <gitster@pobox.com>, Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Enrico Mrass <emrass@google.com>, sokcevic@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Han Young <hanyang.tony@bytedance.com> writes:
> On Wed, Oct 9, 2024 at 5:36=E2=80=AFAM Calvin Wan <calvinwan@google.com> =
wrote:
>=20
> > Objects that are in promisor packs, specifically the ones that have the
> > flag, packed_git::pack_promisor, set. However, since this design doc
> > was sent out, it turns out the creation of a set of promisor pack objec=
ts
> > in a large repository (such as Android or Chrome) is very expensive, so
> > this design is infeasible in my opinion.
>=20
> I wonder if a set of local loose/pack objects will be cheaper to construc=
t?
> Normally loose objects are always non-promisor objects, unless the user
> running something like `unpack-objects`.

We had a similar idea at $JOB. Note that you don't actually
need to create the set - when looking up an object using
oid_object_info_extended(), we know if it's a loose object and if not,
which pack it is in. The pack has a promisor bit that we can check.

Note that there is a possibility of a false positive. If the same object
is in two packs - one promisor and one non-promisor - I believe there's
no guarantee that one pack will be preferred. So we can see that the
object is in a non-promisor pack, but there's no guarantee that it's not
also in a promisor pack. For the omit-local-commits-in-"have" solution,
this is a fatal flaw (we absolutely must guarantee that we don't send
any promisor commits) but for the repack-on-fetch solution, this is no
big deal (we are looking for objects to repack into a promisor pack, and
repacking a promisor object into a promisor pack is perfectly file). For
this reason, I think the repack-on-fetch solution is the most promising
one so far.

Loose objects are always non-promisor objects, yes. (I don't think the
user running `unpack-objects` counts - the user running a command on a
packfile in the .git directory is out of scope, I think.)

> > > After a lazy clone that omits a lot of objects acquires many objects
> > > over time by fetching missing objects on demand, wouldn't we want to
> > > have an option to "slim" the local repository by discarding some of
> > > these objects (the ones that are least frequently used), relying on
> > > the promise by the promisor remote that even if we did so, they can
> > > be fetched again?  Can we treat loss of C2a/C2b/C2 as if such a
> > > feature prematurely kicked in?  Or are we failing to refetch them
> > > for some reason?
> >
> > Yes if such a feature existed, then it would be feasible and a possible
> > solution for this issue (I'm leaning quite towards this now after testi=
ng
> > out some of the other designs).
>=20
> Since no partial clone filter omits commit objects, we always assume
> commits are available in the codebase. `merge` reports "cannot merge
> unrelated history" if one of the commits is missing, instead of trying to
> fetch it.
> Another problem is current lazy fetching code does not report "haves"
> to remote, so a lazy fetching of commit ended up pulling all the trees,
> blobs associated with that commit.
> I also prefer the "fetching the missing objects" approach, making sure
> the repo has all the "correct" objects is difficult to get right.

If I remember correctly, our intention (or, at least, my intention)
of not treating missing commits differently was so that we don't limit
the solutions that we can implement. For example, we had the idea of
server-assisted merge base computation - this and other features would
make it feasible to omit commits locally. It has not been implemented,
though.
