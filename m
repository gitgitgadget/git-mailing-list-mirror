Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170042AD2F
	for <git@vger.kernel.org>; Wed, 14 May 2025 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244784; cv=none; b=rdWmCXa0kDx9FM+wKGNOxssCugbzWU4qP5GZDZX3nsWvFo+5JzNEL3sO04eOoBOi/jtlgaLnTtzvgZb48ny5tsK+nOGgwsx28kGrdhaXQIfU2Ibx87ekB1EfLsGQ+hmgDcLPMuucfwtwEiCBOGLze6wxZ2mV7jV6+UqM7KkBJak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244784; c=relaxed/simple;
	bh=3ovhGWPhpn4yJb9rywwOmc8xMQ5B8ED5gDaytJLmgGQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uiQ7EPMFO6GGpCFBsqF5/fYawjdUqL3jW6iWi1B3F6h9nXw9HjsKxltOvFeoqlmqFyFXugZ8MZJZHPZeOXFmmjwq67FBGFJ/IMW4e6Pi3FCBwlMZ7XwZFj6WaTfhxZjGJ7ASqHBR2ztjjigAWCZw7hdMofW+tkUoPX+OajrFXMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E2GnqcJZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vn3EV45H; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E2GnqcJZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vn3EV45H"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 28D5713801FA;
	Wed, 14 May 2025 13:46:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 14 May 2025 13:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747244780; x=1747331180; bh=Fpkxop0i/H
	1yoWzhUW496sRlGt0vrzlf8VbbsQRN3/8=; b=E2GnqcJZBFrGlL5sZeK7r0kBCX
	Bxk0YOyB54k3vIZR4OlSAyPjBFcGIPGBYQKUD8ni3akBDpF1UK3RAVecNaDIBmFB
	IWiM4B6vQXrpePqEhv83qW0KWNUzRok0octK1PwBd2Cvh8Ljc0fJ2Jkl/XXArASf
	rEa6nScDDezmFgJ6LmI5EoKZC2SWkweCdNXbytAnuPj5uGBGbJNr/7WTWATyUetM
	1LxgH60kVCGiw9ZW3/+O2W3sU4F49KTzVIzRzRj4XeAtkQvhCBhXAgIjiemho8k9
	dkE7oA9nmbT0SikXnAppijIhcBOUxYx6JlyHuqjYzxNXgNI19GrzMI+MFhnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747244780; x=1747331180; bh=Fpkxop0i/H1yoWzhUW496sRlGt0vrzlf8Vb
	bsQRN3/8=; b=vn3EV45Ho5XEeWmF4kHroj+9Z8yovQhKih58cs5w064KHGFWIEG
	fUQzit1ZFIKtHKsa+LyTmIMIERyTHg9dKvodJDOE+cTOtk6GFJ960vvLn1fCO2GN
	urOt/yqdJvGSqp3nv8zOhlbN4fOKdOY2chKsn5Lia+5qE4em60yOSRzpV12MLhgl
	j5Vn51VMTBf3C+pSZkVIaBRv1fKoOKjDAbskjOy13St0ThHfXE4NrE9EtU30rHKG
	BuxgWcWYaGeOvVglCK5IJTgJb3C+DQkgq42B2/8Anp7HvY5DHenBM8+iZOHUl7df
	zWqBbnNKw4vk3NW1tpXzbvk7guubXWo0AWA==
X-ME-Sender: <xms:69YkaESzU0-T6Vjhz8zyHuZJQz1jXumlYBThOEXuabRA8D1_1GZX4A>
    <xme:69YkaByIWHwv3T8YIoqG0DslkQH69PtF2f8yquFgQiib9od_L8SNm8MltqYMo_Xsv
    P1EA7154yUcy496Uw>
X-ME-Received: <xmr:69YkaB10KzVYzhYwcuN1bj5dSffY6Tg-Dom_zbBPkFNSzArdIdet2y3TWRG8TlZwztfZrrJW2h1QZCJ1i0zJaU9hXbreKdsZ5UgJh6s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:69YkaIDqcSNN-pOKrGLIl02VNpBmmMi83KR_Zq_SdZ2YhN7LuXZ4dg>
    <xmx:69YkaNicc9oJLoBN_DKbCMgKs9NX2F6hwrON8U5ipS1DQaUseo3dfg>
    <xmx:69YkaEp0Kkr_3WMNdELuKjX-C7vU2rXVNZ55L8xD7qAvLEs_GjA7Ng>
    <xmx:69YkaAiRY4tRPNQ7ChnRNO3QKFZ78Yb82PdZYj_2gBypjaPrkAf6Lg>
    <xmx:7NYkaAqDIA76StHKmeuxiITp3hqEZxqiiDnCeKjiB7889Do7Ik9HYpO5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 13:46:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  toon@iotcl.com,  ps@pks.im
Subject: Re: [PATCH 2/3] send-pack: fix memory leak around duplicate refs
In-Reply-To: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-2-7c65f46493d4@gmail.com>
	(Karthik Nayak's message of "Wed, 14 May 2025 11:03:48 +0200")
References: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
	<20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-2-7c65f46493d4@gmail.com>
Date: Wed, 14 May 2025 10:46:18 -0700
Message-ID: <xmqqikm39jbp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The 'git-send-pack(1)' allows users to push objects to a remote
> repository and explicitly list the references to be pushed. The status
> of each reference pushed is captured into a list mapped by refname.
>
> If a reference fails to be updated, its error message is captured in the
> `ref->remote_status` field. While the command allows duplicate ref
> inputs, the list of doesn't accommodate this behavior as a particular

-ECANNOTPARSE around "the list of doesn't accommodate".

> refname is linked to a single `struct ref*` element. So if the user
> inputs a reference twice like:
>
>   git send-pack remote.git A:foo B:foo
>
> where the user is trying to update the same reference 'foo' twice and
> the reference fails to be updated, we first fill `ref->remote_status`
> with error message for the input 'A:foo' then we override the same field
> with the error message for 'B:foo'. This override happens without first
> free'ing the previous value. Fix this leak.

OK.  A natural question is what happens when A successfully updates
and B fails, or A fails but B successfully updates (failing both is
much less interesting).  What should happen in such cases is unclear
but my gut feeling is that the last-one wins (which you implemented)
is probably just as OK as the first-one gets retained (which might
be less work at runtime), and perhaps keeping-the-more-severe-one
might be more useful than either of these two, but I didn't think
it through.

THanks.

