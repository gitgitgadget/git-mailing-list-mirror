Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998882D027F
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 23:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755906622; cv=none; b=us17DtxXQj6FQSyyL+jt6Bwga85Qwu/S+xQ7fxyf4JHe8EuPBhQGhjnQeZWgP7btVcz2zakwzwkp8ouQnqFMIhACLZPenTPAb/Cig2xdYKUNLItKajynItmXiMMv4fMkFP+cZTKhf7/gtz13tfyU+pKBGVux4dSZrWik65r8+Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755906622; c=relaxed/simple;
	bh=0rQ+Zxtwb07XIvwfCRdGS6p/0wZoVslhNF+x5FOguro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p6n9zVveDUNze4apBjodo6RO6C7F2+aZms6qOZQqreZq3hg3PAnHbuiAVv1qAVNRlpLagaJNlmy35Qkcp+uifjiigunUXZZ/BUQ47EJU7ss+jHlQy3+YJSQwJr5Cgyz2SD2enQao2cw4p+qdssL7SZp9gPtyovzgcxuz3VQxej0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CGYFKqi5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V0rNzlrM; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CGYFKqi5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V0rNzlrM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7412F7A0130;
	Fri, 22 Aug 2025 19:50:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 22 Aug 2025 19:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755906619; x=1755993019; bh=DR9FMTp4WJ
	fKB0orCtjjQVozEbKqQnS50Pkv20euF94=; b=CGYFKqi5IjnI6I6hiXg1beynaR
	OJqd9//VF1fQ2X3Gc5kDwZYa7q9pRJH0+d+K5JnWlnq7XTIB+3dXRWuy3JIaayDS
	q5rCuoaASpht865Mn0NyYwYUqV0fWs/YceJjJKKS4tfiC+n9wA1oCC8olrhy56Rw
	a5w//ct/ZdsHAW14inOrrP8ypSYuzmYLJS+jsNOkl14uDfJAarYe5bRbGwFjInFN
	wjRsp5urOjlYyqJzu23dGx4iuTncXWFm0UIaTUyRrrWUlvklMo9Z5e6EKqZEbAEE
	PCwkqHjwVoOaqDhanyhgK5VrU/wqfQaDiRgbda/4bG+VlX3GfdKV0V1In4WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755906619; x=1755993019; bh=DR9FMTp4WJfKB0orCtjjQVozEbKqQnS50Pk
	v20euF94=; b=V0rNzlrMRPClro7Mx58a9UuNEFCNsevpwHFS+fgLWc9qUB9crcj
	Fh5iq5Z+HeGX7+3BHNKbzdR3h/qLvdYh1tKpLoOfJvCr/6NgoJ1I1K3O53f1Nnfj
	NlELCpJabBSXI9oTK6LGWBhrm0R1WRnQY11fqGeRUupyt/GWs29/E4lrin5L2VNu
	MoCUpu5FnplRngm/1mNh1z02IAEnHAbJE+l67mshtmfArq43D7gtwNl45H9CwBp8
	cBMWqmTskFz97kId0WfTxMpPllzsn9GZgEz9DzRKTuvoYBjdFLJhHe60aT6ZNib7
	FeyeB7vkBXH8Myx0CA8PDqmZ+EBx6F3gGQA==
X-ME-Sender: <xms:OwKpaOOk8wV3KeYs-gEbFGue1eTdrls--fdpSBgQvIlWIR2UgfoS8w>
    <xme:OwKpaHg0D7jNprBxxqIpmLXA3vGjXvLzvqThn-6SSldNHDWEasLJXmOC7HD85xdbP
    K4Y5-pU5XA-EPcGPQ>
X-ME-Received: <xmr:OwKpaB01XU83IYfa2du99VB-d6jdBdQmoigAEfXOWrjlgCFkAd95Lr4k_98OGNeQcM7rnahtnwUB12LQxoG2nJ7TE2eX6lGnPfpTiiU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieehuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OwKpaBjhZFJUT4nE_DJ96QMkA435f62_XxtSbcyFc7IIUkgSpHSIfA>
    <xmx:OwKpaBe15Ve9gZ8dfVqrhITbjnqpEAYybfIBkpb_t8fBY95RydJrgg>
    <xmx:OwKpaEnYnziDwMgQpL4uLcDQvIR4xKOHfpo-l9gbFiTwh4PBaduvSg>
    <xmx:OwKpaKuT2YTnO9wOz5RCN7OsK_TI9s6KLgOdKzA0xMiA5BmEz6J6Dg>
    <xmx:OwKpaCcJGiWeXIZEMIxz5PPI_9PAuVSbf7G4FfRWSTixQn3Enu8dduXH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 19:50:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 03/16] odb: move initialization bit into `struct
 packfile_store`
In-Reply-To: <CAOLa=ZRazqga7DCePqif_Hx+z9_OtMrJ_ka+gFmzVvMz-frzYQ@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 20 Aug 2025 01:04:59 -0700")
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
	<20250819-b4-pks-packfiles-store-v1-3-1660842e125a@pks.im>
	<CAOLa=ZS4vBPp=2=X98DwEk48qgFMHvM4BecUPayGAK1Wasd3=A@mail.gmail.com>
	<xmqqtt23e0uo.fsf@gitster.g>
	<CAOLa=ZRazqga7DCePqif_Hx+z9_OtMrJ_ka+gFmzVvMz-frzYQ@mail.gmail.com>
Date: Fri, 22 Aug 2025 16:50:17 -0700
Message-ID: <xmqqwm6uvruu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> I have personal preferences, and usually I'd like to hear from
>> others first before mentioning my preference, but for something this
>> small and does not affect readability very much, perhaps I can just
>> pick and dictate?  I dunno ;-).
>
> I wouldn't mind if you picked one over the other, like I mentioned, I
> care more that we make it consistent and that the formatter can notify
> or fix it for us.

Then let's declare that these shall be written like so:

    unsigned my_field:1;
    unsigned other_field:1;
    unsigned field_with_longer_name:1;

without a space around the colon.  It would allow us not to modify
the clang-format file, and more importantly, discourage people from
doing ugly alignment with spaces, i.e.

    unsigned my_field               : 1;
    unsigned            other_field : 1;
    unsigned field_with_longer_name : 1;
