Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14177AD51
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 00:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730766166; cv=none; b=Cbb/QfCbgymYsvjstFPb278vAOkzhdmU9hQBge8RGWOXnBDHhtDVZLUra99LMfZwxQo/wnTKFHLG5E0A7pKnyfKZDyrJyACqhwEENe9j7Cl3Hz8BNn7shmPgIMlD/dr1LmduZFj8+L1BWSMQDStpy0SlM7+rEAFQlx39P1Gtuis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730766166; c=relaxed/simple;
	bh=p/WUbxTtEuDCKImX8k9XiTJG8YLP/Gi4akMKZ8xkrJk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KbwlXgDnhJ53IM0+ZQTmbcsVNsUeQQnaMJOwqb9TLA5EYOk3nuofg7teJ3pX141nadrrGFPDWeDfvy6+aXbF5kekveLaElHACXCzqCiwoVjr417Sl+Sjv1ULow+k0Hb+Rq8Uf/yybh1NNhDTNCA0qVbZ0EJrUiIN2BmyUR+eCQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FsQx+6GD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Toc/CY0K; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FsQx+6GD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Toc/CY0K"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F056B1140107;
	Mon,  4 Nov 2024 19:22:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 04 Nov 2024 19:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730766162; x=1730852562; bh=rGXgaqerCn
	F1VQvN7ei8FY0jtk34KuBYfQjsi1nI/0A=; b=FsQx+6GDxVG1eekdlE5Dzb7+rt
	szKMbigzrauwMHUX0Df6jeHqiTfQ97wBUQu7oKKCorO7fyg47+zj9Aist5zb27GR
	6A4kvFrR1grnvi1MQRHe4PKcRvQxO7qghLhailbIsG7+H4NrLHo4eI5vy9EfYOCR
	ICMjEKq0S41asSmNKrIuuHlYiHfGm7hhGNjbbGLp7jG38YpZEmb44NKb/dfgTu9c
	CdoDU3a5mKEzdsTwouZHs8CVYGH6xpoF4y6yduOlJcNsTX9TsIqnxiNkDjYKEguD
	oe5mjInP2qMPGJr37pE5LP6319M1RkshsIZ3cbvM8FTFVqLPTANXCyEH83nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730766162; x=1730852562; bh=rGXgaqerCnF1VQvN7ei8FY0jtk34KuBYfQj
	si1nI/0A=; b=Toc/CY0KVC9HMqEbf2kYIR2Om0SyyHwUc9tfGN2ZuDtee0Ag+MQ
	W8HspBCOhNue4zYJXOaK2iZFsOoSCM1be34fHdqcI0U1fsdVTBJQV9kazQ8gpMfc
	f0p+SlwxCD/Y7ce69MUzXhW0oN0WhZtnwaegCrlqnE2FQBbv7TMiFu8LLVLOGN+g
	jUTd2e8qvF9EqOfvcfvAZaDe+C4rj4A+nsAsJdSvv2mH5YZl841IAa2vzwU6rlaL
	Hz/9kyFAiYEPHfyDYiBcCffHWb2tSPgW70P4ujPsVLpqjTtzNfeMi45fvrohrd8B
	IPtc3KONPQIfbjWfgRk1vr6mwd0HwGBCxwg==
X-ME-Sender: <xms:UmUpZ_d4LCS1IfQSykMGHU6Oc-2p2YjCalI8C0At5piMdHJOPfeQqQ>
    <xme:UmUpZ1OHR1m1UtLHXNF918i2iaCLCfcjN7Tk_C9VQ6KAlcNT8x3dMxejrPPVVNHs0
    AAhmu_vjSMAGuxLyw>
X-ME-Received: <xmr:UmUpZ4iI7fhiwTjN6wXxNNoKW4D_SG2rZ7izlmBO3BVwh-zMxLG0Cy1P18djewfPT4wq4SwXscY2BUbNes78T5OuiaVVCZSHCV9b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegtrghlvghsthihohesshgtihgvnhhtihgrrdhorhhgpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:UmUpZw--EHha5p1U-RfdOeUTRKRShZNz1qdUkZTlVucWKX676mJIgg>
    <xmx:UmUpZ7sq-p3yJI2py1mvZ6oM5uJenbA_hY94QAblrYu2bXeKAqztDQ>
    <xmx:UmUpZ_HPMhVv0aG2xJkJrCDe0p-LS3-KY0XhBXApbsb22YssLehV7A>
    <xmx:UmUpZyOhPtAmFoMIbpC9pBhwECUS_iILf3VvuIYH_7gqT0EC1vCKnA>
    <xmx:UmUpZ7LiMO0ZzUg7gPCkoRpswXJasa1LcFyeiSnmRwTLtFnfpMEf5oDZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 19:22:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: git@vger.kernel.org
Subject: Re: git format-patch escaping issues in the patch format
In-Reply-To: <ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org>
	(Christoph Anton Mitterer's message of "Mon, 04 Nov 2024 20:24:14
	+0100")
References: <ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org>
Date: Mon, 04 Nov 2024 16:22:41 -0800
Message-ID: <xmqqttcmv8a6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christoph Anton Mitterer <calestyo@scientia.org> writes:

> There seems unfortunately only little (written) definition of that
> format, git-format-patch(1) merely says it's in UNIX mailbox format
> (which itself is, AFAIK, not really formally defined).
>
>
> Anyway, it seems to turn out, that no escaping is done for the commit
> message in the patch format and that this can cause actual breakage
> with valid commit messages.

Yes, so ...

> Consider the following example:
>    ~/test/foo$ git commit -m "msg1
>    
>    From 0000000000000000000000000000000061603705 Mon Sep 17 00:00:00 2001
>    --

... this falls squarely into "if it hurts, don't do it" category.

A commonly used trick, when you are working on Git and have to
include such a line in the commit log message, e.g., when you
discuss how the output produced by "git log --format=email" looks
like, is to indent such lines in the paragraph you talk about them,
e.g.

    In a format-patch output file, the contents of each commit
    begins with

	From 8f8d6eee531b3fa1a8ef14f169b0cb5035f7a772 Mon Sep 17 00:00:00 2001

    where the string 8f8d... is replaced with the name of the commit
    object the patch was taken from.

