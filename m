Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B36B34B434
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690485; cv=none; b=Rm4qBtGCCcxEoAiGA4OaVsyZmDSgc3eeHCGBKyCu2LmzOp/6nmChN7Y1eJ0m7EqeFbd7UkQ3FTWQLX6zEykthITerFD/Bu6q8d1ZXtGUlvyij0umgZrBR7MiEvvW0DTE5L8vxBORPoA4KdI6H20lbd+PW/ZoqSUJlmmIdTgP6z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690485; c=relaxed/simple;
	bh=Z/wSaydcQ3xrM63Ph/YYPTqWwNJshSJmtwZJ+8iMjRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nFRblOWkgJWGfz6c1WpLmVA5L3KV8KPk9o5U39uSKX5WmQji3qk8migpwOJyFla0TF6sPrkMgySbaTVEaRYBcx+8hdZoELi01hMcCMsqu4w3JVhCy6OcZA9wNSEzxmIQytanv/uD4G4OKmFkzl/ifxjNDdgGjBMJbkOCwu7h5zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DvwZd+UB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A5fI6x7x; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DvwZd+UB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A5fI6x7x"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CC00A7A02B6;
	Mon, 16 Mar 2026 15:48:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 16 Mar 2026 15:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773690483; x=1773776883; bh=fSrfKMwATA
	8nLjqagLczJRQYID7Ue0uxl9ZgFPR4wak=; b=DvwZd+UBTJq4tbUH8eFCtSs0V8
	DnocAbhDPdmTVOWW558UwQNYK9RMQ5yaZuMSxM3jpg/LbmGp2nWCaeun7t7GvgWu
	WLv5ToEM1AaJvfLuAa2k1QZPsccN8jQ6dcDDF8G91f5FpDQ9oKu0o6FtrPlOBP2W
	KjCLudXPiOh2q6MWOVS7UG6qBv52ukt4zuC1TNxBX/LazvUtiA3ZMZ56cIYYLemv
	vyThEp4+OLREzGUZgUuCGgPlSSsps11FXw13vq+8jxnz/+7eVIjDCD//XUDrQK6Z
	prTB/hHiVlS2chO+bfOU4j9ynRnnP1sKp+u1xfe5HpsTTPzVlVRB92jBy/rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773690483; x=1773776883; bh=fSrfKMwATA8nLjqagLczJRQYID7Ue0uxl9Z
	gFPR4wak=; b=A5fI6x7xLrX18C4KkcSebqkQZ7U/MBdiNcfRcZZ8kLiKRhZ4Ukt
	4eK18SmCBlvaQVtE5uczYSwuYHWm3skYvCJvalo3BCZrSyoPWanx2xFD/4dvX6Wz
	XcMNA9bMsv1zuxpsunkNOd9yxuf2vHlr8pgDvqkb60135hijKm8J4ThAuDKDUqA/
	YOuYZLQSM+EOdGfCBZaCtATcqDzeSCoz5xDzRoffmfk2u9byjuYFKMx0thmHewgb
	tquyLLlMGS0sx8TLIdPr9gCJC9jDjiN3MGXFW1SIWvTnF5PwJtIHJv/9ubkZ2beK
	H7V++8W0iYB73by5hv7YFmBnEJ6ZqFh8oIA==
X-ME-Sender: <xms:c164aSidVUMBxZVzZErd4ZGXmBoiuaoMyqjc0EP6JWauS8CiCrc8yQ>
    <xme:c164aafRV9mLSxv8VgbAMH39gZmZ2Iflx3pHEf37CMwoGR5fuBtgcjd6az0Gg2xI0
    Fdro2lV2eu51RjZLEjmW0kefk63VVroxPEZ4kPW3qAah5tx0-0HsQ>
X-ME-Received: <xmr:c164aXdWMr1K1rJsLfS-z6farhS0bbBiMv0UljUcxj9t8zKPAdMpiWEL56rR0_pwhOu3irxLsPjJcoQW7RZInXMXJ4wQ4xKfBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleelvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:c164aU8-nJhYAaCXlWwJI6GvKLEd8xlr-V1QrFS0XTGMl0hNOqbSQA>
    <xmx:c164aTn9trdqePi0y7Eu5ZNx_6wOTHNR1NugBamZTTp-Lo2gUe0Qzg>
    <xmx:c164aW-IiIlIB-mhc5uOKV2w3TP0uaX4TrgMGXoftPgnK7jqYkPIeQ>
    <xmx:c164aRnb3K8uTpSoOMfAR7BIvIvfWTWfiLpI-VTskJJrCSF1u7u1rw>
    <xmx:c164aaoPbH7WTfPIP2AYEJxSC5qBCIm2IXtiZ7FPl5R9saQROtV7etWj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 15:48:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] t0008: improve test cleanup to fix failing test
In-Reply-To: <20260316011544.13825-1-mroik@delayed.space> (Mirko Faina's
	message of "Mon, 16 Mar 2026 02:15:42 +0100")
References: <20260315034851.2261530-1-mroik@delayed.space>
	<20260316011544.13825-1-mroik@delayed.space>
Date: Mon, 16 Mar 2026 12:48:00 -0700
Message-ID: <xmqqms07o8sv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> The "large exclude file ignored in tree" test fails. This is due to an
> additional warning message that is generated in the test. "warning:
> unable to access 'subdir/.gitignore': Too many levels of symbolic
> links", the extra warning that is not supposed to be there, happens
> because of some leftover files left by previous tests.

Correctly diagnosed and clearly written.  Very much appreciated.

Will queue.  Thanks.
