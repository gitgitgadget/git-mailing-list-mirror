Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653972BDC32
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003883; cv=none; b=ljX65CjNrySkcmKcAXXXtL9cGyy/hnLZ77affFzuf5rBpj+d2l9zIkquRJJ+HUhokx0wWUihrQRomdQ2MN5MXeTbOZW81IzhNw4KAyQOu6YnSKXl3pRFw64BNjSThRtvuXr3rbLoiR6CYWtncu9KGP9oaIDPNB2OKarLBT9yhd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003883; c=relaxed/simple;
	bh=dVSKW07nQqkS5Kmsx8maer8FY+7YZsxtJWztpah/cVw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pp2QS7FuaBJXAAiM5djd2mgFaSAlqouM9VSlZl1k543ngthfUvwByub3ZkXUcOuhiEd3IQKClCxGqrtg+Tgs6nm5s4G5ToiS0KJYPqg1v1UMtxV6zlLaesg1R4Wmnb32dMIffYZtEgvtWdZoT2hDgha2jx43jmAHy8iXOTQSGp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HLt5YpL+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B/iJDHlX; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HLt5YpL+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B/iJDHlX"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9795D14002E0;
	Thu,  4 Sep 2025 12:38:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 04 Sep 2025 12:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757003880; x=1757090280; bh=51moDVAlT8
	9+GxKzmy87m0KTwBqIIPH76TfCpEBA7zo=; b=HLt5YpL+IbjZVuXvWrJW9T9TUF
	L/Kx5aD3DOeBd1LSBrPcLqsY8+ZWwqkoSi9rgFi6qXx+vxHKKSq7EUaf8qcxl11+
	ih6fxLq0Adk8EUlrnVlwTOYjAZ4Sl3oqrdkhJUWyX7lW2ECbgJMMB6FH/mKUIh21
	fO6pxwJnb8rIMpzLSyODQ+5ce0QWIZnKWsgsDlqgPuxdEmj/OICfHnEFjNjrwJmm
	Nh27yYgaocJy1DmKLKL1RE0xspabHbuHJdcF1PvtcD+uYGd/dtvb9S2aYiPX9XLj
	gi4YLwbeZaR3DwJWdLxctfiakkcBlKEBKUwFXL2nOnX1kr6K5j5KcBNa8tPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757003880; x=1757090280; bh=51moDVAlT89+GxKzmy87m0KTwBqIIPH76Tf
	CpEBA7zo=; b=B/iJDHlX74BU1jYHQ0birxMzjF8GoEiSSwkf9mO/KRMgGs2N+Zj
	FREC/n74fGoC+LxbJPT1YClvDrqluV8qs+netZkcgRzXjL5egNBIyUmecSkiPYbV
	snO/oPLN1glECFOru1AhbB5klxL+dAjiT1Nfh1omvFOXbSQCcfpps4haTdu+AZ8j
	6o+tV3gJ/AKiPz60o3oBNywAv9okzvlXg7XmvfyQwBQN8lK8E502dbS1R4Lhoup5
	3EEMaF6aQladOFKyfT85W5T2BUcsJKGTxl44ND8CZvb5KKz8g0jlGm6AQ9EZVg6t
	wtqVbKa6lyK6KpYFyMtrcuAFmVgArdMXBZA==
X-ME-Sender: <xms:aMC5aBd6MSTspE174NPPOjjQ_Wwd5LwFDgY_tNCb5L35reoQUxDjlQ>
    <xme:aMC5aKs4CP8932IIB8hZg41CfPjmwVaMK-fni0NsKc4tBbNbzFwwoydWOFslEj6R8
    P_Lajc1uxQEhFy7qw>
X-ME-Received: <xmr:aMC5aA_trgbpbd_n7vpehtQWvSeNBK1_jktF_hWXO88-DDj5GeK_hU6cMrVTkRMseL1WFXVNrvogdvb6zVsDA2em-wx62qnZYb-Uegk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdejledu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihloh
    hrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:aMC5aF0mYMLtWMnlhYkzNHPykG4zMxahmyPrHJBRMvNSLwvJKW00Jw>
    <xmx:aMC5aFA9IC1VtBmoWfnx7AWzPsU5sK_bbYk5lX632O3r7MIY8qKQiw>
    <xmx:aMC5aBdDyWmKgSKiJLi_oLAeB5AeiwQa6Q_QHAHIB-qtAnTKRjy1dQ>
    <xmx:aMC5aC58nZ_eASsBq82wkXk8qcQRi8ZHHvLCqKWy5y97tkQHE7gUBw>
    <xmx:aMC5aBMefqKZlBHwQ2-FtCoAWNEh6VQ55Lh8A_zXg2x359cWBHJoZZtW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 12:38:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH 2/2] upload-pack: don't ACK non-commits repeatedly in
 protocol v2
In-Reply-To: <aLmJOdxUYiyHpiLA@pks.im> (Patrick Steinhardt's message of "Thu,
	4 Sep 2025 14:42:33 +0200")
References: <20250903-b4-pks-upload-pack-repeated-non-commit-acks-v1-0-4e019af4dddc@pks.im>
	<20250903-b4-pks-upload-pack-repeated-non-commit-acks-v1-2-4e019af4dddc@pks.im>
	<xmqqtt1ic0ci.fsf@gitster.g> <aLmJOdxUYiyHpiLA@pks.im>
Date: Thu, 04 Sep 2025 09:37:58 -0700
Message-ID: <xmqqqzwm9nrt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> ... when the
> server ACKs an object there is no reason for the client to go deeper, so
> they stop advertising any of its parents.

Very true.  I did point out the difference in behaviour, but I
couldn't actually figure out what goodness we are deriving in this
code by marking grandparents (and possibly their ancestors) as
something they have.  Your change in behaviour could be seen as
stopping us from making unnecessary operations ;-)

If the other side is mischievous, they are not limited to feed us a
commit and then its parent in the naturally expected order.  They
could feed us A and then skip B and give us C that is a child of B.
Pre-painting B when we got A from them, in order to prepare for
seeing B (which we can return without doing anything) in the next
round, would not help us all that much, if they give us C after
giving us A, as we haven't even heard of C yet at that point.

But in the normal case against sane clients that do not skip the
probes, marking immediate parents (like B) when processing A might
be helping?  I dunno.  I also somehow thought that even normal case
we have an option to skip the probes in order to converge faster,
but I am misremembering.

cf. https://lore.kernel.org/git/?q=upload-pack%20fibonacci



