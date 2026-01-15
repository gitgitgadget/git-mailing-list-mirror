Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A7E3A0E8E
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768485015; cv=none; b=s3+fzL7NU2sxoXf8gXLH3oUfFhuBmmXoyEIi5AcQ8yJ7TmNomFwc28EwkgN7tGcjlHCdZRJ1IFotXsfFcaivcJ6q7tJDZ6bJEG0zFFcMkuXWqARXmPnDIa5r29Mx5DEKNphYue401PcB08tgillpRzBz87AE/T5DKqLIX1avLe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768485015; c=relaxed/simple;
	bh=v5cicttdXf2it6lqq55zSSFlU7/yCY1v8oLwPPNRw2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mvUcJsrdCKiTfMKVtwqjSnfRfbCQGTVXyHdfFvP6oDQb3UVP2Rp+PBrlz0IxNqdmbEE+vpDe2NtzGBIKlgBRyaEdbijO4U9L7QryDin6CuUUAMm5DVAOxMbn1UhclB/VCI7S5glH1yX/kYwm0PCU2/NUuLCReRksmoS4pNE8vnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UZl2+P+r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JWrNIxma; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UZl2+P+r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JWrNIxma"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 987AC1D00097;
	Thu, 15 Jan 2026 08:50:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 15 Jan 2026 08:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768485013; x=1768571413; bh=6XaFnFUmZ+
	mdgzkQeNUJBPSjK45RpDTMmAPHdiDrBzg=; b=UZl2+P+r9+o6Yk447QT0j7lPPB
	t9mSOgKuRAYmX3ib702JCX4MyAH3J3Og0oN6LW3LaSsleFe3sozjeEl5ktAhDrFs
	BgB5PIQbLYfJkqVyFV6TueD4wxLXZGJldBVF0+R+1GWTGlqLl2BjlwQCPrfSVBEj
	iPS0aOrKqP5mXe88MN45cL2Nv8TPa0Jt8CG/rFmHIGyWIlvA4lyeaWnORFivTn2x
	AdSxW8eTFpaD49WuJDE8otRfda6uYH6wMzLL1aIcWPjK6bSapVz/XZauN9eKvkEK
	xLl+un/03Jx/ifDXAmNglxjgEmkNtRitnAK1apeoCvUSrXB4FtlqWAbrE7Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768485013; x=1768571413; bh=6XaFnFUmZ+mdgzkQeNUJBPSjK45RpDTMmAP
	HdiDrBzg=; b=JWrNIxmahs6/N1lShxNBgU3S8MSj6FdwH/0mcDelmlIG/JM1g5r
	1XjoOP+5Lonr0Cq6VkTinM4oHuqWUwo+WQJdFJgedhpD+U+MqueuD5CHpukXSDFR
	HiffhzSUMa8Ksa39r3VaAXedtCis9DfrGi/kS65hJKTiJO3Ldw9dasGelMHzsTj5
	QQ9Ryy3InXIG8FAg2mvGQa7cU6Un2tDnoKekXUAkxjas5Yv3x1iVeTCjUmgDCmW9
	DY/fWdIG5WF8I86rsr6qvbnT7NvKXisMi1R6hwmf9vmGMZymvhe1bYQ9WDddS9dL
	W8UEXcUW33BA2IqqJ6JfLikjORbb9L56Oug==
X-ME-Sender: <xms:lfBoaXKTXvvAVEPS8Ser9pGFO_zw4qK2QKvPih4KqFglhzg3ieidWw>
    <xme:lfBoaSkrp3qVixe35isagjqL8VCBdQIqt1YTaBRxxLdKFeJbOgA6uv0FeCQsh-D9_
    eAG3JbQRc7LDrV364Dum1F07YB4JhAVEWMG9Er4LFvDfkBySH4h>
X-ME-Received: <xmr:lfBoadE-PvYkj5rO3-GbpWO-6hsaYn9x9Um3kcj3hpNmM0TSDn5IX9tDH7cB3zdusqdC3lsZ-dnqY8aEIs2uizHLDJGDrjtd1eu6jKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeivdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:lfBoaaEIZ9Q8lKgfWkhQiEYBJiLDYNzPpzXGm9VsNkXDl0u7YOWZqA>
    <xmx:lfBoaSPObP58Vj6jnk8IrfTbht2yjOzFJNhzhvtkxfaoyWXJroSZSg>
    <xmx:lfBoaRG4XIITcWjmvcR1Ncr2T0yPmiS_JwcA575B7OyCiRTyoS4-KQ>
    <xmx:lfBoaROvWKq3AfaOI-zMtLRkbaNbN7OjU2xaYTKElqHqJhD__OC_lQ>
    <xmx:lfBoaathzNDTAYUiZhtU8F-HBCeKELC1HJ_flOZlUbLvom7VJw-L-eXp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 08:50:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/14] odb: introduce `odb_for_each_object()`
In-Reply-To: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
	(Patrick Steinhardt's message of "Thu, 15 Jan 2026 12:04:29 +0100")
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
Date: Thu, 15 Jan 2026 05:50:11 -0800
Message-ID: <xmqqy0lzc7e4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The patch series is built on top of 8745eae506 (The 17th batch,
> 2026-01-11) with the following two series merged into it:
>
>   - ps/read-object-info-improvements at b7f649ca93 (Merge
>     remote-tracking branch 'junio/ps/read-object-info-improvements' into
>     HEAD, 2026-01-15).
>
>   - ps/packfile-store-in-odb-source at 1ff0e42d33 (Merge remote-tracking
>     branch 'junio/ps/packfile-store-in-odb-source' into HEAD,
>     2026-01-15).

These two commit objects you cite have never been at the tip of
these branches in my tree; I'll go by the branch name for now ;-)
