Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30437283CBD
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756936768; cv=none; b=OcT8067JHpzUPHYg1YroGDHu3l7nGgCbYQmUiuvmSZJ5WHj8L95Ej9ivB1NcOH8/HR2SaF2aoB8XGdvSaFDnEiP9gseiZ9NhLJehZipQj8208mRcrZQkuj3Sx9Yy4qSzgy+5I4DOraCF/av//QHpMKF+nTHYhOmElOMq/loi++8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756936768; c=relaxed/simple;
	bh=gMfRPFf0P5MjpbPmB4/XQJYl3trdLnEYaVdSjRGR2ro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rBnwtBfs5fsZCS/J8Fel8+QsMiU3I59lauEkwhq+vjvp8I/tLITmUU7o7cl4QBjpdb94s1ZOLgvshLvn9qw3hZGnhDXUmoImMXkkcWTkUV553LobdEKdWx+i8qaoQENjJHdRB/VW5VMGvitQkNP/ShizezAElLRcSJH6wyV6QNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=3LKiWreO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jndjFA6T; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="3LKiWreO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jndjFA6T"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 576C1EC04E5;
	Wed,  3 Sep 2025 17:59:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 03 Sep 2025 17:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756936765;
	 x=1757023165; bh=fmZyFgTSuVSZP0o8wVZ/sGgxT5pwZvuzCV5pPRP9GnA=; b=
	3LKiWreOOlpZal7xY1LSOSABv5JKIpVsoOImeRKj1aNDzDBQGqUms7K7ih6BmIYl
	GbQY90nmcgdtfEWGsZbp98KzzRqqpyh3Ha5wY0taqmrhHZ5b3wXRvYhvU5LD2cCA
	dDi90Bv00i3EzUgwERJ+NaBu5/Wpgi04F5dTlccAeAa1k9p7Xpmwg3+V8BIKkE/P
	qyKIGQ31rKqKXo/LAzgo5t84AEGhul/XyQu19cKkfJX3UUcJkBhOrzcK+CW9kgUt
	GRRFihtrCOqYyIxd7L/qTKPrZ4rM4zU73t7JXX7sMveEBfwm2zUar04YKaQpPWH0
	gLZ+Iolc/gCp1ZguFMReqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756936765; x=
	1757023165; bh=fmZyFgTSuVSZP0o8wVZ/sGgxT5pwZvuzCV5pPRP9GnA=; b=j
	ndjFA6Ts2dmesh9HoGOGvNeeC5FYYKUax2bcava+X9J6dKXc/ZXpeCDVS7VMVeJW
	/frgamanIQIZRsSCevYVrE5DKNYjUYNa2GhETF5EWOOMh+Y1uQACMFw8Vpk4XfX2
	HxaxsdpXUX5z4QEG4o4NvISXFLY5BEeH50dmaIzIAUcb46JGyHXHjrnoozarXcYw
	zb51elRWFsQkeyPVJSB/HEPDgMXFYmjJgA4uB3TXFr8FjMso8Wj71YvMCjNe+tOQ
	yvz06O3pGG7vVLgTgNUejcLLbOAd0nHbP0MxKL+7JKCOn9Ms8chEJJKPSEBQ35Yy
	OK3gjzCmfReV8PH3GrI6g==
X-ME-Sender: <xms:Pbq4aKIp2BNIxsaKA2Zg3FLPmWRXPBgtTAoE4x-uORPm7af4jygtbA>
    <xme:Pbq4aNrY2yi0lh-gosiHKCnrm0HudI76fpKL9MKpZMpJNDPaDKgiiSFoMU7i62EiB
    twbArLBVtzjOJwrtg>
X-ME-Received: <xmr:Pbq4aBJbCGX-YWPmA_CmmqzXsIVfojUcsXUQs-BdivAMJxx8cjUG2_AnCoKnL3ywj_mkIM3jqiebryuhM4ka8gU3G1DDYJa6aGKw2N0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedt
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnohhurhgrvghllhhmsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Pbq4aKSvDkz7CUnPAxfcS8Xmg8UejKgD3pBC75wmLHrOOEAn5es9IQ>
    <xmx:Pbq4aIt6Ort1cckEb3mG1k14tfij2fhUxwWA6NEr-jZDajy56UjZ3Q>
    <xmx:Pbq4aDZXXBpK1gtSspfUm5sbCenUDdydYTcfZRfShmnJmi8hetNimA>
    <xmx:Pbq4aGHn5GACwNA5c6E6e1MEuTVrS4MHUmJbcOZJVZVlWW97dxguIQ>
    <xmx:Pbq4aBHe8sTB8drrBTQSBKhZHds-G4JYdG9ALbIj9vKi0VeGhAdXFBTg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 17:59:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?B?44OO44Km44Op?= | Flare via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  =?utf-8?B?44OO44Km44Op?= | Flare
 <nouraellm@gmail.com>
Subject: Re: [PATCH v3] alloc: fix dangling pointer in alloc_state cleanup
In-Reply-To: <20250903111829.GA1877518@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 3 Sep 2025 07:18:29 -0400")
References: <pull.2040.v2.git.git.1756337312918.gitgitgadget@gmail.com>
	<pull.2040.v3.git.git.1756472406487.gitgitgadget@gmail.com>
	<20250903111829.GA1877518@coredump.intra.peff.net>
Date: Wed, 03 Sep 2025 14:59:23 -0700
Message-ID: <xmqqtt1jci4k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jeff King <peff@peff.net> writes:

> On Fri, Aug 29, 2025 at 01:00:06PM +0000, ノウラ | Flare via GitGitGadget wrote:
>
>> +void alloc_state_free_and_null(struct alloc_state **s_)
>>  {
>> +	struct alloc_state *s = *s_;
>> +
>> +	if (!s_ || !*s_) return;
>> +
>
> Coverity complains that there's a NULL check here for "s_", but we'll
> have already dereferenced it in the initializer for "s".
>
> I don't think any caller passes NULL, so you can't trigger a segfault in
> practice. But the code is kind of misleading. Should it just be:
>
>   if (!*s_)
> 	return;
>
> ? Or even just "if (!s)".

Yup, I like that.

The primary point of s_ (parameter with a trailing underscore) is
that we would want to use it as-is as little as possible.  When we
talk about the pointer to alloc_state in this function (not the
location such a pointer is stored at), we should use "s" (not
"*s_").

Thanks for sanity checking.  This may have been my breakage.


