Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8A02701BC
	for <git@vger.kernel.org>; Mon,  5 May 2025 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477688; cv=none; b=HcQY9/d//g/hkg90ibscno1k4LAcl00OcSlzHjz6dxP8rwwBkQhn7hAsojFLVDNiNz5Bt5RTz8Ipp7Z2xy87twKaDmcaTusOJgvUxBAUadU0gmrOuW2nXbVoBOMHsGQf0+3oEERUi3bmHPHcMnsFQuZi2Fc2LgDkXHJtxFPK0Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477688; c=relaxed/simple;
	bh=MC+t7w7hTd3wmT6WgCNlsHVKHukXth9nA+fZQ57D4Mc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VW/Yx72ZnoNVmQsQIVidAFnB0STe+OsPgUOqaRCA/AICJb34iBnF71m4wSndxwjFg7KoEgKqzGYU2eGNpZSWMfKh2Tr0wm3tVaCYvG8t8QR1CrlfnjTTOUXG5bk3aENYbNDYN/3alsSQCaIlssCKyuz65ANi+E47lKBViSSHg0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BjuwUgnM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n7wIACHp; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BjuwUgnM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n7wIACHp"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 18E6511401D2;
	Mon,  5 May 2025 16:41:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 05 May 2025 16:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746477683; x=1746564083; bh=42CYB7p/mJ
	vAmvSDI1dGwx6gdnnkz1uiDCVLL1Cp2SY=; b=BjuwUgnMUTGLiEdKElPrIdfOch
	NXNT/uzMwJ/sb2RlUR9MwLQfnRsH2uRmMJPQrrpCy1VJYJckOvbMw1GFtoTiF6Qx
	2NSA/d0d/TvaMzW3HUCav1nvcAExcfmGu325hLA+kq2TEnVQFsOfydCJyuStqNo4
	TgNYS1N4iS0TplVS5lHhaTRjP2/eqlXdJFl1y+UtcbRMF8Eya9qJMadu8sEwZjlV
	G5ve2dW02C9S0lEci/quJsa21JWZwwjDFqu3RnhiN5/CNjupd5xqGeqTRxHYjlp9
	ZWxFpLZyu8T2pVNTr61qviGtUPLC+0BTAq3n/B4xfiUhKmB/OQH1992zqjEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746477683; x=1746564083; bh=42CYB7p/mJvAmvSDI1dGwx6gdnnkz1uiDCV
	LL1Cp2SY=; b=n7wIACHpDkv4vE7RD4tR1d6jA35Q/hGwNImC4VCTbS8ZM+Mj17y
	HMsrpJRqwTE7L6Ii4rwptJOSWir4gb1mAkFctsECyk41PFPXlOa7CeqPqjdbE0df
	kRV4xXLXinMKaJhBXaVncY8zvAJbqX6sl8xBCk4gB7uM6XwvhZ2AFaSAXBG6irnx
	uVBiQuEClNeQaf64T7bn8fMWCnsQ7S1UXkF0mAjXsu4jhR1VYU1SIsRaOrPpaISb
	KosvBORyYefPkmSVPFxqFk41lepufZp2fXI0n3f7OiV8Kv/k9ypvGEnVYiPGQqdj
	1Mo6OHCoHw9CB4J2B8jMamV6ho/kIlT71pg==
X-ME-Sender: <xms:cyIZaFE70Lz2A3L6XS_weQn2cgttyV9ap8b8UEmttXAE6tB6CSvaPQ>
    <xme:cyIZaKUjlq5HTfAS1g11BFFk7icgwhSIW-nk25SxAIPnZVIqjJx1oHaRK-9NfiVIr
    lneTSEylMtSqTD3aw>
X-ME-Received: <xmr:cyIZaHLDbyNhP9Aqky2QkIRnzfnU32dykD3FQYM5tUo7WiqleKL0PNvnTVDLTN9GFuY1g17YWxmJEgEZLTuihbsQoB1n2OMG0G9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedvtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvg
    hjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhu
    shhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:cyIZaLEPKs4e5GVREIz-bDjKfyegFav4k78aqfFcc9Gep2pCugvNOQ>
    <xmx:cyIZaLV4ccMw-IM8Rfun1nO2NJ1T8MInLV0l_5Ma5ean9qItXTGdBg>
    <xmx:cyIZaGOfheeicDCaTWzslab8RzqCYbPvDJZA6H27kFSaZqebADEWYQ>
    <xmx:cyIZaK1g-dy9jmFMhRSAiU17mF9mZvxITU71bn6byYkonflWvim07w>
    <xmx:cyIZaOqL-TPDpgdXQJQWOo7UG0PXjOA-CeKsWfuVhOdu0BnVfVEAn1XX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 16:41:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Collin Funk <collin.funk1@gmail.com>,  git@vger.kernel.org,
  shejialuo@gmail.com,  sandals@crustytoothpaste.net,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v2] wrapper: NetBSD gives EFTYPE and FreeBSD gives
 EMFILE where POSIX uses ELOOP
In-Reply-To: <aBheGySF1FTsIVzx@pks.im> (Patrick Steinhardt's message of "Mon,
	5 May 2025 08:43:39 +0200")
References: <20250502233403.289761-1-collin.funk1@gmail.com>
	<20250503041718.42195-1-collin.funk1@gmail.com>
	<aBheGySF1FTsIVzx@pks.im>
Date: Mon, 05 May 2025 13:41:21 -0700
Message-ID: <xmqqo6w6okni.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> +#ifdef __NetBSD__
>> +#define SYMLINK_ERRNO EFTYPE
>> +#elif defined(__FreeBSD__)
>> +#define SYMLINK_ERRNO EMLINK
>> +#endif
>
> Nit, to make this a bit easier to read: our style guide says that nested
> preprocessor directives should be indented by one spaces. So this would
> become:
>
>     # ifdef __NetBSD__
>     #  define SYMLINK_ERRNO EFTYPE
>     # elif defined(__FreeBSD__)
>     #  define SYMLINK_ERRNO EMLINK
>     # endif
>
> Note that the `ifdef` itself would also be indented because we already
> have a surrounding `#ifdef O_NOFOLLOW`.

Hmph, it does look easier to read.  I think we used to have some
outlier files that indented CPP directives by prefixing spaces in
front of the whole line, but these days we standardized to express
the indentation by inserting spaces immediately after '#' that
always sit at the beginning of line, so what you showed here is a
good example to mimic.

Thanks.

>
>> +#if SYMLINK_ERRNO
>> +	if (ret < 0 && errno == SYMLINK_ERRNO) {
>> +		errno = ELOOP;
>> +		return -1;
>> +	}
>> +#undef SYMLINK_ERRNO
>> +#endif
>
> These three preprocessor defines should be indented, as well.
>
> Patrick
