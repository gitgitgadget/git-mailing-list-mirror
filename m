Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D66C434409
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783528437; cv=none; b=i1/VJBo9AOaaqj6rKBVcvJRa/SSni1jhILUL778lWEeU62o22P6hVWR9e6f5NwPVYX3mN0sHcV9ZNLr47CMtLqEQGf46WY74QwANeIjYJTFi7LYmP4jC8IoZ5QpCJqOz8Is1r+vVKHLJluOjZXrVvK9otF9newXe8BZJbxJHFIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783528437; c=relaxed/simple;
	bh=F6044NvcbCnPjJWrMe+uDmcNg8UizkT7nfeHwGXS+n0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I59I1I9sV1l2rJXZKlN9YV420GxXVlseCP3LMgCCzK3CtMxJ8HNMOYryx0CFx9auKcsRz2tKwGXqGhBmReW0BAcWaw1g09S0I8wJWIrJ3+2U5hg2cNDYwnjMHf5AT3Ti1Sye8zPvlJBZ8XOP7D1OywcrbGCqHqOaP8DbLmoMhOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dg3IluQ8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OqCfZGzn; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dg3IluQ8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OqCfZGzn"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 770D7140005F;
	Wed,  8 Jul 2026 12:33:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 08 Jul 2026 12:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783528434; x=1783614834; bh=RS4nBzOn9L
	tAkAh+LSPryotZWg8G5Mpq1IwE/RdIMSA=; b=dg3IluQ8LQP7YbZel23w6/DMsJ
	O+d2o9iJXxXDgOFBBNqq1sp8GL1GRBG2adK4msV8LkhesI+0SQaVHr66hFaN8K0y
	V4Gdu6Lpp073buBeh7QkgIyWAL6xNv9hK+LpJNfH/Xh2GDlfnbafLpyN/nPXS6bh
	hdyjC36tKwOD9N8iEMymomCBTOmk++Sr5SZcVSk3yARTnNXidcmWaAMaK7YEbTnF
	A/V5/jstB53DEKgxOvDHnX9+Irq485wyBxgkMpcc4QtBy5kPyIxWcX73CWZ5UHNE
	JFxBL1eqRMq4pz4qEmpwmzEqdFljntWHo3uBfd8prYuR9Vq6g999YrE+u2GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783528434; x=1783614834; bh=RS4nBzOn9LtAkAh+LSPryotZWg8G5Mpq1Iw
	E/RdIMSA=; b=OqCfZGznV09yV19lSN0osiDbCh4WaEw/mFqnXzZBpMkVmwZ3fya
	+QQEJsqyyMtdNvXIbXstZsvpRyEruxKlR5zILwn4Ps2h3lmNoQm8YNalG5F23gtW
	GHwtY0b+hCvkzOU9wflxlQh2EdfrnSpcwbVWEAsnqa4tsC76hMDUTBIvYSDrDsSF
	rYctawnFaQsWKosXpjjtkwyVD2cTwsrl4v7eQSOAqrla+HgyIZ9UgsTXxwdI6Cq0
	TyDuMWLSqW+pUZtzDfT+qnu1rXBvV1Vk+lc26CODwCetU5lrQG0rauhgzeo54kDw
	H4OQ3QuAetHuSC1uAX2mqFek1w/NKwIRklw==
X-ME-Sender: <xms:8ntOauaHcrkdNSsdce_0lYUsm-sqjFYclACvsdRlj_3_ZQiZ7-axLw>
    <xme:8ntOaoZBE_taQD6KirqBsq4H1Yc2EBoQcMrSEIwDVbnYoLYs67Umconyj-h7I6oig
    8f2ehhK0O5Ndut4F6pRgvpLNpYg20V2Apf_R7uS1uacVR9T82XGbsM>
X-ME-Received: <xmr:8ntOat9Xgz2LIiS5Prc6_ZrhzjnIxGlX9XzE03zSC5z9AA4xrtPyUMSTQnDFrk8JSgjdQLHqR6ecoXLK1sF5zMdEmUgoxpkj_VdnBu4>
X-ME-Proxy-Cause: dmFkZTGRwtOyrp6uT90haUXnINSUpWW3hZLGhebgzDLUAcyPUMAHJ5qTavIoS69BnEqKJC
    ABVviF2r/3kxjjvdvY/4x2TVlImdMdLJS2ay0c/jWDAm1lYuUi5PwQSscpO9tsdu+WtRcC
    4ThUD9z+bdY02rYKv3dgb5UFtqoO5oyskLLa3juycKeEerrjw+5BSrf1SFF1k0YnGH25M3
    pnnusInZ0D7pDm8lVGxS90EiQ+NS4uC0ZKzCvVLqsshAek0GEZKVa9KeBThhpS1noOVNTY
    yFciyH+tPog0Czxg3DTuBMJ9YrzN2QlEk/oCpZFEPCBcKulUkX5GlU72M8xdi1caNgQlSA
    bFUJtH/j4XLD2YsxpDduo7OFkvb1UVVM83QJIq8xQTP0gY6h+TsOVKoj0AlNlsTzZtlidB
    cfBK9G6+Xe4xeRUn+WMpZeZMlayRe2fe/kIooLGmJAmlecVa1T/BGaP3VGlCr09gDchvwd
    6Sv4jDBtSheNnJoiDSGKRfjWSshTWU4qL4B6cAjBTTM9053z3VWZ5mB7bQbTjK3h60FqTg
    4wRvB/YaySQ9pBV4TDhRJV/lCrfi9MX94KppwsE35l/PzkctU7yi8vziZ+Tkbxd9npJXQP
    GYdWJ29OTE8YN26Mi7jcUtvt7B/hS+6BLZ2cbwDbt0rSr2kcwvEAz4cwGTFw
X-ME-Proxy: <xmx:8ntOavjRkm6Up08mMW5nHPHkePmQpPLzqVLxgTe28jsy-IM5ce6dnA>
    <xmx:8ntOaldsCUsqVodLdMe_41NYco3ptwjiHnp1TubvQwRp9Kzi1SR1MQ>
    <xmx:8ntOauqYIwtyiMEbr_WuVrAqt2eW6mVq2S1_ENMF3Q7W_HGSY6l8SA>
    <xmx:8ntOaiBrLSUZpr3E772K_VVe_AfYYIwxo6khzD96goVyisbu4QK2FQ>
    <xmx:8ntOai_5yuzLQXhe8TcVgR2f2ABZSrZnjdGKJZFwNj09jp3_5Q4ECtb7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 12:33:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Weijie Yuan <wy@wyuan.org>
Cc: Michael Montalbo <mmontalbo@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] SubmittingPatches: abandoning a series
In-Reply-To: <ak3jl3vu_P8eBXa-@wyuan.org> (Weijie Yuan's message of "Wed, 8
	Jul 2026 13:43:51 +0800")
References: <CAC2QwmJ8Z7hZHk9SofRsprvAR3B=UXUkeyy7i4uofRi-xEymow@mail.gmail.com>
	<xmqqechew0ap.fsf@gitster.g> <ak3jl3vu_P8eBXa-@wyuan.org>
Date: Wed, 08 Jul 2026 09:33:52 -0700
Message-ID: <xmqqwlv5v3tb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Weijie Yuan <wy@wyuan.org> writes:

> On Tue, Jul 07, 2026 at 09:52:14PM -0700, Junio C Hamano wrote:
>> Michael Montalbo <mmontalbo@gmail.com> writes:
>> [...]
>> > Finally, maybe a rule of thumb as to how old a topic a topic should get
>> > before a "staleness" update is provided would be helpful, or maybe that
>> > is too contextually dependent / would potentially introduce some
>> > unwanted scheduling contract?
>> >
>> > Overall, I think the explicit guidance is helpful.
>> 
>> I've been working on streamlining my workflow to manage the "What's
>> cooking" report, and writing down guidelines with concrete numbers.
>> 
>>  * When the discussion seems to reach rough consensus that the
>>    latest round looks good for 'next', the topic is immediately
>>    marked as "Will merge to 'next'?" in my draft copy (note: I do
>>    not want to spam the list with "What's cooking" too often, but it
>>    is the document I work from, and it is updated multiple times a
>>    day).
>> 
>>  * After no negative opinions are seen on a topic in "Will merge to
>>    'next'?" state for about 36 hours, the topic is marked as "Will
>>    merge to 'next'".  I will merge such topics during the next
>>    integration cycle (note: I can only have up to two integration
>>    cycles per day due to time constraints).
>> 
>>  * Imagine that a topic was last updated more than 4 weeks ago.  If
>>    there are review comments on the topic that are left unanswered
>>    by the author for more than a week, and if nothing happens in the
>>    discussion thread other than inquiry on the current status, the
>>    topic is marked as "stalled".  I will try to notice and ping a
>>    stalled topic once or twice, but after that I may discard such a
>>    topic (which by the way I really hate having to decide to do so).
>> 
>>  * After a topic is merged to 'next', if nothing negative that needs
>>    fixing is discovered for 7 calendar days, the topic is merged to
>>    'master'.  I may shorten this depending on how complex the topic
>>    is.
>> 
>> There may be more, but these are what I can think of offhand.
>
> Integrating the above parts into the document seems like a good idea.

It could be, but not to the document we are discussing.  The current
document is about contributor's guide, telling them what to do and
how, and "'next' usually holds a topic for 7 days" is not as
interesting.

> btw, do we need to synchronize MyFirstContribution simultaneously?
>
> Quoting Patrick's words [1]:
>
> Overall it's a bit on the annoying side that we have to always make sure
> to update both SubmittingPatches and MyFirstContribution in tandem.
> Makes me wonder whether they are mostly redundant and whether it would
> make sense to eventually merge them.

Surely, but that is outside the scope of this patch.

Thanks.
