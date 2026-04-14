Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907952D7393
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188944; cv=none; b=pEh8XYSkIAlsh44oUZAkaN11ssOpiUf+mN9j+00f/K/y28OTWidn6U3V4Q7Q6qCldkFl+xXMJmdBzrtuYEcZuZdpqaZdWCeuFoJ2wN3OwInwPIylhNCnGrwmqT1GRnppIve8Aa08aDC6g/nDw6/3Q0uEq9pvTyeiKNWkRXneSaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188944; c=relaxed/simple;
	bh=9ixr/H5zX0NG1UGPyZFWH0/JNbn/JC9o3nsVfMEzBtw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XTrNyY9UP5us0J7b7qBfF07HbttffYVs1trtHPAgvWKN+QwTl/6eXW/ooVxZnqZW1Hu6nv5iM5CXWRG9bvZ4uofOFOlGIY8jOd1ZwTnw87MTuWY7eJYpiKzlVZXWumrGSmPqxGF/flC+ZJOgOMG45q1QVRXg3xuS8924I+ulOw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R15O72G0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yhy7qOOb; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R15O72G0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yhy7qOOb"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4ED1B7A011E;
	Tue, 14 Apr 2026 13:49:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 14 Apr 2026 13:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776188942; x=1776275342; bh=M4N2qg84nh
	lvBQAum4xiAIFLZ7qMuJHg5I/wyyeAwVc=; b=R15O72G0AuLiUZjA7635EzzHAp
	5GjP2XKzqq9p2BjjLJKTtnz393RzOruej6okk7NS4lTsgpjNJG5MiYrgqcawspPA
	NyNiAPsje2SkGejyfvAGYyK13nkxn4IgYP0Qo2FGh59DZ9ntbaPJGeygu8Z/p4Gq
	PcOtxQUn8mamTU8fVfEnrQIaqNHy5tJCxrGsTmy9OdxRcaa77dRPClHtIkfkks/6
	PNxyagvVg3GwbdlZpn8LNEK7orImD2blcEqEQrk6jgYW1D/wCdANpGg/Vt48v6JR
	OM7VUmCl78s6dMWRHNbTkIHMjX7jvyXDFDPatxZOEURT4zwydUwzqJgTp/wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776188942; x=1776275342; bh=M4N2qg84nhlvBQAum4xiAIFLZ7qMuJHg5I/
	wyyeAwVc=; b=Yhy7qOObbbZ3H5eJ/4B1M1iI1gjnMVfATYlXM1nxbJNtTYT38sp
	iVCxrc3SHcuizMIJau8eUIClKFbjLxXSyrPOMgBj/9jQAoE8a7ExPTNsxXVWRLgJ
	fBIzw0ts2zpeQZGK1WwrmeQFZq3Ld1JRvOs+99UOfLxTrlMNJcqY9nhA/XflbG7C
	lGJRAhoRiuC+ZbalugFDQQ1NClPDb56gzaCy6G7wjbNj6otztSKLYuNogPR378uo
	e/23LQq7dTR1exQOivNikpZoL16aLSzbiTNhl9szUazBbAIVcfu+oifn7oHLbejl
	VPrVwJDNwUILY1GrWk29LqDoAJ00SpMdlnA==
X-ME-Sender: <xms:Dn7eaSQG7eTF6QSFg_jksgcBHAFKyWeVS8iv06Aib4sTAY70vRGMPQ>
    <xme:Dn7eafPscf_V1oLlmHRDrHh7he4b2U87YY3S1XJ197Uo0epn6ltD1diNsuGw9XQz_
    8bubo-EY8j1IBuUUsRgMZlbuYlwFVh4MPkn4U3QRLyZtWRB150P>
X-ME-Received: <xmr:Dn7eadM95nyg5dq5rm-3B6jKFtxKYQI41iHr-mjnGGEpJRccrJDBJ_L-5WaT2mTUjYAydlyGDK7XEHDJu4B1Rym826pDK02p5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:Dn7eaXto4uptyCvq7iuZUw1G-wzEeA6FvxjKn18rYE4rAclFg7Ej5w>
    <xmx:Dn7eafV5CtIMmtc5CdKlxvl8RVNTJ1k6yHCKbog05LUlrTgAivMBVw>
    <xmx:Dn7eaXuMdcYBi3omX283zjgIePdd4Ms0qwo0673yohU6STY1WfGpHw>
    <xmx:Dn7eaTVcerVrSLjPc-KorAaxGp0nvvFRnsYfmww9TEcGuHUCj83Tqw>
    <xmx:Dn7eaXXQHV5YZNMhZ_LoSqNsudsM3q7MXJ0nlgOKtDeSnXFcM7-E--Zx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 13:49:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/12] t: prepare `test_match_signal ()` calls for `set -e`
In-Reply-To: <ad3rbjDYad8rTybG@pks.im> (Patrick Steinhardt's message of "Tue,
	14 Apr 2026 09:23:26 +0200")
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
	<20260413-b4-pks-tests-with-set-e-v1-1-5b83763a0e84@pks.im>
	<xmqqldeqkesa.fsf@gitster.g> <ad3rbjDYad8rTybG@pks.im>
Date: Tue, 14 Apr 2026 10:49:00 -0700
Message-ID: <xmqqtstda0vn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> How about the below patch? It's a mouthful, but the intent is quite
> explicit and it's overall not too bad, if you ask me.
>
>  test_expect_success !MINGW 'a constipated git dies with SIGPIPE' '
> -	OUT=$( ((large_git || echo $? 1>&3) | :) 3>&1 ) &&
> +	OUT=$( ((large_git && echo 0 1>&3 || echo $? 1>&3) | :) 3>&1 ) &&

Ah, I like it slightly better than "st=0; large_git || st=$?"
pattern, but yes, it is mouthful.
