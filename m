Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A61139EF05
	for <git@vger.kernel.org>; Fri, 22 May 2026 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779440727; cv=none; b=uJbDxbqDZjSwnBqxJFyhkcyfqcvSmpHSk3c4k2ilAHzFPA06AIJYViaQO0hFFyqx++2EvN/hKqj/w24ZSNPqD7zwTzNJ6yrcAdZAq1DjRA2CaEKBBg77HRgEsKUvzHS633YCgvxPOV6nvcuDd1cYrgVqC7kKyB5tmSP4RlwItMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779440727; c=relaxed/simple;
	bh=FT9HoCCZfoc/vdE05CRltTmCi+d2oLrYmCOpj+IEO0k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NxvAnNR6z/DAVML1NxDJDcbN5fvW4fpShyJ0yC5erFVgdFnHtDi3gd/sYzZ6XUgeROjl3nm9xp6E1NB5lWaDLgYn3mof0RwOD+1yeCVwwBp1KcsEhYoXEAVxkwfo0ADjudqbuGlVkdvGEzaSCaHa2C52kF5wXqqYyj0qkrLIelk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=EOi+K1Z3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ddcH4qaW; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="EOi+K1Z3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ddcH4qaW"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 733CA1400056;
	Fri, 22 May 2026 05:05:25 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Fri, 22 May 2026 05:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779440725;
	 x=1779527125; bh=FT9HoCCZfoc/vdE05CRltTmCi+d2oLrYmCOpj+IEO0k=; b=
	EOi+K1Z3vwS6rerNwPBMl8ZmADv2m8oIXKDNWBGAtuRfEuL7LSREcwQGxSGG779W
	pcFYP9YnJbswuAxm39VHLJt7tt8WYiZSSksWiqhg2ouz8RT+l6EsQeTBt+YqgIGA
	1ssvMG0kkwhYTxhqh5jzbtC/TuwFNj9lHsXtwnEzVqfox1hZnkp9Y+oAPz/yoyD+
	gd1CD7vOIewNqxuKmiPivDjdU4bOTURD2PPVf/7ukwr5iqm45FgYB9R5PHYQu/7g
	wy4TjMhGRXIjrif92JRer3XxAQQvB5BBzMmcylFpq4wDrpRKR8V/f+eWHQFczU3Y
	+Cb6NqS+VinexQuODmeYGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779440725; x=
	1779527125; bh=FT9HoCCZfoc/vdE05CRltTmCi+d2oLrYmCOpj+IEO0k=; b=d
	dcH4qaWATq3RwupFk/hE7F0MVW65ymPeTiCym3Z2fbB+ZinukBk0WMtpUw0nyUVy
	+AdmDJRrs2CacQ2Qpj0f/lY/HShfO8g3OVooosDEVqaLrSyeYUaSyCvexDaMaa9G
	/E1tHgBkBsSTQXfQmFd8QDObDYhV7kgq87aq5asDCiPiI8JWeKgdNnijWsV5WJPW
	3ewsmm1MTRDcfJBMx2H8dYtq0wGZVREFeE6vWfMWPdxPudJmoMBHmWNiAqI/87XC
	NGk06lUabQBSl8b70hrIzFwoEMTuonUOpnKD+MgPAe83IAIpwqKKFTo0WapSfcxR
	k2d50X0rHgAh8q3Bxa32w==
X-ME-Sender: <xms:VRwQanXCkopqbIEKzaiWYHrndbzXQn2GHsg9w9RVqFAb3nRsQCMV-Jg>
    <xme:VRwQaqa9nHBfxxAj7VgjgRdmKvW0jk1OJQztgfQ6ecMgxFApnfT30Q6fBdJB2jhPT
    gcs9C9Et6-jqYsG-NpaqwLZ4dNWhd1r5nTjOVxs2suuKQne1jko>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeelleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:VRwQauCwFk1KWVFgbGmWpeXBkks3eIT6SP6TmqPiLfcTY-D6Sdx2wQ>
    <xmx:VRwQamfY7KuDSyI9VKQjMCNoMnBbMIatpjNgcudkAeG6dgJ-cbWKpA>
    <xmx:VRwQapIr_7jv0s_T7OXo49g8MjBwR7jlwwp4IHmOx71HvKLrxgTPuw>
    <xmx:VRwQapek-mlIfA6uLK80ELQNuQpHoaNg-k6WhoS2NTWKV22_euyf_g>
    <xmx:VRwQaiIKTcif6O2JqS43qRLxujDCvs7AyEwU0Gvr3pwfeby864PNAsYU>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 50AB63020081; Fri, 22 May 2026 05:05:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AKLsyOUqBm4J
Date: Fri, 22 May 2026 11:05:04 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org
Message-Id: <b6b3448b-ae21-49ad-9c5f-e1a7ab8dad70@app.fastmail.com>
In-Reply-To: <ag_yUsOEO6AjT4Ky@pks.im>
References: 
 <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
 <20260521-b4-pks-setup-centralize-odb-creation-v1-1-f130d2a7e8ae@pks.im>
 <741c2a26-7380-4d8e-aa91-fb237e9f10dc@app.fastmail.com>
 <ag_yUsOEO6AjT4Ky@pks.im>
Subject: Re: [PATCH 1/8] t0001: plug test gaps for git-init(1) with
 GIT_OBJECT_DIRECTORY
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026, at 08:06, Patrick Steinhardt wrote:
>>[snip]
>
> That reads a bit better.
>
>>>[snip]
>>
>> Isn=E2=80=99t it more that =E2=80=9Cthe upcoming changes *would have*=
 broken=E2=80=9D them if
>> not for this change? This seems to refer to a an alternative commit
>> history where this change does not exist?
>
> Grammar is hard :) But yeah, this of course refers to an alternative
> commit history I had at one point in time that did break this.
>
> Fixed locally, will wait a bit before sending out the next version.

Thank you for considering my small input, as always.

Cheers.
