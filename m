Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF63E38A9D4
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313171; cv=none; b=D5cDmRnUQMhGeA/fN5BP5JRP/Bobs8NEcWhwOPK8FPrB1joavknMkkTJHET4PmGsjwG4P3uJaKolHex7dYcGPSqExHiy+UFwoKWAd8IMgBZsyVai2FDb0x0sFQE5AoSzTRGdNt6GuuA+NQFGX3qk9c3wkglmOfH+zq2TvXKwe6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313171; c=relaxed/simple;
	bh=YaZh9hpHOrt+7pOU5AsGl6whWZ5nI20cooFmCECfTYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JxkHNXuCGDo6u2ygIImglsuLGRIwOcfeeGqiKabIN40eLF6k7Fs61sc1drDxK7PHmxu8DuP6N8G/B/2h7FHtdZhwBLKB1q2f8hLJZhIfG5aJyQ9co7xApcgOSelEz+RUXXUnyrtGU7h1W4URSzrNfi88wELPtYEX2AyokFj+44E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ibCRgPD/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b247cRHy; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ibCRgPD/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b247cRHy"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id DC1901D00070;
	Tue, 13 Jan 2026 09:06:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 13 Jan 2026 09:06:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768313168; x=1768399568; bh=KSUOFO0TmL
	qZ26+ImTGRfiP+FL280C7ojtAvDoi8TQ4=; b=ibCRgPD/xllsr+dM7UttlQqSxP
	ArxdRc9QtNB3Mv/C2o5RdtTJpgH3H9LDES9Mwmi09RXUpEmwZvCMCVGz71PN8QQW
	CWlotkOmBUW83ux075OP6mCg9v4jeN3Q+A/GAWVQ66yQOEA79r/UYGzsnNN/XC7q
	H/CZAqx1VwUKty6llsD0PAk4rwEx8RDKqCKrkaF4yEGt8WCFYRqcTceRls3Sk0HX
	VXeC9zhbgm/UW45DO5gw6+pJfFl3qqNSn1g7T8qI2gC3MB84XTVCU17keQbbOyQU
	M9FrWzWwoOoXLDsQJ4LZiboQdejMjhiMGKsNA6D54NsDeahL9TqkSSDDi9Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768313168; x=1768399568; bh=KSUOFO0TmLqZ26+ImTGRfiP+FL280C7ojtA
	vDoi8TQ4=; b=b247cRHytoOYJlESevSZ1zURx7xLFA4J+1s0JSiUEDntErQG3N0
	CsN9PLZnzPJ8ilUv3qwMJxiigV6u+ylXjHeA7AudjnDTKPeGHMG3C9hZIvNjRETp
	eXH93tSB4JF5R3J3zFWKyl+BDyA6R+HrH/qaN5MnHbdWAr3aMsoqcXoVbnfWm9PL
	Bsee9ryWWM0Ucqb9vGgiUDF16tr9YKCIn9or/GmDIzYvJa40FlgmjGMc9G5SYu0t
	M8MlFAl0VZ4fgULxze1Tdb2IWQPF2TgHEwFyUWcGXFjKNNT1sLnknvqwYFH2Ehfc
	dPMQR7y4dbK3T0kCGHasNYCWqGGLRHI5/1w==
X-ME-Sender: <xms:UFFmaUczYoz4sh_dlB6hFFkWqxq6BoxpRq_ZDYQ0hMcDojieaUGk-w>
    <xme:UFFmaYejI9ZT91c-m2LRFXmlE_mEaw3y5Hk1yLep5QRnj3jyQmWnoCsUrm9s4sKk2
    ZjTiKL1bFwNSkmlcCg0_JQIC4zXVAxcNvvx3QXHPy2jbfH2r_K3mw>
X-ME-Received: <xmr:UFFmaXzGz-8ysKRC7KCI3_tbP0agQuA3bqwDa50v_9U745OFTOtOEhOAsFFlJ8Pa5zX8y9z8RzDgqmFwb1iEUzdYCFm3s6m21TFvrnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddthedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopegthhhrihhsugesrghprggthhgvrdhorhhg
    pdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvg
    htpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:UFFmaf9YytirF8_YZpMBw05LB_L88OdPA__GdZdUUPq2WEJUwR2K0A>
    <xmx:UFFmafjS5Y4tEUQtn7TyBrbc3E_RLiSUo7zUXCxaS9gRg0XLcvqTVg>
    <xmx:UFFmaWEDUzIfTdLwoD5PbhzSIvtB48ihzCcfFW4E_WYrYcY3tYZU1A>
    <xmx:UFFmae_xp7FP5GdJVKfYKjQXTKjc2MsA5hYDjNnlY3HxeiIuFZqFlw>
    <xmx:UFFmaeRaPhEutdP5AsFhg4tvVTF4bTgtnIuNi0ShNoMZJuo4Oo2b4rZQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 09:06:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Emily Shaffer
 <emilyshaffer@google.com>,  Chris Darroch <chrisd@apache.org>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] hook: make stdout_to_stderr optional
In-Reply-To: <xmqq7btlliip.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	13 Jan 2026 06:00:30 -0800")
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
	<xmqq7btlliip.fsf@gitster.g>
Date: Tue, 13 Jan 2026 06:06:06 -0800
Message-ID: <xmqqzf6hk3ox.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> What was the previous behaviour of code paths that ran other hooks?
> Was pre-push the only one that didn't divert standard output to
> standard error?  This patch does look like a proper regression fix
> in that case.  I browsed "git log -p 1627809eef..c65f26fca4" (i.e.,
> the change for "Merge branch 'ar/run-command-hook'") and random
> sampling (like run_receive_hook() that used run_and_feed_hook(),
> which set stdout_to_stderr to 1) seems to indicate that it is the
> case.

By the way, if stdout_to_stderr is by default set to true, but tnis
regression fix allows specific callers to opt out of it, then the
title "make stdout_to_stderr optional" is a bit misleaing.  It makes
it sound as if it is false by default and optionally turned on.

Perhaps like "hook: allow stdout_to_stderr optionally off" or
something?

Thanks.
