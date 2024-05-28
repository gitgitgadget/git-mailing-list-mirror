Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CBF61FC5
	for <git@vger.kernel.org>; Tue, 28 May 2024 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914514; cv=none; b=iZLJAPTcIyKyAtBNGUMioyXnU4xPDy73KWeFv2rKSY4/YE4RYlLMCUjRO6qsLUJaYRTIOdT75thnX8b8kyBqBIaCh8guYmPNh1dSpWpWX4WfzyrgGeilWtC80sRUWO8gXBGaiUR8QjbhjgEo8g4nIcio153YZAGsK/RvfkNkhYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914514; c=relaxed/simple;
	bh=Hr1Af3bU9JCsBY6XM0qRv4LG4LM9T7QQgTIfc0YYz74=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IHslowVtt8gmmO+8XoEr1ZIMhQwqFhEMMPYy02WfyXd5YMelvwRHTU7NPHxBJjIYjI/RNvjJ1RAGAUxWnLd+NPRIs1/6Dp9SSSxTJHsZ4ssV+uV9sm4SfVrf8ktluo+t7peyjIAUdc7SS33j69GZE6XNMMTfViwSUeyW1dT4qQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=r9tvIfIx; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="r9tvIfIx"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2EBC629129;
	Tue, 28 May 2024 12:41:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Hr1Af3bU9JCsBY6XM0qRv4LG4LM9T7QQgTIfc0
	YYz74=; b=r9tvIfIxKOsxSQ8rgxXVOD9L5JG5rsW4GTrWpGcti5ljduJn/Di+Vm
	DELmNaIYfzB0wsZG5yIud+D2OQ1nH4u61vPTtTbdjhAlRlAPm8ec4D1AbS4XH3jn
	hS3nOUiNC3Jyq/niVNLZb9E3uBhc+x30meFpQ9q6lsHThFCBvCOfk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2729F29127;
	Tue, 28 May 2024 12:41:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 33B4C29125;
	Tue, 28 May 2024 12:41:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,  Achu Luma
 <ach.lumap@gmail.com>,  git@vger.kernel.org,  christian.couder@gmail.com,
  Christian Couder <chriscool@tuxfamily.org>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [Outreachy][PATCH 2/2] Port helper/test-date.c to
 unit-tests/t-date.c
In-Reply-To: <ZlXaDWy0lQA1FM7d@tanuki> (Patrick Steinhardt's message of "Tue,
	28 May 2024 15:20:13 +0200")
References: <20240205162506.1835-1-ach.lumap@gmail.com>
	<20240205162506.1835-2-ach.lumap@gmail.com>
	<tpaamfc3g5mrrbfufyvxi67ja2ko2hiihrptwxkbmdx4qpid3f@7aashrngiscn>
	<xmqqttkquxes.fsf@gitster.g> <ZlXaDWy0lQA1FM7d@tanuki>
Date: Tue, 28 May 2024 09:41:47 -0700
Message-ID: <xmqq7cfd7ut0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2DD41F38-1D11-11EF-9AF3-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> As I was debugging other Windows-specific issues in a VM already, Chris
> asked me to also have a look at this issue. And indeed, most of the
> tests fail deterministically. I also found a fix:
> ...
>     -	setenv("TZ", zone, 1);
>     +	_putenv_s("TZ", zone);
>         tzset();
>      }
>
> I have no idea why that works though, and the fix is of course not
> portable. But with this change, the timezones do get picked up by
> `tzset()` and related date functions as expected.

The header compat/mingw.h already talks about implementing its own
replacement by making gitsetenv() call mingw_putenv().

gitsetenv() emulates setenv() in terms of putenv(), and on Windows
mingw_putenv() is what implements putenv(), so the difference you
are observing is coming from the difference between mingw_putenv()
and _putenv_s(), I would guess.  As the former is isolated within
compat/mingw.c, it would not involve any additional portability
issues to redo the former in terms of the latter, I would imagine.

> I'm quite dumb when it comes to the Windows API, so I don't have much of
> a clue why this works. The documentation also didn't point out anything
> obvious. Dscho, do you happen to have an explanation for this?

Thanks.
