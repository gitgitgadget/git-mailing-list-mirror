Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C084C185935
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 07:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735888617; cv=none; b=j0qwJFkZtyeLUpaLcCK5ehrOB3CPOpCtiW7eDzcUdMKi+DhibGajM4254X7qJpYC5DE9uMdMhAFYjRVPFJL/6US8183ghDipN1V3LyBc7WGVB86wPMyI4Som3p+S/+fPxmTrdpgtWRtRfnXg9kv7AmYTkP9vIkuX38qx5MOtRk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735888617; c=relaxed/simple;
	bh=1M6i4JgdGws8ENnvbzawHSpFL4x9OZP3mSalMI3VFOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrj5wr0b3yoVw8u/h9iAOgOwWsJ5pFoDVzaRQGjj7aZvLmQfvRDekESAnajshwKOj9Vzt4xEZjnXwCDf9PYSCn6Ay/uniRKhkzmMcSX0qt4S4kfmPZ/rK2qcadKOR4ElpkQHbHDcVevx/iFFlxBW2WZHle4Sl9ikoYdM+WIJBTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KFGtxlmJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SZU5isqz; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KFGtxlmJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SZU5isqz"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 95C521380345;
	Fri,  3 Jan 2025 02:16:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 03 Jan 2025 02:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735888612; x=1735975012; bh=D0nIUF6KaH
	zDp1Js9ny5KRUDnGxKLAP7fo1Xexe64m0=; b=KFGtxlmJgN+xtUGn5vxjp3fUBz
	HXB/V4jG90doiYAb9OVu7To+Jpc2LHhVO7wF4teK4JgFrwo/CeJ2OiTMtQ6zrl7W
	f7trjCyT9r1D2qbIgbWUowkNs7NWOMNfQtgDtnaV5d4OXEHe4LwRGWqJqIl4VeDd
	6LLZPNDRsyIeXc4TosORTy/1Y6oJ3V2tieS0eddotQp9tPgKUOA5oz5VB0MwF6lu
	OnC7ujONR8zhtLBNSIDKPoHKT2nhKRcO5IeJXEM6mozgdZQnsW8oZnjWP8iOQybn
	CnFwNfL/816sbS8EF13Jg50YhXlIZ07MIIw41DTf7W7ea7GwnKPaVFwTNFxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735888612; x=1735975012; bh=D0nIUF6KaHzDp1Js9ny5KRUDnGxKLAP7fo1
	Xexe64m0=; b=SZU5isqzBynxOA6bqzwsEBZfXMBo/kHX86PrTHW2u7Tj5Q3EMt4
	wiT1B3yXhU0wn5cymM+ArPfPh5v/aMGO0BT1hUuDjclICnrNFk6VAiMJ9sbUrzq3
	2Dwl+p5frlpIHSYTM9GzpXT6rJKEAPYsJ2xfR794ZfKfFZpsHdEKsEcWAvfQcSGl
	x78qhIlYw4J1dpLGW0andmIDQd+xBfVQ6GXFkTcvn+RQKVyOXjF67nnFWwph0JVi
	KBnB/YHYUryk90Gs7nb0bivahBCO/9oqTVVNa7g3BreXOnTo2lMCk+cyIgHDKjvk
	xjmY5fbNBXRymypenLQSUYNWz3mgJ41pNXQ==
X-ME-Sender: <xms:5I53Z2c1CAR_RQNhCJAkNep-Vn6D2DkrSLtujEdhC8UZeJFFw8EZ0A>
    <xme:5I53ZwNjY-ytKJmwhja4UsQEbVCNm9d38WbVtS-VNwd4cPDnIaiFn2Xb2k0VTTWBF
    MDCfxsQAZhj1U6Scg>
X-ME-Received: <xmr:5I53Z3gyask6JlWwzv-XogTwzAIEzVfKcEqyIGaGcCsG6gJMzn1Vjs69TW6mP-7LED-5kU0YWKNd4q5QEdPws9DY8cb-oVO2zRJJ5HSoJ10PvTY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeffedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:5I53Zz-5EgdR3ojL6Brp5N9NcYAhi0XrhBY1fUl3znJ40VHPC1HifQ>
    <xmx:5I53Zys-v3kzUkO2vdyD6veBU4GIvT_9yAUw5XrHVyyD8YMgfiBuig>
    <xmx:5I53Z6G20sKxVO8L_uA5tN0W-A9Kq0C4fAtYvRsLEnxmfHtK3cBogg>
    <xmx:5I53ZxP61bCurkGuRgNeAeIvfJ1i4gVyzBLP1VoyQ9qP3vFFsUT-dg>
    <xmx:5I53Z0KYl_hRpqUQPHRky3_sqexftIvo4pcn1yJlnn1Dn60Q9PlrcERY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 02:16:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c8acc634 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jan 2025 07:16:49 +0000 (UTC)
Date: Fri, 3 Jan 2025 08:16:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] object-file: fix race in object collision check
Message-ID: <Z3eO2zxDOzbbFFNk@pks.im>
References: <20241230-b4-pks-object-file-racy-collision-check-v1-1-11571294e60a@pks.im>
 <xmqqy0zxz11m.fsf@gitster.g>
 <Z3KzHJagr_3Fkz67@pks.im>
 <20241231014220.GA225521@coredump.intra.peff.net>
 <xmqq7c7exytw.fsf@gitster.g>
 <20250101181952.GA1391912@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250101181952.GA1391912@coredump.intra.peff.net>

On Wed, Jan 01, 2025 at 01:19:52PM -0500, Jeff King wrote:
> On Wed, Jan 01, 2025 at 08:50:51AM -0800, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > There is one gotcha here, though. We call this collision check only if
> > > we got EEXIST trying to move the tempfile into place. If the destination
> > > file then goes away, we can't do the collision check. But is it right to
> > > quietly return success?
> > >
> > > If the contents of the two were the same, that's fine. We don't need the
> > > extra copy.
> > >
> > > But if the contents were not the same, we'd prefer either to actually
> > > copy the contents into place, or to return an error.
> > >
> > > Of course we can't know, because the destination file has gone away. In
> > > the common case they will be the same, but the whole point of this check
> > > is to allow loosening the cryptographic collision of the packfile
> > > contents. So the safest thing would be to retain the tempfile, copying
> > > it into the destination file. That errs on the side of keeping data when
> > > we cannot make a determination.
> > >
> > > IOW, if we see ENOENT on filename_b, should we then loop back in the
> > > caller to try the link() again?
> > 
> > Yuck, I think you're absolutely right.
> 
> So I think this part, if adjusted as I suggested, would fix the race in
> the tests without making anything worse (it's just more code).

Hm, okay, I think that makes sense. Instead of being optimistic like my
first version was we should be pessimistic and assume the worst. Which I
guess is a sensible stance to take in a collision check.

> And then this...
> 
> > > I think check_collision() is used _after_ the attempt to rename() into
> > > place. So there's a race when the tempfile goes away, but I think the
> > > outcome is made a bit worse by your patch.
> > >
> > > Consider a sequence like this:
> > >
> > >   a. Process A writes tmp_pack_foo.
> > >
> > >   b. Process A tries to link tmp_pack_foo to pack-<hash> but finds it
> > >      already exists.
> > >
> > >   c. Process A opens both tmp_pack_foo and pack-<hash>.
> > >
> > >   d. Process A compares the two byte-for-byte, and then returns
> > >      success/failure based on whether they were actually identical.
> > >
> > > Now imagine there is a process B that deletes the file (maybe an
> > > over-zealous "gc --prune=now" deletes the in-use temporary file):
> > >
> > >  - if process B deletes it between steps (a) and (b), process A returns
> > >    an error (there is nothing to link). The caller knows that the data
> > >    was not stored.
> > >
> > >  - if process B deletes it between (b) and (c), then before your patch
> > >    we see an error (because we can't compare the files). After your
> > >    patch, we continue on and return success. The caller knows the data
> > >    was stored (via the original file, not our new copy).
> > >
> > >  - if process B deletes it between (c) and (d), then process A has no
> > >    idea. But at this point it does not matter. If the files were
> > >    identical, we return success (and in fact, process A deletes the file
> > >    itself). And if not identical, then we return error, and the callers
> > >    knows the data was not stored.
> > >
> > > So even though the exact behavior may depend on where we hit the race, I
> > > think ignoring an ENOENT open() error on the tempfile meaningfully
> > > changes what happens in the middle case.
> > >
> > > In practice I don't really expect this to happen, and "gc --prune=now"
> > > is inherently risky in a live repository. But I think we're probably
> > > better off to continue treating it as an error if we can't open our own
> > > tempfile.
> > 
> > So we'd ignore the racy and flaky tests, as hiding the flake by
> > ignoring the error would only hurt the real world users.
> 
> ...is all about ignoring ENOENT on the tmpfile itself. And I think we
> can just drop that hunk entirely. The tests do not care here (they are
> running simultaneous gc, but _not_ a simultaneous "--prune=now" gc).

Yeah, we don't need this hunk then.

I'll send a follow-up change.

Patrick
