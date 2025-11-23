Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3814C15E8B
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 06:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763878767; cv=none; b=mcRjm5wF9qVb3rbW/cxjesYFUjq5a0VJwvPTbTKJHZzWAzTJXMt9GMy7EU8hVzSigxhi84N2wuiwmrItudoJHMyG4ADweg7p0ILuRBH7hxn9w3MguzD248k1zduQ7f5PBgP6Nsk7U66023rJPuP6BxHBt6DbkX1Lkda5F6iIE7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763878767; c=relaxed/simple;
	bh=8aKlNG1kQ/dY7SHU4lbHCzFytQoVKEmJ4cvmVGh79tQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L/EwN66c0TZX8qWmB4P3PC73UgtpQNjnqt+o8CxRVB1XAC64zJcd1/fU/BBsb/ffqHSn2U60suob6eWMBvYfLwls0sXuF9/8r2eM5G3au10vzfi653eunPzJqqH0IcGxGK7g1dSh0qA2Z5a493faAXR2KKc3FLcFnP2Zjt08ToQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RUjrIP9g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=swodPZuB; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RUjrIP9g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="swodPZuB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3941B7A0186;
	Sun, 23 Nov 2025 01:19:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 23 Nov 2025 01:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763878764; x=1763965164; bh=tXVrvOCMC9
	LzsX5aBcq6vY7rY6x6pJmiBW/hURmcDLM=; b=RUjrIP9gMBHTLGIi3JQIm6A48o
	p64tNDee7ktSYtQdxyiiYjgN7Kl9XF2tq0+AT38QzP61Onw0r1pFR3mdUb+0+yq9
	hBMlbTkF48U9QW8m/R8euT5qFCvOooFg457nF2HX9VAomFRST2JHh/V69KXRvNAv
	9hREFDsDIJiNkAsDEOItigs/gwZrdSAqLuqBVHaemISs7pZyY8TPzaydxqUAjDt0
	QvhH9eDYYAqDaNz151Tx2Z5VK+IXogmHZvsmPJ42r3AjZiAoPqVaSJeqxY81NbdH
	K1MVW+K2A51RIoiA5TpBjl0T1Z7FF65MePC2Blnn+Sj3lRK1CZ5uCj6b3nyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763878764; x=1763965164; bh=tXVrvOCMC9LzsX5aBcq6vY7rY6x6pJmiBW/
	hURmcDLM=; b=swodPZuBE3hqieAP5a1osn+gcah9wZOt8sQKvlWj6wBz327+ODI
	/qL4HlwbOyEraCK6wHJy05Q5FJULMLk4pUsuP7Y64N6t0OpoKE4zmo+wrG7NNMYV
	S0OqycFOCU5qZbyXBd05yKuXCTnQuXByemspl04RUWiFiu+hfB2CcNZi6IcJwvWI
	oGF7C8BHwmA1miO+VJDSlL2LtoU/R0Hz8zHsqRUJ8drEo6tbBYrZn9KUhyqKgWOp
	0hSp3hQothglREikamTmUK49Pgj+7i+zmsCAKJTPFJKw6bhPsJ6Lep35MFB9RAUQ
	Sjak2pa9yh/MMeoaFwcIwTmLm3y7VE2pcTA==
X-ME-Sender: <xms:a6ciaUl_-c-vM2ZDxpFCMoVC6hL-n5IkaN1CpOCvmQ8_1j3WZFCPwQ>
    <xme:a6ciaWHMsFlXYiRQWYj37Oc_J_BVtAnQIklmoYdXOcS3FFel1EcTSiIsMUcTuaTDK
    HbTYp_182LeQBvroSlT-FLrjvPS2CpVoqBa6XRSY8ngDhC5WvCUrg>
X-ME-Received: <xmr:a6ciaU4HlnqFYDXr2CpS1GbZtBs3UQ6XxzskJrBzf0gN2cSU7fUCMdP3MsA4_EZ1Y7ChUmD4vcl6WpBoYMTLNTc_oL67oB6Y29VL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeegleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtoheptghmlhhishhtshesshgvnhhtrdgtohhmpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:a6ciaWmeCOv0oaKrcZvfYZULgOGch0K56pDAPbLKHA83Xn4qsk4lZw>
    <xmx:a6ciaRqdfi-5-3-BIGOBWLku9mnYRz25r2KFMXrX93PwRK5xf2f8LA>
    <xmx:a6ciadufU6yMctruHR2Rk5YuQ62yIGe1p-SCA9SsgfCwDNBB2DzOxQ>
    <xmx:a6ciaeEt-DydcwDAkEaDNkdaYhIG9xTfNA5x2_EsS1ewRBZlQThErQ>
    <xmx:bKciacGUODFlsFTcwvtf3GniEPP1M6XYiYCiKAk_7KT3QbXeAJWUnZQd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 01:19:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>,  correctmost <cmlists@sent.com>,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH v2 4/9] cache-tree: avoid strtol() on non-string buffer
In-Reply-To: <ca6d99cc-d05c-49fb-ab3c-d7668077d32b@gmail.com> (Phillip Wood's
	message of "Tue, 18 Nov 2025 14:30:32 +0000")
References: <20251118091127.GA4175601@coredump.intra.peff.net>
	<20251118091218.GD529192@coredump.intra.peff.net>
	<ca6d99cc-d05c-49fb-ab3c-d7668077d32b@gmail.com>
Date: Sat, 22 Nov 2025 22:19:22 -0800
Message-ID: <xmqqtsylz2xh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +	while (len && *s == '-') {
>> +		sign *= -1;
>> +		s++;
>> +		len--;
>> +	}
>
> This accepts any number of '-' signs but I believe strtol() only accepts 
> a single sign (the standard says "optionally preceded by a plus or minus 
> sign") so this is a change in behavior from the existing code. I'm not 
> sure we really need to be that accommodating here.

That is true, but at the same time I do not think we really need to
make it more strict with extra code.

>> +	while (len) {
>> +		if (!isdigit(*s))
>> +			break;
>> +		ret *= 10;
>> +		ret += *s - '0';
>> +		s++;
>> +		len--;
>> +	}
>> +
>> +	if (s == *ptr)
>> +		return -1;
>
> This accepts "-" as a valid input, as we're tightening up our parsing it 
> would be nice to require a digit after any '-' sign.

Ditto.



We could try to be more careful, but it quickly became messy when I
tried.  Here is an unfinished attempt of mine.


static int parse_int(const char **ptr, unsigned long *len_p, int *out)
{
	const char *s = *ptr;
	unsigned long len = *len_p;
	unsigned val = 0;
	bool negate = false;
	int saw_digits = 0;

	while (len && isspace(*s)) {
		len--;
		s++;
	}
	if (!len)
		return -1;
	switch (*s) {
	case '-':
		negate = true;
		/* fallthru */
	case '+':
		s++;
		len--;
		break;
	default:
		break;
	}

	while (len) {
		unsigned next;
		if (!isdigit(*s))
			break;
		next = val * 10 + *s - '0';
		if (next < val)
			return -1;
		val = next;
		s++;
		len--;
		saw_digits = 1;
	}
	if (!saw_digits ||
	    (!negate && INT_MAX <= val) || 
	    (negate && INT_MAX < val))
		return -1;

	*ptr = s;
	*len_p = len;
	*out = negate ? (0 - val) : val;
	return 0;
}
