Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F973806AF
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782766064; cv=none; b=aXHHQN4yBDl7anLCeyc+pPIrVPm+wRkwOaAv8v2SkAtuudAow1pNAuhyI59LA0UUhrexbQDtXH6vWE/C9HZ/LSWMQNSTXnI9k79yoXQkQfV1uBgWe5OAc8eyFZ88XaEX5s60rT3DhUmoKso1EHBE5IMKc+Lek1p783uxvAND+2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782766064; c=relaxed/simple;
	bh=DlF21BIEOEmdmpWdydL3XY2Zkdr2WUaqs8AwDc78sS8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WqFuYdCJ1D/t73wdK13LMoSbjYxN24mQvl2I/OX6/91v44nSAmLWlErcyVf5h1TwM+fLZiLMnkcb/e/U8nyNkYvNXy+UJ6jKnlyUtq5L0Wx1S/W3m/NfwwQ30KqhOA+IqRAoAnfTx8mByqqugPHLTeVhyM935JulQwLOj8m8IeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TdXgtuCh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ct8U98/L; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TdXgtuCh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ct8U98/L"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D62957A0113;
	Mon, 29 Jun 2026 16:47:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 29 Jun 2026 16:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782766062; x=1782852462; bh=r/fcckbWEq
	BaRW+hN9Wil74drPmprHz0wA4f2DEiN2w=; b=TdXgtuCh96ZRDYWgcZ61IpETz1
	8HpUzXrbU7zk85g9cCsP8zhv99W+/mMtxgJWcfrU4O9nW8OEyFgOoi3Qu5vgIsMB
	yTxqgT5+XvUQpVTHOwrA2DQkY7RKNBI0pSy6NLoVocIrxguOgSUFLiUpaFhCGXNr
	bAvUewJXjfgNzTnOt7JUB9dJ1RlL+WP0wwbnFkRymb54JNXM6RoPSFZYo63eqkpe
	3ikXRpXDdS1RAcI7eLZqu/bThBbVpak9O/xKAV9gIFDbXv3tlMoWjA+w9Czc2/v/
	6i7+mk5n6LDOXcfHMpV6l+j8bb2kOH0SMKD3eailv2rpAXCV4uwPfPo0sOIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782766062; x=1782852462; bh=r/fcckbWEqBaRW+hN9Wil74drPmprHz0wA4
	f2DEiN2w=; b=Ct8U98/L1eOBf7WbBjQserYm5wA4aO+J4S179SSAjYgtHhGJkV4
	/lp+i6Sb/Uq8C0GjGnu8Jqu6PMWn4Sw5aoSB4qcZoR28w+KkQJ1mP/HKFX542prO
	WxtAMm9atXUHVvGyV4OQkvXzWjdzYQxr10YWlWUt+6oRgAkhGhpLdp4N6th84QYM
	Ym5DJGXy29R+Kp0W6ZgejRioXO9NCC68/mNfFjdvRFfGSYiVSx0UcqrSNHI2s3ow
	G9y4LWFCZNpzVIpBIjlfu3gRM/zf2KXv7bdO2penm3mroiET2z5TfIxg3tTPXavO
	83ErOMxOt0/fQK7ysK7CyWe871x9JUhp3Gg==
X-ME-Sender: <xms:7tlCagWo92qORMxLTiXFln6kKuOLw4jxUizfBB7j9sDhBxzQ9b0qTQ>
    <xme:7tlCarnIMap8tbNfK7JTM13k4ccnDbm4O16oglMUdBG4CCtx5jqqTcXla6-pw0nwP
    Nb5bccw9xP6fug35ro-r-V736y0BNP69zC0kzPgL63JYWkzb8c1qX0>
X-ME-Received: <xmr:7tlCapa6_hcdVxDFSZlVKOqDilMDFaGZjND3Wlp1v4s6nigj8XtD5zgls3ZTXul-JU6eYNbFDxIlR9LzwYirMnlDcGEOuxWXTDt6JsE>
X-ME-Proxy-Cause: dmFkZTEDQDDc/Cy8YLgBCJob43Y25Jbi0aHDwd6sxQuEQHc6SjqYNxfV7Fs8wVPZ2h0cBy
    6BVLyy2sFiW5xpuVTBPZDISNANYTzmAZ6i8uJLb3Gidlgi2cOM08Pn8/RqdqHTXFTJehk1
    6whQVTaxVgTqvLJe6cKE5+buRewUGthVRcRilEB/fsQ7bWrwuU/g631lUE6Uh8YLM/f/9R
    bKrludnsQUgJ+CArz4G88o8WB3D0QtAykcc9D1lp1nqCDq3N1oVFy4nc2qK/jW0gHlyfKl
    BCBKIEwWACS5WYLW4FjYnYx3FhP1+G3r4C+xxRPTtpHd1ZlqW2uLs+/h41ltrgJgDY8Wbu
    ke8VNWqKmibjmrD8swL+jG50DA/NB/fh4bgzyOtjJCRlImp4ZMNk/O53Dt3vhc4gPJy1pK
    t1BGLU9sMek8xQb2pkZH+LVnO/X4avQv2n0q8gKEv0Pw16V1HTiJfSZ46pkfSvw7c17Ila
    wHwL9rl1U7cyrpNl0zcGLpSn/MRjX78Q21F0qfKmhyfEvfcel5AsVD3cdIIpsqibzH63b5
    TEb8UeeRMhRI038RxOBXSHqJoX+7g0oR/gtMjg6zIUlfNmh5j1DnjmdHN6OPhiyn5fcrXK
    kfrXhfLOWox+mKqsqM1gW695Zp1Y56/xeBJasjZujS95wVeZaKkRfx1S9pgg
X-ME-Proxy: <xmx:7tlCauNDgAKtiSmin1G_HZN1YgXZLEL2E95EL4_k6XCTCg9dIhwWzw>
    <xmx:7tlCamYPIGovtusPaiZ8ZxDZzIQ7DOAtxO4Oi26E1JwJI6Qj93cUxQ>
    <xmx:7tlCak2AGvKmtxziOoS4tloHMqa6_9A_1jFDFWFhJFqtvL6M0VSPPA>
    <xmx:7tlCakfidHlaCEt0A9RZ4Hmek0mFszT-zU3fxN9249FSujfbhURVKA>
    <xmx:7tlCak64BhqNJuvT8vMk2jCc5em8GoAJ3j8jeNym0iSZaVKR0lT8Z-71>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 16:47:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 3/6] odb: add `source` field to struct object_info_source
In-Reply-To: <akKtc4ybxFRVJmNv@denethor> (Justin Tobler's message of "Mon, 29
	Jun 2026 12:49:08 -0500")
References: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
	<20260624-b4-pks-odb-drop-whence-v1-3-8d1877b790ac@pks.im>
	<akKtc4ybxFRVJmNv@denethor>
Date: Mon, 29 Jun 2026 13:47:41 -0700
Message-ID: <xmqqmrwdul8y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

>> @@ -1424,6 +1424,10 @@ int packed_object_info_with_index_pos(struct odb_source_packed *source UNUSED,
>>  	oi->whence = OI_PACKED;
>>  
>>  	if (oi->sourcep) {
>> +		if (!source)
>> +			BUG("cannot request source without an owning source");
>> +		oi->sourcep->source = &source->base;
>
> And here it is set for the packed backend. Looks good.
>
> Naive question: I understand that some `packed_info_object()` callers
> may not have the `struct odb_source` on hand, but when the `struct
> packed_git` is intially setup, is it not always known the ODB source it
> comes from? It makes me wonder if the ODB source should also be recorded
> when `struct packed_git` is initialized.

As with your reaction to [PATCH 1/6], I do share this puzzlement: if
the source can almost always be NULL, what is it good for and isn't
it something that can be computed from the available information?

Perhaps it is the naming?

I am confused what the above quoted code actually is doing ("if you
have a source, then grab its base and set it to .source member of
the struct the out parameter points at", makes it sound like the out
parameter sourcep should be pointing at a structure with .base
member, not .source member, or perhaps the caller should be passing
&oi->sourcep->source as *base to be assigned to, or something).
