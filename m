Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F6A2F5482
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105401; cv=none; b=MCLnfiNioLJgHnyfr1rk7N1Y7kP9BlHrfIcKaaaPQdj221G7cBmA5BxZthZFkwtxEjKRM3HRmW3Hn186Oh1kB5O2y1JtAPMkoGWlIdnJWC1KJH5YM82NJ7WpRMJfY2jrOe/aU6qNMNkcxqQmHOLg0iLqrzz05z/48mi3I8ftlHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105401; c=relaxed/simple;
	bh=C4KJ/HmshPsMLhhyvRiCguJJX4dDdo1KKaSuTsdFLwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4E1qaPy4A+tPhDlfJgTXRVxS05CKsvsgt5i8abH1+9QqUfJyh1kWqKqWCSFHmturWZDp4slsikQzCxE5Hp61b7TYOXYI+VsdcHrwwXiMPl76bM9WztiwifnNQxFkIafAef2mead05l1dQel1hD11CZV2lMYIbuOLyj9aZhYqHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SkRogRY9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UEjdfPjp; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SkRogRY9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UEjdfPjp"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E81117A002E;
	Fri, 10 Oct 2025 10:09:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 10 Oct 2025 10:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760105397; x=1760191797; bh=8IPTGlIhcS
	JQz3OGUrp4SwGnFS1MkcxZRtbQ0w3JfUo=; b=SkRogRY9rEmPpTps/looHDa24n
	9jUKMCOmzCQH5ExGXGt6jjLic7XL4JXSk2Lvk5cNdgRijm3Rq4g+JGmhJiGOGmXt
	yhE+2WYPO4TJVNDn71XcT1Ii4KccT006je8HlIGwaN9DFkvYg9iwaeCMnvRoRrLb
	6iOzF1rlUmv+5//tVHaQ4cDrq6KcDqN9yFpTdvu+3Zp6GS2COrSvpsp6FWtYEW1f
	tZ9MAuq8Z+/Vn6YJl7lk5n1/k3X+ulDaBjxcAjWOMwq/MgTov4HjyIIYz/sXtBvQ
	CdwNotbGmRDUnPOKMxsLheWr/r9iYzeNOlywQXlS2bH/sEqoRoXqH22DHofw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760105397; x=1760191797; bh=8IPTGlIhcSJQz3OGUrp4SwGnFS1MkcxZRtb
	Q0w3JfUo=; b=UEjdfPjpxN9+pWRDEDcnHOrwUjYCvVAMmXaUFJYAURkqhMLdQYh
	RFMyXHxOAjWQ2dZ69eTmoC7M8bxip9hXNIskKle/68uZ8H68qaflmmbUWHLAi+1j
	f84gHzywtnMqabj9Y3JF50kKifWO/w1TTI7zB/3YOcfAxxgTQAQ2tS1vUrR2qLlt
	0qneqgyPtLe8qydfM4MbV8TYYwc4zd25cdYdAhsdZ0ulzOrfLxpx95OtKR7J6u2L
	mpZOuR/yxryfR6skwp+HS7CVCnYMnVPVinUIIcV0QF+xJr28EjfNXtSIUUn+zTWq
	ohoTZ6q0j819CO7lZpaX55m+GM7jbdJBYMQ==
X-ME-Sender: <xms:tBPpaIuOij9MsxcBWDQqDQ8uWZQs0-PQp3rQyo_LUayYNPyTLUlJUQ>
    <xme:tBPpaCB6__O2B1nT7pDrp5J9V9za-YH3jzDTWviUMnICnoLV2FN5Rv6jA_dkWWQb6
    yHS4-fLzs1UV9V3-C9qhuNWSt5H79uZ3iglfy7jRjFSCYm15tHVhw>
X-ME-Received: <xmr:tBPpaIP4pTQazFXFLL54vdMmLt8m2ahcTDg5CgttxSTXqoFM0f2J5JQl-LamLHPBNloNNcDnPfIeVyaDLzlQL32cC2emAHfO_7a_3rul4aNCTTMm9SMX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdelvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfhougguucgk
    uhhllhhinhhgvghruceothhmiiesphhosghogidrtghomheqnecuggftrfgrthhtvghrnh
    epiefhudfgueefieeigeetheffieffudejjeekjeetteefvdffvddtjeehtddvudetnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsh
    grnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheptg
    holhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:tBPpaCCDKWtquyJrXTwTTsVyegikTPLsKld0ShefbAWLgOe3CT43DQ>
    <xmx:tBPpaJ5sGep8EiPG7poEQlnKZB1nvWk9fDMExYflp2c1ag9vjBiVpw>
    <xmx:tBPpaM6qE4NqJ77g8heHtx2R5O7sWbeQpA0ApdRM1UKFfdgy3hxhCg>
    <xmx:tBPpaLQ2fSjXMhkEp8InN_TBdYuhsa98-6JC3ucTPzd03wUK9nY0qQ>
    <xmx:tRPpaC5UQntE4v1LVekIB88SlV2S8JrW8GozVY1vVaI6SgtHwwga0fgM>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 10:09:56 -0400 (EDT)
Date: Fri, 10 Oct 2025 10:09:55 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Collin Funk <collin.funk1@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/5] lib-gpg: allow tests with GPGSM or GPGSSH prereq
 first
Message-ID: <aOkTs7G2GGLKajUf@teonanacatl.net>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251009122457.1273701-1-christian.couder@gmail.com>
 <20251009122457.1273701-3-christian.couder@gmail.com>
 <aOisaq-rSdwjwo6b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOisaq-rSdwjwo6b@pks.im>

Patrick Steinhardt wrote:
> On Thu, Oct 09, 2025 at 02:24:54PM +0200, Christian Couder wrote:
>> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
>> index 937b876bd0..b99ae39a06 100644
>> --- a/t/lib-gpg.sh
>> +++ b/t/lib-gpg.sh
>> @@ -9,6 +9,16 @@
>> @@ -63,6 +72,14 @@ test_lazy_prereq GPG2 '
>>  		;;
>>  	*)
>>  		(gpgconf --kill all || : ) &&
>> +
>> +		# NEEDSWORK: prepare_gnupghome() should definitely be
>> +		# called here, but it looks like it exposes a
>> +		# pre-existing, hidden bug by allowing some tests in
>> +		# t1016-compatObjectFormat.sh to run instead of being
>> +		# skipped. See:
>> +		# https://lore.kernel.org/git/ZoV8b2RvYxLOotSJ@teonanacatl.net/
>> +
>>  		gpg --homedir "${GNUPGHOME}" --import \
>>  			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
>>  		gpg --homedir "${GNUPGHOME}" --import-ownertrust \
> 
> Interesting. So I assume that these gpg commands here fail because the
> GPG home doesn't exist, and thus we disable the prereq? Too bad, but I
> agree that this doesn't necessarily have to be fixed by this patch
> series.

I agree.  But it is ugly that any tests we have which rely
on the GPG2 prereq simply never run.  That should be fixed
and, if it were me, I'd do so by dropping the flaky tests in
t1016 initially.  Someone who cares about those tests
running could debug it more and hopefully fix the problem.

As it stands, this breakage blocks tests in t1461-refs-list,
t6300-for-each-ref, and t7510-signed-commit.  Anyone adding
a test with a GPG2 prereq should be aware that thoses tests
just won't be run.

The t1016-compatObjectFormat tests have been flaky since
they were added and no one really noticed.  That's at least
partly a failure of our CI output, which hides these sort of
skipped tests that we just presume are running.  I don't
have any good suggestions for fixing that, unfortunately.

-- 
Todd
