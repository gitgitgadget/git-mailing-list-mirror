Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F698BEC
	for <git@vger.kernel.org>; Sun, 27 Jul 2025 00:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753574446; cv=none; b=Vsin7kArbdvo5yC6TryWBDFVgHLdoOBe5FF4kedpZ2IsvgUe1Dc6p3fS/yBqCfIpuRVrHK5RP96w6C01SSLOIV3tjFDjit3E7mTivfwTL7dXEiJ2HyyY+ufgvW7H8hQnSxL/0ouyzTXVY3OIT0cnBaFnGyTZHQseM7fToMxni6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753574446; c=relaxed/simple;
	bh=7LJ3JoMWSD8CFpZd2dK6hAw0+ZwcMomM++Dq2YIOF8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ObnM5KQWQPIB/2Ann85y//W5PXi/m8D+7Lzm0Tk2++gISFBUmzRcWfxj+ZMHg2fCA59TXNCy9ZvamRzDaPi4L9mqSJ33E+k37OBA1bJn2E1ybrFoiGw+H7ZAUBLaKF1ToPhrB+n6aV0RUctnTPbjl0SdrNvwzediHySlxQ0ugFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=haRLVLQK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BtEEZAhP; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="haRLVLQK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BtEEZAhP"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 0D7291D00CE5;
	Sat, 26 Jul 2025 20:00:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 26 Jul 2025 20:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753574442; x=1753660842; bh=7LJ3JoMWSD
	8CFpZd2dK6hAw0+ZwcMomM++Dq2YIOF8E=; b=haRLVLQK2OgYxOh4pJCieM/bvw
	A65mGXyNE4G6VAAgLvS99tklpGagXaaRbwT83n1ohkBjKsuul/gVxA4GWUmMJn+8
	cubzQWNzdc71I5+Q78psjxF3FiJVoEPc0f6tK/hgcb3XHpP9fsa1PzCcyH/IfYZ6
	V190xebBXmuSliS8lA71YhNjfirAPI54ODAOV4CnwZEBZVHz/wE5AUvIkZKDYfiy
	QGBbI0NTVxrUKc5tl/AMGPaC5iqkGdNfIscTaOAWH4lKGK7LlXlJPqBKVgHxEOdx
	uctzfmxft7zSmpDVJDMv0Y/nTUiBEZNzbe0l8spqbrzMg7CLXDHY5sq3IB3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753574442; x=1753660842; bh=7LJ3JoMWSD8CFpZd2dK6hAw0+ZwcMomM++D
	q2YIOF8E=; b=BtEEZAhPu1GwzZXKWdjAsxVd3xCchFItFdLRF0r0aa8sFgrJL7f
	06MIqU2Z+UglS0XReh7J4TIpV1KxSUpBNrndINFiBX5TAu0oARqYu+wg7kjUcJQT
	LZMPN44CzpjnHNg4HLL23uPLgnJ3mqyCPfcDAx6JxA79uys2IgI/aHS/KwVTQX1I
	f7m2KooxwYybAM+XI+GYDGUr6LDZtvqP7t/mQ1bBsKrmxJZABQUUWUFKukVhTzo3
	csuPOVsyWjFrqYXKVhHddUaF+VZY92mrkKIp7pyvDhINaL61TjN9R1uVSU43MlTw
	WZQfRSpNusV4dsjbr/fN+2YRAGppinqKHzA==
X-ME-Sender: <xms:KmyFaKgZdapEtVJ7TmLVM3SR2vB9acXfLLH4AicyNwQNSYatry_1PQ>
    <xme:KmyFaFnqso1OznYAN3KA_yyKkvhMh3NtoGtBDwa_Xpy1IQPO-hKhudSTSzoInL6b_
    IEwgQ1dJlUB-MsVWQ>
X-ME-Received: <xmr:KmyFaOrL5SSKsdTT85fTQieW7IlLayn25uFmaeYAXI-AMbuP5tG8MVqB_qlohpVmpredzyNEWZ00dryL9pzZDuy5dwSUBlVjB5xHBxU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekjeektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KmyFaGFEBcBf1pv8cqzr-MAWMyC14UEzDW0G2cs97cohf19PC4E-0w>
    <xmx:KmyFaCyRr_PqQrUY4f60LmVXkN5xcpGtTr1dUaz9ETXQxEZ0I1CeIg>
    <xmx:KmyFaDprqQIKq54LhT1s5jFblNRxSXZlIx4JIk3CJqlxcTfEkmoBiw>
    <xmx:KmyFaEiqHZlLIS1Bkh5s5gJceFJ5Z_Yno8RWMe61gtBw2vwm4pIRag>
    <xmx:KmyFaDRCybHTRoTGZkXalnz18X7x3GN7Lz0W587JSxRuAbnjCeAEb1OP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Jul 2025 20:00:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2025, #07; Thu, 24)
In-Reply-To: <CALnO6CD58LMgGgxGF1DRheeFe-E9zRwAKG=-qsUO=kDB-gTdeg@mail.gmail.com>
	(D. Ben Knoble's message of "Sat, 26 Jul 2025 09:00:26 -0400")
References: <xmqq34alik2g.fsf@gitster.g>
	<CAPSxiM9Udi2PxpT7f8DdLn1ihny2gW_H=ieLjV25sEFYSdAjMQ@mail.gmail.com>
	<CALnO6CD58LMgGgxGF1DRheeFe-E9zRwAKG=-qsUO=kDB-gTdeg@mail.gmail.com>
Date: Sat, 26 Jul 2025 17:00:40 -0700
Message-ID: <xmqq5xfe1p07.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> Is there something that needs to be done here ?
>
> I would interpret "introduce a few 'todo passed' when merged to
> 'seen'" to mean that a few test_expect_failure's are now passing and
> need updating.

Thanks for helping.
