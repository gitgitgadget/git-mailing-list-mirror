Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EED19C56A
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971522; cv=none; b=aAh8Clb4RYGP4+v0FBqqUJWvBXKiQ4DFdwcRMRzn2Do4u5lHSN4q4zEfd8Rxe53IRpe5O+JYIRzJ+E8PImhp3s10D+nQUdLkE2u229U/kC+jtaQkSdbPBWhfJX0/lpHkxXFsYqGdnp4/pOrCKrZZlf8wAgzTFn3aL/JG/QIZLkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971522; c=relaxed/simple;
	bh=nt33jXv8M86rIzb2RwKljbCw8sZWeysag7Di/NWoS38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d4Lm+kQ6zaMztZ11YFuENnNyzLr58/ntb1JF2VlQL9TpEJ328d99LaFbjfLjMuH/iDajkLO+fVmIbcBLVBvNeoh8j3gLul8YRlm4CGUq/E3yA3yPIBqdHvLKQT7vziiT4Fire/Evsw3jMoeoRXOxl3Bx08qvgFKXql5g91uofUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rJtdGrqT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fLNAUu4B; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rJtdGrqT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fLNAUu4B"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D230B1380497;
	Thu,  3 Oct 2024 12:05:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 03 Oct 2024 12:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727971519; x=1728057919; bh=nt33jXv8M8
	6rIzb2RwKljbCw8sZWeysag7Di/NWoS38=; b=rJtdGrqTnLPzqyowZtc3QDsgvM
	N6Dr1d2Umk65uBLikooDjMfEn5npMfwX4RnX1debhMXl2bDFWDs5gQvxBi1UkFto
	YPMcDnPTMIq+AndtD0naILbnhbj4hFO0e51Io3Gag3krhkL7TrRERlBw/BcQG3Cl
	XGNiU2fymymoEcD6lSmE+P6bun8oa14TzmTNWKUo41ARsvvu775fsAFWdwUNab5z
	o/WK6Stlsj12apJDK3+fsnUinxQXtz+MCdpSvaVdXdS1/zyOQ2BMiMx6JHduIWiX
	PEIJYA6c1+GQV1pq7RxPwmDzxYKw05Ljb5CVJIm9HoDgX5GDHPAW7op2udXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727971519; x=1728057919; bh=nt33jXv8M86rIzb2RwKljbCw8sZW
	eysag7Di/NWoS38=; b=fLNAUu4BzwSK/Wzd4ZTSy1IxFtZatZ6SraYKlEyFGY9Q
	CiIJIPIgO5J8/M8wt3q0VfJkMTnYJK2Qy59SIOp7PbFLBWu8IHUxDbu8h5wOxkEr
	rifxlVjtP75KNKGoBEGwW0ZXpJaSNBmPynKHHftU1QzNqaqAguEaZAjRjLWUGSI1
	3a6Lkg8tyVorbjrclKxUQp7c7u3wwVeOacP5dcitmc3VKmkpTuORhakCI1cFp/0a
	UA+ZaltluvtcX6SN9QtJJzl3uMkxMmx1xv/MeXrVIszi56exnUohNyWTgHWb45/f
	/T/pJ0KrE1+Wgctc72TspWXv/eWq8WzikjHH4KIP/Q==
X-ME-Sender: <xms:v8D-ZvaXWDmYPvldciDCwjIZP6HaSYb6m-SzFIVIgR9TALcmJWn4uw>
    <xme:v8D-ZubT_bXVlQRg3ZYY7WLrPXZktKPW02Rpn8y1Y-YQ3DkG5flyoFcV-L8hobYGo
    x65OiKIDUOPsCVI5g>
X-ME-Received: <xmr:v8D-Zh813EyhDj97UGfLaTvlxcZe29aDVh3-xa8B1y4zqhk6xhVyOcz1Q1k5d02gRTniDKA4j7J5M-Ob5soaysYcB5lh-VpfLOi_A3o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvse
    hsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushht
    hihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    esughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:v8D-Zlrk87DV8KIb3QZ2WlPuj14ARTJdidZnLULuQFx23ga4RPViYA>
    <xmx:v8D-ZqraPEIDFbh2NVt7MSJyCVgRLkCApfhwAo4F3KAZdxlKFrLWWg>
    <xmx:v8D-ZrRy_GExwiRiKiEXzDi-o7HJy-3n8lND_HGZFjPb378ZEZsr4w>
    <xmx:v8D-ZiogGNAzThx4067P3FYrSStDFb8wCjtjCJx9VE1pCl3EOiyTjw>
    <xmx:v8D-ZqIjvGerYho1XKKiZYMW-1xfmifr852JAQ0y-l8wPRde4-O38oCM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 12:05:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
  phillip.wood@dunelm.org.uk,  git@vger.kernel.org,  Emily Shaffer
 <nasamuffin@google.com>,  Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [RFC PATCH 1/1] Add a type for errors
In-Reply-To: <CAPig+cQjk5_VJ-LNc9Hx3Q4n6H5bgg5cAztWhFpuweG8wFTjMw@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 3 Oct 2024 01:14:11 -0400")
References: <20240930220352.2461975-1-sandals@crustytoothpaste.net>
	<20240930220352.2461975-2-sandals@crustytoothpaste.net>
	<2d2f14ea-cfdc-4b52-948f-b42c8f6e41de@gmail.com>
	<Zv3DehUxEN6SJI1M@tapette.crustytoothpaste.net>
	<CAPig+cRkA58wr_Pn-uhVM0zFA7B0hnArXDeumrjnWrgBbG64Yw@mail.gmail.com>
	<Zv3IHd0c4_0NPjOK@tapette.crustytoothpaste.net>
	<CAPig+cQjk5_VJ-LNc9Hx3Q4n6H5bgg5cAztWhFpuweG8wFTjMw@mail.gmail.com>
Date: Thu, 03 Oct 2024 09:05:17 -0700
Message-ID: <xmqqwmipi342.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

> Your proposal uses Rust as a model to justify the API choice in this
> RFC, but Phillip's point was that -- despite being perfectly suitable
> in Rust -- it is _not_ ergonomic in C.
> ...
> That's why I said in my original response that I didn't understand
> your response to Phillip. You seem to be using a non-justification
> ("other programmers suffer, so Git programmers can suffer too") as a
> justification for a non-ergonomic design.

The statement may be a bit too harsh, as some may not even realize
that they are suffering anymore, after prolonged exposure to these
idioms, just like C folks consider it is a fact of life that they
have to carefully manage their pointers and the memory they point
at.

I do agree that "return value with more details in the out parameter
whose address is supplied by the caller" is a convention that is
easier to grok when written in C.

Thanks.
