Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10E525569
	for <git@vger.kernel.org>; Mon,  6 May 2024 16:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014090; cv=none; b=KEZ7lEh8I7MDeRDxeieM3EbUqxVkdCAO6gE7Kgi1pCyrmg6+gt1bI/BKzaAymWIXEG8EO/YF7vdLHmw67iw+bixZAjHrniT0/AxILI+UKx9zdL6thWZGsD3Klm2izjWNvVpzLTcU2RQjdPYWzCRooQOO7QoA9uJBPjGMgNyZTgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014090; c=relaxed/simple;
	bh=PVljsFkyj+BRd0LNfWpLLTtQ56mefNmIJPAKemwQOLU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BI+yoCUekP0FC04E8oGZwcQaHzs9HXFRr2wLxcBzwb2zFI+EfnBNZeTGDcuCA5YclNEcwBJJootzdxr1fA4sqEFrQ5SpqXk+NwTrFc5uSS6NKz9Ate3M8efPQYp7VZSI5fzc70mgDpZUOTLnmY1v2wgG1gkUePs2hUu4FXUymWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=O7i3of/L; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O7i3of/L"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6A0592A30C;
	Mon,  6 May 2024 12:48:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PVljsFkyj+BRd0LNfWpLLTtQ56mefNmIJPAKem
	wQOLU=; b=O7i3of/LK11iovekVwNG/CUg8SKgvCcv/R7yIEEAp9DrzykovqiqhS
	TLtP5D5/tax4PjQWBIIwZdLU4cJEAtm1n4w5nbR2bQL9sr3lK3a3B7DYN5Wg8gkN
	EjVcpUs+YybOTqmAG6cppy7Ao/08gOi6cb7/70aEYOVuOCDWmroCU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 62E632A30B;
	Mon,  6 May 2024 12:48:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D46C42A307;
	Mon,  6 May 2024 12:47:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "James Liu" <james@jamesliu.io>, Karthik Nayak <karthik.188@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] advice: add "all" option to disable all hints
In-Reply-To: <D125SZ21UPI0.166ZOVLTOBCRH@jamesliu.io> (James Liu's message of
	"Mon, 06 May 2024 11:10:04 +1000")
References: <20240430014724.83813-1-james@jamesliu.io>
	<20240503071706.78109-1-james@jamesliu.io>
	<xmqqedai959z.fsf@gitster.g> <D123HB68ZKO0.3C5RSYGQNO9L3@jamesliu.io>
	<D125SZ21UPI0.166ZOVLTOBCRH@jamesliu.io>
Date: Mon, 06 May 2024 09:47:57 -0700
Message-ID: <xmqq1q6e3n0i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6512942A-0BC8-11EF-B6BB-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"James Liu" <james@jamesliu.io> writes:

> On Mon May 6, 2024 at 9:20 AM AEST, James Liu wrote:
>> On Sat May 4, 2024 at 3:25 AM AEST, Junio C Hamano wrote:
>> > > Subject: Re: [PATCH v4 0/3] advice: add "all" option to disable all hints
>> >
>> > Huh?  Do we have "all" option that disable everything?
>>
>> Oops, I think I mistakenly copied the subject from the original cover
>> letter. I don't suppose this warrants a v5, does it?
>>
>> Cheers,
>> James
>
> Ahh, I didn't see Karthik's feedback. Will prepare a new version.

I count two messages from Karthik for v4, one of them being "this
round looks good", to which you said "thanks".

If you mean the other comment about a non-sentence in the proposed
log message of [2/3], the copy I have in 'seen' says this:

    doc: add spacing around paginate options

    Make the documentation page consistent with the usage string printed by
    "git help git" and consistent with the description of "[-v | --version]"
    option.

    Signed-off-by: James Liu <james@jamesliu.io>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

If that looks good enough to both of you, then we can probably
declare victory and mark the topic for 'next'.

Thanks.
