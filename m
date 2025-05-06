Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACCF21ABBC
	for <git@vger.kernel.org>; Tue,  6 May 2025 22:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746572294; cv=none; b=omz+ziHGBEoduZeIth+ZlB6ygZV8vZ6OcgcGh9qS7iDtRAgLaR4CeHsrNoG0z0NgT6eABcB9LeIxnkbAoBJ6ERJqTkupShwK8b94fnJwn4EzCA5bozOvtIGviqDHZxgdkblVAZA+NKf3Zf/w4eZxSNWY/zpDGDcwyQnJIUL93i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746572294; c=relaxed/simple;
	bh=LJ8lOV0ObVgz5/UwYvfkw3N2j965Fl/tTHMDUtmEY04=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sAhZ/oQOAjRa2+bl859EevaYwWoVVWoegFocxH0bTcsxkUjrQ9EyBYp6KBW0MfBF8gI5J8N1f3ZnTco0EERckQgedw9ep7NuScCDl0lMZ7xuppCLGMNtDFHIJK2pYJod7ikxWbyFHn998JVi5dUZilP4eS23EMYHAnLzI2b4to4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dlVxO2nk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AjYyWo5X; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dlVxO2nk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AjYyWo5X"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2843D2540268;
	Tue,  6 May 2025 18:58:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 06 May 2025 18:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746572291; x=1746658691; bh=ayYM0N1J8h
	YPA/AgPQVb+/ntFxLD/++izIrgDQx4nUc=; b=dlVxO2nkK33LOd4FNHTQOIRno2
	9j9Ba8/I8ugFrUiqbdIbEQBakQqHUjACLI2j+2i5ATEZ2aovYL470XywaC3z7KCR
	qEGciRuJdH3xkvV7jyyvdB6nOcN5Cb3u5xwD5t7igVR7D44sT1YkJT0UbPBrcDcU
	FFrrcWqXmI/HEm55W+U3i9ELtbL+MNjTU01N4m7l/BP6EOnxxNVC3//4KA3aayma
	wl221D7u7US/H8iCRbUygX77cDgT3ijyEGS+xXwGyHdysfn8czAo+q3j43DYI51h
	s9z1w9UOQWeCB7tOH7z2H8ah4lLngiipJIfFLcz/Fsh4nyHZoGsjngk5MQcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746572291; x=1746658691; bh=ayYM0N1J8hYPA/AgPQVb+/ntFxLD/++izIr
	gDQx4nUc=; b=AjYyWo5XtwZD09ye26noqEMUJPPcUmEpjJ7yMkNCZHUAiDD7+6d
	n28uY2B+t8boP1f5xUKkI2hrkut5el570NBHDXy4rGOjlV7NKiMh8Zgra5tSEN1T
	9L76qt9FdMXN45nu48tIBC8SeKSxZeCJmLcYyIuGeux1bJmdg7e+tbCUuF7aPrPZ
	TB+Y9gDrWDzn1FPTf0hDic4O5MAohwK8e1HSlpr06T+wltr0xKUPwWBpKGC65zqL
	J/M1HER5Sf3xxCcsPKRKFKkhaBevs9gVQgb6B9BnGE0fkVTmJfN2jlnEGD4wOuAk
	fnpw+9Ie190CY7mMeqB67yWrnrETFWFlB3A==
X-ME-Sender: <xms:ApQaaHwTEDIM6_vrWtunoVLGMmEee_OghEheL9q90Z98Do2OfHue3w>
    <xme:ApQaaPTPn4glKa3B37MVeF-0llCr2k6YhMxGW-dHq2cvAXVya_ReLraI7PbFTzduW
    UMIyT_EhsL94owETA>
X-ME-Received: <xmr:ApQaaBUbMQVaj4Kw6wsDge88l9ApL4S4E03W8WUHmcwdii3ofIiDRPOeDQ84r5zzEKfavLcLAd1jAlFRLT3R5VbBqDH65OpnZFYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeehvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgr
    shhtvgdrnhgvthdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ApQaaBjSfMYanoofFcwAUF-UhibvHOa-gqfyq2csx7VTfR3rAgC1OQ>
    <xmx:ApQaaJDISmJ0VD5BBheolGrTypmdQGgq2zajK9iF8xLB2ftoQGOyyw>
    <xmx:ApQaaKJhr0-dQrOgqkd2ZJseArG3VycMv3J0Wgp60pkqDs4qvd75GA>
    <xmx:ApQaaICvWW_PESzuCKjQUvYCe3geCS452lTumZBxQaV6D0wSdoHINA>
    <xmx:A5QaaLvXEUGJPUygO--6CRmBKntnWgEKFz7z0wvEXQE3e0mmQIUh1ysp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 18:58:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Collin Funk
 <collin.funk1@gmail.com>,  git@vger.kernel.org,  shejialuo@gmail.com
Subject: Re: [PATCH] wrapper: Fix a errno discrepancy on NetBSD.
In-Reply-To: <20250505180311.GA29783@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 5 May 2025 14:03:11 -0400")
References: <20250502233403.289761-1-collin.funk1@gmail.com>
	<aBVp51yLwxBpRskt@tapette.crustytoothpaste.net>
	<20250503133158.GA4450@coredump.intra.peff.net>
	<xmqqtt5zoyg9.fsf@gitster.g>
	<20250505180311.GA29783@coredump.intra.peff.net>
Date: Tue, 06 May 2025 15:58:09 -0700
Message-ID: <xmqqzffpe48u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, May 05, 2025 at 08:43:18AM -0700, Junio C Hamano wrote:
>
>> But for other kind of requirements, we want to fulfill them on all
>> platforms that we claim to support.  Using open_nofollow() to
>> achieve hard atomicity requirement would be a bug in such a
>> situation.  Should we somehow warn our developers against its use?
>
> The comment above the declaration says:
>
>   /*
>    * Open with O_NOFOLLOW, or equivalent. Note that the fallback equivalent
>    * may be racy. Do not use this as protection against an attacker who can
>    * simultaneously create paths.
>    */
>   int open_nofollow(const char *path, int flags);
>
> though that may not be enough. 00611d8440 (add open_nofollow() helper,
> 2021-02-16) discusses a way that it could be made less racy, at a
> slightly increased cost.
>
> IMHO that is somewhat orthogonal to the issue here, though, which is
> purely about the case where O_NOFOLLOW does exist (ironically, our
> racy fallback code consistently returns ELOOP ;) ).

Yup.  And with the above comment, I would say that my worries above
are unfounded.

> The issue at hand is that particular errno responses are not always
> portable. The patch discussed here improves that. My point was more that
> I'm not sure to what degree we should care about errno consistency in
> our wrappers (which is inherently a bit whack-a-mole as we find new
> cases), versus trying not to care too hard about specific errno values
> in calling code.

Yeah, it does give me a bad aftertaste having to pretend (by adding
compat code to translate as needed) that all systems share the same
set of errno, but we live in not-so-ideal world, so I am afraild
that it cannot be avoided.

> I can see arguments either way (and as I said, an argument for making
> errno values consistent even if we try to rely on them less). Mostly I
> was just a little surprised to see open_nofollow() being used in this
> way (especially since we have to end up stat()-ing anyway to check for
> other cases).

That is true.

The callers in attr.c and dir.c do want to fstat() after they open,
but they are more interested in atomicity (with "the best effort on
less capable systems" attitude).  The one in mailmap.c doesn't do
any stat(), but again it is more about atomisity with the same
attitude, I think.
