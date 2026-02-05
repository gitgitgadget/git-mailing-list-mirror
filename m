Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B616432ABCD
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 20:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770324862; cv=none; b=hqeG8eIbSQRzEf7oTDbgcxHx1W+xyrMSWnOe8B1dY7fI6lgY13Yg0b60zFlOiMsO7oVrSn6HAHopElsVdOY5NUPT00SpC46v/D49FW5s08otRS9NK2S3F1dlpomuQT1FKCeKOOFB4Ebygl6kSZKnZOJPwFnlZEcBfLPqQXHJw68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770324862; c=relaxed/simple;
	bh=z7DVlee3pl2y6HGsckoeb6FeXZxMj2jV0U0ZYO5P85k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QILQ8JZFbzAPQ234aUu7zGHkxYrGr7s5nGi8oKb8acbCE7UmC1KWpNu4srW17U26mv33UjsRZd4YUDp50NErqXYLPRO3j29jAx/nGEvdqrmX67MbHMN1/33M2Wmi1CmyPJbWCgvQjlkSAUwxyxYW1S60pe5FQZAqEFxSj6tgCFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zR3zHdjg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TH3uKj3I; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zR3zHdjg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TH3uKj3I"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E5B83140000F;
	Thu,  5 Feb 2026 15:54:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 05 Feb 2026 15:54:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770324860; x=1770411260; bh=nyN3gOWBzP
	xuUy8dkU51KwHAuOcEldCUCN3Y6cypUJ4=; b=zR3zHdjgkdnvuNHdNZPw1co5JU
	YTVm59LNq5rVhTPwbGbVhtHFybsTwup/JBNhAIXPqeP6YXYlrH2SmjT6hrRqxtII
	1pAnrv68Qr2Z38hMTA9md5CjmEKlcLrcvR+gf32/bAjd4/LJwIAoPL0Ta4jq8Jv8
	DEivRgE+wXYGdN8rveu82Dy74xS2Etm6lqOGF45Rb64wTAoKJGZa3Im1HeLHR4xc
	JCh9ppribAM0KO0zOWcLP6kOcsejyVqv73BTQwWqSDb13ueB1bcKLI1ytwgbnxdH
	YLjilTQjklZkBgV/fvOSUkK+FrQNuHOkGinJeV7KxhHxO/JBzCBHmOtVrmzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770324860; x=1770411260; bh=nyN3gOWBzPxuUy8dkU51KwHAuOcEldCUCN3
	Y6cypUJ4=; b=TH3uKj3ICYMAqsam/dWrk+ER3aQhQpQll0mkVPH/EueUQOgEdXr
	b2KnicN6a+8o+RYadtnyRXbXckiF3JwI0ZELLrUAY20RaFqOx6JdXK1mQXEBke2+
	cnV37jG2o3baZsIToQHimnuKK/BggpTeFf/5bdWnBDKAbAwgfJ2SsTJ+TEI32YqT
	RgKzuPcSRB501ZuhUwxidbCUw1YFpwFJrUadaRS6xdeCalRpvNwr6WpJFRMuW87U
	XVvlHsDpI9RSY2ijmhqMeyhkecoq6WnMiPFzlQkX51ll67ryIQqQ2ruUC6gGZs/9
	mg+ubL35vn7XaqkUfRMigHbo5zclnv9WT8Q==
X-ME-Sender: <xms:fAOFaatAzGogL3hVurrGL6hK4cZv4ZT7zbl7q5i-Jri84C4BBD5sPw>
    <xme:fAOFaTJsJtqNw1vRdBcCz37BNqaQiDmt0ZWa9uXdsRlxK6KzPYdaHG0U_rDKv1_DC
    eX1n1QD7runV1OmIz2Xq326BrIyUNnG7Pavwc-bgIZLgjZtREtOUQ>
X-ME-Received: <xmr:fAOFaflXbMqbsYM9PU1KE28eI5coCKShVtSyeFcCoSmHJyQmQA5DqkwVz-dWndAjS8M33wGia_6TeCbtOdiBN29DxG7HzuOF0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeifeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrsh
    hkodhgihhtsehhohifughoihdrlhgrnhgupdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepph
    grthhrihhksehpshhpughfkhhithdrtghomhdprhgtphhtthhopegruggrmhesughinhif
    ohhoughivgdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:fAOFacKapHJVFdD1Ah6a7Sz0mqfR6yhDsG7LRX5RObkeJX3Y1JDQeA>
    <xmx:fAOFac7_bQDuPc0O_j5bEIxFoY0zfcK4tIzKCL1pPO5pfTZS4qCa6Q>
    <xmx:fAOFaY0dwQf_Ve4IQjtW4SBcMKcuuyZ8bOe7KfQTWj6X1PwuN3h-0Q>
    <xmx:fAOFaae5yl_oGVSUJOrgEQM6WKt45JcGyhDVnXmY2I5K_c8JPaCIVw>
    <xmx:fAOFaZp7kjZU5uOe0PTq8gYEdB1OnqgRlQmAZJQgtzpuxrT00oD2JS5r>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 15:54:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Colin Stagner <ask+git@howdoi.land>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Patrik
 Weiskircher <patrik@pspdfkit.com>,  Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: Re* [RFH] adding test coverage for contrib/ in CI jobs
In-Reply-To: <xmqqikcbm9ew.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	05 Feb 2026 08:39:51 -0800")
References: <xmqqh5smdejc.fsf@gitster.g>
	<20260115175403.3971-3-pushkarkumarsingh1970@gmail.com>
	<7k7ewvrb5hj3jyesiigy6dvo5w5pl67rk7ihztsuxbtqpymafv@ey64nvhzhacg>
	<xmqqjywuyhu9.fsf@gitster.g> <xmqqsebhu9nn.fsf_-_@gitster.g>
	<xmqqjywtu58j.fsf_-_@gitster.g>
	<ef128e1d-dd3e-4573-bfcd-6a98a0a1f394@howdoi.land>
	<xmqqikcbm9ew.fsf@gitster.g>
Date: Thu, 05 Feb 2026 12:54:19 -0800
Message-ID: <xmqq4inulxms.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Colin Stagner <ask+git@howdoi.land> writes:
> ...
>> At least some of the subtree failures on linux-reftable, such as
>>
>> <https://github.com/git/git/actions/runs/21617099884/job/62298228602#step:10:421>
>>
>> are actually due to a bug in ubuntu:rolling's "dirname" implementation. 
>
> Ahh, rust bites again?
>
> Is there /etc/alternatives/dirname like /etc/alternatives/sudo that
> we used in fddb4842 (ci: fix broken jobs on Ubuntu 25.10 caused by
> switch to sudo-rs(1), 2025-10-10) to work a breakage around, I have
> to wonder...

So I tried a custom CI run that has

 * a temporary patch that demotes ubuntu:rolling to ubuntu:latest in
   GitHub workflows

 * your subtree test fix to use the hardcoded 'main'

 * a similar fix for diff-highlight test <xmqq7bstsemv.fsf@gitster.g>

 * a change to run "make test" in contrib/* directories <xmqqjywuyhu9.fsf@gitster.g>

on top of 'master'.  Everything seems to be happy.      

https://github.com/git/git/actions/runs/21726017981

