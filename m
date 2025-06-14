Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FE9AD2D
	for <git@vger.kernel.org>; Sat, 14 Jun 2025 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749915649; cv=none; b=If/B+7xt1qb+X1XFysKofIVqTZsxYIhswkYduvuJ507eB3PupBlEb2NYHQtl5IknOFg0BROvz9x3VR5bK/YMWFKVQvRsUoB/9C9AsgkoZG2PiRkcKepRPM46+OnRucOBoZNdkc3btxyAEdbpFKZk1gPELBxL8MKWMChcVL+9fd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749915649; c=relaxed/simple;
	bh=EVp8KOyA1vuJ7zjP89Cig467lrADBZhPb6t1MKRXnXQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BbMpW4rH77fk2s8uFuG0shcZQ5spVErYUVb26Oj7kgIhmhdp93kFPulAf082bMl7BCFsySySZlhirliMWi3oWhKI+8QUDiij2nRgfVpU1h2q9bqes0WH5xrfL09ZBT8lBq2n3NF+Av8ad/wUQkqpVmvaDjMELYZrlqekiF2Woow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j4lbH+KX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ad5MDmHA; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j4lbH+KX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ad5MDmHA"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C60F5114012A;
	Sat, 14 Jun 2025 11:40:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 14 Jun 2025 11:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749915645;
	 x=1750002045; bh=+IPyr0hTgtcHrzQmzE9X/lrOKTvaX7+cFXydc4rZnsQ=; b=
	j4lbH+KXMNaOGHnFZ0qQ3ccS0GjVh/0Gnrbiw6JmmhYVMYgeJ0KVlFBL0N6ufCfJ
	olxVGoeyroGOquT60QSszEQi1Bxu8jakzyl79dX3xOCJXDrmenxdVWuzhv1S2kg1
	niTMD/ereHpYWcVgf1mPCNcGhYincZK/mY7Ab0urlkpOKyJu0tjKQWV4sCK1pwZ3
	2H+bwmk3RyXZNSy3n8pTd8Yi72FfmZ2U6WFdXpjVQgT5dJyuQyPGPoX8bTSNVopU
	CUFf3XJCr27vDlTeukfcS++QyoJYiWurJoLoiabYPKRCnDel0uGzKqBnyY5wC7bV
	QFQdD5R3XgOhY4KJw5k3UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749915645; x=
	1750002045; bh=+IPyr0hTgtcHrzQmzE9X/lrOKTvaX7+cFXydc4rZnsQ=; b=A
	d5MDmHAVKYzpev+/WEDr5w5Ju8A6gzfrlrktLzS/9KpVfSo/wLhofrkE8gHziuy6
	Te511ToiaxIfkNwerJB16oN5+/2/pWVQQt9l1MrfINyskxlTfAugztWez5DNs3CH
	3P7uKLpfypnYUjPFdeKqJURHJFowN29hgYeTHKXN+RBi7onPZRxra14g5lujs9qA
	ixPoHkyRc6uU6sjXtqIFTYUNeCv5f7f865smSIIjiqlLuOHfojfIcBJfhlFiL1cz
	A7QbHpx8XBcNVDao2EabZghTIE7BM/7JEhX1kv3porui0wIpj7tJEOD7qoAU1fXM
	cJPwsNzbbOPkNfPrOHRug==
X-ME-Sender: <xms:_ZdNaD5PDp_iTfp3GgXIOTt2bRZTVWTA7bf0fXUABthkYWex9yQX1A>
    <xme:_ZdNaI6NZ60fcjQouDXKCeXBrq-j_ddWSYjzkWHudOrhYfvaD02SN-L2uo2GR3atz
    JyCAXRJnNhund0lTA>
X-ME-Received: <xmr:_ZdNaKcxjXjW7CwAd4-XKWNnNLHw5pnEj9Rhhcvb0H0U3ieAbl2lwMRrcn53bvXTzpGLgTOOABVhjk_X5wjb6Uk6tZR8FWN6mBc1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvuddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephedtvddtvdegfe
    eftddtheeisehsmhgrihhlrdhnjhhurdgvughurdgtnhdprhgtphhtthhopehgihhtghhi
    thhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigghhuohdutddvfeesghhmrghilhdr
    tghomhdprhgtphhtthhopehguhhokeegieesphhurhguuhgvrdgvughupdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_ZdNaEKakQsaEO8hX8zH04v105mKoyk2FZRjwW6hElpVK4GxXtj3xQ>
    <xmx:_ZdNaHK-sWrU20y5_oRQJf_54Rexo-7imuPyyVaw3IvtiKpnxZOQ-A>
    <xmx:_ZdNaNwexwwB_8l1UCMM_64pL-8DRE4Nk0bZEBqVvSueWDz6OIjFTQ>
    <xmx:_ZdNaDJd7wPc_BqyKsZWIEwc350C7HgTX1Rrp45-rt7CdEtAbZ6CGw>
    <xmx:_ZdNaPRWncCXG_ws5I8EPhRxkCCm3dwlk1SzO9Hx8DgvVj0_Xk7GarwK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Jun 2025 11:40:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: lidongyan <502024330056@smail.nju.edu.cn>
Cc: Alex via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  Alex <alexguo1023@gmail.com>,  jinyaoguo <guo846@purdue.edu>
Subject: Re: [PATCH] Allocate msg only after fatal checks to avoid leaks
In-Reply-To: <3993AF96-E03D-46AB-B18E-8E6C1108EC45@smail.nju.edu.cn>
	(lidongyan's message of "Sat, 14 Jun 2025 16:26:09 +0800")
References: <pull.1998.git.git.1749843142000.gitgitgadget@gmail.com>
	<3993AF96-E03D-46AB-B18E-8E6C1108EC45@smail.nju.edu.cn>
Date: Sat, 14 Jun 2025 08:40:43 -0700
Message-ID: <xmqqcyb672mc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

lidongyan <502024330056@smail.nju.edu.cn> writes:

> Alex via GitGitGadget <gitgitgadget@gmail.com> writes：
>> 
>> From: jinyaoguo <guo846@purdue.edu>
>> 
>> In parse_reuse_arg, we previously called xmalloc and strbuf_init
>> before resolving the ref and reading the object, leading to a
>> leaked msg on die() paths. This change moves the allocation of
>
> A memory leak on the die() path shouldn't be considered a real leak,
> right? Since the OS will clean up all memory once the process
> terminates, explicitly freeing msg isn't necessary in this case.

It may not matter in practice, but I think the leak checking
machinery like sanitizers would still complain, so I view efforts on
plugging such leaks in the error code paths more about decluttering
the leak checker output to help us spot the real leaks.
