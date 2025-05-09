Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292EEF507
	for <git@vger.kernel.org>; Fri,  9 May 2025 03:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746762191; cv=none; b=GiddffOtR9UFuBrHElqMmB/3FZZmjnOJVK6va8iYhphKH47ftcHFmmywm5gJ2F5RAxKbn5SOUv4Ga3EK/VdOVbNxLC3TKoCYoT7n0HN8elw2luEii9U4jA7Pe0oAkzIceOlPIpGYZ7mS/UVKOg81feEPrLXpkwgKwNN+XR/Zrn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746762191; c=relaxed/simple;
	bh=fiTsf7YCDE6OU4RyygOMurWTCxALJOIlMZMwb9riZb0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XnI955xpojQGLSSPe2EVGT0pzMWK5FT8pqVVA9BECs1nhHTY3GxWTZiauBQ5uvc2Tr/26gJwu82Quf6H+CeX0kCoDJNnEzO4mhcEsDcbfDxX6FAtVEyqi9a++5FSHfaQWoEYIk5pA75MWcdW9b9Fli6W2CGpMPIMQymSCuIfVbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kOltW+7Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ftgw2CS6; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kOltW+7Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ftgw2CS6"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D363013801A7;
	Thu,  8 May 2025 23:43:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 08 May 2025 23:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746762186;
	 x=1746848586; bh=oja3pvugdPG3yBBAIKw//fp5t5vjQsR0oDwv/bnmj1M=; b=
	kOltW+7Q0lPvF8Fizwaau0RhTfO8KqlJ0Ug2e80thiSVtO1AA4CPbruPh9RhbjAS
	KmJ1cAx1QPhLsOKrjVu/T0oQLbtsygkpbZlV1LXLZ/qn4Sz+pgZoCSBI40C6C/EM
	Ok8iQzKXLPYe/AXIGGLO6eyCp/7lMhCbjW+Mk+X5/FBLQTiG0MFv2OCnpQM41MUY
	6PMZ2Nowwo762eeGBqkPry8VOl6XM9NzGvvKZgmnvAbtagKU8vt+T+Re+smz1jKU
	iHr6NLBs1ROYz3WI4/9QgUtHJJEsr/au4KxyHUsHY8ViQ01vRvpVF13iNIywQlOX
	pToUI9SiYLSdmsAcGIiqgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746762186; x=
	1746848586; bh=oja3pvugdPG3yBBAIKw//fp5t5vjQsR0oDwv/bnmj1M=; b=f
	tgw2CS6hKnpI7R+R1HDhoLWpfJbU4PZnXeKIVdRJpj50X6XaQ6S3RGzPmaLrPA6y
	Rjd3162xwu0GnB1hpFEyXMF/kKXv+sG9rg+uk9Tnig/Gkh9f3bWTTNSt9KAJoXx+
	oCudJDTgaz4hn7zn3eHJRetCMiuE9nrJ8VJu7WFstwGjt7TPuWq6TrK9kvIri0LO
	2wO63teWeWFtQRZ5eWt1644RLmSiQ40c+ffgVYi4n3ox9WyNbzj9Der6Em8bs8oH
	osfkpxGDVV52sNT3cPBhZrgyI66WgunVzVVhvr9VFoKwR7RC1nfiDTZJbtEqWuF4
	CMIR6SO4HHu0OAYoqT9uw==
X-ME-Sender: <xms:yXkdaCi3nuURL4595Co5V-PDyV3yDq1Zkk4IzhYc5jIbS-w7hsvmUA>
    <xme:yXkdaDAI-C2cA5Ocz_7ydZKabCjDSF8tkIMox1kBaBYHq69h6BYWtZqicYKr5eBxq
    EvIQd1kltRF48zD7Q>
X-ME-Received: <xmr:yXkdaKH0lo2Dyn20u2khSwupsSS-uTD6FxlJIA7DhUFQHdTkDluISevHYhIHhydLAJh4vrcxHjl4OCiE1Tm2mSDLb-tGY-sOLFXb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleduheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrse
    ifvggsrdguvgdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    ephedtvddtvdegfeeftddtheeisehsmhgrihhlrdhnjhhurdgvughurdgtnhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:yXkdaLQ6XlDDk1OcJzp2Z9YOrm5EKGIItn8RQRojk3lw6CcHHYgLPA>
    <xmx:yXkdaPx6EFPqekZInTh2WP5aWc0ISH57PndoMQPakv0ockHBxj-LOQ>
    <xmx:yXkdaJ5huZVibmYXR4JlpfTxyJEC7YWKx1aJx00N6PsKtcqfIgCgEQ>
    <xmx:yXkdaMwV6MFwrDHPbSc84OkBYOrAWtQxTTZSTdmGd8G6n4h-ATEamQ>
    <xmx:ynkdaHE7Psqbi85BkinBk_Ky6yxVdCyq2yoE0VlAo-B8VMhuDXd2ILAV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 23:43:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH] REFTABLE_REALLOC_ARRAY: fix potential memory leak if
 realloc failed
In-Reply-To: <174cb568-e2bd-41e0-b090-eadd919d1ddd@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Thu, 8 May 2025 23:42:37 +0200")
References: <pull.1955.git.git.1746711583166.gitgitgadget@gmail.com>
	<174cb568-e2bd-41e0-b090-eadd919d1ddd@web.de>
Date: Thu, 08 May 2025 20:43:03 -0700
Message-ID: <xmqqzffm30vs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> Am 08.05.25 um 15:39 schrieb Lidong Yan via GitGitGadget:
>> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>> 
>> REFTABLE_REALLOC_ARRAY doesn't free origin pointer when reftable_realloc
>> failed. This leak can be fixed by add a free(x) before set x to NULL.
>
> Hmm, this macro is unused.  Perhaps remove it?

Or let the sleeping dog alone, perhaps?
