Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC14419D080
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 13:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729602210; cv=none; b=j7TICvl/0qD0jCPhctxWuTbFDf8ARCEi8hlyEAsY9laaT8FUzORzzzMTg8rluM6BuVjHv9eqztOhQf//JW9uzQqHls+oxUdpkYwDTsfPYshZ1GeYD0zfT9mUoGtQ7ETbqZqzss2L3JpqWENZ0dP9o/rM+8ryjAff6B/ZMMyExoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729602210; c=relaxed/simple;
	bh=Oig1bR2SPyDaXrlwopN+rLenaXy/mw6KTQdCGMN36oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEximECVwookSZkj9aCB3+j2rQyRfuN5+ap8VzWc57uwhO7ubC9QS7XDKLnem1/Od5v0axc0FtqJCZMbHfQqaMw51PMT5cQdJLxciziRFgGvvjHpjzvn728V2Kd+FLp5KoZqKTlSWBCQLZX9aFcCPcQBrmqb4X75bS51s0hwPLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F27cLgEp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HH1fkWJO; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F27cLgEp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HH1fkWJO"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C809511401EB;
	Tue, 22 Oct 2024 09:03:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 22 Oct 2024 09:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729602207; x=1729688607; bh=Gxs4sWsxg8
	NFuewtP+gjb0jK1e9wgw39QpeaM+lE3X0=; b=F27cLgEpCZ3Pvk+MighKvtm1bG
	j3HD0O6+pqd85sxkMuPL9tR97GisMJHOtJWxhTj1mHHJ5yVA2wN1mb03qBaQydrd
	LGUEBEW/StE/UbG8+OsqcM7b+X7e9+uifGcRz7hfPQyQFbFS0ytlpLNtNQUBx2qo
	lM+D4rZkkSe5+AjShWbM3tutxIBo5JNP6ZXNK1hP1Pn1F3C8c+Bg5Z3doVMp2KhS
	OcUoiWCr9BiPY2UNi6oSp0jfhXF8K1GzOBmAaGDNfthKfq6TLLeTH+8Z2peWgjum
	s9XMVTUQj0PJrn7lZt5M8aG6dnimIjGJdtxV/RWCQ0QdYNZjc2DjDiKYe5PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729602207; x=1729688607; bh=Gxs4sWsxg8NFuewtP+gjb0jK1e9w
	gw39QpeaM+lE3X0=; b=HH1fkWJODPYvtDG9sjJ5fsKgA87i6dm3p09RFHZS83oa
	/WCCk6znhMdyqSwVrKWWrKZBnG6IxKP20XRcG8+g5jAkLoauwrwfKZp4qWssY9zO
	8jI0OmE0KW29jZNrOa9eYvjTyDNACnr+4U68BAka2GoiCh/CIc+pPQosiAWUYdci
	hwy6AI7ift02FI4GCIw4sU2qGyO4tA27305iOuHgzm9OZ9I3njR9nNsqV0cO+OzE
	FZ9Q7dIJUCOlloTGeqO7iv8n38CFx+fjym4VGHsDz22GE1FjetsQRYwWwWl0BN86
	ElrGYWZDOxgDVVUuj3/BQ94TknDzvyW5CjKuOJJoQw==
X-ME-Sender: <xms:n6IXZ6uv6ZAxeJErWvfUqSFHSQIR73GUqIQRYNkA39NamIuwZX2UjQ>
    <xme:n6IXZ_eJ7SrtJnxoayA11YRomvgEx2axrb2VI_G5WK5whQUaCJKjHDRtNZJp1-gJs
    KlbGzYcu7bnlY8nvQ>
X-ME-Received: <xmr:n6IXZ1wALAoTgqAVcWoMxUuMZOxy7nD8xImZNxsCp_ITJUDPUk2Ya0lUVqZVc_xSmpFyh3Gf_E1-ol05grjw4ZMaocCJjEhrV2JRygibRDcO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeihedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghmrhgrshhssehgohhoghhlvgdrtghomhdprhgtph
    htthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvghmihhl
    hihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopegtrghlvhhinhifrg
    hnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:n6IXZ1M7wj6JXgC-2_iRUKbOUAGbry7eFWWgB4ZG34T5YmxhxTZbvw>
    <xmx:n6IXZ6-YxyARHHLoadQiBGcvNatL91Rddvi_Mn46Y7jD-OY3Y7FVgA>
    <xmx:n6IXZ9XYY0yaVMb-UCIIzNzxJHGmzeJcgOSdK7DKTdy_-xK1WRwIDQ>
    <xmx:n6IXZzdCTEjlJK9eOEwtumokB9ZTXFYQXipiXYRWne9ZzqWLg8tejQ>
    <xmx:n6IXZxk8IO9b_v4Jo2zyVadfHpbDbItVPQOtaUYxMNl0PWuGoBVNK6vv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Oct 2024 09:03:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 81f82daf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 22 Oct 2024 13:01:54 +0000 (UTC)
Date: Tue, 22 Oct 2024 15:03:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Calvin Wan <calvinwan@google.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Emily Shaffer <emilyshaffer@google.com>,
	Josh Steadmon <steadmon@google.com>,
	Enrico Mrass <emrass@google.com>
Subject: Re: Question about `git gc` locking files
Message-ID: <ZxeilMDwq0Z3krhz@pks.im>
References: <CAFySSZBCKUiY5DO3fz340a0dTb0zUDNKxaTYU0LAqsBD2RMwSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFySSZBCKUiY5DO3fz340a0dTb0zUDNKxaTYU0LAqsBD2RMwSg@mail.gmail.com>

On Mon, Oct 21, 2024 at 03:55:45PM -0700, Calvin Wan wrote:
> Recently, after upgrading to 2.47.0, we had internal reports of users
> erroring out with:
> 
> fatal: cannot lock ref 'HEAD': Unable to create
> '<filepath>/.git/HEAD.lock': File exists.
> 
> We believe this is due to "(98077d06) run-command: fix detaching when
> running auto maintenance", since we have neither `gc.autoDetach` nor
> `maintenance.autoDetach` set.

git-maintenance(1) detaches itself by default unless told not to via the
config keys that you mention.

> When this bug was fixed, the maintenance runs that triggered during
> usage of the external tool, repo[1], would lock the HEAD file in the
> Android manifest repository thereby erroring out `repo`. Additionally,
> long running maintenance tasks would also cause users to frequently
> run into this issue when using git commands that are written to HEAD.

It is a bit surprising that HEAD would need to be locked in the first
place. As far as I am aware, the only step where we end up locking refs
in the context of git-gc(1) would be when we decide to repack refs via
git-pack-refs(1). And that command shouldn't ever end up packing the
HEAD file, as that loose reference must exist

Digging a bit deeper surfaces that it's `git reflog expire --all` that
causes us to lock HEAD, which is... unfortunate. Seemingly, relfogs are
locked by locking the corresponding reference.

> We can fix this easily temporarily by pushing out config changes to
> run in the foreground, however, I was under the impression that `git
> gc`, whether invoked normally or through `git maintenance`, would be
> able to run in parallel with other git commands and therefore not
> lock. There is no mention of this in the documentation for `git gc`,
> but I do see it in the `git maintenance` documentation. So should `git
> gc` be locking the HEAD file in the first place? And if so, is there a
> way for `git gc` to have less of a dependence on HEAD.lock?

So what seems to be happening is that you have two processes racing with
each other: one that is trying to expire entries from your "HEAD"
reflog, and the one invoked by the user to update "HEAD". By default,
Git will wait up to 100ms for the "HEAD" lock to be released, but it
seems like expiring the reflog for your "HEAD" takes longer than that.
You can work around that issue by increasing "core.filesRefLockTimeout".

But this whole thing uncovers an issue with git-maintenance(1) itself.
The above commit fixed how git-maintenance(1) behaves such that we
detach at the correct point in time. But what it neglects is that some
tasks are more special than others and should be run synchronously
whereas others can be run asynchronously. Packing refs and expiring the
reflog are tasks that should be run synchronously to minimize the impact
on users.

This all demonstrates that git-maintenance(1) needs to get some more
love. You have uncovered this issue with git-gc(1) as configured task,
but we have a similar fundamental issue with the git-pack-refs(1)
subtask. So I guess we'll have to classify those subtasks into two
categories, where one category needs to be executed before detaching
itself and another category can be executed asynchronously after we have
detached.

Patrick
