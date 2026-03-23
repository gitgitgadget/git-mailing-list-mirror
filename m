Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE6C3BADA9
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282277; cv=none; b=EkRv/KcZjhmW3W5VKaAMDwjvR/+kdtwJp+dC5rAaCdam6Uzp/rnUn7YHPxeH0NEMzztqbnxx2S+LZnYggeQeBQOfL/0O9synAP7ZCy32V6SA79pH8kad1+teP2h1NgbVfNscstOb9wb4CK+3YGazSPb9umAVsDR/2x3sAR6Qumk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282277; c=relaxed/simple;
	bh=I6nFYTiAFSYXbdj2uqhcgQ8yQSUgFgqvoBK3iwgDty0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l16FhBNTbSQL08jNQXVuEjXH+PSpy0y3sNw7reF7JFmRi1s9B43I/cQKt24U721n3T61jU9AjrpOADkOsQQeXhxpv52Bxt/YpGBbTxi9gcwMj4j5PZ3C8DtDGXEhHn/fUmB8ojCvKqhMdI2Gg/p/CXnsjXU3pe3dCXTNTyvt08w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NR43mqoA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r1BNnVzE; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NR43mqoA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r1BNnVzE"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B5878140006C;
	Mon, 23 Mar 2026 12:11:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 23 Mar 2026 12:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774282275; x=1774368675; bh=IDAUi1oIgB
	NkQynF8oLdpvXBwwK1o49q3BH1Ro7BFzQ=; b=NR43mqoAwH2ObVSo8s4IutYmZf
	/5u6gwWyfdoQhSBad/xiEKinMX1XLa9YhejtpaqO2t9FZbbj4e9z1qYkzuAsUaqJ
	kld5Rhz/j+bFjaeuidBk1M7KxwAJDGFDaiImwouLFEDQ5/ckrpHnJ67nup1IOQqI
	BYijq8Oe739PDLcj5qS/1wWMuysRXK52iv5N7J9DtOtqmGmbgZXEzwsX/DXESThw
	0zpPYTsRZox5+zUkVUdO4rAC6mUIsa0/Kc/Wg8i4pLIlM60MxgY/CAwBE3Wuz9MW
	0PYyG1mrz1T258wInj8kHQd3pug6mRvHOhMuSxSBf3sqCob8waIaIH9bIBPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774282275; x=1774368675; bh=IDAUi1oIgBNkQynF8oLdpvXBwwK1o49q3BH
	1Ro7BFzQ=; b=r1BNnVzEXPLhBH+7jGlbdr3RjIHMoPGp5f/jE7o9MtlcG3mbN0D
	7Hg+h0ap+Zmo5d9wiDj8u8/0ufO7NDUY5UX/4s/Y6We2wGoIRhUB61Xgt40WGVyC
	+Fqolb5GEu2y/7b68dz0Fgi2bJXjS6JQw3oCM+NuQNHuL5ZHZLdCr4wN3x3myiwj
	lCq0+YBHTV5/i71GoR07WBuSeiGkVlHBamqQHo1TerP6W5ImRlDMqVAGLBr5hlS7
	y1l3dhyuo9te0vZAPeMlqrDD+3fG2NkMX13KqWM01gHbX0Jjw2h6wYGzGuzl2dYz
	vR6V0H28HYduXCQ07K3bfc7c05B9FLsp1RQ==
X-ME-Sender: <xms:I2bBadlTpy0JE2_dXSm35IcApoO8JS8q7_oNiBvau4kDBxamgV0Y2w>
    <xme:I2bBacjqEDcrFUq366I5vdGRnotYUzhsmpriX9SuQcIBXZSPkMNJwlruskA8hm_da
    6KRASaP4IhrZE_JxvPeCtC_8WG5pzS4LF92FYcp1Thbnx0_BbcN_g>
X-ME-Received: <xmr:I2bBadcBR87UhG_9KXJzOhHl5QstMpdd3fKqmSFXcmVQ__RNDs-5CS_XBaoWMXQsAteaxlnNrardZc0I5S8DDuVaASPWwrUQjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeludeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghmihhlhihshhgrfhhf
    vghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpth
    htohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghp
    thhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:I2bBaUhiBKi4BdCL50u_MQTpPlzzCDYqomRbsyiasU34R7ARQN9NOg>
    <xmx:I2bBadxXAOtywYYxA-zJPa-Tu5LKT8HVpp2r0BR8pcXWv66miXupWw>
    <xmx:I2bBaYMvFbSDF_Mk9Bi9B0GwxQ4zEeJs0vMl8tvbor6ciBT1LGNp5w>
    <xmx:I2bBaWVjgSrGlykvA-6-rwyeqzFJEIFSYddt5dvbYlITMHh3XX7lgw>
    <xmx:I2bBaffwpsFsdTQUMKD_qOkGvUcIjsclNKNa7Qoukg5vv3CMHcSc1rbu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 12:11:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,
  Patrick Steinhardt <ps@pks.im>,
  "brian m . carlson" <sandals@crustytoothpaste.net>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: Re: [PATCH v2 00/10] config-hook cleanups and two small 'git hook
 list' features
In-Reply-To: <20260320115211.177351-1-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Fri, 20 Mar 2026 13:52:01 +0200")
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
	<20260320115211.177351-1-adrian.ratiu@collabora.com>
Date: Mon, 23 Mar 2026 09:11:13 -0700
Message-ID: <xmqqmrzy5xwe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Hello everyone,
>
> v2 addresses all the feedback received in v1, many thanks to everyone
> who contributed.
>
> This series is just minor cleanups / refactorings + two minor feature additions
> to `git hook list`, which resulted from the previous series review discussions:
>
> 1. The ability to show the config scope (--show-scope).
> 2. The ability to show which hooks are disabled.
>
> This is now based on the master branch.
>
> I have pushed the branch to Github [1] and provided a clean CI run [2] with
> the exception of a known breakage for some MacOS builders (REG_ENHANCED).
>
> Thanks again,
> Adrian
>
> 1: https://github.com/10ne1/git/tree/dev/aratiu/config-cleanups-v2
> 2: https://github.com/10ne1/git/actions/runs/23340298770
>
> Changes in v2:
> * Cleanly rebased on master, no conflicts (Adrian)
> * Fix first patch build break by updating call-sites in same commit (Szeder)
> * Drop UNUSED from function declaration in the header file (Eric)
> * Drop the new struct hook_config_cache because it's redundant (Junio)
> * git hook list now prints in tab separated output format similar
>   to git config --show-scope to improve machine parseability (Junio, Patrick)
> * Fix small style issues, comments, type, commit messages. (Eric, Patrick)

These came just before the weekend for many people, so let's hold to
see if we hear further comments for a few days and then merge it
down to 'next'.

Thanks, all.
