Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CA5385D97
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 18:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790791448; cv=none; b=YD7kUAY8b7WLCITZf9rfqOsI4wZ0xMVoPOJA3r2S0CHMf7md4xksaxaYZPE/YTzzIOnXY7G+4FVyTVR4H2BOqhPxwlnekG/V3FCcyPFHFUdMOZv9B/e8uVO1Hi/tnAQd7cf6Rk/ul2GmlMRer0a+Pqf6eKi29FxFZH8YKL3oqvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790791448; c=relaxed/simple;
	bh=sSr8m8NNlz/nKDKC7RJQgLCuqrbKz2T/Jd+xpIni6bc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E4QkfhhErtXO9tofgV43YiGq19IkT239qAti9p2u2jBNfoGde5KFmVRFEUE8KB2iUCsszbHxzXoBRwOVarO29OWgx/06Ephw7wXBPcU3u8GwOoaQl5/Gf/0l0kdodI1+M2+A+bNKnWYVoQO7kZ66FYpMIv4I6qr5NjihOYDuibc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b3qQkTv9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZvDTGAf5; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b3qQkTv9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZvDTGAf5"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7D48D14001ED;
	Wed, 30 Sep 2026 14:04:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 30 Sep 2026 14:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790791446;
	 x=1790877846; bh=kkYUBkQf13W4pMdWMBEeA7RbzcO73jbU8Rw9myuIoBE=; b=
	b3qQkTv9tP6qfhblX0F6KEKdFBPnX13k7MVtD2Mh7tb8O++15MCO/1cJS044TExi
	iN48ZALycIVKjv4r6dP/3oskNm0zSoMNqjrsMmA7nMMwgLmO70Z9n1n862aL0Dp1
	NeB5ElLhxxhzJLLxqCxpJOAR7FBAD3wXu8+d8BgqbPxr1zfFepS/VBp+0Pz3Cngm
	an5V/y3mexHek8yNBoie9q5EcpQmljFLdJBcl8m+Q9oKJb9w1R5Gp7RGoF2ACphV
	vcqBOiWMLvvoIJ/t5SIpTcQrJq0B53f0+RYN5VZXZpf0yd7t3oyVZD8VN6rkZUx0
	7F3Q7JTQQ18lBWIWnPyTew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790791446; x=
	1790877846; bh=kkYUBkQf13W4pMdWMBEeA7RbzcO73jbU8Rw9myuIoBE=; b=Z
	vDTGAf5qoz3TKYkQIEui0Kkg56bw3+SeyPLBoAvSX/YzuT4Mm3cHwL7H4h3DAM9W
	LbJoyM+MYIzNsgStKQ+b4q7ngLVprF6ycuuBWGPnfRDfBg0L3WJS/DkCUsr/nhb1
	BapiElnXGDbrMGJZTK+CYADaz7qt+XZBLKrMM9gwBgAI8se+xRKc/BFrlr2IgupD
	4oQ8gLhtdWflJFsV6lWvmrZMLvBSZ4Gwx6XbqAfunmMHZoOZ2KWk0mNp5y1ndFfF
	dJTWtIbbk+iAhasipVZBsXDZPjSm5ilox6AQEERxLURxzDGNHQprR+naNL0jPt6k
	7twyMaDWEOPMzRP5tWMNw==
X-ME-Sender: <xms:Fk-9aqrS9YhelQkV9GHe_wG_7ppfXm7DAAd1UWsLtBeyLTwBRfOsEw>
    <xme:Fk-9avhU1Oe47XqFrqMbyv5bIGajhRFOf7oTDDDQ2K4ZgDuD1KyxFQ8l25mKCMAIq
    wgAJFpfCEXIC6d7WL9itw-kN2ydz3SOMN3j8lNWGfmIoRNIv7Oub4I>
X-ME-Received: <xmr:Fk-9aniQcYEuZTC-oK0FkLo4L9PPs3z92wV1YE57mwxBQS12pAEm_n5vgX2q3woyYaWB_RamrF6ajXDylhCqSOhT-eFtrqxQ4lxI>
X-ME-Proxy-Cause: dmFkZTGVRHdempr4IA6WPPD3E/EZ549UBQua8SjIKUy2VHwXumdVDLiDkw3bfUpRqpTC2X
    SaK9JsCcdj9WGwe6DKIu2oW2CGwWxmOFrBEFlOSM0girbBg1ilr1MnMYeNCsRPuNRLLI/9
    71HgKp69xLylPXW/ZZlkTTSeconTWv54+SOxnvpyJs8JYirk7scZFXREV2Vp4AT9yFoi5v
    bnMCZ2Q7w+NStGr6jqr9hCo/i4ystBxvGa/vMElV3sXmTL1V5dAfNClaY8BE1RAnrxI02t
    iSEt7ki1U8TOTAITdb7yZ9q+NLQKI5aHpXES/2xHWk4w8e6CdHZVysMWZoULTMmlYCNIDE
    kIwT14TfatZ7Zt561OKSr64phE22lTJrQFsm0cYLgZxZ7Lif0DSs0mpDpUdkMdMmxf7L0Z
    /GMQllEsajJ8uECc0BsMfD3q42HA3+T6aQrrkahBOgWp/fPoF0Em3L+xJsvcUjq5HIwlWA
    JNl2IBr1CBYeeIvMSYKMp+kRSmAU6Iae1gI5+1T6JSUpSAVrDp2sBUPAYrB8YIF32LwKxb
    oBVz6tN0ErjtHqZtdAaCmXWP95t28HZUVJgLVduDrY3j9NdreBlFUKpnL+74y0qi7hW7Id
    /i138SHSnEhugg2//8PsQOKmqzCe7r3uI15YGlBJ9nXC0n4CqzYZbuMJtvSg
X-ME-Proxy: <xmx:Fk-9alh9Z-kzRgp6xYBrxzJi7tmd7R_WuVqhiXdpWzhEFPzrQAcaIQ>
    <xmx:Fk-9anIr423zuYeRIyi0H_wI6OfbMGK7i_El2aqtqYrRebYW3Vm6eA>
    <xmx:Fk-9akFF1s-ywuiKO_U5wLGMHrLrHbaxp5jCq08oDlQhuYcjXUIWgA>
    <xmx:Fk-9arQqmYywtcQ0fuBz-WzPpwoextxVd4E_a23su3LqOrzEV5gqBQ>
    <xmx:Fk-9amDo3_UbRKE_PbhFNFWMFuV2MyZkydf2cRSgkhWNsUcJtn642jrs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 14:04:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v3 0/2] ci: use cmp and align job-count selection
In-Reply-To: <CAJ-ks9kYC3NM7BY=gYKxVL54nOkH4wp9TdAJye_8ifNPa7oVdg@mail.gmail.com>
	(Tamir Duberstein's message of "Wed, 30 Sep 2026 10:58:22 -0400")
References: <20260925-ci-large-test-resources-v2-0-f632cf319756@gmail.com>
	<20260930-ci-large-test-resources-v3-0-d65ac7c21b5f@gmail.com>
	<ar0gon2VE0RlG_cC@pks.im>
	<CAJ-ks9kYC3NM7BY=gYKxVL54nOkH4wp9TdAJye_8ifNPa7oVdg@mail.gmail.com>
Date: Wed, 30 Sep 2026 11:04:04 -0700
Message-ID: <xmqq4if6boq3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Tamir Duberstein <tamird@gmail.com> writes:

> On Wed, Sep 30, 2026 at 10:45 AM Patrick Steinhardt <ps@pks.im> wrote:
>>
>> On Wed, Sep 30, 2026 at 10:20:33AM -0400, Tamir Duberstein wrote:
>> > Changes in v3:
>> > - Use twice the CPU count on both providers, instead of adopting
>> >   GitLab's existing one-job-per-CPU policy.
>> > - Include CI timings and their tradeoffs in patch 2's commit message,
>> >   and explain the use of sysctl directly.
>> > - Patch 1 is unchanged.
>> > - Link to v2: https://patch.msgid.link/20260925-ci-large-test-resources-v2-0-f632cf319756@gmail.com
>>
>> Thanks, I'm happy with this version.
>>
>> Patrick
>
> Thanks for the reviews!

Thanks for writing and reviewing these patches, both of you.

Let me mark it for 'next'.
