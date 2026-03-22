Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806881A6815
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774202015; cv=none; b=blIYghxCPnC7iIubiJkiEZPXtErSnAgnqDOHcRy0SSac7lJFLV3WpeVOQsXWV7YBildb0NLbTYmHCuWhfo479PeU+j+Mjs4JpWPO3srGXnHyFq1ISawyXlYv3WYDHDLeLHFXGZE0WBSDIoi3wi4gksq97Gf41vgK0qIJ2p/+vRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774202015; c=relaxed/simple;
	bh=hHOh4cP4tx8i8A2dBMHWrCtfLLr5lLt6Rfex1bS1Vuk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p1Zl7vR/E+M57X0ed3/wxIK9k4QKC5VvXtJ51dOZ1DdBvQSaW53co7xSBV80bQQ+gMek8R/d3+lpzK5K1nJxkXoSbEjth3qb//EzmEv983JsBBqBKWW6dCCQmRdXXmj9O9RRRhr3uDf2yxaxmDw29Q+PvskejUKE37kkW+Bh+aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WGf/iI7e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tazG1vIm; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WGf/iI7e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tazG1vIm"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B3DAA14001B0;
	Sun, 22 Mar 2026 13:53:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 22 Mar 2026 13:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774202013; x=1774288413; bh=tNqcdTZRc8
	EMt7JMh/R7LTrswhrJccBzDYN/pMGwiDk=; b=WGf/iI7eFRkn4kehM9pUakzYFN
	WUvKAQBZNTsjRPiD2crF33D1XhiG02iiXKF0LiRibCXnldpA+ZavbajZFvBPaRFw
	3wRDaDlKGiGip7F636vriMAwwb8m2HMj8GWOr1+DZNO8vbsP5N+/5jzPGLoz0O6E
	Sm30LOMUrQNvIyVSD7GLFCgJNgxBYEXHsC0bUxdTMRlhsS+tsyVqQl8UVooBhHfi
	9y9gj0VmSmf0lLRD/ZxYs9xoWbE1uIqNJX/7t86FTNsCcjC9i+E8smisrofWngW2
	UNZcRiYtVOx9B2gfsCzOY7OiW/s0JoufTEUR2AIspHnPn8KEH7GjQqcJfHkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774202013; x=1774288413; bh=tNqcdTZRc8EMt7JMh/R7LTrswhrJccBzDYN
	/pMGwiDk=; b=tazG1vImVu2+mE+ZCm6At5Gad0MVvvmMEGI8i9rw/BjN521j0+E
	qr3fYl4ZEXTa/UWJpa3+WBa1dvTp2bv8SRnThaEOstRx0sdGBeasHi4lvK19oM4e
	q+FA1niDBGxt5VejXgzh2RWBNWBvWfCjdp5eGNwT2XKuLit3KJnSQ8iUaFT/S1MW
	rSXix7Vv34Zb06yrWIhADMlX3/pz0rRpWogBufOeW0BXBoyMG/EN2QNCK8hPXuWu
	CP/QUHsMCc4wuhYpdAV2Nt1qoDs4UTlBHD/tVtvLhU8L3Nc0mJY7hInP1A5TuaC6
	iDrdlxhgshGwj0KJEwUhgrmiVN2eCqlurjg==
X-ME-Sender: <xms:nSzAaTLR_QNsQu4DTcBXz1gyY0XykBj643UZJy4RTe-Xa4zqUF-G1w>
    <xme:nSzAaen17qSTaULHJEKDETSXs4xBvkZ4Kcz1ZyikUbgrNcr4JHaaFHm6CjtbY8sQu
    ieGnB9mKVFnW_hN8NXzn-KAVZoHqyniey8LyF3HNbcGkvlnNJLV>
X-ME-Received: <xmr:nSzAaZES-N_JCwgIHCJ4xT2ySHAPQ5d2alZm-q0FkABRgoVd1gP01Ri_RpCyaZsQC9no9QvMmTnkuvl-QDq77TyuA-d--8zjyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeigeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:nSzAaWGxxAG6RCMAbZWFuWNJBkyyOHF0hZrwqyyhaI1MgxIhTnFbrA>
    <xmx:nSzAaeMn6oVJkBRdq7LW5a8pjs7i9e1fsIi9L8CODou7oTIYK9Mz5g>
    <xmx:nSzAadFuXg5zYOqi4QpFkDPUXIzkfO-8iS7k-UeZVH7AwjDcgdFnkA>
    <xmx:nSzAadP-Q8pOovJXjH7aCCI-0fun06sh3LkacCzuC7MRFg0Fd7izYw>
    <xmx:nSzAaWm9qoGpat2UgQOlA-wSgkuqXrV4pAJ-9936sUna9ASFj1fJaNC0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Mar 2026 13:53:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2026, #08)
In-Reply-To: <20260322141517.54890-1-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Sun, 22 Mar 2026 19:44:38 +0530")
References: <xmqq1phc9x98.fsf@gitster.g>
	<20260322141517.54890-1-shreyanshpaliwalcmsmn@gmail.com>
Date: Sun, 22 Mar 2026 10:53:32 -0700
Message-ID: <xmqqpl4v92eb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> Though you fixed the conflicts while merging the old version, commit is not
> yet replaced <20260318090546.1213077-1-shreyanshpaliwalcmsmn@gmail.com>.

The end result would be better with the initial one after all, as it
could be merged down without somebody else's patch you do not need
to depend on, so let's keep it as-is.  I'll need to replace the
status comment, as this has been reviewed and looks good, and it
also seems nobody complains about what the patch does.

Thanks.
