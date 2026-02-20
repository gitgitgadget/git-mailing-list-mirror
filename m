Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39AC30C356
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771628825; cv=none; b=JoK42zUuB+OLcK+XWq4CCrZf9d8n/x+tXVckUA5+UUepUmtE8LNZvZvUgMAGEAYHY17SNL+fkRdZy6EfhlxK7lehFgsZz5KZrDxLpXBkRilQ2EvAI85DH3C/TqzvzHob6ZhdyrMWeah/38tJT2JYkTW7z2eGnCKS4oRH6sqAXZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771628825; c=relaxed/simple;
	bh=RpXt12NcF8W4U9hMiMOKIDP3wl9nYg66bGE1bO9AIew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h6esMl5GHKt53XnHDhdDNDCqQbf3P4mtvYXaeugQujz3/e/RXpM1NwZo5LmUJJpfHvFRoQtgMwphUiRNVVK+dvRe4k03SUZeuGRpIwrtT/8wj4SU1P4fMj3RZh/dsdo50nk/GVJ0puNRwPjROBNFjLkVe9Ph4XkMr3xxad+gMOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yd5yQC7W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LDBx0dKH; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yd5yQC7W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LDBx0dKH"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 35CCD7A00D5;
	Fri, 20 Feb 2026 18:07:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 20 Feb 2026 18:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771628824; x=1771715224; bh=kjn2EZJNz4
	L4EWbaEIoctttM0ZbHXGuJfqadsa0BVBY=; b=Yd5yQC7Wdohn7xtPxt0JCkWEyt
	yTr++RCqwJD00xoIeO9RQ0zgaAeQruV5V7kE+DxhwqGt2n1EINEzqPlxYo586bbz
	/qumeEHu9928euBRo5QFv3T8RY98FX2eALQRrs8mHlQeQ/d7bcLf6NTB/1PyJHq+
	MuZwucptD5BaNQ1qztebAU48D6FUFt8VQaKBH1VyP8l72S1IkrwBmDhoAldi8NX2
	qNmdqtdZlfvHZvLtnI/fXj+6QSpePL1304ZoeV5wnHKB5PthlNkjU+arlFjyLwt/
	O85tQAJcWqTvAmzYCoTIE5ZX1Zprs0v7LEez0+USaLLOlbSx9Fwf0XhCNX9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771628824; x=1771715224; bh=kjn2EZJNz4L4EWbaEIoctttM0ZbHXGuJfqa
	dsa0BVBY=; b=LDBx0dKHckAwY+WM6K8tahNnRvaev4qSM1vT5H7dBpbbvZBWzQK
	eD9w1/WQiPQ7ZIdUeI0criiAMZ4wJnjIWR6Rfi8X2VawHVfWV6BChjSpYcI809pX
	d/TQUOngqwFzD5vcsT2JTfTuzBWzhsbECNYXC5c2g0HnP9HAEB+cv8DLODMmOluC
	NVgRRkre8G3wspNeYW/Dc08trITMotxydBBbJ9PtpSEBS8Nw6HqKBS1wpTOJOHF1
	jdZWXpWOzQU6tv0wojyqi3Br5I6tCPP0Sd/rmvsgVLtqvHU93AGp8igU4JjWIIlC
	ezplZvu1KLmznPtuQxu4zB9WRtfxsit/eGg==
X-ME-Sender: <xms:F-mYaRMxoLgnnjHAXbNhlfBlOE5iVdmbB9OxUcZ6BkM3SQIop_JreQ>
    <xme:F-mYaa3d_FoceOFTxMtql-XvUS0f1BvHfYsT7BavZnmkrtCC2Bj5kqw_smfb3hVWU
    fIK5Yt2fHGpZPFz4X8bW2tHuWib4TPsrIeYkRAdwpeswPJR7-tmF0A>
X-ME-Received: <xmr:F-mYaYljYvER3B4r3qEDWCq0SX6zq1V1wRIupOAJRr9ABo-g-Q7jX0RBVkz2Tk72HCewPGSDq-4Ma-rf1S7RzMMVCkUl_S4cGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeljeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephigthhhinhdrghhithesghhmrghilhdrtghomhdprh
    gtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:F-mYaZWhPkJLd1RwhVpc1cR03IARWm730aIu2jP2TIzFjulNEhXFkQ>
    <xmx:F-mYaWtnSNp8SRQG_5Ce5GqtOnp3GVLMjfkjLLOHknrEqW6EgjcxVA>
    <xmx:F-mYaUaEXiLJmew2L9BMhHoEfXQKbUgDIlD2mnxoJvhFuR_VED8K6Q>
    <xmx:F-mYadV91od1JorvEqPvTM3e1Ww0RatgfBuB6oKKSbLtEQj88xbbFQ>
    <xmx:GOmYaQnwqRhNfOno-gqHNHAaxsgF_q5McefBPj3Ldx-MQlPiL_zQO4mM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 18:07:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Yee Cheng Chin <ychin.git@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Yee Cheng Chin via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] xdiff: re-diff shifted change groups when using
 histogram algorithm
In-Reply-To: <CAHTeOx-TLwqbcdGcb2drD4vE6D3M93EPMjcAeTNR+XNTbmTVZg@mail.gmail.com>
	(Yee Cheng Chin's message of "Thu, 29 Jan 2026 17:58:18 -0800")
References: <pull.2120.git.git.1765054287938.gitgitgadget@gmail.com>
	<xmqqikcusn8p.fsf@gitster.g>
	<4fa413ae-f2a4-4de2-a2fb-0b1db379750b@gmail.com>
	<xmqqy0llk33y.fsf@gitster.g>
	<3aeb49dd-8618-42e0-b9f9-6a4fb8065793@gmail.com>
	<xmqq343sjn4x.fsf@gitster.g>
	<CAHTeOx8SOZmqvi0pkcheSjFpbEALmOwaUiX0tKLmNP7fqvjMXA@mail.gmail.com>
	<xmqqsebo9lv6.fsf@gitster.g>
	<CAHTeOx-TLwqbcdGcb2drD4vE6D3M93EPMjcAeTNR+XNTbmTVZg@mail.gmail.com>
Date: Fri, 20 Feb 2026 15:07:02 -0800
Message-ID: <xmqq7bs7ui95.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yee Cheng Chin <ychin.git@gmail.com> writes:

> ...
> {-AXB-}[+CD*XE+]*
>
> Because of that, I'm leaning on keeping the current code structure,
> because it *is* indeed a cleanup step to be run after the previous
> one. I could still refactor it into a separate function and put it
> into the the case #1/#2 if blocks if you think that's cleaner.
>
> I will also add the above to the test case in v2.

OK, it has been a few weeks since we had this message.  Will we see
an update sometime soon?  No rush, but just pinging.

Thanks.

