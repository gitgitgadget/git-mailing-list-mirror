Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1118530AAA9
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 06:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784098079; cv=none; b=ObxiRHQCwtrJq5lZ7MVcMcL1KLCcXVLePU2avVVkW1Z6iyKWHyrMxg9DYNpUIFuyoQFgvBQOgsbFWohxJlEG+GeiNiUNYvcdJfnyyGyhDJ9nyfjnfTFQCnrEublLOYX6rM9RZ20vUATXTIcmxyI4NvGuhSRaAsLN9652CdFajWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784098079; c=relaxed/simple;
	bh=BV8voljbPuT3odczbHiHlXWzqmw9+Pt09c1ZUJyPZQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClV9Lh1sVVZUyZdYEPfD3sbgTuHj7ZPxOT4rfut2MvLn+PVv5uNehvMWe9POqOXpY1X3BkYGbHU8sRFrVGrl1LpigFDj120fuMn3E5D5lMPsI8SRhf+CaEIjTccfJYoXr4kkcPK2IB0wwscDjLCN5rOulAHlMZBOVOm41snI+go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LwbbaWph; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S3u8E+oS; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LwbbaWph";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S3u8E+oS"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 47EB27A0103;
	Wed, 15 Jul 2026 02:47:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 15 Jul 2026 02:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784098077; x=1784184477; bh=yA5YJl+hNd
	9CuB5TQcl29ONZBkH4MeBntYrAqwAKPuw=; b=LwbbaWphvwpJMyu+/9ADBM7wwH
	F9h+jFaotsaWsYN+bwV5Sp+Bp4I7CosgqbsJ7BgG8SBCnrEgEuX9Hr+Vdhr320Q3
	LSesfCljB4h3d6reADig2B9Qa4UVZHqof3cFZKQ/HA4RJ1HbLH/33JKYmoi8P7yB
	swTgqlbOHTtaBcCXTYGBxXgpmNGWxuGCXPpZe8duEUfB8/4pfTw0PeiZrVWwO04B
	UcAclqyCQByvuFdVl2MzQqUN8HxLO4JhxC8xZ70Sl//lhrXrwPb5I9zuKj8tptZ8
	3skQn8FTLCCajHFvc+CzXhcdK0OpcrE22y+6aNC8BDrqKDg6QPWNqPV61Jsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784098077; x=1784184477; bh=yA5YJl+hNd9CuB5TQcl29ONZBkH4MeBntYr
	AqwAKPuw=; b=S3u8E+oSJ25bKmuWhBWorbsNAXpU5SKeNFvZG5bhdGaHPyfhY+A
	ge3R7H9OYme4aKGbcgo5EePS4rohJgc+WO/D9t1sSF8mBASPCph6L2VgdftYjCFR
	LYYUUv417IYqdR/irPlgIlOH9osXKZv6u3vMQpb9ZnURJx/O7TeMn1FDqxg1acCU
	Ax8cf5WIkWZ7RtyrFxDaKbBYC0uRWrbgVVVe6KRvRa6tlUFT0SqlM9NZym4LC6C8
	BA5J6kFmofDHBsmHQqjS2ZvYdiQv/D+zoruVR5gAgueEpaxtfl/qfy7bVjf1dlVp
	7BD8YMI21fUKcp7ZjrE41aYPQTYm7+Uqx7w==
X-ME-Sender: <xms:HS1Xag5fArUyjz5IfDSOJlsDcoyNAOVvwaVWQBAYutSgZSUQIpjNxQ>
    <xme:HS1XapUEI6pNzhiFvU7iznWydosc_7EfcZaAyKdOJnZMfBoNLOZkVokLlsFH049_u
    9TRqbjlQYSL2IWKLnqz8ADJz9CG2jDsc_vvKwk2nYgr1yY2fTxZ>
X-ME-Received: <xmr:HS1Xas3Z4Iq7vYgE9LWt1lfackm4Od_wyDRMOa3BUegfsc8NVXlY7Wo-d3i00Z4WMRgc598zTz-EWnRuSiD0VZcvYWMl0nFT4-Vb1RBH_wk>
X-ME-Proxy-Cause: dmFkZTGlzipJss/0tncU1YoyCRhmMAuzBZuIPjPGjp/9aHbpino5CNwgnVg9t47AMoXilY
    /H2q3rVMU/hZR/4nJB/RztMZrmxoDg87q+pyts0yIurl/XyGXH7vfhaVPVcLmJgwsHmpaT
    TXzisFWrAvu7JSIuPLReO8k8si/rZGisEUkJ+7FAr6FiM15gco9V0d1aJmbC/JSygLrlpX
    8fGmMX077B2tazBkSgk2KB/B3Yg3dbohQdsn6XQkMO4BVXVBCHmQZk0UcuHW5MiCb2fox+
    KCG5RAmyTNvpwxrt2u33KwoftQsDn1Wrg3O1H0qjEZhWIekKS94SyrEQbsQr3YbFqjz2MJ
    smTUtrKyClhuKFGY2GW8pgdiYesh/iua8rguesvKDsfg1sOGuaoNrqnpsfVGxMAmNnGn9l
    vvB+Nc9qY+RFnRhlM3tVi3ea4suXjvyaLAS3l5+vWX62z0FYruo6/iYiO++3rKAQF6zAgg
    DQWJpyBDp8Pcm8jX4AiAF5jSGKivCMXyF9Zy8WhifhLA/zrQ8qJ9bndoRW+vhCe7t7459B
    hJQiwRFIyTvRfXNL0Dtcf+ItqiDgcIozM610LsE/DmitKDeRLII7mJ47cOh64TANaD8Pik
    MYQw862OnFG0NZdiyiudso5i3lGd1xDLKOdHpwc5kbopXuSIX2QKo6Dato9g
X-ME-Proxy: <xmx:HS1Xau1tMZ2jCJ-70JwSa2SltM-mqI6LxlOdkh5H0Z0tYFEQMqf9RQ>
    <xmx:HS1Xan83rJ360zV5OcwDvBJF25Yi7WzsLr0xtqrxeJkjIepNIIBTmw>
    <xmx:HS1Xaj081TEEpAi36dWc6MMUvLfrnzUxXnpoMcibiYQtv_qSY0wVkg>
    <xmx:HS1Xas99-KeVtXKuEsQF_HCiKt4IlvSVlORZXvYEtGWjzCx0fI_v5w>
    <xmx:HS1XahVb13gRmRNSojvsQMN-0hNgRm9FPUpDkWLf3Pp-D70rmKdjVMp6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 02:47:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a48bbf7a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 06:47:54 +0000 (UTC)
Date: Wed, 15 Jul 2026 08:47:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH v4] show-branch: convert per-branch flags to commit-slab
Message-ID: <alctGDn_g4bWB933@pks.im>
References: <xmqq1pd5q632.fsf@gitster.g>
 <20260715041856.51526-1-gatlavishweshwarreddy26@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715041856.51526-1-gatlavishweshwarreddy26@gmail.com>

On Wed, Jul 15, 2026 at 09:48:56AM +0530, Gatla Vishweshwar Reddy wrote:
> Changes in v4:
> - Fix show_independent() to use has_only_rev_flag_bit() instead of
>   test_rev_flag_bit(), preserving the original semantics: a commit is
>   independent only if reachable from exactly one tip, not merely if
>   the i-th bit is set.

Please note that it's considered good etiquette on our mailing list to
not only post new versions of a patch series, but to also reply to at
least some of the review comments you got [1]. This makes the reviewer
feel like they're not only talking to a code producing entity (read: AI
prompt), but rather to a human on the other side of the internet.

Thanks!

Patrick

[1]: https://git-scm.com/docs/MyFirstContribution#reviewing
