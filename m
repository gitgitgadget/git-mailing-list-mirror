Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECC2275B1A
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753729032; cv=none; b=KTlWbjoO3jFavsRC7GjtV/MNRQFggslgJ8dhJuaGr0Wrd4cbWV/WWGUSR/TrplKtlzUsZ6DielMZOXfntqgTV7rBCqtGVslWgkPwqJW3sNz2zhnCh6KzyoD4IH9I+tmp3Hyw1/+7eCOOVPguhy9CzARmp4zR6UArZqYcOypN4cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753729032; c=relaxed/simple;
	bh=AxP4icfHcEVm5V8kDMhsK9gekBm4IMuAaNdg5+QyyZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X3bW7KCQ58g5t0T7jYQfQaJLXdTA2/u+YgJvobidTywl5vLIXECREUVmtp0bSM9pgGTVvYF7PBWWpyzFK2fbsU+9sYZUfPhITAQbsq9VjhcryduOEmsusYFoWG0egWeR/u3uVCLxmaRQfKnKWB8xHQLY+I4VqKs3VGZ6Nz9gQNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CSmqsMBX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fLIcMvVI; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CSmqsMBX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fLIcMvVI"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7AE2F7A04FC;
	Mon, 28 Jul 2025 14:57:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 28 Jul 2025 14:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753729029; x=1753815429; bh=V2ib3E0b4T
	d7MAa6MnlxD4t1z9gy4K8c+gY1zmuffDk=; b=CSmqsMBXteq/81mGpvO21ctKSu
	rSUCOBcoh3HlgoxKurwVOt292UXqN08kcPcu8JQZMAnSFSP0ObGX9ik3Q3N90MUG
	MSbAz9J3py3/uMphrs9NPho4cC1NjQJMlhR2xeX6NC8Rn8hBavKVUTr9FUPF8j7o
	t+e/7OFm5f+vlUC39pbDB3qDuIrnDAi2QIDAHzWW3CZG+3s7RJce/AYmQ7m9U8lm
	E3tiwlct5jbLpT/WWINiQc0QiKbU5PcS3RyJbRfld9ZnqApE0dQ0qJjwF7qpJdaW
	Gk3YmKmkEaF2lmDc3T0mBljIqnXNYeyife1PVtGd9xMFO+4OqsHvqlKCN/RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753729029; x=1753815429; bh=V2ib3E0b4Td7MAa6MnlxD4t1z9gy4K8c+gY
	1zmuffDk=; b=fLIcMvVIw3gCrXmmobnR5mIuTUz7mLo1O26r0OvLNTi54EvH7UG
	p24+sHCU8MOjNOYXFINKvO/4rDAcTAtb2rxYBCI8nvQ1/wIkn4DdT72nIN7Hrtg9
	4LWYO7AWASNgQZFZXBU8pTMh5a5fL122FrNXmuY+WnFT+MyX402lKfUX4GhSLDIR
	EmKN6sMyeQYe34qjKEWwl//+CIVB2PcZzZ6Diil794S5lReb040eYVv1H+7tp/I/
	BIAmC2VybeLMo8pj4y/U3bHE1uFt/eElgV1kPAciHP2x49sTmLGf9qQaJL4tLDjQ
	2Uoq1eQwY7S4WnQ8QRoTh7fbab7Ip1l0FPQ==
X-ME-Sender: <xms:BciHaHvtd5SjxwHkPnhv-67mguITz9BgD_t9PimkBwsXgiaonfqQ4w>
    <xme:BciHaA76k9ZXRUnX0yZQPt3P7wiAa6vMgM8MKt_mHGlHihyAlmP-DUv0ei6hIvBmv
    cPYLEbfA3Mru3lIfA>
X-ME-Received: <xmr:BciHaLN7f9zrIyWhYnkFGin7dxAYEBT47q9jY6qRm6WSYtHIO7ISTE8FdT2Btg_F1ES_ykNQRHdjfCX10-vZ7SWtRERqdBzdJk8_4qs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjh
    hhtggrrhhltdekudegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:BciHaGtM5BSesxO57l5B8uAgSnrfBXkPrd9GEMww1oeITX7P07I0zQ>
    <xmx:BciHaGbKsM1DOMbhaQ1WMZ0TwBM8ii9Cv5w2vlSQuvhNgtu-n22Jzg>
    <xmx:BciHaAxILoL_BnutXSPrmy1jMNqZjGSL3AawiLQ7Gc0KAS1I2Zz76A>
    <xmx:BciHaGh5TdT1ts0M-qia0L3oAeDmgNgObo5_n-6WObLKIx0xar3Vpw>
    <xmx:BciHaA0_UDTZmVqTanfYCvoyqpFXCpII9jaaNR6NPvAupEugsJZCWkxE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 14:57:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Han Jiang <jhcarl0814@gmail.com>
Subject: Re: [PATCH 3/4] builtin/remote: rework how remote refs get renamed
In-Reply-To: <j75h4trgwn5dvvxy6cqjv6pbh5ernehvnoi5itqr3icogebegp@ldbsvfwtxoeo>
	(Justin Tobler's message of "Mon, 28 Jul 2025 13:47:13 -0500")
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
	<20250728-pks-remote-rename-improvements-v1-3-f654f2b5c5ae@pks.im>
	<j75h4trgwn5dvvxy6cqjv6pbh5ernehvnoi5itqr3icogebegp@ldbsvfwtxoeo>
Date: Mon, 28 Jul 2025 11:57:07 -0700
Message-ID: <xmqqjz3suosc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

>> +	 * This split is required to avoid conflicting ref updates when a
>> +	 * remote is being nested into itself or converted into its parent
>> +	 * directory.
>> +	 *
>> +	 * Unfortunately this means that the operation isn't atomic. But we
>> +	 * cannot avoid that, unless transactions learn to handle such
>> +	 * conflicts one day.
>>  	 */
>
> We could detect if the rename operation would result in a D/F conflict
> upfront and special case it by using two transactions. If we know there
> isn't a D/F conflict, I think a single transaction would be sufficient.

The right solution should be at the implementation of the
transactions, not the application that uses the transaction
mechanism, no?  So I would think the above workaround is actually
counter-productive.

> That being said, it might be best to keep it simple for now and leave it
> as-is.

Yes, we do not have to update the transaction layer to fix that D/F
thing in this same series.

Thanks.
