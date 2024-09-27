Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92FB139D1B
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727464978; cv=none; b=qHhoHDSHY2vo0ALBYlD7C3zoSzaEC1fmeLtcpL7NHELMhxfAOu7n6UFvL+ZawPx9sm0nXDHZfXQWlbCWxuKS15KNmDXxHMMySsXqZ0f22x2esWW1sdhzWWBqksdAvsfdObMO5oEq6CyenUR1NGBfH5bGPMllQ6AYgT+kqf8O/JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727464978; c=relaxed/simple;
	bh=CqdnzkXLy6qhK5wzpPTQUwBnN6ojBzu2aDUl6plkJPQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NtifXviExcy4XhO4iFh/UW/VHm0vaVe0DvI3IUk05iw3ADLHUJxmrl7gwgKswW5NMYByqKGm3N7p8tOCeaA5Cyg84BZkKlTWX4E0HnIvTYuCqpVqT6BA67ZBhDv8OEm77frz/oHn49+xYc7TAZA4JbGiShLsaVZskBNWPZtjFLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sskf1kQY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DgSE2sNE; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sskf1kQY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DgSE2sNE"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB530114017B;
	Fri, 27 Sep 2024 15:22:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 27 Sep 2024 15:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727464975; x=1727551375; bh=my+RUL2LIS
	SwiqmnHGIwEXMCH42NSbBigqagHgGHcj8=; b=sskf1kQYSj43raAoo0c3k3AGUW
	lBETZ1MZFWcHifKrtqpxjOiEV9NCjc8uwm3SZfcnOW2sYtRozh36WEgC+8zvv26z
	Y8pENN+AjnE84u0i6ulSlp/0b+/I86DDCL84DZR0BHIAdh9WLPDd4YxgdbYPcCQ7
	ROSSv2kn3aaV3dHhKS1Stiek1TqRgJQf5rvRsnukfofrAqQgkBUbus2vDrfteId2
	oiC+TLX7tAICa6dtcwCQtguSBzBIqhXpOJx5ztWOVX5gWutThAuC3n+dVfv6+R3e
	qAqNpe5JRR4K04SB5eu3zk4lEeovPJ/aTtCVmE6QgkC58uKFOJ7jeFs3U05g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727464975; x=1727551375; bh=my+RUL2LISSwiqmnHGIwEXMCH42N
	SbBigqagHgGHcj8=; b=DgSE2sNEzUSE0vhO4Q+u0CdsonragH1vOaIlox8iw0TY
	unvoCWrjs8EAuDFGNCi1hckrL5zSk42VoktrF04Cl3HkOMFJXPbdbBN9/PSQuWxP
	r+bbyrxUW16eNilNeOum+g9yTHit0O57G+l4RoilI6y7EK6V7ByEwqUCJr/tv3Aw
	VKODoGi2xeVqH9N/JzLhzRqlYi1RQ4u6I2FRidkj3Dk9Mt3q2MmK7PlZ7rb6rtnc
	Whf8JCakGO67+HQHFyH6eF2qVgNcUN85b3AI7fwS5K0g3lDjiMFsExTQjeBB9pg8
	FF778MJq8+XEezvre3qnEZuBOms8+43AuACy6DE1Ng==
X-ME-Sender: <xms:Dwb3ZgVbxlcDTHPO_5mSi4Of232Mv5mLNlUZHngocfqcVj2oT_QnwA>
    <xme:Dwb3ZklbzRtwJMJi05Q5C7GfvWzAns9X309zrB2qJoUhd6355vJpUcVF6y9b-n-pL
    LP2MVSOEDkumaqEjA>
X-ME-Received: <xmr:Dwb3ZkbMH8MJ9ViCNkdptufds7d3ZYC5mwSk8GexO0draixvm_OnaVAF5ZDXL2ldYIToyQH4N8HmjcRuRAH77O2jHnZXa_iSqXnePKs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtledgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhonhhsthgrnhhtihhn
    sehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepfhhivhgvvdefud
    dttdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Dwb3ZvVJfO-ml5yF9DE_MHI_zqjuUszEtRIpm3RL0iQraX4Tp5NXMw>
    <xmx:Dwb3ZqlffYIO1iYwKNFdIVpEXpqy7RtI9LTuE8aO2lAvBJlyXa2LFA>
    <xmx:Dwb3ZkctBnLmCmNinpqsC16nz2Cp82ExcxCFnKGwK3xp6VCiE4fmGw>
    <xmx:Dwb3ZsGiYNtP_qlG_GVauiWCL6T5dltH3O9rQwpQWldUz5B1xzOJmQ>
    <xmx:Dwb3ZoaLxJ83LTzIlrzHvRgV4EGmm8TWGMX6YEDkTRtQRQcQtm-fO3J_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Sep 2024 15:22:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,  Kousik
 Sanagavarapu <five231003@gmail.com>,  Taylor Blau <me@ttaylorr.com>,
  git@vger.kernel.org
Subject: Re: [TOPIC 07/11] New Contributors and Discord
In-Reply-To: <4e2b5740-6863-4ab6-8483-2e933b4c427c@gmail.com> (Phillip Wood's
	message of "Fri, 27 Sep 2024 11:08:19 +0100")
References: <Zu78E+0Uk5fMSeQv@five231003> <xmqqsetr5wl1.fsf@gitster.g>
	<20240923-spirited-lime-lyrebird-fe90d5@lemur>
	<xmqqbk0exdk4.fsf@gitster.g>
	<4e2b5740-6863-4ab6-8483-2e933b4c427c@gmail.com>
Date: Fri, 27 Sep 2024 12:22:53 -0700
Message-ID: <xmqqed54gauq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 23/09/2024 22:31, Junio C Hamano wrote:
>> Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:
>> 
>>> I can chime up and offer bugspray bot integration for the list. This is a new
>>> tool I've been developing for integrating the mailing list with bugzilla. I've
>>> been using it on the tools mailing list over the past year with reasonable
>>> success.
>> Intriguing.  Everybody loves to hate bugzilla, but would bugzilla
>> become less smelly with bugspray enough to make it palatable to all
>> of us?
>
> If it's easy to set up it might be worth a try. My memories of using
> bugzilla in the past are that it wasn't too bad for issue
> tracking. Most of the pain came from trying to use it to review
> patches which we wouldn't be doing.

The biggest pain point I remember with bugzilla was to find bugs
that are still relevant to make sure they are assigned to somebody.
IOW, curating the collection to make sure false alarms are marked as
such quickly enough.

Thanks.
