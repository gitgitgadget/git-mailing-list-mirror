Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFC633E1
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 00:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748910972; cv=none; b=s7hz47stukLBdp1qqKAtfZ6/kC8ysgJOLwWOaOS+XTsKokGRsBlmQboy/Iz2i+cpKfSNxk3vhCSSAaH5a5cQeT94t8UOspgoaIdY3kFq36beP2GYv+6NO4Xn+MHXB/afBaRF8sdCY80SnUvLbcNUEme8Cx8/Pb5+jLeU8xwR530=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748910972; c=relaxed/simple;
	bh=EilRYCrYjkImv07Yv2CQnNYCCawivSejA1mRDyUSZ5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LLd967HMV2E3+tV3Rf5I2QVfY7ZeAsJ3XXPigDsNAtU8CbGA7l59UV8ZBDP2RegqJXI8RhohPnrF12Q+vYV2OgMC6ICA/zM0HvxpEMLJnLAmbSM915zUSsA/w4zyoFVbIvLpYnwfaLuzPSsoAyU5F8Lbtz90aOEzBfHNYZPh7Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vHP9KI25; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WZHEF+RN; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vHP9KI25";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WZHEF+RN"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BFE1211401D2;
	Mon,  2 Jun 2025 20:36:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 02 Jun 2025 20:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748910969; x=1748997369; bh=zRHtxXohvr
	otAjpsj+oVZF9/+sg3zOoTGsSB30TQ61E=; b=vHP9KI25amBZZhEn7NMMDVZqzp
	pkQW8cF/oDRO66SLs+Yoan8faogEzcF3xfYumJDplRHB9KtlFj8PGNARTt/+vuE1
	iYDF/5Rd3tXszfg789VIRqlmBKmceOR4iwvAKLCJ/t9PMaGgvmrkxyEmLiOdrtQN
	+e8FIIsBOSVUlw7AN9WbMSo6OGtrb1WZ4HkQKxXbxlG+/REjY1ITbk9JXdLq+BZ9
	1M2hvrmG1LWRKjaVlDRW9HEqJG6vizvfuupLxGcA1CQpzZ5IH//I5zLKBlFf2y2x
	SAOhXL0Q3nW42ceCvU4MovUfAzMhHbGqLuSrC9+3eJaZ4mAUO0O4inxCP0Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748910969; x=1748997369; bh=zRHtxXohvrotAjpsj+oVZF9/+sg3zOoTGsS
	B30TQ61E=; b=WZHEF+RN8hhnIbP+D4EsApWF1R1wvle8C7uUl8yozOeUITol690
	PVDo6jyy+QkzvoJYkf+1ED1dAxxrlzKHCT5/JZPTS72PmTBbZ1hb9Q5cyZ+P+PFc
	kI0um8QeJ5RBm3mXNIH4sTUGtb1/OkTerCC+KwHXh0vLuhdO2ghPVvccuY2mL8mE
	gmvx6V+ivTmAoPc9BJ7P47k3CQFEl6GTpK9RktJMQJi5AzZYer/+LAgmdayU/O5f
	2UzRt0nSvv/yesRUhzuxdtzBcMTkpL815H5wZYLQZ1mq34qbyFQgiCj5hperQdXC
	RFd0muJpntmoS0Z3rv5BO1kPgyob4ymIvFQ==
X-ME-Sender: <xms:eUM-aPw0YgEXYzsx4ZuHXo4aYWaTPCz3VusFyN9SPewD1nw0uq6COw>
    <xme:eUM-aHQTsXpMqsrQdXwt0OAn14-yIWH5duV4xtviIV7xe_bf2qFXNAgLAk1qELK8t
    MkP0Bam7UtGZUedyQ>
X-ME-Received: <xmr:eUM-aJXYL9ON5LJu6dioqvCrY6SlX8rEiihEQZBazCiQt9QPFYvwGCAMMKCIDqlYiXIq24bg3dP8efANib50fHYljdqT2OHNUSMe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefledufeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopegs
    rhgrugestghomhhsthihlhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:eUM-aJiBNAzaJaqmG18KnK9s8dEsrAOv1zZPj5VHROcVnMH3pWZTpQ>
    <xmx:eUM-aBCCLeOzxH8maxWeVKquzpRZ1UdbuMMS7vtcrNI2B1prjmGdAQ>
    <xmx:eUM-aCJd4eRWrekU62y6Q7imJPo50QRe4KvxPj2IAf7JbrbImr-mtQ>
    <xmx:eUM-aADFlrdrOYpvx9X2ja7FsEg0AzaRYxO6x393wXVsrVtRY3y-jw>
    <xmx:eUM-aJF9hDafwH-fX4AiHFbGNZcwJU_5u9pQdgLhcfw4_8CXLMO2HgI2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 20:36:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Collin Funk <collin.funk1@gmail.com>
Cc: Brad Smith <brad@comstyle.com>,  git@vger.kernel.org
Subject: Re: [PATCH] compat: fixes for header handling with OpenBSD / NetBSD
In-Reply-To: <87wm9ut3uo.fsf@gmail.com> (Collin Funk's message of "Mon, 02 Jun
	2025 11:06:55 -0700")
References: <87wm9ut3uo.fsf@gmail.com>
Date: Mon, 02 Jun 2025 17:36:07 -0700
Message-ID: <xmqqfrghslu0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Collin Funk <collin.funk1@gmail.com> writes:

> Just one question about this chunk:
>
>>  #define _DEFAULT_SOURCE 1
>> -#define _NETBSD_SOURCE 1
>
> Why remove this definition? I think it might be useful on some older
> systems and seems harmless otherwise.

Yes, it is curious.

>
> Other than that, I tested on OpenBSD 7.6 and NetBSD 10.0 and this patch
> fixes the missing declarations. So:
>
> Reviewed-by: Collin Funk <collin.funk1@gmail.com>
>
> Collin
