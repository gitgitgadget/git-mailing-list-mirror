Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877AC3EE1E3
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851817; cv=none; b=OpC93BSud9xwEEtFwpXeqNcuxabqPjRjzEyIzaOSxBIdtXp2myYOXoaGz8+JSnhoqJiUcdi40cTTShjGLTdVJFiemNehBnNOv7ILzXww6xZN4luvXCk8QVGY9J3b2FC5mI5+6/opNSThs+x/kqeNi0IWiL6kERDStwye9Vei8g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851817; c=relaxed/simple;
	bh=/MNVqHDTaBKoqXKYUkDgyKJNW/Yn2IPy13dyJMTj39g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DqdFrVSUkeLYTmoBPogoKhp+0CQFrsD5Sewc6R5P9zP5RKTtEwcpFK9hh0e7gkajFDqbgW7wUCtC7UJge/9FIKocFaYstLGhQe+jhWOkijbaXFRitNEwUrwXoUuIMSPmP9Z8I4SutJxIrtAVB993qxMRrdwDdkWMrEasS2S1tYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ekHqjGy1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oPWskIbz; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ekHqjGy1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oPWskIbz"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 411A4EC013B;
	Wed, 18 Mar 2026 12:36:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 18 Mar 2026 12:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773851814; x=1773938214; bh=I4m07PeaU1
	kmtGD/sQsh6bsgC9SlyXheyJ3k4x3yGj8=; b=ekHqjGy1kwBoZKO0zNrxwFJIPy
	4Kv4teKSeogZvB4i2orTq2V3MmkupQ7FHJWzy4oNo/iTmvvda8mv727KQbM8KL6E
	uPbnh8Hnl11smfmvk394/oViXiUi3fTsby7OuNqPmkRjrUOVXR4yJVncGfL32DR9
	7eSjjiYpXyBlqsTMBuSLm+gEguVJKEAgDIzw8vYzFrv9g+62tgh1cFxgTt0BnooP
	8UNWRQnH0ZtueiV2cXwDCsIvCJNbFsb3MunC6XFaarceYbm2VACrLlDSZHFWy4g8
	80o4JvfqkTq/Of6vWi4PpluHgyD438e2ho1bLsiWAQ6Ah4iqgdDcFdL/Pk0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773851814; x=1773938214; bh=I4m07PeaU1kmtGD/sQsh6bsgC9SlyXheyJ3
	k4x3yGj8=; b=oPWskIbzB6TAsOM/E78SS25RM60OkY+DpHo9ZW/BVa97dPniUxz
	3T3KVIhN9NXOHw10t8F+oWvKoEfIyh+A5VYoFfwKo7S/uXnNpWM39YeDtFPeKaF2
	crAhYkEtXrfpa83elfFytI9bqguJUtU4nOQjAfskYekBqVcj6A8WJ+0MII60EAAk
	rmACvvxUonM66u3aiXcje5YsTMhrNblysK3MPVUw2UO2JpMPLXlb/YBAbXMZi6WL
	/d92sLN1JS0ZDiC/2F659V7T/CHemRAKm+lSjSdYwT5t506MEZyxinAXpYvNWauX
	nAs0/D1wUD12yLTHlXnCxw1+cXj/nTv52mg==
X-ME-Sender: <xms:ptS6ab5h7BWXtXLkBdNNZT19h-Jg7_p6bmF7hfK1ZMMVOqpy_Rw7dg>
    <xme:ptS6aX4SzfcoudaQh_o9xcoTmLiEoftEALoxOKiUrtmmch4nAElDf81s30YOoHqkC
    h2KHXelykJXt38A207quIaGEfn7FKPNXCW9EFwkaWK8ZKx76yoy>
X-ME-Received: <xmr:ptS6aXchAH9TPojZUBrWuDje5QKXG3Ah-nSL5h8yjfZZPj4pdQf5807BD2i6hxRXCnGjpUhY6YLcUHyX_eie6459fCa4cyQgcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdegieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ptS6abA38xUR5Z6CLykygO9jX7TPbj472DC3UEH0FrE7y3NAXGt4QQ>
    <xmx:ptS6aa8LGIAD0a6ViZeQEX0Knr-mZ6OMPU7VRuTQI5lbJXeZG4aSIw>
    <xmx:ptS6aWKBpvpN5hEYf8Na509idONtRiLDkV-xJi3BN4olXJ1CaYL4_w>
    <xmx:ptS6aTg2Zht4xvoY4rdSYgV44HILv85CZx_c_GUpdaKK9ypQADGWAg>
    <xmx:ptS6aW8iuPSYe_BM6zpzF0DYY8BREvglQAyGuBOELqgOWRLHOAyilDrs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 12:36:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2026, #05)
In-Reply-To: <20260318030304.GA1926419@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 17 Mar 2026 23:03:04 -0400")
References: <xmqqh5qka8so.fsf@gitster.g> <abh/LUGAWUDx/E2t@nand.local>
	<20260318030304.GA1926419@coredump.intra.peff.net>
Date: Wed, 18 Mar 2026 09:36:52 -0700
Message-ID: <xmqqfr5xgkm3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Mar 16, 2026 at 06:07:41PM -0400, Taylor Blau wrote:
>
>> On Thu, Mar 12, 2026 at 05:10:31PM -0700, Junio C Hamano wrote:
>> > * tb/incremental-midx-part-3.2 (2026-02-24) 17 commits
>> >  - midx: enable reachability bitmaps during MIDX compaction
>> >  - midx: implement MIDX compaction
>> ...
>> >  Further work on incremental repacking using MIDX/bitmap
>> >
>> >  Will merge to 'next'?
>> >  source: <cover.1771959555.git.me@ttaylorr.com>
>> 
>> I think that this one is ready to go. There was a relatively small
>> range-diff between v2 and v3 based on Peff's review of the earlier
>> round.
>> 
>> That review[1] said that:
>> 
>>     There were a couple minor issues brought up in review, like
>>     out-dated comments and the u32_add interface. So I think we might
>>     need a v3 with a few touch-ups, but that's it.
>> 
>> , so I think with the latest round we should be OK to start merging this
>> one down.
>
> Yeah, I looked over the range-diff for v3 and didn't have anything
> further to add.

Thanks.
