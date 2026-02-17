Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305FB36E465
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344828; cv=none; b=sVZSi6oSqe/juw6d6YGNuoU1816D+UTyVm6dzH296N8aHqADdB2DcMzX1hMIjF6IcwpCwdItqGOxxonUle1J6c6AqvLJRgSGH2MsT3lMNN6BpdHQ3FFj47KsX7/ubuv2/jp+J+6HceYvOkwi80mnJmsSu7M6T9PtdOCto3PxIgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344828; c=relaxed/simple;
	bh=PVmzFyWCsAditY5lecP+8wAy17S5z396AwDRx53DvYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPbOBVzy0QEhG1/T0gOAhze1dV9VuH/yhKP/sKUpJS/SXE7yFyhFpTuWoqjv1RfzsCWzdbvRVtmJmzxWnCyKGMyZ22obQs+9REPCHEN4P4A9frh7XsJP1IgpUcbpZbyv2oFiInKJ5w2aYHVIvR1CZXxn4BSdLBS1qn9CyqMkm3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZZerrr5s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DkxSRsyk; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZZerrr5s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DkxSRsyk"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 6C293EC04F2;
	Tue, 17 Feb 2026 11:13:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 17 Feb 2026 11:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771344826; x=1771431226; bh=Q4MtNtHlRm
	yShhR8SzPKgPy9F6oXJHdIao0TslCx5ig=; b=ZZerrr5sa66C2dDTlX1TgGUfJV
	j0jGqdqGW6nrVzzDVwqJ90/paXhhVnmOZI9zvVML3fTQ1Tqvzxby6Jb9X5gmrlnq
	UGJJh7RLSejTDgdpPn0r63CdoD6MKdGGidDlHkwTnwF00fOjm6PMYjfAWunmLMRc
	x04Y6819jCjyHXZspywjZ4DaC7Pa7j+sJVzgxxm4HhXBryx+Fva4CEyQxHn+hDuH
	K9JFx/WGjR7Ql/BuDsM8oMZKh1yTIz6HeSBWjt8x9t02B/gMe2c9WiV1BB3Nomqh
	3TrFQavbqSJrg4NJL8pi2xx98Y0fGoR3cjU7PXdxuCBQO7WXJjPXLy4PdUFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771344826; x=1771431226; bh=Q4MtNtHlRmyShhR8SzPKgPy9F6oXJHdIao0
	TslCx5ig=; b=DkxSRsykQiRYXX8YuyPyOd1awyr6ciSI9uBdCUdbiWe9sS7+FHu
	rKUMNan9KF+L+SNwOBTDxL/+yFQeWPW5GPa/CUHFcD+MI7iMsqeDpGIulNzKgntl
	qQ+TTRkoCwHEFP5IO7K4B/P+mbgDul6tvqk08RTn6D8vG4hG4uXmjTC6oqIhpELC
	zfD7FvQeoKQ7u5a4D/We+MCHGJ64Gdqvmc9zeXXQErBHf9kxsH3nwLHnTS65xaaG
	D5ezLr3X7bh0HLVfm/7tyJO1sKCIDLI0DETAoNOruLWNwQg5j7NyNBOeGZSFZZzV
	iOgU/lPyBkTrSqjR+IBPViSJwMKGYi01M6g==
X-ME-Sender: <xms:upOUafRaH6m6_7vWdCtF2et6wAND5HKtS_LlqiMtpTaUFw2u_ae9WA>
    <xme:upOUaf3saS0rkLhjyK44OSorhgB7YwXoAyHCmDxgZNu8kX0CVMNl7xFKOsJTP3xTC
    d572ufkhNOZdAO1NiGmUdMZ36K0q83fGcd2bIQu4mJIJRmXERqXUVI>
X-ME-Received: <xmr:upOUabDzzfPrm59l1v1rJU4X7Jva7wbjvaZxDGJ6ROcjmlX1aEFbmsh6v4WZ5W1FglZt5xziwzAx0Nil4XaSxGs97TSuL0bsJw5Jm_-SIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrd
    grvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhih
    hllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:upOUabj_yZLtrz6UWoa6okELdg86CmMqlRctzm6Nyo0yO5e-OJiOjA>
    <xmx:upOUadO_n3GUw2pW--ehS6by5iJ_-Wjhz9qfKCdpCWLp59AVpMiaQg>
    <xmx:upOUab88mJjMEztQTL85NMewgHnKAqDA2kARqonVQoTpCUkt_YPtUQ>
    <xmx:upOUaefHPOQfj_fJ9hHytdW_KvAfJTjQT8__h8hmj5tXgCqiaGG8Bw>
    <xmx:upOUaQpCn9UbJ-scz9k99BA8GzhEk4AoYfxxpOud45u_m5aloi9PE0xT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 11:13:44 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0e77c09d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Feb 2026 16:13:42 +0000 (UTC)
Date: Tue, 17 Feb 2026 17:13:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 03/13] config: make 'git config list --type=<X>' work
Message-ID: <aZSTsVApNL3A7y8D@pks.im>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
 <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
 <6d2a48a3b7f61c068392e66933caaf1d78055857.1771026918.git.gitgitgadget@gmail.com>
 <aZQvLzL-AhPG3rbx@pks.im>
 <xmqqa4x7e4eb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa4x7e4eb.fsf@gitster.g>

On Tue, Feb 17, 2026 at 08:11:40AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> -	if (!opts->omit_values && value_)
> >> -		printf("%s%c%s%c", key_, opts->delim, value_, opts->term);
> >> -	else
> >> -		printf("%s%c", key_, opts->term);
> >> +	if (format_config(opts, &formatted, key_, value_, kvi, 1) >= 0)
> >> +		fwrite(formatted.buf, 1, formatted.len, stdout);
> >
> > We could probably use puts(3p) instead, but as we know the length of the
> > data ahead of time it might be more efficient to use fwrite(3p) indeed.
> > Ultimately I guess it doesn't matter much.
> >
> > Patrick
> 
> If we are not always doing LF-delimited output, puts(3) would not
> help us very much, I suspect.

D'oh, right.

Patrick
