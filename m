Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187752571C6
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509371; cv=none; b=hVLRvj6qJZBNt/3L9fWEkMHy0PdXQd5LWLStFCRwViZm4RhCV6jeKYCqfYjrarsUgpFskuArK0KEsTYjESxdMd/aR9py5dKsxOMbZSh7epgL6rvQcyJZVuidJcBSnBSUk13VkFAYktM1p+PtmHLc8QYzLpdLqARgLeYtpFezQhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509371; c=relaxed/simple;
	bh=V8QLYyJ98XNZ7HxY+OOeNE4lyYpkGORpByKo6FXvN58=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XVpEfjHvHCCFHW6fOAZtCkb3TVpqP4ryBtkwkvpD4I1vDyzcV5qaZRfQMNKBhxavLOdpBadPDw+qrmzvQAlBgjEATR2NKFHwJS6386k3BbEzObA9+3KApZKvrtUnWmlC6EdgSaH2MMi8z98sGRMI5Ji0sYLeH0PLIm1EhgU4JdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IspYKmbv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bmREfArf; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IspYKmbv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bmREfArf"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0EBD114003F1;
	Mon, 14 Jul 2025 12:09:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 14 Jul 2025 12:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752509368; x=1752595768; bh=k2kUewW2AJ
	zTtxxkY2R2DiX73RlVHXzG4o6ZHzqkET0=; b=IspYKmbvbSVzrWfp50q2IzF+gl
	aFD81TKBzmTSxKXndEzERPlKgrszRPaChR9v5XUS55wEJB8kTvfaYST6c+oLkoYZ
	IBiF7LnkJ7k+Vc1TTIL2/upjgJLcH4+bTt8wT0J2IDLVMvGAlikfWmKj90bzmugr
	/wr5nzKvYisEYUx5J2NECXFuprb+pdbGJhCFndZL3jHA9Bvlo46gQhaP07Pjh1Jw
	zB9GiRCs2l2MPBikVaRG/k+Xagsb/WRmJODM/gnVNpotOoNgE9pViJxjRInMQK58
	JXzvv/6xHl1sr9LmWTyWQ9teuwcsXvXl1j+7C4Mowirq1QsJHmbLtKx9RcVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752509368; x=1752595768; bh=k2kUewW2AJzTtxxkY2R2DiX73RlVHXzG4o6
	ZHzqkET0=; b=bmREfArfhXnU3FNPCaBM87WsYOS/AAfyGKc9PWOFhVAGQ7QoKOH
	2RpV4OVbwcT5WTEfPKCzJ1MlVglbXstNqOEh/WVIR/KhWPH37UOYkZ6CGCCnoZJ4
	MS65XOB2vT4qjsVJyG5CSfAmwIMaOgF6PEVXnwlK9TZbi6RpX95cDzS/MVsn5L8J
	3UrxYHA7jL23Et+EwZBXaop+wsegNWngyUSWxVmRLFU1Wan3FlbkfIZcPD36GXiM
	VYqG53N+JwagI+F8tQh0vv++++RvZ5lwIkMs1MkkKr7JFKsVO9B3Nl+pLyb6sUk0
	3DzJLQGCeIbV/v7c3cByN4i7LosrINT4oBQ==
X-ME-Sender: <xms:tyt1aMzUduwmeEQG2CeMXbFjZg7Qi-W-AqFGhZh6dA6ccSym0bMbUg>
    <xme:tyt1aIs9m87NL63nQi5bsVoTdy8oRPhlnQJSdxChvf_glAzMHFdmKFbsDnF_f9KKs
    mVXhyUJfpVxXiMieg>
X-ME-Received: <xmr:tyt1aOyFdZvWSzwN__nqXKAK7IMLzm0WgC3BG5ToERsTm87PBQbSfoCQK0tEe3RI1jDC5lSLbZHTSAfKRPfCOh03gef-e5zZM1sdSik>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehvdeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshgthhifrggssehlihhnuhigqdhmieekkhdroh
    hrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:tyt1aLDcYUuz89640NiecNM68WaNlB0bihGYR1z_UDofEg1bPvYTMw>
    <xmx:tyt1aMc1YaahtskK1Z8lVu2VsftTBRjDuQq-aKSzmG-t_eFJf9S1sQ>
    <xmx:tyt1aFkmMWEt-tkhTMh1O0BXNf2yy17J5-ITd5gOyyQlrrgEp0VlYQ>
    <xmx:tyt1aDFOOxFVtkQiajlfpxVol03PXu966JPdEeFiSwHcheHqjSRvlw>
    <xmx:uCt1aKSw0QZt6MkJad8NiQWQrjSr1rTHEFVtUwyWUaJkUtpZU_mjOw2w>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 12:09:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  schwab@linux-m68k.org,  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 3/4] refs: selectively set prefix in the seek functions
In-Reply-To: <aG9hMP9gEFLhVgJL@pks.im> (Patrick Steinhardt's message of "Thu,
	10 Jul 2025 08:44:00 +0200")
References: <20250708-306-git-for-each-ref-pagination-v3-0-8cfba1080be4@gmail.com>
	<20250708-306-git-for-each-ref-pagination-v3-3-8cfba1080be4@gmail.com>
	<aG9hMP9gEFLhVgJL@pks.im>
Date: Mon, 14 Jul 2025 09:09:25 -0700
Message-ID: <xmqq8qkqvjnu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> + * When the REF_ITERATOR_SEEK_SET_PREFIX flag is set, the iterator's prefix is
>> + * updated to match the seek string, affecting all subsequent iterations. If
>> + * not, the iterator seeks to the specified reference and clears any previously
>> + * set prefix.
>>   *
>>   * Returns 0 on success, a negative error code otherwise.
>>   */
>> -int ref_iterator_seek(struct ref_iterator *ref_iterator,
>> -		      const char *prefix);
>> +int ref_iterator_seek(struct ref_iterator *ref_iterator, const char *seek,
>> +		      unsigned int flags);
>
> Another tiny nit: instead of calling the variable `seek` we can just
> call it `refname`. That might give a bit more of a hint what you're
> actually seeking for.
>
> But other than that I'm happy with the new behaviour, where we are now
> consistently either setting or resetting the prefix depending on whether
> or not the caller set the flag.

I am not sure.  The way the "prefix" is used, if I understand correctly, is

 - it is set by iterator-begin, typically to the area to iterate
   over (e.g. "refs/heads/" for iterating over branches) in the
   for_each_ref_*() family of helpers, and internally we seek to
   that area (skipping anything that come strictly before
   "refs/heads/" for example).

 - iterator-advance looks at it and decides we are done when the
   iterator points beyond that prefix

So if you are iterating inside "refs/heads/" hierarchy and seek to
"refs/heads/m", don't you still want to stop when you step outside
"refs/heads/" by keeping the original prefix, instead of unsetting
the prefix to empty?  A postimage of this patch for packed backend
(picked at random) reads like this:

        static int packed_ref_iterator_seek(struct ref_iterator *ref_iterator,
                                            const char *seek, unsigned int flags)
        {
                struct packed_ref_iterator *iter =
                        (struct packed_ref_iterator *)ref_iterator;
                const char *start;

                if (seek && *seek)
                        start = find_reference_location(iter->snapshot, seek, 0);
                else
                        start = iter->snapshot->start;

                /* Unset any previously set prefix */
                FREE_AND_NULL(iter->prefix);

                if (flags & REF_ITERATOR_SEEK_SET_PREFIX)
                        iter->prefix = xstrdup_or_null(seek);

so after (true) seeking that does not have the SET_PREFIX flag on,
wouldn't our iterator-advance run through the end since it no longer
is aware of where to stop?

Thanks.
