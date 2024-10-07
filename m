Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E473C18BC1A
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 21:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728334927; cv=none; b=aIjEI/QW/Qd1wooOgCn4/8t+7H6o1jUqBNj8sytncFA8Ecdi/W2q+M8YEDlEJ4y66MrSPFrXSRwKVhoesUgv7V5cXwMfGz8ccQR3ddev+Q4Af5FI+Y5kC6A7IN/fh7ZCRY0PP/OuKCG8y25x6LWAUZh8DxDv72IYaRqWspC/2sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728334927; c=relaxed/simple;
	bh=Yge7uTH15kQXcSzKb4gUab8UCmgVIYCb02N8B/vlXZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YLe3frvMsIGETF9nlcrjKRG11CTWIoDi/VnrZK4t2cXruxyj/mxVE25SRCKbzY2hag1xONb9rCBXJMX70sXx2Sqop57VLnsjudFpivgnBXAytIP1dlDg+dQFEkc111D0CJEPIhYIJE/SnvcEJ+6+45we79B+yF3ZPHH9E0a/B8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IqZkugC2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LucW/6yP; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IqZkugC2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LucW/6yP"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 0E4941380255;
	Mon,  7 Oct 2024 17:02:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 07 Oct 2024 17:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728334924; x=1728421324; bh=7GUJ543KPt
	loqo2TtVmp5wKCn3FWnhgA/lwyX23h4PA=; b=IqZkugC2fj6Lwur4uEMl6z04xo
	qxSNUhFcoRCVA9UDHTuxw1ZQZON8mjK44Ts1K5DSPI+NL/5fCySCi2odIqIM0n3M
	4csuXAMHE2L2KZ2lvkDkQw/rAyNmGKT3NzQvCmWGo9mFUoDnI4USDX1yjWjCbCee
	sMLnyIH/974ndZfiI4i3R9leLgmUqCJvcU/UuMTNtoniDakke2ioLSMn1ac/zF3K
	3Mcagp6l8qkCrn1ep/XVcwXakW2tRnRpHi74EdRJ8/B0xaxUoNznm0KPG4N1hfVS
	PWNUOotEHteNlDo3gMPwDLJ9avex9JeXGPTaMf+xvbXNG436dqqsT1ynQ37w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728334924; x=1728421324; bh=7GUJ543KPtloqo2TtVmp5wKCn3FW
	nhgA/lwyX23h4PA=; b=LucW/6yP/1i/y61YCDTGe0PyGEcwB9Wd+D8TX1kHdr+k
	0xZWfZi41CzbR2Aac+cLqpNN8dn5XRW5rdXFmw+zkaLE+osAA3oEyp5m9kYbFFuC
	HH93sxvMF2Efq0JcXMRrXdluPFgAtZpuoTJcwL1SC/tpnFFa2Hlwb7+9AwtOTqZO
	cyHDfw0nlZnhC7BUTAYTPEtqCs9x2LM0mrQCKhBRrfbNTkDjYY82VRFFGnTFhrTg
	DhTrqgqJeV3e3m6MZvm/h1obGObMGJO5RB5P5KePixMd11BMqlUIyjQd3O6OWpyC
	2wH3pC5BOYS0w9Oi2s2mpIYcLiPh+hNRtWL0xa67lQ==
X-ME-Sender: <xms:S0wEZxI6LW0nhApruzZH5UHHWIgs3MQEftOp1nckyQEYHbwZr1su2g>
    <xme:S0wEZ9IB_Ipd6HLmYZIGzt57hAzjtKNIl6FRTAwFwFY76gTOHtUpEd5IvinLo8Nux
    a3xqYj13toiL_HJ-A>
X-ME-Received: <xmr:S0wEZ5vK51fP6-bupfkk0OLLtHuxqle4HzhI0AX_CnThdL8m-c1BOLieafcaplX96lfMwL-ewxLMOWofb_ATVK5ASOyWZd9t8hxVzfY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhnuhgvthiiihesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:S0wEZybyfyMJFQCZP4u1pqbC7oyRHyF3LdYZ2VZIBT-r8Dri6AiqAA>
    <xmx:S0wEZ4YCVHzl0MTalPJGEFJf3C2BgNiIeesZ-WwKNbPj6oKklFImsQ>
    <xmx:S0wEZ2ATeHIby2yhZCR74YK7XLY3QOfpsf1bz5VFYDHpC4zF--kl_A>
    <xmx:S0wEZ2YRpi3gJyHKE5knJyM9bkGESIhjyDccif_KQ_WyWSZUU94rlw>
    <xmx:TEwEZ3yqIwJ4TA4VxsgebS9b-FE6dIk5Jl32sTvJNdAjr3KVRUDaNMCr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 17:02:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Gabriel =?utf-8?Q?N=C3=BCtzi?= <gnuetzi@gmail.com>,
  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: Bug: `git init` with hook `reference-transaction` running `git
 rev-parse --git-dir` fails
In-Reply-To: <ZwPEwL-fKHBkUOcm@pks.im> (Patrick Steinhardt's message of "Mon,
	7 Oct 2024 13:24:00 +0200")
References: <0084cc18b6d90ba14849a7f788939f4a1d0d61c9.camel@gmail.com>
	<ZwOVy4FltrEjxHn_@pks.im>
	<867f42bea10de470532d2f30eacceafa2b03d8de.camel@gmail.com>
	<ZwO-j0C59vuYsEnt@pks.im>
	<a8807b44026458097267932f429ef61d5b77aa4c.camel@gmail.com>
	<ZwPEwL-fKHBkUOcm@pks.im>
Date: Mon, 07 Oct 2024 14:02:02 -0700
Message-ID: <xmqqiku38w51.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> `$GIT_DIR` _is_ defined during hook
> execution. So in theory, if git-rev-parse(1) behaved exactly as
> documented, it shouldn't even care whether or not it is executing in a
> repository.

I've always considered "git rev-parse --git-dir" and friends were to
verify the validity of the repository before returning "Your GIT_DIR
is here".  Otherwise there is no easy way to ask "I have this directory.
Is it a valid repository you can work with?".

So, I am not sure I agree with the above.

For what is worth, I am skeptical to the "solution" that tentively
creates a bogus HEAD file while the repository is being initialized.
The code today may ignore certain bogosity in such a HEAD (like the
".invalid" magic used during "git clone"), but there is no guarantee
that a random third-party add-on a hook script may invoke do the
same as we do, and more importantly, what a repository with its
initialization complete look like may change over time and it may
not be enough to have HEAD pointing at "refs/heads/.invalid" to fool
our bootstrap process.  If we were to go that route, I would rather
see us pick a pointee that is *not* bogus at the mechanical level
(i.e., "git symbolic-ref HEAD refs/heads/.invalid" would fail) but
is clearly a placeholder value to humans, soon to be updated.

Let's say if we were to create a repository with the name of initial
branch as 'main', we could create HEAD that points at refs/heads/main
bypassing any hook intervention, then call the hook to see if it
approves the name.  We'd need to make sure that we fail the
repository creation when the hook declines, as it is refusing to set
a HEAD, one critical element in the repository that has to exist,
and probably remove the directory if we are not reinitializing.

Or we could use a name that is clearly bogus to humans but is still
structurally OK, say "refs/heads/hook-failed-during-initialization",
ask the hook if it is OK to repoint HEAD to "refs/heads/main" from
that state, and (1) if it approves, HEAD will point at "refs/heads/main"
and "hook-failed-during-initialization" will be seen nowhere but the
reflog of HEAD, or (2) if it refuses, we stop, and the user will be
left on an unborn branch with a long descriptive name that explains
the situation.

A much simpler alternative would be to simply ignore any hooks,
traces, or anything that want to look into the directory we are
working to turn into a repository but haven't completed doing so,
during repository initialization, I would think, though.

