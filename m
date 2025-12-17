Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26353A1E8A
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 23:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766013417; cv=none; b=f/ESo92L+wYAwcxGuJmeMFIM5/i5KUn6AJIB6n897JSMuQcY5n4zkbEY9aXwAX1BmHrJtKijUxBMoTfOj4Q7nH21zXTah0KA+wNrcrC2SRbiFpoKUGPQB+SvDYn3tRFc8gAAsKxzaqh5lhuXmnwdxttwOU/jbht/gHe/QrKaxRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766013417; c=relaxed/simple;
	bh=q7u47hq0E0Fs4nKM5UFzjKJ2aeFEnCGDCPFVck21q4Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qBSwfcvc9RjiGDYjHbrwkVMjvX6R38ZtDnGWYAIQzRPA7N9M4ykpKzJ+AjleSgE4/iXOpTLZUezJTqeONRMuv0Sf4RK/mO3dL358plGRd+SPbNksSplH9xuUF3bcxntWysZxSB0nckguVQYmtx5bNGbnD6NhhibMibPVoqYE2aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KvQdPMsm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DyuD1sHw; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KvQdPMsm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DyuD1sHw"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 075D0EC00D9;
	Wed, 17 Dec 2025 18:16:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 17 Dec 2025 18:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766013415; x=1766099815; bh=hL5g4+AfNU
	A+1mc0PE7hz8osMkudBq0OUQiFie3H8ik=; b=KvQdPMsmwYAdu5gVpdEw+4yasX
	a99pbuB0TyvdoVgnhOYifWuMQXX+4Uyk6Q2SZ2qqP4VyNlBnF0weMChH2txbIPpv
	ht/xgqlKstCjlv7mF87b5NJXzi1gthTQMAbaANt8LZrBf+fIqPSwC//47IC1trqz
	gIPV7X5mFAaHJ/5Zt/LuWTVJe1lH03aKg60AnVQXzlWuwDbSXQQOK54pDuHgIVBu
	muS+ISrzcX8/FmZI8L1POo3XzYCgEsAhy1fvHUb6sMFm18FPiK2BxJrgYILjZ0G/
	DtGg1q2qZeudqjDqE06SnwdE2FaAhdZWPLzxFnwTXIiQXXGjc+7WRidm8QoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766013415; x=1766099815; bh=hL5g4+AfNUA+1mc0PE7hz8osMkudBq0OUQi
	Fie3H8ik=; b=DyuD1sHwfcppivuPK9LVYNCqgcthLadG5Yw34p8YnxSuOjwoq5Q
	490hA3hLotqoF5BMeFKWFG+9wELI0nw22PwlCJr3zQqjLQXnkFUDpXc28nB+aLPr
	HtnObPxbUYrQT4K6g15y8HHGqWLAc3qCbFTDFy7pStk4VWck7juvADBFkM1vtiOQ
	cobI8h2ZqDaWpOMYcjRrq/odT+BfaxLxHUkkgPKilLcWDwWtDIy5A92w3G4iXkSM
	sZOPLdDbZiTcePOhoFZC8YtTpH64HWr6t2LSK6T0LSq2Ckuh9zOlJrLGctn9NZTK
	TlrNKfB3vOGBLb1J4E1xmZVXurR5mvEfD7Q==
X-ME-Sender: <xms:5jlDaQRKp11txE9G1EmKK_KZkrEqEulCfSfOVRBwn98zTGz_knzU4Q>
    <xme:5jlDaUoCl_tZRvysYPh0jjmYz98C17IqDaaaIFez7caZarp7sWtNOq2OgCJl0bt9B
    oQL6ogMYos8Hs2nVqOZb9MhFvCDXvBn_ZiXDoQoxZ2hdoYtRVvaRA>
X-ME-Received: <xmr:5jlDaWIIpbZxLNjwNH9lfw5YCxXQ6-Sz-aQvbTuDwK5CHhqLtMHqkX0nVsstKqmOY0poQo_-qoVn3Zh5WAzrxhzcKRS9sArl0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegfeekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehnvg
    ifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushht
    hihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5jlDafrHxUWnHG7BRIIyfyyg9rDYfBa1BbC1y-YKyjlivy94f_Ovwg>
    <xmx:5jlDaWx-bsK3jtzEMqXegC0TnIDzetMYQcnPU0MgHydwUGUDBW1wuA>
    <xmx:5jlDabM1LUYz8T3lmYqLp_JcUgS8jxqtFKcBHWM6ioMDHRgwXf6CaQ>
    <xmx:5jlDaT73u5ApH9hZwWVfnt6LxBck33NR9Q4phzwJSvivdM0y3A0tFg>
    <xmx:5zlDaVGXg4imHzGott85K4xZYZeRc9GXmbY4mtyd_mDUwQ1xF2s1VaBz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 18:16:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Elijah Newren <newren@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH v2] commit: document that $command.signoff will not be
 added
In-Reply-To: <7bde8cd7-7487-4270-98e5-ab598b0a91d1@kdbg.org> (Johannes Sixt's
	message of "Wed, 17 Dec 2025 14:51:03 +0100")
References: <xmqqldj48pyl.fsf@gitster.g> <xmqqv7i62r6w.fsf@gitster.g>
	<7bde8cd7-7487-4270-98e5-ab598b0a91d1@kdbg.org>
Date: Thu, 18 Dec 2025 08:16:53 +0900
Message-ID: <xmqq7buk1yxm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

>> +There exists `format.signoff`, but that is a historical mistake, and
>> +it is not an excuse to pile on more mistakes of the same kind on top.
>
> I feel that we should s/pile on/pile/, but I am not a native speaker.
>
> This patch looks good with or without this change.

Thanks.  "add more mistakes" should be clear for everybody, so I'll
change the verb.

