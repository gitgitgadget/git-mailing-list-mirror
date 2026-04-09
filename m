Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880D4311C3E
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775767242; cv=none; b=I1gcHzON6p+37lOPmpSQTDB9axdxX1OP/SUt9c0g+bmHdUFEk01JCWkuFtuvInJw34HU3ARA4RsC5fKG7CBxZtr8eGaq1c+Y4R6NqnVMU8GMzkL9jswK6RxrGrwNdsctzNaXYL2FJE7zzv5xlF2dfll62Nt+ljh3lrWysq3OvXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775767242; c=relaxed/simple;
	bh=vPU25/lwljMd1U9ks9jAd9sqM6/1+KmpododGHFOJEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mwIP1xB3emhyZ+YgpGWfiSSTG1qySrRXgyJC5QmrBgZA9Te93blF4CN5gQg5d6emwf63Gx5nIthWhdIi8l2CKgGJw8JigZ2A+Y8Txw8+V04KXPPNra3G9ZSveMa2zBisdfpMRPfDJuU6SIX7O0n6YB+q9STBBVMcjl7OHnQtw9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ayDRaIi+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dch/ODHy; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ayDRaIi+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dch/ODHy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 435CA1D001C3;
	Thu,  9 Apr 2026 16:40:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 09 Apr 2026 16:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775767239; x=1775853639; bh=J+HTs9jJe1
	d6i4lZH7TWquARHAziinrKseg4Gj4dcmU=; b=ayDRaIi+xeERwfGl4NE58RP3eG
	q6m1bmI5D2R8ssqR1P98NYmnU3/oanP/wa57qBp1Y+69XpPWr5jKz4r6TB3iIgl/
	SjxHo/I3oYQ1vRBOqebHjW8GSng+GWc84xKsRUYxpOypeIL55Xq9chz6NYjybnLu
	vI67JLkGyb3+sJmtbz1nQqCjaxrt2LxnbAE6rVnD+yaZP7sXn13Z98tkWKqVcvkX
	5OPq3MuWHMT37peTevq37sXXN9st5befkMVyx82exeplfWWdu/AgWyEVmMhkxJIV
	6yOAPABV0iPoxUWX+Osf5QCTSP8YhIwskpb10MeFAUIPS176LQH6K6xpJ4nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775767239; x=1775853639; bh=J+HTs9jJe1d6i4lZH7TWquARHAziinrKseg
	4Gj4dcmU=; b=dch/ODHy/O+s9Dr0m7M660bJ2R+4EoDNT9mTelRDf6Z1nKFl/lo
	WjRgs6mSVrfTlF//KduKQ0/xlrYJ9fwrYyneMnCWD7QrdFjUkgqukeFYhon+dT3Z
	0UpWWE/aDJIOivDZC1ozYtWIfDfFe94aF1VbH/Mf1rnzvv4hKg6njPM+wyYTyBKw
	jhkoLnkE66yOo+9qBt/PEtEPMT4ij2ZTiuO3Xit/Ye0IXWKsVbZaeSN3ZtMThKbf
	pOBdEHvOSUVHaGtw8+zPidx9YqA5PvXXLJsilVqXwZ272g3rurau6xnAreckySOR
	h+qBXtgM77O+TuhG9HrpsWvERk4GhcVpdcg==
X-ME-Sender: <xms:xg7YaVGG9XEs-95khWalha_HBLUcvdwrdoB89WeAKgTbdVq-YDRMHQ>
    <xme:xg7YabBkkruMncsHh82UjOcmIwbPMzgPPQ3breqpDANsmn0iBslyb7yRJhoMMBb4s
    vS9BtkWOcBR6oyGNL6FVQHt1OZfmyIDXKKIj6zX4EJD-gUeVplt9Q>
X-ME-Received: <xmr:xg7YaVXTvx09iGAUJ8gNCFEWtZj9mLsLWOxY8lomFUBfr1d2Hxd8zbKd6aldRahbsjfu2aX_Fj-cH_qg-wnDvyJ0nEeUDejsgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjeegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeetgffgvedvheehuedthfeljeevteefleelkeetueefgfekjedvgeefheehvdeg
    udenucffohhmrghinhepohhpvghnghhrohhuphdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurg
    hlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoheprhgrnhgu
    rghllhdrsggvtghkvghrsehnvgigsghrihgughgvrdgtrgdprhgtphhtthhopehphhhilh
    hlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xg7Yafq4NN14tZ86jxgj5TuTw9Te2deAcfxXT6OfqOHFlaM1bWKhSg>
    <xmx:xg7YaRS69VOvJSbPUXcR_6oujVFzfGpwv5qrLKNKlrhTwhfX17iJLg>
    <xmx:xg7YaZ0tp_WyPaHFusDq_HfRU-J6YxfwKu5AUZZnq_H_eTxsBTvOvA>
    <xmx:xg7YadA3cpEnUqcy14ksZCRftA77U_4fdS1LgEOwHmmZxB3O7yOSgA>
    <xmx:xw7YaSur7gWCRlmGZ0uHTPMTxdhqJo7pFXHl1KwGv-b1l0HIBWcfgf5r>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 16:40:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  "Randall S. Becker"
 <randall.becker@nexbridge.ca>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] wrapper: properly handle MAX_IO_SIZE in `write_in_full()`
In-Reply-To: <20260409202329.GA3076846@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 9 Apr 2026 16:23:29 -0400")
References: <20260409-b4-pks-writev-max-io-size-v1-1-81730e8f35df@pks.im>
	<xmqqika0ultp.fsf@gitster.g>
	<20260409202329.GA3076846@coredump.intra.peff.net>
Date: Thu, 09 Apr 2026 13:40:36 -0700
Message-ID: <xmqq5x5zsw8r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Apr 09, 2026 at 09:42:42AM -0700, Junio C Hamano wrote:
>
>> > +	for (i = 0, total_length = 0; i < iovcnt; i++) {
>> > +		if (unsigned_add_overflows(total_length, iov[i].iov_len))
>> > +			break;
>> 
>> We add .iov_len up in this first loop, because we do not want to
>> bust writev(3p)'s limit.
>> 
>> 	EINVAL The sum of the iov_len values in the iov array would
>>               overflow an ssize_t.
>> 
>> cf. https://pubs.opengroup.org/onlinepubs/9799919799/functions/writev.html
>> 
>> As the width of ssize_t in bits can be a lot smaller than size_t,
>> the above "unsigned_add_overflows() triggers way too late for the
>> check to matter, no?
>
> I think it is correct as-is.
>
> The real check against ssize_t is later, when we compare total_length to
> MAX_IO_SIZE (which is clamped to SSIZE_MAX). So this is just making sure
> we do not overflow size_t when counting up the total (and if we do, we
> _know_ we are going to overflow ssize_t, which must be smaller).

But then what happens after it breaks out of the loop?  We cannot be
at i==0, so let's say we have a reasonably small iov[0] and iov[1]
that is so large and makes size_t wraparound.  We break out here,
and then send the iov[0] with writev().  But have we checked if
iov[0] is under MAX_IO_SIZE in that case before calling writev()?

> I think this can be made more clear by counting down allowable bytes
> instead of up. I'll show an example in a second.
>
>> > +	}
>> > +
>> > +	if (i < iovcnt) {
>> > +		/*
>> > +		 * The first entry exceeds MAX_IO_SIZE, so we pass it to
>> > +		 * xwrite, which knows to handle this case.
>> > +		 */
>> > +		if (!i)
>> > +			return xwrite(fd, iov->iov_base, iov->iov_len);
>> 
>> Ben has a similar comment, but it would be easier to see the
>> correspondence if you rephrase the comment perhaps like
>> [...]
>
> Me three. I think this can be made more clear if we bail to xwrite()
> immediately in the loop. So together with the count-down, something
> like:
>
>    ssize_t allowed = MAX_IO_SIZE;
>    int i;
>
>    for (i = 0; i < iovcnt; i++) {
> 	if (iov[i].iov_len > allowed) {
> 		if (!i)
> 			return xwrite(fd, iov->iov_base, iov_len);
> 		break;
> 	}
> 	allowed -= iov[i].iov_len;
>   }
>   return writev(fd, iov, i);

I agree that this is much simpler to follow.
