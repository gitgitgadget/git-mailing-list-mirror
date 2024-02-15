Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325FC135A40
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021170; cv=none; b=Z25WVUwYNVLEhgYiH/aWMplHye7zobiGQDN4JgJw1h9jIZksgPzi6r3cbdBQatm0hOwRX6vtT6+uFG0wace2iV0TRTXdIlWDxMtTIBmpi/0o6XnVPKFxrgP/TockSXnq7Zos+/1GwwDVzOQlzS3J/J552z8iwUZ/RpLRnBXaWkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021170; c=relaxed/simple;
	bh=kyOgSpU/x9N6fv39N6LG0uSXICxufgLkxqgGHUGt/fQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V9957KNH/eb1PdyCVzts/L8kYz9kAHIhcmwriP1+indRJ4Op6p7DycH1t1akuphZ24tfuc8+duX3x1y9GA0q8EvwkgiGK5stSVvU3nioWwfnFPk38cYOvFBKdeJLBF+ZdsL5CuT+IdwpuSHmPk76f0rC+lM5AB2ImTUVE5jg/vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uhxqvKbj; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uhxqvKbj"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BCEFF1DE765;
	Thu, 15 Feb 2024 13:19:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kyOgSpU/x9N6fv39N6LG0uSXICxufgLkxqgGHU
	Gt/fQ=; b=uhxqvKbjfr4/wdTqXtHEIVBrS0sZBphxIhaOBrbyK+ACsUEbypprEt
	szmg4CTP7moGjxeIZZJ/J2JtWoarg18DDTvjA0NMTytewF4nqoQLEuEgp/y63/DN
	ON1dUeWdJRabxye7Kv9DDFfC661cmebvX6oePMCHYllteXFwPUs5M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B50361DE764;
	Thu, 15 Feb 2024 13:19:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2005B1DE763;
	Thu, 15 Feb 2024 13:19:27 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 2/7] t0410: convert tests to use DEFAULT_REPO_FORMAT
 prereq
In-Reply-To: <2dd87f3126cedd39cb5b113053c90ee35ae0e5ff.1707985173.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 15 Feb 2024 09:25:34 +0100")
References: <cover.1707463221.git.ps@pks.im> <cover.1707985173.git.ps@pks.im>
	<2dd87f3126cedd39cb5b113053c90ee35ae0e5ff.1707985173.git.ps@pks.im>
Date: Thu, 15 Feb 2024 10:19:25 -0800
Message-ID: <xmqq34ttsi8i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C0E007E4-CC2E-11EE-BA92-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> We have recently introduced a new DEFAULT_REPO_FORMAT prerequisite.
> Despite capturing the intent more directly, it also has the added
> benefit that it can easily be extended in the future in case we add new
> repository extensions. Adapt the tests to use it.

That is a good explanation.  Instead of lifting the prerequisite and
forcing version 0 altogether, we can move by one step (I am puzzled
by "despite" though).

As I said in a separate message, as long as we make sure somebody
will test with version 0, we do not mind if other people test with
higher versions, so in that sense, the patch in v1 may be closer to
what we want to have in the longer term (but we need to figure out
how we "make sure somebody will test with version 0" first).

Thanks, will queue.

> -test_expect_success SHA1,REFFILES 'convert to partial clone with noop extension' '
> +test_expect_success DEFAULT_REPO_FORMAT 'convert to partial clone with noop extension' '
>  	rm -fr server client &&
>  	test_create_repo server &&
>  	test_commit -C server my_commit 1 &&
> @@ -60,7 +60,7 @@ test_expect_success SHA1,REFFILES 'convert to partial clone with noop extension'
>  	git -C client fetch --unshallow --filter="blob:none"
>  '
>  
> -test_expect_success SHA1,REFFILES 'converting to partial clone fails with unrecognized extension' '
> +test_expect_success DEFAULT_REPO_FORMAT 'converting to partial clone fails with unrecognized extension' '
>  	rm -fr server client &&
>  	test_create_repo server &&
>  	test_commit -C server my_commit 1 &&
