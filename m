Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D11376
	for <git@vger.kernel.org>; Fri,  2 May 2025 21:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746221251; cv=none; b=uUiMq+/uUuBU6uRdAFxlsykbXlWBtkc4JoWo5Bpy0d3gK/AYsuVLnVEcMjsKYeGcx6SbcKJjFJPHhCiZ/UmOiJECH02g6/E/8jhlHPJVsw8hLYlRGN/mf+kKhYDLzoocqBWBynj956yfLG1DpL+afKKterezeuJeqZErIxNlG00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746221251; c=relaxed/simple;
	bh=zmvAtc7xlNQH//comsIgKDgsemxtucHmvDKXeNim400=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GfgAUuNPkIVox+wqL9m04gC4/12MOp7/z/ZX7qt9hLLk5kOkI6LOKrX2R0OfxDc8v1zOdMwR/DXVaOXzZSAljKp4KywBxATe5uTb43SFjQ7cmK0z6QlDtdnwYeQ7HrNEJ1ZrlTrgC6IRnZfsmvkrzf6tRCjAFCk6H6u3BFQEt1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZV65iq6X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kSnEmtyP; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZV65iq6X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kSnEmtyP"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id C0F451380F97;
	Fri,  2 May 2025 17:27:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 02 May 2025 17:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746221248; x=1746307648; bh=7IKYl5dnWz
	BODBJz/eDmP2CVwVqOOgNU5GBwT4H9wcU=; b=ZV65iq6XRxwo70D5qa+gKrm21p
	h4Z37xQjlALBXGIGrYUchV9uIOTulbK/0elohETTh+XpHePItZ326GD7ntLaYU2m
	fRKhFMrozN6qtFlHILT/hVy8G41r9rxwt2NUJmitCKV54aRB1uwSAmj3U5JOzQ5J
	lyv464TGhJ1IvqbkIf4SKnwY3DmDvRnNhdmKGzeAlfBTGghCtyTt9MTMRcX/Hf2y
	Iu/ToxxWbplcr6aFZcePEe32nyniuSJr7ehisEMJN7L7BVSbygP4kzDWPtfU/x41
	vIxq4JKCsougAcblqUX4Ywt5Jd0E9VUCOijPcarAWjO4/xl561UdyBuKO+/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746221248; x=1746307648; bh=7IKYl5dnWzBODBJz/eDmP2CVwVqOOgNU5GB
	wT4H9wcU=; b=kSnEmtyPsFk+tJv0M8wU6kqwdzKp5l8JNKVD5+dVOx/MZCCIVi2
	qx4hR4FUyI5Xe3ded2yZyYqRKqo5WSx5v/jQP/eTjH6NH+lVy5tPMmwIwj85lAKH
	Xkhj0dLaUHfbwrXMm0WUNWyIIIWaxz/j7NFmHR9sgbaknOiz4htMaS9X7RKK4P/2
	fXLFtORRHNNVwuZ7lT9479hT+4yZ1YJeEJqLQQfsjbfq/yh76IqsdnVP8uA26eJa
	mgJvCqPAJKD8212XHdooLoOtixqQ96hqlvh6rbBiT8UrJlCgl321BTghJlccOXyj
	tsmy7GU6mPsrzA8KwdPBjhr82E0eRyY4f6Q==
X-ME-Sender: <xms:wDgVaPn10wMdbxZfcBBWhLq2zrspXF5fqKQEXWUOnuIDZNk0CX8Aog>
    <xme:wDgVaC2Nvwd5Ny_100hnTAFUeZ8qxGVi1hDxxqm52DsZPdMuKyZrTp9dxmZE5xb-q
    rATbHjwsEsyMh9_QQ>
X-ME-Received: <xmr:wDgVaFriQYiIZTxeZUxRE9WJfs4dxjsbUFzWrk9MQFr_l4jHODkhMTdL_ls-5sC187ZBwuJAULuAqGmLPJ3DQ5fmHMbXaP7lWhBa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeefhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguhhgrrheiudehleehsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepshhunh
    hshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehlrdhsrdhrseif
    vggsrdguvgdprhgtphhtthhopehrrgihkhgrrhdrrghthhesghhmrghilhdrtghomhdprh
    gtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wDgVaHmoRTHehekDwtFx3iHU7Mk-5k89LlKMJ8b0PlVkkuvJQrjLQw>
    <xmx:wDgVaN011QkUndxt4TQTXwGjDv62M65sPDX-cjCPoYVbGLECZjF6EA>
    <xmx:wDgVaGsZz4yLIDUMysnly_XVHQm4cQqxzVPG9NdFdi-pPOUlw7cxbw>
    <xmx:wDgVaBWGRbAput7KymG-rYYjnOtXDy77jAB-BG7vO1Sygekoqhip8g>
    <xmx:wDgVaA1R7aYsJjDQcdP9a5KCS8saPfDgrs0Me1csNKZVCACtoPIy9jhU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 17:27:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Moumita <dhar61595@gmail.com>,  "Johannes Sixt" <j6t@kdbg.org>,  "Eric
 Sunshine" <sunshine@sunshineco.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,
  "Atharva Raykar" <raykar.ath@gmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v4 1/1][GSOC] userdiff: extend Bash pattern to cover
 more shell function forms
In-Reply-To: <20250330134018.9662-2-dhar61595@gmail.com> (Moumita's message of
	"Sun, 30 Mar 2025 19:09:57 +0530")
References: <20250328200525.4437-1-dhar61595@gmail.com>
	<20250330134018.9662-1-dhar61595@gmail.com>
	<20250330134018.9662-2-dhar61595@gmail.com>
Date: Fri, 02 May 2025 14:27:26 -0700
Message-ID: <xmqq4iy2u2ip.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Moumita <dhar61595@gmail.com> writes:

> From: Moumita Dhar <dhar61595@gmail.com>
>
> The previous function regex required explicit matching of function
> bodies using `{`, `(`, `((`, or `[[`, which caused several issues:
>
> - It failed to capture valid functions where `{` was on the next line
>   due to line continuation (`\`).
> - It did not recognize functions with single  command body, such as
>   `x () echo hello`.
>
> Replacing the function body matching logic with `.*$`, ensures
> that everything on the function definition line is captured,
> aligning with other userdiff drivers and improving hunk headers in
> `git diff`.
>
> Additionally, the word regex is refined to better recognize shell
> syntax, including additional parameter expansion operators and
> command-line options, improving syntax-aware diffs.
>
> Signed-off-by: Moumita Dhar <dhar61595@gmail.com>
> ---

This iteration hasn't seen any reviews or responses.  Is everybody
who participated in reviews in the previous rounds happy with it?

Thanks.
