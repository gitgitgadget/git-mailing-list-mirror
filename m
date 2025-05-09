Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973B92110
	for <git@vger.kernel.org>; Fri,  9 May 2025 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746800763; cv=none; b=u+QuNEhPqDljLc8ONefPmmSkqZL3bbGOwtdachy86oc3HfyM7LHCkLhpvNCMnvpAoNhQfeMEIcqMojDwtkzcDrPL/f5v1WRBCAiDsxXhsYOdqcNi87/HZpuap12rDfLeWpoTrGLA3sC7SbJs9WfkYwJ/lyYxpg5BjAocvfVpFlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746800763; c=relaxed/simple;
	bh=ZHLtxYLI8JEElJyk9AkLLz9C+agq3xVFenF29LJZtrY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XnlPPbGcWMhRq3hi13e95Z8qAngk+XzgMbThCKwTfdhOYPg8QxuyIuEixKYRcPpZiaxL3UDFQnrCloqo/+frLFbQlLj1sgA57fL/mJgWl3jjIaqM2PrSmzy+0QzLMye4GmYOOSnylOD2iUoNu2cZEgg3KaUjogbek7ki4nBFkMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hZbznMN5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v1Wf4CYa; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hZbznMN5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v1Wf4CYa"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 77B2213802F0;
	Fri,  9 May 2025 10:25:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 09 May 2025 10:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746800759; x=1746887159; bh=ZqFiEuYkM8
	/bPNIMP0s9eXm1KhiOASgWyRD3yLqTc2o=; b=hZbznMN5VaJRrK2lKfLq4GbjcX
	BTQSswQD7Gi+greUMjS2beb3K1yUdujJFjhpOe0Ej/8I+KyCkNQ+5Eo3gg4tuP+y
	mLOoF36p2bVLCAzm1qRKsq8Hd6mMip8mqWF9daWWaIqX0rFHf3QOyCSsO9YsaGAP
	FPVb3H7JpzhKhPt08G91LzphRf8i6suWaVNy7a58oByuDIJVnYXTJxom+865Bwa3
	J/9KXAeypZEyw7hJgq9JhlaPoTVuYNgiH6xkp+quMzApEMYJQ4n0bJ9ATgo/vu4G
	ijnDgqeE2lBbY9alFqV4v6hva1noxPovuYe9YavHgqoq6ouaSqcKuhJhU/Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746800759; x=1746887159; bh=ZqFiEuYkM8/bPNIMP0s9eXm1KhiOASgWyRD
	3yLqTc2o=; b=v1Wf4CYaphZBVR5mJu8JwTOa0PEqfEm21seJG3RBLTYRQgu+rUP
	8CnIslxHlS+CHJCk0CG6/uQrtmGCOioY9lZ5b5yffp/wvNyt6sKIhU3RZZJCLp1O
	SsbpSUU3AqC3fwYpWryKefRZMSmTT3SEv88SGid8+7pN2lm1ZBTkUATwjJr9SbOe
	xdJxEzB330HNJB45F4rsswtOcCrddZC0djyRSzgBTzJwi/HAuK4o5hYu2OZEByBS
	X/3O4/iYJ7DEFUahNIDf3dGbrb9NX1E8Z14eEJ6uHOgpaUU+ZLOgCgrV1P161/L1
	2icMxkrkLvhAWAMW8c4y4Co/yqhXb3iOOxw==
X-ME-Sender: <xms:dhAeaDh1ka9_q07v4U-uR6C_lDMf_Utu0CKU2UAciDVow3D94TB5Rw>
    <xme:dhAeaABV1VfgrGRY2M8B2BvYJHabpnDVfeHvVdUe2i3LDkCtijvaujQG_s0uEN7Du
    vjasba2xuMK_3TFyQ>
X-ME-Received: <xmr:dhAeaDGJk2MJ9_A7LHVslYw0_ZavZzfs6mSDMW7UsNwI5E4oTLAzJxFsH4-BNIp304J2C2nZAi7Qv-uHUyfKbW7vZJCcvyw83mO4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhdrsh
    drrhesfigvsgdruggvpdhrtghpthhtohephedtvddtvdegfeeftddtheeisehsmhgrihhl
    rdhnjhhurdgvughurdgtnhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:dhAeaATcIi-BP0UKnaMHZldlmMV4ouh9EQwsbQ14bdDca43v1qOolg>
    <xmx:dhAeaAwKd-vykReKu5U9mDTCfnYG7qkVgC2DcHUoue9zsITV6tg-EQ>
    <xmx:dhAeaG6rrGByt80LbJTl9dozjyWpBXntw-RJw6TOYQzPgbxWnRuK2A>
    <xmx:dhAeaFxjjytIXbxlKshNNM3Ci6Ml5aNxDlDZZzV9nlFuBSd80aJyjA>
    <xmx:dxAeaGQMfJrJ_G8fWikiQgWmm71egenuIA1AAfUvs0ZZTSKrs4QQv2_B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 10:25:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Lidong Yan
 <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v3] REFTABLE_REALLOC_ARRAY: remove this unsafe yet
 unused macro
In-Reply-To: <aB27k8DI3BNgiwS-@pks.im> (Patrick Steinhardt's message of "Fri,
	9 May 2025 10:23:47 +0200")
References: <pull.1955.v2.git.git.1746756263207.gitgitgadget@gmail.com>
	<pull.1955.v3.git.git.1746776686718.gitgitgadget@gmail.com>
	<aB27k8DI3BNgiwS-@pks.im>
Date: Fri, 09 May 2025 07:25:56 -0700
Message-ID: <xmqqv7q93lor.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, May 09, 2025 at 07:44:46AM +0000, Lidong Yan via GitGitGadget wrote:
>> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>> 
>> REFTABLE_REALLOC_ARRAY will cause memory leak if realloc failed.
>> Since it is unused, remove this unsafe macro.
>
> This looks good to me, thanks!

Alright.  As long as we do not foresee adding a new caller of this
in the near future, removal is always preferred ;-)

Thanks.
