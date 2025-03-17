Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B908B1FFC55
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250451; cv=none; b=GsOACajeLk5cAgZYcGhLE09RBUpDphO3NAZIEMMKmxMzpQfNFv74hm+uT/M8Mn/u+57BAJ1t1r4wlguGp6goWTZ+gWQgmKP5EQ7302Ll8GbFXC1ziqpgVPBYr+0kKu+2nnK896tRUExyjH2ySmtVWQxV5XKFMmV3l8p0XJA0haU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250451; c=relaxed/simple;
	bh=ocKcVTC9KMPSAThBGToBjYrp5VG0KHRLDl9hEUg1KLY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VD3yISkW5yuZARnhz9w5iM/tzm7jsOJ4znYXFKEZTOA0pjrCf/6LqqnWniR7QKwBY6s6kKXbyK8QKBAxoGX/TrVT8by7N/dATzRSpeKY8RbxcWYg7NCGFFyc+UgP183/1ET4RiwehBWQM8IYSe/+GDj77VXSoaVzocCM9cfi3t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mIc0wQZZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ae1/uUAs; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mIc0wQZZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ae1/uUAs"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CC03A11400D0;
	Mon, 17 Mar 2025 18:27:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 17 Mar 2025 18:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742250448; x=1742336848; bh=Sa0rCONfHk
	7GPy9utDlr5tzownqCkkmnjwb8g9XbQHU=; b=mIc0wQZZ41RS6QdRcWq2ipctAt
	gE2mLQnsl17Q6nSzH8UhcZVJJEavCs3vRA1bejwA1IJMeRKeOW2JvfXzF3HFZrZ7
	ZvimW78Vo/PquYMk8TfDGeX/TM/Yv62yE78P1452AK0JsuxI3Z4vGYYzldCRe4jk
	Kpa23a6v0oOHwm/4mz1ziKKMuE0AYywabg0UleC81EN/QR3T8uAI/saIq8MIMJqE
	UKZZDRrrsH1lS/tXKTN3Vk5bef9vr7ZKsjprgwo68BikPtZEJTJvcVy1ZuDObs+l
	OEgz5ktsR98WURyHB1djtH1QpI6nrl3stJrFQAv4guwddW+a+87CKcHqln7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742250448; x=1742336848; bh=Sa0rCONfHk7GPy9utDlr5tzownqCkkmnjwb
	8g9XbQHU=; b=Ae1/uUAsN7HZ/dvvyozFxuvqLPdXC02tPYnD7Ut+2u20OsGhHBB
	864qMUCEG8lXA21+I5NJjqsASb8F7wnIRwAma5T+vk23WqkGIBBMLuPlhultm+89
	14y4zih+4nREQnRJ3l3cIkT+MoZbeiiBp3vCoxfjBS9CNNUZcin932KDm+zgBxrH
	eRkM9elTKQk71Qqetqwt5B+iSRZVCYDj2uow3zAWlZQ04UFAQni6/btRSHiEPjKe
	5rQORDXApWgza0B2px5XJP+gNgf165f77ESe94btoNn8SJeP6X8sYQXwZpXrjBRz
	M+c5B4nwo1IP0uz6p+FqcDlb2hH/E/LSRRg==
X-ME-Sender: <xms:0KHYZ-LEVGhm24nW_C6B6Xk_rb8Bx9yYQX3zQaHOMX-4glT2UIYEEw>
    <xme:0KHYZ2L8SFn1nqyutREEOTlW4BDglCFKT7EgjMj2MIER3qgLV4LIrg6R-TgFGbo0Y
    DzwYyqi_2eWDWDqDQ>
X-ME-Received: <xmr:0KHYZ-vZizQYY1G-rhasIruYXan0sRKa36u9ISy40tjCvmxyoMrd14gPW1ygyoL7JQL_V7LuGSyL29o9P8tfqIdurpt9X-66luQBSAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohht
    hhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0KHYZzZX3Pg7Bo5L4ArS4DCEHGiV1ZbPP39iPVuZYDI4QDyKxFDchw>
    <xmx:0KHYZ1ZqN2KKqFxZE4bMPdjNJZttJyKKY507ovgY7oSQv7sC1u5wdw>
    <xmx:0KHYZ_AmULcrppC5XCSJWoJx_A70OxolQFqny5IL_7jfzmj4RcIv0Q>
    <xmx:0KHYZ7bF-Yckb1tncpm9pehQw_UZSqt8wNGrcDW7-YWWeDaCvQt4Hg>
    <xmx:0KHYZ4wCcIbXeeHneiU4J5oe175rTOhYIMHjZKYtiu91YHhRBmDgEvg9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 18:27:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Elijah Newren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/3] ci: add build checking for side-effects in assert()
 calls
In-Reply-To: <CABPp-BF1LgdafW+PHmttuhHL1OOHPTsGpOTVuG_A0SSH5cbfbg@mail.gmail.com>
	(Elijah Newren's message of "Sat, 15 Mar 2025 23:38:38 -0700")
References: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
	<80dcc2ba3aa0ef72abe18f8525d571ea39ac6382.1741911652.git.gitgitgadget@gmail.com>
	<xmqqy0x8l8tu.fsf@gitster.g>
	<Z9OD8ihB-tiCdBmp@tapette.crustytoothpaste.net>
	<xmqqtt7wl85l.fsf@gitster.g>
	<CABPp-BHRSnNE0zj9kRjrVm4-NXt33tYBT_iSgZU-5JU9Y2vp3w@mail.gmail.com>
	<xmqqa59nh66g.fsf@gitster.g>
	<CABPp-BF1LgdafW+PHmttuhHL1OOHPTsGpOTVuG_A0SSH5cbfbg@mail.gmail.com>
Date: Mon, 17 Mar 2025 15:27:26 -0700
Message-ID: <xmqqo6xz70oh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> >> +extern int not_supposed_to_survive;
>> >> +#define assert(expr) ((void)(not_supposed_to_survive || (expr)))
>> >
>> > , which serve as the core trick, I had used elsewhere before.
>>
>> It may be arguable that it is too small to be copyrightable and
>> there is no other way to express the idea behind that check, but
>> in any case ...
>
> That's what I had been assuming, but then you, brian, and Taylor all
> pointed out how clever it was making me think otherwise.

Heh, cleverness lies in the idea, not the expression, and copyright
is about expression.

> Turns out we don't need an alternative.  I contacted the author, who
> responded and placed the two-liner into the public domain with no
> warranty of any kind.  I'll send a re-roll with an updated commit
> message.

Wonderful.  That is the best solution.

Thanks.
