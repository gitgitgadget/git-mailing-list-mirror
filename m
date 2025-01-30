Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1315145323
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738234283; cv=none; b=o0syALP2/IM3Fcy5ByJvlCt+7ykQpYE7iraaJY4vun4PElC3VHkSkUQ4e2ArFteZSZwm2+xYZAj/0fJ88v4P10a5yQWGRhYxLA1ktVqriLrQo0O4+64d6KV8hFk7yr5O0sdq0l3io5nBuCMpA26+UX8i89S+vAidyenSRy0ap+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738234283; c=relaxed/simple;
	bh=INHr6gDQCA5XTyaDol7+0ACG6n0ZLj5qhTtYjSueVlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN5TLt56DT9hBIOJSdZYL/SnTDuhHWoQrObZNITtN47Flnwp3mpmOvrbUrdtXHZLVqHT8KLhX0mi8z1/j1/anP+JFACFONha6qlOspjo71zCy73aqX4H1qV/2TbD1BGRnEpz22QCUF7aPB0CmOVPwXsH7fua0a2fFHKwwAx2dBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q3cWw2Vo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qo6euqlT; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q3cWw2Vo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qo6euqlT"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5A7761140106;
	Thu, 30 Jan 2025 05:51:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 30 Jan 2025 05:51:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738234280; x=1738320680; bh=mgN68zIJjQ
	SnWdVNNsQyIdxjaWoOHOg9QzcPxNV8W00=; b=q3cWw2VoT4roTBwzggfbGnZGCj
	+drBZLPD7iBiTKaSRcAko3kqeUV9aP1T/G8S1g94RV4mdIJl8NwlQ6S1nOnCMG6r
	Rluw0Ni/Q1gb1n0ZditkTFvnkIDpdwRR8sx3c/BmMYyg8B3rjPW9fd3etJtt3Z8s
	rIHzEEC2uTOpcHZI8SFv3USaDtejB91cF8YiHyS2cz19HizQU2kbGZNHhbziW5tm
	vzpo33Y6qEDsrIKPBRdkLMgDMYkvlm1jfqssr9uBnB6T9ChpWLquIp7BKr0aPuBt
	Vg60edxe93hganwDxG2QNYYEGF0ZWNq7eD+u8kdESeGGWwQKrmf303ivutvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738234280; x=1738320680; bh=mgN68zIJjQSnWdVNNsQyIdxjaWoOHOg9Qzc
	PxNV8W00=; b=Qo6euqlTpttbU6ARhaAUgK45mtRBN4rz9mVvtqHet4Ays/ZjpA1
	nx2Qp3N4qMijIaQWgXDHrVQpqcu4F7RAt8GD/uoPK6PX37Jstx4GTepodJGjOXfY
	/cwNwmSwMe0HMaArmu4S58Zt+jhjMVCQsj8Iyxccx94uERRSSWIGrD3bJzVxdm6a
	tvZ+88aw4kRnuwJ0rLbMTyfOL5oA2PXNPqANh8W29voX1Bkt6/NFZeQYFQyRylzE
	u9pg7ZKgC8NdDOScqdlWgcA6MBYhG8ilOpWFLjJQa6ui8dSSlUEDGdAGtGj9FMEQ
	DgZo4TeJCCxjjeMhOgs5PcE7UC//dIhvmnQ==
X-ME-Sender: <xms:p1mbZ29Rxz6jitVNLVLqHDS7l18wF9v6Dq3HZoW8FvE3YQksrtn4Og>
    <xme:p1mbZ2uCUWrU4Wu7RdoP9TASs96Vo6iqAfXJabzb6LGAEc2O4ECwTtP2gY3cgp_9X
    qdxfIEzEiNMjPA5zQ>
X-ME-Received: <xmr:p1mbZ8AB5Xtqy0r5lwWpcdLJPkaUU5jg2GfJCW3PiHwDT5yJdSGh-QygbOZZlJJSlvpgWeCVtKA7bJryf9GDW2-HimYSQZrV25TVMxJ_V0xE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepfeefiedvgfffhfduuedviedvheetieekveeiieejuddv
    ffekjeehgfdtvdevleelnecuffhomhgrihhnpehorhhighhinhdqphhrohhmihhsohhrrd
    hiugenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    shesphhkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtth
    hopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgv
    sehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhush
    hthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddukeek
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:p1mbZ-eq9-HWPlKW2dSZdwIVGj2E1FLVXO9_P2jWsQMze3XYLShcqg>
    <xmx:p1mbZ7MSN9VGFrRQWIBQeGJ8U20OZ7Gha147MKuvL3VjfRkTwQ0_ew>
    <xmx:p1mbZ4lkKju9Cdyj8HUFujfL3uWJ25_R05WjKbkz5NUCpNLIM15IqA>
    <xmx:p1mbZ9t1STa5zU_GJ4RixXS1YRmimWd8mV16msTwJySEXkJqJl1TIA>
    <xmx:qFmbZ8G3o7qXhddNIJjAyTY2H9pokMhkHrEwm4a--ASZv4OZbXvYFCEP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 05:51:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id be262841 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 10:51:15 +0000 (UTC)
Date: Thu, 30 Jan 2025 11:51:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	"Randall S . Becker" <rsbecker@nexbridge.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 5/6] promisor-remote: check advertised name or URL
Message-ID: <Z5tZoiAHK-2OqjYJ@pks.im>
References: <20241206124248.160494-1-christian.couder@gmail.com>
 <20250127151701.2321341-1-christian.couder@gmail.com>
 <20250127151701.2321341-6-christian.couder@gmail.com>
 <xmqqa5bbq0nb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa5bbq0nb.fsf@gitster.g>

On Mon, Jan 27, 2025 at 03:48:08PM -0800, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> >  promisor.acceptFromServer::
> >  	If set to "all", a client will accept all the promisor remotes
> >  	a server might advertise using the "promisor-remote"
> > -	capability. Default is "none", which means no promisor remote
> > -	advertised by a server will be accepted. By accepting a
> > -	promisor remote, the client agrees that the server might omit
> > -	objects that are lazily fetchable from this promisor remote
> > -	from its responses to "fetch" and "clone" requests from the
> > -	client. See linkgit:gitprotocol-v2[5].
> > +	capability. If set to "knownName" the client will accept
> > +	promisor remotes which are already configured on the client
> > +	and have the same name as those advertised by the client. This
> > +	is not very secure, but could be used in a corporate setup
> > +	where servers and clients are trusted to not switch name and
> > +	URLs.
> 
> I wonder if the reader needs to be told a bit more about the
> security argument here.  I imagine that the attack vector behind the
> use of "secure" in the above paragraph is for a malicious server
> that guesses a promisor remote name the client already uses, which
> has a different URL from what the client expects to be associated
> with the name, thereby such an acceptance means that the URL used in
> future fetches would be replaced without the user's consent.  Being
> able to silently repoint the remote.origin.url at an evil repository
> you control is indeed a powerful thing, I would guess.  Of course,
> in a corp environment, such a mechanism to drive the clients to a
> new repository after upgrading or migrating may be extremely handy.

I'm still very hesitant about letting the server-side control remote
names at all, as I've already mentioned in previous review rounds. I
think that it opens up the client for a whole lot of issues that should
rather be avoided. Most importantly, it takes control away from the
user, as they are not free anymore to name the remotes however they want
to. It also casts into stone current behaviour because it is now part of
the protocol.

That being said, I get the point that it may make sense to be "agile"
regarding the promisor remotes. But I think we can achieve that without
having to compromise on either usability or security by using something
like a promisor ID instead.

Instead of announcing remote names, each announced promisor would have
an ID. This ID is opaque and merely used to identify the promisor after
the fact. It could for example be a UUID or something else that is
mostly unique.

The client will then create a promisor remote for each of the remote
names. The name of the promisor is derived from the remote name that it
is being created from. When there's a single promisor only it could for
example be called "origin-promisor". When there are multiple ones they
could be enumerated as "origin-promisor-1". In practice, we can even
roll the dice to generate the name, even though that may not be as user
friendly.

These names are _not_ used to identify the promisor. Instead, we also
write "remote.origin-promisor.id" and point it to the UUID that the
server has advertised. Furthermore, for each promisor that gets added in
this way, we'll also add "remote.origin.promisor" pointing to the
promisor name.

So on a subsequent fetch, we can now:

  1. Look up all the promisors for the remote we're fetching from via
     the "remote.origin.promisor" multivalue config.

  2. For each promisor, we figure out whether its ID is still being
     advertised by the remote server. If not, then it is a stale
     promisor and we can optionally remove it.

  3. If the promisor ID is still being announced we double check whether
     the URL we have stored is still valid. If not, we can optionally
     update it to point to the new URL.

This buys us a bunch of things:

  - We have promisor agility and are easily able to update URLs and
    prune out stale promisors.

  - Promisors can be renamed by the user at will, as they are identified
    by ID and not by remote name. We have to add logic to update the
    "remote.*.promisor" links, but that should be doable.

  - Each remote has its own set of promisors that cannot conflict with
    one another.

From hereon, I'd also redesign "promisor.acceptFromServer" a bit:

  - "new" allows newly announced promisor remotes.

  - "update" allows updating existing promisor remotes.

  - "prune" allows pruning existing promisor remotes.

All of that only applies to promisors connected to the current remote,
of course. Furthermore, the values may be combined arbitrarily with one
another, e.g. you can say "new,update" to only accept new or updated
remotes but not allow pruning, or "update,prune" to only allow updating
or pruning promisors without adding new ones.

I realize that this is a bit more work than what we currently have, but
I think that the design is significantly better than the proposed one.
From my point of view none of this really needs to be part of the
current patch series though, as these are all client-side changes in the
first place, and as far as I understand we don't have the client-side
ready yet anyway.

The only change required would be to adapt the protocol so that we don't
advertise a promisor names anymore, but instead promisor IDs.

Patrick
