Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA851D5165
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736962828; cv=none; b=vCFjSm/3bfUQl//QGgpZrDXtIUj/o+CQZ4sijAKLFUWqWOfkXZ3FsyJIdHBAZc6e16L/CYFjwGB39+QFaZoCk/yR3skI5tdmfQnnwWwmSvYoUkwwyKcbfq0d6cOeyLwuZyREX71eXn1bLAU7wAx5DBMl0Vn8aa5p/ws0XgcU0fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736962828; c=relaxed/simple;
	bh=j1MNw/5hnzUhTrCJfv4yRrcxGaD4uTHrYTs7RPaiC60=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rB2aeTedUq0oCDN/L1dy046UkFbbKZZpityU1yDyYLK8i+nxka87wCdMo6z5rg8fEAjnp08TEo20zv2oNvY4fp0988C2rH8Ip6qJc66DW5aDrvn1dwmuY9NYvYed9yW2G6U+vuon/oMYHwZebHwmTeYtCR1QG4OJ+o27G1RGHHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=SY6gI1WD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HEijVjYn; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="SY6gI1WD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HEijVjYn"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 13B7A2540178;
	Wed, 15 Jan 2025 12:40:25 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 15 Jan 2025 12:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736962824;
	 x=1737049224; bh=JQbolMIZOAelLcFw0eDHF54FXQ/XqCX4vmZj8/UjRwY=; b=
	SY6gI1WDr92LTlcklEbIKm7JSTLe76tc8r8XL1JRn86eJP7Qw+e7wjyNeWi3+LYU
	EUZtRIJmAz/K3rmaMjMExmiCqH1mN7hz0x+xZaoyXkmDJTh45+HhuIVlTLlGOgla
	1WEuXTJ4tWyRRSpEFgWzQvbN/KL9ZTEEgKEXpZsSrpPcP2DB0KfBEmwoUjnu5gd4
	7Vmnkl4vyDCxTOfJMsF8PoZs9eskMy6u33ZC3Iq9xw8TKYiDMUmEuQ2SUH23k91N
	o/fAHhNNRnaiDYruC/uUAoJ6/6pbPV1zadHzOroQJcFwbrh94+F/zFgcBQyJTG90
	NTLEnPCLQgQIQymNPzKsmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736962824; x=
	1737049224; bh=JQbolMIZOAelLcFw0eDHF54FXQ/XqCX4vmZj8/UjRwY=; b=H
	EijVjYnTjOxudfBgKOtIf+xuGFNd137izOHpdR2MhiXfwj2E9sWmA0yj160Tnd6J
	tlhZkLo1KLEIiVQeuf2AYeHfE0kfQYte6d5sv2j4Y52trCl/10gIDWuvpPjmdPeF
	uFroNBs5JPp0HcDgWzQMGS3TQ59pjUtN3F5YZAgu0mtrd54FAT/hxm9nanXBn9rW
	aXCBOQoCvfcPgaXfVcvZYdnri+QvrotJF3d3Xw2AFFpambqTm4Ytg3jLpVGGXcL9
	rEncnRAhzJK3DPAyGZk6qJeJoH6IkEfsrakyrCoNQepuvkuOlVbjQPpSofvP05yT
	Cnv5hB0byBdTaV2WDCRsA==
X-ME-Sender: <xms:CPOHZx9MC9A5fa7j4QE5BQLY8fOoszzdJcPOe2o7CYFzpCUSf4XYrSE>
    <xme:CPOHZ1tfvRFfa25tpj9jqy8wXQdtD_7QtYCxe3LwMl2K8p7oF-s2jz9aj55YKwwVi
    l8RLj0IE1f9YYWAJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmtggvphhl
    segtvghplhdrvghupdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhonhgrshdrkhho
    nhhrrggusehunhhiqdhmuhgvnhhsthgvrhdruggvpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CPOHZ_CzkXrq8keyVuCyWM9BnjuA3u23JQfBAFiOuXIZ41ZsLUrg4g>
    <xmx:CPOHZ1ep1l1K9mYStYfRYS2089oPEs0xMGaRg2wkYPWcKS_Xb3Cgrw>
    <xmx:CPOHZ2MIApsZD3gwM0qqTiD9V7As9JCTCNvZ6HJuOY8_TyCrNsb9ig>
    <xmx:CPOHZ3kgkenzOoZG8nX1wMUvjMsRnby26l0HbjGRZQz1QEV6U5t6NQ>
    <xmx:CPOHZzrgmIzR-rJAkbRXYzx2Sij1uN-JKiHbpdRTdouijgX416weVczY>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 60F05780068; Wed, 15 Jan 2025 12:40:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 15 Jan 2025 18:39:45 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: =?UTF-8?Q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>,
 "Jonas Konrad" <jonas.konrad@uni-muenster.de>, git@vger.kernel.org,
 "Jeff King" <peff@peff.net>
Message-Id: <0cf0b268-c691-4fed-a58b-ea9f77eab295@app.fastmail.com>
In-Reply-To: <xmqq34hkyoys.fsf@gitster.g>
References: <04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de>
 <D72M6S9O1E9F.WVEBV7ZJ1JTC@cepl.eu> <xmqqed1414gt.fsf@gitster.g>
 <c92e7b16-b70d-46f3-9858-2be805c5285f@app.fastmail.com>
 <xmqq34hkyoys.fsf@gitster.g>
Subject: Re: Git branch outputs usage message on stderr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025, at 18:19, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>> [snip]
>
> Being consistent is a good idea, and I wanted to first gauge which
> way we should unify.  It seems that those who spit their help text
> into their standard error stream are indeed in minority?

Yes: 40 of those stderr `-h` outputs.

Versus 102 that use stdout.[1]

Trying a random command with usage-on-error:

    $ git-upload-pack >/dev/null
    usage: [snip]

Does give usage on stderr.

=E2=80=A0 1:
    git add
    git annotate
    git apply
    git archive
    git bisect
    git blame
    git bugreport
    git bundle
    git cat-file
    git check-attr
    git check-ignore
    git check-mailmap
    git checkout
    git cherry
    git cherry-pick
    git clean
    git clone
    git column
    git commit-graph
    git config
    git count-objects
    git credential-cache
    git credential-cache--daemon
    git credential-store
    git describe
    git diagnose
    git difftool
    git fast-export
    git fetch
    git fmt-merge-msg
    git for-each-ref
    git for-each-repo
    git format-patch
    git fsck
    git fsck
    git grep
    git hash-object
    git help
    git hook
    git init
    git init
    git interpret-trailers
    git log
    git ls-remote
    git ls-tree
    git mailinfo
    git maintenance
    git merge-base
    git merge-file
    git merge-tree
    git mktag
    git mktree
    git multi-pack-index
    git mv
    git name-rev
    git notes
    git pack-objects
    git pack-refs
    git patch-id
    git blame
    git prune
    git prune-packed
    git pull
    git push
    git range-diff
    git read-tree
    git receive-pack
    git reflog
    git refs
    git remote
    git repack
    git replace
    git replay
    git rerere
    git reset
    git restore
    git revert
    git rm
    git send-pack
    git shortlog
    git log
    git show-branch
    git show-index
    git show-ref
    git sparse-checkout
    git add
    git stash
    git stripspace
    git submodule--helper
    git switch
    git symbolic-ref
    git tag
    git update-ref
    git update-server-info
    git-upload-pack
    git verify-commit
    git verify-pack
    git verify-tag
    git version
    git log
    git worktree
    git write-tree
