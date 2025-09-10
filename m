Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD74831690C
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 11:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502504; cv=none; b=PnPynMoPfRV05tdJex313IylkI9JN1FGNUJEjIqmIjrictYfNc3enIQ1FkqHdA60KqR6nCEjeklKWWSyMDMFPYGmMozDiOu4vQMWIqRWqdVQauWSHr/J4oH/ljTELDbgfon/IYw3uyNIbqNlW53CT2elvZ8fxaBusyVNAqmrznM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502504; c=relaxed/simple;
	bh=5vRA2LGEblGvXqBmy0Yaf9rFF/KpdD6od7oG2M1ISgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gf8VZmnXB27iE3ZNn9VNL+bdIpD/pjuA5mFK1/9JxSroohy69gpWN44gHw/9/TXfjIvLtWWinazL783Qa732n4b14C9N3nU7sV1/EJ29rAAdyIZOxY6xvvzB4VzVOfIDoQKIdhh+jalVDdrMWtX0Ak/OAbh5p9TlDhdeiYxklU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZqmZdiFV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KgRJXY7p; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZqmZdiFV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KgRJXY7p"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id B5F191D00083;
	Wed, 10 Sep 2025 07:08:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 10 Sep 2025 07:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757502501; x=1757588901; bh=F7nrigk1xX
	Eo9dxNkBXKdnOiHeb5JdDJQqNAwAj8m3Y=; b=ZqmZdiFVdwTz4DxAbcpKdHN1nO
	2GMY5qeQDO3Dq/iZ9Ea11I20pZWPyCLqucG1qIgjA0vfRMBVHkMP9ew56Ss6mwyJ
	gBij2Fjm95ECOkjDqsWUBDb3ilekOSbvJR9z0VAUqJWTI9h93R4KZsAGZOv9Pg4Y
	0skn6k5Q1pqyDQe0b0XgP2GswgMM2onFvGUEek3jJF5fYxha8RpYI2kBB1g3eqTL
	ZgciqiW9fMVeDgKfJq7sMmPPvCHdDGvElfqcqN8DC/Y7cL8gIZeGoN2f38rV4qUI
	ocIlU3dQoDq99I02KsN2iEdjtORUQRnCvfAziUCgawOnc/YIdOBaZExsYmUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757502501; x=1757588901; bh=F7nrigk1xXEo9dxNkBXKdnOiHeb5JdDJQqN
	AwAj8m3Y=; b=KgRJXY7pJLrJYCEZh3/ECcIBCICHxPkgRQapWx1PkDm2+WT980m
	Lt/joKGsgQbElmZx78BvIpgN87pMjACeXFxSarUoL+DThjzEggfwYVe2enwxl3TO
	qXAZjD8rgUIiFt4d4LvRqmxVWUClocJaZrxN5Mf+DTVjFWH8TGDghVAm0Y0Hb/HU
	7ibYfotUb/iLczxjDli/SITZlR4LuMS8N7Bz+DCqF/8LrsCkDydbKS9dZHRc4i74
	MLuntrQAoonT2dbaahmsrYXLKLcdzVWkRpEvyoDnzCIL+11lx2Hdr6LEHPVHiYs8
	TY/Yki4zPgF1gBf5/CALveyHX4h52hJ36kQ==
X-ME-Sender: <xms:JVzBaHKFhi9U4mFzaRPRk5QH1gVFvF7FYI6_cG-g1DK9flcZnJcLcg>
    <xme:JVzBaIsZh-TShSnHpTZjp-_awmlnr4_OeW4KVevgdz_Z3lJLFqjvibt9EZqFh5Mnr
    SKdmYzj1wy_vOIcaw>
X-ME-Received: <xmr:JVzBaGIwTFNaf0Z2IxMaiJOr0Ff0JiGt8VVvDPlk3uCX_O8GTo4NEUaIKBrwg6KXUBu7IDPxoJeH64e0fJcbghfQfkimTzXCdTI1osqRLRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejvedugefgffffieegtefhgfeikeevfeefheevvdegieetgeeujeeliefhiedtueenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopegsrghgrghsughothhmvgesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghp
    thhtohepshgrfhhinhgrshhkrghrseiiohhhohhmrghilhdrtghomhdprhgtphhtthhope
    hsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:JVzBaB969ciwREhV4BEl_J4CIo2voFKDS-YDzm2WrEofkAzUBP0yUg>
    <xmx:JVzBaPw4HuVkPtxa92NDp63KcKLCLtBPwQCICAZn-8ZpuCTErdgkMA>
    <xmx:JVzBaO4GOzkbeo89A_jkihWNF8EKBIf83N3yNdPeizBxI4v-wJaXow>
    <xmx:JVzBaG_CLLwO1RLvfZFeKV6JFChWWbMvRwyu7ltCOtPO01yaJB_tzg>
    <xmx:JVzBaJ4s3vvMuNH23pmMpUI9qE1xuDXmwgsd31d2hOwGzOqDMGSAa_zy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 07:08:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c65b8826 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 10 Sep 2025 11:08:19 +0000 (UTC)
Date: Wed, 10 Sep 2025 13:08:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Taylor Blau <me@ttaylorr.com>,
	Askar Safin <safinaskar@zohomail.com>
Subject: Re: Shallow clone support in v3.0 and beyond?
Message-ID: <aMFcH2nfKO-DZcwm@pks.im>
References: <aKzy6naLtdeq7Tgn@archie.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKzy6naLtdeq7Tgn@archie.me>

Hi,

On Tue, Aug 26, 2025 at 06:34:02AM +0700, Bagas Sanjaya wrote:
> Hi,
> 
> Askar Safin <safinaskar@zohomail.com> posted on the ML about his complaints
> regarding grafts removal in v3.0+ (see [1] for the full thread). He also
> briefly mentioned future of shallow clones (aka git clone --depth=1).
> 
> The question is: If grafts support is removed, then how can shallow clones
> be implemented in terms of git-replace(1)? What about its implementation
> details? How about unshallowing (git fetch --unshallow)?
> 
> Thanks.
> 
> [1]: https://lore.kernel.org/git/198c29e9058.119e3a5c065010.5888624019176274871@zohomail.com/T/#t

I think the BreakingChanges document could use a revamp in that regard.
The mechanism used to implement shallow clones is of course _not_ going
away, and the internal mechanism to facilitate this will go away.

So the intention really only to remove ".git/info/grafts" as a
user-visible mechanism. Users should exclusively use git-replace(1).

Patrick
