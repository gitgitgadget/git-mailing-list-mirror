Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB241DEFE7
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759508441; cv=none; b=ghpJOPs1eWojKPTvAlqvZWHGRFmJ6EmTLVzbCFQ5qIpk+KH+2fyYpEGWD6kkXuoKHvSVi52oES4LdcT94yxYEFp8Jd6gB0/dS/TGcP3Nxiqwe9Mu29EH1bHenN3YEaVrzIMXtfkc/wmjTfzy6iizWj3uSyWtyOryPRQnzoEVYmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759508441; c=relaxed/simple;
	bh=EByCztbuakdlUF06Pk2Dy41ZFprbuy9nItHVYR1AfB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CTX0LGp50RSh9pDpeU7gIvWVsvoFgt6Twzph5dntufgcmmfJUrOeByLILQqQ+P4dWYhrKjzONTBMTSqVLnuEpoAwKFZcRFgTSN9dLxM5z+Wj2wm8aDe50iGW0d2XD9f8C8gUb5S2Sr6eAbibVwib5xjTM9p0UYXeZpAg9qG3CK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GwtW4JDB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wdZmCmbp; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GwtW4JDB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wdZmCmbp"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C6E6EEC0281;
	Fri,  3 Oct 2025 12:20:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 03 Oct 2025 12:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759508437; x=1759594837; bh=gZdIXo4WkT
	y9nZBOLlAepcOVNRrwXMLXp1s9F9ARJno=; b=GwtW4JDBwPQvyCYg0aqzXzfxzZ
	3IYd4z0PojJxAjwZu+6GdRxJGPIkeq2blOAJMBixJckgkcHPdFxJpQ++y8ahN3sQ
	lVK2521ptO5HTaHrip/T/t8lXFZP+7FdT0M7s/+/IZNyB6+tzdG8hLWmbSH8CdTx
	EmmWcDb55ss6valJliLrekPla1XJ2/qst8OBU5j877fPp00Lkqc8e4mxpC7OIKpM
	BTUisi+d4jhGtYo56W64k4zVeApGKYuDwpIFudQr6F91xo2O82p0627gv+qEnJlw
	Ld89OrGCbbPPMXNMA+8YrOlEdxvjTkfGzTROAiB997ELKJ/wnwNNEoOjZmLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759508437; x=1759594837; bh=gZdIXo4WkTy9nZBOLlAepcOVNRrwXMLXp1s
	9F9ARJno=; b=wdZmCmbpwZ3LC5hTp0DG/7kDlOd06XQ5q7SEHE06DSGbt38SSrq
	X/6D1hC5fv7IoIOr8az5FySyv1P0R70L3UOAqtL9WeF6M0A2JdLROu/+ksSU8aUX
	l3aLi44N9BDWfzfxibD+0oomYKRl4SO9GVSjZFRiQgpEDO7f9ba9+a9DBXLTxmB0
	XPjzw5TQZGi+oIfW1FXc4Z3WMt+htPM1Po4irgosnV5fABnxM8U7w9re4r2bHir0
	+J8pQnsA4f/3PSwGVyO2rFvCIrn+hJQ7B101eroiM8yjIrAK/uxNhOV1y70d68Q5
	HRxsdq5SU92BASUyhZHozvqNLqv2tyKLkCQ==
X-ME-Sender: <xms:0_ffaPWA8wv1HPxLzjsqUtpm1DXGw8-W5Mk2AVqdA0H8RQ6Bw3qfsg>
    <xme:0_ffaEfbg7u0riXj5hYNcmBYrYfcPJ-2o_HQV_jraaZOeolhb0B0pVw9qyY_mve4e
    7izKcizZis0r8RC_tYKhk30z31XAus69sAJlBNB_TktLQTJYC3_sw>
X-ME-Received: <xmr:0_ffaLLcJhNhOmbyZbtunNWBkgWVUOlYLCBH_BKSDiXPerpHyq8iO-ubEss8_Ai-9NaQTfEOsMGxbi8G2iaNB_gyl6zDbX0sxl90>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehrihgtkhesshhftg
    honhhsvghrvhgrnhgthidrohhrghdprhgtphhtthhopehgihhtsehsfhgtohhnshgvrhhv
    rghntgihrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinh
    esghhmgidruggvpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegthhhr
    ihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:0_ffaJwTbGPMzGdpHX311AZUICncTVCUpr9XHx3AAhoUlhWOSD8hww>
    <xmx:0_ffaJs3FNz9GupIhyyZ8dydsOYnSnYCHyl3Vb-gvFVVz4rt_FCS_A>
    <xmx:0_ffaEDre1S7Z_o1o6uZeZTonZ9mGrjKKlU5WUUcsCBdH4c2E8I2ZQ>
    <xmx:0_ffaDGR6iSgumd1TdobGMXEatvu5MgfDwrwgrc7gucI4xoT9GXg6Q>
    <xmx:1fffaKP-gGGsG6LOPE5i9eqGjmkRkqdAZ1B8jf0AZ5HFSkA3fTn6mvnS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Oct 2025 12:20:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Rick Sanders
 <rick@sfconservancy.org>,  Git at SFC <git@sfconservancy.org>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Patrick Steinhardt <ps@pks.im>,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] SubmittingPatches: add section about AI
In-Reply-To: <CAP8UFD3wc-aj27Q_kFXvknJrpa-ySWbZiPmNCTMboA08=HP+xw@mail.gmail.com>
	(Christian Couder's message of "Fri, 3 Oct 2025 10:51:13 +0200")
References: <xmqqcyalm0mh.fsf@gitster.g>
	<20251001140310.527097-1-christian.couder@gmail.com>
	<xmqq4isi1gpm.fsf@gitster.g>
	<CAP8UFD3wc-aj27Q_kFXvknJrpa-ySWbZiPmNCTMboA08=HP+xw@mail.gmail.com>
Date: Fri, 03 Oct 2025 09:20:34 -0700
Message-ID: <xmqqjz1cufcd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>> A milder way to phrase this would be to jump directly to "we reject
>> what the sender cannot explain when asked about it".  "How does this
>> work?"  "Why is this a good thing to do?"  "Where did it come from?"
>> instead of saying "looks AI generated".
>>
>> It would sidestep the "who decides if it looks AI generated?" question.
>
> I don't think the "who decides if it looks AI generated?" question is
> very relevant. If someone says that a patch looks mostly AI generated
> and gives a good argument supporting this claim, it's the same as if
> someone gives any other good argument against the patch. In the end,
> the community and you decide if the argument is good enough and if the
> patch should be rejected based on that (and other arguments for and
> against the patch of course).

And then who plays the final arbiter?  One can keep insisting on a
patch that looks to me an apparent AI slop that it was what one
wrote oneself, but you may find it a plausible that it was a human
creation.  Then what?

It is very much relevant to avoid such argument, because the point
is irrelevant.  We are trying to avoid accepting something the
submitter has no rights to claim theirs, and requesting them to
explain where it came from, how it works, etc. would be a better
test than "does it look AI generated?  to everybody?", wouldn't it?
