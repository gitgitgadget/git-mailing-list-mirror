Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCEA22156C
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 21:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752010281; cv=none; b=uI0N5DW1VixiWJr3sifVZrnBTeFGIWtdq3ZS5lEB8EhLwekNa7gzO/sL9eunjSB5i9IMGJ+6GRPraASt3q8o2TlyErZvPV8klc0lBUB/AB7ajm4ovQIzygNu/Ioiz32TH+N7D+f3MzQx4EcAQO3xRIpNqnf+qRd9tEt3aS74Kxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752010281; c=relaxed/simple;
	bh=66XROOMhm5SEi2Am1jmTdkIWVDrc7s2X8XR5edAY4vg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PQL8Fhy1aQrRDcdEJVt6SLAI98H76dHqBm7NFSI8lu+qIiTuVVpqppqwcYzJGDBOQBy2wm7pahcnGtr5TQ3s2tJbLn+5KkwUZYqmYNz5d1rPQHyX+URk0ipW9V0tqgWx1EfsNwaTW6DJKYqDqqnHmFvu4mI2qt9AGnx0l38ONZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XjCgzD8N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ctWIO5bL; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XjCgzD8N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ctWIO5bL"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 37CA01400382;
	Tue,  8 Jul 2025 17:31:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 08 Jul 2025 17:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752010278; x=1752096678; bh=l/hcADAUa7
	DpywgI0I1jEWgQw8NJgwQN3WCHTW5p0Zs=; b=XjCgzD8NuLthlUFvISGa9WulaK
	M4dhQuiS7dxcLwSFQK9sSHu/IuF01vuVivsTL9KayNYqlK7h7qVZiqmCmiHP4eRa
	s5yo/nnax0MMSdjzQ1uCmhw+M8cYFahp+6o6/5JvZ5riQ0IdlnIP6BuKr/a8QhZ/
	OVb8hkZBYBpj0Mq4HmdUGs1oVYrKzSSJnZrz70bxE+7Um9pn6AkkBK6Y39K6GSRV
	wzv9zT6aExleQg40Rdhn/jG68a8a4bw46MZjQNnXmlg7K9eAc9QhpNB4/DZoM/8c
	Y252C1U8mO8W3wOUAXcKxiLxBup7J+LzNXvpzbfE4TPkPimq4F8qovmgiP7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752010278; x=1752096678; bh=l/hcADAUa7DpywgI0I1jEWgQw8NJgwQN3WC
	HTW5p0Zs=; b=ctWIO5bL7UdBZjTlcdtJK2C8UfLobcX0hFGRAgYJeznqA94UNdy
	+9WozhDDIxdcdtuEJRPungAmtWFJInjIHSre1Xbfpxnoz1+l0T4xDN/qwyHiLi1B
	oFQnwWFxoHkgvqAxRf6kxFYSZlr02N/jjqAuit3ekmoq/r8rTeFUpBlqmFYEokO7
	wtN5NQQH1q3ucU58B8GPav24nWSbqqbWZFWIGxQarlrR78BmBbptDErMwR1uwvgJ
	OHfrnce4r0C9f6bu6DdDOamklHaychKOGg5BpmT7aFtSQ0UeixjkLfS2i6f6mEjc
	/KIn0p1iEmCWRiNNT/WY15Pn2dBCuWMLJsA==
X-ME-Sender: <xms:Jo5taJIAd-exy27LWzjkTc_1G_2xdNsq8mIA_2qCudPyNOls5Zd0nw>
    <xme:Jo5taIZyRM9i7tGIOEkUgTjIT44EE6v7oxX_y2MqSJSxXbA34vkcC0G2CJNTHeYSa
    1Z_wB49suiL_tYU4A>
X-ME-Received: <xmr:Jo5taLKqW28C2zjW9Ytw9K_YEJ5Hraopwf_2zhLpZeEbIr-JdU6l7W3LogrVqTtFuEKsTLqID8L6u3yZb97xeaV8VRJv2afYzmr0fHE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefheejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhrihhnthhf
    uggvsghughhgihhnghesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:Jo5taGAV3eec4IeGoFuykdeOU5UffyywO7FGLey_3c1Htolz_uCaFA>
    <xmx:Jo5taArbZ1lGJOOYi047uKqYiXB7xPJKzCzESsaTUF7KM0cAfudECA>
    <xmx:Jo5taBhJDmfRUwErzq_R8b1BgqwBGk0Ghbcp_UAPthy1-ciGifvwvg>
    <xmx:Jo5taNBvD0zUs6ocV4pursLGJRKzV8_T7RyW2C44K9RnUxkmShMuuw>
    <xmx:Jo5taJAKyaTsZ1Zgd4y4ojrUcAx_LSoJ2HjGnhUuADL_BbnCFjRidiBa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 17:31:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Sahil Gautam <printfdebugging@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: locally storing issues/comments/projects
In-Reply-To: <3e964e0d-bb90-4074-a9ae-a10fb02b3f50@gmail.com> (Sahil Gautam's
	message of "Tue, 8 Jul 2025 16:22:23 +0530")
References: <3e964e0d-bb90-4074-a9ae-a10fb02b3f50@gmail.com>
Date: Tue, 08 Jul 2025 14:31:16 -0700
Message-ID: <xmqq4ivmtlnf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sahil Gautam <printfdebugging@gmail.com> writes:

> thought what if git supports it inherently, so i write this mail :)

As far as I know, no.

Your worry about these hosting providers taking the non-commit
project metainformation, like reviews and issues, hostage to prevent
their users from defecting may be real.  It would be very nice if
these hosting providers can agree to make project metainformations
interchangeable in an open way.  It would allow not just migration
between hosing providers, but may even allow federated operation to
be implemented.  You push your work to one site, somebody on another
site comment on your commits elsewhere, etc.

