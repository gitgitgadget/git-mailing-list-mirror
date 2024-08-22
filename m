Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B0D1D173F
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724358666; cv=none; b=LqUaYkdieJyILESoqihKMx41B+xMy0Uqb6Ly3f1fLvCLGTtXfNJ2JMH1j9SbCwQZVtJ25ThBM+4ueyB2Q/CbEeeQB/tScWsYiZBxpW/1p7Vd8tGJnIhwzAUPwCFPnylcCdERb6hYsV53i7FWNMs1c3yqSMSWmY9hFQWBruFkXUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724358666; c=relaxed/simple;
	bh=+BrlaeV8EYETqiTYOU3fjZs/rRRMec+DYdYXvnGmTyU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dGEUmQnUnZ3iB01osmSfy/KogjJFYEtAGDR+vFjDRYpcrso+eG8D4arQyMD1JHv1Wv9gt+fe1nJJFlO1TpHxOuBmamnR4+M0UyRIfk/lnWfGHPe9PFWzIk4DV5MNfaSYrDHMfvXuzDmnZQsLwS2haXLWtcVLI248pkWTAkP4Rz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YneuF4kK; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YneuF4kK"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CDDA130545;
	Thu, 22 Aug 2024 16:31:01 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+BrlaeV8EYETqiTYOU3fjZs/rRRMec+DYdYXvn
	GmTyU=; b=YneuF4kKCHb2D7ck5epL4rrra0Kq6+2KmqXEEa1OpVG+7BYzlr+dn1
	I+jSdLkMhcuCZWwnqLeMdvT7chu0gsCNirNhlXNle2c08o2N2UOPc2ET/5BiTc29
	BvboeG0IIDopg44Yi+Q0L/seZTTkTB7voUsc63hOtH7RsrK9P6XoQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C71EF30544;
	Thu, 22 Aug 2024 16:31:01 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1887030542;
	Thu, 22 Aug 2024 16:31:01 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] send-pack: add new tracing regions for push
In-Reply-To: <jjnfnxuozlsguonviswt23simi4gwqjaetcm7b7wn7kndk6o4t@7p4dedarn6xt>
	(Josh Steadmon's message of "Thu, 22 Aug 2024 13:20:46 -0700")
References: <cover.1723747832.git.steadmon@google.com>
	<d57f258026f941e7bc05de8dac359fc1e2e42bee.1723747832.git.steadmon@google.com>
	<xmqq8qwxsg8w.fsf@gitster.g>
	<jjnfnxuozlsguonviswt23simi4gwqjaetcm7b7wn7kndk6o4t@7p4dedarn6xt>
Date: Thu, 22 Aug 2024 13:30:59 -0700
Message-ID: <xmqq5xrsqozg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 721E481A-60C5-11EF-84B2-9B0F950A682E-77302942!pb-smtp2.pobox.com

Josh Steadmon <steadmon@google.com> writes:

>> ... understandable if there weren't any suitable mechanism to simply log
>> "the control passed at this spot at this time" kind of event in the
>> trace2 subsystem, but I do not think it is the case.
>
> Ack, changed this to a "trace2_printf()" instead. Annoyingly the JSON
> Event trace2 target that we use at $DAYJOB doesn't log these events, but
> I can add another patch to enable that.

Ahh, OK, I was concentrating solely on the producing side, and
forgot to consider that the consuming side may not be prepared for
non enter/leave pair of events.  That's understandable, but if you
are updating the consuming side to be able to do so, that would be
even better.

> Yeah, thanks, this did need to be reworked. I pushed the regions down
> into pack_objects() and receive_status(), which look like the only two
> places we might spend much time.

Sounds good.

This is a tangent, but I doubt we have many users without sideband
support.  In the longer term we may be able to drop the non-sideband
codepath, which would automatically simplify the flow quite a bit
around here.  But that is totally outside of this topic.

Thanks.
