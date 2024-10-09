Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451F41A3049
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728499996; cv=none; b=TvS8cojjHPeyWilqDn1y8pb684onxllqT5prjTpfpQRUG8kJamuznUtURY+41N7hlzWdCpecmdK12nh8nSPjMMVFOWO0EOdo3wP5cBvlSI3wX2IwzuJMheOB1XYo/cr2x2yrbGOXTM7jHBqt8rhiGCotYsumUvYb4wHJ83iQANQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728499996; c=relaxed/simple;
	bh=wuO3RteMmfO62rTPtcik/AyYCmdrio60oKITZj/3aog=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=hRzpsT/GNHYe/2A8wF5/fMbLFsnHhnEnQ0QGJSUchLEF5eftwaXR3EIaDtCI8sbHYDWgncKD1mZYQNIt0pzvfGuFBloBu23CZ7AXbQcmvSdTRYrzkyJtykF5yYU8/ggQTzxY8MKvo2ops0znLiTNht9/i5ngAv3iRwXPfr1lyc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uAKL/tkf; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uAKL/tkf"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e284982a31so5379607b3.3
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 11:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728499994; x=1729104794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BeGrDgyyZOvzNm/y8AQhg+s4E+vlbIfgfdiqEnN6lTA=;
        b=uAKL/tkfgVxoKLwTcbWlnlQjdvBoXlTYEzLDMYuSZOg3K2p9l5MNY0fcoglwONvY7r
         A/QWE7LIU/byn62j/rldskGuL19qCy1EK07miGPc4nfNhvcsT8OmoFldC0ncSxnhi52c
         ub6CAD+oLGZTqEzg3DzcQo0z4Ndc01fIZfgZtP1BC/4ht2lqdGB1kyCSoLFHzJNx68KN
         nGT2s2brEIBZ9YcVSAFgUKwZlfSoka8sIWbcl+lEv3INETYb3ExKzNZOYKSquPqExvBV
         ncAXc5tfBx4qVlf42oMG2/0eO8dSkhdPbC/QePkstsk3FgXe7p7hoVcgbGQmL4rascOl
         NZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728499994; x=1729104794;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BeGrDgyyZOvzNm/y8AQhg+s4E+vlbIfgfdiqEnN6lTA=;
        b=V3nMugk3U231yfO100dHR7ptK2PdaUNS7In4QvQN2L4RUVqLiUPyr9N4Z4gwEu9yDO
         ZYxLboPwNg//sVkPvAyzbrJasHdPvXPix309tUyKr7IJyzJZPaXPtRcrkFZKPx5WhKt2
         DB1p/vG7DbFomz/8td2MPVOQkgixpBfNQy217t+r2sFQgTZMYdu98uSkdACh92nDSXcD
         8HssxyWlJ9IcbrJd3cksZ8sXUHWOx0uTxzg0McrQ+L7joXPy2lMMVvRsz2u+SRRbm3XS
         zl5P8oRaCmwP3To/2gCqs759MhrhneF44o6zkr9oBD9F+rV2C4LLhN9zvMP130t3iLsr
         oUmg==
X-Forwarded-Encrypted: i=1; AJvYcCU5GaIYDot4V55pO15ZlgdrFfvA3Yb2g+70YR3skpBO1ClbG7cR2XnxEb3um6D/TxSOVU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrMA52OFaK0H2mTP64J/cuER1UBHuaR3GYimkqxYpfHgTMFMIS
	MbprHNVHG+PrQOAneTylcBIxqpOwWbBeH1SO1fFj08sGaqgY9NLjfAOG8p7DKKhydjGgDjbcl/N
	w5YnwlNOVVwjhgIkrKbUhyFqIr+PsVA==
X-Google-Smtp-Source: AGHT+IF8fuVZrh85aZ/hUkDkRMZkmx4LhlR7Izptkh4BFXQjsEsVGIKhVDRxtEhT5lvLCHhMw3W4cW5nLflWtuSqpCfG
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:424d:d3f9:36a6:1e7d])
 (user=jonathantanmy job=sendgmr) by 2002:a81:ad16:0:b0:6c1:298e:5a7 with SMTP
 id 00721157ae682-6e3224662ffmr815907b3.5.1728499994114; Wed, 09 Oct 2024
 11:53:14 -0700 (PDT)
Date: Wed,  9 Oct 2024 11:53:11 -0700
In-Reply-To: <xmqqo743qkn9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009185312.200629-1-jonathantanmy@google.com>
Subject: Re: Missing Promisor Objects in Partial Repo Design Doc
From: Jonathan Tan <jonathantanmy@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, Calvin Wan <calvinwan@google.com>, 
	Christian Couder <chriscool@tuxfamily.org>, Han Young <hanyang.tony@bytedance.com>, 
	git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, 
	Enrico Mrass <emrass@google.com>, sokcevic@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:
> > (C2b is a bit of a special case. Despite not being in a promisor pack,
> > it is still considered to be a promisor object since C3 directly
> > references it.)
>=20
> Yes, and I suspect the root cause of this confusion is because
> "promisor object", as defined today, is a flawed concept.  If C2b
> were pointed by a local ref, just like the case the ref points at
> C2a, they should be treated the same way, as both of them are
> locally created.  To put it another way, presumably the local have
> already been pushed out to elsewhere and the promisor remote got
> hold of them, and that is why C3 can build on top of them.  And the
> fact C2b is directly reachable from C3 and C2a is not should not
> have any relevance if C2a or C2b are not _included_ in promisor
> packs (hence both of them need to be included in the local pack).
>=20
> Two concepts that would have been useful are (1) objects that are in
> promisor packs and (2) objects that are reachable from an object
> that is in a promisor pack.  I do not see how the current definition
> of "promisor objects" (i.e. in a promisor pack, or one hop from an
> object in a promisor pack) is useful in any context.

The one-hop part in the current definition is meant to (a) explain what
objects the client knows the remote has (in theory the client has no
knowledge of objects beyond the first hop, but we now know this theory
to not be true) and (b) explain what objects a non-promisor object can
reference (in particular, a non-promisor tree can reference promisor
blobs, even when our knowledge of that promisor blob only comes from a
tree in a promisor pack).

If we think that a promisor commit being a child of a non-promisor
commit as a "bad state" that needs to be fixed [1], then the one-hop
current definition seems to be equivalent to (2).

As for (1), we do use that concept in Git, although it's limited to the
repack during GC (or maybe there are others that I don't recall), so the
concept doesn't have a widely-used name like "promisor object".

[1] https://lore.kernel.org/git/20241001191811.1934900-1-calvinwan@google.c=
om/

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
>=20
> In other words, with the status quo, "git gc" that attempts to
> repack "objects in promisor packs" and "other objects that did not
> get repacked in the step that repack objects in promisor packs"
> separately, it implements the latter in a buggy way and discards
> some objects.  And fixing that bug by doing the right thing is
> expensive.
>=20
> Stepping back a bit, why is the loss of C2a/C2b/C2 a problem after
> "git gc"?  Wouldn't these "missing" objects be lazily fetchable, now
> C3 is known to the remote and the remote promises everything
> reachable from what they offer are (re)fetchable from them?  IOW, is
> this a correctness issue, or only performance issue (of having to
> re-fetch what we once locally had)?

I believe the re-fetch didn't happen because it was run from a command
with fetch_if_missing=3D0. (But even if we decide that we shouldn't use
fetch_if_missing, and then change all commands to not use it, there
still remains the performance issue, so we should still fix it.)

> > Cons: Packing local objects into promisor packs means that it is no
> > longer possible to detect if an object is missing due to repository
> > corruption or because we need to fetch it from a promisor remote.
>=20
> Is this true?  Can we tell, when trying to access C2a/C2b/C2 after
> the current version of "git gc" removes them from the local object
> store, that they are missing due to repository corruption?  After
> all, C3 can reach them so wouldn't it be possible for us to fetch
> them from the promisor remote?
>=20
> After a lazy clone that omits a lot of objects acquires many objects
> over time by fetching missing objects on demand, wouldn't we want to
> have an option to "slim" the local repository by discarding some of
> these objects (the ones that are least frequently used), relying on
> the promise by the promisor remote that even if we did so, they can
> be fetched again?  Can we treat loss of C2a/C2b/C2 as if such a
> feature prematurely kicked in?  Or are we failing to refetch them
> for some reason?

This is under the "repack all" option, which states that we repack all
objects (wherever they came from) into promisor packs. If we locally
created commit A and then its child commit B, and the repo got corrupted
so that we lost A, repacking all objects would mean that we could never
detect that the loss of A is problematic.

