Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68678189BB6
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830593; cv=none; b=HHiBOM2nLGkDay1T4pBg/afzuVaOLYxmTv/8R0OK04zM7muHTJRvFe6Ni4gIbtaJOvgCZG4tX3q5hilrIxotGbrnB4zfPjxiOWISZGjfgSEIaMAtU4vbKZXbWMyiCu8jAXkUtkXaj9nwgSLGO9xk09z5tA4qvQm+tHdVk0sZsgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830593; c=relaxed/simple;
	bh=IGZUvFSDRLoIudM0Lt4gK//amHPHSYOtc/Ph5IlT/44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PShptIxndmVkmlJwhmPVE52ceoWbq91OOesMNd0fUximTY24mqM3NttEmS0qpdVM+tF+LRgLMQcGqbT5cKFmWn3PSjRmoKnG2lzjxweEgCzx6OrxclFpmk6lo1UGm3tmh8kzif2OMh1S1ITmTx8IsIKgYgIiBiceKrJ/7fXFGOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QwWB7BAK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b09y0HOw; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QwWB7BAK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b09y0HOw"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8290E14001C4;
	Tue,  2 Sep 2025 12:29:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 02 Sep 2025 12:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756830590; x=1756916990; bh=QwDdnz/f9v
	wbcTQBnH3O6Lnf8Yw+elloUJ92eJeEbCI=; b=QwWB7BAKnxpL/qSRVW6J4PGSu3
	KqBZgxZArgXKp+bHTZSANJlKae4phvfNoFwFKcrlQlMnfHGTJNm1g5XtLJu+yGPq
	ruvupxs6CKcOZsNNHaDWbrbOaGqm5O6ksK7Bhn8oy1edEsvW5vrdpYWIOSyHKyNH
	ZR6XSbPvVYqUXGmGDJJyNK+dzDjP2ITqnHxin2lwfbsrcOzgm/58EBNdsO+lqpqx
	6E2YcEQLSe9Ci7kODtASFKBQAWsMr3X3lip2WZkj2zOrG9znQz8Fj+E0ED8yCVop
	sOBjqvXmKGaGrs61vwyxrrAfoW/GnruqLtU93YNpfgzNXAfTjnTeSDiV8BlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756830590; x=1756916990; bh=QwDdnz/f9vwbcTQBnH3O6Lnf8Yw+elloUJ9
	2eJeEbCI=; b=b09y0HOwa7beYyUg7lxN2gXRzN6u5iacmqpH59GWXqdQ/dvcYK9
	DNVszjZ289xBxkSvmrgBDIH+hpsNLRicuinPZuPvqRcuxz8wy+y6T28xZrdjit6w
	ObHj0Qy0+f0bZqW0/XJvpRO5MhhsaYQV5n4T9fti6h28SdMWFhA3GjUBZssAzLk8
	GGXXyAVwAc5d8yUt60sInJA0WsNWfyUHUjBbM/u29GVdZnafvMijkzFNerjUFwJN
	MeFfsabJkAOGSpaaXTFBL41iASYmYy9RPh6X7QilbjtsD65mmO/gmSimQUxgUpSj
	Mxw3UdWrR+GgDXflRfen4DoL9tlQp/Sg2Kw==
X-ME-Sender: <xms:fhu3aObJmdN4EWi4At2h2EVBb67CIfGpZcXmIoE7c6gwQhDDpYYDlg>
    <xme:fhu3aEqjZQzRDLhkkRqHOGTZxhQQ7l5N0jPoQRmHr9msK5BnavYHKsZqQMzUP8bTK
    K45w8dy0kYC_2EUJg>
X-ME-Received: <xmr:fhu3aCaG_TQoR3SBXkjwaTCux7d0TwdkytVJaHDnGZt_ZNiUqLjhCCfKGYocwl8toAr4VJseOgcVns9NWLZA7Z3XSaEtx1a3ZY7kdq0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufe
    ejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhorhhgsehmlhdu
    rdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:fhu3aMS94V9toSl6guTqq-4aTH21PV4rcD2RNeO1XI5ELn7NIvzXMQ>
    <xmx:fhu3aJ5l3ZZM6Q14VM0iuZjp59nFpopQZ5djaK9oLIJvTS4Jb0UO-g>
    <xmx:fhu3aBxCC0UY_CDLYp258iKkf5Wel63QR5CohRgeXl6BsNG7cryWvw>
    <xmx:fhu3aIQOLyAKB6zNZJ7AXkmGYr9VCydnR2SEi33dlb_QfwGSfpJspQ>
    <xmx:fhu3aEPbX77eWjmD_vIF5yCSvfG1-cva13O4o1MutXrPga_X09YrbMvl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 12:29:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: jorg@ml1.net
Cc: git@vger.kernel.org
Subject: Re: Still using "git whatchanged"
In-Reply-To: <74c5f07d-6376-4787-a5e2-bb09abc58ce1@app.fastmail.com>
	(jorg@ml1.net's message of "Tue, 02 Sep 2025 09:18:27 +0300")
References: <74c5f07d-6376-4787-a5e2-bb09abc58ce1@app.fastmail.com>
Date: Tue, 02 Sep 2025 09:29:48 -0700
Message-ID: <xmqqcy88lsw3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

jorg@ml1.net writes:

> apart from what's stated in the subject, I think it's not logical
> to use "--raw" when I want to see what has changed.
>
> "git log" shows me the log. What's the raw part about wanting to
> see what's changed?

But that is what "git whatchanged" gives, so when one is so attached to
what "git whatchanged" does, "--raw" is what we cite as "compatible"
option.

If you want to really see what hash changed, there are other and
better options, depending on what level of details you would want to
go into, ranging from --name-only to -p.  My personal preference is
"log --compact-summary" but I do not want to force my preference on
those who want to stick to the output from "whatchanged".
