Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B83283129
	for <git@vger.kernel.org>; Wed,  7 May 2025 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638487; cv=none; b=EIkSPPU4AcnPNM0h3ciNxeeUR5HRe3/dSVKte6VMmlDez79Ku2WKYI90UtcrcWVyBCNW9rgvWOQldBgg5/jLudFlbj4ABBU466k+a0UgQmztKe4RHZcsY2K0CifxcLx0ivHvXegfldkUuxbIl8pbXUdrOxXJtWNjk11wl48aCRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638487; c=relaxed/simple;
	bh=edBd5EN5dzb+t7BID0zBGaOlUUKw5o5xuFPt/PoDnpk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=isx2nR2NI75iDfV0QFMzap02TmPVUaBLWT9GFa15AnHEX6U7cUNUOjrwJio+ez78ljrj3ffIoQcq9JjxDYFujE+qzL4bf4qOViwFbpX4g4kwJC03Eghz4H5+1/tNYSVhKgybf6Daw+UyAOset+/1F0hwZDLVfYFfKBvdZ+6i6ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gqrDAaht; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ulG8e8Yi; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gqrDAaht";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ulG8e8Yi"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B22651140173;
	Wed,  7 May 2025 13:21:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 07 May 2025 13:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746638484; x=1746724884; bh=x/PLSdX1bp
	AaLys7V2zbCNarGCo2QN4jx30WuteUNps=; b=gqrDAahtcmMwAJ+TZkDnIyH5+T
	wRauwDNtHIXJoKltYw9iW79sxXKJX/TJF/EKzguGbTsF6MVL9zW6JpfRv7CMLAQs
	BTj7S5xaVrUr2Le/FYdybRmdG6vQpnhVg8T7Q0IUz/hC3NxykIXHv8iZzabgN+MM
	mVb4eJLPkhksVHF2ntjLsYloMmDeFsNAdLST8UoI2oTWvNjh+GtKHdU7QD7IDPmL
	Tc5UGmMBuBOS0chPNKpQrWC1mYkYdwmzh8xzIPdKJq6eItE+iuDziAHB2qLOsUxc
	xIuNWd5xmtRDaLTPmrZyPxSVGEZBMpCdm639cHI2eY8yScPjL7Wb7BNsnTmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746638484; x=1746724884; bh=x/PLSdX1bpAaLys7V2zbCNarGCo2QN4jx30
	WuteUNps=; b=ulG8e8YiMmZ7W7QonkOJg5y+QgqSuXuuAdna4gm4sg6G2hmWUZ5
	RSADaXpUctXCi33hbYHXNd5ObISLh08maMGWW2YJUo2GGWeGcqTtkhPoVgJuHDM8
	iH4PTPczqVbbw7QbAaHQIV1bOJQj3VArbNzNhQgN/O2G9PsTWUKkFG5kmrVBczVP
	8XcYT7p5n5BDaq2SITr1UxnzuuMvm/TVelwBCSmMmkakcaY4iUJcutnBd5IAwiqA
	weCLWMjOq1Suvpt4LZuTgxKQ+279jwNZx4ubE9A41aJcEK7q/sZLPk1xBXotSl5X
	EOpw8+ol9NBZ4yu7nTALhFVWZm3bYy/mlXA==
X-ME-Sender: <xms:lJYbaCBlXGpIOy935Au84reXlGTK8de24bUultKaw26y_om5JYKgYA>
    <xme:lJYbaMjqp42SHm3s0rDBB5sWF1hLRfTbZt9P5Dyl-JyzlUyId9F6_DJUqXiRggCT1
    jmXE-wVeEzUq9u34A>
X-ME-Received: <xmr:lJYbaFn_LgVdTy-GSTJyV8ixO83vRopQlyP-Lkcrc14HKTumQe4mVlC0NKWtVcLMlWrLgPatMuTFZx3PrZnlT69QbW6jOiFskrQq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:lJYbaAwbXEcceoQ-Kgl5qlPKv6NBaayjMBpwf36FEJdsbeZCVO_ONA>
    <xmx:lJYbaHQQ2LVAX1l7jTfFwQm3l-IV6NW3YeHARD08okT0XT-TYqVnzQ>
    <xmx:lJYbaLbVnc9ejf2v7l7YX2qtCkcEnUAhnQwUglRaZlaQ5N2XL6UNpg>
    <xmx:lJYbaAQUm36HWBAjPbzDn0L_qMNAhDNI1PERUhy8mjaHckijnlSa1w>
    <xmx:lJYbaMDe4a_HYkG-xxteXDwddqTMXSYHSJmEv9NXAzUUmY8Cv0RIjaJL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 13:21:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/10] contrib: remove "remotes2config.sh"
In-Reply-To: <aBr9VuYurCCvRYnj@pks.im> (Patrick Steinhardt's message of "Wed,
	7 May 2025 08:27:34 +0200")
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
	<20250506-pks-contrib-spring-cleanup-v1-1-e6d5ddd79a72@pks.im>
	<xmqqr011ikjc.fsf@gitster.g> <aBr9VuYurCCvRYnj@pks.im>
Date: Wed, 07 May 2025 10:21:23 -0700
Message-ID: <xmqq1pt0e3qk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> the deprecation notice we have created explicitly tells users to use
> `git remote rename`:

Good.  Then let's do this together with others that we can do
immediately.

Thanks.

> All of this reasoning should of course go into the commit message.
