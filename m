Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FEF1D5CC7
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119669; cv=none; b=qxzUyhbnhW/J+0xacdn3OwgWoV6KTN7OgC6jeuCNWkaUhkTnDlWun6PtLVvwXcn61638iz8uxvW0I+XUTOsRVZ8YnLb4BeK4mngzP5zKXtbXSgHdI1EayPZ9eaLIb2BtET57tN7KbPzFHSOl3lgkWQWpiO+nC1kHx0B1rjqy060=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119669; c=relaxed/simple;
	bh=Km/5EffPFnsm68F6GR6INQ4CNPlqh8jGBhqCKiLFCsQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=grq9ynRPoos2egepCZzRqZeUoJKhjWvQ08URVnqL1zuYACG8dO0GZXMsSUcYceYibFEoShO1Dl+ZWKXQtNVuq40rn+fC18BsK7Qo5MTOasi8+/92E5A5GOdnAFQONeuXo4jlRitA7zQy04lTAw2nbqdq1HfldZxv3n/fvt5KLAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GlprZRg2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=humG7FeT; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GlprZRg2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="humG7FeT"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 81F8214000B5;
	Wed, 17 Sep 2025 10:34:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 17 Sep 2025 10:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758119665; x=1758206065; bh=yNDaOIbKSN
	61ytV14w9hpxacZZSahVVcG4hukjApJSQ=; b=GlprZRg2NwyY23MO1Amo7pd4EE
	1mjqrFr0c0tIKrcfiiEp+7ZiHMDKuTVaKbpTdMgKszvbrRlLlgZvNHlMKIu+/4J4
	d3L7It1KJaUtwrsZ4v571L/bqGzabS7Nn3mTmlUaHAzJ5WsHWuOwqcmRX9mcu4M3
	UmUXiD0sQIyVad33jD3Iqisn0L16iX+7FAp4KRsyqlsAc7xVfVRY9Nu6FWK8v3FX
	MmsyJx+lrbSmZy2r+MMjztsmQm4ofB5U5Z/yOoLoKULm8ofOBvpL72qNntq2mSq4
	n0HZGSjhH1j7b1aVqKQwYRzkm+DH212t6lCrxYpMEW9hwUT579M0zNABPsXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758119665; x=1758206065; bh=yNDaOIbKSN61ytV14w9hpxacZZSahVVcG4h
	ukjApJSQ=; b=humG7FeTrStpih3Dm/EFBX4dEpsmSo3owV9MV3zgrZSe8abNG50
	dPa21GHsFJFOGd2VSnoIrKpux/WEfIpy/4ns2d0B5QIE8lz+FUvRSVy7wcdJW0KS
	M4vMO7CxmLXXk9qlavEPtt47Ni+lOPaSSXOyFS83O+WkDNe+XbQyUMvyZrJ1aZbi
	CRDSzp7UvQYJSz45QzhZ+8Q8BSzX7/ZHJ6QC4DDRv7SaOVECCECO2rd+swb0BVkX
	90FfY+wCQkSuL/uvMeTtcnyJxH1lKMaG3NtTmSF2+uQP3+i1Hn57bBx9+8iWEZSL
	vMli+MXsHKg75dWCAMhzhR3zBA5cIcvtElQ==
X-ME-Sender: <xms:8cbKaDT9o2FEY1znDzwsCi1dyX6TyV_2rM3-n1K3kEI8Li0dbwjmLQ>
    <xme:8cbKaNPhArVHu97jGqaZPTtFLIzqsx38sTRjGEjXSqk40cNgrMV-ODWRzfVhPg_ta
    FYdGnWLxwqq-T0MFw>
X-ME-Received: <xmr:8cbKaJQoj7VtyRBBjceUwGl-Mbrlx4A7DksByjQEIJZ7-G83YlV40sF5c0ZG0a7FwlQ9U2Kg8tU4HTnJGn2O_uhlCP05aUIuV11Z1PQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovgdrughrvgifsehinhguvgigvgigtg
    hhrghnghgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:8cbKaDgOTxMHmWY_G_i2EEiyFkxRoxAOM7x6R0pOjmnSRLZsZCAdtQ>
    <xmx:8cbKaK98P3rW9Q5gmng2pHgvdX1iKSR9q8bd7ubOqnkF_b56Ub3Z_g>
    <xmx:8cbKaCHHadha0f8VT_0zs5JSg0tbSt_-TNTVmJeN9uy_nD6h-M43tg>
    <xmx:8cbKaFlzK13zPfhBGHvhhP-zjRx9N9O-PVY2LXbpAg7kqp6_NgF_Yg>
    <xmx:8cbKaLO_pXoQwX0bKzY7MACawjZafLoo6DOoy9G31t6P0lFBtARttWDq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 10:34:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  joe.drew@indexexchange.com,  peff@peff.net,
  ps@pks.im
Subject: Re: [PATCH v3 0/4] refs/files: fix issues with git-fetch on
 case-insensitive FS
In-Reply-To: <CAOLa=ZRvAMq7MNm6=dBneAXdDe6OjQ=NqYA9-Vd7E+nvDWGH0w@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 17 Sep 2025 03:45:39 -0400")
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
	<20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
	<xmqqh5x2m5d3.fsf@gitster.g>
	<CAOLa=ZRvAMq7MNm6=dBneAXdDe6OjQ=NqYA9-Vd7E+nvDWGH0w@mail.gmail.com>
Date: Wed, 17 Sep 2025 07:34:23 -0700
Message-ID: <xmqq5xdhgnbk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> Changes in v3:
>>> - Rename duplicate_reference_case_cmp() to
>>>   transaction_has_case_conflicting_update() and add comments.
>>> - Improve commit messages.
>>> - Add an additional test in the 4th commit to showcase D/F conflicts in
>>>   case-sensistive file systems.
>>> - Link to v2: https://lore.kernel.org/r/20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-0-b2eb2459befb@gmail.com
>>
>> I think I like this "latest first and then historical" order in the
>> cover letter much better than the other way around.
>>
>> I see that this topic is pretty much done?  There still are a few
>> questions from Justin's reply that may want to be answered, but I
>> have a feeling that the answer to them would not require a new
>> iteration.
>>
>> Looking good.  Thanks.
>
> I did respond to Justin, I think there were a few small nits around
> grammar in the commit messages and a question around error reporting.

Well, if it is already locally ready, let's have a quick "small and
final" update before merging it to 'next'.

Thanks.
