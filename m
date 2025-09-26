Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0461D31B9
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904256; cv=none; b=f30lHL6plY8sUc//eqBvdbi6U6Q8jiGF8q1GzdTsV5D1m/yrvyEUlxkWwDz9Wabm07P7cYaqgT8yAQqHmaI8T7RZ1iyLSgGYXWgiLEOsyUHbqCbwcjmY1/EZd9iC1ez4pw7JRz+N98jekjgbJh99UfRwJzX3Ti9Q8kRTHb7xoE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904256; c=relaxed/simple;
	bh=dyfUNftq935HEcE1/uuCwL2+fMzEKDkBVwez3CAzm4Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y52P0/7fAODDLwcDbowP/fellPEYwswdvAgl5qHt6zChPCIaCOPZHog9ijleY+Kfh9ophkGGWfN9hqZz3g04sIWf28Q3p2gTGLVuPpmHN3KiavPpTqjYcYL8Gql4/oxgc+GXX0/urSGpaBJ4UeZEsjPxR0e16eqLi9VfxqWQjR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XZxe/Bnc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bv2uW8wF; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XZxe/Bnc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bv2uW8wF"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8C2107A012A;
	Fri, 26 Sep 2025 12:30:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 26 Sep 2025 12:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758904252; x=1758990652; bh=jQrJrFzsc+
	fMblSfh3sWeTTBTIlL0TOUqOkxNcfr9Yk=; b=XZxe/BncKeRP+RfIeqYfMAryMD
	zxOUVIoa8yooy3hDnnR6r0c+Za1Ylx4y5R+UgG5ZEP3I4xLXzdQw7+zkM30GYENt
	W7erxpZAu9uvMKLfnZt9vYereYAlYPvm/YPo4TfqC3OdfdoKgqmBRF6UyBd24w1M
	TFWBqn5n34fol8keSdy9F7BphtV7kL7w1eShpO+0B8mxGmChfn0q1HREFI7ZR/WG
	WuDOlz5jI+dXOg6/941H1z00AA+VzutSCBBmMQFZvbjCSdD+VFxuikBXGuYYDgHV
	Dc8XUQB1zWj9wBH3lfUU2hxm3uJjzwW+jP41KigEp63NgJveX+9FZPm+C3Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1758904252; x=1758990652; bh=jQrJrFzsc+fMblSfh3sWeTTBTIlL0TOUqOk
	xNcfr9Yk=; b=bv2uW8wFx86PxOKXZCqqPtWlDSUYYQW9LMNVOlSwrSh1nWoRJYC
	qju3H/jdRLRFM57C14B4Th5LpsDVTle/5EKP0ktWYzrOKjcYSpv3yT3JSPzAiO5M
	1GxBadbJ5Vvcf3y1Q1GrU0Y5X0BU1XQw+9cO9lhKBuBQRIHweabhyuJlvSSMhDUf
	9rPrtGHW724uvFx8dbl4b36Ao3jvztimNPakbHfrj3q4+LOIq2jhydzfylV6b23t
	+Csph3pPiVo/9k+o12zCalh9GUzZNWiSkMIeUCG1Qa3IlQcxkbzonKAyJiffQyKZ
	SnlxIj5mQ+6PRdnFG+cJt3skapQ53FV3Yvw==
X-ME-Sender: <xms:vL_WaJzwSymuvCH0yaRrEX57TnRjhA36r0mcDyAq_BabS5DAecvIcA>
    <xme:vL_WaARbgEp7ygKsboskT6qkHffmC66quPg01v-lY-7HEznk7UbZNkyoNWWaKUVh6
    okEnroAkNeS2o2qhrEqzECJjEg2V9wgjmYNmT4ZbDi8Ln1zWZq9-KE>
X-ME-Received: <xmr:vL_WaIVmBthlEj9HTYomsgr23GQ62HjmOxSslVZliGJ03jJR7kw1fDvYpvQ8q-GPli1aFGygkrQmHnKIcqPzvmo_DNDSt3gpo3Kf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeileekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vL_WaKYykWxpTA3gvj5uCVwVDbIU60ptUdcO9KmTmp06QvwJBxPuuw>
    <xmx:vL_WaG3qnP9mR2Bd7iNDVLCkWZN2PxazYZ0TzssQG-dNkHH8bIg7GA>
    <xmx:vL_WaEgMgMHjFK65i9mRaaddSL0nINyTU7UlidFYlAZzN_yQPRQ0SA>
    <xmx:vL_WaCb-2Lh32uCG_7LtN3UgZ2JdWRv76IX09haC8NgbRwG-JrzF3g>
    <xmx:vL_WaP0ElLB_cwchZe3abo6hsAErPhR0WxDttBMwHotxoV9wOTlbPiTh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Sep 2025 12:30:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2] refs/ref-cache: fix SEGFAULT when seeking in empty
 directories
In-Reply-To: <CAOLa=ZSfL1CVCNjD0Vi3kpQqLM6t7YVa=G2ChGpaza6WOjZTCw@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 26 Sep 2025 03:41:58 -0400")
References: <20250924-583-git-for-each-ref-start-after-v1-1-c73be2b5db5a@gmail.com>
	<20250925-583-git-for-each-ref-start-after-v2-1-3613b5a27ff1@gmail.com>
	<xmqqbjmyh353.fsf@gitster.g>
	<CAOLa=ZSfL1CVCNjD0Vi3kpQqLM6t7YVa=G2ChGpaza6WOjZTCw@mail.gmail.com>
Date: Fri, 26 Sep 2025 09:30:50 -0700
Message-ID: <xmqq5xd5ch1h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> This wouldn't happen because before the loop starts, we set:
>
>    dir = get_ref_dir(iter->cache->root);
>
> So, `dir` will always have an entry (i.e. 'refs') in the first
> iteration, after that, the checks in the while section  of the 'do {}
> while (...)' loop will kick in.

Ah, OK.  So we know dir->nr != 0 when the loop is entered for the
first time.  We may descend into a new subdirectory and at that
point we might hit dir->nr == 0 and that is why we want to catch it
at the end of "do {} while ()".  Makes sense.

>> I wonder if we can leave at
>> the beginning of the outer loop, even before sort_ref_dir(dir), when
>> dir->nr is zero, or something?
>
> We could add it there too. I can't see the merit of one over the other.

No, I don't, either.  As long as we know dir->nr != 0 upon the entry
into the loop, the check at the tail end in while() is sufficient.

Thanks for clarifying.  I wonder if a bit of update to the log
message would help future readers of the code, though.

    When using the files-backend with packed-refs, it is possible that some
    of the refs directories are empty. For e.g. just after repacking, the
    'refs/heads' directory would be empty. The ref-cache seek mechanism,
    doesn't take this into consideration when descending into a subdirectory,
    and makes an out of bounds access, causing SEGFAULT as we try to
    access entries within the directory. Fix this by breaking out of the
    loop when we enter an empty directory.

or something?  I dunno.

Thanks.

