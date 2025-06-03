Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793881E8356
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748976099; cv=none; b=Ccoi2BstJJWjDmDJXF1wJdtZpfurBDkFDtKSwpWHW0v0tSKYSUDM3VDXXuaxcQXmlTqkFVQDZ8kGtkuZps0XCvZ7YaXWfBYK6mATjw9mGMuTCgJWCvFAd4Ff4ciqnQMWlvMRpQmZ20CEKZNPVawc496CjhmEAhDdPXFRKO3xuDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748976099; c=relaxed/simple;
	bh=LG6nrm74DTxPe36FHF++mP63j03GGv9tbqPw79DbLtM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=reTYoUOxDDeQcwDKezntq4JZnFuANgPcfLOsFsN3v/cgAp5EnV/1joaffFg2C3jHwCaLnWnK4wDVYopXdz81G26Cxqy4YWGSXWFI3pYJ7hmWca+Y9OcIrNBg9KGXtod0EBY39ieqirODf29+7sriquvVdmpz8QvU3GXlVd2mF3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KrHQ+8FU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MC3Ojw+8; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KrHQ+8FU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MC3Ojw+8"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9324111400D7;
	Tue,  3 Jun 2025 14:41:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 03 Jun 2025 14:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748976096; x=1749062496; bh=kQhaEm2tEG
	NFSmfwWATLz+iEmEPxvOPQVvsPIhpIjIs=; b=KrHQ+8FUA7GpigxgVmLz8huZQd
	Mh/uK0LezBkPDlag+cDPdTF9KsPO53D191ye8sqdh+JW0YEqOxXO8M7BBf37bxOW
	QR4r9/4THXf+CJTEHSFc1z2FVmzMhlWe/kt1CfY2v+ViPSIjYSO6bcIs4DJCD8Ea
	TRq6URAVnGfutgeaAtnMJX4gHL1O97gBJyx33hK/UO7L6AldgpxzU4RqDSkEj6D9
	nLjaT/+zOoVCJzViODz1mRsMHK/aa5WCsCJJ8HKEevO+dCV/7iBhDyMBylACclgF
	vFjXqMFuwroEOcoXP6+tXWcElzcjjO9dFrYWOsdbQmZvAjMw4TAhPVYyqI+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748976096; x=1749062496; bh=kQhaEm2tEGNFSmfwWATLz+iEmEPxvOPQVvs
	PIhpIjIs=; b=MC3Ojw+8fm50EE+3IwfQ6ohXjKfWE3M0VyhtcCZRL2bvKJAjm/v
	jOOfH33RlqgJAyLYo4GfiNbxywfHQ2yUhFBNf4tZA557D9R0isClCAo9LhGAN8NQ
	rC3mEvIwKMGjVdvwGqDfjRBaD/Tvf1nJqAtmBq7cP+2AV4b8cqNhCXIGvMe0BlTa
	uS+hub26yMI2AUJzyu31pCVxsadIZ4wOw0K2RYLwQ+ZjkzXfAMR4uU6F9euu6UQo
	/UHpxKNKo52jwrxMUIvoqzd+xHIFeX3lnJV7MLYrZK/eUcOKVBz9eVyZD7cVOHTR
	oTmMmnrlpJA4DzCNW6SIM9D28GRxLAYsLHQ==
X-ME-Sender: <xms:30E_aGYw2fb7cxfOkJNAjKqAIVvW3aTV2TAd3kEaPiFcLOdvbzswvQ>
    <xme:30E_aJZb85WsY0EwbnDtqPBI2LBHnZZg2kdX3u3f0gpuHcUt_RdWgZ2lp3DN2Yn0h
    lNRwhsn8LINtndNpQ>
X-ME-Received: <xmr:30E_aA8bj_ZVixSRz0z7aOa3azgWJt1z4Yu79a0ABm-vzrBjOIQWuuIe_w9GEkz_z07k60147ubzN2Bf_3WsMIIcKCedW9lFOJLc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhhfohhrihhjihelke
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:30E_aIpr9cXNAEQ-1bupv_9hY11O7Y1br9ZNd9YJW_mG9wU8oMO8dA>
    <xmx:30E_aBqKmNOsh3GOpwxdL3Boyh5qEOzyNzI6_C0BhWQT-0ZkLsiUOA>
    <xmx:30E_aGTF5IBUXjvmBU8dvBo_ExL7y-0Tz_dmeChNawB9VK4Cw-mQ8Q>
    <xmx:30E_aBp1jY3nARU6nvxR_tQTN3Qs0o59mgrwe7wPImKCs4Q5pxTixg>
    <xmx:4EE_aDC9kYbPwirXrOmfT5j2nzJ-KLt08UY0Ogc_Oc0BOhYH8bqF8VI0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 14:41:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 00/10] t/unit-tests: convert unit-tests to use clar
In-Reply-To: <20250602122559.208780-1-kuforiji98@gmail.com> (Seyi Kuforiji's
	message of "Mon, 2 Jun 2025 13:25:48 +0100")
References: <20250602122559.208780-1-kuforiji98@gmail.com>
Date: Tue, 03 Jun 2025 11:41:34 -0700
Message-ID: <xmqqldq8is69.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Seyi Kuforiji <kuforiji98@gmail.com> writes:

> This small patch series marks the final batch of our existing unit test
> files transitioned to the Clar testing framework. It covers all the
> reftable-related test files, and is part of our ongoing effort to
> standardize our testing framework to enhance its maintainability.
>
> Changes in v3:
>  - some code refactoring based on review, which includes initial creation
>  of reftable helper functions to
>  t/unit-tests/lib-reftable-clar-test.{c,h} files in the initial commit

I guess this is no longer a "small patch series" ;-)

Are we done iterating, or will there be a small and final finishing
touch interation?

No need to rush, as we won't be merging things down to 'master'
until the 2.50 final gets tagged, but preparing a reasonably well
cooked topic in 'next' for the next cycle is always a good idea.

Thanks.
