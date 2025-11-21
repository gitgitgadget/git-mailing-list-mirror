Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8312DEA89
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763742504; cv=none; b=idoGm6Z2vTNct49VtLSAsIiLiDxxQaCvvZYKnarS+Kjo0omQfSSF8FfWnkWtkojnRTZxFnByTqdLfWm9lAWyB7GzdZ2DFlsvyVTLViX9IEDy5iJATZlCrhiilTchQIHLhg9ZmqHV2x7nET0v/bAFqwwxeJSosIsnl2Ru+qtatFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763742504; c=relaxed/simple;
	bh=VwgcoSgyNGmCH8NyB0UFy1Y0huhBIp5Aef/vJlSyCrI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ox/bw8FcijWd/4EbALH4HMrXrdvmwpTEEYYmlAYzCg2y/16A0SL+UrN3VQ+NRsO00FAIsqjEHzsNSgwObE77q0K8KYrSiwu9si7C+n80jLkapHi74aEzr9oVWK4PLYLB6L+SJJiPnFCOxEG5Hjrmnrz1WvRh8RxssbfEw/W5mbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VBBAW+K1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HcMFMh1p; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VBBAW+K1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HcMFMh1p"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 1EF36EC00A9;
	Fri, 21 Nov 2025 11:28:21 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 21 Nov 2025 11:28:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763742501; x=1763828901; bh=IOOSDYW0A7
	DbcBVN4jV/X/bq80NoEBwxUOh4xxEnloc=; b=VBBAW+K1UX2anjj7ZyEwnxyUc9
	MWurUVtfF5UDiCgKlIzmT0RfFCmWH1rl5rs7/FK2EEkXuRioGCYY1+sHzonlvSOR
	3ceU5GMuJcFXa/s/3/K14ysn1l2s5JFi51SEBrBHZ6TfEtWzwROJj4o+8VA9RAuR
	tyTOwHQAOwq/B5Z8ODQ5oMZ9RnlCvzoTGY4wUYIOC+3m2cEZNuFnPOY+kEvLMSeO
	eSyFx0rSfvdCeHlG4hPxVlPcM2HoGRdrEa3OE0UVfPwZzyY03hz9rlXwCvlNMPEh
	ln+5svETPEpwuP84hk7amre0Lm3bigMQ0eeOd5h4drh19IRXcSZQ/MSPcx6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763742501; x=1763828901; bh=IOOSDYW0A7DbcBVN4jV/X/bq80NoEBwxUOh
	4xxEnloc=; b=HcMFMh1pby8kLFsJjtfDk161RcVW/DUgur/2JCN18V5j1OFgS07
	kRAFIc0FcJrEJOsv7z22LcG7VqGlg7n5qNsZS1HPBiWCa0BOqZWK39XUbJ7VkgNN
	iytwahizB5fwpR1guMDU971D48L4QM7h0p0Kt8h8+px//eySzCBVCB5EgnHe6gUo
	D6T61bx+3JzrYBeIn6HMAdkkaL7qQgscLIjCDm+QbC5pmqxgXr4jSqppzXsFd6Oj
	eZhMLNuG0q/kvZFkqdrKTCgmX+cZCDZ2o98f3xiW/7KLR2RQhWbuPv73dFMEOKN8
	pEIQrrRQzXfROgN399MnY+6rHU9zduY/aMQ==
X-ME-Sender: <xms:JJMgaRq5_hBQUyOitYEoHxYr2k-Bb5SjnCX0uSsjfM8MgG0m7zzwfg>
    <xme:JJMgaars6Kk-rR-s5j_HiJwWoDPo7mUDwzmsYqnrxywWR6cM01vVVg7qxMqiLrNDr
    DluMk57nWsXC_kEPmeToA9pkwkhYsNf6miEWZXkIgokPR6tG5E->
X-ME-Received: <xmr:JJMgaTOOb6NZhRSMzDUmsS50jI0lBAxiLt4e54v5iUC1JZ7CAGNb6X3tlIpuDCAxb6mrA8BuxREuhy5yDQicoBMexJhT_rFMz2wV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedtgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrsh
    gsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:JJMgabxrZfopCLT69zsQ0MZoBAghVL1Hl44IHgbWVhiWIMdRlpLiRQ>
    <xmx:JJMgacv8isL6EWPx4-A1WO9WkpAZq77WjMOYENOLzZr4EU0V9uEKdQ>
    <xmx:JJMgaU5SBhhPCnFqIM__qYEoCTYLZP49rME8a9bfykhk43bm9ioZvw>
    <xmx:JJMgabQydvQkM_7GmXJd0X0Jq3SAHkcNizkNEA8b6gvImSfMwM9UPg>
    <xmx:JZMgaRxIhFypU0zDzlGWz7oQom6J0mVhEFkSTycrKQ_l_GRL6L8N7zpF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 11:28:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Kristoffer Haugsbakk'" <kristofferhaugsbakk@fastmail.com>,
  <git@vger.kernel.org>
Subject: Re: [BUG] Test Failure 2.52.0, t8020.16,19
In-Reply-To: <014801dc5ae9$543c73c0$fcb55b40$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Fri, 21 Nov 2025 08:18:24
	-0500")
References: <003901dc596c$40bfbd80$c23f3880$@nexbridge.com>
	<94d81164-5af5-471e-a403-f2d544796d18@app.fastmail.com>
	<014801dc5ae9$543c73c0$fcb55b40$@nexbridge.com>
Date: Fri, 21 Nov 2025 08:28:19 -0800
Message-ID: <xmqqy0nz4afw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

>>> expecting success of 8020.16 'cross merge boundaries in blaming':
>>>         git checkout HEAD^0 &&
>>>         git rm -rf . &&
>>>         test_commit m1 &&
>>>         git checkout HEAD^ &&
>>>         git rm -rf . &&
>>>         test_commit m2 &&
>>>         git merge m1 &&
>>>         check_last_modified <<-\EOF
>>>         m2 m2.t
>>>         m1 m1.t
>>>         EOF
>>>[snip]
>>
>>Also reported here https://lore.kernel.org/git/4dc4c8cd-c0cc-4784-8fcf-
>>defa3a051087@mit.edu/
>
> .... The concern is, is this a defect in the test code
> or underlying
> git merge code, and if the latter, how big an impact. If we hold off, how
> long will it
> take for a fix (approximately). I do not know the merge code, so... 

But is this really about "merge"?

The test is about how the "last-modified" command behaves given
histories of various shapes prepared with the sequence of commands
that comes before the "check_last_modified" line.

You can probably take a snapshot of the resulting repository
immediately after "git merge m1" from a test with both problematic
version and older version and compare the two repositories, and I an
reasonably certain that you wouldn't see any differences (no, I am
not saying they should be bit-for-bit identical, but the set of
objects and topology should be the same).  Bisection by others
pointing at a commit that changed how "last-modified" computes its
result should be a strong enough hint as well that the problem is
unlikely with "merge".
