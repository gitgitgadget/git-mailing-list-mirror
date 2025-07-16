Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2DC28BA8D
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 15:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679282; cv=none; b=JMCh9crqg7JXVDbsOXVTZM8q2Ls1iTykJGUoAXB60DVlH5Y64YtIN1dNbV5ZOf7B67l5LAlSJxApE3PAAiiW5DcvvCwpw86sfQp5pANCUdQwW4RpL7WTgAhr8Ii/zNrY3Qi/KD7myfPZviaG8csKE7gI7vuo6qkXeMyxqGKOeB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679282; c=relaxed/simple;
	bh=13Bbi4aKjE0E0TSsvfU4Yaw8DrJeZQr8RGaYgx5I4IU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C0Icy0jGmKdsNVaxGNCJJeP1lmMFqF6Z+WvRJ/A1dhGSaJ1O8xKNT3pjDSfoLNt/E2FLNrQ8L/Tg3dNQg3B2qqescYjfI1QQ55cqUTe6CGQGehJFxz3tj5jUmXo/+teut4ELDYnzPh1vBFxKWZrpywokWBGxXQa6IcKJgfvLjcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sicjl8tw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DiKatyXz; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sicjl8tw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DiKatyXz"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id BEFD31D00029;
	Wed, 16 Jul 2025 11:21:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 16 Jul 2025 11:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752679277; x=1752765677; bh=SBQUXS0BiD
	qmK91YEtkvo/6pUPmFBM7LCDzZhFd72Rs=; b=Sicjl8twHh7W3ck28MDARcTjLI
	DZlpRT+oo5j5I9AGIFcXbfAyxGvIIS7uo/97UsJZUjo8FJhci2rudAiX0DS9ue8p
	n0+Iln4RMQtVxU1uTHAAra3S3HAEuH48VgdKs8PNby1fLiVzhhaL+UeNbpus7F0Z
	xwk9JQd3zTFM2FGURKE6g5+nrd7p57daIZLjcpe+C0cDxf+zyCGNuQKsplYtHNlL
	Ist5E4DxayyJxMIzpz2u7qvM7bik5ExmweMVqcNrGBjnWJlMw6lcDFhPgWe3wv9H
	zshIxtoM+7P9T9gAO1g/4Dq2jFC3EZq++TY19rPUH2vo2KBkZXPC9C3oxHuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752679277; x=1752765677; bh=SBQUXS0BiDqmK91YEtkvo/6pUPmFBM7LCDz
	ZhFd72Rs=; b=DiKatyXzJHhLUlyBjZCO1uxdygPh/NLYkdKK1/8eUdyaPNgbtCX
	AvQ//fDOZXMv+1sPnvcCB6ZRPl6Cyf1PF45SPdqGdZVq91JNbZOhLC+/3knt+JAm
	e0EQWWJ0+X4oHuRWqttcYHV9Rjl0rSiYghLoHe64mJeRWcbVHZFFvJHU03ZpPBD8
	i4Xs9LRPeGeWng6QDXIhIsBH+s3HtlIqcfKGtWWQDIBtruKhJ46m/FiouNVLKAkw
	9eQ9XikZo5S6OmD7oABiL0UIEOX3DxWfxWswAz/znhR6/ogWkrDVPy/aJXj/lJZ2
	IJpBLQTKQ/aTSD3nmHVhdVbI+9aedMK0ndQ==
X-ME-Sender: <xms:bcN3aE7lxymRmZjh0-_tGKhZdEo8Dcbq9ujMXk3z3TJJnA-H51qq9Q>
    <xme:bcN3aDeSTFU_aYphBmNjs0rArap9ALfbVuAHFNmLoe8D6QP5gp7paIouTpykZVn0T
    oGLdoaFn7k0gUFxRg>
X-ME-Received: <xmr:bcN3aJ4ZWyivu1nRYR7BGvJ_2wdN16Epy7HIdtwzbt4RRtYVqPJwn1li8dMx_bDAoiGKvzPOWIRuNvQQJQ6pkz04Nb9Z3_-eNcyPY6U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhh
    higrmhhthhgrkhhkrghrtddtudesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bcN3aKuwKvGDGNDYjxK_73hEs0nQ66BPlhj1EgvR6Inp24peXul50A>
    <xmx:bcN3aJg62IMckFVO60PHSH20Lan4RMtVKONyD5EzyE6GsJQbFTRn5Q>
    <xmx:bcN3aFrer6_0zJLZ8ebmN1cxuIM2YB3AZ7fTG84q2DuYgZsgJ303-w>
    <xmx:bcN3aGuDB2Wesj7wJesziFbjOt0xT4rL8QDyv1t8CmENpbZboOetzw>
    <xmx:bcN3aELysSH2bsITj4brWl1wt1CZed8JN-jwNIggmXCIkenORg-nBWgH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 11:21:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,
  phillip.wood123@gmail.com,  shyamthakkar001@gmail.com,
  kristofferhaugsbakk@fastmail.com
Subject: Re: [GSOC PATCH 2/2] config: set comment_line_str to "#" when
 core.commentChar=auto
In-Reply-To: <CAE7as+YxajFO0FfMe2wYpT9okYQoevZAghDD29d7E0P82-A_Hw@mail.gmail.com>
	(Ayush Chandekar's message of "Wed, 16 Jul 2025 16:34:36 +0530")
References: <cover.1752602474.git.ayu.chandekar@gmail.com>
	<2a3c2d323bdb520a37a099b361be9ec5f2d5d46f.1752602474.git.ayu.chandekar@gmail.com>
	<xmqq1pqhgnby.fsf@gitster.g>
	<CAE7as+aN+j4CteHUrr+R+CbZ=qi=mehYW2xQEG4ZcQYvXqJsaQ@mail.gmail.com>
	<xmqqcya1f2vr.fsf@gitster.g>
	<CAE7as+YxajFO0FfMe2wYpT9okYQoevZAghDD29d7E0P82-A_Hw@mail.gmail.com>
Date: Wed, 16 Jul 2025 08:21:15 -0700
Message-ID: <xmqq1pqgduvo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

> Yeah, Phillip should actually get the primary credit for this patch
> and Suggested-by does not do enough justice.
> I will send a new version right away.

Thanks.  Don't forget to ask him to sign-off.

