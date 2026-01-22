Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A9B30CD91
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096518; cv=none; b=IUpvrn0tHr5hk/99msEQhfTrDjn8mcOVOC4jYk9KiC04QcnAdNtpazO5s3psbSUCvQQ3BEze25HptkZRFV4KeiE4K0qXX8ykxRmYTXcXwn4S/fdkbwVJ+Oa9DU75SOXbyvANE1Zjx1m8uORoRvFuxtm0eWTSAF5vO9ZTznohT3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096518; c=relaxed/simple;
	bh=GXp1snzLUK2cdJ9XcS6AP51lJOXdWTO8l7ILfLbAmBE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V6m8PkTB39JtLys5cnekHA5lClCPH5YzoKfA7AAOyENkWVS2/HZDL9nS/moyqAOo/+Q+L87aq7ddUcElbheRKI57/IINqTGBOBzgMbjoDmykES2HexgSqa1d3j6fRwMEDdj3lE2mQKBbcis8sq23yau2HzC+4v5Y+AS5ZAfAAG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=B+4aB9vF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pcNjbQcj; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="B+4aB9vF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pcNjbQcj"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C81A7140012C;
	Thu, 22 Jan 2026 10:41:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 22 Jan 2026 10:41:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769096513; x=1769182913; bh=0Lhi5xtfPp
	0a4QBVwJGDxm8ckqeOcJQPRf9YMMqOu5Q=; b=B+4aB9vFjqWMylSEPeu8nz09TC
	w4I4tLJV3bAyYNUzE8t5Lh2380KYaBmYp5FrwvAaG8l9VVtu1b5z4fNSW1oy/L2n
	JT/gaQedCiQlKQtHMs0PCNuRS9OAjsnSdWVkiJfiO5VshoFEC5s2IayxXU1FuPmw
	AtxmFIEF6I+SsV0OSNUpGtpB92552rxab/kRj81fUWYBBaFunjCIQIcF8G8tIMv4
	T5CTci+64h+A6oLU1GqNj0DGPxehFwYCvIShSfScpgTsgWKA0sgmSEeg5fefLipa
	Z6XvxCBsh8uPwHHKhX5x9Bpi1xhVO1ryKkWQsUSDOcQqTLAd3bwCdC46CT/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769096513; x=1769182913; bh=0Lhi5xtfPp0a4QBVwJGDxm8ckqeOcJQPRf9
	YMMqOu5Q=; b=pcNjbQcjfif66tLuhAgDJGENFmcvOrquZ561DlM33E0Q6HSw+oX
	9oriwEHvmnbDLqoq/eJi0xlZm+Bb6bi55URXGvw70rXsnbzyYIO/oAdyKOiBji2V
	mYt8e8DLEr2PmTkJ2aNfe9R8eyoWxNttB2v/U7l3CWZ5HJZhnP1o28BpoTnwlejW
	3r1zIJ0OIL/zBn4QHB+XNJ04pIQyO4nsqsXxE8D1i7DVs7fVuD41ZAMUQMAYC698
	grnl89qff0hWknylNTylvEirgOf+rpoZbIuYpgWSfdPfjI3Th9ofN4WxCa8BTyE5
	ysko3BC2BJdeGtgRSyznPRJWzIhx4r0Brtw==
X-ME-Sender: <xms:QUVyaVy0bZ-mhDBjdJqCdmDwL1wENYkb-ZAUlie88QXeEETzMxGnzg>
    <xme:QUVyaXh3Xn2UhE4xtoRWySxGdoOBH1UR1VDj0FLOdb9_DLi-VHiyDLSCWQNRNaInO
    JQN6oHQq9khmj_TJkmL2J1wbwuh5WRCfpsBL9Qj0-5RqnH9Kuv9xQ>
X-ME-Received: <xmr:QUVyaRmKcl6XzJZtTR4b-iroHnw7-TCcJ7D0uAGv-h4BjKuhpfwwyxBDgnLE8-XS_JGUH9T2KvKYnNi_ht0mlRWVD_4LzcoXVgy838k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeiheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QUVyadiwkqoJVK0VOmup84nKPfGME8TxcY8gXgRVRzPAiMSjN3LzEw>
    <xmx:QUVyaV0wLAo8rSeB0TKFn_f0jtSL8KUkfRHTmBLvZ6drteYcP72IoQ>
    <xmx:QUVyaWKFTZYPnPQ29xb3s0O-_VzFRCZULS9hgGQu2IkCDZJAqvUCvg>
    <xmx:QUVyaVwyCgs7QGvlEUVxT9XnrRCvSrdAtzaPBrE-1dAkwyLRfKInjA>
    <xmx:QUVyaUg4ViFT0yFpFxza6bmbzHt47aQoZRpVVWSXAQkv8E9WrGIdaf6L>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 10:41:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 02/14] odb: fix flags parameter to be unsigned
In-Reply-To: <aXFosXv328ZPjlcw@nand.local> (Taylor Blau's message of "Wed, 21
	Jan 2026 19:00:49 -0500")
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
	<20260121-pks-odb-for-each-object-v3-2-12c4dfd24227@pks.im>
	<20260121211128.GB723458@coredump.intra.peff.net>
	<aXFosXv328ZPjlcw@nand.local>
Date: Thu, 22 Jan 2026 07:41:51 -0800
Message-ID: <xmqqcy31pscg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> I agree with you that we should be using an enum in these cases over
> unsigned for the reasons you suggest. I've stumbled over this in the
> past, so perhaps this is worth adding to the CodingGuidelines?

I am OK with declaring our preference of "enum" over "#define"d
constants.  The only two minor hesitation I have against the use of
"enum", especially for bitset but not for enumeration, are that

 (1) enum gives a false sense of type safety to casual coders. If I
     have two enum types and pass one to as a parameter to a
     function that expects the other one, would the compiler help me
     catch that as a potential mistake?  -Wenum-conversion is not
     enabled even with -Wall so I am assuming that the compiler
     folks fells that it is not reliable enough.

 (2) it is not easy to force an enum type to be unsigned, unless you
     are at C23 or above.  If shifting enums are warned by the
     compilers by default, I wouldn't worry about it, but use of
     unsigned is more explicit in this regard.



Use of enum does help debuggers, as gcc figures out that three and
tres are both (ONEBIT | TWOBIT) when asked to print it in the
following snippet.

    enum bits {
            ONEBIT = (1 << 0),
            TWOBIT = (1 << 1),
    };

    int main(int ac, char **av)
    {
            enum bits one = ONEBIT;
            enum bits two = TWOBIT;
            enum bits three = one | two;
            enum bits tres = 3;
            ...

