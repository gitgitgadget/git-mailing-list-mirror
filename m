Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5078642070
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735295660; cv=none; b=s/xasiVQknptTAuE/Oun1vRVxw3zgByv+EKMc28fJxCBjUgAw4Bezh21ZzwPumpreeEItvWv9HdiSucPigrbi1i0TcOuO3aCFGcNGXVK09WncaExeiv5ciws68cmOBAamD4N/mV2zvq549SF6K+pQVGQH/uBYoDlllUFiGtQ/F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735295660; c=relaxed/simple;
	bh=BYlx5zcYn13KCcw4vyU/o9Gbly4sFVd7Mf2gzoiHVFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFmR3/C2pD4CHUDKiFOyeSa22oZPAD+5OiQft+pR6DkJD3XGO6nNv2ixEoikiuwrE9SVRU3tTMPrBkfMTNl19Z6e6Tz1yCgUht348/hjClA1FMVn6G1UO/38HBl/JXT227MBr5PR67OJ9iBMFdeZ9UK9uwGZeE0CHUdI0JnN7E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IlXsV3Nw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FIT8eMfA; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IlXsV3Nw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FIT8eMfA"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 426B81380137;
	Fri, 27 Dec 2024 05:34:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 27 Dec 2024 05:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735295657;
	 x=1735382057; bh=uwIRViihLEVnBAiiOAqoEcHcecpCN0vQA4/aKstH5K0=; b=
	IlXsV3NwtNvJlSQgAH3r72Z4EwdjBTrOLBo9J0Aq8aNQ9I65YGjy93Gv3t4yJw5N
	5LwI4wXwxqGpl7+MgSB9j78UeOVM7SEQ2ptYwXd1SfDdSJDSkDmvqhB6GP0QfM/U
	ZrfXDToE+RS/WEhMxziL1nyX8d5pJhPif6LgEMM7rXKI7Eo7aIzYkqX2AldScPeP
	r1hnUtyItHzaW9tyej/acQlt/0wtPvOIBVlNZGV4ptnvgGdKPFrZi5j7DrJ0HwE/
	NACdld5CRoR2O8NLLPrahaAgJuQmlhjcE93uN76Je+A7b+5TVaV8unA311vXAQ0x
	efvNi8zQdTQmSqUiP6giQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735295657; x=
	1735382057; bh=uwIRViihLEVnBAiiOAqoEcHcecpCN0vQA4/aKstH5K0=; b=F
	IT8eMfAzWBV9yetNTxy0K1/qpDUiYNBrpf35JRUJaPjlt5pa3mY/qNCL8ErBp59N
	ClkDC6OTMrPViaGwjGTtwCiiamAoW9Rer7BripCUQhli9A2Xq9SpkhSUA/UGTGpw
	ht9NeoswTRfoB/i8g4xjcqVqLKVRRqZLOgjvniwxwZg5TdTqrS43UBEaizm74Jh/
	uGddUd/Zq7kfdztHguSPeJciMM9vzL45+8o5gkIyN3B1REuL1gEvWlkOH0MQ6JDh
	LAlg/KeHdK1kiryTQ9/SSCUrRL347n9fT8S6TteyW3aXMCat8ZEtiNOF+f23ojQu
	rYYYj/XKsWEtFAd7fUT1Q==
X-ME-Sender: <xms:qYJuZz2XZeDNG4gYvgAYbSwbiRp7uSJSd8WY3vQ1gCfRVN5K4w2BSQ>
    <xme:qYJuZyFPVGvfZM5IrvTgXxnOWHIj6trgRxb1gBZpllsyMBewKqdK8YBDgx1cDqzwS
    I9p_DFf0_ooMwzz9g>
X-ME-Received: <xmr:qYJuZz6vyflZ6nKof-BKk3kHiM23HTbGHhj_XYaBwAyRfmZJ4h9KpjVgIorIqLDgIT3D9NWBrrc0bAw47N1gIfXXM6VgcMmx6E_nbYAZjiETLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitd
    etleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdr
    rhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qYJuZ429XCRSFG3czLRtpzFsU98VhYAfcCYzKYQzX3MX5Xhal2o-IA>
    <xmx:qYJuZ2EnCQ4wE6kcz8D175vwvSiuB-_zMyh4PoqTLpXEnbbUlYrH6w>
    <xmx:qYJuZ5-GmR8ZzWZWDYs8UWGdshVUlZ888ONaT818kzRzbhkECc12fw>
    <xmx:qYJuZzm9gtKnbAeyaEU77CnbZTDPmuLsYAIDYHA9Uk9VtEVR4BPzmA>
    <xmx:qYJuZ7RfcysdpNTu97Ps5d5cPsGZ04hgtJHKD7JoGEJam_Byh0vwK8ma>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 05:34:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0ab9e7b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 10:32:11 +0000 (UTC)
Date: Fri, 27 Dec 2024 11:33:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/4] reftable: avoid leaks on realloc error
Message-ID: <Z26CjQpewcyLwfs4@pks.im>
References: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
 <9b2f4baa-b602-4cc5-8dfc-dd941b1d7af6@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b2f4baa-b602-4cc5-8dfc-dd941b1d7af6@web.de>

On Wed, Dec 25, 2024 at 07:38:29PM +0100, René Scharfe wrote:
> When realloc(3) fails, it returns NULL and keeps the original allocation
> intact.  REFTABLE_ALLOC_GROW overwrites both the original pointer and
> the allocation count variable in that case, simultaneously leaking the
> original allocation and misrepresenting the number of storable items.
> 
> parse_names() and reftable_buf_add() avoid leaking by restoring the
> original pointer value on failure, but all other callers seem to be OK
> with losing the old allocation.  Add a new variant of the macro,
> REFTABLE_ALLOC_GROW_OR_NULL, which plugs the leak and zeros the
> allocation counter.  Use it for those callers.

Hm, okay. I find it a bit curious to discern those two macros from each
other as all callers need to handle OOM errors anyway, so doing the safe
thing should likely be our default here and all callsites that don't
should be adapted, shouldn't they?

In the case of `reftable_buf_add()` I kind of doubt the usefulness of
handling the error just to keep the old pointer intact, as all callsites
will ultimately error out anyway. But in the case of `parse_names()` we
do in fact want to handle the case specially so that we can free any
names we have already parsed, so that case makes sense indeed.

So there is merit in having two separate wrappers, but it would be nice
if `REFTABLE_ALLOC_GROW()` would be doing the "right thing" for most
cases while the above two callsites would be adapted to use a wrapper
that requires a bit more thought to use correctly. For example something
like `REFTABLE_TRY_ALLOC_GROW()` or similar.

Patrick
