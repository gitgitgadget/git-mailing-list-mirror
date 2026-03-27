Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194A940DFB0
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 23:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774652467; cv=none; b=nA2MXKQd90Zf8+fKL1HDXEAY6GH5gE7i+yhsJSsOnY78ikZk3aKGKB3Y6Az8KkqEy/P48o3TkFx6F3X8kdwntEH73PyhXQjf8+fAQQwF/kbvv7owE5lG6sWHlCkxClRYsAmb5j+KGpFvayX7i8orVFOhwzshqaq0dPTQF57zjIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774652467; c=relaxed/simple;
	bh=6pWne4eDLCLvMKDTpUfIhJcgQ5750mvTork0Wrr9O50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G/7W6nhGzMd8CUYwcYmAa+H4EJvO3JUqreVZlD0baPsC2NZp6PZN49U9x3aAJJYQtIb19perewTMpB992gTCDJXBJuvzIngOKckOI/aOzd5Ic/NslAvFfoWAnEOWlEsQNIwtBvQRVV6E9A/fso77pIAAK16b/c/Nrsc56Eb6mYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a/QuWXwi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KTf2VLpg; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a/QuWXwi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KTf2VLpg"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 05B501D0024A;
	Fri, 27 Mar 2026 19:01:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 27 Mar 2026 19:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774652464; x=1774738864; bh=JeCYbbmuLQ
	G7mYyS9K+5I6oQwmqbvLfZgldkc5+2RoE=; b=a/QuWXwiIToqxNHKO9lmm/Zfjm
	ucHHuk2N2lg+jvyn7u1hK5xLSnzT0CaiNdUayGQlv141NuyGO/HRJ/TlTxAGEkjq
	t7VhgzHLho3dY2uLmpWxqJmVOInsqBOi6L+pfP7V8rA6sX8L+zyZSh8Tu1XpVQym
	jUcne/hrYcaSHMTaQhxbowsB8mtsx+0SV5LgVlS92tneDB2WT8PScsavzw+4c6MW
	7KQ6RibXnkKA9CwF/S/QsK3nmKdWMOdM0U7nyw7dbXT+b6i6qCoAJ5kOSGt3Zdhk
	TnNxCP0IGZ/Gn2Rv8uqmm0mnLZECCMfOmBRKyykIaPjvGq1unR1KGa+8w90g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774652464; x=1774738864; bh=JeCYbbmuLQG7mYyS9K+5I6oQwmqbvLfZgld
	kc5+2RoE=; b=KTf2VLpgmyaD13CYl1K/2h6EIm+66Ab3ydFpFD9cORzYE/ozjRU
	uhLIF8Fv/dU6RAGmObVLTn4q+lIe5GiNF1OBlBMBWkrEft7tmbDx+5UkCkfjBfpS
	ZalmzswW1fOV9n3V5KXOFN4P1c+TwzcC/xqoxqVxf7wQ6qgPO3TTq/6M+J8cEXAc
	pfDdPYWyaj+xgMJgwNPXm6WYXH8Nw3IprNslkIP2/n/OXPjQwH2n7iZ2NS5b41hi
	tnXAIqdAZRYvGdI9MXz4V1j0E0Tg9c8AdzZBreh8+ETAGXNi4tjxtSEXvIZLrtJU
	G6dBhwZ3nuDIUvGJZHvrS2XZeyjLHBQNodw==
X-ME-Sender: <xms:MAzHaYT1de6_XFXJbuXBuwhb73JaYa-7aEMWuxOTv_UABA8g3l0b8w>
    <xme:MAzHaYUBMoOIKphkK-J9qXKFEJYA0-iPzPPsKd5KaRzGn6HMVjlDWqBjtnhWgPmQo
    K04Mm-puOpEmYvBRt-LQCbheBuKFZ_-HComgU7nDkmCUDEq4z3QMg>
X-ME-Received: <xmr:MAzHaZf4YQ0ylbJgs70x9KtDd_ffodVUXfB4DT2KbR6CGqOsfPL0WKqMmSEvKWe4lCCoxBvnzV8123TeFTzAglAu3iPRKH8fTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeduheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    peihtghhihhnrdhgihhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggs
    rdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgif
    rhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:MAzHacI3z-LTgfRbfXRGBYRksgfPdyFIDUn3YwIi8rdmyKTiqPMHIw>
    <xmx:MAzHaWw5q-L3NhtXVrICymo4EP3pJUqLHMJMr-ik5Ww-WgQ2MgmR_g>
    <xmx:MAzHaSsxsAG-5ilV9hkSBsMx1wBcIQbLoio8mXm1jwKvOM6dCclLbA>
    <xmx:MAzHaZCN3GoHvS-OdpudPAOXWfIs4M94xrkYHqDk2mS5wuhBx_Pm7A>
    <xmx:MAzHaT1WB0x50mG6ISPS62daqO8DOpCTnMoVIxHBK1qgl0kmbgFP-7UE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 19:01:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Yee Cheng Chin <ychin.git@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  Jeff King
 <peff@peff.net>,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH v3 4/6] xdiff/xdl_cleanup_records: make limits more clear
In-Reply-To: <xmqqy0jdhtd0.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	27 Mar 2026 14:09:47 -0700")
References: <pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
	<pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
	<86dd98db9b93651b21adaa41ccd44917910fedcc.1774639433.git.gitgitgadget@gmail.com>
	<xmqqy0jdhtd0.fsf@gitster.g>
Date: Fri, 27 Mar 2026 16:01:02 -0700
Message-ID: <xmqqcy0oj2s1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Ezekiel Newren <ezekielnewren@gmail.com>
>>
>> Make the handling of per-file limits and the minimal-case clearer.
>>   * Use explicit per-file limit variables (mlim1, mlim2) and initialize
>>     them.
>>   * The additional condition `!need_min` is redudant now, remove it.
>> Best viewed with --color-words.
>>
>> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
>> ---
>>  xdiff/xprepare.c | 19 ++++++++++++-------
>>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> t4071 and t8015 do not like this step, even though they are happy
> with 1-3/6 applied.
>
>
>> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
>> index 386668a92d..2cf1f8d1a8 100644
>> --- a/xdiff/xprepare.c
>> +++ b/xdiff/xprepare.c
>> @@ -268,7 +268,7 @@ static bool xdl_clean_mmatch(uint8_t const *action, ptrdiff_t i, ptrdiff_t s, pt
>>   * might be potentially discarded if they appear in a run of discardable.
>>   */
>>  static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
>> -	ptrdiff_t i, nm, mlim;
>> +	ptrdiff_t i, nm, mlim1, mlim2;

Ah, the problem may manifest itself in this step in the series, but
the root cause might be before this step.  ptrdiff_t is signed and
that is the type used for mlim/mlim1/mlim2 here, and before this
series these counters count in "long" that is signed.

>> +	if (need_min) {
>> +		/* i.e. infinity */
>> +		mlim1 = SIZE_MAX;
>> +		mlim2 = SIZE_MAX;

But SIZE_MAX is the maximum that a size_t (unsigned) can take.  No
wonder assigning it to ptrdiff_t and assuming that any other
sensible ptrdiff_t value can ever reach it.  Instead, this
essentially assigns -1 to mlim1 and mlim2 when need_min is true.

>> +	} else {
>> +		mlim1 = XDL_MIN(xdl_bogosqrt(xdf1->nrec), XDL_MAX_EQLIMIT);
>> +		mlim2 = XDL_MIN(xdl_bogosqrt(xdf2->nrec), XDL_MAX_EQLIMIT);

This side I do not think has much to do with the breakage, but the
way XDL_MIN() is implemented, it must be noted that xdl_bogosqrt()
is called twice on the same value with this rewrite ...

>> +	}
>> +
>>  	/*
>>  	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
>>  	 */
>> -	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf1->nrec)) > XDL_MAX_EQLIMIT)
>> -		mlim = XDL_MAX_EQLIMIT;

... as opposed to computing the value only once, in the original.

>>  	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
>>  		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
>>  		rcrec = cf->rcrecs[mph1];
>>  		nm = rcrec ? rcrec->len2 : 0;
>> -		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;

So the original said, "if nm is not zero and need_min is true, do
not bother comparing nm with anything, and always use KEEP.  If
need_min is false, we use INVESTIGAGE only when nm is large enough,
otherwise KEEP.

>> +		action1[i] = (nm == 0) ? DISCARD: nm >= mlim1 ? INVESTIGATE: KEEP;

Updated code, when nm is not zero, does something different.  if
need_min is true, mlim1 is set to -1 and presumably nm is a count or
length that is bounded on its lower end with 0, so it is larger than
mlim1 (== -1), and we always take INVESTIGATE and never kEEP.

So the rewritten code is broken when need_min is true?

I suspect the remainder of the patch is broken exactly the same way,
so the remedy would be similar?

>>  	}
>>  
>> -	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf2->nrec)) > XDL_MAX_EQLIMIT)
>> -		mlim = XDL_MAX_EQLIMIT;
>>  	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
>>  		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
>>  		rcrec = cf->rcrecs[mph2];
>>  		nm = rcrec ? rcrec->len1 : 0;
>> -		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
>> +		action2[i] = (nm == 0) ? DISCARD: nm >= mlim2 ? INVESTIGATE: KEEP;
>>  	}
>>  
>>  	/*
