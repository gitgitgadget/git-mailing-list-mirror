Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425A5523A
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 23:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758324673; cv=none; b=Xi3zKu41JQkpmyGJdTtoOw/1ep0Nh+A9KxkVEGcm9j6gYrpEdvkcuQqtSQ26ULnhmWZufGbCBoFz3qSpd4mh8wDltlNPWPWsT8ILt4Wj/ORHuvMhQSj+imId1kNH+JWy9p60aTRZS8AFKcoXQJQ2enCTL7FX1i3ioMP7Q7wBtI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758324673; c=relaxed/simple;
	bh=ePcB489usJ5TACEIJE41EJCKOAIc/jp+k++pvE5L5WM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KxGVIneVtLEHgfzyp+U2BzVNTmPacUjr4WQfyifNtIUeJd/hiySt27raHevHz/XaR0T3Q9ljPGDKHyTgv4hnSvNBpm0S2bmFFIEqHHovR7JnF2MmBGAkruHBTKQsTO76UOLuabRVR1/5YEe05AXRzfxhM8NaGn/jMQy3ILUuWeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nEL/PFNp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fxvZhI0X; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nEL/PFNp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fxvZhI0X"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 378F11D0002D;
	Fri, 19 Sep 2025 19:31:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 19 Sep 2025 19:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758324670; x=1758411070; bh=HeQagM7iwA
	DHiTf9iQEWkr7QSpykJ62MQINmm5V3oEQ=; b=nEL/PFNp+uPBoXx0kRfAFWuP+5
	SBYpsvHLafqH0XE3hmkD8l2uGH5LU/a14G4+JlkirsKGU0dKLRStqj5YqUVeIl3r
	pezWFf9NPd+6+8VaFcWY8oiG/cOq0Kp2/ZlbFcHtOckO8FwtDbsClj7M6X0ZIYGC
	gvvFIpzNFOycp/RPgoIb8Jgo2saGFYvEDYP9HTxe2OKnI8qnMowbB06Ord+ZSHrF
	zg1+C7ZTCX0sHHr/dtVqymKqgmceops1ij4KBdldGvXb+0T+bGVLr8Vl1TTdasGz
	5vhmBEz5mT/LV9hG7N1bhzLXo/qf/O6Jpe1jlR1R+iNvZLWHVDb/4cVBsmwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758324670; x=1758411070; bh=HeQagM7iwADHiTf9iQEWkr7QSpykJ62MQIN
	mm5V3oEQ=; b=fxvZhI0XMEhQm8nGRknD2i3HFyb2aKrI52wsXJyGgDQoQNREqwI
	MNxSwGrHvo1o9OrgwSBq6zxDeem3RDWg9MJYDEIJV4IfMZ549Aq1c/zHitY4L0fr
	ssfx4ezfpk7ahqAlpGiNgHVKyGHCyyoh42mpKV1D9AlVgUqPapqwgkgOTiEiYVaT
	4gz4ds1K0RKXicNDBUUkMr4AZvpBesXa7b7C3Rmyq3Bko2Uzfv3JvApLPE7Jj+7W
	/4PlgtqTqJ9Fgs6nhFHB6oSvZ0+7M/+Nl1B2i/xdPkyCkM6Fzn+SfUtR253HTcN/
	XcjktvQmVZX1IbwfrvZ0OJvd1t14tCRlJ4w==
X-ME-Sender: <xms:vefNaHSb1ymPiJvb1KFBN_JDv8C20F0UMcoftG5_VxIp3-umTvebfQ>
    <xme:vefNaET7eRB19yHb6h7lJ5BBl_U9dQDLXI5MOGhbGuQlWIS8ZnUc85qEoMg2cnyld
    agAK3mziJpmRZxbAQ>
X-ME-Received: <xmr:vefNaDQ-ALxS1k3U532xhvmTawnswjH8f8jfPOjbmUdEAr9r4uqMhBsvx_X4Ee9u59jL7mTCgEaOYVQpZMYOr5Fgv0fCtMYJ0dpE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtdehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsthholhgvvgesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:vefNaB7xAun4r7-5lRSPAlMFkCsxlpIXgT8n7D6yKMsMtOCC59mgUA>
    <xmx:vefNaH33hSqNwndTJwDz9gy1RM8uUGd3aA95V9q6mi1NNKlRyfOmlw>
    <xmx:vefNaED22VoYLGWxHELnM9chs9uNqxIveMc8CiKHSXAKpJud9vHL1g>
    <xmx:vefNaKOafPz6_BEgtiyAGwAIuF4XtFDWXf-pKnyzavXIQYs3rYd8Yw>
    <xmx:vufNaJn7GQQizr2yv98vlMhmG2Oqpzbjvr-Kkcgnm4owSQ8j9g3xmAUM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 19:31:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 7/9] fsck: consider gpgsig headers expected in tags
In-Reply-To: <20250919010911.649831-8-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 19 Sep 2025 01:09:09 +0000")
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
	<20250919010911.649831-8-sandals@crustytoothpaste.net>
Date: Fri, 19 Sep 2025 16:31:08 -0700
Message-ID: <xmqqecs2yq83.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> diff --git a/fsck.c b/fsck.c
> index 171b424dd5..341e100d24 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -1067,6 +1067,24 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
>  	else
>  		ret = fsck_ident(&buffer, oid, OBJ_TAG, options);
>  
> +	if (buffer < buffer_end && (skip_prefix(buffer, "gpgsig ", &buffer) || skip_prefix(buffer, "gpgsig-sha256 ", &buffer))) {

Could you wrap this overly long line?

	if (buffer < buffer_end && 
	    (skip_prefix(buffer, "gpgsig ", &buffer) ||
	     skip_prefix(buffer, "gpgsig-sha256 ", &buffer))) {

> +		eol = memchr(buffer, '\n', buffer_end - buffer);
> +		if (!eol) {
> +			ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_GPGSIG, "invalid format - unexpected end after 'gpgsig' or 'gpgsig-sha256' line");
> +			goto done;
> +		}
> +		buffer = eol + 1;
> +
> +		while (buffer < buffer_end && starts_with(buffer, " ")) {
> +			eol = memchr(buffer, '\n', buffer_end - buffer);
> +			if (!eol) {
> +				ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_HEADER_CONTINUATION, "invalid format - unexpected end in 'gpgsig' or 'gpgsig-sha256' continuation line");
> +				goto done;
> +			}
> +			buffer = eol + 1;
> +		}
> +	}
> +

Do we allow a tag object with both "gpgsig" and "gpgsig-sha256" or
detect as an error?  I think the most natural way to extend this
system in the future with a third hash function would be to still
have the primary hash in the payload and signatures created with
other compatibility hash functions on the header, so if we were to
detect, the rule may be "gpgsig* in the headers ought to be unique
and should not include the primary hash algorithm" plus "if you have
gpgsig* in the header, the body must also have inline signature, and
if you don't, the body must not", perhaps?
