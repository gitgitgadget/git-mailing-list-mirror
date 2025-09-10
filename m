Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA8C26B779
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757540257; cv=none; b=IpUo2OvdKTtLQHY2cJtJ890LUovNMKnQZ70sDFhzKoaobV0VRp1XcWNbzC4PkNdYtPjeNZ4vhZJ/6x2c7dGBmokFONkX5Jt2imke/xckT1b6EzfnnAj6Q67hfqgYG2wFrKGA7afig8IKBEiYpXQyWv+kugqg74Xw7qHAPruBg1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757540257; c=relaxed/simple;
	bh=CJIos+s+rd4Ekt+o1fEIPJg/TtoEOIk2oHCEdEqdt2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mJ06eqaVEH6ZJjj1sDcyb+K1rqk+GxIbPpt1Hp20M1BYYUWKR04y3AOCRsrk7LWBGz2x45Eywr3bWnIXmnqbzkO05tx2UCvMPWZ2IRytz2hihTGmRoLiZNCL0LdmuD0sxwuUClD1wHH2o4DKNGrsd3gXoTy5mezRL2pYw87jKzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K0AubEKU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W52tBMaE; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K0AubEKU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W52tBMaE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EC8511400286;
	Wed, 10 Sep 2025 17:37:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 10 Sep 2025 17:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757540254; x=1757626654; bh=thS8NKJbJ7
	h2GFfHVSUD93I7wHodpSDCQ9bg8WOfYEM=; b=K0AubEKUSTxlV1q2qMlB+LPnQG
	c5tDRgykSRB0ZD+8UL7h3iWtXpioAFuQDsnhAemRmOt0OYTrLDRukHkstYa24p4c
	rf3OuLTjjI1+j/KrRT0IzByYyUESN/hsrdCbEKN4KApVIQc/tA+1CqChvdGdC08Q
	YnKsq9iQXXfV0lrV7Fq+4EL7O/F9DZK8Av/UXfWE88CKMj0BtM3InJVgZE9lqJSz
	jVvKiBm/nGkHruw/keFDKAzhAkAWhBo6h4SXeNEk81pJI7cfuP8DW4ZTGBEmQE6s
	Nx81LmXPOkA8jc7a6ie7l9oNxbHCYg23pburdKK42glsBBBYROgu1ALhYpBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757540254; x=1757626654; bh=thS8NKJbJ7h2GFfHVSUD93I7wHodpSDCQ9b
	g8WOfYEM=; b=W52tBMaEtDn+vXBhfjw7lzFXrf/nQPvswWTyUH3mj/PMHEbbsdj
	IvmytzhWGQ0MeJ2U1th6AajWd05o4FZUdVJANlQ2Z1QkfMgumZ/+xXNgaTZkZSlU
	lrDgNv3L0VZyptl/fgsgzPi78JJXwYZBFNtCc26dmqqyk+qPiMRiCmuK1RUWpITM
	YKR75xS95mPz1iNVPG6sLK1QbYX+O53mP9DoNzM0qam4a4julm2nRa5RI8QF8nwC
	BOd/bcagYi8CWx0Y2R/vASEwcYLafpWbBLx4znfF+X0GnOCC38ENaSXxi4GRsncL
	sbFJbHT6/rP+qQTR0iDMiTCg6DGnuIO+02g==
X-ME-Sender: <xms:nu_BaHx037Cczhy7vCedyJl5KGWzrKsQ1AJkocaXJdN0Nr7LvFpiYQ>
    <xme:nu_BaCgJmjBsctE9rCu7a8AS1UYhOI6Ip6RDHYLfyv4zEYuoS7BSO7dMHlKgzeLo1
    7SPFHZ63dnCWtJtfA>
X-ME-Received: <xmr:nu_BaKxZeh_IRyG3XbuHSIWX0Y5k37z7NOI_2P9SX3Duv0Ebg51eOdFWhZv84LpvTOzG35WYfWPWbixf3vbiTmV7XKL8KVW0wUhmOLk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nu_BaNIxmpC6lYr1_14i08NfB89LcNSgDs5iuuKDo2yfSpv_9XqO_Q>
    <xmx:nu_BaJRjky5yJFi23ezs3ln53Z4d0g_38ZZcAhR_KF3bZghlIYry1w>
    <xmx:nu_BaNpne9KwlUjw7Q0YQTH_pd8wjpT38A4HQ2H-ZewM6hBgf4vrRA>
    <xmx:nu_BaGrU_6kTc61p5-nn9ytzKOoHWr0nsCokHSXxAm2GI3u83JUtFw>
    <xmx:nu_BaCGIQo_x8X95A9QjVLCQGBWu49-AuamS1f8vDnbQKTiMfF7iXaI8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 17:37:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2025, #03; Mon, 8)
In-Reply-To: <226976fa-2805-485c-b01e-138e06f9c7bb@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 10 Sep 2025 09:42:59 +0200")
References: <xmqqjz28v21e.fsf@gitster.g>
	<226976fa-2805-485c-b01e-138e06f9c7bb@app.fastmail.com>
Date: Wed, 10 Sep 2025 14:37:32 -0700
Message-ID: <xmqq8qimq99f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Tue, Sep 9, 2025, at 03:37, Junio C Hamano wrote:
>> * kh/doc-fast-import-markup-fix (2025-09-08) 1 commit
>>  - doc: fast-import: replace literal block with paragraph
>>
>>  Doc mark-up fix.
>>
>>  Will merge to 'next'.
>>  source:
>> <09aaad696895c18c6d4dda7d6a2f4b77f84f39ba.1757363213.git.code@khaugsbakk.name>
>
> Nit: The ref still points to v1.  Although v2 just has the Ack:
>
> <724b975078daf11e17f26472c0da5638a5d1ca86.1757366352.git.code@khaugsbakk.name>

It is not just the ref.  The updated version has not been picked up
at all.  Thanks for letting me know.

Is it just Peff's Ack, or any other changes added to the patch?

Thanks.



