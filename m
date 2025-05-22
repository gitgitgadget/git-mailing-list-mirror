Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F39F186295
	for <git@vger.kernel.org>; Thu, 22 May 2025 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747942080; cv=none; b=NNJS6ib0yP2TopmNIithw0IHLSMsQ0RgCcip7HnBHLDmBFyFudvYWwMhPIVQz1k175M27FQEUCcZvOHqE6hoGYz23OAZSxhwzzS6U64jYVUW9C4I7rVyIn+D1DxYuiEwlLnF+IFxLiJhsSMIIoAhtYY46QZz7CiyDnEotgWXkHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747942080; c=relaxed/simple;
	bh=sIBOPng5qOd4vf25HreXsvlXW4v9lEvyR0n7NkAteC0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DzTQOpNDilTOkGajwPHBZ3s9dwUFDl0V0wdg0md+WMD3+CyYKlEXxxTzBnBt2sqjRCZzOkuuF4eBW0k21yvpryP0aX/EMwHUBxnbkSnL0lOBoTz4OfbWUjtfT04CbYrFcnOOg9ae9wBTyFa7OLWUMxj3hjqaaJw+CsEDgnsh5n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nG1nWKvj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XgjzwdFn; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nG1nWKvj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XgjzwdFn"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3346F25400F3;
	Thu, 22 May 2025 15:27:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 22 May 2025 15:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747942077; x=1748028477; bh=hc9muFjgP7
	fceteGnrwr75B5O+Uo4OC/M0UhUA4LBAU=; b=nG1nWKvj45izELc0zU22covMMq
	EXbRGnZZEAL7EHCsYqDjD14k8+UuahewE7N6IxalBXQMCEJ6z0fpQ3SD1yrCjZQM
	borHGBwUMypDJgIj0mbQM276xYiqJPNleNy5mGGdBQ4z+6+e3eMXu16jBrAWAaT2
	x859n+uz9+SE8rVBFuj1Y5cYwaf8KlEOdWCibYl7zzGgu8pnegWvQ+rftDi2AIkq
	Bjgmq9cB7lSZnL25yVyeUaJWSTtTzzrFn8P92eg5IpSqiLMqNTpVZp0d5v/Bgzra
	7hO6C2BNant5US4i1F5t6+QtQ6DCEWcBazU6kfDzv2Q0r77APS4jVPp52U2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747942077; x=1748028477; bh=hc9muFjgP7fceteGnrwr75B5O+Uo4OC/M0U
	hUA4LBAU=; b=XgjzwdFn70aXAFWUAVl+UrWCesYvwr+DdLX2tCZqSGpHrGHVbqD
	GtnbnRiLPcF0d/c+OordElgNaSEwKJcsZSF7rJX1u+yFBmMuRIKTwmRL9FBU1ns+
	u05W7wDNQ/u6B1lVmbUQNTvl2p544JFvUwxtc1fUemQZQOdbBwepzWPKT/MFJSpD
	M33GmkfM0bLJCzmOUENCaMV/vqEQB8xS2vfg2hRHrzSNyZsfLJZ13ZYRpMSAVvuH
	8MFp7Z9XmqMmgMic04Cs5AC5PzghQiCVzIklwmbjzTDZOFhhNtFxHR+DLOPFfmDN
	bcGdsLtjHZVGXeCsSP+nNxeGuAhHsJn1mZA==
X-ME-Sender: <xms:vHovaHtQJShMPCpGTz-FURi0IXTRhoEsgdLD78X93Zu-V_tbMMZxjA>
    <xme:vHovaIfii8G4yrdYQdAKMigccE9fNgs5UKriEq7RzKIhX_UXrFTmDPb5AEcQ21YYc
    rpTso3vocOlkWGL7A>
X-ME-Received: <xmr:vHovaKwV6fPa3Wg0sbPcZa2mPTsTxyWxEh0nWAPIvNuE25hvY52vtAkdfWzR3Oy2jUTfdOFa7mRFXhkhCfa_0s2Yk2CGO_nTQBmYjd0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeikedtucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrd
    hknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:vHovaGMuKquw64UFxxRq2w169yKwA8b51auGDVvGBkWUuKQJoIEKQA>
    <xmx:vHovaH92KqAYyxqN-cv-iA2Cd1qLePYL54s2P4VcwFRsEYrkIn4xKQ>
    <xmx:vHovaGUqhTjC-HdqY_85wfJ9hL08EAiPo9yOlKBDiMZLxdzS2DedlA>
    <xmx:vHovaIdcg9J0hLFjzwVNLoZvQCaDR09cY24vq6Nv5AQJ7ts8MK4WPQ>
    <xmx:vXovaKRfWj9fUkhj90XoTRHPytuCchUFvhKR0lw0K4MoEYAFdNJ_hJQb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 May 2025 15:27:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>, "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v6 1/5] object-name: make get_oid quietly return an error
In-Reply-To: <20250522185524.18398-3-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 22 May 2025 18:55:20 +0000")
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
	<20250522185524.18398-1-sandals@crustytoothpaste.net>
	<20250522185524.18398-3-sandals@crustytoothpaste.net>
Date: Thu, 22 May 2025 12:27:55 -0700
Message-ID: <xmqqa5745ttw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> @@ -1081,13 +1081,17 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
>  				 * still fill in the oid with the "old" value,
>  				 * which we can use.
>  				 */

So far in this if/elseif cascade, we covered the case where we found
a reflog entry we are looking for before running out.  So ...

> -			} else {
> +			} else if (!(flags & GET_OID_GENTLY)) {
>  				if (flags & GET_OID_QUIETLY) {
>  					exit(128);
>  				}
>  				die(_("log for '%.*s' only has %d entries"),
>  				    len, str, co_cnt);
>  			}

... existing code chose between a silent exit or die based on
GET_OID_QUIETLY bit in the flags word.  In the updated code, this
block is entered only when the caller did not ask for
GET_OID_GENTLY.  But the point is that if we do not say GENTLY,
we no longer do this "choose between exit or die, either way we are
dead at this point".

OK.

> +			if (flags & GET_OID_GENTLY) {
> +				free(real_ref);
> +				return -1;
> +			}

I am confused.

Imagine that one of the if/elseif cascade handled the situation.
e.g. "The caller asked Nth, we found exactly N entries, so instead
of usual new side of the N-1th, we can give the old side of the Nth"
case is ready to return a success.  Why should the caller in such a
case instead get a failure only because the caller said "do not die
on me; I will handle failures myself"?

Shouldn't it be made the final "} else {" of the if/elseif cascade
instead?
