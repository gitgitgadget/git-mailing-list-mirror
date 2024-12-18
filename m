Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EC87080D
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734536393; cv=none; b=MBCiC3vToZDwwKVbjKLra+94eVYvcfIzyoazJ7VHvcUHFk+oc54Hh3OawukEo15KKYRrTNW8tVYSTMoRxLtJEuNOuVUD4d7ZxF5IAHFcbru9XHXa2oVJbHD37kxf4Hv3s7oui6rPzSCPy0XQzs87jWxlbLW7oFxcfxUmL9f95kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734536393; c=relaxed/simple;
	bh=GAFYUwVjePivlhjCq9PBiuv/w7Q1vVQ9DCKiaQhG4nI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rHD4krfAHD1qpWPE0d/0s1Iuj5FxG49vLUqy/ClVXRReMUQoYK2hvpG4fO9qC70GoeSmCpqhPMeF5IIM6ROndCrdYTOHIiA8d8AAH9874l4p4a+9CKjCtf6UsGQcfbuaitJUiyXWfXNO5zhuX35Ggg2Vv5KfNTknU9z0GRns7XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jPDyjpNi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XIInnPHM; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jPDyjpNi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XIInnPHM"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 159EC25401F0;
	Wed, 18 Dec 2024 10:39:51 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 18 Dec 2024 10:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734536390; x=1734622790; bh=UIRrtVLrLI
	RudC/TbUAEVWY49Ub4vErTR7X6DEP2sEw=; b=jPDyjpNipjWuY/g31l0395pMkT
	5IU265Ds7Ca2MNRe/fPoAc7eub/Ln8ty4AU539VUUL+s4g/tnOw/Xa9uRdUrLA5C
	Ee6XZHT1G9ymJSRpbrnS88ZNh5fYKnfgqM5E1AlT7RnYU7hWGg3oHbVnW5cXtPHJ
	krEmiirboJLMa1l8AN8wAhoH4mjITQMmUdXHtdPkwpm8awyMB5sI0Yj0atcfMmXA
	BcIh0W5JxPiQefazmY9poBZvt+d6Nwgl01wMtOlgTTtpv+BNnRhZNKuWRyg9TssF
	rg7gVjaE/DOK36UsymFZJV4YG6oDiTObPp0paaCtSXRkDEhLZMDb0BeR4IgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734536390; x=1734622790; bh=UIRrtVLrLIRudC/TbUAEVWY49Ub4vErTR7X
	6DEP2sEw=; b=XIInnPHMSMh6Ew7eeD5/wK1mCIjS9NCmBsMFdWWKlgRHTVML1ok
	SGRUoWgjGQv2DdJiiebpBuxXjtsRr6h7lFivtWJeJ0Uhdx1N27tCOZYYjtWgg/iR
	c6UElltNdyJf9lidQp9ryfCAUC+fREgNCW4LZyBijNYtb/y42DwWKOk9rO9EB/LH
	nzyDtAw83QYUuoFmQjeYhSSEMiDfg2Z7au19S6zIbY4uo7+Dq3GHqo/P/dKRkFMh
	7l3nZ0S26i90PHH45nPEPHQXS1fhZryc3KZBkFqXjnj/3RekkmeLZLUB/5+mXX3m
	P+mexJBiPEkURcI/1uR4UXzbWdnEqg3fMFg==
X-ME-Sender: <xms:xuxiZzSS_Uel_cdAHX_nn0gXc281gfzSSCDIwEQ5e2gStMNg3H4STQ>
    <xme:xuxiZ0wUOKBD0YnEqaEuEfZ_NsjfPnCy5VigTFQSRlZvZpL6X6iXAE0mCVXc3vxAQ
    W05rAI8dfAA8LWzpw>
X-ME-Received: <xmr:xuxiZ41EjS_57wMDUi7Djnty4NhEy7AIKMRKN65KBfibxJ_3_Gjbhkfp2k5fFqJLr0-APP9Hf95J11g0kwi8G72sYwmlTcO9E18KHg0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleekgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhfuhhnnhhivdefgeesghhmrghilhdrtghomhdprhgtph
    htthhopeguohhrvghmhihlohhvvghruddvfeesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xuxiZzBKnOcMoPRXJ6uxe6Vcz20d99pzlIuaLbmE_cxNv1vDPtVO5A>
    <xmx:xuxiZ8h6tkjfJIAkLgjaDIWpmlIEpa8Ahg-YnYDlwniSBw7MNojC8A>
    <xmx:xuxiZ3qTSAl9EALPDfE05i5NXuiDq48gBNZZsxN74KhLRoHnm13zqQ>
    <xmx:xuxiZ3j4e1uvcZuB4ar3vdL4PelMSkeHzr1Z29odnib17DRiNoAFmg>
    <xmx:xuxiZ2akSAXwmcTT9Nh5StGZareGqPsAIrkgBanAX2dM_LmrwlIvAszy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Dec 2024 10:39:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  AreaZR <gfunni234@gmail.com>,  Seija Kijin
 <doremylover123@gmail.com>
Subject: Re: [PATCH v4] git: replace greater-than and less-than checks with
 one not equal check
In-Reply-To: <pull.1432.v4.git.git.1734489859673.gitgitgadget@gmail.com>
	(AreaZR via GitGitGadget's message of "Wed, 18 Dec 2024 02:44:19
	+0000")
References: <pull.1432.v3.git.git.1734483016515.gitgitgadget@gmail.com>
	<pull.1432.v4.git.git.1734489859673.gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 07:39:49 -0800
Message-ID: <xmqqjzbxt2yi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"AreaZR via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  	if (top_index[0] == htonl(PACK_IDX_SIGNATURE)) {
>  		version = ntohl(top_index[1]);
> -		if (version < 2 || version > 2)
> +		if (version != 2)
>  			die("unknown index version");

I am of two minds.  If the code never evolves and we will never
support anything other than version #2, your rewrite certainly makes
it easier to read.  On the other hand, if we plan to ever learn to
grok versions #3 and later, the original would be easier to se what
is going on, i.e.

		if (version < VERSION_LB || VERSION_UB < version)
			die("version out of bounds");

and the code as written happens to have "2" as both lower- and
upper-bound.

Of course when we do introduce version #3, this line must be updated
anyway, but the final form would be as we have it with the second
"2" replaced with "3", so leaving it in the current shape may be
easier for the developer doing that work.

So I do not know if the proposed change is an improvement for the
longer term.
