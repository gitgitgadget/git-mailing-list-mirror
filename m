Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197F98462
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770667290; cv=none; b=d/QgYzVX+kYlj2RoLWaXG025ROtMnyJJ5aGUMLnaaCd7Xdz3OV36y3hfMblio4QeQwolc6qFcoPelGaB/ILqlg7u1RmZ7AXkIK/hiJ7Y1WXSCi9j1O/BrPzDWnanO3t+Eo8IJzo/NNmQ9gtidR9Xst/zOi+zHKYzTJZA6vuqa+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770667290; c=relaxed/simple;
	bh=qX+5FuT+dW/b7qfMAS4rcQ0BvBFk9TngHOeemKLoMcI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g8o+Zh/i9Guq66IgFOaNW4ftY7JAb5/+QjDSYTJwGBUpAHUdJ/W538DiIfXP1oTOFmjmZ44ooPoXqd3JCHMvw2Bs6OwHyJlIImoC1E7D0SGOnrQnELyKbtJI70bzXnpeuFrBGcNNdbaXcdV0Yg08E9LLinpIWkH3XMJvivrPOVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vFi4tSm5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TugXyfQ3; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vFi4tSm5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TugXyfQ3"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 4FB60EC0251;
	Mon,  9 Feb 2026 15:01:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 09 Feb 2026 15:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770667289;
	 x=1770753689; bh=vSax2ufbgHL3HYi576ClFtuNfMEWQU3xzzcn+Nf+ntQ=; b=
	vFi4tSm5NOAMWPIosssh+ErvWPc1mp02uVsTKt0UoXbLdn4mjrds3+XrFVg1W4ZF
	KEjzFk4fxor/LJD9dMeWnrspBBGhg39YXdF1l9NqEsZlPSskTS5yu3nx2hQQzK6m
	pIZ/l3tl5Mj/8KZPHcZb9O1QC8VOubc/awBbi6wk20gyt6CUx02LSvCKdz6MoESl
	fzsqTFQcIKujMUY9WvIasfWtn1V2rl3ecFTL1NknhPOhJh4iES8il2QhicuKqOZA
	U/a0/KcJxbVr75vJMM93FJLMUqEFAKTp8x/nS980HaQZR6R0Pu9CTO9yO04732zl
	f0M53PAEzbQVKG70+NQz7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770667289; x=
	1770753689; bh=vSax2ufbgHL3HYi576ClFtuNfMEWQU3xzzcn+Nf+ntQ=; b=T
	ugXyfQ3HlX7SP4WCko8Ssm+W/VUxPCh4oQI5BVsZJGUiiaXeAok6g8lN9eEvPRk6
	K4g7KEAdGKp1RUNj3iMw/n0P1APEwzlF5SDISpFscfSyorPM16QE+L5qaYTGHRot
	yyRXc0NBIVqM5lEScUd+HC1NI7r2/LDjxDG5sCRHNzoi1+1lLHbEt6gVk0ECGon+
	0JEyNIz0IbWsP2L52XavS9errOwwPkUia0hvuZJ+FA7LPsOXRFDWZfofcu/Z0/1z
	pRepq4lp42Y33VhT/GV66Pxl7ksFOxHOxmuVUqyrBuCnfhNKKg3R2QzXLVvxV6sC
	znjSaU9lPzktUsGNQp+8A==
X-ME-Sender: <xms:GT2KaY4c53WMw8nw5t-S-fGsYtIkj_iGFR3G_9WmRxGCWxzUqk2mrg>
    <xme:GT2KaQ59JbHSGscFGP3B4OSmbgUKXRLX-hqoW12uP2PtKhONhO33HytOg8TZwECFI
    oQWZyGHQu6EuAusOAvon2Fg49mi6M1AMObdh0hLLhGo7Zu44BYhiQ0>
X-ME-Received: <xmr:GT2KacfgIvZfWaFTmMruQFi0um-dIBhD5BsByNJzffqAJUlKtp1Igkef4_AasXZVpLghe7BoV_Er45JZA25GxsVBoZaJpZdmKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GT2KacCMYMUqvUYt_j8qpu8aswSTT1BJBH5TNk1H7OwOKVaxnEA98A>
    <xmx:GT2KaX-j0bb4WKw-YIPwlChKKNmjt19HZ4QzxDbQ6iOYoAiL8wWQnw>
    <xmx:GT2KafIE0Vmf2u1fZQnUVDIOqHBq0eZMQlqA2piPzTYhLE_qYBBxHw>
    <xmx:GT2KaYiac_ubvEQe4xYEwi07EOMtIJotxs1HsVa12SDSS9XEFkrZZg>
    <xmx:GT2KaZc_bwwEO-atzi2SmZrxhYls_D2tgGB7S9u_nDkiZ335m8XnbL2X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 15:01:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH] xdiff-interface: stop using the_repository
In-Reply-To: <CABPp-BFuwvqiCTCCpoyT6em9_1-qrgPWHWhrufQ3UuZ+Kfkb6A@mail.gmail.com>
	(Elijah Newren's message of "Mon, 9 Feb 2026 10:57:56 -0800")
References: <f58fa33d-b015-4339-819a-9d91be60cd0c@web.de>
	<CABPp-BFuwvqiCTCCpoyT6em9_1-qrgPWHWhrufQ3UuZ+Kfkb6A@mail.gmail.com>
Date: Mon, 09 Feb 2026 12:01:27 -0800
Message-ID: <xmqq8qd14rfs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Sun, Feb 8, 2026 at 5:47 AM René Scharfe <l.s.r@web.de> wrote:
>>
> ...
>> diff --git a/merge-ort.c b/merge-ort.c
>> index e80e4f735a..a4103d56ed 100644
>> --- a/merge-ort.c
>> +++ b/merge-ort.c
>> @@ -2136,9 +2136,9 @@ static int merge_3way(struct merge_options *opt,
>>                 name2 = mkpathdup("%s:%s", opt->branch2,  pathnames[2]);
>>         }
>>
>> -       read_mmblob(&orig, o);
>> -       read_mmblob(&src1, a);
>> -       read_mmblob(&src2, b);
>> +       read_mmblob(&orig, the_repository->objects, o);
>> +       read_mmblob(&src1, the_repository->objects, a);
>> +       read_mmblob(&src2, the_repository->objects, b);
>>
>>         merge_status = ll_merge(result_buf, path, &orig, base,
>>                                 &src1, name1, &src2, name2,
>
> A minor point, but could we use opt->repo instead of the_repository in
> merge-ort?

Great.  If we have already an appropriate structure with the
relevant data, using it is the most welcome.

> So, if you want to go ahead with this and then I submit a later patch
> that cleans them all up, that's fine too.

True too, but as long as it is so obvious that "opt" here has .repo
member that we can use, I do not see a reason not to.

Thanks.

