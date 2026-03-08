Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB83A1E7C23
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772952489; cv=none; b=HOttoeUPCMitBjChv4awUxELlt5wL4dVK5NeZqVCzEhZ1ajpv85scDTKxq6xGFJ+hB8H+/KOCs7KVHaZ37Kmf5Ay7xNTpQSUpANuGOv/oqYTn7u9wM6JmRwX165DLhoFYJSVft2kj/kBtqEii5Fwo+rk7k9QY1tX+2aBTOldM/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772952489; c=relaxed/simple;
	bh=LP0O/Dm5yQIvZvzj7A/1hgwd6bHGsG2jGQThiCBT1g8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sYoWQl+9i43PU2XcnFwQPbzrAcm34ZuB+Y8a+9vqCgC7Ttf2Km2O7rDIWvE5wNl0cOn6jD7DC4NgOtRKW/v7ZSM2X2U4ezTWM3NGP9HJM4jdLWLyJUsPNfPE3H8JTkRqaIagN2chOh7VKyUYjigI6Tq65cS0Zz0Vpj+vg+bLpls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZJ/I0g2j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DM55OCTr; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZJ/I0g2j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DM55OCTr"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 43F271400167;
	Sun,  8 Mar 2026 01:48:07 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sun, 08 Mar 2026 01:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772952487; x=1773038887; bh=Anazb0Rm8Y
	Jx7V1LMJ0iYdDbHul3nokh1pHcOySTNz0=; b=ZJ/I0g2jtuEwYpAblMPSKy/z12
	dUjCG4Ih4n3r6bUJTfFcWQnCZQlR/2heLVh5+UbKGT9Pdrmu3NVoiIgi8zqqsVQU
	CzgdrtX3KCx45Ew3UEBREd56HBgGG8ViC412xaVIioUGLqazepxAYV5+vO2ZskbA
	rOpZeEmfPV2wvTjf7+oTHi2Y4Zdl0HUw298I8AFykI+KPa2nMJCbez6J5hhDKVfF
	nTYV91c6tIGNwOLDIo3jbw1EXpmSLG/9B14T/+z3v9CY8/pF7X2Uqld53oL243kX
	IdPAkGNPCUAe9CrNoWmdyzsrEgwFHZWc2+Uh34SVhhQ/sMO6IQCbcH6VvbqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772952487; x=1773038887; bh=Anazb0Rm8YJx7V1LMJ0iYdDbHul3nokh1pH
	cOySTNz0=; b=DM55OCTrkfZ+6bPKk0XLyV6yFfvXJj7U9rD+WUw7eM/f5YuYXou
	E+bgE2AaFrlJjmxT2Z5x+VpQHh+PaEBTvaDmLkJ3aTsfWr/nsugCkQ8afwkTVnms
	FGMVDaQDV4vewkShXsqiKN5czbxs1ENSW7HWBG5xfrQ7t7e46yi0VM8w+tQHIOQk
	KKXZAuovJXoC8j27xuvCScP/1DOvQwtn82irI2LQV/IY2/mF/ciknBzrtRexsd9B
	C+I4CIe4+98ZIrx7kWpYg5FBcPXrGyolJWJpMeSYr55Nv/lkNFJwz+q3DJ8YU4Tz
	U3ypP3vvrO8ODkiHUcF4YVnpD+ZV89ZU4nw==
X-ME-Sender: <xms:phutaWd_ujChQo-LMKz2b2jQKm2GtcJIoTJ7WRpi8UMchoT4xgp0yw>
    <xme:phutaT4KRArg21NU_Owr2W1ohz9mPQJNullBxPpL05b6uouhZYYvhEsa_mLIc-iSD
    -YlA4svpRX7TOUo7wbAFRvSRKUzvZuTCS820mFSrhrahAecbqqpxg>
X-ME-Received: <xmr:phutaRVrF_5lZlPAJRY5UWuTIevYiOy-2zK1Dx5RmhDFw49yHkUpklyawiLpQO9Xy8WE1Zv9zd09duidzr8-1PJZDXwugqd13w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeeggeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopeihohgrnhhnrdhvrghlvghrihestggvrgdrfhhrpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:phutaa7ldguN64qUB7KNq78o_HIz6_PD_FHgBYC_uYyxPPqzKt-Bxw>
    <xmx:phutaUru17piAoW1UXD2hqGIAlJRgM9bjLwXA0m9D2bE3Ku62L312g>
    <xmx:phutaVkQb_UbPpbSZNA6ZL63-vCHi_uTkx6rZ-UBhlujuN2XKa2EiA>
    <xmx:phutaYNiDpfVSOtC87i49LKphZgTPDlGE8comp23Gl6-Nakw0VIfvg>
    <xmx:pxutaQCILAnOBfcMT61G0Yn8zHagmEo9i4fvWGcoJD9ed4m1B4V_4YSk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Mar 2026 01:48:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Yoann Valeri via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Yoann Valeri
 <yoann.valeri@cea.fr>
Subject: Re: [PATCH v3 0/3] branch: add prefixes to new branch names
In-Reply-To: <CAPig+cQu92SNS9mamfEwfdZMgqHeDh4Qn7HExgB9OzFiTZTHtA@mail.gmail.com>
	(Eric Sunshine's message of "Sat, 7 Mar 2026 02:05:06 -0500")
References: <pull.2202.v2.git.git.1772207333.gitgitgadget@gmail.com>
	<pull.2202.v3.git.git.1772802872.gitgitgadget@gmail.com>
	<CAPig+cQu92SNS9mamfEwfdZMgqHeDh4Qn7HExgB9OzFiTZTHtA@mail.gmail.com>
Date: Sat, 07 Mar 2026 22:48:04 -0800
Message-ID: <xmqqfr6alsuz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

> Sorry, but I'm having trouble understanding the value of this patch
> series. Neither the cover letter nor the patches themselves provide
> enough context to really understand how this feature would be helpful.
> Adding some real-world examples of how this simplifies your workflow
> *might* help sell the idea. Without such examples, it's difficult to
> imagine that you can't achieve the same with some simple aliases or
> tooling/scripting on your side.

Very reasonable suggestion.  Thanks.
