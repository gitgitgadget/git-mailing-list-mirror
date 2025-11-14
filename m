Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D60B1624C5
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763136802; cv=none; b=kacBsoGgVZIzy8s61hdbBGR/cZ33yR8uLkRVIKFQLcGoinOQ4V0jIumHFVivZ8PnW7Et2lNBALq28QAUVkP681wtW1m6d/tQUAsVJNrSOMjoHJDQeKZifwmllY6FSJSyt1e9640NT10cBonW5BBkMtqEAqTEsOlIiabuJWOcMcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763136802; c=relaxed/simple;
	bh=3yjb/VUO0E1DAVuptaGBgQWucxgrLkSr3b8UiCg7AZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bYS+QfmPqZDXqNJp7I3EPcWH0ra2Z++7vT2QQbiX0HWlNU89ZTDMaS4ue6NG2J/liFTmvNc97nsVy7raYXaHW1Y/hZApLPd1l5i9qWYVHV4z8A+5JZSK7dHVveQptbtJP4MLeiboudlWVxB3xIlTPWU7XUWOdQaWXwhcZmMVocU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mOBv7VVO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ptKFgv48; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mOBv7VVO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ptKFgv48"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id D11471D0005B;
	Fri, 14 Nov 2025 11:13:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Fri, 14 Nov 2025 11:13:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763136798; x=1763223198; bh=9FK9fGYori
	33XEwSgdWw8xJbAK+I7kmqmjz+spRdLYs=; b=mOBv7VVOsNwCeCZXupOve/cPoc
	OG9oT8JvXH3jquTmpE1PxLObN+NTfVZqN0dvABAIsWhiGVxCFnu1wMRDfzAHjoex
	8I94cVbx2iN263QPVMT1GrGhR152B7HGqsxR4dVJnsaQY5oT19VsjBYn72+4opsY
	ziniigfb5CvoX4f5gSqj1VLYsrjRLbyV3mW/BpD1GQjd6EfSnbU6Uy8wtitlwfVo
	VZ6XhaB7twJFWnqzhF9FkjqNqcdjNTdd0s3WQLxg/Rc6Mqv5GQ5C4RpExIxQ1zk/
	9SxbI3c1+Ys5kDxFzZctqXtShbHI8/Xl6eS1s2l2z+xSjLE8DtQJKq1Ppe6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763136798; x=1763223198; bh=9FK9fGYori33XEwSgdWw8xJbAK+I7kmqmjz
	+spRdLYs=; b=ptKFgv48NeIWBPT3J3v0B6LAv7PAfWVj/R+ZlVYDHFKEOEZiO5s
	j30D5JsS5IXH9q0oySrtvOthNqsLT7FnAvQ3Tn5lwrUeorX4H6dy4qq60YzQ4JJr
	kGOcrsMb5icHWcngEEQCADAitWgv56j2/mR+Sv1QrPpNDq5b9oPwMV85cmUPMPCj
	AwPe/o3IxxsQPQADPiy+QslGRl0W0UOSLdIl8BeRba81fLXT+OOSH2lnrJHMazi6
	bMoj9w5JKNlcOyXgINMJ+jmwOq64ZoaqeQKXGAsCn1GP4iJ1NyIu2ZBQPFdY01fC
	jndYZQKVey/KO6jxRTlNcLT9FRfdiXdQrJg==
X-ME-Sender: <xms:HFUXaaNCgxVYMGV1iYjfzc30iP5ZHIDPfefKF7FNm2nNpP9PqfnO7w>
    <xme:HFUXaQihlzV3I4jnEupcePFLEK0q-kxCkSzYpGoqzmj0wrTv7TYs0Uz6I87HfO3Rd
    CYTx-lIYtDn7BK0bFThSIzJSNrPSVpYCtJDp6FapzAMR-QHftz8>
X-ME-Received: <xmr:HFUXaQ7LR4pY_jzjZ-aiHfWDFVJjMA1c0OqqzVesLZSVenVI3KIBkb-P811bTp6DrZ_aKffrCild6URM7hYEFnnhJgPSegmZJ8Re>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddtvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfi
    horhhlughhvghllhhordhnvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopegrshhhsehkrghmsggrnhgrrhhirgdrohhrghdprhgt
    phhtthhopehmihhkvghlrdhfohhrtggruggrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprhgrlhhfrdhthhhivghlohifsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgr
    vhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepsggrghgrshguohhtmhgvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepughjmhdttdhnsehmrghilhdrrhhu
X-ME-Proxy: <xmx:HFUXaXdom2nwxx-iqLVXdK7x_-NbBYV_06EWN_lq0xi4IN34SHMB5Q>
    <xmx:HFUXaZDsCyszPdOmaxkWx-64RPnimzbaCGFCbGQoM2OFkEviigNFEQ>
    <xmx:HFUXaWBX495o40NNxVSfSXsHpBtzHcoHA4Ldp6ZYcx1awl7HgO3xAg>
    <xmx:HFUXabaPyGmyKL-v4thI_A1FcSNlaUn1v68uNijQ98R3_OxNCmmB3A>
    <xmx:HlUXaete4Ri7sUoPLw9dwSRaImkwN23tro-NZaSv2hAJBexhWnJnkH9p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Nov 2025 11:13:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Justin Tobler <jltobler@gmail.com>,
  Alexander Shopov <ash@kambanaria.org>,  Mikel Forcada
 <mikel.forcada@gmail.com>,  Ralf Thielow <ralf.thielow@gmail.com>,
  =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,  Bagas Sanjaya
 <bagasdotme@gmail.com>,  Dimitriy Ryazantcev <DJm00n@mail.ru>,  Peter
 Krefting <peter@softwolves.pp.se>,  Emir SARI <bitigchi@me.com>,  Arkadii
 Yakovets <ark@cho.red>,  =?utf-8?B?VsWpIFRp4bq/biBIxrBuZw==?=
 <newcomerminecraft@gmail.com>,  Teng
 Long <dyroneteng@gmail.com>,  Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [PATCH 0/2] Fix misaligned output of git repo structure
In-Reply-To: <cover.1763098804.git.worldhello.net@gmail.com> (Jiang Xin's
	message of "Fri, 14 Nov 2025 00:52:43 -0500")
References: <cover.1763098804.git.worldhello.net@gmail.com>
Date: Fri, 14 Nov 2025 08:13:14 -0800
Message-ID: <xmqqms4ok2xx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiang Xin <worldhello.net@gmail.com> writes:

> BTW, I used two AI coding tools (Claude Code and Gemini-CLI) to generate
> the commits, and added the "Co-developed-by" trailers in the commit
> messages by using one of my opensource project:

We had a mini-thread on this recently.

  https://lore.kernel.org/git/xmqqo6p9zo8f.fsf@gitster.g/

