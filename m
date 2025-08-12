Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBB22F3C2D
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755008139; cv=none; b=JrnO5HJgkYhtaA8rpOEAeCJPfihvs27yFhX6xSPZ3RHZQbpwWaE8WMFppYM2kKYhypGqaf8PUusrp0JIJzKFZwVCXa+zMomvtav6JpvzCyaavClYo7DLCOqX2upHK1s3KM4OdOwqEJ3s98SGC/YOHMFJYusPZZRB+e7BiSH2orA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755008139; c=relaxed/simple;
	bh=NKD0eLT3mlY27mcgHajlWN8s2F3N6z/Nv6woG4ulZHY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gMOqzoqL29Wv8sausvCyf7vgFzbDUeZVps9USYUepTfJLwQvEkVTkRn+PKtSySqjXFupY5ETF89FhQcNa+VTsNzFYmGxA9FhScf39fWVLpecHOy6eWG0JK5L8V3izG+kTG6MtVmZ6jplEVInRDoauOJBa4ZrWstcu4jQQkR48Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KYuelO5T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fdlSuuCh; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KYuelO5T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fdlSuuCh"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4661714000ED;
	Tue, 12 Aug 2025 10:15:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 12 Aug 2025 10:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755008135;
	 x=1755094535; bh=aLBukXZ2PpWAlPpSjh0IVc2j8+ZeM/dsUtNhVFlghMA=; b=
	KYuelO5TvOd2hwHFeyiTvo1T0C5kCa2PLTNvioMgXL+dYLd6k4IgVU8GxL36TQNy
	2kTdGrpFva8KfZFPEPVnixXMwdCNWu507Zj4yY5sMd33vta7J942T8mRuArWzPnz
	wJpaVDqdsY6YftEsxo8RjRFCMQIkQxjjb8KaYlRw8QRKZxWCpkfcJ0TI6l/GrBxr
	pBju2S/dnXXmbqqNA9LJbF8ZHufkAXDIw9ZLzeDNSNc9xaFqrcz1IrFptJSD2ybC
	Vh1g5WGsNQ+sieM4bBTcx6AvwwYBnjiveNEtTs2jSTYKVFLOUgi030X9sdmr6AAG
	00m+noQc3U0cAOYTqwTBkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755008135; x=
	1755094535; bh=aLBukXZ2PpWAlPpSjh0IVc2j8+ZeM/dsUtNhVFlghMA=; b=f
	dlSuuChV1RDWrfwXimmVEex+3lx8BpsUxsoKBpXernA2R5KAlJo10mv48clLqikt
	Rd9L7CBZx9k0JiCPL5DSUDttWQmb/uFSVeSisn+b7IubFLz2CoDmn1cdVyV7Qmtx
	bQ5vQEeYm3O8RCKCEEOoeco7UDMUkn7fx0yJZ8lacOMUd1SbOWxjtArjmbTtRTgV
	KRkhSMW5JOpMUFDp+rKHLUeg0nRBMUDd0sqwitsqIAzkDlZl3HbZCwdxxg265TFo
	ZdR6uMiHkaHDTcYJ5OvqoWak7yDI0H4ktIGi7qUnDoJSNsVA4BB6w+vi7jUkuQYR
	T8VfGgqncsS6hB8e0OCeQ==
X-ME-Sender: <xms:h0ybaHMHAFXB3O9egqt3glx7a_CeqKlrmUlWQAvqBKa_f8wJSzUVPw>
    <xme:h0ybaPhZ_Lpy09RBVcdqgLIWFiEPgKf3FRDCyBj_OOf1uGdpGBiYUvfhq4hJVSzxa
    e9RMazaY6sDSTWucw>
X-ME-Received: <xmr:h0ybaMuMluWO6yY0vXrOnLHIPncxyN3wNpNuk9vQg36RJjWJFuR0fbPJtdIH3YgyWG_ZLLxm8jm-uaMlzLz1zSdPJgRUqbl8TeJzt60>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgrghrghgrughithihrgdtkeeslhhivhgvrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthht
    ohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurg
    hlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:h0ybaNQocSAiMkNBUMzuoJTFMYD2JlZ84RqvFfzUKnEpAWcSCykjTA>
    <xmx:h0ybaA06mkjLHAhcb8OQAVYSDXikJk0H-LBrBxsGYS-0pHLnTjeNKQ>
    <xmx:h0ybaCvBqLeAP9o2dQw7IQyfTOUU2ewMwDJuxORzAz4ctm9debeb8Q>
    <xmx:h0ybaGjcc7wcKAze1nZhZRsFFlmIdaoZ54gC8PrEAO7HlDryyQaA8A>
    <xmx:h0ybaLAC-8IgenVgbTc2srZzYro9RSxSdavZgNfLKz_2D4aa3eGb94uz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 10:15:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 2/2] send-email: enable copying emails to IMAP folder
 without actually sending them
In-Reply-To: <PN3PR01MB95970565CA1F554E4B440C63B82BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Tue, 12 Aug 2025 06:27:43 +0000")
References: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
	<PN3PR01MB9597EC4C5DF97943587AEEB4B85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95972CAE853F4079F0F62F0AB85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqv7mtzfuc.fsf@gitster.g>
	<PN3PR01MB95977F0C73C909929400B3EEB82BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95970565CA1F554E4B440C63B82BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 12 Aug 2025 07:15:33 -0700
Message-ID: <xmqqpld0y6be.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Aditya Garg <gargaditya08@live.com> writes:

>> On 12 Aug 2025, at 10:38 AM, Aditya Garg <gargaditya08@live.com> wrote:
>> 
>> ﻿
>> 
>>> On 12 August 2025 3:22:11 am IST, Junio C Hamano <gitster@pobox.com> wrote:
>>> Aditya Garg <gargaditya08@live.com> writes:
>>> 
>>>> +--[no-]use-imap-only::
>>> 
>>> This is better written on two separate lines, i.e.
>>> 
>>>    --use-imap-only::
>>>    --no-use-imap-only::
>>> 
>> 
>> There are many instances in the docs where the command line option has been written as --[no-]something. Do they also have to be changed?
>
> Nvm, looks like they have been changed by a recent commit.

Yes.

Others around you are also working to make the system better in
other topics in flight concurrently with your topic.  You do not
need to do everything yourself, but you'd need to be aware of their
effort and avoid adding more instances of what they are fixing.

And one of the jobs of the maintainer is to help contributors
coordinate among themselves, which is what I tried to do with my
message ;-)

Thanks.


