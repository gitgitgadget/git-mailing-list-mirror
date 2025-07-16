Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928813BBC9
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 21:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752700405; cv=none; b=rHl6GA98AjenUKEuKlVTx10tAXzf64u9GYZrzjjbGb0IG38TzsbUB5jYRUydFtCS2nbOGcb6g0qh+FQ8xBiumHiSIErbljhPTk7pWPiwnH1psT7EB6GYOWF3IZdg3C9evIONQfCiJXLL2e1smDtcUH58rD9hVtebEHCusAqPYSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752700405; c=relaxed/simple;
	bh=v7OvDx8d6q8E73hBRRDmZ78PTWB7mz2x7q801VbYGyw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s2pMs887w3/7+Z8P7rXcxgN6/7lBYrjDBq8Gz3WDw6HbnI4CBbpPrrMO2IhuQwW9Ax/+x5Oi3nmTOkMGY59i+EvBWXn9MWQa5frRbUKCl3tjFDnSM0fwLhxzVNeo6MG8Qguh3Xgx8sdR/usfNack6JL2HmU2VHecOEMjB+2RImw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z3B4883K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PVruCiAB; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z3B4883K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PVruCiAB"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5E7917A0030;
	Wed, 16 Jul 2025 17:13:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 16 Jul 2025 17:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752700402;
	 x=1752786802; bh=HwuUFchckF1nf8DW2xS56k7ioN3P67z/qyByu7mnWjY=; b=
	Z3B4883KLZJAa7B6gMneP/RbGkvPeSY3fwUIv/SfBMG+sqpLO3cHfrIO7I4o1sYP
	mbLGSXHHI1Sn6RpqolJeLO0ObchuZUAc+dH/V60w3ek9lnDdU7kcXjP0/F2kd2JX
	TzZpBksMrH8lMLy3Ph6UqJQWRuGhgVi2OIyWtjVcqhdslkPwakhWgr45Q1biwVy8
	RHp/lvXF6cxfDlxPShYEHf9l2YaUE7n2up8n+0wAqWhVzDCkBEgu6M+0L2NIhO7K
	s4J0n0DWZVxddwTkhIUPnXMgA2lYDkOK0TIljeidGNS0ko6FkzOTZFqkEJs2IgXD
	3MzfqprtEq80zyT2Gzzf6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752700402; x=
	1752786802; bh=HwuUFchckF1nf8DW2xS56k7ioN3P67z/qyByu7mnWjY=; b=P
	VruCiABzpFBHR4H54PNAzFXykoDEJYf+71h9q2g89038ldjn5N3s1srDDOOyB+lG
	pJpWxAHnWh6f9dFXQZxFVrf2JJ7upcsX7wN4j48hRcxKxVjhsS17ZMokp+jGeFsV
	ipwqBc12F5Q1FQszUKKDz0YvlkrFsuf7/RekrxngKYYUE90qwds6u81yleUeR3CA
	KOJ3ITsEklMH5/0BZ6NCI9GD/qmcY8sEz5B/w63k3pKJgHDY1SLf/Lh/rAbFDDCt
	gPmM8waWbMvxbJcQYuT3XtgIgH24dFcf/TsXtDXeJ4zof8GFoLGy4H0EkEAFluUM
	qJqIlse5uDfN98nU7D0lA==
X-ME-Sender: <xms:8RV4aCEsSh5gFnCueCWUpyjAijNVQRT3FnbgMxR2Ra2fEvBkqsMkrA>
    <xme:8RV4aA5M6sDyOUNtC5CBgO8w3wWzmN_GGpT67nD9SA_pJSVlTqLADZ17HAKTF6fAp
    S52tJHAi-54bkiMMg>
X-ME-Received: <xmr:8RV4aClkrnNagB9egZtyFVQJKKXMogwlEY6liik5VbumpJC2Cu_vpB7aJlv808Gdhw9p_FzkE5YGctO0kdneXhME-0PjYR8S_9Uz1Ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgt
    ohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:8RV4aNpPvhqlrAodmkWE--yuRP5XiAXPfjZL0hYyD5wmGensA0-T5g>
    <xmx:8RV4aJs7C1rkZyTTniLAiZlAa-NLh0bdjbw978hJI3MqLGbBjxWgJw>
    <xmx:8RV4aKH-Ez-LfpT7pW7FxDcr6av33TS7z4SQO8DNjmEVxIziQP_ghw>
    <xmx:8RV4aKYLHbsob3Ize6hz2Zmg7otzOWaKIg4BIWXTnFamFmmQeL2DiQ>
    <xmx:8hV4aNcNN9fL7vWE4omOpDfHtU8uUQ0MtjY28e_Mr9Gqou5bPB6NX95J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 17:13:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  sandals@crustytoothpaste.net,  Eric
 Sunshine <sunshine@sunshineco.com>,  Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH v5] meson: work around broken system PCRE2 dependency in
 macOS
In-Reply-To: <20250716193000.44673-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
	=?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 16 Jul 2025 12:30:00 -0700")
References: <20250715114407.37955-1-carenas@gmail.com>
	<20250716193000.44673-1-carenas@gmail.com>
Date: Wed, 16 Jul 2025 14:13:20 -0700
Message-ID: <xmqq34avalfz.fsf@gitster.g>
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

> macOS provides a PCRE2 library in base that is not usable and not
> configured properly, as it installs a pkgconf module that
> points to a non-existent pcre2.h header in /usr/local/include.

Thanks but unfortunately this came a bit too late after the previous
round was merged to 'next' already.  If needed, could you make it
incremental update on top?

Thanks.
