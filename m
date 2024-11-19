Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744B811CA0
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 00:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731977055; cv=none; b=Zp6LqdRaIVJIoRbjqi3DBZxWHBMIMKqak/MhxhOuPMyPr+9/nuIibAfxEnVnIu69p8C1oa+Zvtan8Hupk2rILQsXA+Vk4OBySzSOhnGaw03XsvLe3PhTFL4r4hMCEjoWN0YvPNNV/Tsp4aBlSQhphBbv2RrwkpUMoMvDVXfbsvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731977055; c=relaxed/simple;
	bh=yTf2xmvh+UjE0N0LE+tc4Gg8yNXwsc0fFt3T0aBpYnA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pNfibXjpGBVr1JaFrJ6xsPG9k4AkNutnW4Y/NCY3BESJBfWtaHowYu70etuvQ4wDrYEV7anBapWjlgLrIAyfPow6iIg8mMXIVQN+V7aWfLkYVKhqg0IJMXr5Rt8fmBZOnB+d7jok0WpSoAcmdTfkRN8LZM/jUCulTpcDMTr+B3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l9iTsQyo; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l9iTsQyo"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 760FF1140196;
	Mon, 18 Nov 2024 19:44:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 18 Nov 2024 19:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731977052; x=1732063452; bh=OtcdYe/BF0Mr9JPDY1cQhe2Si4viguxyWbS
	w7q4SFCk=; b=l9iTsQyobcZJA/+vK8PIb6IaBu9BA79D2TjteKRScfAcsXetCIu
	53bcy5/ac4UUlHsA2v6YV2XEH/eEo1k3itg8e+3K4bMxIo1FiBCTV+uxfbpQpVho
	PZsghnP9NSeP2vX4ehCGX3VZieoZ9oGSVJKVPALdjA0OXH4dNroNwaQZmCfEbxPK
	q/HMqunKVcjnrP81DxTAuW+k53VxPd/2V35CZc9yrebCjlD/38vJlqH3EtSvOfDI
	XGLFAnyjA4YooXqFOindwiFbBNmPmtQ3RtAALAWjXueEE7tPgANtm+0T6BRud+op
	TnIjPKvbE9wZjj1nl2tRN1f/id/XL9VuBWQ==
X-ME-Sender: <xms:XN87Z3MmVQzAvIeYkcisr88Tzq0uGytDIhVD2LIpVKnpB2mqObEndA>
    <xme:XN87Zx_NxjTG69eZDglUXDhP_NEPJMxwbt_tz99CwZNznmv8pxMoE9RPsEErS3SK5
    9KoHD7rIDI6NSZylA>
X-ME-Received: <xmr:XN87Z2SI4waxtR1A2BOPCSERsPIKmvk19P8Dyk8OTLJc4STZRSgdXSH3cx-d1eUM-5wTNoNMoiIgiUE7ML_WjnNhv17677vGWYFe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedugddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XN87Z7tWfhSs7zGfVNWGDBfi-TNOINTVF1gTyyFv-aieDzE2t_FfCg>
    <xmx:XN87Z_ezXpY3ulGk6ew9YCSh6cB782eS-WsRUHonpjSFFVtsta4RXw>
    <xmx:XN87Z30mnbZggTHombwlXntCuxTc-4XTevu_vcPVffrSaXHN9IqFag>
    <xmx:XN87Z79CV0Wd4XN_iHzqZJoBdnaEPVS6hLnZaKPMICut9rIwwDMyFg>
    <xmx:XN87Z27KQL6kYh0qszJetKDb9HWPGo6gipd4J7AhIEi3PxxWB5qI0B5r>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 19:44:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] fast-import: avoid making replace refs point to
 themselves
In-Reply-To: <pull.1824.v2.git.1731968389590.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Mon, 18 Nov 2024 22:19:49
	+0000")
References: <pull.1824.git.1731610074707.gitgitgadget@gmail.com>
	<pull.1824.v2.git.1731968389590.gitgitgadget@gmail.com>
Date: Tue, 19 Nov 2024 09:44:10 +0900
Message-ID: <xmqq8qtghx2d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +		grep "Dropping.*since it would point to itself" msgs &&
> +		git show-ref >refs &&
> +		! grep refs/replace refs

"test_grep !" may make a failure case easier to diagnose.

Other than that, looking good.

Thanks, will queue.
