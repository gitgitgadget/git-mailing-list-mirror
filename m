Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB181C4A0E
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 22:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737583992; cv=none; b=dYi4cyLdV4NHxZTDmbivQLwVYsSlpvLXQYLftutzxIPLaMGdzbKx+JhFPna34NvDwzKnBHQpu9DwidRU86/VYgslyrArEUbyVz4SszLscr98JtprZsyg+ManpY2S0hyFLOpq6CgNI6z6qdv5htQ9dJBfUOollpr9ealvTpSAdSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737583992; c=relaxed/simple;
	bh=Z4wzbUAsK/UMqBWrrAIyLyfCYEaojluWbFJmeaGF+oo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZwQ570S3euNlhYDcgD4pA/rxUki+gpg1pjowa/oPKiWijt6k9gRkvpCjzcLGgN125CcWJuAXacp1Cf18jXsy6mt+eNP+uaXnPp01nsuSurahnUvI5xY7CRKZf3a+S0G2Unln8MEApqTFEf0z0sHyeTpwv/GUXepysiUX32ZHOoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h0iFzzR3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P1qBrMst; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h0iFzzR3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P1qBrMst"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E98D3138020D;
	Wed, 22 Jan 2025 17:13:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 22 Jan 2025 17:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737583989; x=1737670389; bh=tJAFtY0XvF
	wcAuqs71ciWDoRKDvUzxWg1fvsXZ6qpnc=; b=h0iFzzR3AZWnabbNag3GSrfnWR
	j0F1Oz8oOD+T9s6LOLxwZ+jLC83d5pM63TRNw85v0KqDKagliR253gIgx4D+ElG4
	M92190d30Oi8yxGzXBJ02sApOC/ov29FvOUwKDg8WDS2oHtZGH4IBiGgL1tXiGJL
	I9RaCDR/A8jxr+KD+7htZegpjqKH7VRP3qCy9AbDeHDDW3t+sWdk0xTC3PBreFsN
	e+qxMLLbTAuexbMQ7osau3zDDRLm5y7ySqTgaCcV605+wdwes/xs3S//ilfKJjxM
	iVzH4171xSZclMMBghRIvupjaVEX5QTlrlf9RqGfHyTX3re2rDZhZhQVyabw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737583989; x=1737670389; bh=tJAFtY0XvFwcAuqs71ciWDoRKDvUzxWg1fv
	sXZ6qpnc=; b=P1qBrMstZpScZ4niCdH1vhpSBfHw3y2NJ+eaU9SSa1ZGC9zvico
	axX04hj8ICwIBt834d3LajD6uzaHU93ExEQy5jvuj199f0gTkAAYF/LG36LancK7
	SVFH5sg//iqwJLVG+aBkUWjAkxxKkTdX50lv21wZWXOE+aar/irqZieymAVUFHgU
	LrpanvqUZK2pG0WGr2eznqw+8CgoHjGvPQzWhnWPZ1j9Iz8DJczvGis2Hl7kVIzb
	eC1zXW/QKLn5eUrMfGnvKYeXtrmlzv7Mg4Gp4/UfXQpTB/ByLL+bjuHp1tt5+Fvv
	5nYXfGGzgKoT44SewGafooz74nRyfBRs4YQ==
X-ME-Sender: <xms:dW2RZ0dHVc9C7Ze8s7r7CVuYGr0y73TCTvV3_xucwlRg2m8HIHvnIw>
    <xme:dW2RZ2M_w3SPoUgKqJcHyJ4GKT0cFTGiDUUaPgsj7PVimoXZp7qFQW0qPM5sEshYW
    0_p8yYxhxfvIecoqA>
X-ME-Received: <xmr:dW2RZ1hHuWIiIlwE75dl62vu2if2-G550pRuPZ7MSLaTXxI2-YWkJpc_78xsZZvLAT6dcUOdczv8luvpZAfFEfVT_9YNBF04cgil>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgvdekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dW2RZ5_c_9hi3RMM0OvdqWfLR8aMliafQHm8-f8JWlPT4Tw9yXBKVw>
    <xmx:dW2RZwuO_8UAcwI4NjQ8s_appjw-cWH7U4i8c-S0VcXgWd0fc0Ad3A>
    <xmx:dW2RZwH5d-S5F9IukMOfrKd0aI5Jogd6AaMnKJ1rWJv5i-3I9oakkQ>
    <xmx:dW2RZ_N8Ve4rUJLjnIBINpHjstLhcOZkHZDla3c7_k96PkJ81HRJPg>
    <xmx:dW2RZyKXsCLDZGBijJcKoM2Se_MOvYHzFDFfhCOJtZC6Fn6wOOG9jp3i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 17:13:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Derrick Stolee <stolee@gmail.com>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #05; Fri, 17)
In-Reply-To: <Z5E5KdbwHE7fmiJx@nand.local> (Taylor Blau's message of "Wed, 22
	Jan 2025 13:30:01 -0500")
References: <xmqqwmetgdgm.fsf@gitster.g>
	<1331d214-890e-4b47-87c6-44f445172bb2@gmail.com>
	<xmqqv7u7zz8v.fsf@gitster.g> <Z5E5KdbwHE7fmiJx@nand.local>
Date: Wed, 22 Jan 2025 14:13:07 -0800
Message-ID: <xmqqh65qv6oc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Jan 21, 2025 at 12:30:08PM -0800, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>>
>> > On 1/17/25 7:42 PM, Junio C Hamano wrote:
>> >
>> >> * ds/name-hash-tweaks (2024-12-20) 8 commits
>> ...
>> I am happy with the updated function that gives us better of both
>> worlds, without losing too much from the "renamed from other
>> directory" while making sure we do not lose too many bits in deeper
>> trees.
>
> I had a couple of thoughts that I meant to share before the holiday
> break, and haven't quite had a chance to get to it now that I'm back at
> my desk.
>
> Let me try and find some time to respond to the latest round of this
> series, and apologies for holding it up in the meantime.

The topic has been stalled for unusually long time, so it won't hurt
too much for it to wait for a few more days, but it wouldn't be fair
to stall a topic further with just a promise to "try and find time"
forever.  Let's say we'll go ahead by this weekend unless we hear
otherwise?

I am not ultra-happy with the last step, as I personally do not see
this different algorithm as "version" (in that people would always
want to use version N+1 over version N when both are available) but
as "variant" (in that there may be prefer to use variant N over
variant N+1 depending on the circumstances), but that may be just
the matter of terminology.  What's important is to make sure we do
not mix two algorhtims up while creating a packfile.

Thanks.
