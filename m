Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66FF5695
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 19:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758740516; cv=none; b=S2dolOVLhec/1TKx7Hb9Er1bh1c6+C9rzbby8T6qtgnv0kYdhGHzCzhH5B+F//Bctx9PfUINUexhPPn7YlvtOypO7nGE1LBj/fERoek6/OTnXVYKCq1cfRzq/88tuHwIqgfFXV7cynFwfDaaxSgmnCDPJhlH4DDZDqftN2hFIVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758740516; c=relaxed/simple;
	bh=AJrmYy+y9iz4KfI+OtGNXX5w+C+Q28CLhWpe6CJ44dY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LW7xS040n7lCIgKnDCroYScIDuJ9XVI7pGMVqS5x/JzIAG9rnZtVlHMPpwH9p2HxrJS9yr0v07pCvBS1KPgfJPuybSSIQeOJkLJCxXIVeSNVL4CSaHzJxDvB4UKtD00/6/YGhUzffbnFHKww7ebimb1x5ONL0qjh8Dq3ZgXvaKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xd90jcsR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i6pnWboV; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xd90jcsR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i6pnWboV"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id ECD8BEC00CA;
	Wed, 24 Sep 2025 15:01:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 24 Sep 2025 15:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758740513;
	 x=1758826913; bh=wiW6zJzyK/O71FXHW2Ktq9v/CE7+MYHGIOWJAWA9g4w=; b=
	xd90jcsRyHjks284h9d/m/9oLdy5G7lYK6aBWzmgjEVaBpCTAHu7jl8CPKJlABNh
	gzNPaTNCPvbz7oMWuyKEFy0skAZtiqcztyVeR22T/c4EN+sIMIgFMgEkhoahBvOL
	SQdq48Ptlv6ecPSYIMbykbehhgtYxDd9CbdDYE2C7O8Tf0g2slspcmCxpBcxiJ2o
	4wAPmbBrYTmUgh7yq6+fsJA2oX9BV2RAlielfXthwOHwpIAjunGnpyQQ0pKsuaRi
	GxTnfebJW5vPDETbxjE+NEEMV+Fk8UzrHPC6keqjg3fVVsmDj9896ewMZoPOKq2r
	dgf9y/k/WhZpfDNysvo05A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758740513; x=
	1758826913; bh=wiW6zJzyK/O71FXHW2Ktq9v/CE7+MYHGIOWJAWA9g4w=; b=i
	6pnWboVWAJSaDE8XG8Rr1JYk+QKKFDNyhnYdHzOSIm0zyaDNxwLRgBlDFRGH5jXP
	T74sIn5/JWOi+iszIre/cr8bBr7QDEbQ7xDuNnA/LX6jmEC55RRbEIHozUQIuLVa
	HErRHhzTX+UTnQO7EFE+iMq4+JEujmpHzw/n+s7G8rfzG3ctmNkWkEKSwR8wstf6
	HqCblZongPtl8vYepBEadVf/tmO6IYbbvGTYiALcFewf8aprFA2jS+Cd9Cg1EVod
	OZHeTpREPKKVD+gi1kWZ/gGcfFnn0Z/QhDWx9VFN/fy5HEMkHiMjis+iy0vRCvyj
	Od7BByEVHxmeJJrACsa1g==
X-ME-Sender: <xms:IUDUaKKroT0Tm9g3HVEc5lIvwLS6mPhHFah7uC0upwsp9750qUpRtg>
    <xme:IUDUaJmXM-WuNrGPFw6C0m3Kdtg89XGj3KnIsOl61GdG9hYsDGtWzv1KavjjgKlxb
    fRBRfK89MRp3ZTeNzy4mMPo6d0rDP7n529UdF12zh4EaxrCdWf-Gg>
X-ME-Received: <xmr:IUDUaIEKtZRaIuLdn7gidbukuG9ecNZZtVuUqZdVhQ_TQiyhv7-eLrwixWwP42c_RBEoQ6s6ddCsHlQDeZvgnrwdhWIZjT1Hv4aM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkeertd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevle
    fgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsiigvuggv
    rhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:IUDUaJHiO27wQ0iHnYr1Xup4MRPM9FDFXtS5xkhWw5cCWX04VV05-g>
    <xmx:IUDUaFM5G8MdwqCex5AqGj4BDCOaV-xyFy_8EUSLE7rGGXf9fokFsw>
    <xmx:IUDUaIF7LWXKy0-gg0_yN7dNuOv1yLiw0RpjxJrIe3sNsxjm_QmpiA>
    <xmx:IUDUaMOFEhjQig6MKVag83Ab5jhL4rkESzy0EVN-DUNONGprtnC1Hw>
    <xmx:IUDUaBlbuPkbkKO4lzc2wvcRHy2LIbcWc3W6Kkqw1-jtGjS874NfyVTb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 15:01:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2025, #09; Mon, 22)
In-Reply-To: <aNOTMtVC0ArCSTRS@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Wed,
	24 Sep 2025 08:44:02 +0200")
References: <xmqqldm6qehe.fsf@gitster.g> <aNOTMtVC0ArCSTRS@szeder.dev>
Date: Wed, 24 Sep 2025 12:01:51 -0700
Message-ID: <xmqq8qi3llnk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> * jt/odb-transaction (2025-09-16) 7 commits
>>  - odb: add transaction interface
>>  - object-file: update naming from bulk-checkin
>>  - object-file: relocate ODB transaction code
>>  - bulk-checkin: drop flush_odb_transaction()
>>  - builtin/update-index: end ODB transaction when --verbose is specified
>>  - bulk-checkin: remove ODB transaction nesting
>>  - Merge branch 'jt/de-global-bulk-checkin' into jt/odb-transaction
>> 
>>  Continue the work to build on the bulk-checkin infrastructure to
>>  create many objects at once in a transaction and abstract it into
>>  the generic object layer.
>> 
>>  Will merge to 'next'.
>>  source: <20250916182938.2193476-1-jltobler@gmail.com>
>
> The merge of this topic into 'jch' modifies 'object-file.c' by
> replacing a call to reprepare_packed_git() with odb_reprepare(), but
> at that point the latter function doesn't exists yet, as it will only
> be introduced in 'ps/packfile-store', which is merged later.

Thanks.  This is because there was a merge-fix defined for this
topic that was written back when this topic were less ready than the
other one.  I'd need to move that merge-fix to the other topic to
correct it.

Thanks for catching while this topic was still outside 'next'.

