Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DCE341065
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199836; cv=none; b=B34oZYnmXKmEVabMLMuK7TXkLhgx2E5IohYkzwxCV/f6QLzqIh85qEOFkk0leB3IdV1GvzCrPIoB92pSpuruhQx9IufK3YOl9ZkxmZsyvHKAS5s4GrSzDHr3jbkBZqljdt5JGVaGKu/eiyTfHCfDxNzdVAWZKOJSnkuKBUrtwbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199836; c=relaxed/simple;
	bh=Vk2koJrHPm2Q8KOd3J+3bbcoyxEI9bXhkMt6tg5Na6k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=olvtlTuxFQzXsQXBokZh8mtx0hg7olTKmj417hraWwOSg5ERRIUIxLB4D4UB+jBPzS9ac22dyekl6raChjy6NPw1VVawEGIXnITgu4M/0Aso7vED/aIhRFUmK9l9h+kobTVNHOJYL/33LAKZ7NXoPiFuTnPi7Xz78vBtHBhWdAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OuLHPzu/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CO5nf/YA; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OuLHPzu/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CO5nf/YA"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 60F281400062;
	Thu, 11 Jun 2026 13:43:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 11 Jun 2026 13:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781199834; x=1781286234; bh=usG+YAILYP
	W/oNrIiJbQOsom1xtzKnqmPCIHXkToDQI=; b=OuLHPzu/6ygwtAD8YOK7U99SvA
	01XPV3DYGjzCOT7nN1XzP7PR2DrejvuclY0dB8LnQ9LE94kHINLvpTQSeQXw2T9e
	BFUhwV/iOFquRsKtlneGcThsNor4E+k0N9uKqj29Y3qTgPZgLJARuphdcfHwJ0lP
	IQTUON0Q/S8kCjm3+XU1n6e+nL4+oZfJExk/WhJOOOMVoO61ONmzDBKU7yAA0Ex4
	HkLM1DDnOqQCvJWq55ol8YD4WZ6753Ad17LjkbRk/95re++D3xGbr03PuOGJz9SZ
	nkubhmCayAuxEoIfXzCQoX75H+FBXsONbmcrnp+TJe48rHaKTmPdOFRWXdbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781199834; x=1781286234; bh=usG+YAILYPW/oNrIiJbQOsom1xtzKnqmPCI
	HXkToDQI=; b=CO5nf/YAVjz5E6t9wSkMMzC63boupABTjexalSBq0/QF/1O9Nxw
	jrzXcEsRTlpkBz57cZ7IedJp8gh4KXVtoBwtx1FR5EGGVEwLT/tSij4o2NVpRKTq
	P7b5aefDvV5XxoXCzh4kSx/03VEPZye13XupT17H+nEnJq8t+yvxe14JHMQ6HXBv
	PeN6VHjR+7eFcnZsTup/J1/g2hs2CYIcNet+q9FlDUZE+dkL2EkZLk6JIXs7flmI
	vEoLq+Ami5cJ9ZW463hlsosVuI2CFr6NWY570YYf/mo1UP9UL8XRF2hnVk4EqIYB
	py8pe1s/fXcHaUZa9QY5NGW3fIA4p5avJaA==
X-ME-Sender: <xms:2vMqaqv841oIlX55tIRV7qWuxDuSv-PVnvOcmEpAgik15CKmWN8wHA>
    <xme:2vMqamf35iJFQUVHYJx75kjpIj5dqKG-EuYK1jQ-nmZcv4vWstRcrve9efjTd0cOV
    Tiih8_EHJnXdnXORUg04lXZudx1_XI7WcOdV4b41pav2mRalRYZ_Q>
X-ME-Received: <xmr:2vMqaqzuezEk4HjJWM3ME8VQSyZYK2df3n-tKVQ0CQLNND3ME7RkuXq5xHLxxuQ8qpXrO0LZ66tSND2mBSqhDQnMyjD2FyN2TR1P>
X-ME-Proxy-Cause: dmFkZTGqdO7JP2I/vNFzQWqtS41heA4NHNS1c3RwqNFyc4d7lC/1knfgBHlKkn414cblzk
    NTgiTom5GxIc3LDifbfiqaeGfHPjPjO15jpNLBU0q2YI/wzq78JjhipMErVh2JUAzJnz8k
    n5PDk4datFKmkMHxUD+miC09t96EkNE6dXNoLGXmA35UufOyurZ9Pnb5Y6pc+8SY4imkhr
    ktCqQksD96X1oUWJ66K7L3tJwLsoEElkO18UXHgBCvckN4L/xqRPwGZHyZsTlUqONMy0dT
    BETZlvFWNWTnbrk/h1ewLSg4t2zlN7Ob4qPlhiffWqCIgYyB2ISGcP1XJ0NS6tbn6y2uM3
    HumUpFPiHkaIFc/rZPt+IOwW5H2daACsSNduXdCqeee6eb4RXoCHnGnIM+tgW9kS9O7Hmf
    gPgxmj0xephv4QdJGduRKrQw2zAhooyyd/dhaoj0Z4qzsNz2aiFBrb8xrPLcjeuT1NFX/N
    5zrMivtp+vsIPyPb/kOE6S2rrCGBTzpTM7Eay1wjOeDzjOkoA0QHAc/RG+ZsA2RrTlkdAA
    FrHmCjYJxPOoTqzrfS4M6G9prKCpIxlrQqDi778IdttDRdw0hqq2uNVgThN+U+SKWfS1pO
    K0NE2M/JQaVucSL8i1pv/o8ShDnbyDfFomn4I+09PAPUXUKegfcKf8cB4vYQ
X-ME-Proxy: <xmx:2vMqakE143Hzu4tk-9Jh-cQ4W9OlN8OAi2r2U0k7_x0qRX4bfWFhcw>
    <xmx:2vMqamxIw8K_eDSSmsWQ-N8lat1RS-DJ41ug-SlwvXtnR3AJJ0Aq3Q>
    <xmx:2vMqatsrXRqLFSlc6Aw7KRL8OevhYRV3c9esBi_0HsobtZX8FaklFA>
    <xmx:2vMqar2B4c4sgj44Y--vbZa3nLeXWEJq_kZ3ZRUx8ZLrPTeKpe4DjQ>
    <xmx:2vMqamsuwVBC22eW8sNwk8mKFaAr-gjNHnWkG5QYsrvSU1Vx7Oq4N4kB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 13:43:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Git <git@vger.kernel.org>
Subject: Re: git-diff in a worktree is an order of magnitude slower?
In-Reply-To: <20260611085526.GL2191159@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 11 Jun 2026 04:55:26 -0400")
References: <CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEuPUh-yoeK9TseQ@mail.gmail.com>
	<20260609001134.GD358144@coredump.intra.peff.net>
	<CALnO6CD+3sE1xQUnRsCFfWrZTsq2Edw7BWseLzasgT3dgtaq_Q@mail.gmail.com>
	<20260611085526.GL2191159@coredump.intra.peff.net>
Date: Thu, 11 Jun 2026 10:43:52 -0700
Message-ID: <xmqqbjdhnfaf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I guess the distinction goes back to c06ff4908b (Record ns-timestamps if
> possible, but do not use it without USE_NSEC, 2009-03-04), which details
> some reasons you might not want USE_NSEC. Feels like it ought to be a
> run-time config, though, and maybe even something that gets auto-probed
> by git-init.

I thought for a bit but didn't think of a clean way to auto-probe if
a filesystem loses nanosecond-precision part of .st_Xtime when
"metadata is flushed and later read back in" with reasonable
overhead.  I do not think we want to trigger system-wide sync and/or
dropping of buffer cache ;-)

> Definitely not an area I have looked at much, though, nor thought hard
> about. So there might be gotchas. :)
>
> -Peff
