Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7624A28E617
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513893; cv=none; b=h/NhYjtRgIJHDcTzEjmGcSXkeOOS/RZ02Ckv5Uo24TQlE4OOu6Ey89WRP025dMjD5tI9fV0qyqyGppGfgZmxXJ2lCVfrQ3BeMSwBaEJuc9divnR09wTNqBRONrk+Mu4+jMYJqTCcjx+Lz7/r7ucPiU/h9iQhc6/fZzoo49vMl/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513893; c=relaxed/simple;
	bh=z9lBQkbNrbfmcNon1ji1EF8yS/v0z6CtvrddG37zFRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PuHq4HzCQmBHdTogliOLtBxK27jnhikUeWIy0Wm8PaVu1pj4I0yHI7eHSC58CIQpVTMP5dVy3r550cLrXAq3BR9EGNYGg7L0sLrtJ64oiG51NbYiC4ECtZW6zg/p799o0yCifTBdKMIoxCH0Zb5y5KkN789QVDRlPz85meBYiAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TAdBnNrF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hG9svIS0; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TAdBnNrF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hG9svIS0"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 31BAB1140204;
	Thu, 24 Apr 2025 12:58:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 24 Apr 2025 12:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745513889; x=1745600289; bh=z9lBQkbNrb
	fmcNon1ji1EF8yS/v0z6CtvrddG37zFRs=; b=TAdBnNrFTLRERNQAoHC2IRLCW7
	KO5VPV30lTjW6Q7wtGxiw6sHRh9Ip13VzZVzL0WjThJ1G3jZkgaIjBnisSf0Xn9q
	nDC9OgZ2JfYVM94BXF7wOeS3jeni7DB/Xvb/AquiAopsQ4/n8DcIlPxwzJCptGyZ
	vk2Z41rDspJojeli6lzZ6BvKXprTLovAB2MFu2iJXkjL9nhPKbZo3RS/2QGF25CT
	bV7+fMjm/BLBDDqQ9wC90nE5jkYFLuuQl59PirU8vBS4UV18V31iex0BQ2fsIvdn
	E89eekA9VkpSXgbJDSU0EKshLvP6PNWMN4Im/VdpqFgraddj0zYiAzmDTb8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745513889; x=1745600289; bh=z9lBQkbNrbfmcNon1ji1EF8yS/v0z6Ctvrd
	dG37zFRs=; b=hG9svIS0XKtibAPL3a0zZQ4qlQyKO76nmYMhdwLCj1S9EJljykE
	wU+L6MRHqMEC0HCUI8lCt1lg22sk8NqRVHr64nLoJ+fXOW7kS5qTUjNSwLFjjVgz
	UzWBnwANn1G1eNkhCgnx1pPN99gwNRKcZvBCWZ90OADdd88SfiFJt5dUo8o1HRug
	g2gFYKgtczRnICxUEhIZfxK23ksQ7VXO9lcyUmG+sRm/yPyfuT92jFhcW2BcAxZ2
	r11lokNjgCuF4mJsGyz16/GZNcOj6d6HjlbaXcmwYWzXd1QssOI+U1IKGJCqu6cg
	fxbRVuA+4mHHojqxtbM3EKZ16SgoDwIkTzQ==
X-ME-Sender: <xms:oG0KaNLxGyntjtOit0yQLOChOlcfh6vIamZm4k6lFtuZEUk42rl6ow>
    <xme:oG0KaJK-tu3DDAhWv-3bekPndd-pjDOxUDsU-jcnzROib2EjmeR7HR9FEexMAzBTd
    OOLPqfUN-t-Cqzk-A>
X-ME-Received: <xmr:oG0KaFuo_qfgrc4Vghg0E58kbGRyZhflNHC5b4bCTfIFSeb6HBp4L3Yx77qZppXP0dwRfVEsSN8UpNiqG7VkwZ4jLxacbWqIBJcS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedttdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguih
    hthigrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehjuhhlihgrnhesshifrghgvghm
    rghkvghrshdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpd
    hrtghpthhtohepfihirghgnhdvfeefsehouhhtlhhoohhkrdgtohhmpdhrtghpthhtohep
    ghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepvg
    hhuhgvlhhssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:oG0KaObcdrUF_ZG9j81zt3D1OPEvrXFM7-F4r0LYRS4P4ZL61iml6w>
    <xmx:oG0KaEZ2XmJmGpK_A2cU720BB3RIFAekhyzBH7KDTPj6LXEHtCRNvA>
    <xmx:oG0KaCDc6f2d0VxQgRqRzcRg9-GsqoWcALUNPhLJRVCLqJk4SyfrMw>
    <xmx:oG0KaCYLdVhOv3DHh5pvQ-0ks_Z2NvNupOpShVelGqud_P-bX0_Pww>
    <xmx:oW0KaOLZthrrbfOiIag1ZxEhlYUz9V48K4n8kvf3-muSrjXbz5VLbYHf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 12:58:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Julian Swagemakers <julian@swagemakers.org>,  git@vger.kernel.org,  M
 Hickford <mirth.hickford@gmail.com>,  sandals@crustytoothpaste.net,
  Shengyu Qu <wiagn233@outlook.com>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Erik Huelsmann <ehuels@gmail.com>
Subject: Re: [PATCH v5 3/3] send-email: add option to generate passswords
 like OAuth2 tokens
In-Reply-To: <PN3PR01MB95977780560CD8AE138ED644B8852@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Thu, 24 Apr 2025 21:16:37 +0530")
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN0PR01MB95884F106749628745FDFBB7B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
	<PN0PR01MB958856EC9FB1E4F73A738746B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
	<D9EVAF38Q1KJ.24J34ET29VPTI@swagemakers.org>
	<PN3PR01MB9597932FB4B19DE2038AA26EB8852@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqjz79vb6e.fsf@gitster.g>
	<PN3PR01MB95977780560CD8AE138ED644B8852@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 24 Apr 2025 09:58:06 -0700
Message-ID: <xmqqbjslv6n5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> TL;DR: I should have looked at the docs of credentials as well. I kept stuck
> on docs on send-mail.

Meaning the documentation on send-email is lacking, which is a good
conclusion to draw from this episode, and have somebody (it does not
have to be you) to look into.

> My suggestion: Maybe add a small link to relevant docs in other docs as well.
> Eg, in the description of SmtpPass, you can add a suggestion to use [credentials]
> if you want to generate a token or something and link its doc.

Yes, wonderful.

Thanks for your suggestion.
