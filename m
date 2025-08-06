Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6911A76B1
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 19:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754507090; cv=none; b=K7El/hZQ0wB25R8mm30GhFVjCI9J3COza28nt5BIYWIXHAg/t2AeP4P/Qcz2Ky9Zv+juw0URa7BeuCY4jT+AUmAfUy2jmKuUAGiuo6ghtPTyJqdevJaheof3giq/uV2nccrIpu/FwepdNjPQqAnJcz/eEtulKBXe/Yb3lY1hvYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754507090; c=relaxed/simple;
	bh=BtKvOX0EVwF1MFceUaLLpckS3GJQ+BtD3dTS5Ij7Vz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ECNLxdHGPXBEfJmGQa1kJ7z6O1JxIZiFMCzUurZWurS+q0rniQ+RteHDk1vF3o8LrZr/gtXd5o4V8osysiUoy3DM2AJRFB2pv4FsT26V9RV9gUyJT9mVwYdr7aAU1cs0/73gVOGwbHx3wkBJdBMvGz29/EJi0XqQ/Yy+5Py5/Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eKa5mF7Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lKYMeMmF; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eKa5mF7Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lKYMeMmF"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2F2287A01A4;
	Wed,  6 Aug 2025 15:04:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 06 Aug 2025 15:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754507087; x=1754593487; bh=BtKvOX0EVw
	F1MFceUaLLpckS3GJQ+BtD3dTS5Ij7Vz4=; b=eKa5mF7QpycCUHNKi4L2R9NysK
	g0ioT8eoOPJnedQKWZt3jey5IE05xLeKyX4TFWEqmlcFZkhdlGFdppur2mwE3u2h
	qe1FEBe5PZUf/Edh2dKpTBTzvG3Obo5YSZSVgQPZ0qsRlxkRU/aP866QhRRghv1K
	21nrRHVRvFeQZFfbE/dVwBTBiX7Ih6dGHnYftDpgnfh4MAGKcUtfVFESzGGsMVSU
	L8TbN4XAekgY1w/+olrZ48etaYCnQZH8LeHIGZR+8ah2LBAbcj6V5XKqS/nsUglB
	OILy/X1VZmk7LmfGBJu9RyVRn/UIaxyrA54vqqQflqSjyYzbTnXPiloiz6Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754507087; x=1754593487; bh=BtKvOX0EVwF1MFceUaLLpckS3GJQ+BtD3dT
	S5Ij7Vz4=; b=lKYMeMmF4KqAhffZRoTmG6gkkExXjQ/qXwPp2r3LuwM5WWTBWPC
	G7FSw+Zo1ge9/AbGFasBW9cbZOjRIjaZzYRsap8cQrHWXcv3BY7BnJRA4XUYF/CV
	JD4pNevDWXJqaKyUsKeX4u7Srh2yXuLlLMavhfJkpJvWq+ETsuk68thPAPT+JEHb
	x499FUNnuxb1yp1GLjZoZjQHIfBGgKsWyPH1r+QrzqbVFGfyOtv02L4OmULUL3CL
	OpNRxCTdAUi5UctDGc+FkcnflHHHL2kMehvCidHElqzccTgEfeS9c1zxClZ6TPrs
	i1pZaQkEK8UHcxjJIllOr7VcuYq5oEjTHnA==
X-ME-Sender: <xms:TqeTaC4_qtS8FcbsRD0JqSVI6AJuRuq5Wo_eh7JeM13gekFZOqzncg>
    <xme:TqeTaHbNukYk0UDiMRMMCQ8EoLe5fhD3wKe6Mr-3hxdDE2dYoN9123CD0GMjVFg9d
    UNBQaDURlAtOyXa9w>
X-ME-Received: <xmr:TqeTaH6pijREem8N4FgwWPPhA4R-qjeGnoa8ogo9ONan4SGTvO6ryOSp-5vrNO-T5HqMa-NQ2VnAtT1t8Ycw5sVU_JXwhelGcF5yqR0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudekkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegouf
    hushhpvggtthffohhmrghinhculdegledmnecujfgurhephffvvefujghffffkfgggtges
    thdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsth
    gvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepveeujedvuefhteetveei
    teevvdfhteegheduueeikeehgfeileevgfefudetheejnecuffhomhgrihhnpehgihhthh
    husgdrihhopdgvshgthhgvrhhtvggthhdrtghomhdpshhouhhnughsohhfthifrghrvgdr
    rggtrdhukhdpshhtrggtkhhovhgvrhhflhhofidrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohepphhs
    sehpkhhsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:TqeTaKAbj6zJNWHipgjS1mboYYb5x3YwCCBF4hhZQHWjDeLLReA_bw>
    <xmx:TqeTaNfcPEc1rBX1LfyUlBmlGl6ZvwuN97WOBH_4GFgVFZ28L56XQA>
    <xmx:TqeTaJJ5wGH5AvQFUv5Z7jHrn7xMoYiv8GwRiSqGmFVRuD3aAtRIzQ>
    <xmx:TqeTaI0wNjIKVNp4IJNGFcINYfn5yT78srt4F0cxIKW9zVwHGZYwQw>
    <xmx:T6eTaI0A2nnnj6ztdT6C0ceAILGkIMcT_eAfkUgaf7R9R0rRho7yZcRe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 15:04:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Patrick Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 2/9] commit-graph: stop using signed integers to count
 bloom filters
In-Reply-To: <aJNQm1r_FOIqsDlZ@ugly> (Oswald Buddenhagen's message of "Wed, 6
	Aug 2025 14:54:51 +0200")
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
	<20250804-b4-pks-commit-graph-wo-the-repository-v1-2-850d626eb2e8@pks.im>
	<aJB5uKFdGybf-IbN@ugly> <aJCW7aYqJB20LDNg@pks.im>
	<xmqq5xf35429.fsf@gitster.g> <aJEppnTkY+66IEza@nand.local>
	<aJL06Nlee6CR-KK0@pks.im> <aJNQm1r_FOIqsDlZ@ugly>
Date: Wed, 06 Aug 2025 12:04:44 -0700
Message-ID: <xmqqa54cuv8z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> On Wed, Aug 06, 2025 at 08:23:36AM +0200, Patrick Steinhardt wrote:
>>If I see a counting variable that is signed I immediately jump to the
>>question of whether or not it can ever be a negative value. I assume
>>that the author of this code _intentfully_ made it signed to cater to a
>>specific edge case.
>>
> well, there is also the diametrically opposed view:
> https://google.github.io/styleguide/cppguide.html#Integer_Types
> https://critical.eschertech.com/2010/04/07/danger-unsigned-types-used-here/
> https://soundsoftware.ac.uk/c-pitfall-unsigned
> https://stackoverflow.com/questions/30395205/why-are-unsigned-integers-error-prone
> ..
>
> in isync, i standardized on unsigned where possible (e2d3b4d55), and
> sure enough, i introduced one of those underflow bugs not much later
> (859b7dd7f => 12e30ce56) ...

Thanks for an amusing reading list ;-)

