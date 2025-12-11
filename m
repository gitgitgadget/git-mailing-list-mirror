Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3822D7DC3
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 09:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765447153; cv=none; b=FLxhgnJv4pVYQvtoxQWkNvXTKSp4BGOdRnu6RZymzqE/lE2j+E7i/4e1uPtjB7zsZd95MsZ9ui45vpatxCb+GzRGqZzqfRrXKmex9mmJcT4roEoV6qLt1Hsr/JFGfBzU9w1LqlNHm2n3cm5Bzo+p31y3MU6JOpHW/nIR+P8qrV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765447153; c=relaxed/simple;
	bh=yo62tHQIW3CBumLoGCl64uHCyFnATWXPxbC3KzN0hkM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iHLE5woQ+T++RssrIoWZv3LbCtETNFjHWKpeLRPILGObYLMa2CiF3q2KFcyGvDrdqFQLVzcCNdtz9o+uLzchX1GloPm4pv71rj2ysfOg8g622YOyfMJqiG+CMxUSN3tGGLDzx1DUC/51N02S2/mdEzereckwRX6QVJ+5r0O5aRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GB8nMfVP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PzgIEec6; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GB8nMfVP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PzgIEec6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3E99F14001C4;
	Thu, 11 Dec 2025 04:59:10 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 11 Dec 2025 04:59:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765447150;
	 x=1765533550; bh=9vK7AljJOI3kdEazaNOxlQx9Gk1QXAunI3Lmulhn0M8=; b=
	GB8nMfVPz0FG8gclhRJT/HFYE2NyMY8b7YDMb44gIJLcijT6TxMediHGvvNYoEDG
	FNTnaWKluzlKw7v7SAsOvEVAYGdsNb5ZeIr+NBsj8DL4Jcx5uDYd2pkuLAMGlmV3
	sOu71w9f+v/phLFQVRV4cJ+LZ+YGRPWranZWmx7MxBPQt/B05vUwMRxCJIS9QIKK
	xDKdnsuCW9FIGy4BONQSxvnWorhzFe3Rc03j0iztddyNDBTrAwBAyGTAX0wUI/YW
	+QB4uLXvaKp4W9pF/MjMg1AKOSMZQbLVZSNkubzGEP0eTaHRpQS6K4yZSSfGfWfH
	7uaa+wnelylnz3wrQX4sHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765447150; x=
	1765533550; bh=9vK7AljJOI3kdEazaNOxlQx9Gk1QXAunI3Lmulhn0M8=; b=P
	zgIEec6HmU+jwFDYmr3eGeBT32dKPl5awDPzkAPImk6OGoS82qopvurdEhyBtia+
	low7VJeEgSG1zkQT32CcUElnCLiXYXz3Y/f5loYdWACoLQfwCyDKBCQT6p+ooXa/
	R1wDtAjt2fviPOYM/B2jhVfLSJ33jSy/zHg11m2P464WLlBHVzKZEBVsBpB/yMRl
	yS5+Oi5M5SfVz2Qa/UyMGVY+bcvC/rvg0cfpvBAu+UldSqjAYQjGMkmbe2RxRt29
	QiKJIuqD4O3Hc8JFftxcIt3DE74mc3vbPHqH2G8/27IP9OK2/gglAugnwMK8URRu
	0rnNv9pdJOIu3jYEFbBMg==
X-ME-Sender: <xms:7ZU6aR6LajGpJegyAt-eOEByddZuvdrrhPCXen675dIfZ0AT502opQ>
    <xme:7ZU6aVwWLyK8zYnyo67PHjMW6ZVbOebMRZtyQcqPogMeIo6mskQNVLVVwQ0X9mR6l
    RpdpWWuHp1rNz0k6tbnUhqaxDrkLA6riJKU6h-Jz0CDV_IR6SArPg>
X-ME-Received: <xmr:7ZU6aQzABeT3Cqgne18ImMtBmPJR3Z1DsOn3Z4sst6VX666X972XSkWAVLevYdC7B5UDXXpJ1Wl9ISihfOe7ci4tDniBtmtoXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvhedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehsrghnuggrlhhssegt
    rhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehkohhjihdrnhgrkh
    grmhgrrhhusehgrhgvvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:7ZU6aVy3rjky9iIJKTDLjx9rbMs84crPx69Aj3wVLwFubCDDIWKeKA>
    <xmx:7ZU6aSZ3Bo4nEipWT2IhnzmvyOhcHPgCHHiIlbV9IsBIHf0zUgtLVQ>
    <xmx:7ZU6aeU40RYVQLZQk4w0ba5FVt4bsnDHluqbGiTBxgkyth8ZSJR0jg>
    <xmx:7ZU6aYg_iA9Ts6SlmMRj2kchhiT-r3RhHBGmyAhrWwtgxscqvIsW3w>
    <xmx:7pU6aXM_rLDpb8G6pYzmnZ94p4yH5-5qTDSa-p5CHl-4oiusLe_qa0Db>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 04:59:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
  Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] config.mak.uname: use iconv from Homebrew on macOS
In-Reply-To: <xmqqecp1hhi7.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	11 Dec 2025 11:36:16 +0900")
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
	<16efc726-34be-44f5-aa92-4e82b663ab3d@web.de>
	<aTn92yqtSDyVoLgh@fruit.crustytoothpaste.net>
	<xmqqecp1hhi7.fsf@gitster.g>
Date: Thu, 11 Dec 2025 18:59:08 +0900
Message-ID: <xmqqfr9he3v7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> On 2025-12-09 at 19:35:34, René Scharfe wrote:
>>> The library function iconv(3) supplied with macOS versions 15.7.2
>>> (Sequoia) and 26.1 (Tahoe) is unreliable when doing conversions from
>>> ISO-2022-JP to UTF-8 in multiple steps; t3900 reports this breakage:
>>> 
>>>   not ok 17 - ISO-2022-JP should be shown in UTF-8 now
>>>   not ok 25 - ISO-2022-JP should be shown in UTF-8 now
>>>   not ok 38 - commit --fixup into ISO-2022-JP from UTF-8
>>> 
>>> As a workaround, use libiconv from Homebrew, if available.
>>
>> I like this solution, since it means when Apple ships their own Git
>> (which doesn't use Homebrew), they will be incentivized to fix the
>> problem since the test fails.
>
> Well, their build without Homebrew would fail with or without this
> patch, no?  It is a good thing either way ;-)

Does anybody know if a purely vanilla installation of macOS, without
any third-party software collection like homebrewk, is supposed to
be even serviceable?  That is, if somebody at Apple builds a version
of Git that they ship themselves (they do, don't they?), can they
untar the latest tarball on a vanilla macOS box, type "make test",
and expect it to pass?

Are there folks in the audience, with stakes in having such a thing
working, whether working for Apple or not, listening?  Can you
perhaps help us to get to that point?  The effort would involve (1)
fixing bugs in their own system, like this iconv issue, (2) marking
some part of the expectation unachievable by sprinkling !macOS
prerequisite in our tests, if bugs in their system like iconv cannot
be fixed for some reason, and (3) once we get to the point of
passing all tests, have a CI job to make sure we will stay clean.

Or do folks in macOS ecosystem already do something similar but
outside this mailing list, and it is useless for me to attempt to
help them?

