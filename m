Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878741388
	for <git@vger.kernel.org>; Sun, 30 Mar 2025 00:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743296210; cv=none; b=W7PTQfKNFnLile5GdFHSbFzUV71/YzD+A22JYtbqVrOwf1RyEzCzXzTKm+hCGB7UNf2rMg72yH97HaFvJh7HhXzGoevMwPRZFsQaknzmaDpIp0dhFyCyb2ks+hOsJo0RysBl09pOx8BP/Bvl7HZbVvX2QLaEuvqESJ/RD1Ourts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743296210; c=relaxed/simple;
	bh=fZuF5MTykG1BHFZavAiyA2r2BmxpD1oe479Xq1hYsVo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qKCH1oT9wJeuNigOVQHchwrAtPKHk+KulAdIS0sYd8TnWKS0g5BgavkjfO7GRRCA7I+dHF6T3GIt50mhw0SFHbldTWTyfhvAWgb3y3SwAK0DkTiAPvZ+J0C/j3fPkJ6hcHV11N+n2Zo95DCHPDfkOqCaDz3tAdEQ2p085Y/C7DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EiR7SvD5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iSds1NUJ; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EiR7SvD5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iSds1NUJ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6ADB21140113;
	Sat, 29 Mar 2025 20:56:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 29 Mar 2025 20:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1743296207; x=1743382607; bh=McWA0VYnaf
	T2NFqECgFudCqLxb78LzMXJx9Y6RI0viU=; b=EiR7SvD5Vga+kpfZR/+Md9myvT
	Ue4fkjVhOMN/zUm8n6VCycQ96J9nc6/NK0ClkuO8LGqykN6e5VM4VA2iEaq46KxW
	+fkZiMlVX5yWmvVF2FDABJZc0TSi6mvTEXY3HMGv/pbO8OK//ILW8u10HP7I0/jw
	im5gtNq4ihPmqbvVLHt21Ey76NXOx3+6h1NcEPJ+Wt0z4Sk8RjU1Q5VqrCE024rK
	V+9DrWtU/VMBfLV9hc2/6wz23t/dFHM8bv4BYTaxlmEFRGQeuAg2uzw4heXKkMyL
	rQaxh9y8bGQCXXgWlCQjTDutDdy6F67IHqDyfmlUvNsT9fm74Ts57+vsHQ7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743296207; x=1743382607; bh=McWA0VYnafT2NFqECgFudCqLxb78LzMXJx9
	Y6RI0viU=; b=iSds1NUJ8/y3Zo6+on0AVUpJ9HyBwdOADSkoCFDDG3B3RWP97ZU
	nGNM+gQ7uy45ludha4dCIpbJncwFsimdK3LKVzM21538p+rYpCU6KxwVOEZL3QGT
	nCXkiehmruVO9MvZH3RQnbV3/UzbHrdQAaQOpQQiB05ElEK6ZWBVdUal+WdjnG+Z
	Rb0fy8OcroozV1EeMlYWpIfoMYaMLI5i1FXSvzIYQoF0sqVudfxsDJSHMrFfDtYm
	rITKHMfvhsNbSwQeCRtdJ+S0THmqB/zaA4rcXzfpIpDBsc3+uyPN/fsekNvqbaaU
	F/Ybl/9V+QKqU/NGRRTx12GnQhE/qFQhboQ==
X-ME-Sender: <xms:z5boZ24WwcgWyLrP2n6Gh8Hz1msXO5eTg40yjcFU3gA5xHuu3T503w>
    <xme:z5boZ_58u03Ow-7Y8GZGgp960y9HXK8FHp54cOh_f5jF88Pu5tKoiWXrMjREumGwP
    4EJFUrZAlwSv_I9mg>
X-ME-Received: <xmr:z5boZ1fEqAAW4wFzlqzWFNmhUhuPsrQzbH9A3n-EMgmiP4kDijAdGpktpy6avlM6740hEdCbwU6Gel6byHgKYPtZ8CCFDgzzwm4GiSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeehieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvg
    hsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:z5boZzIvWZ8MOzoCXfsB4GnmuGWbpiZ-_JHxiljwZkAdrxr35DqvZA>
    <xmx:z5boZ6LIuxOYyZD_EkodLRDkEG4k6855541NaciWTN3Kr-CCWqZwIw>
    <xmx:z5boZ0yVdA_52bJN6O1xSh28xb-lpTdSRCc_bqutgn8Ovrx4fWHRfw>
    <xmx:z5boZ-Jqc09VuCc1-2VcBkTZnfHOGhA49qVHtggTQnCKeu9jLuQrMg>
    <xmx:z5boZ8gZ8jJRtuFJffgYotyAqf83h1njDDy87XDZzlPQpruJBh59iy-4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Mar 2025 20:56:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: ps/reftable-sans-compat-util, was Re: What's cooking in git.git
 (Feb 2025, #09; Fri, 28)
In-Reply-To: <44302902-2624-8252-54dc-d4e5ee38ddbe@gmx.de> (Johannes
	Schindelin's message of "Fri, 28 Mar 2025 16:31:51 +0100 (CET)")
References: <xmqq7c591sus.fsf@gitster.g> <Z8aeLc-xelujEjTE@pks.im>
	<0c808b85-d97c-ecd3-0b1d-fba546a1124b@gmx.de>
	<9cc294f6-03de-d88f-9734-510a23fc8991@gmx.de>
	<Z8bL0HUuQqj7LlTp@pks.im> <Z8bQsflIqzZd3AMs@pks.im>
	<9cd879ed-5366-a7bf-f440-e35222a733d2@gmx.de>
	<xmqq34eyijbx.fsf@gitster.g> <Z-Y1YbE2EVqLZhGO@pks.im>
	<44302902-2624-8252-54dc-d4e5ee38ddbe@gmx.de>
Date: Sat, 29 Mar 2025 17:56:45 -0700
Message-ID: <xmqqjz87bak2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> The topic can be merged as-is. The relevant MIMALLOC code only exists
>> downstream in Git for Windows, so there is nothing that I can do about
>> it in this series.
>
> Yes, and I already replied in the thread (which is admittedly challenging
> to keep track of, as it is not connected to these "What's cooking?" email
> in any way, or to the topic branch) in the affirmative that Patrick's
> suggestion worked around the CI failures I observed in Git for Windows.
>
> So yes, this can move forward.

Thanks for confirmation.  The topic has been marked for 'next'.
Thanks.
