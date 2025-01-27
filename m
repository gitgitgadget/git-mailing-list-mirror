Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113DA7083E
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 17:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737999868; cv=none; b=kSCHORpnzOB38737M6ssN4n1hQBY/mtpRLT0RZwSj0c/jK9BT2uGlBUlcIkI1zN38D4d3Z70ymPHaipE0fjeSuidUSlahgyJaT//zC4biL7ibRr5Bh9JCKOeydPVtrE8IvN46fajpLdGmtWGc2hrE2UlSTf5lGIJMLB6HmIzUes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737999868; c=relaxed/simple;
	bh=2kqTmIx+4IO1zGLkZqTiIlRGVoLv1h90PHgfNjHhj6M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NkO0DmVxzQ2nXsVo0uUvLifrmFkvyHfudSNdZ7QP4YQCMTf9ih2XpMUDodCIb/Rbsj7JNKEeH2saidS0r3xlBdhANrlyftETF2sNWWROJZBpu1gyXTw4ClKOuAMT8B3X9kQoU+ipFOL2u2kNR87wT6ARMw7kL9Kqoz6nxSzqbNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NdKZchI/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tsb+GYaH; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NdKZchI/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tsb+GYaH"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 019011140207;
	Mon, 27 Jan 2025 12:44:25 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 27 Jan 2025 12:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737999865; x=1738086265; bh=dZ/3SDvOw9
	1GQtQoNOuVfoPQcR+oNOc1rZ2cIFJkujk=; b=NdKZchI/JYaQAcvKZIluIR1GuD
	/lG4HAgK/20dw6COasm8bUVj74W2yKy1YzjZhMFjzaKY2llU0QWIQTbpyQ+Xd6Vu
	nAWrSvbgtEZMEreMjWWmor3XESp/cFkKRC3ju0wNNvNSjuyktICvdJeSA6GVELip
	vpuM4xsvN31v+QQ32YKWj3NBjx2SOj7sKVvh7diVoDRU4y7fzEKFXUhLaPhm0jbK
	85RG3DHa1Zw/Y0sEpp05wKJCyCKP+EnRxKbml08LHQ+sLzU4X/ImhVDQdT5rEvds
	4AvTEcLKZBNaaIQgwsi9dMnekbOBaaRWo0Dmm4bytnihPPGuV2fQGusDhZVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737999865; x=1738086265; bh=dZ/3SDvOw91GQtQoNOuVfoPQcR+oNOc1rZ2
	cIFJkujk=; b=Tsb+GYaHqvEqmOOOFUo0ZrcDWon6W6kxwtUcBNxYmIUvcOCLDc2
	reUudTTlwdVwM74VZ5shuIsiZ+sScr1iWtNB7znOfPCq1KHDIutPDtzeufXVC+9M
	tQBC3TO3svHoEWdhZ48688rRm6NRTx/InTaXmsuGBFY2pGrjSip80wtMl/jEUh/r
	FPTQRs98fWC4XMg8SFlaHmItBmPjTKZlK114zjDcr2k1kepsnli76iVSZIYKWz+9
	YIRC43dUnEIpnSs1sH06TbJsg7fxnT2LFKFl9PoFV0yD79rC7+eK+jJAcmaLPRcm
	1WRfc3rk27/t0PROFDwcF9GE+cU3jW9zaww==
X-ME-Sender: <xms:-cWXZyfnFCYOEG_6cd35ewCo81vLayJhzVfel05JAUpB0P_VAM5OGQ>
    <xme:-cWXZ8ORfTDye88Wqq4XNMi1tdXvimbrvRkJ0hwKbzEZavLtg4YEPMEsgWF9Z-qUL
    ymFmwvtiYEdgGSO0A>
X-ME-Received: <xmr:-cWXZziakOeAsuSJyLVkm7t_PJ9cUhir_zW31O7NnbE1kdLaP_1U-f5NsEwhjuVI-osayw6ejPYRY1oldCTbWn2-sQ1fTxQVb358>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-cWXZ_9lo4Nk7w-_WzKwZkV0Sj6NSug2i8IX1loxJfNW5-i_6YXxjA>
    <xmx:-cWXZ-tLjT8j4HQ8Pa2Moc-rU82VRvsVnd6l9VYgJDpB3lFe6Escuw>
    <xmx:-cWXZ2ER6UiXSqX_DNUq801kZw6a8fSfuDntll-c4m2HJbAMfyog9A>
    <xmx:-cWXZ9Md4wbnBTUs-dxftAfiXXUoD9B3IcUDvuns-H7KTAF-JS99Ww>
    <xmx:-cWXZwJ0PaTcnqFGvtq9aopJry4qCD1YE3nh76fOPM3KrVrITGgkUXjS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 12:44:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 00/19] reftable: stop using "git-compat-util.h"
In-Reply-To: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
	(Patrick Steinhardt's message of "Mon, 27 Jan 2025 14:04:08 +0100")
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
Date: Mon, 27 Jan 2025 09:44:24 -0800
Message-ID: <xmqqtt9krw1z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> This patch series stops using all kinds of helpers exposed by our
> "git-compat-util.h" header and open-codes them instead. In order to keep
> us from using these helpers by accident the final step is to pull out
> POSIX-related bits and pieces into a new "compat/posix.h" header, which
> the reftable library then uses instead of "git-compat-util.h".

Very nice.

Is there something we can also do in order to keep reftable from using
stale version of these helpers that it copied with this series when
we make improvements on our side to the original?

I think the answer might be "then use a common library
implementation that is used by both Git and reftable", but then we
might be in the same place as before?  I dunno.

What do "libification" folks think?  Anybody?

