Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D69E1BEF72
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 20:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639967; cv=none; b=hjWDAfE1PVUWSk0YG8qedbneQJbmXzct5F6GfJyuMiBcZ440DkZUh/G84nnPZx3I3CRFpv+tJO0bNuIVDO8sJxUBLv/7BB+RIfYkUUuDyMn0tTE5l3sHlHxGC0kvLcIcSggO3BzP20qFJK39V5uahsNc8Tkc9JTx8Jdn4ERds6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639967; c=relaxed/simple;
	bh=quRjvYQklEfKwyAR4JLYcS3WeinISgiKg6RsYDrelr8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ibU2L0wa67lqAlfQGsiPFveD5emHOHr4Bfv6ypabiWTx/15YYAEeyHJDpn9MOdPToEddVVS3RDhD+TcUWWaswY2v5Zmo4dQsHlCXy79c50HztmpOS0L3JdD8R6VKbk78NnwXYdHwFhnIA70InfK9kC4Mp9hGVbJZOyeqPseAodk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HA+sQwBA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5lrUTCMJ; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HA+sQwBA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5lrUTCMJ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4796A1140186;
	Thu, 19 Dec 2024 15:26:00 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 19 Dec 2024 15:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734639960; x=1734726360; bh=1T5LGk+O6g
	CyKoSWm1knu1U8HKllcfJ7shzGCb74p6U=; b=HA+sQwBA0q3eN+pAOnZJ/sFzpF
	j65cw6+kHxJvgDq9hV+I6UkxzhX3W6LZSYqUle80GxVz/tD+CG1DeJHusGMP1PaK
	Yh/DvE+yRSHS6tev7qG5cZaqz2LDuvmW/uN1pSckhZO3EjDgrzCty6/3+HHubS27
	7mrXFLPlq3cp70wiS+70cdCuv7VhRVMf/Nf/KYrThE54n1f0nfibkhkk4xNWFfGs
	bQ4k9oQrcxm+ZWVsoYA0seTlGlqTFDKZzvhA91PS28Nrt61mX7RQlY8oFPg3qiR6
	zNt7+kZMajPD1MS5l0xGfamwUaU6hrSDMW/tZwg6L1VZrAH8yaNWgTM56ghg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734639960; x=1734726360; bh=1T5LGk+O6gCyKoSWm1knu1U8HKllcfJ7shz
	GCb74p6U=; b=5lrUTCMJ8opm7e4OgcQkTZJq9QLYhdvkR3l/fHGNimoKnU2xBRu
	x+qjJUeVpUOI4aKAHTFzpo03gg8K1NejyRF6UGf+CH0q84oiP/58C7oyS1WcEU3T
	2XbP+yYou4aJe1gXbJd6RbWtHW0njzHJus6RwdZDU6GqrfRMURjvyLzkb7+czR8C
	CWhC3xuW0JPuvAV37YvD99F9udzhIYzQ/bSvBzpYtmBCYUQcTHiWu7+SBCjSG/Vj
	3YGHagvs/QK+NKHtygaCR9fPaDLImGikl/bm+NBPSkfIJLY+0oS/+8vGUy473j4z
	xIEjBp8BNBOr/Tce9T34YORy0CYZRh4cYLw==
X-ME-Sender: <xms:V4FkZyg5HVq2Y5f4Uu1sQl13SN02A-rIuY8w_3akbTrljoorgvaT-w>
    <xme:V4FkZzBioUhM6RqvkCFrQkLChKa_9HndjF-QKBFTma6gfqcBX5z4LgLhi4d2-ceh3
    n48jQh5_cFXL_nOjg>
X-ME-Received: <xmr:V4FkZ6FGjgb-y_Q5TxjGbiMrT8FPeV8b2catwOgdOST-dkhjQ71D3HjAiPUmmIZy0B77IJ_jPdw8Mr6pX-9vYeWMmLXlSljmaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddttddgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhoth
    gtlhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhl
    hidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:V4FkZ7QkWJ0pGgjXyQZPlwUyPRROJhbd7iB54g6yr8-pBKpDCJMphw>
    <xmx:V4FkZ_wctVlmjgLMImyHnwFz5DXWBvCa8pcyt5IkAD7ml6DNirpoug>
    <xmx:V4FkZ55bXqsBaW-s67hI5WhuOlZPEbtVh3uQf2agChec-QFY3b41EQ>
    <xmx:V4FkZ8yHwqmGB4VENP54YSGrNzNJbWXV6JkJL_AyHqFhfyAbaQrsTg>
    <xmx:WIFkZ2k4a62q0KV1U-XaHnrHNw8mMvPCS7_3ffo6uCSxm_XHmjq011vD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 15:25:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 6/8] refs: introduce the
 `ref_transaction_update_reflog` function
In-Reply-To: <8734ijh3jg.fsf@iotcl.com> (Toon Claes's message of "Thu, 19 Dec
	2024 20:32:35 +0100")
References: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
	<20241216-320-git-refs-migrate-reflogs-v4-6-d7cd3f197453@gmail.com>
	<8734ijh3jg.fsf@iotcl.com>
Date: Thu, 19 Dec 2024 12:25:57 -0800
Message-ID: <xmqq4j2zifmy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

>> +		const char *what = flags & REF_LOG_ONLY ? "reflog for pseudoref" : "pseudoref";
>
> These strings are not localized.
>
>> +		strbuf_addf(err, _("refusing to update %s '%s'"), what, refname);
>>  		return 0;

And the structure forces sentence logo.  If "reflog for pseudoref"
were masculine and "pseudoref" were feminine in a language where the
verb "update" conjugates differently based on its object, the
resulting construction cannot be translated.  Rather, we'd need to
do something uglier like this:

	const char *refusal_msg;
	if (flag & REF_LOG_ONLY)
		refusal_msg = _("refusing to update reflog for pseudoref '%s'");
	else
		refusal_msg = _("refusing to update pseudoref '%s'");
	...
	strbuf_addf(err, refusal_msg, refname);

