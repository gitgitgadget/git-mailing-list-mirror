Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857718BFA
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515130; cv=none; b=eBuyqzB4FdWePZy1UHenQCF0v0KE4xVn7pvaj9Ns2R7OubdgXe9fSv4+kW8qvxcI2XKXNOun15h10uA4qyoMwhVJJ0OPoLl6QJWB1RfeJGH5hWvVh8Tb/qxHsnwRXh0+uNLmD/qCTrC97oMnOLTkgS738sGQ2kN4fJtxmaQexwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515130; c=relaxed/simple;
	bh=bzfex/5Sxqut3CwndrJkt2eurABwUaOZdNlIYwoG++Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MegT9NNo1/nYF0IXCMvY/kCzVQ35STq7eFIyJI64SYRTZvNxsNGmUEa88Vk9lmjlQVcIbxa5j5Y1bpK/34jumvCvk2JAl0Gzwekkl+APV3iVBGbampw9KfHbfnecT6Joo+Bq49xpMebcmNarRJnDME3Hhjnq2yYQOuMI/BOYmq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=s6UTb99X; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s6UTb99X"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A4FD1C27C;
	Tue,  4 Jun 2024 11:32:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bzfex/5Sxqut3CwndrJkt2eurABwUaOZdNlIYw
	oG++Y=; b=s6UTb99XBUiR0UUnweNZYN6S2hcUy8LSLa5ljfCYORYYWL2WHaymIN
	abv7/aIBtVenCy9mkjFk9R92lvgwtd+TMVNnOk9vAZ6wE6pcgjo2MsnyXF9zfNO4
	/V+f7M4HaYw81wS/d/DIzX7VzeTyjy8KKSLacvVmhTILEqefzIx98=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DBFE1C27B;
	Tue,  4 Jun 2024 11:32:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B2971C27A;
	Tue,  4 Jun 2024 11:32:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,  Dragan
 Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
In-Reply-To: <20240604101700.GA1781455@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 4 Jun 2024 06:17:00 -0400")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
	<b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
	<20240604101700.GA1781455@coredump.intra.peff.net>
Date: Tue, 04 Jun 2024 08:32:04 -0700
Message-ID: <xmqqikyo207f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9979CD02-2287-11EF-B81F-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

>   diff-highlight | less -FX
>
> But after playing with your patch, I realized that:
>
>   - there's no need to pipe through diff-highlight; it already happened
>     as part of interactive.diffFilter!

;-)

>   - since it's triggered manually now, there's no need to add in -FX

I do not know about -X, but yeah, -F is of dubious value in this
particular context.  You explicitly told us that you want to page,
somehow knowing that the hunk needs paging.

> So I am perfectly happy for you to stop where you did. Possibly
> interactive.pipeCommand could be useful in a more general sense, but we
> can wait until somebody encounters that itch.

It makes it sound like if somebody has a use case already we
shouldn't stop here ;-)

The default that colors the output is something we might later
regret.  Those who want colored output can always use the
interactive.diffFilter configuration, but I am not sure if going
the other direction to strip coloring is just as easy.  But other
than that, I think we are at an OK place to stop.

Thanks.


