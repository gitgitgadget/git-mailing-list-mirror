Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7947F1FF1AD
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938990; cv=none; b=g+H3cEgMsvOceOTss/3VgZV5Os0MDf5OdnF86gWWKRcbW9Gr/4qoiAfqe0/QuEob3sveh636MdO8rduPR2wlu3VrgmSm4cT6RmvVW+NUsmgQWD9KcYn00/ozBdUMLQQgtnybNCUt0qsdmg9xb6IEQn2RpofrV00WhJQ+drcg6kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938990; c=relaxed/simple;
	bh=Dzd2UMksxh3swf9kExwm8JRdCEdfPWy4nq3AwIUXmBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f51LxiMWwy3XyLls2Lu8xOoyUmR0i11X9ZsHO7aJpZmScrl5+LKuivAarV2k4O7D4tnqBUh/lp4rOcH0ZHMefBVHGvIHNyMcCwIqB43GS/IVgIC3WCO9fTZTlf39nU/seM6sxAfHNlm9Goqtheg8xxLW2ziZJxgE3YSkod/0gZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bs9fD1Uh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cojZ3oaB; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bs9fD1Uh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cojZ3oaB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7E9B01D000DE;
	Wed,  8 Oct 2025 11:56:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 08 Oct 2025 11:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759938986; x=1760025386; bh=JAlvFCVyg1
	A9ObyW67YvsehQ6/86wHgf1+n+5dWX4SU=; b=bs9fD1UhAO/8409fNaHYMsHGoW
	R9deu3zTTxKyBpv4oPWyJbNVUEH6scigab5XF1lnTZQBeSrh+WRiG/Tapw50bi4p
	VgWOhggfKnA65y8yvsgO8ZQcOVggMKC+UAR2XGOB0+AhSmGqjC5o0prrQYZMjUVu
	hfr0q9tAQgZWc6Ut+RQPnbgWfzL2kum2K4ftfXF5hsNBB7CMHaTKZ+P8iRaviknl
	B7EPud/VrPr7mdmi6W7crkemVfFR0ibuhb+b9824LCEqSywAa8WpShsrlCF15c7z
	3D2jIBnp2J5UN4NUQl3ciYTJO3/Z4zHeLKWF+lhvT1kOM5YsAA7Jgj5G4STQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759938986; x=1760025386; bh=JAlvFCVyg1A9ObyW67YvsehQ6/86wHgf1+n
	+5dWX4SU=; b=cojZ3oaBXqlZSYAtsVM9LCG8lxR1VXKK/G7jaelUrjyNovXtIhU
	H11ZDTQEogf1vtoHy4DjJosovTdR6AOfn3OcICoxVndss0rpq5eLBSId7JXs1H4U
	cLkYVUKUiGlEx3hTg0TKTtiT09dRmCl2JWWSdUt+LpPndGpQr6Yop23WH8l35kVU
	/hWvGrQk1FHlai0pvBp1L3ddDvrTGM+3qlZJJ2XuSuE6JgIXYaln8XKQdvY5DMut
	7gaobnvUT3zwq7tDnSK3C/2UFsvr7p5Q1Kx22PoQw0cNji/4QIzeKJ8dhBIPbtY2
	EynJj+jCjApcl1Gn6XHqlECyXlQiWb1dbtA==
X-ME-Sender: <xms:qonmaCuYZ58p8Eij6fOw4QyWkWdJlSZxk6LPb0oWKokhwsZsL2NI1w>
    <xme:qonmaJtwRILWo7w05rZJCaPZfm0uplKRd-obr4xBQ05JGEu1C0UpCBvw35jcuTJpt
    ivUDkkmt_x6WSw5YIBYLQga7Css2lLaYx-RMqWZPkWN1KK6VWYakg>
X-ME-Received: <xmr:qonmaAAQdxj2Wb61O3jmRHulO8xN-naNhKgeMgh3J3lIw3siZjdXhOAtMYLBs_jxLN2POkjVYjlsqOs9b3fAfrPZCMR1h7iC3ARx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:qonmaDM-wbEQNuf6uyAziwHE9EBJhkfKZDsClOdp6mQgW_qYglDPrA>
    <xmx:qonmaBwi4iWBRS-FTca4qHIKcncOqVdEivnS3qd_x4CWPcWE7CGL7g>
    <xmx:qonmaLUNC1hZmn35nkl3U3jQUn4ZT-GyrC2Ek_0qWqzA56NeU300wA>
    <xmx:qonmaLPPu3ehQtErWE86AavxIQk_QS6qyorZANd-6zSbreAeKpbXdg>
    <xmx:qonmaAzOXa6YP3d0O-x22Aed2fmO1nPWfE3WR69zLbZsWmDKesXC8XWc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 11:56:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Collin Funk <collin.funk1@gmail.com>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  Karthik Nayak <karthik.188@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v3 0/4] enhance string-list API to fix sign compare
 warnings
In-Reply-To: <87frbudusr.fsf@gmail.com> (Collin Funk's message of "Tue, 07 Oct
	2025 18:52:20 -0700")
References: <aMp8yNFiXDyk2hP4@ArchLinux> <aONhmrE0otiyZ16f@ArchLinux>
	<xmqq1pnfof71.fsf@gitster.g> <87frbudusr.fsf@gmail.com>
Date: Wed, 08 Oct 2025 08:56:24 -0700
Message-ID: <xmqqa521gzfb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Collin Funk <collin.funk1@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thanks.  I didn't see anything glaringly wrong in this round.
>>
>> Shall we mark the topic for 'next' now?
>
> These look good to me if you want to add:
>
> Reviewed-by: Collin Funk <collin.funk1@gmail.com>
>
> I wrote a bit about the signed vs. unsigned integer for object/indexes
> in another mail. Because of my opinion on that, I usually just ignore
> these warnings. But my impression is that my opinion is in the minority
> regarding that. :)

Well I probably am in the minority who thinks that it is a disease
or superstition to think that things must be counted in size_t,
which is often unnecessarily big (which I do not mind too much on
modern architectures) and unsigned (which I do mind for the same
reasons as you do) and those infected by it should be somehow cured
;-).
