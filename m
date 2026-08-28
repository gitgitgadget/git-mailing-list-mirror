Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7CA35E1A8
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 21:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787953030; cv=none; b=dIhins7GZSo1JnzctVCVjGaQVQWb/S3/Slb+UiZ2Fn8JaQ8HSj/3+cqmnTVRlpLJYq/ivohZ5RqObslRc/8IUAvd9e2xlxG7TPzpao0hzzq3pHUYwkYe4EcsWnZKasy6gJStrA2sG93jtbcVjrkclgBEwm9WValrW6Bzv9pFBo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787953030; c=relaxed/simple;
	bh=9Lqlnh/dOdwKnORazi2MBuNGDAUY4P86xYrwEb/T74A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XYqCuUdTAJSSu0LbGXxiQt9lIk53Xrm1m47COc8PzvUj1nl5AJS/+KZHIMlT3r3uVSzz1s1MSJqf0uJ2v2M9ABWfrZhCtW9JU4pwQuOuco7lWt6EtuHtT1rjb1bo4pJOcK+f+nE6Ur7wDmJHmQSuBQ4Ziry8D5ig3yvgOPq6pO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PhIEq2jL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JQD/aVpe; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PhIEq2jL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JQD/aVpe"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 0DF021D00146;
	Fri, 28 Aug 2026 17:37:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 28 Aug 2026 17:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787953027; x=1788039427; bh=5aOzhUQ0H0
	r/N+yiwS5w/bVWAFmYhloVQP58HSjEDYQ=; b=PhIEq2jLMiXq5uDSogRXsOpczp
	QMKPUcb34vYAJQO0ZwAPf95ERVGkRwN9f24NxZRLNp/QuNJsspK3lni6WX9HRH+P
	BjNPvgQBxxzpcs3K7P2s20pirho1L4ynN+n22xpWSF78KdgDPad46leuABombIQb
	VItim7Ik5rER5YdEEnrWyYP5CmaIua+8zLWbU6J/b0M92Bc1Kjj3a7isQqTLSQ2a
	x1Eec9YFfsYYX3k4gCcoBp4lhcoScy869ZifqutZDvrLBYYt6HaaxGVowmCb5k5y
	jXPycDzcbz8S48ddHDH0eoOSjaAQB8ATLKMEXEpZbU0ti/L+iHj7n7fdguZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787953027; x=1788039427; bh=5aOzhUQ0H0r/N+yiwS5w/bVWAFmYhloVQP5
	8HSjEDYQ=; b=JQD/aVpe0IGu21FTPYYc/YeW6QBw5ZTcApLPnBSIrATchg1lP08
	cBeEhB5+MvRvy4g214MoI85YN6QcN3+CPSq8C50ad36/8U6M74rvnAc4K0/+7f+w
	FwkiNAJWcF7uIT81EqtHwPUZMZKF5XQKp1TJn4gAfuVankJagnIpDPIP/VoqVxEc
	UXjtfyq4wvgg9GGIOSCQkTRJIuu9S6/StvelKd/RbirJuV8SP4mmyy/5cTDMI48N
	hETQonXzo9zGLJnwY0TjS0jhDtWbTKFagTV/2iCdNAt6ufpV1jcpO/Phdt9esCDV
	Wl4UIQ1+8rOQMCQNMbldQ1DRzFeXDsOgNsw==
X-ME-Sender: <xms:g_-RahVkv1yURaFbQO3-OEwNgpmCea0s4IN5lJBhY779QdgjxljAhQ>
    <xme:g_-RalS8NeIJV8For4P-IcRIXtNihbbmUIxT7XHS2X2rxpNoJwbCbzmxwvEU2bksD
    tqqvYl-VvI4HKRaAMbYSSYJJizhxMkgUAfPhI4TUt4_KNZp9IT7pQ>
X-ME-Received: <xmr:g_-RanMCSFYr8LrOkiwLm2tX9D4vrbLjJZGJqtKmdfjQ0wb9DyiGRIcHybFgBkeKG4mo90R9a_KWH0iaXdpa-vUyBxm8Sag5Kw>
X-ME-Proxy-Cause: dmFkZTFLYnayFBhF6MF7ysrKYjJdUjdFv9TDLntLk+VKBmgs3wiwLmVdyifoe/eq8TPz4r
    3bUrLETGVa1C/o/Nf3nHBzsWeXKlNT0iyoKmJqqv+qxCOcK09gAcAuu9zkxs5vaxKK8q/v
    2Wp5dTOJe3Jw8l8dJaYbpwoD9G7kS7fdV/5xzt1BTUVWj85SAbhBzof1J0FBmrO0FvS5Mv
    wZteOAPIZkBIL0Ck4soJst+0NDkNFabw78cKc6KjEVzpxtOMAPsuWckRQDw+2uyaTgIrLr
    AdtLmlI+2ogTMaciH4vumRObhuYzyORVKJnRYb58OjW3E3Jf0qX5wKiYm92yR+0qPoPImT
    mpOBjZ3Erb/0k7bNtLliS6Pz0gBDDmHwTRUU47fG4rU3/yVLvCRAPpukDb9CAUAEyjCCNj
    kiJNL9JdZqPXD4uJg8fvFhs1BTr98g1zOSKmmdjyG3LwdzuA67gB15Pio/8lap7BSqhXXt
    Nsms7RoUKYHBTjY1NhyFcRtyI2opmRbaD7fsylpGYdVl813uaLhRHJbNO7dt7f67AfKnxm
    nfdSaX1C0cNIVoP0Xg21r1cPHC2TImI+E0rr/ZHLiqcTgVYASZmLn62slwPqyItHGBrvtQ
    YFRusNfHGGfWp9N1YZSe8uQrILtsR1CumLIyRjpOcGvMNylVpR/QBxmn69HA
X-ME-Proxy: <xmx:g_-RarTMzU7vFQU6Xy9NfTiSTuG3r950eSlepxvUfwTu5KZdM84Tvw>
    <xmx:g_-Rativ76dWV9XtICarymO41nIhTm76HfL7OH0zhM1hLn3MXOd8zQ>
    <xmx:g_-Ras8NWtNr6Sowqv0bZWE45pDxjhuUe56gV_GFjwgDxbMIYdWhwQ>
    <xmx:g_-RasFRnDB0I5LuFd0frUFWSugJIQxJLZPdUxBZDbhPDkQAQkS7qw>
    <xmx:g_-Rat6HNiZoo9x0orBM0h13hNCJIkoZ7ftc6J6FJVlryu--XGtHyzrg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 17:37:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Diogo Castro via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Thomas Haller <thaller@redhat.com>,  Jeff King
 <peff@peff.net>,  Diogo Castro <dc@diogocastro.com>
Subject: Re: [PATCH] dir: fix negative pathspecs in 'git ls-files' and 'git
 add'
In-Reply-To: <pull.2391.git.git.1787949348110.gitgitgadget@gmail.com> (Diogo
	Castro via GitGitGadget's message of "Fri, 28 Aug 2026 20:35:48
	+0000")
References: <pull.2391.git.git.1787949348110.gitgitgadget@gmail.com>
Date: Fri, 28 Aug 2026 14:37:06 -0700
Message-ID: <xmqqwlta2agt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Diogo Castro via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Diogo Castro <dc@diogocastro.com>
>
> `git ls-files` calls `common_prefix()` / `get_common_prefix_len()` which
> calculate the length of the common prefix of all *positive* pathspecs,
> `max_prefix_len`.
> ...
> Solution: in `do_match_pathspec()`, only strip the prefix when handling
> positive pathspecs, not when handling negative pathspecs.

Hmph, if the command line were

	git ls-files -- a/b/c a/b/d !a/b/

shouldn't we strip a/b/ from all three?  Would it make sense to
leave the negative one relative to the full tree?  I am wondering
if the solution is to compute common prefix across both positive and
negative ones instead.
