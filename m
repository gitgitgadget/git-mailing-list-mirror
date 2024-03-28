Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DFF81219
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643749; cv=none; b=OBXUKJ49em/BHYstq/E/kL/pE8kZXjFxKV0ZGa2Hqmu8FyR4M/qOkdSF5c1xHIHYwA/FLrXDCQrofZSz6Ggcj+aCujBD8K8Q5c4TpyLzKji7vS+/FMsu5Zj9x5Rqbd6rpekQvMEWbuufR+ErXOquFOCMq06NeOL9oCOy3ITps8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643749; c=relaxed/simple;
	bh=rVnOTy92DnjqLCVLFEjDdVXHMLlcF9+xqlD0+rBhy2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oqGLgCC6+7s88e+zF/CE5rHz1O4hEM8zFdGOdS/tk83BrRQN8wIDmppZssOuzBGGxu4sTogkVFZXgEGr9RUStfl98/8Ml2HFgz32WCrnH8p9NQ5eWGmbiA987UNjNjuHDEGWlu3RG4OB2F2CRSd6JEZP+P6/mfNtQ2wbceNgvpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OJrhnizQ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OJrhnizQ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 21F5D1DC08B;
	Thu, 28 Mar 2024 12:35:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rVnOTy92DnjqLCVLFEjDdVXHMLlcF9+xqlD0+r
	Bhy2Y=; b=OJrhnizQgS7h0Z1U5aykkRG8WUFD7pjTdoRX1ZW4Rf4DcF2dgCW2LE
	1q9ePDp1war8ZPs542/h41oVM8DD4YGNe4IBZkAoTPxn+eY1rlhm/K9UPaZ1MBP7
	jewz58zglFLsmX6zhiOR33W+H9UoAbTI805oQsLloU8FDnwTJaNVY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A1191DC08A;
	Thu, 28 Mar 2024 12:35:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8543A1DC089;
	Thu, 28 Mar 2024 12:35:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: Achu Luma <ach.lumap@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  Christian Couder <chriscool@tuxfamily.org>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Outreachy][PATCH 2/2] Port helper/test-date.c to
 unit-tests/t-date.c
In-Reply-To: <tpaamfc3g5mrrbfufyvxi67ja2ko2hiihrptwxkbmdx4qpid3f@7aashrngiscn>
	(Ghanshyam Thakkar's message of "Thu, 28 Mar 2024 18:05:59 +0530")
References: <20240205162506.1835-1-ach.lumap@gmail.com>
	<20240205162506.1835-2-ach.lumap@gmail.com>
	<tpaamfc3g5mrrbfufyvxi67ja2ko2hiihrptwxkbmdx4qpid3f@7aashrngiscn>
Date: Thu, 28 Mar 2024 09:35:39 -0700
Message-ID: <xmqqttkquxes.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 36E32F12-ED21-11EE-9348-25B3960A682E-77302942!pb-smtp2.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> I believe the issue might not be related to the setenv function, but rather
> with tzset(). As you can see here[1], when we set TZ before we call the
> unit-testing binaries, the tests which were failing (EST5 ones that I
> separated with t-datetest) pass on 'win test (0)', and the ones which
> were passing (UTC ones, t-date) fail. (Although some tests on linux are also
> failing, but that can be explained by the fact that t-date runs first
> and sets the TZ to UTC, afterwhich t-datetest runs and fails, although
> this is not conclusive). Therefore, I am almost certain that the issue
> is with changing the timezone during runtime on windows and not with setting
> TZ variable with setenv(). CC'ing Johannes to see if he has any insights
> on this.

Interesting.  Sometime before I started working on Git, I learned
that no program did tzset() after it started running to switch
multiple timezones and worked correctly on many different variants
of UNIXes (there were many of them back then), and because I never
got interested in writing a world-clock program, I didn't know, and
kind of surprised to learn that it works on some platforms (like
Linux and macOS) to switch zones with tzset() these days ;-).

So, if Windows runtime is unhappy with the program calling tzset()
more than once, I wouldn't be too surprised.

Thanks.
