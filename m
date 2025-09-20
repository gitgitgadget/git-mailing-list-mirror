Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E471CD15
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758387691; cv=none; b=uLw6FSlYI3vapKXz8dOfRdn3HPWDX1Bg3p0tAfdjt1zOWWvjsomUxbHBsguR5kvlKPVH1zco2ppa2wEnmPqeNjd9pfkRk94+YcISZYVfIdURWzM6rVBvyGg6ZTjhIJkATwUDIEgJlRA78XrxP0W7vvWEseYWmInzou7RpxaTzLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758387691; c=relaxed/simple;
	bh=rLR/9n9fHpII+DnvmYz0huTDGnl9+bK4GsQ9moE9x6k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s7VOgRdDPK9d+ddhbRtL2IoRW/QBoW6sVwPOMplx2Yg8fb39L8CC+/Vc0h6PXtfouIj8oc1xsyeAxmqh/FoqaUttNXqXEJBjco8CzuAy/s5uIJK62YMJ7CDKltBxAr9fkKoKSchK4BrQqsT5vLg6boqKWEUOBhhPt4nB2AhIEhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pmVTI9cG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lKS8IQxO; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pmVTI9cG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lKS8IQxO"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E6E0814000DD;
	Sat, 20 Sep 2025 13:01:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sat, 20 Sep 2025 13:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758387687; x=1758474087; bh=epWKhHnUNw
	ceUfiBqzAgfk0YJkH3Hi0UrrxQo2ghLPg=; b=pmVTI9cGkZQhOeC3uyixWz+bDJ
	POfEPexTxOJSFTE1wdf80ck1/q0j3G4nWBGxdGmBi/6NwQuFb6LPaLTLtXn0MguC
	nVAP9MePJMXUJgrCdfJcPgfNzPvPClNWgu+UmZSY9kYzVu3M2OxSiTJ+PkVfrhkl
	kq9Le4qc7txT/oODGyn6uQS3omS34GiXfM50KCySLMSY3aNUQlvy5flLKoefMLhf
	dzTAKrudKNdPB4m1AeRIj2y2GM1ZCaRabyqWloF+2lWYxsxiTh53l31SgKQ+tX+6
	k/0YKAWyhCCuQ+9KbDZaeiCigH5vRwUK2M3wgjV4PKcgh2VKye1Hbl7oZ2cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758387687; x=1758474087; bh=epWKhHnUNwceUfiBqzAgfk0YJkH3Hi0Urrx
	Qo2ghLPg=; b=lKS8IQxOlcEasNxCulaLXtMzBqtmk/TPV52pApXdo6ozbmDnOE0
	1JCXQZz1xLEfVl8svbSFSs2WZNn1lvYIUg+V1Q4TFYYv+RXEn6jC20E4wVH07IdV
	V6XaOaPJdlRyfg/7bFziFT1jS/PGVFX+5rKcDDmo3szpdokqMHuzwPi7TZk3BUdb
	8mJ/hTyv+NQLyBofRL6//rvooSBgZlxYq9hK/FPzJoHhnOp+m5X609kcNANuec35
	UBEsI/ZMiBkkIjvKXR/XHYfhQKiLQiOOLg8mQ7SSYIOQ/PhP6mq6FDRfEKoTmeii
	3L3LoWm59xKR24rUdKQOsmJZS45vQyoFdHw==
X-ME-Sender: <xms:593OaOUkrHFG3-kBp7t9JBxb4nRzE5Ywwj1-kTXTVOUZTtqpb4gIwg>
    <xme:593OaGEGoEtR34Oy99TnUR5WzKSLM5sG3TxUqje73BlZ5wDRspnyoCjYnzAVqJ9mR
    WOBjyQ9wxGGHbmntw>
X-ME-Received: <xmr:593OaI0H633uZQ1NT5HaCbn6QA-D0ageVztVEc7AVYAJxo1BSfh7bI2inPkRTB8L-5jqkceW_4OpNUStpew-agmRbTko8CgeISU_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehvdeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsthholhgvvgesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:593OaAOi7Dah0YfTw4vyvRAP90Q2IBYCP0nXsEzNl7fu7SGl7_6Eww>
    <xmx:593OaP4GEPUVdf7fjs_8YOAqcHr7jpXhS9gbdbx4RyfFhH74QJlnbw>
    <xmx:593OaC12fMqlzP8EboJ745vA7BYrSvV5apQnMgRs8TuR72Mh-eqxLw>
    <xmx:593OaIwAGPgA0r_iT94zDAsio5ZQluJ6lAX8jEEKOsNqEnnNNiF7Yw>
    <xmx:593OaJYbVfDlI1WIBJtvzmylLrC7_D1sJPfzzrtn3GS7lDnZ0Up9Rsco>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Sep 2025 13:01:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 1/9] docs: update pack index v3 format
In-Reply-To: <aM7G22LJ47nx8Wqk@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Sat, 20 Sep 2025 15:23:07 +0000")
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
	<20250919010911.649831-2-sandals@crustytoothpaste.net>
	<xmqq7bxu14fw.fsf@gitster.g>
	<aM7G22LJ47nx8Wqk@fruit.crustytoothpaste.net>
Date: Sat, 20 Sep 2025 10:01:25 -0700
Message-ID: <xmqqseghxdlm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> I do also agree that 32-byte is the natural size for the trailing
>> hash, but I found that the two paragraphs below was far more than
>> necessary.  As they argue, we use a truncated hash anywhere in our
>> file formats, so I would have understood if the explanation were
>> 
>>     "20" in "A copy of the 20-byte SHA-256 checksum" is an obvious
>>     typo, as SHA-256 is longer than that.  Fix it to "32".
>> 
>> instead of these two paragraphs.
>> 
>> Or did we mean to use a truncated hash back when this transition
>> design was proposed originally?
>
> I think we intended to use a 20-byte value originally because we felt we
> didn't need the full 32 bytes for an index or pack checksum.  However,
> as I mentioned, we use the 32-byte checksum for SHA-256 already, so all
> it does is add complexity to try to mandate a 20-byte value.

I think we are saying the same thing but from different sides of the
same mirror.

SHA-256 packs and any csum-file based file would be using 32-byte
checksum because with CSUM_HASH_IN_STREAM, finalize_hashfile() does
not know any way to produce the trailing hash other than writing the
full hash value, and that would be 32 bytes for SHA-256.  This was
exactly where my "20 certainly is a typo" impression came from.

Be it a typo or misdesign, picking 32 instead of 20 is a good thing
to do now for a subsystem and fileformat that is not used anywhere
in producation yet.

Thanks.
