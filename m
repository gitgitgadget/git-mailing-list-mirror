Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBBF1A262D
	for <git@vger.kernel.org>; Mon, 12 May 2025 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071300; cv=none; b=M/5nq86kvl/2IaGcHF05MMoHq6Z46HnZifnu+vtW7SUfrqZOAODQcOYbbQiq2QYT4MFum/GUKRObjOWNP8lGefSzvi8a52/HPckwk6e5EqbCKge2jqsU12LB65eD9mEpbHUtFbu/ysEV8FE3pGTwJuDrGoqfkunX9PWJ5d8A/1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071300; c=relaxed/simple;
	bh=CEHwbjmxWxr/0xC81fveq9FejFElhU60fG93uqR0sRA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VIzq+Vgb3ad6AAn/Qr16n5Mo8nwd3voqYu/tJC1v1RkV7adQzCF7mEGNLo8N0ShqNBZ1dezaD7jM/l9fRAZe6UIKh5LQjaI0+hjRam5FQOF4queA5Jb+78X2phSf0YP/Xdny13X8sd4jCRVSYjgFDdYcLSCUZig19uHKCJgjwes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oebwTkb3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cTKFbtZ0; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oebwTkb3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cTKFbtZ0"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 55AF32540156;
	Mon, 12 May 2025 13:34:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 12 May 2025 13:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747071297;
	 x=1747157697; bh=N+HCC8U7vaxsm0mXcxU9GLsV0XXRvxsbGBchA3VSLXY=; b=
	oebwTkb3jH3TXfcPfgm949piH4fOUX3C0ekqGzVytG6WIyXkxSnECr4kEThkk1gp
	9gmhMN9AvynC4J1GjY3iJeVLBasIJRwXIcPd2DrLIM+e0QOCGRpngouRA1oKXhx9
	4jCEEWkVkJVQ5XZ+M0qEZkSyzxuZM/XIAfIKa1HtKJjCUL2j7cH88rmeqpOuraMi
	1eGsj22tiUFTOjAqR+y8vK+W+zTnNAo1NjV0NYOF85VRXKgw266G7SqPLirreUFD
	4PCGwa0tS4OF/3GcJ6Yb5fyldoK2TLjxgA7VOCeHYou6vjoXZlrRdFiF0aazmeiD
	/iBi4ShGjs8f77QTWoMB5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747071297; x=
	1747157697; bh=N+HCC8U7vaxsm0mXcxU9GLsV0XXRvxsbGBchA3VSLXY=; b=c
	TKFbtZ0GJx3AxcfaEU6qwPlYzm2q3Sq/fd1jfBMZXjDceMrWjH3LtwdzLGk1Li1n
	2RPfxACBDZZsa1g4fb7iidVe1p+HWIwwM8VbjRbGX3SHBIRYsDzxmh/BgLDKlP5f
	iGAL13AaJugZJtuMU9VOYq4otqxCxIk7nRQPCeF9cBfsOCfMEQmNM263TJB63v8i
	a7SEzC9YGjyDi4Wp1Sb/DGK0DaRq9SCNAuh2O9Z6qZTsUbnZk59jnxhHAd1TGfA3
	bJcxlqDySdod90hsp1gSMJU+eRxSHuzWQ5jet4DNoFUdXGqiY1SLdpaRAZ+8QOxQ
	JUbikQwjl84bUUls9lxKQ==
X-ME-Sender: <xms:QDEiaPON2jgT3oDs6yspSTScUd2DY6OAz0uCAI7yjczsPfMLZLK6JA>
    <xme:QDEiaJ_ekG67jclqWQ5TXyp4sccgjfG3PSuW8r7wleI1xYOUWq1htWVXRonu4y92v
    yJwrOyQpLEFn82Cuw>
X-ME-Received: <xmr:QDEiaOT7pU9aAVYb74lQHw8abcH9wAs4xmiX2uAyTRY6khUPv-0s6wYi3mkaq7XPEtLc8BzSFvrp15A-eDTuTbHOiA_zupc9I9vKnSE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddukeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrghgrug
    hithihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepjhhulhhirghnsehsfigrghgv
    mhgrkhgvrhhsrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhr
    tghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpd
    hrtghpthhtohepiihihigrohesughishhrohhothdrohhrghdprhgtphhtthhopehkrhhi
    shhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QDEiaDuEDj1Eph5_9XF-pEEVPUv5q1yvrPfHFkLTCaYKgnMOp_CWrA>
    <xmx:QDEiaHcTo1aXc-TC9C6Vl0EbGeXfJv9ZJOEgbSOertBlqyAmqhJDaA>
    <xmx:QDEiaP3PhgtP-6S33W4bWZBXjtV3wLCozzE4sf0cLQvHCSIboGKKcQ>
    <xmx:QDEiaD9uHZ2TIpNKOuURS7jmdMPuwiDpd4MXp8VapKD4YqlOAgUqVg>
    <xmx:QTEiaKKh-QJk1RGrCzSG4CMOlb1WY3VnNpwWUxpMi8MECZ6au0zACBrm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 13:34:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Julian Swagemakers <julian@swagemakers.org>,  "git@vger.kernel.org"
 <git@vger.kernel.org>,  Eric Sunshine <sunshine@sunshineco.com>,
  "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,  Zi Yao
 <ziyao@disroot.org>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2] send-email: try to get fqdn by running hostname
 --fqdn on Linux and macOS
In-Reply-To: <PN3PR01MB9597D7CAABB0EEE93A5CC490B897A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Mon, 12 May 2025 16:46:41 +0000")
References: <PN3PR01MB9597C419019DC28E489D2AF9B88AA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597BC2E1B526A11D21BAB24B895A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<D9U0KAX6KVXK.WCY7YGX2Q0A5@swagemakers.org>
	<xmqqa57hvl0f.fsf@gitster.g>
	<PN3PR01MB9597D7CAABB0EEE93A5CC490B897A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 12 May 2025 10:34:54 -0700
Message-ID: <xmqq5xi5u401.fsf@gitster.g>
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

>> On 12 May 2025, at 10:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> ﻿"Julian Swagemakers" <julian@swagemakers.org> writes:
>> 
>>> There are multiple implementations of the hostname command, and they
>>> don't all support `--fqdn`. For example this will not work on Alpine
>>> Linux as well as macOS.
>>> ...
>>> All seem to support `-f` though, maybe that would be the better option.
>> 
>> What makes me worried about such a proposed changes is if there are
>> implementations that takes `-f` but uses it to mean something
>> completely different from fqdn, and emits something that looks like
>> a hostname but is not.  At least an implementation that takes --fqdn
>> without erroring out would try to give what this code wants to find
>> out (or it is simply crazy), but -f does not feel specific enough.
>
> What we can do is use `hostname -f` for macOS, after all its the only darwin based
> OS used rn, and use hostname --fqdn for Linux.
>
> Although it still leaves out Alpine Linux.

As long as we record the reasoning behind our decision to use `-f`,
with an explanation like "we can add a configuration to disable this
if an odd platform implementation of `hostname -f` truly misbehaves"
to suggest that we can, if needed, easily give an escape hatch if
this change breaks existing users, I think it is OK to just use
`-f`, which would be the simplest ;-)

Thanks.
