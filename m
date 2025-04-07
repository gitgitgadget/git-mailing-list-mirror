Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2C722655B
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 07:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744012299; cv=none; b=ErWt4VjMuHeybztMQMgC5vE5ggGs5sNA9EnlJneNAjXKiHRq4DQNKutb2E4A/wKkLaMaZoAhUQGyI7wgnaQAHHlHJC6Ml/60otyKsCTbuw81WwaepUwVoGFSD+lAd3smiZjsN6xyKe3/I97tf0SKuZPAelrmPb0TmGQoEKA54XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744012299; c=relaxed/simple;
	bh=Bsi1jg/PSknGAwnGSNVKKcZuxlVpfFjwOqXAwkJmrJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBabJL9YM+7lWkKuIDSwWqBAFUthkiIfQ+YXqDvCzdswv8zsaW3oKMMpye81Vj1TQBjcu8ejD7dltr9B4GOqb+Otsa4w0KPutdtoZKQBNrYhXXR+ETu5AQDSp7PfxO93+VHbsDDj2hWsEsIt6AaZXzgAOpcxAuJlnaGPMaUiHsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lip9JGlL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NTnHonMQ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lip9JGlL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NTnHonMQ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 42BFF13801ED;
	Mon,  7 Apr 2025 03:51:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 07 Apr 2025 03:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744012295; x=1744098695; bh=X7EKgTRvYp
	1OwPfl1XMxHu88heSr+xJoR4ekrx/hvSI=; b=lip9JGlL5USBumjlPIb64OBsDn
	YAh7MDsah2IQd/J8BzBiPFrhJokaKDhM4z6/H+GFqeTk98zbPe/qWJe90jjoWHbr
	B1HCG7TkyT9pmEMV8v6lqegybnVaX27x1AmLJ3//o8fSvlPflHtqAQiYwxOJnkyu
	2a0c7bWvB3GAPSYEdtS23Ejpjoe3KCTm3U1eaVVUFyZXQfTq6YGio25suVsVBg8Q
	BpgxxaSM+HhRiePCt4DNoKxUYO9imINXk9+RWIVly03mFaCEB8AUEDEYOs4Ei5+/
	P6/I8NXEqapeyOpmOuM9ChjVZPzUvXha7GTOCbjWeTjBKxEJdjLEx6L+OM7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744012295; x=1744098695; bh=X7EKgTRvYp1OwPfl1XMxHu88heSr+xJoR4e
	krx/hvSI=; b=NTnHonMQHAZCPVkJkHdAihGN+uuV61lBYbVU2psPgWR5PN6zVPK
	6zorNEQ0FPGNwrgYN3E4nmrEijZTqRLYA678MTj2qmyektOGe7Ic1gN9Z18dbmia
	p+r2yaDjhJHhlOkgNH0wqaaQ/CHc4hxpQABMVZ0DmQGWDEldbGcoojq5r185RUi9
	fNtrYRrHnPzYQTw5ZieXarkdSTkevIazjjPv+3lP1/cPeuaLgbOVNrg77yagGCsn
	EzKWOcOcOtmtdePCa8Mp1LpsepzmKqPyMpcK6dzcyaOSyslSe1YvrzOJQ5uZlTrc
	f6iQzUfXzn1URDN0NkchsmW8WPIdxCBV2ow==
X-ME-Sender: <xms:B4TzZ-YVQoIfdjdKnNzyqRjnEkt39Aq9TDljonuMpfT02vcnmmgxDg>
    <xme:B4TzZxYTzsFTzEO1pU1qFIfczhJgJ6fs_WyJN82x8npUuiKb7mxd_ghJN6SpDvBTI
    knHKgJw1EVVYCNhQw>
X-ME-Received: <xmr:B4TzZ488jE2ehgKNy40EhcV_I3obpj474QpUybZGbAHRjVlLwvN_tQUcNXRabGLz_WXohnDiec8VuL204Gj0_Ew7judH4-sVagnwtSFHrQSkgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleelieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprghnthhhohhnhiifrghnghehudefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnth
    hhohhnhiifrghnghdtfeesihgtlhhouhgurdgtohhmpdhrtghpthhtohepshhhhigrmhht
    hhgrkhhkrghrtddtudesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirg
    hnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:B4TzZwqv1R0HO7SfoTlg6VlHI0yg0fp-bpcaj7fa6GRhXx5iuUrXvQ>
    <xmx:B4TzZ5pHuvRRUHhgNNhKbczQo4jWNxosfWBWRvbFns_Dqqeqoy-T4A>
    <xmx:B4TzZ-R0g55D0jdkbFNJmtlI5F4Rz4ZZxDGeSFme0k-0ypWhejipJA>
    <xmx:B4TzZ5ouy4XaPlqhI2WQcBIbgGn1ydd9woT-C5LTgtfCLHS6h3US8Q>
    <xmx:B4TzZxOtIPa4FRBJwMhJxLlW-nYSNZMmAP8rGgfZDoN4sJKYWSfNA33h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 03:51:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1d13d06f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 07:51:32 +0000 (UTC)
Date: Mon, 7 Apr 2025 09:51:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Anthony Wang <anthonywang513@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, shejialuo@gmail.com,
	christian.couder@gmail.com, shyamthakkar001@gmail.com,
	Anthony Wang <anthonywang03@icloud.com>
Subject: Re: [GSoC] [PATCH 1/1] t9811: avoid using pipes
Message-ID: <Z_OEAxJENE_mGkVa@pks.im>
References: <20250405103718.25160-1-anthonywang03@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405103718.25160-1-anthonywang03@icloud.com>

On Sat, Apr 05, 2025 at 12:37:18PM +0200, Anthony Wang wrote:
> diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
> index 5ac5383fb7..5abac938d0 100755
> --- a/t/t9811-git-p4-label-import.sh
> +++ b/t/t9811-git-p4-label-import.sh
> @@ -95,9 +95,10 @@ test_expect_success 'two labels on the same changelist' '
>  		cd "$git" &&
>  		git p4 sync --import-labels &&
>  
> -		git tag | grep TAG_F1 &&
> -		git tag | grep -q TAG_F1_1 &&
> -		git tag | grep -q TAG_F1_2 &&
> +		git tag >output &&
> +		grep TAG_F1 output &&
> +		grep -q TAG_F1_1 output &&
> +		grep -q TAG_F1_2 output &&
>  
>  		cd main &&
>  

I was a bit puzzled why we use `grep` for the first invocation, but
`grep -q` for the other ones. It made me double check that there is no
surrounding shell that expects to read the output generated by that
line, but as far as I can see that is not the case. We might want to
drop them to avoid such confusion (and explain in the commit message why
we want to drop it).

While at it, you can also adapt all adapted calls of `grep` to instead
use `test_grep`. The benefit of that function is that it will provide
helpful debug output in case the test ever was to fail by printing
contents of the non-matching file.

Other than that the patch looks good to me, thanks!

Patrick
