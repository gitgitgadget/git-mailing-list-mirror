Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249C213C8EA
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 20:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741379149; cv=none; b=U6UHFGNOWCgmMleP6z5BUWp5dpNXiTpq3TSyku4+WFu4+W5ksZ1+7noDjXVxlB+V8UbxgVGalihdUZ3HV62hmaP0DxnbVAWBvSMo/B3sf/x4GVX1h/vWlSGN2TpCn16VmsrqrJcmOCUANDu9LCB5HwgNBuKG9jz1VKJt5gJkyT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741379149; c=relaxed/simple;
	bh=LQK/NCKNWC9eAm8ZzsLXFqct4YkfHZWDFgC6q5pX8J0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QxSJUs1xnvABcP7eEp10SnyGedG6+O2dzDxLtpEpQO+2BhtOHlLSktEOP94bGFi+V1CrVGnAv46I+YTkzcs1dkjXi+HGAQd6Vl+R0ln3ioVy4hrJtb+kpSClH7bTMZuFiaWhc6lVTfh+F8Uv6Mu7KRil++15kA5x962TvML3B0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QBSYxJIf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lyvt+gxd; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QBSYxJIf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lyvt+gxd"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4A99D2540200;
	Fri,  7 Mar 2025 15:25:47 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 07 Mar 2025 15:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741379147; x=1741465547; bh=JcaShhrxdS
	yp/wMNn/e3oDP8wkjeaAiax43oYkplVqA=; b=QBSYxJIfzjy2s5j1T0sncDpTyz
	Cv+zomHknQg0htugdkbk6EKuW4BdbzC67un9169PWq9s9fc8mLhZAWVe8wk3HSyW
	9Kp9UUu3SHloPbRnBBhdVHHcMByw6wfdnAKS8gK/EIKXWQlv10vWZyEE+2+S5teQ
	grakLA7FALdvWYitXQHxcs7HM49znnyKOtW1SsuVhZOzpA4E/OAXxiQcTUKBhNOy
	VLdycQxGfq1bne4XwyGnX71lrMpJGeHJbPplUV8J5AeP5G8DtVHnJXBv18mivEiQ
	gQA7Y+0iZ2iS8+cXaA4+81cmP/A9sZLkmE72Wetq/VPJoo7jz+Jxl4t4wWmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741379147; x=1741465547; bh=JcaShhrxdSyp/wMNn/e3oDP8wkjeaAiax43
	oYkplVqA=; b=Lyvt+gxdndcayA1to8c7NK5ZKtu1cEDJv5s5Yhlz+eusSrHIzTH
	H65eOBXN2llqoQRIUmva5uuPtKymgGszmqGckyrtGth+cjcyY8+lOv4gqZ9F2Rd+
	ofTxRsTAqecu/A7bkf6JBbUd635N6gbH2a13o56zgPCBFP9cvhJynwVpv1DiO4h5
	kFuCPs7BVbLqe82mLIxGpSkPiAbFLcwZiWp88ZsXgOH4PCGJtAQeEaV1DY3lWAUs
	RT2LnYKsQhhkyCHh44XJ6BxuZNYYuUA/0w1d6CSAFb+WKxfpOc832fPxaGNMjpwU
	WZONv/DIiACeqlMzVvblQ/uA8DyukoqlVwA==
X-ME-Sender: <xms:SlbLZxfdcC5z01UrR14rFt3hbKxrWX4MCEIYpMyuANll2VWU1wdJIg>
    <xme:SlbLZ_Po2jc7QrzAzoe37NuGv3uW2Pk6k1wAlN4q7G-4-1o9OjnFvP8EElY1yOIkx
    AUZJfV8QdT99aN_Bw>
X-ME-Received: <xmr:SlbLZ6jZ4-ZRrBBttlj4YVRqRzJDOvTH0SjTfUAhLw81WdJKLdVlODgkO6n0nx_XsNjkmnjqm8yvoWhR47sydQm_zdep7Dz9DDg_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:SlbLZ68IVKAPtrPCixCBpwUqRigsIsHH3MHySLFWvN36TwIBxJfsyw>
    <xmx:SlbLZ9uwLMPJkHL5AxZ3r0ZRXmuP1t0hZVFC7XdUEo0L8KJf7URuvQ>
    <xmx:SlbLZ5GrtrXG6Wv4fPJ_4We3leGFaKr0uhC1vF7uNYKrapGqnBX52g>
    <xmx:SlbLZ0PkNNcTdq9TATQdXbbc5GLP-TJb0rUtZb092A6nMpQ8tHWjJA>
    <xmx:S1bLZ3KYN4fUnDqwsNsj3wWvAXaHBvzBjJxNLNJRmcL4Fjm-3ukn9LRH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 15:25:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org
Subject: Re: [PATCH 0/2] Ensure zlib version is printed by git-version(1)
In-Reply-To: <Z8sAwLHff3S4jF1P@pks.im> (Patrick Steinhardt's message of "Fri,
	7 Mar 2025 15:20:48 +0100")
References: <20250307-toon-zlib-git-version-v1-0-5e8069752bb9@iotcl.com>
	<Z8sAwLHff3S4jF1P@pks.im>
Date: Fri, 07 Mar 2025 12:25:45 -0800
Message-ID: <xmqq7c50egfq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Mar 07, 2025 at 03:18:06PM +0100, Toon Claes wrote:
>> I was trying to benchmark the difference between using zlib and zlib-ng.
>> To be sure I was testing the correct version, I was interested if
>> git-version(1) would tell which zlib library it uses. After some digging
>> I saw it should be printing the zlib version number, but on my machine
>> it wasn't.
>> 
>> I discovered a regression caused by 41f1a8435a (git-compat-util: move
>> include of "compat/zlib.h" into "git-zlib.h", 2025-01-28). In the first
>> commit I'm addressing that regression.
>> 
>> But I've noticed building against zlib-ng directly still didn't print
>> the zlib version. This issue is resolved in the second commit.
>
> I've already reviewed the change internally and it looked obviously good
> to me. Thanks for finding, fixing and improving this!

Thanks, both.  The changes look quite sensible.
