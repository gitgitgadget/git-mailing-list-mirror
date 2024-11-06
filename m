Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551823A1DB
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 01:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730855198; cv=none; b=gcZ9K6ysjxTbcALpS3p885RNTyhJd+SN+XEm5LXJ5/93r8/zWGBnLbply0xEfjEnGO6z+BtBezmOmdahMk6VAKpbbVtDug48qxNfTZMIxTSeRmQ9PUGhh0ZLCAp18aSeG6mkM00hF6NjwnPCIq5/Va57RjGGEJltJ36eLY8BgDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730855198; c=relaxed/simple;
	bh=NoQLhl/8mfjpw+4pGKlhWvUiiBwVuE56YWieFL7E1Zs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BJ5Lww6ajgorjxRt9Nq2kpSVckswQuE3FGwZWM7fcsVQLYAi6XfU0LUU/9pts/OqbQNhIGV42a9sffz30xZ0EnMqoMqpkTqpHW+Rh0IBKN5gbtwg53ylNQhJypGnACAxSXDlnQb6Nv7F5mxIHJuBzM97xQJ9ep6SkERJvtoD0IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KTFomUpM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HrNCa/Rt; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KTFomUpM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HrNCa/Rt"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B2D3D25400C9;
	Tue,  5 Nov 2024 20:06:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 05 Nov 2024 20:06:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730855194; x=1730941594; bh=NoQLhl/8mf
	jpw+4pGKlhWvUiiBwVuE56YWieFL7E1Zs=; b=KTFomUpMktoXm4xTVeE/I11Mtv
	qfknZo6p1lQVeSyHhti+LTNNdUb+NSQb7a7jp7pNO8S01aEVuDKm2/aqEffML3Se
	sZmPllgrrJHb4q35ufAk0GutTs4I8cSRMX3Fj/Jow6qHVunIun45aoUR0keb/moW
	R+c4SYYvs6hPPUjp1RzzZmz+H6Z9339lIRN4XQTISPCAleWOj1zUq63P4GmXXdLm
	OvIQqvrvrNLcjYuLcTgke9Orckxk/vZwZt31t76Z8y2y9+8yfLhRPdw42ukKe6fW
	a4QPbLsaxRi0lFWbW4uDQYH9H/YMCA7clFxFkaXKSvZG85vkrD2QCao21rQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730855194; x=1730941594; bh=NoQLhl/8mfjpw+4pGKlhWvUiiBwVuE56YWi
	eFL7E1Zs=; b=HrNCa/RtOg6cndo3qofXFHwCJYpB19eeylMvYXdQ6ASPXeLrpSS
	MAPpMsH8QCNE4Xq7L/a1fu4KxIJFkLs3AQxVR5Pg0HRhXMbNGYyNWmMmqMVKXYjX
	1EFRkgJYQt0kR0Pwp7hXsbQ8/NsF67jhJS+6ybQ1f+oB6LEbSADXGiJGrP0l2/SS
	0zBYhq600fWWn4W0CFNO96pRw0KyjQvjY3CIwYVG/04FnvyAlAh3czY4Np40Z+LA
	zYW2sPm0OV4CTgRvYPVrAM+C6fiS5lwsucOB2mhXjVVcQ+s2aAl6vi8mQxHvjkq6
	n+jLt6sh49lG+jys2PIKp3VMTtw7ldWilVA==
X-ME-Sender: <xms:GcEqZz1uGX-rUc_aBg_jSH0-0aHPmC4UP01hO2mu2lI9iJUE19D3pA>
    <xme:GcEqZyHaEMXLkaM7jrxPKkN0SqOuqaSyjnwKO-zFzVPXtzilQ3FYCw-TIP664By03
    L1zaf3gIYE0ba6jqg>
X-ME-Received: <xmr:GcEqZz7e8re8i8q9nHA321gDgLS1Zg3n037zUz1Ex5IBep3sNIdB8UqGfB5X8ezlV6K2sAUWEdCQFZsdGmPiXcye7VBl5f2B3uXD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnh
    drtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghrihgtrdhpvghijhhi
    rghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehjohhnrghthhgrnhhtrghnmhihsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhoth
    gtlhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:GcEqZ43AH3DJ6JI31ZjbMqQWxwH2E6aqQjmzXdCE-QWM6kRZwnBd_Q>
    <xmx:GcEqZ2Fuw0hfld7S6hYGDgAlOOkmc2V2oMNKui_ZE8KxNOFKUnb3Cg>
    <xmx:GcEqZ5_Bs_BVrRJ93XPdAIbckakwbVWOLTZBZTltDprQd-sOzQlZtQ>
    <xmx:GcEqZzncr8_4W5jx5JG_VSopPb3Cq6dp2uqVF-HkAsmtlEOLCq9N9w>
    <xmx:GsEqZ-9a1vTXKO8mqPhaTN1itmgE-Vbif9UcLAE3Vb9_cQJc-GhQbeOj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 20:06:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Eric Ju <eric.peijian@gmail.com>,  git@vger.kernel.org,
  calvinwan@google.com,  jonathantanmy@google.com,
  chriscool@tuxfamily.org,  karthik.188@gmail.com,  toon@iotcl.com,
  jltobler@gmail.com
Subject: Re: [PATCH v5 1/6] fetch-pack: refactor packet writing
In-Reply-To: <CAP8UFD0Yk1Twv9DMOYwO4R+7P0YHj1CgK8xN=2YdE8sdi4ukow@mail.gmail.com>
	(Christian Couder's message of "Tue, 5 Nov 2024 18:44:29 +0100")
References: <20240628190503.67389-1-eric.peijian@gmail.com>
	<20241028203457.19715-1-eric.peijian@gmail.com>
	<20241028203457.19715-2-eric.peijian@gmail.com>
	<CAP8UFD0Yk1Twv9DMOYwO4R+7P0YHj1CgK8xN=2YdE8sdi4ukow@mail.gmail.com>
Date: Tue, 05 Nov 2024 17:06:31 -0800
Message-ID: <xmqqo72tqig8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> It looks like other patches in the series, like patch 4/6, have
> similar issues. Otherwise the other patches in the series look good to
> me.

Thanks for a review.
