Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221C426E70C
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754065601; cv=none; b=EqharVUAYfbFPoIaLkvym7d4dK1tE0WK5xhlhFIlBKr03oV3766jN2DE1YJ137hB4pHkx2ndsBFB58Q3cUocUW/I2VVmf4boQrhl1V3ilzPLjPzXYlrGz+LlENfb4T8QISRg+QjqwuraWXN2nPdCBUQzI+0pytxOoY3sHsUfWzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754065601; c=relaxed/simple;
	bh=z1HXbK3WfauDQPRsYHQ/r7+UITsbw6/gK/fnKpDJImY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R4iG/bBFnHTT/a4IG4C6kRkXdP3q5dIm+vNxF81msG+GpEoX7MO3PK1+oVzv+WCuM+rhBY7r4THhcsGsxfmoKhaEm0mNmDF25IyUoA3Rlxz0u/J+yhOMcBYWQTxdxWKt5NtcaVqyMHKbbmYXdiuUVFk8jZgyKFSktIiCSmb18FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kFr9+C/r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NDElKhTf; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kFr9+C/r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NDElKhTf"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 126927A0112;
	Fri,  1 Aug 2025 12:26:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 01 Aug 2025 12:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754065598; x=1754151998; bh=dO4pYL29r1
	wmBdv75ZZezzkl3ae3lIFFSmyhDFAz3fQ=; b=kFr9+C/ro1AIDZDWcAdbBGlfQl
	Q4Sw+9qd9vln2jzbU8WfdcW3C/+hceYCpIfm33H0ncdF7qaYeZWtMO7HWBnw7NGq
	h4vWgxT7U0UogfLiXo/RRiGhsg8Q+kAFiVk6l43+w/FpLaOoLANcIj1qwHmCCTcr
	G3YlAtcdEQrp5jm39hmhpz9Q+ht8g4yDht5n9+CcNXFYjrryRmRnxd9neeD0gUpL
	Mog0c/iYKYFUOVvK+YwziPl3tM/LmxUAmPiTsMfc1Pt/jLFq27wVHMplAm8H6adn
	zA1LRXl1HTQPA06mKQHew1ERtDzQUWMFaKBwSMajwtU7k8fmY34Yj1Biwe3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754065598; x=1754151998; bh=dO4pYL29r1wmBdv75ZZezzkl3ae3lIFFSmy
	hDFAz3fQ=; b=NDElKhTfgbQf6KZwY1L0asHDux1jwRUZWeo8t0YhqgiIh1CeRg6
	BEG7mXc4gw1v9bvoBSMLmDMzbjOw2zDC3hmI8IcAh0goVZB5EmzXU4DKGIZ9dpm0
	W7a98gTovVgk5PicYpzewaC0TT8WurgT6Dn45HVfHGGSlQ4I2y/D+IzCFCTb51LF
	gis1yNMey3afm3XSYuekSS7eFpJtrofcyeckftSilkcJqVCO1w8kvAEQ/uZdv6BJ
	RRd4ktu3KeJbCoUZGJ5yvLLKU9/dXBm0p9jaRVbwvUTblQ8fMu5QGMKtiDIs4oE3
	2q6aaCfrCAda7LL6TQgpGaBCjkBO8VmK2dA==
X-ME-Sender: <xms:vuqMaPhiWkkeinE9TkKPXCMdVjzE2pecV4LPpd5nQjDo9xbPhARwlQ>
    <xme:vuqMaPT7hPFOe6dbe460X1G--XRqWn6ZmVevHgB_hHliEuOq9XXShalP_0qQ3S1ML
    yo2WrsI8_mOZwKj7A>
X-ME-Received: <xmr:vuqMaIgCtxWpOzSCHuyHszYu7ZqZeRAZ81dX6VbTVMrHlUpmERUfdweTjAUxdSLB_jrTbAzsQtX3u38kbvcZriEy9-x1NEAEW57UTEs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdegudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:vuqMaH6_81paGolty36gS0KOYwGuVDV4oqfBM137H6xANkdzeWvZhQ>
    <xmx:vuqMaNA9jY6VWHvdQcxBHoPe76brFyJ5IPyQud4-FND1MwRsPTCOew>
    <xmx:vuqMaGY7P2ElxoBqBD9J2wrDLmr6VvxanXWD8jba0xH9lmPsVxNoEQ>
    <xmx:vuqMaAavgNBoNfkHpA7RDG4RfpKEEfq8A6pYoz2BTGTalIOU8-BGhQ>
    <xmx:vuqMaO3Qet_gNawTHVkbIf89uydBWNTLpNLdVUrjigA7CodMWq_bfayN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 12:26:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 4/7] string-list: optionally trim string pieces split
 by string_list_split*()
In-Reply-To: <aIx_HIjWEDx9pNW2@pks.im> (Patrick Steinhardt's message of "Fri,
	1 Aug 2025 10:47:24 +0200")
References: <20250731063949.1601669-1-gitster@pobox.com>
	<20250731224607.3942417-1-gitster@pobox.com>
	<20250731224607.3942417-5-gitster@pobox.com> <aIx_HIjWEDx9pNW2@pks.im>
Date: Fri, 01 Aug 2025 09:26:37 -0700
Message-ID: <xmqq4iurnh36.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> One issue I have with the `_f` suffix is that I immediately jumped
> to "formatting string". I think in other places we use `_ext` as a
> suffix.

It stands for "with flags".  I've seen _with_options and _extended
also used.  This is like oid_object_info_extended() that has a
variant oid_object_info() that is a simpler and less capable wrapper
for common use cases.  None of these overly long names are my
favourites X-<.

With brief inspection, many _ext() in midx.c are more like helpers
that deal with a class of files with .$ext for various extensions;
they are not the primary interface to external callers, and many are
extern only because the code is spread across midx. and midx-write.c
instead of being in a single compilation unit.

>> diff --git a/string-list.h b/string-list.h
>> index 6c8650efde..ee9922af67 100644
>> --- a/string-list.h
>> +++ b/string-list.h
>> @@ -281,4 +281,14 @@ int string_list_split(struct string_list *list, const char *string,
>>   */
>>  int string_list_split_in_place(struct string_list *list, char *string,
>>  			       const char *delim, int maxsplit);
>> +
>> +/* trim() resulting string piece before adding it to the list */
>> +#define STRING_LIST_SPLIT_TRIM 01
>
> Another nit: I think nowadays we more often use enums to introduce such
> flags, where the benefit is improved grouping. Also, I think having
> `(1 << 0)` as value is slightly more readable.

OK, let's update that.  Thanks.
