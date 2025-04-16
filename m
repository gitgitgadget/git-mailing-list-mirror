Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB93D20FA9D
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744819256; cv=none; b=CATb3w2z7QPL8HjuboGZVvbPbrap7Uv1MTRUEGdx/Jq8ZcN7xSHSbSMBaTTYeqd6XBkSj9nvjpRcFzZFTTg3A3W+o9oABVtl7Ry4AKz1cEcWAJ4Bu/H6mMt5G4uGzZ4ZaN9n5Ukc+Uho0oZ0WTbB3Xe2mMIWA3ymtX1egMHZGq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744819256; c=relaxed/simple;
	bh=QhpNiJaOilEJ88FlaRXUFnrCw92MzrOcS+gPhA1Yg8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rkfhSU17ORfMy2O8nH6QhfxAWa5gVvmuSWEwSXBer0OxqiFyUuTnn3UkTVrbXEhCz5Pr5Fr0HjuaD9+5JfPpZhsckjxVX0eIYDUMvSKd47lGYgh8go7bTj6ZmGJz9Yifnz9dgFrywL+AxNA+nNrgwYq2iviNC8z01FCs/xI7u3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R9BHWan6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i3UjvHIH; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R9BHWan6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i3UjvHIH"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id CCB531380212;
	Wed, 16 Apr 2025 12:00:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 16 Apr 2025 12:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744819253; x=1744905653; bh=Ads5Xr/tuB
	Hv+lYw6puqnoYXYjLBhzg2TUy4uPsa0sQ=; b=R9BHWan68Qszy7E6uJ1cZKaJhH
	ER8DuaV4LF5bfv6+nVBx7so8Ac3pK6yvvqMYwh29iG/88ztlCHUOMvmdgt1z6gde
	FkQOxPdf8YSG/L6xh12mkfOtZA3BuapOWzUdxGTw/jLmktybsXpo8TacPv4f5dfY
	gcQMvAoOE62eqSdUZXwvTFKR0sNn/hNvvcZOD8WwANMtL1ha2AxqaSLki8Qmv1KB
	4LXDv6RFUpqrTPy3XDYf1YpC8o4SglbAOhPMIsPqDzpVv8iPP/qu0+7J7iSgnMlA
	7K+HaSr+gVhtd7yzPmz6Ln5Ffrm4NPHGpCP7qs9yWXa/bHjWKhZNXqolx2MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744819253; x=1744905653; bh=Ads5Xr/tuBHv+lYw6puqnoYXYjLBhzg2TUy
	4uPsa0sQ=; b=i3UjvHIHkBbtYSrbLiFE+mItU+3oCRmhJQwF2Ao+Zd909HvsIVY
	mpk+UjvR8uUS/LGPVhm+EGyYE1qXtmx5mjd1rJZ6XuP0SR2j9axBecuTX97+tB4F
	9e1NgFwrfI+/jeAFsBNabKGcY006LK+uLlW95To3EVgdtXMjN4W9a1pSXno5behj
	H8jduZ41y3Rz3kCCEfRypMSS0lyDIAeT7jJc6J5pVllWJ2hbp8nMphNp0z/jZYhC
	zX4jXZl3ozxaiw6HHI2SaklTSkBIeNaM0HU2EpyPKP/P0kmhjsEoDLy50S5ULOp+
	vPSPzFWoq5J2RSi9h0TMpbzPBq3j7DBurvA==
X-ME-Sender: <xms:NdT_Z4Ly6vevzONBNoNb-EMpjssE3VUGKTEX2OYGfTHmT-g4hC0OOg>
    <xme:NdT_Z4IpuDis4uq02Jf3Q6VqrWB2WVOTw6yQrHIntV4Hnt4uM_nClcRey0u33Q-BE
    RPXPemK9cl0ydBY8w>
X-ME-Received: <xmr:NdT_Z4vQ7JK6IdWhPW-HqkxqY8ZXKWUTGWF_9WLehU5SdLQXh31PiHjJRAX1mVLrPNfp6U982QYecCZH2JXjGV1UatSVPPO3H_Nl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeijeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvg
    hikhhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrhigrthhhvggv
    rhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehsrg
    hnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehpihhothhrshhiuhhprgesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NdT_Z1YZOWG-kXjOXkefJz8VSE_asVQJNpPedBzyIcsEGisiKPLToA>
    <xmx:NdT_Z_bRnt17GjTga9TUpLfg_NpLnYQpnsDjoKLWpg5EyYBrx7b1hw>
    <xmx:NdT_ZxAG8XCInPRhztkV7Wwc1R-6lnN4bi2O834U1xCO7D-QYQzJuw>
    <xmx:NdT_Z1aGb4uELFR8sVZYuWXrNqXh4Do9-7Uae9FH6UGGu_QAzeMpPw>
    <xmx:NdT_Zw95FFUi6w-FVuODfWIFft5Ji1NRymj2_zXaTg4iLGUcy8ipKF1R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 12:00:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  git@vger.kernel.org,  peff@peff.net,
  piotrsiupa@gmail.com
Subject: Re: [PATCH] t3706: Add test for wildcard vs literal pathspec
In-Reply-To: <717161C8-497D-42C7-8C10-AC112238EEFD@gmail.com> (Lucas Seiki
	Oshiro's message of "Wed, 16 Apr 2025 12:49:51 -0300")
References: <20250412094607.236382-2-jayatheerthkulkarni2005@gmail.com>
	<20250412174051.780148-1-jayatheerthkulkarni2005@gmail.com>
	<Z_7ekhsBzXK6LKuV@tapette.crustytoothpaste.net>
	<CA+rGoLfAidyuomeNym5WX8Bo7-jPcfHx35wDeZ7W2aorAN-B7g@mail.gmail.com>
	<xmqqa58gjlnk.fsf@gitster.g>
	<CA+rGoLesZ3nSjruJ8_XRWVsFpMu8mo_4cCOdB-GFHU_qXkXDCQ@mail.gmail.com>
	<717161C8-497D-42C7-8C10-AC112238EEFD@gmail.com>
Date: Wed, 16 Apr 2025 09:00:51 -0700
Message-ID: <xmqqcydchz9o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> So, if I'm not doing anything wrong, it looks that it is not solely
> related to pathspecs, but related to pathspecs when used with some other
> commands. hmmm...

I haven't looked into the code, but if my recollection is correct,
"add" is a bit curious in that it has to deal with paths that are
not yet in the index, unlike "ls-files" and "grep".  It could be one
half of the code paths use the "grab everything that matches the
glob" while the other half uses "stop when there is an exact match",
perhaps?  In the very early days of Git, I do recall making a very
conscious decision to stop when there is an exact match to help
those who add funny pathsnames with glob characters in it, but that
is a long time ago, so I wouldn't be surprised if we gained multiple
code paths to do the same thing, some of which have been corrected
while the original ones haven't.

