Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C44F1C302B
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728057030; cv=none; b=SSDB1kHwHZnK8zKxkYfS2kA/G8QlHJtIwZQGB5D6SUpuFx3QgO6RL2wDZlrdtUe6M2d9Unb3dLZVzc+8sUYZ1S4s2OHJFekfjUO7p8LuBuJNzBpS+i49r8+kVsMS9kW9G8AMOVBl1h5M6alRYQq1IDNTzXdYjZvdw1xI9FglRDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728057030; c=relaxed/simple;
	bh=fly3VhnxwMrScMD+Ez5GSDIqy4+/pl13k0Ce2TpEcEE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WxXWgpRl+oxXZzfoVI7JqnoZXp2jx7/KkPde3wuOJ11Ozf4csKY7/RjuMppXf+qrDJhop15zLGxHArKeWVKYELdm5jiNo3WstxBV3HjJ0/5toVlTR/8DzAKHKP/UZYyJQjpkiXSY4NZLiqovofs9vbqiXFzOksUv79NNTG1KFV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jH3RgKV9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VKw5NC99; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jH3RgKV9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VKw5NC99"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4DB7813802B2;
	Fri,  4 Oct 2024 11:50:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 04 Oct 2024 11:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728057028; x=1728143428; bh=viIj+TVY7Q
	IIdgMscWLOjYg7uRO7Lf6+PSk5aDYLIsY=; b=jH3RgKV9GfXBRAzK/VvVFsRvJ/
	netzQEQlbwwDETNh6ewKm1oR2qn4BQhj+cbxmFP2TCLPVcp6BkkOTtTzE5wglc6q
	1bwZ8Au879bcFE+VOH2ex8TsJs2k/GpmvKokJUe1pYmApeL91d9i6iGtxIa1Lew2
	9uT8hz/EyTFZwlha/h3FGyewPIjeLbXZBd38R2VcmgPvTZ1sUI9Wh0wLCBlpDpZn
	833QzleXBysfYp2YW63TYxml2WK3oaki1ZPY6TOi5pQvKjBSgBWRDsmGGyKBiR4z
	aUiUar3/YxM4TRle7utyBujN1zsBLnRmuO6flYKLUT29Bu1DPmOqoa4dgXGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728057028; x=1728143428; bh=viIj+TVY7QIIdgMscWLOjYg7uRO7
	Lf6+PSk5aDYLIsY=; b=VKw5NC99I0kAor9MN/kepbsaU7iJGmrA1yWcP8PWYhWl
	/Ijjkft11oYv4ANfBYAhaipHh15QnBu032dtHrryG+vmUrJ7zYloTC9j3iYY4GVv
	hAdo+JgmRMUfOL4AXuUysK6FqRk2hx/UCYbIlbVLkKDefC5hcnqqGIVWO45qMbry
	Gz+PWgZiP9Rabn3HRlmzznCONtuVIOyEzzDbL91eDR71qJFGYXHY4shaCIoCxAfi
	gj4XVg3qt6Mn76VSD7k7JNohnYsKi8K7RagHsvKbAPHNhiheb0xTGIJ6czYv6Mwa
	/jco9MH51YkskAO6HoIgfF1ij8F8fBZd6uJmzLiwuQ==
X-ME-Sender: <xms:ww4AZ8lz00RrRPy-AM1SgR1XxWF6wgHHIqvjEwkAYXcihVXmnGKwTw>
    <xme:ww4AZ73-UJsQV8BCSVIM_PTqTmOhQBCtzC4_hBmNLrX0Lw0qUNlraOiXv1WniK2E8
    HxLrn0mhh_hhn_-4A>
X-ME-Received: <xmr:ww4AZ6qc9pnMw7BxjAbFkiSIqx7yaHU8WGz0Q9Ppw0HTGZ7-lRo3pZ7vtI4BC3kvg4AeUBKl69UFGgUB1ecAcSHEY0WGnZnQWWFVxKc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhu
    nhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuh
    hnvghlmhdrohhrghdruhhkpdhrtghpthhtoheprhhushhsvghllhdoghhithdrvhhgvghr
    rdhkvghrnhgvlhdrohhrghesshhtuhgrrhhtrdhiugdrrghupdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:ww4AZ4ncXDzgvPyrgBvDdYIEiku6cbCWi7tw2nXRZzHtUDHVThR56w>
    <xmx:ww4AZ63APHpqJjP8vIsXIvX7IIqFu_VbSDYHDDNYNT83AUOCxD3CXQ>
    <xmx:ww4AZ_sTXMdEKvFiZnwlig54AGPrffXmG26cHPl90FLFCS5N3gx61Q>
    <xmx:ww4AZ2WVKSSZcjAnN3bPL1j2lQNoWe1yeQDJaSE0KSgdiZ135vNzmg>
    <xmx:xA4AZ0pdGaODwiokdDM1PDBEbIuTKayADcAwNvngw3nui8ucv-beaYKn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 11:50:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Eric Sunshine <sunshine@sunshineco.com>,  phillip.wood@dunelm.org.uk,
  Russell Stuart <russell+git.vger.kernel.org@stuart.id.au>,
  git@vger.kernel.org
Subject: Re: "git worktree repair" modifies the wrong repository
In-Reply-To: <6c0b8681-95ca-4224-ba89-7582fd731565@gmail.com> (phillip's
	message of "Fri, 4 Oct 2024 10:15:55 +0100")
References: <E1sr5iF-0007zV-2k@binarylane-bailey.stuart.id.au>
	<CAPig+cQ8=Y6sVvN_dBo_GQ5nLkQ4GJ7AM6mE2kt_2QV7CR0omg@mail.gmail.com>
	<3b579ddd-b386-4daa-ad63-1e75522b7462@stuart.id.au>
	<CAPig+cTkpLLoTxTa-8xfycNGFibN_M71+kkHtT-wgp6HRPi-aw@mail.gmail.com>
	<4781ff6e-c20a-4340-851b-c9d324d1fac8@stuart.id.au>
	<CAPig+cTop=2+k0XbqYbsCTbJVo77evY+_a+FqDV_ziKf2q+Dzw@mail.gmail.com>
	<87afa860-52f4-414a-82da-09e7eeac1301@gmail.com>
	<CAPig+cSSDnq_kh9ERuYZmUCNrVvWmGFF8OSfBCy8bHrkx6fz3g@mail.gmail.com>
	<6c0b8681-95ca-4224-ba89-7582fd731565@gmail.com>
Date: Fri, 04 Oct 2024 08:50:26 -0700
Message-ID: <xmqqo73zg94t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

phillip.wood123@gmail.com writes:

> "git clone --mirror" sets up a fetch refspec that forcibly update
> "refs/heads/*" when fetching. This means fetching overwrites your
> local branches and I think the fetch fails if you have a branch
> checked out that it wants to update. "git clone --bare" does not set
> up any fetch refspec. In both cases there are no remote tracking
> branches to base your local work on.
>
>> Regarding core.bare: That's one of the settings which is special-cased
>> (hard-coded) to work "properly" when extensions.worktreeConfig is not
>> enabled, so it's not clear what problem you were experiencing in that
>> regard. In my testing, `git rev-parse --is-bare-repository` correctly
>> reported "true" in the bare repository, and "false" in a worktree
>> hanging off the bare repository even when extensions.worktreeConfig
>> was not enabled.
>
> I've a feeling I thought I needed to set it because I didn't realize
> that core.bare was special cased rather than doing so in response to a
> particular problem but I can't remember for sure.

I recently encountered a funny behaviour in a worktree linked to a
bare repository.

    $ git clone --bare file://$(pwd)/git.git victim-00.git
    $ git -C victim-00.git worktree add ../victim-01
    $ cd victim-01
    $ git grep -i -e subscribe
    fatal: this operation must be run in a work tree

Of course, "git grep -i subscribe HEAD" works (as it does not
require a working tree and works on a proper bare repository).

What is curious is that this also works:

    $ git grep -i -e subscribe --cached

That mode of operation can work only when the index exists,
which means it needs a working tree.  Perhaps the working tree
version is written in a more strict way to avoid unexpected
behaviour (and gets the implementation of strictness wrong), while
the index version has no such protection?  Running the index version
in the bare repository

    $ git -C ../victim-00.git -i -e subscribe --cached; echo $?
    1

seems to confirm.  The command does not fail, but in a bare
repository, the in-core the_index has 0 elements, so it thinks it
successfully looked for the needle in the haystack and found
nothing, without complaining "hey, there is no haystack".

With the extensions.worktreeConfig things work as expected in the
worktree linked to the bare repository, like so:

    $ cd ../victim-01
    $ git config set extensions.worktreeConfig true
    $ git config set core.bare false
    $ git grep -i -e subscribe

So, I dunno.  Is core.bare really "special cased"?  It seems to me
that any halfway special case harms users more than helps.


