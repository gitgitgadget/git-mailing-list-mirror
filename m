Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ABB1E495
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729602840; cv=none; b=m+7Uqd4AnKHoGovO088LhjvsA/EQq/YDqil9+Nvq7I0KiC7sMJiuFMgNcz8L8h9mxrN7/qj5jpmAixG8HJNK1h2CKAIj9rs9D/4z/hpalj63HnvoergRFkL6Td4MHGiPrLF4zXx2/0OPuYWJZMGg1OiVmM1co4EtpBJ43+zM7rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729602840; c=relaxed/simple;
	bh=6Z7FOtuuw+77p54x2mbNxF3RhyvLBIy3I6/KyEyQERI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAySEWX//GuMy4ahIsz2vrgfPL74FmIAJbl6qfd7VJjbsBnYiG+ubC3QdRoFCbwr4LNx9qJwNWfrCOCa5Hoc0+7fvDBOH+MzuhDTyhvQX9T8bqYscBEWY99ULU0+zCVEZxvD4/LAhg4JpPkoidkO8pqkxgUjBwp9JiK5gW68330=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=u3O6QR+Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m4jV6x+f; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="u3O6QR+Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m4jV6x+f"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 267AF1140147;
	Tue, 22 Oct 2024 09:13:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 22 Oct 2024 09:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729602837;
	 x=1729689237; bh=YXnQZfDywt3VW0jdQhmukDqnIsEhBEAvM6faVLM037g=; b=
	u3O6QR+Yvby42RjjyZH5x3pyAXYPJclGyl/MNu9pfnbADVqREXb/u0Q7UXG4hao+
	/GbZKRV1mlDHrZejFVLLm3K8r4bg0hF34jr6d+iOhcQEeBruKUDadp81GyJ6qSL7
	xlJ6c2f/P84S6Tl91uVASYFnoZeUmdco2RYbSE67jonzcONId6hbXDZoN3txmt+E
	wbvjzdalWhFDAD6jrwTRQzrkLntnPL3EWOlNL3Ex73quKyBjPM7MjuJo5/Dr0plN
	e1wBq0P8wT2wc9W+t5I8XGVZXWoNSQHtW/SalMP80YdozB8x9kWgfkqG8+X+mBIJ
	YI6PBQEIY0ldaXgprUG80Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729602837; x=
	1729689237; bh=YXnQZfDywt3VW0jdQhmukDqnIsEhBEAvM6faVLM037g=; b=m
	4jV6x+f+ET/hSeKplSAIyWCp/E8lFioMf0r9SvWAPF1ePMcML1YoZqVDTPFQTi0a
	vTd3ENHgm1yG1RUQfLnHnL3UnMgU0c2xboAOTlg8UYhLhoQwGqZUV4/3dMbUWAqu
	TAVmP4kCXS+TeGVaXmzMl3RyQw0SJS4PIICoRAwv12PVsyfFBb9EemKL/dS9Vo12
	Tgy5mM+KCQMe4sXsP5NUqivXWHJCo7ndRjbIL8vQSUJib6Mb/bm8+6vRm9tjxDDe
	N3JC6qHy/8nvJqJAFlr/9PET7ptCKl79kL8qYr1KsBRU8GRlTmT9jdJeH7RzCAfZ
	sFTClopOkWwTlkja50c1A==
X-ME-Sender: <xms:FKUXZybnyifI73Xh9n1fKxkJQ7gangn111HKcqGIoNPNDNbVitEZjg>
    <xme:FKUXZ1arDpCuB1HmWPDPntVgES6RLHtskEUAJgzxugVgHQXXCM0rR4bp41B0L2cq2
    zJeNMwcUPPQ8m1Acg>
X-ME-Received: <xmr:FKUXZ8-P1gLfVuqhjEhMs3zch5-JxFlh4QvqISvI5JcNWv55QSCvO88DuYdt3CEA2P2dt-OHIfh7cH0rxxaaqhWPOlghNNXKPIxWlOKfqykT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeihedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FKUXZ0qhRlTurkuYzl5BanHBDrLgzh6FucpqkciUM3x0fytjSNGzww>
    <xmx:FKUXZ9rsdm_elQk5lCyI2YJexgWNyrzRJaryYIHJ9mLqmJQQjHc3EA>
    <xmx:FKUXZyRRTTQMqqBZ3032hlQiFkn0yQ3fTuGiO3TKKXG7prvZLX6xsg>
    <xmx:FKUXZ9p1nzMly0AKuOfJ73m7mjTFVRvW4XwAqLVoD1pvPIcL16Tmfg>
    <xmx:FaUXZ0U3Ob_N9tUwgmcxzU_AKDyoKg5hIRcX6RDbk-Hg7fdzS1BZEej_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Oct 2024 09:13:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d018a7d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 22 Oct 2024 13:12:23 +0000 (UTC)
Date: Tue, 22 Oct 2024 15:13:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [Outreachy][RFC]: Final Applications expectations.
Message-ID: <ZxelBccIFk1aXP3l@pks.im>
References: <CAPSxiM-kf8U=vzp5MoD3tUuOtnNjcCgPhLdriyeQo5CGf=EhyQ@mail.gmail.com>
 <ZxeWDTFHpHmVePdF@pks.im>
 <CAPSxiM9WQMFu+qTgR9LPk9erVUFgPU5tqRBobTomOJhm-hiLAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPSxiM9WQMFu+qTgR9LPk9erVUFgPU5tqRBobTomOJhm-hiLAw@mail.gmail.com>

On Tue, Oct 22, 2024 at 12:54:18PM +0000, Usman Akinyemi wrote:
> On Tue, Oct 22, 2024 at 12:10 PM Patrick Steinhardt <ps@pks.im> wrote:
> > On Tue, Oct 22, 2024 at 11:45:14AM +0000, Usman Akinyemi wrote:
> Hi Patrick, thanks for your reply. As you may know, Outreachy has a
> kind of form for submitting applications (they have some set of
> questions someone has to provide answers to)not like GSOC where the
> applicants do not fill any form for their proposal application. I am
> guessing someone should add something  like self-presentation in
> answer to one of the questions as there is not really any question
> asking about someone personally. I think what is near to it is about
> previous experience.

I wasn't aware :) But agreed, previous experience sounds close enough to
me.

> Also, anything about applying to two projects ?

That is a good question. The only thing I could find on this was the
following statement:

    > You are welcome to apply to Outreachy multiple times. However, you
    > can only be accepted as an Outreachy intern once.

I'm not a 100% sure whether this means that you can apply to multiple
projects or whether it means that you can apply to Outreachy multiple
years until your proposal gets accepted.

I've asked internally whteher this is okay and will get back to you once
I've got an answer.

> I will start working on my final application to get enough feedback.

Thanks!

Patrick
