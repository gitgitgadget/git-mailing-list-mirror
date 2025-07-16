Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCC02EF646
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679799; cv=none; b=c9ttJdJOGODDiJ8AFtH/4W/CjEJvysBTmlBKHdmVO2Bn5+XXHymqbYY1kPjTmuzjfbZjFwzAeokblLam6AA4WDMdw81okTT4IdcPMy0vOu5ZWFtlPBBPhgCH7OEFrNfffuzgX2DxblGyuhGZRKeDmma/5eOI5QAu0d+yYEn+ViY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679799; c=relaxed/simple;
	bh=x55SF5JJ5N+FsUghvQVJyyAYWRly+W6jUcNAUjym1c0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dKh8DNLKhrFqM4VcSxEHqouuJlp2MUJACIKcQnMepIoprca21L5oA40zpXG0m2iw8bc4axLZOtRUWzHRyOBRUng8Vvm+2EAYvtOqA2enzfR8QrYfTnhcZD6606lh7/uQDXI/aTIIkyosmXlGTSmGDcrjFlV4u0mXJA5qlrjjWZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Mr93cPgi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nhw6FpWA; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mr93cPgi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nhw6FpWA"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D1BEF1D000FE;
	Wed, 16 Jul 2025 11:29:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 16 Jul 2025 11:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752679796; x=1752766196; bh=vipzCeO7lA
	nMmSyts/wTgI+waUHq0MGAQufzuxb15n4=; b=Mr93cPgiK9aONHN+RlQL/aUk2x
	NJ7UK9ix5edCxRndUtdVYma6YrHluHUaN/J9lpDXtSpLXM+T1KIkduI3OwUlGB2B
	ImS0gixFrq8XKL2vmmfMgp+wo6ejGVpRqL8rrREaDFpQA6WXq6vaoiCxDv39iQ0r
	VsBsJSDcBZvRun0ZXrmRdSnEXGuE682+k1j7X35BQC72+AKWv2eDSjwfj073F6T+
	SOeXquluTuHr8H2D7HWlc5v4r1yLjpZ47rGcVehlbF1XfTI6+5bvBflf03CfTlQp
	3oUAzxgE5WKqF7erFkEayl5p1oMy5Mcvg5sJY9l/mRhj9p5uuikFCxMK41aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752679796; x=1752766196; bh=vipzCeO7lAnMmSyts/wTgI+waUHq0MGAQuf
	zuxb15n4=; b=Nhw6FpWA5DqHP5c1SEYDN0DZHs7uxtzL7DSErm5r203RzoUFIdN
	Oh2XzBwS+tNaxYATAUSq0R+x8l84sgP0DfuN9TlNDGC3qna9YpoCeSXl7S3CO2j8
	bH9ApAjV/Gre9yVWOjMzRoXSjk0su0Ux4odPaM1PZUe3zgRPuVMIHoYTfGWTFpns
	C19uXeB3L9X7Lx8/QHgamo1nMeQPxzGJKIYMyBNs0hSwtB8qkKUemMBzVqBweTV1
	otDA/P5Sbsx2qbdkwczSJ8tldNQZfPN51cl1inACmz7EhnI+Nd8iF8ArBlMMjv0s
	OcsdBBqz5lXkRfg60XHf08r2d9c7W9d4rnw==
X-ME-Sender: <xms:dMV3aMARo_uGZOS-FX7Iv0NRh8CDyi0m2txLtVMvaj3K54tILJRBgw>
    <xme:dMV3aMHqpG5fonDi1cqINilBKUG7bJVHdjyvMSkrOcOvPfQ2-f49otb874MyHNWoG
    52-hpbakZ-F80XXaQ>
X-ME-Received: <xmr:dMV3aGDIvJ3vBE6ihcLB5VN_ZgYDDPG-xvTLb44ea-4uWw3dEYuee8_Zb9fxSEKxUAPxqhont0UhBWISvDFovULzuke4chw-BWAJzW4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdp
    rhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhh
    higrmhhthhgrkhhkrghrtddtudesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dMV3aEVlnAU0aVLodn5-J4rEGVoN7VpfwugkkfcptPy-qmqPa3lyZQ>
    <xmx:dMV3aCp8fGqjrB7lPG6N77mJUyoLa_KZt2yFEyEUiGZYCg2D5TNyxw>
    <xmx:dMV3aIT1IIXXQEwdzZd2t7WBVh3sRcXPLPzaRxFHMsc_9SiYOBgPYA>
    <xmx:dMV3aE0ctqf0c-F0RVy1UAS61S5HxpAE0BWcaK-4yqadRR1ewLrtgg>
    <xmx:dMV3aOzhTSGoTtyZT7mswZR4ScwntrJq-4cr-ESom3RJck5LTQm5oR1T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 11:29:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>,  christian.couder@gmail.com,
  git@vger.kernel.org,  shyamthakkar001@gmail.com,
  kristofferhaugsbakk@fastmail.com
Subject: Re: [GSOC PATCH v5 0/2] commit: improve behaviour of
 core.commentChar=auto for comments in commit messages
In-Reply-To: <51e75a0f-fc6c-452c-b1c3-2836d1508308@gmail.com> (Phillip Wood's
	message of "Wed, 16 Jul 2025 15:28:00 +0100")
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
	<cover.1752665506.git.ayu.chandekar@gmail.com>
	<51e75a0f-fc6c-452c-b1c3-2836d1508308@gmail.com>
Date: Wed, 16 Jul 2025 08:29:55 -0700
Message-ID: <xmqqo6tkcfws.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> This version looks good to me, thanks for working on it.
>
> Junio - shall I rebase 'pw/3.0-commentchar-auto-deprecation' on top of
> this when I re-roll to avoid conflicts?

Sounds sensible.  I can drop my merge-fix then.

Thanks.
