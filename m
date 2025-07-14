Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9525672632
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752512313; cv=none; b=m6LfXBrYMbyVLcbMc/MIsrL/TueQaG3KLD1xCyDxqOn0aKTvJ9j/iMAuAP6+JjRGPu8ShEBDytUlDd7tb96cvxEHA20mhICmnLQnksoofgeeaFIulsqlUOkhGEIKK8ZPi7uTdnybMmXAzD2AyJbY4fLxTZhcxRYb/yQiQfz+Q+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752512313; c=relaxed/simple;
	bh=ozmLBg0hFzsL2MmgUxD9pzw3HxzplmwxGc2Wo5bk+A4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uUJfojksIOhR80VXhigI6SqWNi392NWxJcKIed9CgLtxCiOkO0pAMRxvaCHAvj5THCEplqZJ6Pdw562SM77c8gdS2x3jQZ9jeSAch8ARAM8vj3njhE8GWyYAxq+VrqGNosfGbnr9U4fSUS3taguGEmmZPKdkRP9a/YGQUXRgDM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iiibYz1G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Aa6Us2Tm; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iiibYz1G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Aa6Us2Tm"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A10F214004E5;
	Mon, 14 Jul 2025 12:58:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 14 Jul 2025 12:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752512310;
	 x=1752598710; bh=ftX+KAaT/Qya6yl5HLk/ZKDkC1SJQ1v3OjUxXN3Tt+M=; b=
	iiibYz1GFcntCwa49d7Ihf7+N3jfXI5rWr0xdNnSHHnTERR50EWIAdk5uS7Sj8ZO
	0l3ItutRg+eubvIijniU5HdBvvpa+eyHNn1rKBYxiUC90DGWnsan/LHBVaAchVGZ
	ZHyGpN5/bVZeAmOkvQjiMebjkKvLkVRUfBg8RZ6qd/gmQ91xPhTQuur3TFJdxuAf
	KpBZRJfH+sWg3sydMUEoBlOpPrn6iXLAbfaZjFJPN7ixyL8ZAKKpaBmgTzj5F47B
	FhGq3nUtRotk4sI3dRL1G2C2TdSYX4Z6MrT9HQpSlAEV+A81wp2Oay4Xmsil9zqm
	GFnNtb0ODmNn/lWjlSIcyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752512310; x=
	1752598710; bh=ftX+KAaT/Qya6yl5HLk/ZKDkC1SJQ1v3OjUxXN3Tt+M=; b=A
	a6Us2Tm0TnZXJ6tmwdGAD4Cz75qtRTvsuaf6o7GVF0ihWDxQ+3ie/SXPB4K0oTVZ
	ItsJoZxg84mtv9MtKHOq1lWcnBPnaYH0lG2/LV/4vs3+yuG6igwl4Q5v7Nlwk+fe
	l9qA36+PgKcA4dFkg3pFSZyc4O7XQKBdyaXKDYJb57f5GJjIWVYgWsIy5vP7Za6s
	54Zt6HRuRcoQoQtXbdbkTbVAYpYafoxE+Pd6SSLOYob8dKxL+hGdS7e850Hm7pR3
	JpckJLHcWGuhep/R2rIX3T8Bhi6/nvg8i108csLzPGGIozZUqZmcEoVMDD/aOiCN
	g50hifDRbqKnMOGCBpXfA==
X-ME-Sender: <xms:Njd1aC0QUxP4RLgwzEwPaGPvpQxXfuY-leKhsXiOrNAlivEj7Pn38Q>
    <xme:Njd1aPpeTDihCAtfgWRcSWuMm2ElT1_JMriZmOC_PO8MFQqQ0Sv5h4lVy3Hh9Z1rU
    gkxd7br4mxJk5KFMA>
X-ME-Received: <xmr:Njd1aHcacckh5-EEpiyZE2yM19V90xGn-yF_fCERvMEr1i7QpVYrveOIeq838XcWQIiBXVk539SDIGPdj7O2NN3Xd69rjuCqcFDgASI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehvdeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgtph
    htthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Njd1aGpk5KfaClqiSPcRr2G09ROieVze20QfqppwvJx7JEtk_olJ7w>
    <xmx:Njd1aAFLxHpCO2i1Z7BOK4iCrAwMTjwton7dlz2OmDORL7N-D2jraw>
    <xmx:Njd1aOvozSsAx9QAIA_mafQOYBg1S6M0ZrNjDAos_9qh9T0EIXJKnQ>
    <xmx:Njd1aKU0wENIuy5JlNkLlq9aAZa5sO6-Kl1OUxe_JjOo0-Py2CPRjQ>
    <xmx:Njd1aMEhGb_4ARf4LtF0f9mz_x0L2_AgD4274coHFsHVY3Bk4bLQkUDw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 12:58:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH] meson: disable PCRE2 dependency by default
In-Reply-To: <ymreouejava2acp3xpvrviffd3bd7cu3wwmi3fadzykkaaubim@25oyqvcfhrda>
	("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Mon, 14 Jul
 2025 09:46:29
	-0700")
References: <20250712172615.11364-1-carenas@gmail.com>
	<aHKgu3Ew3Pk0PL2v@fruit.crustytoothpaste.net>
	<CAPUEsphoFaS7CnxXs_PsMCtCrB7ByE+y+SxQGaxoovjAdH7UFQ@mail.gmail.com>
	<xmqqikjuvlxc.fsf@gitster.g>
	<ymreouejava2acp3xpvrviffd3bd7cu3wwmi3fadzykkaaubim@25oyqvcfhrda>
Date: Mon, 14 Jul 2025 09:58:29 -0700
Message-ID: <xmqqfreyu2tm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

> This part was more of a: let's assume that we enable PCRE2 by default
> in the Makefile as well, what is the impact to the libification
> efforts now that there is a chance that libgit will be linked (probably
> statically if using meson) with libpcre2?
>
> Since the plan you mentioned above is still dreamware, wouldn't it be
> better to move all the pcre2 functions out of grep.c, export them back
> to it through a semi private header and convert `git-grep` into a
> standalone binary that might link with pcre2 as needed?

The engineering effort that such a move (and encapsulation of
"grep_pat" that may or may not have pcre enabled) would go quite a
long way and brings us quite a lot close to that "dreamware", I
suspect.  So it may not be a bad thing.

But even if you move code out of grep.c to a new "abstracted regcomp
and regexec that may or may not use pcre" source file, "git grep"
would need to run with the code you move to the latter anyway, so
unless your plan for libified "git grep" engine is to make the
library user responsible for supplying their own "abstracted regcomp
and regexec that may or may not use pcre" (and "git grep" brings in
its own in that new file), I do not know it changes the picture all
that much.

Thanks.


