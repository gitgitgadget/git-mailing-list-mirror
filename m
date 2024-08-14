Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3511B3F20
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723649315; cv=none; b=UK+DreSfWDf0qE49xc0/cjb3erM/6OlaqiYuFtYmt8zJcGs+rbzZor8uG9ciPJOpTKWUTu7I2Qx3xHw2Bdu0VqPfdVDjR5jkvthZRZPw8dtjZPWHDsmM1svJ2dH3KKzQWsAb023cnZ6WoV1CSdxxK3LC7A2uDjlMmPLl4/oQBP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723649315; c=relaxed/simple;
	bh=ZdffIFdbRTl3xFRXQUB80moeXcrbilHGaNudXRZNsKw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g6J7hTvP8Ug3tHe2vv2LO8lSmTEHQotw283JbYovbv5b7iTxQceucQzzVz43q2oq/b/lVpbRxs7D+0MgaLoOOgzHfaSuaMp4DCn1CBXCbaQ5st7WNRJpM3Z+LNpDFXjnYIheBGbUcW/N4dvA/TUqAAbaTydGVx3sNTkHvbMACp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PT0bF4BQ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PT0bF4BQ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 23BE03FCDD;
	Wed, 14 Aug 2024 11:28:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZdffIFdbRTl3xFRXQUB80moeXcrbilHGaNudXR
	ZNsKw=; b=PT0bF4BQXSOJg5EV6D8cYRyDc/4T2wiYzrYRMAy5AXC2grK9d2T8sN
	1ItkheWLqzvTfFIQzzq3P9k2dNr2rIFIcv4pUaNdZb9mv/5PynWq+WmviBhjhVuE
	gg105YNdbhw+f78PJe0W20LBWKyyhm1xPawnmzZCHJrTq2Q4gYlcI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A8E23FCDC;
	Wed, 14 Aug 2024 11:28:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 70F413FCDB;
	Wed, 14 Aug 2024 11:28:26 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  James Liu <james@jamesliu.io>,  karthik nayak
 <karthik.188@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 22/22] builtin/diff: free symmetric diff members
In-Reply-To: <Zrw6M7wvPFfzv3fO@tanuki> (Patrick Steinhardt's message of "Wed,
	14 Aug 2024 07:01:48 +0200")
References: <cover.1722933642.git.ps@pks.im> <cover.1723540931.git.ps@pks.im>
	<31e38ba4e150c9bc9e3aa1073869881ccba9035e.1723540931.git.ps@pks.im>
	<xmqq1q2s8k56.fsf@gitster.g> <Zrw6M7wvPFfzv3fO@tanuki>
Date: Wed, 14 Aug 2024 08:28:25 -0700
Message-ID: <xmqq1q2r2kfa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D9CE291E-5A51-11EF-BFF5-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Good point. It does make sense for `_free()` functions to handle NULL
> pointers, but doesn't quite for `_release()` ones.

I agree that foo_free() should accept NULL and silently become a
no-op.  I do not care deeply whether foo_release() did the same, or
not, as long as all *_release()s behave the same way.  Maybe it is
more convenient if they ignored NULL, as I have a hunch that feeding
a NULL pointer to foo_release() is unlikely to be a bug.

Since we documented our aspiration to use these (and foo_clear())
consistently, we may #leftoverbits want to also document the calling
convention as well.

>> And symdiff_prepare() at least clears its .skip member to NULL, so
>> this pre-initialization is probably not needed.  If we are preparing
>> ourselves for future changes of the flow in this function (e.g.
>> goto's that jump to the clean-up label from which symdiff_release()
>> is always called, even when we did not call symdiff_prepare() on
>> this thing), this is probably not sufficient to convey that
>> intention (instead I'd use an explicit ".skip = NULL" to say "we
>> might not even call _prepare() but this one is prepared to be passed
>> to _release() even in such a case").
>> 
>> Given that there is no such goto exists, and that _prepare() always
>> sets up the .skip member appropriately, I wonder if we are much
>> better off leaving sdiff uninitialized at the declaration site here.
>> If we add such a goto that bypasses _prepare() in the future, the
>> compiler will notice that we are passing an uninitialized sdiff to
>> _release(), no?
>
> You'd hope it does, but it certainly depends on your compiler flags.
> Various hardening flags for example implicitly initialize variables, and
> I have a feeling that this also causes them to not emit any warnings
> anymore. At least I only spot such warnings in CI.

Yeah, that is a sad fact in the real world X-<.  To be defensive, I
think an explicit "{ .skip = NULL }" or "{ 0 }" would not be too bad
and may even serve as a good reminder for developers who may want to
jump over the call to _prepare() in the future.

The explicit ".skip = NULL" says "we know it is safe to call
_release() with a struct that hasn't gone through _prepare(), as
long as its .skip member is cleared", but the story "{ 0 }" tells us
is not much more than "we clear just like everybody else", and that
is why I suggested the former (iow, I know both mean the same thing
to the C compiler---I just care more about what it tells the human
readers).

Thanks.

