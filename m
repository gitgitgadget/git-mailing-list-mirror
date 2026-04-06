Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6634038B7C5
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775501353; cv=none; b=Mczshq7X0mGshMrucZq52Nj+46EW5LWj1xrbbu9IssAQET1qjxmzwcZ+/1UzYclgobG2iQgiljlnCwyN9tAHAHaqEGBvSpRzBL1H6zMsEjMKY0l94Df4OUI1ArK+7c1SCIBeJiQTMwK5tx0UCejTKRAk6tKjZgtCO1D/a5771P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775501353; c=relaxed/simple;
	bh=t3faZrzx6EnXYRj360ouRieloM68Cw/l2E3PPlhcliY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PTynGSc1DKMLixqyPJuwXy8HKcp/+8tjEsDrMvpihvUVa2Rx5WE9u+Esb2g5XQzkGrJZx+1A9N/FfBitmgF04S5avWxJSdeh1+EY+scWRJugvTQkAKDajKByGqeWQo1rEFrNfiNC3WgWuSis9uEh1Hrm5p6BV08pQV7zOFmOMWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kBmwF2O2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BD0Hezs5; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kBmwF2O2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BD0Hezs5"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AFE7A140011C;
	Mon,  6 Apr 2026 14:49:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 06 Apr 2026 14:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775501350; x=1775587750; bh=mb6rGNrqAf
	vmrO7cDqKioOiZe2JTHNS9mNjnlANlp34=; b=kBmwF2O2Fbs1otH+z73eJpBmbZ
	LXZu+ia9e4HLsoMIVpDYRDPCh9FGPGAx5SYdOgDbpMOqidpZrPYFX7U4Yi1r5nhY
	YlG6Jmn8hoa4Aw6G0+fSNUrfhGHsIZBD/PM3NZOIa/S5h0Jx+mf+kapJKYQiVU28
	omzrQI/wCoG2aTCUw9bQXxRsxH+wrLacyKKBdN89VWXywCkQCpNUi0qYk3vL6zag
	XJblDxggdjPnsZ7yoBJGoL0mlRIrOdICOWoqBnYnibB2RNwhOuNic8EMqM1LHScQ
	uCI3Qd5d93V6JNjqkESChacqy0uoxwCixI7xrySwKvEHjQgJufiGrxU+bLzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775501350; x=1775587750; bh=mb6rGNrqAfvmrO7cDqKioOiZe2JTHNS9mNj
	nlANlp34=; b=BD0Hezs5X87q3DhMvugkq3uL6ftTP0RlceceP9uPN8GYHS33iLf
	52LrEKEeiZETLAbmGbnTMSGo2UjiFiqnlqlOcFT+0oNIiXCGgIo5CUfPT0XxopBJ
	DzWqRtNdn5gbAPClVTcdH7vQ8dsgULFiFOpyXvC/u/5/s0//B2dm1J1MvFIjh5i1
	kKBV/qhazGmlXuQH7WEVH7wYsbXyXLE4j2wqcyHIUIfX4AmudlPI+7UbBFiv3jUU
	W2KCu+HWY6E4UmM35Q5tMmW7+UjHmb1yCwBMJQoxmmYiB4932cmhAcYo+H7tXeer
	2oyB8eU+dnysiy+L4YY+z4UcAidrLXHBLwQ==
X-ME-Sender: <xms:JgDUaWHx3PE1gQ2WmBndxLp-gjjm35JgOBp1tJFoDZeCk3yAqEfykA>
    <xme:JgDUabAtzRZG6-Pu9SUeH-5Ho99ZxKuUYpNEZTsx6Z9R-4gX3pOeqLkigB-yU7BXu
    tZzGJQIj5KlVZtQijV4RCrmMdQYdinLkJKJ1z1hCOoO2w9om1Fs5w>
X-ME-Received: <xmr:JgDUaZ_uaxPLRqA_fm6ym6PfNg98mSL7TztIcUiBRjNasaUhTqeyadqHhtgsG-IbaMJ1Zmifdvg0PrvYEgyM_Vdi2j_VkcLcbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopegurghvihguiiihlhhinhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtph
    htthhopegurghvihgulhhinhesshhtrhhiphgvrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:JgDUaXDj2P3IhwqB96MzsrByqCNMo5igD2DX8R9s35QHgR4Zju-75Q>
    <xmx:JgDUaeRFZSN2RbdMt7pIuShNIgK5HD0yKmvm6j5jjKGCvEWyYMIJBA>
    <xmx:JgDUaeu4ScTc5U8GtR3NTrwP7Pr5yux8gorNgNxggDjjPJYRPiwHrw>
    <xmx:JgDUaa1UMyBzbu04SoFyvhQlcssQQ-Xn3s9kIps8SaZQXQYVyM6aig>
    <xmx:JgDUaYCelHZMWlDXh-KS2-Qp1b2IrZ_bAWtdbH77i43p1QLBZSpuE9hi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 14:49:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: David Lin <davidzylin@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  David Lin <davidlin@stripe.com>
Subject: Re: [PATCH] cache-tree: fix inverted object existence check in
 cache_tree_fully_valid
In-Reply-To: <b0ee86fb-2fb8-4c7f-904d-66140b58164d@gmail.com> (Derrick
	Stolee's message of "Mon, 6 Apr 2026 14:10:16 -0400")
References: <20260406151456.63620-1-davidlin@stripe.com>
	<b0ee86fb-2fb8-4c7f-904d-66140b58164d@gmail.com>
Date: Mon, 06 Apr 2026 11:49:08 -0700
Message-ID: <xmqqcy0bc4bf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 4/6/2026 11:14 AM, David Lin wrote:
>> cache_tree_fully_valid() is supposed to return 0 (not valid) when a
>> tree object is missing from the object database. The condition
>> currently returns 0 when odb_has_object() succeeds, which is the
>> opposite of what is intended: the cache tree should be considered
>> invalid when the object does not exist.
>
> It looks like this negation occurred two refactors ago in
> 062b914c84 (treewide: convert users of `repo_has_object_file()` to
> `has_object()`, 2025-04-29) which had this diff:
>
> diff --git a/cache-tree.c b/cache-tree.c
> index c0e1e9ee1d..fa3858e282 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -238,7 +238,9 @@ int cache_tree_fully_valid(struct cache_tree *it)
>         int i;
>         if (!it)
>                 return 0;
> -       if (it->entry_count < 0 || !repo_has_object_file(the_repository, &it->oid))
> +       if (it->entry_count < 0 ||
> +           has_object(the_repository, &it->oid,
> +                      HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
>                 return 0;
>         for (i = 0; i < it->subtree_nr; i++) {
>                 if (!cache_tree_fully_valid(it->down[i]->cache_tree))
>  
> This was one hunk among many, so it is easy to miss that the ! was
> lost as the function was renamed and moved to another line.

Thanks for archaeology.  It deserves to be recorded in the proposed
log message.  David, would you mind updating the message and repost
a v2 of the patch?

I wonder what the practical effect of this breakage was.  The added
test only checks what happens in the trace, but what was the effect
externally observable?   We did not rebuild the cache-tree when we
should have, causing "write-tree" to record a set of tree objects
that do not match what is in the index?


>>  	if (it->entry_count < 0 ||
>> -	    odb_has_object(the_repository->objects, &it->oid,
>> +	    !odb_has_object(the_repository->objects, &it->oid,
>>  			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
>>  		return 0;
>
> This fix (respecting the has_object to odb_has_object refactor)
> is the correct one.
>
>> +test_expect_success 'cache-tree is used by write-tree when valid' '
>> +	test_commit use-valid &&
>> +
>> +	# write-tree with a valid cache-tree should skip cache_tree_update
>> +	GIT_TRACE2_PERF="$(pwd)/trace.output" git write-tree &&
>> +	! grep region_enter.*cache_tree.*update trace.output
>
> nit: I think this would be better as "test_grep ! ..."
>
> Thanks,
> -Stolee
