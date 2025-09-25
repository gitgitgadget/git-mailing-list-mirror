Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51492367C5
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806722; cv=none; b=bhNhaB17yH/bX4j1rDW41PvM11AA4L3XC81afBEoG5uUd8AUpJsv0/cGQX1X5D/iy2qKfAO2fIrZ9LfuSS9riFS7TCnXCBlsPeIFlhOpAQO0YFEnc+xatwUuU4FChpKN3MxcSUljyREJ0f9UvbxcuvpT2DYPryt/nAhXM4DmyV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806722; c=relaxed/simple;
	bh=zVRFLT2+Zq7g087bQcUwYjbsjhwtn9o3D387DjZtVQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cVzdXXz0NwM8cfALhRFb5Xr7Do23ypI+yYfTRmpoKX42R/DY1pn31xmgNWXPfSU1QHR0IzpRyue7exW3XThDKkPpyQWGmtmhxLzxT7+CNf1KWkJ2NxAMKY8L2jIBCC5Fn8kF9mYrHRBXtGyVH5dyk+cwEW4hTlP+fzhVs3d6CAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S7w21Gq4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SN+5PyM7; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S7w21Gq4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SN+5PyM7"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E76AD7A0079;
	Thu, 25 Sep 2025 09:25:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 25 Sep 2025 09:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758806719; x=1758893119; bh=U82BuCTDRx
	IbHEva+UeI7gONzXEIjDR9o17aJunwrCM=; b=S7w21Gq4aZcSjKYmaQtlI5yzBI
	jQGXxVVetg8fU7v/WOciXrPXJLgi3dGnTUzEaamqV9QpYLlroAdZ+VhPz1qO6vVe
	FUkYq+SGceBrRLmfunRUkX+Wc7uKikIxwexGhwXMNN2p/IrBvV9YCsYpbj22cfxL
	L8BfuUWJ5NnYeamXpfBo3qNU/2WFh1aKtXqLochh4kZltdTfrHbFbCpvkZl/LKMS
	noaLwq0CwnJe8yeZ2IvkJqObVYi3AwgqTTTcwGuseAnf3au67zYb7bb9cS8Di3jn
	6VOW8IxCtS3Hx/AJxH9c78IPf+YTB1Ap2wPwF5yl9/5uAc6RFhJtMiv0jLiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758806719; x=1758893119; bh=U82BuCTDRxIbHEva+UeI7gONzXEIjDR9o17
	aJunwrCM=; b=SN+5PyM71fHvp+4wvSPYpD9R7tBIboGPmJkWLLv+DV3MdmDZnFy
	xZKsU2jAUEBeu5T5nQt4vJy9iS2UnPfrBry4E2L0rw0U+2FiOBlMnbdkZcCjT9lE
	BYhcElmjBQCGWU+K6PX8YiakjcmeKS/Za0NCP3SZ6vgRoO4YP6D/mIeq9LzSD+T3
	HmGe41QGVrWUHD+aWHu3NEtVEW/ce4wRPy+Fv1IaYaOfeIuqrpRcijKa+351hYdw
	N6+TmRyN7WepFXodOo+w1NjHwx6FhJd52fRu8Vk5EA+RDTkSG6xOa48dQvgVk/f/
	vrY0kbjNrM9p+y1kBwhnzvcajt97nR8ItBg==
X-ME-Sender: <xms:v0LVaGdczkM3gVtfqfzXSisoTw6ZguHCD_VahaJcpp6qnXk0rRwX7Q>
    <xme:v0LVaHHIAuJgK_mlq6CzBDMhfkPY_bjSiVUZEwVqgQQV8yyWFlF5vJ2juwPK5yueQ
    PNZd4pqsZQjMvs0D6axniNKlWaLf1qMeICyivy6a_6NXmLOB5ZL8Q>
X-ME-Received: <xmr:v0LVaP1wgyT2crO2SnShYZV_6LIk7tebK66_abgDO3lx3CZV3p3KvZWBhoUaZI-_QqHtCU2xGyu0Bp4deb5nQuNEbdQRadKP2X-6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiieeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehnihgtohestghrhihpthhonhgvtghtohhrrdgtohhmpdhrtghpthhtohep
    vhgvlhhotghifhihvghrsehvvghlohgtihhfhigvrhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:v0LVaPmTV7i-XKILbMedLl82JqbBHI4r58KvjS7pm8tg5bioStx-mw>
    <xmx:v0LVaP9z3bikmmCiIAWvSKCDp6X1K-svfBE1VNxEsxqDX7B3ZryxPw>
    <xmx:v0LVaErXkcGbSZoIjoW97X9MR7sqcjyexT9hJhJh6I3VNdxQuiP_Rw>
    <xmx:v0LVaIlu9mwBoGMlV0mMyftnAOOy7AbsKxA_Geu5hhsjuIVC8e5Bhg>
    <xmx:v0LVaFDYrKa1UHD_4lbKXcIgUImLHrU2duFYhcrCvKt3yJqFV43ZJ7XS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 09:25:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Nico Williams <nico@cryptonector.com>,  =?utf-8?B?8J2VjfCdlZbwnZWd?=
 =?utf-8?B?8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>,  git@vger.kernel.org
Subject: Re: 0-Based indexes for git log
In-Reply-To: <95F22D6A-38D9-4F4D-B71E-59320B86B4E8@gmail.com> (Ben Knoble's
	message of "Wed, 24 Sep 2025 13:28:31 -0400")
References: <xmqqh5wrn66m.fsf@gitster.g>
	<95F22D6A-38D9-4F4D-B71E-59320B86B4E8@gmail.com>
Date: Thu, 25 Sep 2025 06:25:17 -0700
Message-ID: <xmqqcy7eis02.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ben Knoble <ben.knoble@gmail.com> writes:

>> * merge parent numbers are 2-based (sanity of this statement is
>>   already questionable).  If HEAD is a merge, HEAD~2 is the
>>   "(first) side branch that was merged", HEAD~3 is the "(second)
>>   side brnach that was merged (in an octopus merge), and so on.
>
> HEAD^2, 3, etc., rather? :)

Thanks for correcting me.  Yes.  And HEAD^1 is the first parent that
is the same as HEAD~1.
