Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F9623958D
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774913072; cv=none; b=iodXhWjoJqcuZk3ZrnQfEkLVnXdIR+PHOCtS0AtCTPCL9zCgGtJ4EcEN+ggTzBDKxGRd+d/+HFz2VbCzFUJoCe1pm/A6TIz/XhZ+POuflMJTem4NUhgO94fgmIGnnSRjiiJisUhKwzSXCBEkEHfh5Pstn/HC1hMHqpyiutLR4K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774913072; c=relaxed/simple;
	bh=QVbv+opbdu5/c4s5dj/uoI2Q7qF5r1mdiuFUft7LVaI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tk1R1QLVqYWB0KqYRKwOQMWVDM73uYL7E5QpklE2gLGXNVhmQ0szxwaoyrmx6zhHkzLMOkSltQhht5UJTQbNTSAnC34JR7RY/4euThLlF+OhE9+jJKIlnAklyRHeXu8cHk8Rzl315ms+ehCI1JDfljU5xcpZ8KHevuPZylkb8Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UAVliOeA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4Yr+8V1R; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UAVliOeA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4Yr+8V1R"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 83AD614002E8;
	Mon, 30 Mar 2026 19:24:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 30 Mar 2026 19:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774913070;
	 x=1774999470; bh=gYHwsWK1oZgl86vYiZdaWI4uZ+PJ0iyBIuT9S415H0o=; b=
	UAVliOeAn6ExUn6WMbGNkBWe1SxAVBwESHpzifVURKgtwEh4wpRaWZ1+huH2bRX/
	QkLnZ7xyww40kvalsDgWA+2SMPz2clVn6F4geyt0fGlFl+nR0qfnZCj3URTLMJJ5
	R5SxfCF4RJxWvd4oy8hGVNg05j4hC+5w22Jhm1WOZRw6XnScseS9OEUsVICYFVQ6
	NcUpaJo2VqeqWB7x4Y9fSDKs1M+B9dqhCbwFc5kX0FEkk4hIJelvFDbQYtVnHUIr
	BGkSjgBYr+NDTA21ZqxBQqWEQJqAxjCnkuxYMz2UbsZZvvRXEbmzJ+UBLCOePaAp
	m3/icF96Wl4U4P3upyhvHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774913070; x=
	1774999470; bh=gYHwsWK1oZgl86vYiZdaWI4uZ+PJ0iyBIuT9S415H0o=; b=4
	Yr+8V1RVK0BoajbygaW0HeigLJJ3HSxvdy/88nr00pbtnDF8XWHSP2XLeFmec17b
	uG2tOvFwbtyctswe7ZYFOOjvEfLokaDqqysIU4g0FBdB5nm8xMKYbxsglauQOOw0
	GPXEhDG0EgDVdrjtYn00PEvCAPl/eHLzgrFsMnzE2QdZ0n/DojUsy6G2fEEjflgo
	VQqcfpEtIVak0prn74HzkSU/hASqHiXgxA59Ka1V8QoeKOn9qs+TPbIp0/SUi4VA
	BOX33zl5CtNPsJHMdmc5CK2woRPHgHI58H6CiemjnQqvOjMc9PqhvPFJGMzim8Jl
	Zsoum+K5cEBi5638n8Nrg==
X-ME-Sender: <xms:LgbLaUXCKaNR9bTuNvIbIMhjHsf2Ok_fRBITrNhND-JqaZfPPoefGw>
    <xme:LgbLacT2XuIx7np43TE66OSpD5fsJhNpl-tF1vMHpHnSt_D5KB-1pLWgxZE5SGuCO
    -G_LX6Ap2Y_rJ_jE1cRr4KDOJYyfZBiiYc0_GGE7xL9m05XEFjtOQ>
X-ME-Received: <xmr:LgbLaSOElnEZyWLZwUHxmnEDgFA9tGLi88Ceh9SDcXw11xJO8-qZNpKVy2_lfmMwx66vLKD1goozH54QNeLBhlJC161o2DUQJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedtvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhgrtghkmhgrnhgssehgohhoghhlvgdrtghomhdprhgtphht
    thhopehlihhnuhhssehutghlrgdrvgguuhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:LgbLaaQk_6WHtAvCGHN8C8kpAItpSHOQWbcSwVCO2XE4L3gqmPEGkQ>
    <xmx:LgbLaQjBM06HIJsqqbhsRsqj9ha1oeka-GRZyKtKlrhD1Cn7JEJb8Q>
    <xmx:LgbLaT9_Bj7LCfG3YZlcTgRFBAtXYEuyQ7JP0RNZezPh0kV_QTeZ9g>
    <xmx:LgbLaXE-Mz3_y7IOBbBmyPruFMr47Sdls3G7sl8gVqfa_qfPjngkzg>
    <xmx:LgbLaYDJkMhOpvleYCSJfIFmzfo0kl6CYOOkUSrelbit6k785VxcGFJ->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 19:24:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org,  "Christian Couder" <christian.couder@gmail.com>,
  jackmanb@google.com,  "Linus Arver" <linus@ucla.edu>
Subject: Re: [PATCH 1/2] doc: interpret-trailers: stop fixating on RFC 822
In-Reply-To: <2ed992d8-7314-423d-828a-5801f4de2471@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 31 Mar 2026 00:56:44 +0200")
References: <CA+i-1C1DM0CHoFJ0A5CchQg=qDVLi_SSiZqcd0dxsay-Y94WTQ@mail.gmail.com>
	<CV_doc_int-tr_key_format.533@msgid.xyz>
	<doc_int-tr_key_format.534@msgid.xyz> <xmqqbjg56jhb.fsf@gitster.g>
	<2ed992d8-7314-423d-828a-5801f4de2471@app.fastmail.com>
Date: Mon, 30 Mar 2026 16:24:28 -0700
Message-ID: <xmqqmrzo6gur.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> IMO it’s best to stick to the normalized `:`SP when writing as well,

Absolutely.  That is why I suggested to mention colon somewhere when
we talk about key and value.  Your 2/2 with minor fixes you alluded
to in your review response made the worry I raised for 1/2 go away.

Thanks.

