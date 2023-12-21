Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA8677F05
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 22:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JvjKuadW"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D55C38AD3;
	Thu, 21 Dec 2023 17:05:01 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vYKCCExN2dsvIZCXsoPK8wqV6OySdg99YIhuOX
	c69dU=; b=JvjKuadWCwd+XN4mMCLPqyD8OxKz7nwPKcIaGkscuSCQZhoAdgt0Z3
	kXCZPM93xyOqtnubXNvc9gqtme55McYSn34cI1RGfaKRO/69/JqziyfyN9jecz2O
	N9XDCpHxpYrh1UUzscfX8zDQwUIKLrou8m+qvx3RVWM9S9RbTLO1M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 163F038AD2;
	Thu, 21 Dec 2023 17:05:01 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ABC8338AD1;
	Thu, 21 Dec 2023 17:04:57 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Josh Steadmon <steadmon@google.com>,  git@vger.kernel.org
Subject: Re: [PATCH/RFC] sparse-checkout: take care of "--end-of-options" in
 set/add
In-Reply-To: <20231221214550.GD1446091@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 21 Dec 2023 16:45:50 -0500")
References: <xmqqbkakqx6s.fsf@gitster.g> <ZYN-5H-2NNoRRpf-@google.com>
	<xmqqplz0p90k.fsf@gitster.g>
	<20231221084011.GB545870@coredump.intra.peff.net>
	<xmqqsf3vmqug.fsf@gitster.g>
	<20231221214550.GD1446091@coredump.intra.peff.net>
Date: Thu, 21 Dec 2023 14:04:56 -0800
Message-ID: <xmqqle9njjp3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FA96DD22-A04C-11EE-846C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> Right, that is the "gotcha" I mentioned in my other email. Though that
> is the way it has behaved historically, my argument is that users are
> unreasonable to expect it to work:
>
>   1. It is not consistent with the rest of Git commands.
>
>   2. It is inconsistent with respect to existing options (and is an
>      accident waiting to happen when new options are added).
>
> So I'd consider it a bug-fix.

So the counter-proposal here is just to drop KEEP_UNKNOWN_OPT and
deliberately break them^W^W^Wrealign their expectations?

I do not have much stake in sparse-checkout, so I am fine with that
direction.  But I suspect other folks on the list would have users
of their own who would rather loudly complain to them if we broke
them ;-) 

I'll see how bad the fallout would be if we go that route, using the
test modification I made for the previous rounds as yardsticks.

Thanks.
