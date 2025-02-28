Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1B926B2D5
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752147; cv=none; b=BJ2aD/nOJuOgjdfXkmJ1bE+fsd0Gi5oU2bFvz2WqMJme+CQFYD4Z2Y4BMOGEEH/yyiP6ASFFHFSX/mPqHbdJelVmaaIDHF7orT2MmJw1fm2I1J2vPxSu+ThiMk4TloXnvuG3fvDQQy/sejqAR+zGuZEWKEj3LQnMFxbdvcfOIkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752147; c=relaxed/simple;
	bh=7tjVfRM26J8fj+PWtpn6mp/xy5QIyDKMU9VBL4u6bqQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KToQ0q+vKLt4AvTHmo92ZLR2tShzFcXug37lAi+M/iIl57E84MZTpO1kqn/uhWmTHNqN4Mp88DyyxDwd47auvsFKDPOiJEj6TZhdN8o/iYwHGgzCBjF/GkmFrskvNGuUI2AQeZ9AwI7VT6fxpM3ghLAfJOywk8maqsqgvd0IDVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zsjZykNl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eEsdbZYV; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zsjZykNl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eEsdbZYV"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.phl.internal (Postfix) with ESMTP id 8219E13827C9;
	Fri, 28 Feb 2025 09:15:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-13.internal (MEProxy); Fri, 28 Feb 2025 09:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740752144; x=1740838544; bh=Pd4HEvxJ2G
	A47Z7dirjdhMhinooO5NAnakyaj7hFt2E=; b=zsjZykNlhqZdCt2C7CP6voklkh
	+XKVEz09egwlRNW4maxkqBU8Jb7tgKByl32vyYMELv6z8MsS+1bgBEYdmUFQWoiH
	M15Sn/L1LfOHxpsHBH06jl1Q/0JW7XfQ2cUvXc6CT9gOvT11Z8ZgO2UV7N/zbYjp
	ufuT4+1Bw7ZpPYYWYMwlWCA2Ky8pzznBw4dboKGo+dkkaOqndKzDT9znC3kSAoZp
	m1iqkopMfxyVRe23dOSue7NWXSzo4MADU5GVaOSNUIc8qxpOaoE//FUwiW7rPJN4
	ZGl62sGhFuDq1mhYmsVYTjcLPqoBikI/MGY81R4AHVns/dGYw6qnzHf/zaIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740752144; x=1740838544; bh=Pd4HEvxJ2GA47Z7dirjdhMhinooO5NAnaky
	aj7hFt2E=; b=eEsdbZYVx05vJHFoXTeXWdfLS76dQ1Gr7FRosnMzIG+TAEvsRC3
	iZOuw2radaJOqkczfhwCRdYp69TiIzLsUujd3aXrFh5Sr8qxx85lJwBS0kIoeWBj
	O1l+hfRzobvyUdTBo5Ik90ruYsDocCYWpsvX4AKnEjRJoK/fyIb+ZP5VQC8harfu
	GsucFQsKXjtcLalI6QAKZfaaxERQg8+xJJ+29zwXLuMswLyrkxN6gNsP1WnOQjk1
	/E1Aj1Od9U7K7UIKF9ZaNiF/7lVkX0yJeQ4i2Jccd4nLlVQRfLxwxXYRbh7681aJ
	UBiopGIJWgJOFNqvbwCg7bQ8aUqfXIjPbDg==
X-ME-Sender: <xms:EMXBZ81J5N6SOOz4LR6bfGSgMQ8JtzCv8HclTzJAs5dVd7C7-mILVg>
    <xme:EMXBZ3G2cxhpAvEGflYBuFttZRjP4GFZ8a6UqmgCqU5ZZKHyPbrOk_HvJ7fg7EfG5
    9CZxlqdu0W1-zP24w>
X-ME-Received: <xmr:EMXBZ06MuoR7o70lFtBQ1M7zOfLnc39dAY73yXt-w-w-g5uROQ9eHam_z9kslhrQvpFKGMtkkbTC-DS2Mz-DpR7rnZ0BTmwiSn5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesghhruhgsihigrdgvuhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:EMXBZ109R16exnrtgyfAwy53wsGgdp9Ujoq7asSf9J4tPewC98tGHw>
    <xmx:EMXBZ_FydpknVC8qE-bDOPil9301P0IwAzOMseRWwm8KuUs3DTwDBw>
    <xmx:EMXBZ-8SxjcCBlC1y3GsOvodvnhQfp1fUdbPjIgaqWmf05Ozrm-V-Q>
    <xmx:EMXBZ0lbSt1A3Oz2CQcokl3WhszVUcXMAZRwAU8asGVMvph1eAxSkA>
    <xmx:EMXBZziqxpIN1leb_nnherqe58HogWN17knJAYYah7FW-LsNtp6_qKsf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 09:15:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Michael J Gruber <git@grubix.eu>,  git@vger.kernel.org
Subject: Re: [BUG/WIP PATCH] unit-tests: use clean test environment
In-Reply-To: <Z8GVAjwZWOM7c2fR@pks.im> (Patrick Steinhardt's message of "Fri,
	28 Feb 2025 11:50:42 +0100")
References: <e3be6705d103ccbc165d0fd3b9b7c818d14001e9.1740516033.git.git@grubix.eu>
	<Z8GVAjwZWOM7c2fR@pks.im>
Date: Fri, 28 Feb 2025 06:15:42 -0800
Message-ID: <xmqqseny40kx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> This to me is the biggest issue with the chosen approach. It would be
> great if we could find a way to sanitize the environment in the unit
> test executable directly instead of forcing users to run the unit tests
> via the provided script.

True.  What the end-to-end tests do is to have a central place (in
test-lib.sh if I recall correctly) to ensure a sane environment and
have everybody run that before their own code.  In theory we should
be able to do the same in C (otherwise we wouldn't rewriting things
done in scripts to the language ;-)).

> I suspect that most environment variables shouldn't matter (for now), so
> overall the duplication may be acceptable:
>
>   - We need to unset a couple of variables, but we can probably reuse
>     logic `git rev-parse --local-env-vars`.
>
>   - We need to ask Git to not read the configuration, which we can do by
>     setting a couple of envvars. This should be manageable.

"Provide a controlled environment where Git pretends this is the
$HOME and that is the $AUTHOR_NAME and so on" is much more
preferrable than "Tell it not to read", no?

Thanks.
