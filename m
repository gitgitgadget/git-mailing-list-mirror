Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638C6271461
	for <git@vger.kernel.org>; Tue, 27 May 2025 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748359504; cv=none; b=LfULP02bVX3zn+GdYb0N8doSz5Pr1XC28tuiUYBFpZnUKNP6msy7AdoBet2ud0HFnCBZmthUS+h5rrIXGtaIVC0pFZrX4zB0fBqR6JV6PDLXWM4k64M1y2TSVrSDb+Pb4qwiSJspZ3GNoiZQmgwjKjyBGdkXbR4MGmcGJ2bErE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748359504; c=relaxed/simple;
	bh=jO1xFBFEeMQGMxOko6kYO9Cpq5AxI/QP9I3/9pczuGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mL7Z4Az96xEg3Tz8keDytS4JinRg7N3ZOgXBBCiylc+UuxyOTwnXOnLfwx6vyfTAgYIp94hTVIY4g3G2VOyVSL/K2WvGYgAuc9sL4d2qsOiVCvPeyKrhlCJ9pYQh7oGqnyOv1mCBimv7PRU+2kQrlYncTw8cY3hAMX63KIQCoVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zlYdCXEW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Js0WL55d; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zlYdCXEW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Js0WL55d"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4D0B12540129;
	Tue, 27 May 2025 11:25:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 27 May 2025 11:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748359501;
	 x=1748445901; bh=JaRpmOMTZYhcIzXya8vBW3PiOr4lqvNj1Ih6BwSgPqw=; b=
	zlYdCXEWn5FOcwVe6NKQfrDoyJtvwM+wrojym/I4cJkrRi2AN3x2UJAkocFAMbWy
	uGQ59VQT+g1epkGWdhK+VzHdUl0kLmHjbPcr63YlXhOq+3+0UwXsPFaP/Xbsjd8k
	cJCfEUQOu000JRqg8GIQZRzpvq+7PaTuwMHxp/dr6glz9bR8wjxpnBJC/dBnEr0j
	7b/7q02kSy0lScWiEU2uqj4JZKmYIi9hpBYIYm7eGdZO2Wh39vR7aYVcFrUB2zS5
	rzLgZwxnOXvyZZIjE4XCtghy6F/Wi7g/aTEzsw85awFkHMktVBfrhZ9D5FSsAFJj
	vZ8sMQnt8lUK89+C39EM+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748359501; x=
	1748445901; bh=JaRpmOMTZYhcIzXya8vBW3PiOr4lqvNj1Ih6BwSgPqw=; b=J
	s0WL55dvECfRCHPTa9vLRCWBFtEQxRMRCWVR/PK1UeJccEnSjzqturZFa+2ZZ9cE
	F+4bkrS+mUDuI8MhcyMDYe1CmUdcqPvTlFEn1L9uXoi5H3lEeLwoacdP0Pfp81/i
	fjAhCyK31TZ2u/JoMo7ZqOixYKs0MEtUizN3xqowrXTo4uZttBNe14KV9gRZdphf
	/blWUQElApOaVevrZmVBKD5nu8Lv0dcbFgUkmPCUA0v0TPo0N0QvoLuwXRzdOh9d
	Np3B2EPGOO4HaXr7106EXIApFD7ANgrU/HaRRslq5mDpnOw89bPsQYPH/yg/bF+R
	o1/nfDaxtTL+dwuAofwyw==
X-ME-Sender: <xms:TNk1aGmJJ7eIVdhuNhJjRlDAsbHvySZZjWefxF_deVoQY1HxzFfnIg>
    <xme:TNk1aN3zC4SwF1z-Znh16R1HU7Bz7uk54etPBTY8IM1xixC4Ku5We9hr6VeZ3qA-N
    7SIcIxUIyf48rO4pg>
X-ME-Received: <xmr:TNk1aEq7S2NdY7i6UqJppfcJ2xyl-mxbcXiBaHATDd86wSRNG18Hd0veA1mkdMFmX6jH3fc7FQwFFOTUW3yb1uSQWY6R_Xu6nGOtcT8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdejfeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouc
    eoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdet
    gedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphho
    sghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehophhohhhorhgvlh
    esrhgvughhrghtrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:TNk1aKmmnmrlLucmgksBQkjATzNVPTEFXPMA4ItYsegszS2XXOx4mg>
    <xmx:TNk1aE2QWF1_aJw1FNVNQxpfPQ-81KF4WpbpuaT3z_Aji4PFEvyOdA>
    <xmx:TNk1aBs7PZ49Ts_KAWXS8OcPe2WVTidq_CcBIUKXAQnLo8FHTKCrlg>
    <xmx:TNk1aAX-rbyxoWB-HA1kM02EG6Lxgy0I6QdesPx8GBEu2bicxC3_Nw>
    <xmx:Tdk1aHZSg0rNNZu0A70bflS42zs7I4yVYq0LAiYalNTvjv7d4wwc-DpW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 11:25:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ond=C5=99ej_Poho=C5=99elsk=C3=BD_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?T25kxZllaiBQb2hvxZllbHNrw70=?=
 <opohorel@redhat.com>
Subject: Re: [PATCH v4] cvsserver: remove unused escapeRefName function
In-Reply-To: <pull.1925.v4.git.1748267305871.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Ond=C5=99ej=09Poho=C5=99elsk=C3=BD?= via GitGitGadget"'s
 message of "Mon, 26 May 2025 13:48:25
	+0000")
References: <pull.1925.v3.git.1747913206622.gitgitgadget@gmail.com>
	<pull.1925.v4.git.1748267305871.gitgitgadget@gmail.com>
Date: Tue, 27 May 2025 08:24:59 -0700
Message-ID: <xmqqv7pmqdo4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Ondřej Pohořelský via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Function 'escapeRefName' introduced in 51a7e6dbc9 has never been used.
>
> Despite being dead code, changes in Perl 5.41.4 exposed precedence
> warning withing its logic, which then caused test failures in t9402 by
> logging the warnings to stderr while parsing the code. The affected
> tests are t9402.30, t9402.31, t9402.32 and t9402.34.
>
> Remove this unused function to simplify the codebase and stop the
> warnings and test failures. Its corresponding unescapeRefName function,
> which remains in use, has had its comments updated.


Very clearly explained and looking good.  Thanks.

Will queue with "withing" -> "within".

