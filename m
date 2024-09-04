Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2AB1D88D5
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462101; cv=none; b=cmj2jdrNFGS6tslAYHXaG+jUFmWdxvRINtYsFZXKxowle5eK8XuQCxyFIKNnjyj7+e1Yh7I9oHyaqcLF8la4qKVRT2R3bIFfvbpzP7hUhumIP446OkGGgg3v563yF1TaIxWPqxmujoGN0cz6q5IxrbaGLJTHA0UoCsDQQ0NKsng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462101; c=relaxed/simple;
	bh=v53R7/7NOTxclOuVqLPQs/l2cRx1RkxehpUQWOXAJ60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UcKcJG8PlRAiu20QCTK44hRTynGorI0TN5D7SohVhzhjkwnhyJJXvdczEJcOli1pR+6wnaxK6zzetHm+dM/r99bsAkQTAzzLhBhuM+SH934snrcO5ot4yv7CQcjhTEKCVUDUtLZTZnujZOxfNS1zlpPcqBV2SicpTqESASHVMSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VF3cRD4u; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VF3cRD4u"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FF7B35045;
	Wed,  4 Sep 2024 11:01:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=v53R7/7NOTxc
	lOuVqLPQs/l2cRx1RkxehpUQWOXAJ60=; b=VF3cRD4u+tY1Dy88d8Fs98FTZQQr
	LW8NW9uswzkhmLXW5DcaZnWNjNCd+kJQ+grL2Xx1woFpM1nkLiRUMbcRvaoVyCe5
	T0y7BpS8kK2Xcn5MhtiCmPK4AXt6PMswF0L2/nRAUeSUfVLCfRxLDeOwZ0U0GFVa
	Fxqa0S2jk9tzQgE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 400F035044;
	Wed,  4 Sep 2024 11:01:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C8FBD35043;
	Wed,  4 Sep 2024 11:01:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,  git@vger.kernel.org,
  Christian Couder <chriscool@tuxfamily.org>,  Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4] t: port helper/test-oid-array.c to
 unit-tests/t-oid-array.c
In-Reply-To: <CAP8UFD0NMCUeFpQmLzXZmTUQQjQh5Dk79QxxMH_GN62w8ZC6YQ@mail.gmail.com>
	(Christian Couder's message of "Wed, 4 Sep 2024 09:42:58 +0200")
References: <20240824170223.36080-1-shyamthakkar001@gmail.com>
	<20240901212649.4910-1-shyamthakkar001@gmail.com>
	<CAP8UFD0NMCUeFpQmLzXZmTUQQjQh5Dk79QxxMH_GN62w8ZC6YQ@mail.gmail.com>
Date: Wed, 04 Sep 2024 08:01:35 -0700
Message-ID: <xmqq7cbrea40.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 9510862C-6ACE-11EF-8DFC-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Sun, Sep 1, 2024 at 11:27=E2=80=AFPM Ghanshyam Thakkar
> <shyamthakkar001@gmail.com> wrote:
>>
>> helper/test-oid-array.c along with t0064-oid-array.sh test the
>> oid-array.h API, which provides storage and processing
>> efficiency over large lists of object identifiers.
>>
>> Migrate them to the unit testing framework for better runtime
>> performance and efficiency. As we don't initialize a repository
>> in these tests, the hash algo that functions like oid_array_lookup()
>> use is not initialized, therefore call repo_set_hash_algo() to
>> initialize it. And init_hash_algo():lib-oid.c can aid in this
>> process, so make it public.
>>
>> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
>> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
>> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
>> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
>> ---
>
> It would have been nice to briefly summarize here the changes compared
> to v3. On the other hand they are small enough and this version
> addresses all the suggestions that were made previously and looks good
> to me, so I think it is good to go.

I only checked the changes sine the previous round myself, and
didn't see anything questionable.

Let me mark the topic for 'next' soonish.

Thanks for polishing the topic, both of you.
