Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A934B2AD00
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784914390; cv=none; b=PbcwrXuzdhIU5S56K+YzmDNKvrqd4gZSq93m4PATze9gsE1cUIrOIxobiCHqit4M7KcS5vh2f21duhQGuTpGglrcAbjmUTqRSlWSacvIVNmYutn8TxA5SoYyAf9YIpo1HpMKOnyY4c5HrIM1cK4m1zH31Bpls0J78ZOT2j/+Xa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784914390; c=relaxed/simple;
	bh=ZHRt5NUzybASGNroyH6/+mqy5nXnflJKeg6YPG2EAos=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IGy4CxwK0uXf5j6tHNN7ycmSSsstbcfAAhDwxpjXN5S+t6KnYn9mOHUE963sy+JpVSMQVZS7uPK6272IcOcwPPEX0vIYqyW8L7PuKW94lC/joZQcz60xAVFDTMdSDcWbBDk8wzIcX1piLTiUiYZ5nF5LAf1y+VZbxedINoz8mOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d3C/FppF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NFOcLm6n; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d3C/FppF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NFOcLm6n"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B64A71D00342;
	Fri, 24 Jul 2026 13:33:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 24 Jul 2026 13:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784914387; x=1785000787; bh=RQjZ7QFApL
	9gbeqFTZljbY7PRR+nu/0/BIjmre0RlEA=; b=d3C/FppF71jr1yVLyzMvn4B5jm
	c7LqP2OBv46wESN5D2J1rx/7DzlpBxPPYTpWtdcUjF2fWKG0RdCDrRmGktuw17q7
	b1FmaerrSmOdj41DuSrPouSolL2/EhMiqH/uMW732DeLJpWjiIlsgbc8a997yg8t
	ZOAL1SU2H0DyqGmHAiLMo8MsBpMw91V99buzXBIZL4sRAMpJ4wIM8y31uyWiTV+E
	fZMJ8cCOIF0MxtQjEfPSVql7q6PwiJfMC0WvuH69b0My2f1DhU/PvjVb0AytiK8U
	YvGXjXDPDWp87m1JZluLc5lqkX684az3zfjfEWsxYdCL7UMcqw8/uwCw2FnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784914387; x=1785000787; bh=RQjZ7QFApL9gbeqFTZljbY7PRR+nu/0/BIj
	mre0RlEA=; b=NFOcLm6n4rvR36jgTQQgJCbC4QTGGC2qj0Ab0Nc/iLJ1VhV+fPc
	SxafoNO9vWQeuLAoT9u0tChP895MTqVdf1oQw7wLMxk6J5P6SZ6soLVABVQW3Ljv
	Dx2vd6qL7Yw0AjXrzDVmE1HXdtYHgLHefVRwen+oWFJCe6n+TXkCYJc2vBggW3ZE
	+0py7jdkXJVmusOl7BWG6YQnD5ynrSFiRSlxk+llLUPHYfj3tVzej8AjHw3pLVFP
	k1MzyAoDZjhIz3wsXN/9DjAZ2rtDC4MgFPavOo9ctX0RwILJUVGu6fW1ykCSbc92
	RzMnQy1NdjZ5QqckcEpc19aOQ2i7bV8ADDw==
X-ME-Sender: <xms:06Fjai-Fuwg23iRYa9Ep58ySx5gOKEm57m7QiPY7dHYx9jr-lZbFsw>
    <xme:06FjapnVANYo3vCCNHSPDKmEYjifdq2S5FC3WZKCwKCLIG2uq0GPveVVE5EthgYyU
    KYC0hvB-7GsybPM-7wpVhUJkz4x1-9cJcZR4ixfhnNTtpxY1LwnMw>
X-ME-Received: <xmr:06FjagX7YBiwhnta1dGsRs7xlgu1O80O7LYqujKcfLWzNtfvbsMprHNKIBdepFitCOYQ3bHpJAY8haPBQpVyW4GbyTT95wxz1g>
X-ME-Proxy-Cause: dmFkZTEurNHKMZr4SsBRkfSf4h2rII9vNgvkPI73pJJ5TekKCxRDSyHfSLq4aIjpPeq1eX
    gY5WgDqfmyTEJ2Tq7MljkbOQ/9fkX+qzLwdcOLyaPLqjoc3iv3NF88rhk2Wx5gLEezPO5h
    VQ4CEE7A8gN/rM09f6/UZI7ADF1bB6ylHkUOYgvJpzHtPMj/9kfZ9aaLnMuZGsosgx957j
    BVvfMbXsksjkVDvgtEt6NwedIs8FSTw6Pa1FpPB7yQXKkcPB25iwpH7AKihhDffYGDliG9
    cS8i/We7tcBv0f3lgGy3I3cWcHJW7K/04FVCbOmyMb7XPdVUmEAVOLnC34rb1zxvMtsnmm
    POI3It83oalzt0kXzPDjHUOHEbIgwbf1NlVfEe4GeaJhNmu2lyh29CIMFqIFXM1zh8tMu5
    pBRoeyLqikk1pS8sS24+KcUhiAhlKxl3H9Trdbh/htJ1M9qCow5iWF45dDaFEnQOLxzDrf
    1etFZWshkLsCXsSBdhsKISXuVlqT6GttQRTu4tK5Yq/mkkXCGx+HIjwZBeX3OT2bmdLOGy
    5rnseizUMEAxvBQbmagxmTrkIVApFy1t8gSoQKzPc4qUtzPer4fXsGPzFFN0ezDhEra0eO
    caLcflKlguu6RoNbtadAUhGVl9tQIRt3X3aNsN+ySFgfoThXdrQ8uo61GMng
X-ME-Proxy: <xmx:06FjamGJDse3zEyzeFQ16AMKd3vqv66jdi2FNa1eSiFg9UhucKKLnA>
    <xmx:06FjakdhH8l7P7h2dgjFSwpjeFnMIqjjYEG6Zv89LWa-dsZ2-JYpYA>
    <xmx:06FjavKOMhfUkLYPsnDSymEWSZJOzUJWkSHWCEhumJZ852D6sKl1Cw>
    <xmx:06FjahGRRUblB1i0XCoVzDn9XVhFiZXyo5WAH1NvyNKNgCMiwRC-Uw>
    <xmx:06FjasZVPtmfiXDKdWUlLukWFOtvtbodkduj8ml4t4TLdCXcW5A6IZ8H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 13:33:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: tnyman@openai.com,  git@vger.kernel.org,  haraldnordgren@gmail.com
Subject: Re: [PATCH] branch: avoid slow strvec Coccinelle matching
In-Reply-To: <xmqqbjbw8icj.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	24 Jul 2026 09:26:04 -0700")
References: <20260724091152.27794-2-tnyman@openai.com>
	<20260724114948.GA825505@coredump.intra.peff.net>
	<xmqqpl0c8jml.fsf@gitster.g> <xmqqbjbw8icj.fsf@gitster.g>
Date: Fri, 24 Jul 2026 10:33:05 -0700
Message-ID: <xmqqse5870oe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> Ah, very good eyes.  It is a disease to try appeasing -Wsign-compare
>> without thinking, instead of questioning the value of the warning
>> first, and in this case there is no reason to try forcing the use of
>> size_t, even with the unnecessary casting.
>
> Having said that, another fix might be to standardize the way we
> count the number of things in an array and update 'ref-filter.h' to
> use size_t in 'struct ref_array' as well.
>
> It is not as though 2 billion refs are too few to satisfy our
> needs, and in general, the platform-natural int should be used to
> count things unless there is a compelling reason to deviate from
> that norm.  However, "somehow we ended up counting many things in
> size_t, so it is better to count everything using the same type"
> could serve as "the compelling reason" to make such a change.

Let's not allow too much latitude to ourselves, as that would only
confuse us.

Here is what I recommend that we do.  In the short term, i.e.,
within the context of the topic in question, let's use 'int' to
match the type used to count the members of an array embedded in
'struct ref_array'.

But let's leave a '#leftoverbits' note here in the mailing list
archive to remind us to revisit the idea of consistently using
'size_t' to count things when things are quiet.  This is not the
time to needlessly disrupt the 'hn/branch-delete-merged' topic, I
think.
