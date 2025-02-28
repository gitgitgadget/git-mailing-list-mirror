Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516B11F09AF
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767645; cv=none; b=ZyEvuYygw8en5lzGDcglDfmc6nYXBbh45GepLb36gurMONy1jHhJ6Jt7mKjf7jZGGE2zvQGfecI9/p67AxNQn+3f7+F6Q4zGRktBWZBWlwa+3Ug2gO2tzFgn6puSwkUjQmknsz25VzpmjdFiIN4DeChQQtUe5Y+pVE3Gh6pkiLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767645; c=relaxed/simple;
	bh=YizdfEwGh/vcPsiOhQNVtYBw+P9vIW30sua6cE6U4vc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m1oz7UqNahUQ3KknGF9jfGoJXxRvYTHicyQuU7v/iiA13HDOab7yrI8KxL3qnHH/t4gYkcSgLhAp/yLAJdpUIUGUpnrfl3WdlbxlULSXKxieh+yozk0YH4t6yBBJK/pHU6BQajZDTU54VUAaMog+9vQYqZ83q0mDp6GVnMt9cmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kDQ2HVnM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mlXZc69N; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kDQ2HVnM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mlXZc69N"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 24A46114012B;
	Fri, 28 Feb 2025 13:34:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 28 Feb 2025 13:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740767641; x=1740854041; bh=tTT7CAk26i
	lFzlj3h2sBN40eSKXuBoU2Y3hPBWL9q2Y=; b=kDQ2HVnM44F37lSQaKhVyF8U4E
	HFBd9ddmxRzrW3mS1AEbupKA1FUThPXHtSw2v+IC2+iO3T634olPs7dzyg0Ha/kS
	Y5bkBoA9Dg/2B0n9DP8UiEft2ZKjgFBcxyV0dH3D4IRxUcJBhAPJ5Y/pnyM9Iphk
	gn19jKjsV3tQU8tPqBHLTnwK3HR4bUiqDgsvzuI2ZIrPUylI8L6mvA/JHMiIDCLT
	U8s2BmQaFZgHw8vlCKsUW6XffcX007lvkNwrtWsPwm4O+VC7Wkrda89pm/KNuPuo
	hmRkph/N5EyXUyptTsc5yZtu3/e/4skFKqsLfV8zRFBH2jIYDfFQAuf9FSUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740767641; x=1740854041; bh=tTT7CAk26ilFzlj3h2sBN40eSKXuBoU2Y3h
	PBWL9q2Y=; b=mlXZc69NklD4izjCQFpoyG5OwXSj8jXkZ6HUE/x+ptcZ+vKIdR8
	G4GkfVHj7D+n6CS++wbSssA8CKLsqzZFG06dEz3YAKYQ6kKFQa/FdvpKq7qDuSgn
	7lzcgpgHprX5f5xK7Oe0spGLzrLELWlln6er0MCwy/LdXZNioqhmAOmFUoVhAEYQ
	4yT6VPl6WoMoJLVkZWG5M3Yn6wB4o1j6JBIGVnHGMK3XEU+qs4VQe3G1BGOGxiOL
	CjJWvzOxpH8v5CXzfZNRC+A8CLTD4cBerPpXYzwrn2eo5L3C12K8BMa4PJhvrrvp
	w0xqMarpohv5xzK7pNWYu6HPrJx0V8jEXCA==
X-ME-Sender: <xms:mQHCZ5E31tHpDieyi2Bz73XHJIlAJDsiMNrVpxoz6ghVC7chM5a-qA>
    <xme:mQHCZ-UKxA0Mf6OkPZDt99Jt-5_33ni5NOOicmhUG1VdvDrWgMHDlms09CcvyovQS
    N_R19d3UWYrAI2PSA>
X-ME-Received: <xmr:mQHCZ7K5vpYGZuO-JO9lS6OJM4efK9bF1T0GrU8PY9vFb5kAfXRM1f_s7w-YJb0czJY-4_I7Y3n1k4jBhIYVM4qEGGQSKDBx0YFL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeludduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepthhmiiesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsth
    ihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:mQHCZ_FoBlsdpWhzExbHSka_rrMiY6mSY9t8RTqBlFS8r4QNUBHhrQ>
    <xmx:mQHCZ_X4cnzpaHnDRvjcXO_8BkUw2WUZ9vu9VmbqCLKPziDrwYR21A>
    <xmx:mQHCZ6O6YsGP0gc9z_7SBwtFOQhPijTY_NlmON_xIKpQuKZ-b_jMSw>
    <xmx:mQHCZ-16meUDFVCoRoE9nIIE1JIKO2kGpoYVNQdC7GldG0irA6vanA>
    <xmx:mQHCZ1dXzUdTiE-QsVioUoIGAIQsS07-p-xA8IP436JMxlShl-_wpC6v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 13:34:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Todd Zullinger <tmz@pobox.com>,  git@vger.kernel.org,  "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 3/3] contrib/subtree: rename .txt to .adoc
In-Reply-To: <Z8HDhZ7I5D6Zrr-E@pks.im> (Patrick Steinhardt's message of "Fri,
	28 Feb 2025 15:09:09 +0100")
References: <20250228034713.203461-1-tmz@pobox.com>
	<20250228034713.203461-4-tmz@pobox.com> <Z8FwG_q7NmRDUqof@pks.im>
	<Z8G_Ia-oXgRcgVvs@teonanacatl.net> <Z8HDhZ7I5D6Zrr-E@pks.im>
Date: Fri, 28 Feb 2025 10:34:00 -0800
Message-ID: <xmqq7c593omf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> won't be for long.  I'll definitely have to take a stab at
>> building my local rpm's with meson very soon so I have some
>> better testing there.
>
> That would be great indeed and very much appreciated!

Yup, huge thanks to both of you for working well together.
