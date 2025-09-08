Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EEE3112DC
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349867; cv=none; b=CXkP29Mhflyy+FdKYrl/v2MCh0JUrzOl0wnFxRQmrckxtJ3mQVc0rotDa+kT90GCXmMB7Cj+Y5UR6x5HBHTMFayo5eIhUHJUHOkiE+1DihdMlkGt3kJuEUEIDpmMGI8tRvvTQBSFtwdcMQNYyFIZMSCYzQNFnAhG9uAoT0/aGJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349867; c=relaxed/simple;
	bh=W0pKbaLQyym/+CEpgkFoLFcKFL4kuh1eBp3I3ztoANM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ETjPj9y4/IxTiRVFZ80xFHWGn3EyWtSLCGubEIb7AVSfjZNkv5HL2bZiYp4c9aFWHaU1Yold2johOe/1xQc0UtBpzJsXKHlSIrb81vnVQzGoqPzM3wCA0AzdhGtMLH37JpNYwwPybNfIMQDwwQNtISN791BJYkRxEnf60mmZHTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X2P+di1p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i/1VvQ2f; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X2P+di1p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i/1VvQ2f"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3FECA7A0151;
	Mon,  8 Sep 2025 12:44:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 08 Sep 2025 12:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757349864; x=1757436264; bh=0Md5rIUqry
	SEjSxaCbEK1tbE2H5z3V2wIVcITm4ydCA=; b=X2P+di1pXf3iD8acaZtfxOPeRi
	4jxy+w5YGYwQJI214toVgcOB/5idO3w4XOn6jDZIEL3vLa4gFHhMy0KQKlXDFoDx
	haTRGfu8GF6Q6qnbZ4yQSNjJhXJbHXbIK16LKwS3ayjRiGZExNSaSGeOTPwNUTMe
	Z0ed/s2NIR7+7ZjPvRB2WqC6lwVS6i1ghB2khYwdSI0C3HGLPC8syL2+CM7G95Kp
	M8ktla+tJVkcow0A5KYD2CprnuOVB2WmoLaY0+/Iyyl96ZdKlS2eAIONEeTarA6r
	zFrb5h/Y92OEPrKPP4Kv701OKi24hDvcxoQJxIX1bBh1oIbaj270hNA3JXuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757349864; x=1757436264; bh=0Md5rIUqrySEjSxaCbEK1tbE2H5z3V2wIVc
	ITm4ydCA=; b=i/1VvQ2fsoHYhunuTrn4oHP3ZL4AbyVDquE27CcR+KS9c80Sdmn
	9F4s2dHYRJsUdkwOEydH/sRlFNjJl+gyeMXFkgMRkBySO058wAKddHEPrKgYxU1V
	0mQqYCrFA1Vv9NTz0lxasiUbySgnVpW3+xXkPNbJZqnlepAOA95RgM9aB1Nw1pGz
	pQNJM7voFBg1p6hgDyBTw/ifX3Foo8lG3KjLCsKnpkvjawONz9vvyhwdWR2VL77D
	WSAiNDHx0ebCzGpTUyC4hDmY7sML4W9AxzcqA2yEt/jx0BJO1lNww3JszFXYhb9B
	hzW3K/y6PMWO8BYeuLfyMgrEfJo3KZlnWoQ==
X-ME-Sender: <xms:5we_aA_W0NdBzOcSUT5UfX47FIg2gXU85_9-ACe6rkLCb5fwzGQYgA>
    <xme:5we_aEMxI3_sMckq9N5qr0MpHjC2GZX8fNNpr5poyZz52GPophQ_ssHlm2Y8mVerU
    xi_DDZk5qo6x9SJWw>
X-ME-Received: <xmr:5we_aMdVo8mx4wBBV287MH3KNHF5G8ry5891y63WezBXgOMST3JgkDuc7nth1o-ieN_miES4PfGygMAM-EQuq9S7D6a-axgDAgPmSyE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvggvthhsohhniheftddujeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5we_aLUMJnSy64gziWafPHLMMgNALhqVBNMk54DLJae9u2x5kbD1Dw>
    <xmx:5we_aMhgdlQumw1vP7NuOW9eXyuykUbzTWVqurza0y0tedoFvl4uKA>
    <xmx:5we_aC8t9E-MSpuDKvP65KRqWvacUB7BUy0gn51lNym4dKBO0HbuHA>
    <xmx:5we_aGa4VMwPFtzMBy98rWRlwVT9YZoF7KGNquorsMb1JNvf5Hejog>
    <xmx:6Ae_aGti6oJ0_21HEnNCK3XY7Nv1PhNi2StGtIH_puSLnBoHxzAmRxDF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 12:44:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  shejialuo@gmail.com
Subject: Re: [GSoC][PATCH v2 2/5] doc: factor out common option
In-Reply-To: <20250906075147.1076656-3-meetsoni3017@gmail.com> (Meet Soni's
	message of "Sat, 6 Sep 2025 13:21:44 +0530")
References: <20250906075147.1076656-1-meetsoni3017@gmail.com>
	<20250906075147.1076656-3-meetsoni3017@gmail.com>
Date: Mon, 08 Sep 2025 09:44:22 -0700
Message-ID: <xmqqbjnkyjvd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Meet Soni <meetsoni3017@gmail.com> writes:

> Subject: Re: [GSoC][PATCH v2 2/5] doc: factor out common option

Be careful to make sure that your title is sufficiently clear.  I do
not think the above is sufficiently clear to let readers tell what
doc was updated to factor out options that are common across which
subsystem.
