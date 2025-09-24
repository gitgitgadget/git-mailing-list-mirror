Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA1D231830
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737073; cv=none; b=XAnm1MB2UCeC5dNty9hhf1zDmAXEajwbwnR0nrY5Ie6YRzC+e3SvaXFH85l5AZYlVaXFDKQxSCprIJUeS19Ey3zGlf/KaH8NocnaOn1JjHQjQ75ZBWsgFgWz3jmnl9nbAgGd8AhMT/xKmHGsETfylrBgxQHXekkBTrNL+GJj4e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737073; c=relaxed/simple;
	bh=Emtj4iFBYMXJq0rOOX2mZJU7PsG/LtNgdvS1A6u5E28=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RheMb6zi8vuXXihzqR6SZh4MnFTFDIfQ+/DZezRAc3BiqMI1VJkoiGGM24DCxopfw6YEjwPp2wRTKum6+YHIsqIZA18SDxTlh6UsftpMWmPlV0jn2EEhr7KpsPkKEDGFUV0nrwS5Siia64R7SmdyTzvyotFUbYWhW9ODpshV5w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JnA3DPxO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NEipkQIW; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JnA3DPxO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NEipkQIW"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6E8DA14000B7;
	Wed, 24 Sep 2025 14:04:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 24 Sep 2025 14:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758737070; x=1758823470; bh=wxikZMqumR
	Ty3VuqTfgEWzqEcAOhFxGZ6OiHMl5t9X0=; b=JnA3DPxOneaLP888vSTxRtjGO5
	YCzwuNhZ4/mAbttAH40+h4sECAC8u76TiDO8Y9uMjAa2UPRiTa/2iwfVmJAC1Tlf
	7yjm2x+82M3u1VGRoF1pXNcb5ScJhp3uS7+5sQixZeego/ygf+BRpYBItXAUiDcW
	TAivkBKc9KWOhS0WE76crj60NhSEYDdc0kTzs28+UYdsNOXT0VfQyKmwcjyRzK+j
	4S9zSvuuDQYPN1dPETY6haS+kQD4dmMZG8W0Z+6wZ7kN/F9lB9CynOFyo2n0EhRF
	GHSEbBbdEnDjvTByVMMi8mBmNoX2hIm+tvVbs/QSpenUAacUT+YGZjsytEJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758737070; x=1758823470; bh=wxikZMqumRTy3VuqTfgEWzqEcAOhFxGZ6Oi
	HMl5t9X0=; b=NEipkQIWiysuGYz+RSXqFtu0fno0duiv9tMWDPgR5e7pT05UB1r
	JQapwzq37fdWnt5VV+oUzf2hQnIpSKY+/C72jm3q3lJrVaSGLz5DzwFGA7HxbmN0
	Hu6T0Xu3g5R42Y23fTS9DmIPyrWGdKZwoCLCbwqCCjJm8QMC0wptzHpcgkCm+I2z
	l1AvcC8BD5KnDquCB71AUyTKTn7z/7k0sTRqhSET9cJOb5YMX8wKvX46ry/wBnK1
	3XSCVPdq8qPBwGLSHiyS9A+BK8BeaQYU+E33Mut6jyzH84XyHM8E51P4wCvGp5JM
	uj/zgQ//GWz844Na277EfRAMpf1IflRdkyw==
X-ME-Sender: <xms:rjLUaNhQU9bmoe7LahTfZsSyrhMTjIA-zOcYglioxdC7Hn7n_nyC3Q>
    <xme:rjLUaI5iaA6nkNhHM4d_zgzRJYmdes_jdUfNgbl7PG6NnKXkHTL99GnZ0Jv8DaOnf
    8MGgsjpR9uq5WHMGaRGiT4ze3ou39yw6Mf6wj1d9DMqds8rT_7QCg>
X-ME-Received: <xmr:rjLUaFYd-IwTShACB_0ZFBxLoE9De6D4-FccwAfBcKiWjzMKQTleTs-05Qidp2jawqVA_ynzT8Ti7XtLsU4RhX4k5kIJfXnnlknn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rjLUaN7r6BTISmMxwZfgKquK2Ogwa5Rdk-jBVAxB8zPIHEuGXgH5gg>
    <xmx:rjLUaICe01SZOkLY0O4OX-QvhylTeTxr6Fy0NpC6lPErJp11f_0Mqg>
    <xmx:rjLUaDfWfWAtrAKdlAHzm4nXDAk6HHSZgTJgfEsT334kMaP_vezO6Q>
    <xmx:rjLUaHLn9qZrVXudT-mGraqzGrJr0lV2o_aMKT4JOOJFcCf54MAImA>
    <xmx:rjLUaJKPU2H1CBxssvQVH2Qm97ZZFLhIFpNO0dg6lCykHvSd_zLnGB9G>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 14:04:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  shejialuo@gmail.com
Subject: Re: [PATCH v3 4/8] reftable: ensure tables in a stack use
 sequential update indices
In-Reply-To: <CAOLa=ZTf7KL23+=Fggfg=4LXt1Dsd6nRCFg3q_Dhuom2Bk+L7A@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 24 Sep 2025 04:20:07 -0700")
References: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
	<20250918-228-reftable-introduce-consistency-checks-v3-4-271af03eb34d@gmail.com>
	<aNOHl65jYyoNXou_@pks.im>
	<CAOLa=ZTf7KL23+=Fggfg=4LXt1Dsd6nRCFg3q_Dhuom2Bk+L7A@mail.gmail.com>
Date: Wed, 24 Sep 2025 11:04:28 -0700
Message-ID: <xmqqikh7lob7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> On Thu, Sep 18, 2025 at 10:11:45AM +0200, Karthik Nayak wrote:
>>> diff --git a/reftable/stack.c b/reftable/stack.c
>>> index 955be1edb6..a458f5a4c5 100644
>>> --- a/reftable/stack.c
>>> +++ b/reftable/stack.c
>>> @@ -317,6 +318,14 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
>>>
>>>  		new_tables[new_tables_len] = table;
>>>  		new_tables_len++;
>>> +
>>> +		/* table's update indices must be sequential */
>>
>> Let's make this a full sentence starting with an upper-case letter and a
>> period.
>>
>>> +		if (prev_table && (prev_table->max_update_index != table->min_update_index - 1)) {
>>
>> I wonder whether this check is too strict. It _must_ be true that the
>> new table's minimum update index is greater than the previous table's
>> maximum update index. But in theory, there is no reason why there cannot
>> be a gap between those.
>>
>> The reason why this makes me a bit uneasy is stack compaction. Say we
>> have three different tables:
>>
>>   - A base table with record r1 with update index 1.
>>   - A second table with record r2 with update index 2.
>>   - A third table with a deletion record d(r2) and a new record r3 with
>>     update index 3.
>>
>> Now if we compact the second and the third table, the compaction will
>> realize that r2 is deleted and thus no longer needs to be part of the
>> compacted table. So the new state is:
>>
>>   - A base table with record r1 and update index r1.
>>   - The compacted table with record r3 with update index 3.
> ...
> However, I think your point  holds. I do think eventually we could
> optimize this to ensure that we do something like you described.
>
> I will make changes accordingly.

If you allow gaps in the indices, it is a bit confusing to call them
"sequential"; "monotonically increasing" is less confusing and it
conveys the author's intention to allow gaps clear (otherwise the
author wouldn't be using such an awkward two-word phrase instead of
"sequencial").



