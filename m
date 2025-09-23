Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E6178F39
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 18:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758653322; cv=none; b=Ph05FRI/lAY2KP8bJyHpLbVhx9V7rpLRtOvj6DCRLpmpJj56gspP9kZJpmo26iOD9HjbfTFY5oC4TdORAe9HFkxykmNunA7HE0KNeTmoK+zkFKTj8DdJTZx9PBAEY8IeVLZovQUAK+y7Hdh6rizDTkW1/bG96SzNAKICZRPcGhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758653322; c=relaxed/simple;
	bh=B+NBlNCcpsus9ndTx/DdW8BZf+2VWUjOmMvq1TA+R+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RmVPkMtTNjxbUkhTl+iDrTjJZfNpMOGopqDPzrtdwcYJTgi72b+FPb1rHt61QNf9IsJ1ofaxHqZ9Nr9DpdElZNafo5mr60I2jFQcKhv62HpKm4SjhdH3WPKss8DzrPZynJ0jFo3QbaFRyAzoHY3Umfrr3M6aS9Htr+I1Dogsr90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=McmXKcgR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MAjO3MIx; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="McmXKcgR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MAjO3MIx"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8DA231400113;
	Tue, 23 Sep 2025 14:48:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 23 Sep 2025 14:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758653318; x=1758739718; bh=1M2+1QN3Ng
	jrNZWMoOw1RwE446ozOX0FEMeHXMl3z9U=; b=McmXKcgRhzm0pomZtarIMxh1hU
	YhRsCr9B/YVOs9XiSFVqfOUaddKMUSV9DcODQ9RXJhWJeVnF7QZS2/bshZ7VN6GW
	p06OxC1y9drkLFAQ2fgeek9RjOnLeNicgn3SosvXHJ9SRWv4Oor+wi+6rLHHyr/r
	rcvfh5QrHQPwtqOz0lriKhlsPx+H0CCFeluDxe0gKs0nxBuKVrOxT5voE/liLOoX
	iSl+oMRumFnZi94nZP8pWuG0/S/9otz1TPPDrxB2g+oZEoiuy0VrKIvrgJMOUjF/
	2CucgJD4vtGuUVNu24xh6cY0eT7iuYHmbMazXSUT2nqPxmJ4bnMcYBeBQu0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758653318; x=1758739718; bh=1M2+1QN3NgjrNZWMoOw1RwE446ozOX0FEMe
	HXMl3z9U=; b=MAjO3MIx4WXEZkaxOohiJk91wzlqasH4pSJl2svWjbjfiArpMs+
	70jup9BfIkFD0M+6pK0WEhhQV0FoqlXMsj/30YSauma/1bXpz76U9j205uOYPKdO
	2WurxIgdkPNKTOvvjQVOGw7fYa4R1Z1K3m66EgqH0JA4G1utsvuFW/L2jEsBhZBu
	DUzLUNLgh3GLJdKmGo3a8YAGU9s2a11UC1zLWl6n629gx8vBucv2Q5Xila0JJiDa
	jXjGFABL7HMXHii0nVJ7BAVkOY0+ImlLu89BWTyhNTh58nQhn9sno9fcdr9qXMnL
	SARBz7cMe0T91uUT3KT1grOBQIDlroCWaRw==
X-ME-Sender: <xms:huvSaKoQ2bC-vIsJBvFMXFyFhV4UbQjJHYcOW9GRfyBNny8_M2l_6g>
    <xme:huvSaPi6STVr72k1erWyJEkl6Yi6q-liRF2Ie9iddk36zS-98xblfpPfuUp5qzr3q
    EKVbEoaWeGkemN4bTamOYqaZKgIskTxZjuTj3JIYV0CZ-YQnhcfYA>
X-ME-Received: <xmr:huvSaHj-Ef4gPu-ECrVP4MCejfJgKv0iEbMjOfZ_TZBlVWTvtjf8PJwj3y09mqY1NcWY7QomB02Eh6OkinS8vXnLynr_g2gRZwBq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhho
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:huvSaFhTioST2Y-VmYhoIVULcrahoXPVZKYvIu5kvYPOCcjaODtEKw>
    <xmx:huvSaHJJ_A-H12Co8ZDdXogzvmQwUph6oulBtay8JH3uGbasb5t9Hg>
    <xmx:huvSaEELfA2X-bxN0i83iG7WL4er5kwTFdGwtmL_AWwXwsWswz22YQ>
    <xmx:huvSaLR4EkT9mYylPpoqZq53bM5vpTOn_8kXThYTgDo7nEpS-40ezQ>
    <xmx:huvSaIxTOVrQDwEHEAd3GPzz3lid6ZvuO4Yi89yLJuaCah0RtaBocZ1a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 14:48:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/4] string-list: replace negative index encoding
 with "exact_match" parameter
In-Reply-To: <CAOLa=ZShms1D-cq=x04dtT2ULTVE3ZDo8DODFnJRP2wcJz0EgQ@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 23 Sep 2025 05:35:39 -0400")
References: <aMp8yNFiXDyk2hP4@ArchLinux> <aMp9OtXLfRw7dEwA@ArchLinux>
	<CAOLa=ZShms1D-cq=x04dtT2ULTVE3ZDo8DODFnJRP2wcJz0EgQ@mail.gmail.com>
Date: Tue, 23 Sep 2025 11:48:36 -0700
Message-ID: <xmqq348dovi3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> shejialuo <shejialuo@gmail.com> writes:
>
>> We would return negative index to indicate exact match by converting the
>> original positive index to be "-1 - index" in
>> "string_list_find_insert_index", which requires callers to decode this
>> information. This approach has several limitations:
>>
>
> Nit: It would be nice to start by explaining what
> "string_list_find_insert_index" does and then talking about the negative
> index. Perhaps something like:
>
>   The `string_list_find_insert_index()` function is used to determine
>   the correct insertion index for a new string within the string list.
>   The function also doubles up to convey if the string is already
>   existing in the list, this is done by returning a negative index
>   "-1 -index". Users are expected to decode this information.

Yeah, such an introductory statement would help those who are not
familiar with the convention.  Thanks for suggesting it.

>> 1. It prevents us from using the full range of size_t, which is
>>    necessary for large string list.

It is a disease to think that countable things must be counted in
size_t and it needs to be somehow cured.

It is a type to count the size of memory allocations, nothing more.
If you are holding 1000-bytes per the stuff you are counting, you
would not need the full range of size_t --- you'll ran out your
memory way before you fill size_t with the things you are counting.

When there is no external constraints (like you need to specify
exact size to describe a file format to be interoperable), the most
appropriate type to count things in is a platform natural "int".
You wouldn't be handling billions of strings in string-list anyway
(and that is smaller than half of 32-bit size_t; 64-bit size_t is
much larger).

>> 2. Using int for indices while other parts of the codebase use size_t
>>    creates signed comparison warnings when these values are compared.

The other thing may be (mis)using size_t when it should not be.  If
they were also using "int" that would also squelch the warnings from
"-Wsign-compare".

For an amusing read:

  https://lore.kernel.org/lkml/CAHk-=wg+_6eQnLWm-kihFxJo1_EmyLSGruKVGzuRUwACE=osrA@mail.gmail.com/
