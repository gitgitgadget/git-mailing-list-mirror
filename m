Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C06B641
	for <git@vger.kernel.org>; Thu, 23 May 2024 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476570; cv=none; b=qaaJf86q4FDaWrnbfMKIM8+98atnMKAgbW0eBOVO7QM6sntn7j8CKs7dYX+/TiYBB76VJf0EErXpfrmVHMk1+2dpQHQkAvnZHtoDyiECtcwcXjVFlOZd6OfBgN93Z5ajocIbqgNT9ZmgbZaikv2FmoTfGFRv1azkSMveh84Dn70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476570; c=relaxed/simple;
	bh=Hu2BLchpSg/vDM02mDkMt2dkVIPYeaaJ9s1aouktclA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HI7dw6enRYUC7sLuYFGGWnYpHi112HjpNuwHvwOT8985ITxT9mLcst3SQCRbk7apggPk7CSagST9cdBc2A+nZM9Wblg96PHsbmX4oU3MGLNLoJjKgAs3K0Owsr7dLVQxuvVNuvLI8l4HHS79W2FJcvtUjO4kNdEeIgwlNqtZDO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CqwXzISz; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CqwXzISz"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 781641CD02;
	Thu, 23 May 2024 11:02:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Hu2BLchpSg/vDM02mDkMt2dkVIPYeaaJ9s1aou
	ktclA=; b=CqwXzISztgsipDZbQgU7uvi7a5CJBnTr0G24FKvf7J1ETt6OeaDUQi
	BDFtYPJNZRPH4yfcPh5wiE5e22ulBhj4WgH60YOHfmkD0VqyBQHab6TXdmYJYgPx
	Jt8ZlAQAjTJj+Nwy0Qw3Cqf7Hr1IqTsdyrX9K0jpIySOZ+fDjo1oc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7105A1CD01;
	Thu, 23 May 2024 11:02:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BDEBC1CCFE;
	Thu, 23 May 2024 11:02:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 0/6] update-ref: add symref support for --stdin
In-Reply-To: <20240522090326.1268326-1-knayak@gitlab.com> (Karthik Nayak's
	message of "Wed, 22 May 2024 11:03:20 +0200")
References: <20240514124411.1037019-1-knayak@gitlab.com>
	<20240522090326.1268326-1-knayak@gitlab.com>
Date: Thu, 23 May 2024 08:02:41 -0700
Message-ID: <xmqqbk4wy3ji.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 816915F4-1915-11EF-8276-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> The patches 1, 5 fix small issues in the reference backends. The other
> patches 2, 3, 4 & 6, each add one of the new sub-commands.
>
> The series is based off master, with 'kn/ref-transaction-symref' merged
> in. There seem to be no conflicts with 'next' or 'seen'.

Wait.  There is something fishy going on.

> Range diff vs v1:
>  1:  1bc4cc3fc4 =  1:  1bc4cc3fc4 refs: accept symref values in `ref_transaction_update()`
>  2:  57d0b1e2ea =  2:  57d0b1e2ea files-backend: extract out `create_symref_lock()`
>  3:  a8ae923f85 =  3:  a8ae923f85 refs: support symrefs in 'reference-transaction' hook
>  4:  e9965ba477 =  4:  e9965ba477 refs: move `original_update_refname` to 'refs.c'
>  5:  644daf7785 =  5:  644daf7785 refs: add support for transactional symref updates
>  6:  300b38e46f =  6:  300b38e46f refs: use transaction in `refs_create_symref()`
>  7:  f151dfe3c9 =  7:  f151dfe3c9 refs: rename `refs_create_symref()` to `refs_update_symref()`
>  8:  4865707bda =  8:  4865707bda refs: remove `create_symref` and associated dead code
>  9:  4cb67dce7c !  9:  2bbdeff798 refs: create and use `ref_update_ref_must_exist()`

4865707bda has been part of 'next' since 0a7119f2 (Merge branch
'kn/ref-transaction-symref' into next, 2024-05-11) and was merged to
'master' with 4beb7a3b (Merge branch 'kn/ref-transaction-symref',
2024-05-20).

I am confused why we are seeing a total reroll of such an old topic.

Also you have one more patch at the end.  Neither the before or
after version of 9/9.

Is this actually a single patch submission of 9/9 alone?  Patches
1-8/9 are all old ones that are in 'master' already.

Puzzled...

