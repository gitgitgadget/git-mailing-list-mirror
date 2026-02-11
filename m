Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203EF30F7EA
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770824601; cv=none; b=fIEhjwl/gE7oS1W4kZPh1pPZfjkbd86pisyqzgzUPCiX24yJoNCaEGrmc2pJYcfDoWJaGPbXASgsZLJveDSjl7icDtLC1zRCQrF6YUjaCwVD/0GWBXQc5UgbXioVOi3dKInLZryFem563TOPcWvFiMrtyC7q+ZBE0blqWDPt86o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770824601; c=relaxed/simple;
	bh=qmFhC0rkWlChhGgZvP5JgGKP7CV8B6Vkveeq0FccU+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lj8cu5S184KJa6C7QKV1qd6a3vU6C2+acK0VtrXPmBB7S4VmHRZtj/wqIjLmcHz0AR+g2f0STJx7opTBplU39AAIWruJCB+WLaZBJHC1tIJ4o1jDdyw5JFipxXZWVM9kXKJj48zUMdsN5w9DCGOyzGOcvpH7n9Y6hBT8R59fz5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uA+dYQPJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=veJUJ9Md; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uA+dYQPJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="veJUJ9Md"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 66A0FEC0261;
	Wed, 11 Feb 2026 10:43:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 11 Feb 2026 10:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770824599;
	 x=1770910999; bh=MvPV6QRTXsLvVbpVChY/XXHI0WkuUEaATj2pTBSU9Dk=; b=
	uA+dYQPJVqwXPWguAmmVglj8liAjFqS2s/BPvr8i1okcXb91UolM/2kHU5IWPY+Z
	Jq2h5zLqaFOc4fzTYqP57pm8zmhUuMxtFo8W+S5gUul75A2BeZErSsndvtyUviq9
	EoiaItfqENaGtRSu1n8lLBWqVFWMV153vSjobIcSGIxFuC5SsJ6vPvSIqkS9CMQD
	tJ4S0vUHL0j5evQ9OByXSV4uoisRftaiq/iBB/7WslbmppGzJKiIn2QAmUVX++Sc
	qRv6+P6ACPhcQs/lVNyOruzLBVqVbwYdGwqFQfgfuGncO8IppcVIbyu/KlDxw8Af
	kDB3qVZaLL62Wog5otMNCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770824599; x=
	1770910999; bh=MvPV6QRTXsLvVbpVChY/XXHI0WkuUEaATj2pTBSU9Dk=; b=v
	eJUJ9MdwTKQlK0SrfF5clmE/3N/KaVt9WdkLNhDOsTTK3bfO4v9Ncb5xruuBRp5c
	XwH4Onqv368p2zrEz5EOJQ/IuTkW0qwD0AOjQa0HBu1MBSmZbnYv7LwR56tCGdPE
	ewiiW08awaJsorkEJk9qPVvX5arh0JZsIrWultURTN+OrozQ4bt4vCq/fFzRVN9f
	SuDo2kr0a/ut7mZA3W1LYcldJJ5i+lTDPPreQe7XlzbUPpc2xGh0dAb4It5Xi6JK
	xzLT8/Y2QRNXNNkVk8hLp779qFRLGFY+gwpR0JLhLZKZSdq4XtRZLySlPNIvzuA3
	XNWdBAuYK7fq2055m+Rgg==
X-ME-Sender: <xms:l6OMaQstTebYv7PexjFrJMcwEouCFzKmWlgHae8kfTT11odEoXvo8A>
    <xme:l6OMaUX2pJARmSNH1VWZbllWuzq5A3JC6dFKI6eiMyAdKnnBrAKLSb8WJmppA8dIO
    qA556xTiXxMYIr_MPnUrVo8PVjwxbUzwH95rw2RnGzC5z5gp17ghA>
X-ME-Received: <xmr:l6OMaUFsLUznjGoUBynKMUK7VnJBOEIgpQB7kjHidNdDQAenDY2hem1SdvmxQpPx4e2yb4TE_E4e1BZ7oRj49VDVZTbYHT0PDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtph
    htthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:l6OMae2nJu46iTuRnRt5GH_WzTwIDQBSKkJMPkz5BSWP8i8ypXne3g>
    <xmx:l6OMaeMq5qrYc3h9WREwWmhLKzpDoO-QqkVvif-qv5U-4cTmU6JhjQ>
    <xmx:l6OMaV6OyPVJxpvK94kjdHJ_Vh8jrIArHoqdb1vW7jtZh_3tkAj05Q>
    <xmx:l6OMaQ1aLu9s9isstSmYOjWgqFnfD41KC6sfV-KP_GVi15yEB-GFDw>
    <xmx:l6OMaWBlvqBCiMaFNSKwKL8LqUzpEQJL1V5GVz6moa6f8sftdHLd0Vj4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 10:43:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc: kristofferhaugsbakk@fastmail.com,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] doc: rerere-options.adoc: link to git-rerere(1)
In-Reply-To: <1a4060f1-6607-4b50-859d-927642eb34df@free.fr> (=?utf-8?Q?=22?=
 =?utf-8?Q?Jean-No=C3=ABl?=
	Avila"'s message of "Wed, 11 Feb 2026 08:14:13 +0100")
References: <doc_link_rerere.328@msgid.xyz>
	<1a4060f1-6607-4b50-859d-927642eb34df@free.fr>
Date: Wed, 11 Feb 2026 07:43:17 -0800
Message-ID: <xmqqikc3waju.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël Avila <jn.avila@free.fr> writes:

>> diff --git a/Documentation/rerere-options.adoc b/Documentation/rerere-options.adoc
>> index b0b920144a6..115882edab1 100644
>> --- a/Documentation/rerere-options.adoc
>> +++ b/Documentation/rerere-options.adoc
>> @@ -4,6 +4,6 @@
>>  	the current conflict to update the files in the working
>>  	tree, allow it to also update the index with the result of
>>  	resolution.  `--no-rerere-autoupdate` is a good way to
>> -	double-check what `rerere` did and catch potential
>> +	double-check what linkgit:git-rerere[1] did and catch potential
>>  	mismerges, before committing the result to the index with a
>>  	separate `git add`.
>> 
>> base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
>
> I'm not fond of introducing linkgit macro that can create auto-reference
> in manual pages. At the moment, we need to use conditional inclusion in
> the manual pages source, but I wonder if we could simply filter out the
> links in the macro itself.

FWIW, before deciding to accept the patch, I did check if
git-rerere.adoc included this file (it didn't), but if we can make
the macro smarter to do so, it would be great, as that would avoid
people including this file there later without realizing that they
now need to make the mark-up conditional.

This particular patch does not have to be blocked waiting for such
an improvement, though, right?


