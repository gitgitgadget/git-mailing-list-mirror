Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FF936E48D
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 06:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784268150; cv=none; b=pikPmWutTQeZH3ord/sdgbidjDfR6FEU7DBh8YFPJySa9Mc0XbMZWwLbbZ/ZElrKKTm7cKLZRmlEyGrq4fYI/8zHkTCjFmzVqELO5e/9nyAa3JDwkgYf7Tu9jwHB1tuO8r5Bp3gWiVxeBrgLVAS6nyK9hmjVSZzTCb8aJwfBhgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784268150; c=relaxed/simple;
	bh=4je0w5EVH9Geflylv6Hpln2kPXCe/3YhqY40HXDzgtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2RHYgZtCuAaKSiAb5/ViQC37J/e9ohYl9EpCP67hh+HWtvMNTnvvpz8Z8sbz+3+b6GPmTEUpizHCv5sB4A7GTpkQf/Lc8i57cjFLMDKU3gbxfV/x3jtqyrIE3Zs0ilF1eA0WrMRmLD1WgvCbdjCbWfFE0JbhgTvy8yLILqDky8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RdLaiGOx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UHCeaGxm; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RdLaiGOx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UHCeaGxm"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 19D557A011F;
	Fri, 17 Jul 2026 02:02:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 17 Jul 2026 02:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784268143; x=1784354543; bh=6Br7tHJZtA
	1cO7VqC2HRkuV2t9c+ZJr8QmMW1Ci5dzc=; b=RdLaiGOxsvQV95ODiVa0MfHLCW
	6ssFAxHHzDoIONAmnvl5pqIxFFDgNIZ63JjR6VQlOchRzss1N5cBpkP+5JUzMgeF
	1571cUxHWl/r+lrgjPtyhObJFNXtBzoeOJTEauHfcpQyeKV98xg5aWQRP9yIR726
	AdPAMbr2tzaulA5mb8zX4RBAdimv3bqJfBTeWV+u1+cCVQPEODt5BIhk/7bXjAE0
	1UznVuaxY8flp+QEOOQ4dvQ7i3bJCdNBmbjz4Si+hoLEx7EGAWPCrgYVNTU22EqN
	g+7Ywz3VKCI/6zZ8pABLZ0b/mYFGhoLmjX4EBy0Tp3p3vOxJyodj0dJGCQRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784268143; x=1784354543; bh=6Br7tHJZtA1cO7VqC2HRkuV2t9c+ZJr8QmM
	W1Ci5dzc=; b=UHCeaGxmkETs2KCr4oX9eeiJJo3UXKEQ+pFYhLwJ0z+g5L0Q0BQ
	0B3pKKeVzpc8SA3+KI2uLjD1FRcCvTd9dBsLR8ohVlu+htdwrv2/Gtsdx2y4BtTr
	pbA0H08k7qnrC+YNMbHalUQAL42a0P2k4Sxih0xaxDoDs0W1ICXUOFDD/q4qFdzD
	AqbZ+YrYrK/UmDOqJRxbRcKCm7lQN5iGs2SqNj3BtNwkPErkxY3HQijrhSDC81FQ
	hal9PaXQTTR00xXiIIfQvbadRHBFPj3rDkdhLCgVbc+h9GtV+4P0uZdNapxkszvp
	lsFCVrCnEvk21EAuUcdG2ON1R2GMIgZJK4g==
X-ME-Sender: <xms:b8VZap3kFbeAcN3kR88iuL88ZXnpFqnxpqk8_wBAUKqUFCDnFgTzJQ>
    <xme:b8VZamEEB18n4pmwRUwwut0qbtTherfwMSNkn-WkqhxCffqK8FIWYGwqIhhUPNlX_
    L1A79OlhU_0vG5Mng7MQmpSANEtMdApWXJUHRoSApKMRfO9jvP2>
X-ME-Received: <xmr:b8VZanj5oB-rhDRAbpSNzTyHnkE83C8hcOrp7lWs7ZKt0Wl1r27UAo7QpIIEgil7rTj-5Shm5Le9Jz3_ClMWluBrBUJclR8Z_Nwaed69Dc4>
X-ME-Proxy-Cause: dmFkZTF6IF5PdRTGnvTZmVGAz+KzfY7uZgmlRBrZBpYqAh4lCKPljfYFmTkKF6gvfX9w8U
    41Mx4SV2jb3iowXl1Nm8pbWgyW5Y5X1qND3s84RfK3FdOw795CoJVWE1egxQBzx3RwOhoZ
    UsXA3MKmP8ASAGUoCSwGx403Xtt98HpVwpkqORVhbM9LFDusubltQgdi/pRXVQNKqaXGtW
    5bd7y48Lo8G6GiKzgMe/8ZkD0qice/4o1b9AgTb2ZNLmAlEgB5bkf5ubTgqKjdg+A3s97m
    pxJIPsBGUsrFubl8K7RMayN9NP/WeMVc89LdE923VmGySsNCwqNIs74oEm4yVxmRZEzkjO
    Pu+rZUjqadJ32dKP9TTar6ImpDKdp1GEZL+Hvt74dvht7B1E85Z1sosAlzIxfsNHrcHG3M
    z3V+PvYM3mhdCoM8VsWF3KN6QhzkZOFCT1loD8CGrw/Lf1BWoXn0QLwJFLt36ebmkENbFI
    ZR1fJJgUonbE8wv6bgcF/2gzkb8b9gAHWAOnfHYKfZxK7Yf+tR/j9PJZLelbokPParNkqb
    QQBMZj1qAyDgU1mDhcYqHwVXno+NO0h4a7uCSYcXCL9R2o0MHAfdJ0gTxAH3s8qX9wWZhV
    hQt9SuCUKI8SLJ/xJ4ijQ6CvBZjMbJO4UH/aYTQYf8owaM4P07V30e3d6HwQ
X-ME-Proxy: <xmx:b8VZah9RJkpREObq6QVrwkDJc1Lmch08PDl67y6ERAztbid4ssv5hQ>
    <xmx:b8VZaurhjJOgn6AxrxZHNPEcWmaYrBwnUxlv-qRdtQci9PvB-kMnTQ>
    <xmx:b8VZag9YRDMT2ryK235JH59F8C9OG3O9jSBvtUjnYaXdXd4TeikpsA>
    <xmx:b8VZaiWrn0b-8P191inUOqMNTz72-K8EICJRywERj7vYcoXEofZfwg>
    <xmx:b8VZalOFkiWiID15aQZQnEjWn74KE9zF-09c5gURpCpVEEd-KqfkmeMK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 02:02:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 451fd001 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jul 2026 06:02:20 +0000 (UTC)
Date: Fri, 17 Jul 2026 08:02:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] refspec: stop depending on `the_repository`
Message-ID: <alnFZe5jqvFdHQdh@pks.im>
References: <20260716-pks-refspec-wo-the-repository-v1-0-aa40844d067f@pks.im>
 <20260716-pks-refspec-wo-the-repository-v1-3-aa40844d067f@pks.im>
 <xmqqpl0mejlc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpl0mejlc.fsf@gitster.g>

On Thu, Jul 16, 2026 at 01:59:59PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The only remaining user of `the_hash_algo` in "refspec.c" is
> > `refspec_append()`, which needs to know the hash algorithm so that it
> > can parse the appended refspec item. In contrast to the functions
> > adapted in the preceding commit, this function always operates on a
> > `struct refspec`. As that structure is expected to only ever contain
> > refspecs that all use the same hash function it doesn't make sense
> > though to adapt each caller.
> >
> > Instead, adapt the structure itself so that it gets initialized with a
> > hash function and use that hash function to parse new refspec items.
> > Adapt callers accordingly.
> >
> > This removes the final dependency on the global repository variable in
> > "refspec.c", so we can drop `USE_THE_REPOSITORY_VARIABLE`.
> 
> While we lost some references to the_repository, we gained
> more references to the_hash_algo in exchange.  Because
> the_hash_algo is defined in terms of the_repository->hash_algo,
> it is only available when the_repository is still in use.
> So these changes do not really help callers, and only leave
> more for them to clean up later.
> 
> Which is probably fine.  We have to start somewhere, and
> refspec parsing is a fairly well-isolated corner of the
> universe that serves as a good starting point.

Yup, this patch series follows our typical approach of making one
subsystem `the_repository`-clean, but bumping that dependency up into
the next-higher level.

I've got a bunch of follow-up patch series that'll also convert some of
those higher-up dependencies. Most importantly, I'm converting all
subsystems that relate to the transport layer, as I'm on a very naive
quest to try and get git-clone(1) working without `the_repository`.
Let's see how far I get.

Patrick
