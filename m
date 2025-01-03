Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D58196
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 00:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735862724; cv=none; b=njhCy5i5hEQL/3f9Wb+J6Rs64+/gI8rdNYhFZldFRnTVSP3TXQtTZCvqmDwHrvoErpqMAU83twrbCWvvX9e80oiQNGVS2KfZC2mKeN3u7KFhaCNeqan+yFFHEq4GcuYzkTMEd58K7TA4Reui1HPNIQrIoq+pCtuJNR1hl86bze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735862724; c=relaxed/simple;
	bh=jAtaQfn4ELQvgenpDt9aXZ1Hkn/8U35XewGrVEzRWDY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fuEPJJ/srxuIEEL0KaWFRcJcGu9melI0uxXSjUZl9OD2CaR78Bkrs3J/8N5BSPVzHGU2AlYzX0jrn60tUfdGrH7gsgko59xAiXLy+yT+9tIoPPHmFSUyIn8+Sc7ezKf7IzzFhOy4LJndIlH8c36kIF6BIPgfVvUWNTk0696hxlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=6XoQoeWi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xxc4oY39; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="6XoQoeWi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xxc4oY39"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 974381140208;
	Thu,  2 Jan 2025 19:05:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 02 Jan 2025 19:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735862721; x=1735949121; bh=jAtaQfn4EL
	QvgenpDt9aXZ1Hkn/8U35XewGrVEzRWDY=; b=6XoQoeWi5C6rRoRn137/t0PWS0
	ivKm8R8x46EajNLafHNzmAm5v8CZN5Le2E1iP1GPG0RGolOEWfGnuwycQcC112E0
	D8C/CXvz9lDY4vqQZ/0Lr41U3dZToLh943Vv8tirzVYlt90MBsurfCSkXqXzv0uE
	+H3CbRJ3Q5cEBA2gqgvNu2KFHjlXYLbVtcOMtu/o8FI+9xVovWJd48/r65ayp9OG
	daesYaelafEJ7F1XZmmeCe3gzcMs+R6tfTgG3g7/aa7re91hPSYKhrX0p31me7qL
	llwUX81wC+MpazqTlFRjGLVV3NauuRt2ZkWmAwTuJsLwjpEThlda5RafLf4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735862721; x=1735949121; bh=jAtaQfn4ELQvgenpDt9aXZ1Hkn/8U35XewG
	rVEzRWDY=; b=xxc4oY39uoAf61a9EPu8cj4iUHW6DUFr2xzaAZaovmZz4HRjRc5
	+VG5cVsCGmaNGP1B6Fcf0DUbcGrQof0RokT0+e+2ksqLOb+BCjQqpStfYdWJEIhr
	x6nozoUggfP8XQF8qtyig7cHBEvMooVmbHTkg2PFWh1dZPEOPKIN5qP3ulG+hZhX
	gPcYW847kHo2DfqyCqS60BYaz8m8yBJxPf7rY97kV4fz9tiL0LJUmFgNTCtq3LuT
	ifvOdsF8KuYt1jfvqK0xMP358XMqNVGJtbJ1KD2xTCl8tApeD5ByLMdV5uM+OyT4
	t6iwRVprD4HfYtxgL8VuRTwzQ20KuIRybKA==
X-ME-Sender: <xms:wCl3Z96xYmgJCkshVMsX1LXdC6VEBca0TyAers0pexe2KBr3qsbvcQ>
    <xme:wCl3Z65LceLuuSK_XIKmaKA3p3o772bwWHkSiu4SpNn5VtpLEDiYkG3QhOkyEz5aZ
    B22Meb1401VfbBOWA>
X-ME-Received: <xmr:wCl3Z0flA9QbHAzirEUKj0FkNh7CFppOX4HGxwDBCsgTpiX2qSvYEt1j7vRacXQ0jTPJwuLSJiP6EDHBVnf9WO7I5TkfU1urRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeffedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeekveet
    veevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrhhnihgvuggvrhesghhmrghilhdrtg
    homhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopegrnhgu
    hidrkhhophhpvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:wCl3Z2LV_fkRjhUz8FriSlfyzwCS6m6j-7bkbQJzcaVmXm8BwrRDlA>
    <xmx:wCl3ZxKrZW2q7bcuMAfSG27cy-rQuJfkdzCZrwF0hRrwqMAGrROAzg>
    <xmx:wCl3Z_yeer1RyIlrFPAPoSB2u2eh1pphil7Az8icdERgdM9d2h7CBQ>
    <xmx:wCl3Z9Kq-WJRqRdpH5l4kP7uQaEMqhN9tllcYJq_x9ujXWX3rOHVxA>
    <xmx:wSl3Z59KeMpCDs_QXtrEp0AXQp3hLY1tlNN7g2rKS5IN5OGDsigtFNkQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jan 2025 19:05:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Jonathan Nieder
 <jrnieder@gmail.com>
Cc: Toon Claes <toon@iotcl.com>,  Andy Koppe <andy.koppe@gmail.com>
Subject: Re: [PATCH v2 11/12] t/Makefile: make "check-meson" work with Dash
In-Reply-To: <xmqqikqxussh.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	02 Jan 2025 07:41:50 -0800")
References: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
	<20241227-b4-pks-meson-docs-v2-11-f61e63edbfa1@pks.im>
	<Z3ayzUEfW1xd4Up0@google.com> <xmqqikqxussh.fsf@gitster.g>
Date: Thu, 02 Jan 2025 16:05:18 -0800
Message-ID: <xmqq1pxku5hd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Without this, I get the error described in
>> https://lore.kernel.org/git/CAHWeT-boK3x6mup11boEinNDQiAxxf0vwvZkxsGRc_GRvXYA8g@mail.gmail.com/
>> ('/bin/sh: 10: Syntax error: "(" unexpected'), and with this, the
>> build in the Debian buildd environment succeeds.
>>
>> Tested-by: Jonathan Nieder <jrnieder@gmail.com>
>>
>> Thanks for fixing it.
>
> Thanks.

Now the fix is in 'master'.

Thanks, all.
