Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2C21A38F9
	for <git@vger.kernel.org>; Mon, 19 May 2025 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747670349; cv=none; b=XgCxyJjq7xKHNxvQ4LWuicrNAUcPCSbvvJCn+njZHJx0HqfEdRqrJALouLyrORl3yTSnLMKe+Z6piMrBzFo1Llwt4kxZKRVS/mevcXYW2v3Gq4+IkTs8iNK2i2id8ArgRdINJ4AcrBrmObwLM920LYbPvgxOw0EmngCXtHfIM/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747670349; c=relaxed/simple;
	bh=95ti1H5GC0R6bK/uhdW0gsfHxQzvxV8PHutGjekbr0M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bZcniVmiiatcYrZU2sxkAkgc7hKv9nCkfX7h0166jHrUKRk+eBDq9IAD4N7XFsF4GxrZ3ntbDiXgjSaYD+qx2hCTmpW5q+W4Y1NnafpM33Ez6sYbTPAxhXrGpW6cn0ZobKOMNxcd/iElEX8YYMZxW58Dub+pJhzdXWWj8mQzxUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q2QOtwbM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DjqItBLW; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q2QOtwbM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DjqItBLW"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 9EEEC1140147;
	Mon, 19 May 2025 11:59:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 19 May 2025 11:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747670345; x=1747756745; bh=mWWG2mu8J/
	8JzaOm0XU41whRwnc4+6lewqDtiX1KOGY=; b=Q2QOtwbMcNv+h2W0DMAN39Ar/7
	cywOsR6+/CJeukewiAeRfuoQKj0vkaS4ShrKFbyL7LqdUS0drWo9vIIARvUs8JnY
	2x9zoz9H4ZnU/1hveXrElNUHL45GC6iQ09vJGuXDbkotLvVpGZnkcy6CNE0DHn5s
	WSufRI5HgVDOs2t7TtQHE1gx2ehW59zIL9mqxPf+WYApCDAw8JxxDdjJHq1iVxLX
	xgb+39yJ/iA0UhD2Ba6x1k1iibNGvqJ02Kl5Xd5rFJQYIFde+/MyTuBeRKIBZer0
	7922u7XgkPYU9GO/Bzao+qks+jyHJ7LZ/jeHSlmJs0HlFAaTITgj+OBOyQ5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747670345; x=1747756745; bh=mWWG2mu8J/8JzaOm0XU41whRwnc4+6lewqD
	tiX1KOGY=; b=DjqItBLWyfkS9CM0+jrfEg2zQP0DoT61/Pao88edCzMzT3S5PLb
	e4xGr7EN4u5qtGMORbgnfEMOmuvYEqBZSYbqePYFQh5GXgK1q2m4FKSTR8+dnF5/
	5H3Ab9GENV3OghpT/E91WYLkyy+eijXbphBBwnVSnwOlP9b3u2nflB5Ty1wKeJjl
	yGd7USv/pORw/f5eelkeQGPYAHdkQfrLHpEmL5wjpkw6KuFNtjQ7NBkEwvmfodci
	7LbQFy0HBDdqolZ03ZdxdPnIt2rSalBCDkq1Exeiz8ftx6nSANOngQexut+3iXoi
	pvHIzcRugFZhq66lD52B8b7K+OZdoNBMmTQ==
X-ME-Sender: <xms:SVUraN2XiZIJQk5XMwA_j8PgGiLWWI7sfu-v6Vm1IZwUOtidVoi5pQ>
    <xme:SVUraEFTuPBWK8jC9rJW3btcv8-jCF0aXd6dfAYASl_e_svTO9kjtxoR2MqQJyJ0-
    xlMCUXghnQsZ4D7Jg>
X-ME-Received: <xmr:SVUraN4wlC7BTrKHhRYGgvjR82nE_oGMUUOde_mvonnIyTA0gK2o2oD0YwfU7gPFHnTTTbZytLCu2tpjQC6_ivie6yOT52vmu-ebk6k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddukedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:SVUraK2ui86WVeZQ_ep_gU_FpYdUFYHFqkh3bI-f-_APhQPSeg1xiQ>
    <xmx:SVUraAGSKLore2yTTy5IzaaQ5HkHmJeI9BSclFZXTIwr9dSFxYo7Qg>
    <xmx:SVUraL-sRa7h5pCsfAdANV2O-XrBtT37NhWVM6FdQCewfKWjv3gVxA>
    <xmx:SVUraNm4jyEJsXhOgVPi-jDIpHgw3Lto-VANGvIPOvBoPTeBK_JzSA>
    <xmx:SVUraARo2LS3v6Y3-hp6IN_sYEYKmSORFRPDECTZjtD7B3tppIGrZTfJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 11:59:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4 0/2] merge-tree: add new --quiet option
In-Reply-To: <74bc8741-0a52-45d7-be2f-cc10b641c704@gmail.com> (Phillip Wood's
	message of "Mon, 19 May 2025 10:05:09 +0100")
References: <pull.1920.v3.git.1747182287.gitgitgadget@gmail.com>
	<pull.1920.v4.git.1747425858.gitgitgadget@gmail.com>
	<74bc8741-0a52-45d7-be2f-cc10b641c704@gmail.com>
Date: Mon, 19 May 2025 08:59:03 -0700
Message-ID: <xmqqecwkoam0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Elijah
>
> On 16/05/2025 21:04, Elijah Newren via GitGitGadget wrote:
>> Changes since v3:
>>   * Renamed --dry-run -> --quiet . Any further naming suggestions?
>
> Thanks for re-rolling this version looks good to me.
>
> Thanks
>
> Phillip

Thanks, all.  Let's mark it for 'next' and merge it down.
