Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1DD3CF207
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052647; cv=none; b=UmYW9K6qCyRnZfUF437WZKp6k5NsF5f9TspFgx3mDF1DS3D60VtU9IfjV4d3ykmyVZb/R9Kr5/oebxWOqUTw2fqpgRR2EsEZaEXXvzyrKYnDXZD5vOoAf3m29GtrOUBthg9oyI4WX3PXl/36mggmQAyOwN/5RPOwLE+BuukVw/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052647; c=relaxed/simple;
	bh=kd+UXivXCNsdWrGwiS15ofn85M9Fo//TPJHIedGXpJc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bw3Vr7nG2PSSjDvewF9y3mi/Y7KJyGJNJfiifuxzPFoHEqxZux/xRBbzznjcO5P2d+AmD4b8pj1DwiVGYFfXbyooyC6gQiABmGYsM0Mb73t2JQHw341qOYj0ajbom/pnkoe5IQsr+Smzm8H+elV5SZSdvcusdTCCil16vIzexWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UFZ3TJWs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YN5YlGU7; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UFZ3TJWs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YN5YlGU7"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 888131400045;
	Tue, 14 Jul 2026 14:10:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 14 Jul 2026 14:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784052645; x=1784139045; bh=fcrzmUjiR+
	GJK4NDR4r6jF3+/mCAPceYk8eKJwKFf8E=; b=UFZ3TJWsCuQ7KR96U0zbqzvNES
	QDXeLArjjEfxmOGTvbe3yO9kRj/zPMCzkbGCWJFa7vp1KUQviPaUa4XMg/6WUhIP
	zGSM35Aqxvk52QRHqz9dex+Ld5m2alRCgZCSFUtY351MJu56qq9HTty5Tares+f0
	H6gZUfuwA6icbqnGg7uvce2/NFE+wQmjUzEklWDPzrQNSAyHu6XioTYD4MYmrPsi
	/z06YcmwrGdeN+n23wFtFW0fxkscLCcG8+tyryYoxHzRb8eW0a1tydI2xuVXjMDC
	Chjg5TUn5/tYi/Xd4iciZ0Kqyo4GdQ6j+PJ1nvALY5l1XrjrbvkUvKVAVJhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784052645; x=1784139045; bh=fcrzmUjiR+GJK4NDR4r6jF3+/mCAPceYk8e
	KJwKFf8E=; b=YN5YlGU7//c4WqXp1Es8jbsBOY180caH3pHJAOnzAECpvw9pDDd
	4z28cMbhplHfMKu02uJxfNoYGykwaVqUKasLzIfqONriZ058i9ToyHy2odRlkJNR
	gzDcR5vJcPhn9SFTnKZea985z5HbVuWQDdyiyYe70ZSKyamLwvNB5blP9aNMQKXY
	m8UxZ3Wq38ODpsp/EHewn+CITsNCwVvU4X49OfqJOI876dVqb4IZujpvWU4i1RRI
	LfbZEV/hEVPMOoM7oAnuJdZI/FHguCUiGKUdzakZwZwpX4TtU11uyINcFFC1j9OS
	y7GJZJ9TrJurq72c2M3+Xgq44dKuhcrQpkQ==
X-ME-Sender: <xms:pXtWauvp4neQYyWSbLHIbE24S860lgfIkfeucatpZddk6bhDwHwUVQ>
    <xme:pXtWamCbHovrJ6ZhL2vy325Kt_FFf_ENitQjUYpwkpCAo6I_WLImorgxYNzZtOtr6
    gHqvv4WtkU-Iy_HvRbVsrhiGgdIL7_XyUAUaN1aXyLpRKpuxPUGJA>
X-ME-Received: <xmr:pXtWatY8Pr_-VKhH5OoU3JHP3lzeF402IovmFtP6uy_tUYKU77QU9emILlmGXDPKP__I38Tb7lCn9-CGzI0TOHS02Y7Jo8SZ0JSJP-Y>
X-ME-Proxy-Cause: dmFkZTGOXhzcjXuOajg7x3zgdsf+MYOq36uoYJOoS3+CWDG4s78HTIhXIHySKAwnsKAL+w
    Lex2I4zDTievT0aeDF06RVVuTp6zu66rXuOLzbDk8DI+mpZr2j8Hu/KX0jEDKreTbtrIh9
    4lPQU2gXc8zFh8dHq/LOqNt5joJSi3gR1XffTo7vJCKpHksq8L5A3H7mwoj8z55CzwFCZg
    YzrVS03J+50OW6u7IaPle9SZCBZZQhd8wpGUqX68PTt/bjG3D38QzG/J9HI1SQeXuzJeSH
    xwLyFlfaN0mgY1dcFnyiEktCbWqrCrPcl6nrek8JtN4HuK6sFDwt/Y+Vs2bfDbQ04FRULy
    cXGcsvdObri91vBxWrbK0FaOVEcEYAKmfQIQNBPuYu0q2sYo/ldY9uuycQ3K9xL/s0RCCi
    pI2kHD+zNMuGCS7E/+/Xz9zPZtr8M/7TAxqEEV+oFoUhcmZLeTAPpZM335ZoMqmqt3uDEI
    u5KarGDRpuA9YxOm3ybw8wz+a6d0g+nlkcuaNU13hYnFcwY68b1homYuvVRS3j7ThYwbYU
    6UnixOw2MGLsfHAaxXoQjxMbJNVEqJVTkfDZuW/q1t+pElofwh5afNpqrgPvKRb7syuYWw
    tZ1RgWQOzXZmTCXnWZvD2aHGDHrZXWpefqFkTe+LeCU6OytO0l5zaTptVv2Q
X-ME-Proxy: <xmx:pXtWapXg_A7MwsaGaxje41LXClWp1yLkL0C538j-NSpQe5G4jAAEZg>
    <xmx:pXtWakOtTVR8jr26IRrgi-OU-fj_oKnl8_1aQB0uDOdZXaM2QXKMog>
    <xmx:pXtWaratIpTOffsvVpyIawc8KE3Lc1bqbzYWanfwt57_hHxW_pVFnA>
    <xmx:pXtWar92pPteA5BgTeVG0PD5gxIUk5wK7-_kzZTCkOE0tFk3IWd9Kg>
    <xmx:pXtWaugUCGTbwp1iAV8pHaaA56ESO9_IOwjp4bZAUWKrjARfmxbqd3DV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 14:10:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Ted Nyman <tnyman@openai.com>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH 1/2] http: use unique tempfiles for packfile URI downloads
In-Reply-To: <20260714052833.GA2516582@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 14 Jul 2026 01:28:33 -0400")
References: <cover.1783982021.git.tnyman@openai.com>
	<alVn-QmK3K91_tkH@com-76773> <xmqqse5mv10a.fsf@gitster.g>
	<alWXwAGWgXSXoRJv@com-76773>
	<20260714052833.GA2516582@coredump.intra.peff.net>
Date: Tue, 14 Jul 2026 11:10:43 -0700
Message-ID: <xmqqcxwptpb0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Jul 13, 2026 at 06:58:24PM -0700, Ted Nyman wrote:
>
>> > Are there better ways for these processes to coordinate with each
>> > other? Instead of appending to the file, what if the second process
>> > uses a predictable temporary name (which we already use) to open a
>> > new file with O_CREAT | O_EXCL to avoid this redundant work?
>> 
>> Using the existing pack-<hash>.pack.temp name with O_CREAT | O_EXCL
>> would prevent concurrent writes, but EEXIST alone would not
>> distinguish an in-progress download from one left by an earlier
>> failed or interrupted invocation. The existing .pack.temp name is not
>> covered by the tmp_* pruning path, so simply waiting for it to
>> disappear could leave a fetch stuck after a crash.
>
> A few thoughts:
>
>   - Using O_EXCL makes this essentially a lockfile. So we could apply
>     the logic used elsewhere for lockfiles, like auto-removing files
>     with ancient mtimes. Or we could even go all-in with a pid check for
>     liveness; most of Git's lockfiles don't do that, but at least one
>     does (the background auto-gc lock).
>
>   - If we're not already using a name which is auto-cleaned during
>     maintenance, we probably ought to be. Leaving aside concurrency
>     issues, nobody would ever clean up the on-disk cruft.
>
>     But of course the original code here is intentionally _not_ using a
>     name we'd clean up, because it wants to be able to resume an
>     interrupted transfer.  And you're explicitly breaking that for the
>     packfile URI case.
>
>     Is that a cost we're OK with paying? Fixing it opens up that same
>     coordination can of worms. You have to tell the difference a
>     concurrent writer and a previous dead one (whose work you can
>     resume).
>
>     It does feel weird that we'd do one thing for dumb-http and another
>     for packfile URIs. Wouldn't they suffer from the same concurrency
>     and resumption problems?
> ...
>
> If we're OK with killing the ability to resume, then yeah, I think it
> would make sense to start simple and un-break things. And then put a
> coordination layer on top later (or never if nobody cares enough).

I share that sentiment.  I am not entirely convinced by Ted's
response, since a major goal of the packfile URI feature, as I
understand it, is to allow the use of resumable protocols for
large transfers.  The proposed change deliberately closes the
door on resuming interrupted transfers, whether manually or,
with additional code in the future, automatically.
