Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E7D266B72
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 23:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771025644; cv=none; b=n5FP30H0G10BLiroimmlbpkC4ms1rJI7qe42SlEbDJyjAgj6wIiC78vMp+zVxEnv36H9ogrP3XT1y295TmoH212+AdQ8Tx44bQWjklkOlTdC1AnL+GgIXF7NESDDl9y7Y4zYr1BgzYWo2gbU6LzqdBCRZiLxMKx/OSnhj4ZGGwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771025644; c=relaxed/simple;
	bh=qQxoFj4GlQjtunEld+agbRdr+uGovlR2Bw88HfcmjLo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TfBJNcaEqY+ux8DPGAqXgk949YHdYudqsMjQCcnlPufhYtYNCEUAaDHDlCCzF2Ku3B9lh5WiGiy5A7Skvn95e7EATDp9LImgNV+7XnpXS2POdDrBPnk3QICdefT5c3hcrT7DGSvPrT+z/0EpPNNi+4OrZZ+e6Ku3VV/IJM3OIVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SLydztL3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S4/lGx9d; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SLydztL3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S4/lGx9d"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9299E7A00C0;
	Fri, 13 Feb 2026 18:34:01 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 13 Feb 2026 18:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771025641; x=1771112041; bh=Tf7xCmBu3O
	jjeBtPucYWSu7ZZmA/9KEq2qolVnDV8VI=; b=SLydztL3qQSOHEoNU7m702ZfbE
	OLcs4ZVp5eGlbuuYQ7Zr/XYS7W/ATFhVDEzS4wEc0xrI18IlSVXK28JM9hSLG3Fi
	pX1my/RyHGRCFZW8IX0OLtyXZqtH65MHesSV9Tn0aMxo9P67JivW9xaCpeVGKHfD
	sqvF2vrFrTqkxsrzogvC6X93VIffed0iYE0M6tb4x0lPC0//5V/dJ7Km+Da/Kez6
	B1Y7Un84vdRVHXtJaTtrlEGFOl7QcWtyW11BTLtMOeh18JNKcfw2H/1dIEMFu2nY
	RJk96DywU+3XYZkIvCZPmEjNOxtdbyaw2aGJkFA0XTSjJ11sMjB/KUYUoc+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771025641; x=1771112041; bh=Tf7xCmBu3OjjeBtPucYWSu7ZZmA/9KEq2qo
	lVnDV8VI=; b=S4/lGx9d7BxIK7dX989RlczPVu/+k7TLRbQgUlLqJik6CmS5OTh
	g+b9pL1aUBwJGB0kRrMHHsu/GVBNMJHByv2uE/3WQAUK3zrW3zIZl9ukMmEycy0C
	e9evuduFIJ8uUwIxsTDb32liYvABuHQp2AuJnbriJIntvukXiBDuj99JlM5dv0yp
	imEt74BJOcE632RSOSqdYGgua0V44Sjywzrc4W0dfUkon+jgTpZa/M+eyAOws17U
	8KwrpqwZYuZVKmFkkHGJeYrMAA0rFz4qNuTzh/VnA76H1XYw+4fxa28kA3ve2BLt
	7x7voPnYjFLS7v9UoIq3iBTAnui/pDLZVkQ==
X-ME-Sender: <xms:6bSPaQB7XDLW9m7fE1IKQ6kflBnBg81wkS29ZswKrjOFe6MpYWLx4Q>
    <xme:6bSPaeXJE6lFBMAcF7XsUFwYg4_3rTRY2cXo1zyqbaH6YK12Vj17e6B6zGJF8RCqx
    7C_nIgxUX3EmjmPV8qFK_VQq9nDJVStNBhEgUhGZw0wzlOenGIvOos>
X-ME-Received: <xmr:6bSPae_tPULp594w4pxlZxS_VJoj5tiQI_IAgdXHSKQLgxYN7zYyuEKqEex33-FP0J1IpPANZ8Z8sMCdFWTmV4KhpS4VHEzruw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdelheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrsghrrghhrghmrgguvghkuhhnlhgvhedtsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhm
    rghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:6bSPaQRGJaV14FvhSqxog2y2ttFxlafFgGzmlkcB0PRcVWFIQPChjg>
    <xmx:6bSPaTT-ABgBf_QWSmUjOX9Nt3hcq2gYH3ci4e-Z5h50mQ_EIFfGjg>
    <xmx:6bSPac7Fvbc_Mzv3O89C7EdBp87HeIjGy_wrj3lDTfeJbbQ8TdeSsw>
    <xmx:6bSPaYVaBYPzHZ1FgHMy_HyndWxFgupTtZi3JL-_X7kzRxnyayYslw>
    <xmx:6bSPacw8SHGQneX0OKItl0Mjm58B8E3REVoNBL6RvjCvd10nKqMwwh8U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 18:34:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>,  Lucas Seiki Oshiro
 <lucasseikioshiro@gmail.com>,  Chandra Pratap
 <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v4 2/4] add-patch: modify patch_update_file() signature
In-Reply-To: <906f25e184d744f9d23681600a0d9e440b7f07df.1771015581.git.abrahamadekunle50@gmail.com>
	(Abraham Samuel Adekunle's message of "Fri, 13 Feb 2026 23:10:48
	+0100")
References: <cover.1771015581.git.abrahamadekunle50@gmail.com>
	<906f25e184d744f9d23681600a0d9e440b7f07df.1771015581.git.abrahamadekunle50@gmail.com>
Date: Fri, 13 Feb 2026 15:33:59 -0800
Message-ID: <xmqqms1ci5g8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:

> -static int patch_update_file(struct add_p_state *s,
> -			     struct file_diff *file_diff)
> +static ssize_t patch_update_file(struct add_p_state *s, size_t idx)

Why ssize_t?  Are we going to handle that many hunks that we do not
expect to fit in a platform natural "int" type?  If we are not doing
anything about "idx" being more than half the type, which apparently
is the case ...

>  {
>  	size_t hunk_index = 0;
>  	ssize_t i, undecided_previous, undecided_next, rendered_hunk_index = -1;
>  	struct hunk *hunk;
>  	char ch;
>  	struct child_process cp = CHILD_PROCESS_INIT;
> -	int colored = !!s->colored.len, quit = 0, use_pager = 0;
> +	int colored = !!s->colored.len, use_pager = 0;
>  	enum prompt_mode_type prompt_mode_type;
> +	struct file_diff *file_diff = s->file_diff + idx;
> +	ssize_t patch_update_resp = (ssize_t)idx;

... with the cast that is not checked here, wouldn't it make sense
to just use the platform natural "int" everywhere?  Your code is not
"safe" either way.  I do not think we expect to handle 2 billion
hunks, so even on 32-bit platforms, platform natural "int" should be
plenty.  Instead of religiously using size_t and ssize_t to count
things without extra care, I'd rather see us check the error
condition for real, if that is what we really care about (and that
can still be done while leaving the codebase cleaner by sticking to
the platform natural "int").

Enough ranting.  Anyway.

If we really are bothered that we cannot handle 3 billion hunks, we
could avoid losing half the number range by returning
s->file_diff.file_diff_nr (which is one more than there are elements
in s->file_diff[] array) or ((size_t)-1).  That would allow us to
return size_t from here.  I care about this a bit more than "why use
size_t when int is perfectly fine", because some platforms that are
not quite POSIX can have ssize_t that is not as wide as size_t.
