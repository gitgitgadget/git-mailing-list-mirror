Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4671A3164
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 01:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768010164; cv=none; b=YiW9ggytXefMmgSOrqEn1EQNGd3OB471YOITlTaVd9AlMt4vUbHDVdin0Bsz38qq79UdAiiQXdk+DJ8vqKBRClrfekPDyqCm3hu+Ds3ZBRCAdPfte4Mo08O4Ah7KRbnQfyUv1WSG4akQFo8AFm1809gJxnXVjXsH0YhAB2G2oQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768010164; c=relaxed/simple;
	bh=AZFe1IODxvIEUkXyCmj89bzwVccgqett9mDdGTzj3So=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DIaoO+98ro8wMlMu+URbnl3AiuYzzvW4jA2EfJ07ila223wKxVzd4N85h3YZJe+Ov+shLgm/Q4Zmsz2Nrr+IJc73FILzuzJeCOKScJkJtdItPlGeH0jMhaAOdKMJJ0+4d90nUJLWq4QQCXXmCwH6EQ1Dli5CtKsMklIQiTXwdL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EyRz4tuB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QdDHcom7; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EyRz4tuB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QdDHcom7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 19E147A0102;
	Fri,  9 Jan 2026 20:56:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 09 Jan 2026 20:56:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768010161; x=1768096561; bh=5Hygeu7eMv
	em51603fazfbrGMqvDRs4DhluT1ImTiAQ=; b=EyRz4tuBwx23eR2J/Ci+NgEWfC
	zEmkIYKMOusUzPIcwT9lOH98uilye1Kz56stearB3nMGUp82fXF8blHeqbqI5w46
	7GOd90rffkyV9YQXbG4wdgjxcC+K8G7DDTE9YSVyfMl3Z0HwPj+vHESb6KIxKCM9
	sRxfLhX36FNMoDI0iN0FkAadh9U4+SzdL3uamcnuinMq8+AeW9afoheur6qs5uvV
	AMZdmRHDugsi+ZZBAn6mgCciAfIqpRorpXzwD+v1GjPKPDTdJ2x+UsBSwuTZ9mlP
	FshZJWz7l/ExYqJCkbp615l+ZEp36CUBNl+6Ey/xg1wBqttjWodnWoYNUEJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768010161; x=1768096561; bh=5Hygeu7eMvem51603fazfbrGMqvDRs4Dhlu
	T1ImTiAQ=; b=QdDHcom7V9xgqy6DQh0q0gy4njYmsoJWzHlAbJU2sHVQ4I3NYaT
	RG09kB73Y9UBBYC7u805ZmMImV3SyHQPcAT+C2uZ5+XQFAH3DkzMxq6eUdKuPgDm
	mcvvlqF66vve6H3M6WsPdaJpk+ZHQBt4SRT93ifatN5B4T7qQ+y1eJS/WSRS57Hk
	ojQzBn0I1eDH1MmVPIzPx/kgSuN8sIS9TJcPJjUhvrYuLjfey06MWShBRCP3vZO7
	jg6mN6/P3471WqMK04kHVZ9FePBIWMcsIVzX8vDuBER9COPSAAC6ZObrlYY9cum7
	onpYLzkuFBkkCawfs5YfSmqS6pIRPgT66Jg==
X-ME-Sender: <xms:sbFhaTOqMxtTkPB72j4TXOLE4777JAY2jKulCcwvzYy1udbpYUKOHA>
    <xme:sbFhaVZBv9Lf6QfnRhoISXL-P6BykAmYaumscYdak9oDOZPz6qWNj19hQ3OvEyyJj
    Zq97dZr1VNgkJgmijace6A84ZOOsUNcUJQZOCBDlC8ABNFOpRxSiA>
X-ME-Received: <xmr:sbFhafod6JNM7_sNtPT1txzzZHJoB-_eSsDMIGABFRiMO5FVvIe8vDEgbNDhsa6JKMtJuIEK2JIFp5urfUv34LyQxxWy5EMIueMOFm8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduuddtgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:sbFhaRbjBdwnAyErD1o8CR_95WVTFz4V-43ikrcQKZbb034ecAFTCw>
    <xmx:sbFhafTvMM_1O0fpqbwcNd_RNqVzMHNfzrwT5VfxKqtlztwjLnwO2w>
    <xmx:sbFhaQ7k7AZuLPvJDR04ch-dvUHTx9CSxFXRma5tNAGjRI9PtEt7vA>
    <xmx:sbFhacy3fJZfWiomu-5v-xVMdjq1h6-nmDwUMqDV7_OSNf4V7qN1pQ>
    <xmx:sbFhaWFBZp1BROMGEO8gxYcFjNLmVMkEgDnQXfq71nlIHMQykp02arb->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 20:56:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] gitfaq: document using stash import/export to sync
 working tree
In-Reply-To: <aWFg_VUZH5_ZqTix@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Fri, 9 Jan 2026 20:11:41 +0000")
References: <20260109014608.42773-1-sandals@crustytoothpaste.net>
	<xmqqseceua9j.fsf@gitster.g>
	<aWFg_VUZH5_ZqTix@fruit.crustytoothpaste.net>
Date: Fri, 09 Jan 2026 17:56:00 -0800
Message-ID: <xmqqo6n2temn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2026-01-09 at 14:32:40, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> 
>> > Git 2.51 learned how to import and export stashes.  This is a
>> > secure and robust way to transfer working tree states across machines
>> 
>> Here "secure" in "secure and robust" triggered my "huh?" sensor.  It
>> is a robust way, but is there something particularly "secure" about
>> it, other than "it is less likely to break your repository" in the
>> sense that is already covered by "robust".
>
> We know that sharing a working tree with different users is not secure
> because people can have things like hooks or config options that execute
> arbitrary code.  Transferring stashes doesn't have that downside.

Ah, I wasn't thinking about two different people transferring
repositories.  Using rsync may have that downside.

