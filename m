Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F983128B7
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762800039; cv=none; b=Wd+jxQJcRRfG2rGZJuGT9E/J4ZAvIHTY8s4whXg22KifthRWOZ+Z3k7O5pPTgRQb22FC96G8uZxmA0imr1T1+EoWoIwd5xbBVsRLEqVZMsR1M5AB0N/u+b4bEEfoHHCKCn0KaenOswEosj/zCA0Nth1/Cvj8o539hmIJajuUp0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762800039; c=relaxed/simple;
	bh=BOzn1ePOLCqkxzUCQXGVrIyp7iPgjWRef/kaX+iPjpg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u6+9E6i/8LqsF4AK9qUBhlTGvnpS+2hc4GzdT/f1mlVXUUlNNcJzy2r4XTszl8IXB9EaswMep9NhM0BJ89xqNtM+G2jTSj9C62h0nX0GFV3nl4HSAHP+KjimcTBjMwfGiKMtQr8aj3rvI2hNabGAQz9xxORZdM2Ad8LHW2lAB6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PhjwhyVq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZktwNfHW; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PhjwhyVq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZktwNfHW"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id C1738EC1ED6;
	Mon, 10 Nov 2025 13:40:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 10 Nov 2025 13:40:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762800036; x=1762886436; bh=gAjZ5bffka
	/mn2icT9lILRE85lxCJu/K+oLfWGghLsU=; b=PhjwhyVqN7uk7qiWrRtr0A/lnV
	7gvPMrq8QXVmpOmY3HW82zyg5THDuOB8p0JDASZBg0/xfpzGO8fofNIJ9zeh406f
	XXInjfl5cMlaWmNF46HSIJUyLzaMKBlYwZ+CRCPmlGo8xgVHogWIPalE4yt8juTp
	t35qe1dx1vTRHOfjywia2QbJbymu715hWN0rPajbe9UtP/4PZw7aq74N0AfQAh3z
	0j4Y6UIk7g3fHvRQlISxxghd0xTo9kO/WBVnU0RwM/NQ+RCTATxINyrTf8dhUh9l
	tHA1Jr6nOZPg4uMXQbCYOH1AUhdXIc5d7ACnU0R1aguhjykBaHLm6pz10ieg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762800036; x=1762886436; bh=gAjZ5bffka/mn2icT9lILRE85lxCJu/K+oL
	fWGghLsU=; b=ZktwNfHW0NafnfUNcDnLDCQhN59UubJQU8gFdKLu2EHPARjfz/7
	8jjsan/29V67H5LxBgNecNlvn44Vo2JG/Kl8rX/a/Jq8QnR18X7viCm2NAFL1yzo
	76t37g7bxfHAfud2jo0N/Vn4hcSiafIki1UCuMy7WyuRKopWN/kJhBnnDhCiJcG1
	5fvTWOZ9FBWvIChobQigFvNuIMxtcZhOtL2NKAiFj4w5CCg7aECWHkz3fW3S9dHc
	OAYXWr5+zpk4A8H9IwT5vB35Zx8IWfg+MIFKOHNefgjY2DCy84ggqyf6Bc4zEBxV
	fU4f43wcb0ixoIjdiDR5Jxv2bzWFiC07ONQ==
X-ME-Sender: <xms:pDESaUU5VGTYIbieFzYrrjLAeEGTHDH978SGuSCRg-sgJLFQOYaDFQ>
    <xme:pDESafkgG2hIUoFf4YmBhugsqk-NzYVz62J-jIGvM0K8L9ZRlJgpoLy6Ajn-R_tYA
    OBu2rtRdo5OgUVfpojZ6KF19pll71es3xz0nswlUbyh6L8gImymlcw>
X-ME-Received: <xmr:pDESadbNonQAeEGsYMjJT-9V_3MCBywVaLHHk0A_6fPqtKLxdNGzuLr-diklXwnNiwth8kjJ64Cfups_IQL2Hm47PQweN6SMlXS1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeltdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:pDESaSP2pxyf4zyCd2ejCy2vFWRIWpx1xfoi092ZM0sW7tKobk3I0g>
    <xmx:pDESaaZ0LAoFaHx8Fr0wq3LEFhhildo2nBk1uw-JaKlIbm1XiycQ4A>
    <xmx:pDESaY0cWRHYceNUC4crI6yu-pkkVH_iscAZZpI4jzIaqlytmeQPbQ>
    <xmx:pDESaYfpfpL4WA17yqZRgWB9hdf45yJ4WQL3gQJzYg1eIctRq4yjbQ>
    <xmx:pDESaY5bC4rVqNqllnq3S9yFOrG9FPOqBtncysNCHjWWZ7OR4zCEStoy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 13:40:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 12/12] attr: enable incomplete-line whitespace error for
 this project
In-Reply-To: <e14d2d1f-f147-49dc-897d-87f0fbeaa275@gmail.com> (Phillip Wood's
	message of "Mon, 10 Nov 2025 14:55:32 +0000")
References: <20251104020928.582199-1-gitster@pobox.com>
	<20251104020928.582199-13-gitster@pobox.com>
	<e14d2d1f-f147-49dc-897d-87f0fbeaa275@gmail.com>
Date: Mon, 10 Nov 2025 10:40:34 -0800
Message-ID: <xmqq4ir120kd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 04/11/2025 02:09, Junio C Hamano wrote:
>> Now "git diff --check" and "git apply --whitespace=warn/fix" learned
>> incomplete line is a whitespace error, enable them for this project
>> to prevent patches to add new incomplete lines to our sources.
>
> Makes sense
>
>> -*.[ch] whitespace=indent,trail,space diff=cpp
>> -*.sh whitespace=indent,trail,space text eol=lf
>> +*.[ch] whitespace=indent,trail,space,incomplete diff=cpp
>> +*.sh whitespace=indent,trail,space,incomplete text eol=lf
>
> Do we want to check for incomplete lines in our documentation files as 
> well?
> ...
> This series does not update WS_DEFAULT_RULE to include 
> WS_INCOMPLETE_LINE so we will not detect incomplete lines unless we set 
> an attribute.

Yes, that is why I said "to our sources".  The rest is left for
somebody else to do, hopefully long after this series settles ;-)

Thanks.
