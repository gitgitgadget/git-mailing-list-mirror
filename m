Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA6B190068
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735832515; cv=none; b=t0t02vKRJUuQBLadZQju147qwLi826wdhfQizLmAPYWIj96ZJ8rk+EAbmPcwyXsafXXsZgL/at0yIG/8TzRUG9vToXhc0BZmU4GTg7flxgNqN9/n7BWvmmpP4I2o81hzjwLuphF0S4jucgu9d5cnF2R2MWsaTk+9Z3NXjKfhbps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735832515; c=relaxed/simple;
	bh=h4CFSaBj99y7F347UI829q2eqBKp1NiTFVjZH/+iJ1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LFSdUGiXOoelNrW6bYYDwehV8VTE8sz5/+lvOoy2OzRQ/n+TdEavGb2dTjMakiBKzKf3rbjPzUWVfb6D3eFtL98XnCGEG6D/g68j6/Nml4fRsTpdzMMwijl8AEvutsVMxAKdxTLQF4c3UY+YDROAPVkXGVbMcJwdAxpKISchhEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EaBLwaN6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jz75j6j7; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EaBLwaN6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jz75j6j7"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 007D111400EE;
	Thu,  2 Jan 2025 10:41:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 02 Jan 2025 10:41:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735832512; x=1735918912; bh=h4CFSaBj99
	y7F347UI829q2eqBKp1NiTFVjZH/+iJ1I=; b=EaBLwaN6JuSQXSSme4cs3wkBe5
	spwhZLJcUFEkI77GBwByqqSxyVbDSMG0CCH5JfciwNMxahGVVAZ12F7rXvEmF3ju
	IHixCJgrmeltrOp5lpdQQTCTfUwOeFCgS/jCwwqJ5PqSwIzHJJJWYr6jg/fXN4Ls
	O1gKzs6MwtvN4lQCeCdqmw7++kDEfVqDPbrpCkHX5kRbDhgykUWrjxn26y+P0Wxf
	nDFHMeGiSB0JXfl+gqiBfIzeiAeYW+wsqeaVuOlqY1oTvKHQ8EPNRRkAKC/8+QTv
	VKgAXA0vtw2EMVsVMq0/GNduRooWT/OeKk50ojl20bv241YCEGvsI6Ls8ASg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735832512; x=1735918912; bh=h4CFSaBj99y7F347UI829q2eqBKp1NiTFVj
	ZH/+iJ1I=; b=jz75j6j7VGklq6vsRn245ouQuK4AKOmDx/DD8PWUZa/XNwolDAE
	rXSe7XXhIxx7FdQjW/fonU5vHsHAlv50XjZp+YEb3PxV/zeXpi5Y3g4wK/G68acT
	hrwOe/sIOrxEFpv8580OmqTRts45r2wgtv+nrxVcR/Np315FVZaBZczUJ8GW+IGt
	Wy8tdgXZzCfVKam4q5Z0iPrjiT3qbkEFWk/D9ceNeWm0L349PDQyJwHsAsXhJJ6+
	eKKJ5zWoLkirF7lWCq4NczGRKM8VAEbMoxEGUFyepRdF+dh5Qq0yhUmjcMbVHGH8
	7qFHEGeZRy8NbXhhW0CsAvepJ8T8xdc0GuQ==
X-ME-Sender: <xms:wLN2ZzXVCLsYuTT0nISlYKpK49rTueJ3ZTDC-fAD0BD03U5LcB3qdA>
    <xme:wLN2Z7mBIl10NJlgYEbijcZybL231wlJO-5LaYW4KrdmItlR6kCi7TIO6USTddc3y
    rRtgY3d1PC-UgFFzQ>
X-ME-Received: <xmr:wLN2Z_bJKaTrQ-4wievWhFtgOyUAAT74I8HDOT2dlCStHHE567ZlbGB16vd8zUxj9nMVzINg2b27EWqk4ATaHHjBw6-lTcNO5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefvddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepgfetjeegudevueetieduhffhgedutdejhfej
    vdffleetlefhtdevjeeuheduffeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopegrnhgu
    hidrkhhophhpvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:wLN2Z-Vt6ThnT06bHR3o1JAGZDDZ4XbFntFACtXIe7Yqb2duvyyrpw>
    <xmx:wLN2Z9lMfxW2uQrTmiUGM7vBTygKqeMmzeXgytU2JOErRer4lzO_iw>
    <xmx:wLN2Z7dKMQ3jsaad2iVHNyrgo424FGt4OEzBMakXYb6K175bZ5Zb1g>
    <xmx:wLN2Z3HLbuxIyZtkQiCOFzuulMpXqr_9eORHW_SIIgoBvJzwU8QWaw>
    <xmx:wLN2Z7bxWbYrJNP0Ol-M9sFo14daUL8vssEfseaX4bi2GQGzpuEIM_Ei>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jan 2025 10:41:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Toon Claes
 <toon@iotcl.com>,  Andy Koppe <andy.koppe@gmail.com>
Subject: Re: [PATCH v2 11/12] t/Makefile: make "check-meson" work with Dash
In-Reply-To: <Z3ayzUEfW1xd4Up0@google.com> (Jonathan Nieder's message of "Thu,
	2 Jan 2025 16:37:49 +0100")
References: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
	<20241227-b4-pks-meson-docs-v2-11-f61e63edbfa1@pks.im>
	<Z3ayzUEfW1xd4Up0@google.com>
Date: Thu, 02 Jan 2025 07:41:50 -0800
Message-ID: <xmqqikqxussh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Nieder <jrnieder@gmail.com> writes:

> Without this, I get the error described in
> https://lore.kernel.org/git/CAHWeT-boK3x6mup11boEinNDQiAxxf0vwvZkxsGRc_GRvXYA8g@mail.gmail.com/
> ('/bin/sh: 10: Syntax error: "(" unexpected'), and with this, the
> build in the Debian buildd environment succeeds.
>
> Tested-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks for fixing it.

Thanks.
