Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8D81DE4C8
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 17:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738083950; cv=none; b=oC0aZkaAJPTKxM+BMUqazV0H2taBH46pS+8aV0r8+teYvB35y7SaPfOjV514kosu9RkeUBmH7kX8nzz3eKGR2ZkBz3+UCPKn8QtnPK6ObqYwmJ7RvpXQToE/Zra9TtTATqYgNIlF0xUCwuij24yF2EFtJCtCQsdxT3eQ2t/mKhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738083950; c=relaxed/simple;
	bh=sQYu9HRv6OYD74HpQAJpotH9ZqSEJWdwz56JUXe6f8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ss3SqF7BvoVhbdj4BWUUCIn3C6QThXKGwhBgCZLhGgP0AK8R4pY3gXKxuftNq8BXn2lrQ6ppuYdaQEylGvYDTqXng6DxUZGOLO/CbsT8H80lM48h+XDcSVRO4CZmKf2A0Aqo6Rg5kAAEntueDhruIxg47z+8jtEMSzp1yBqhA/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Eoc8e8JG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U5sOw2hk; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Eoc8e8JG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U5sOw2hk"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5F96B11400A1;
	Tue, 28 Jan 2025 12:05:47 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 28 Jan 2025 12:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738083947; x=1738170347; bh=WHU+ai9P74
	a2LWyVszfqSfspgz1AgVIRduTMqg1/Msw=; b=Eoc8e8JGFYAykQ8fXmvIxE+as6
	qtsgnatwrzOpQeWVHbLehPJ/jr3TWZS043vV7j1haRTxsYwi/yQffOKSvxScWA2G
	doM+8HpVhZmM79YTidrtcppMsC5aXvjPGsaHhl29Gn0V7ltuVX4cYttGshhfke++
	nKiTbQkGP3TrG8On2o5lC00cAT0kpZAaYgjZFBZFsjWQc3ycB82xHRJ++jvIMrso
	t6bKSQ7hVNobbTZM/duc3Kvwh5eF/FhpU0FMy8Fm08xggW4BhYgU+rJZH6HME+45
	NkaDxxAb+GYW+LAX2D1z4+r4+QXJAsVABB8VBkZHGJIkefGFyAfN9T7WTQpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738083947; x=1738170347; bh=WHU+ai9P74a2LWyVszfqSfspgz1AgVIRduT
	Mqg1/Msw=; b=U5sOw2hkjskPWYEUADSV0/9jayKspirJ9+qo1Qi9l6LQI/QoN3T
	/C1J7kHoNYe4yJOjEynuaZ1GXgzK4F6NzPxwASJ/E6G+kNq+xPW36TJ1MsdlI8rz
	Je6SgjwKmKu8h1h23tQtKFLw3v+AsZuO5PDPcXjLarw9OXjuwyemomPEH5Md8tg/
	gHUHWyOJAg2aOmBm+bJ+6+uOu1hJqLcQ8aCWTmAQ2Bt/rAJoSMxwSQqK/zD2icPc
	Yi3GV+5v+PzGhmTKFx747l/lv1mzaehoTOtQnGDjhKYZCrN96bue23HBjA5kFfHT
	7uTT7363q4bi8AgvEReFBA8DdtXDl0g1Z9A==
X-ME-Sender: <xms:ag6ZZ75qhd2xm2MaBItBMcm2qhhFToazaIp2CdYIrE7NGJIh63WFaw>
    <xme:ag6ZZw5D06KKlpPyV8uBykvZJ2DbO-baFZjaPog8OEpSJ8aNqXF1XtcI-wm8tnnGo
    bRerBruSdYiMLxvQw>
X-ME-Received: <xmr:ag6ZZyd5eg6UaFAzCHtk0Qd952htgFAWWw9XH9y9MUM__zCaQ4r0pi6DkNjZpopha7PiIfvHFOeLAFnFdePBqFzHWexTHgoGk_O->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvthhhohhmshhonhesvg
    gufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:ag6ZZ8IL1vkI8AQtAyCoQaNkWJaKX3Pf3cQMu9jRq3bS5JYZkQrd4A>
    <xmx:ag6ZZ_IRz_02Mj6qZZUWjTuLaN1gm2gBJdthZ6gSmovCPCjfcqSGcQ>
    <xmx:ag6ZZ1ysSAMyJBIs1Tux6jibHU5kfldpJlK0qKG7TtOkSQZdkEf4QQ>
    <xmx:ag6ZZ7KcOdB2JGXVr4mAgyTGwJcquQUuS74sIyqnM0i6UXfH7Zn6Tg>
    <xmx:aw6ZZ1hRjbcOAm8q3zBd-QcGAuJMwsXusBIKEVlUJO267sLeOeWNaPF2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 12:05:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org,  Edward
 Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 01/19] reftable/stack: stop using `read_in_full()`
In-Reply-To: <Z5iQH4C2JqazaJUl@pks.im> (Patrick Steinhardt's message of "Tue,
	28 Jan 2025 09:06:55 +0100")
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
	<20250127-pks-reftable-drop-git-compat-util-v1-1-6e280a564877@pks.im>
	<u7hbqd6at3owgka4pitd4vgzc5emgipnx3w4dat5ofpiv5hxxo@lbfj36uhqtsr>
	<Z5iQH4C2JqazaJUl@pks.im>
Date: Tue, 28 Jan 2025 09:05:44 -0800
Message-ID: <xmqqsep2oolz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> The cast from off_t -> size_t matches the currect behavior, but is it
>> always safe to do this? In `git-compat-util.h` it looks like we have
>> `xsize_t()` to safely handle these conversions. Since this series is
>> moving away from `git-compat-util.h` should ideally something similar be
>> implemented?
>
> It is safe, because a couple lines further up we check for `size < 0`
> and error out if that is the case. So we know it's a positive integer,
> and thus it can be represented via `size_t`.

Even where off_t (which measures on-disk file in bytes) may be wider
than size_t (which measures in-core piece of memory in bytes)?

>> > +		ssize_t bytes_read = read(fd, buf + total_read, size - total_read);
>> > +		if (bytes_read < 0 && (errno == EAGAIN || errno == EINTR))
>> 
>> The error handling here for EAGAIN doesn't go as far as what `xread()`
>> does via `handle_nonblock()`. In this scenario is that ok?
>
> Yes, because we don't set `O_NONBLOCK` in the reftable library.
>
> I'll note that in the commit message.

Good.  Thanks.
