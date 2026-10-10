Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39E81A683D
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 01:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791596737; cv=none; b=EQsLWX2SS1wLFzC5pwtI/9ioPcCxHa9s4pFDRypd3riPyVRZllL4DeDse+mtFc3+Emttkzu7Z/maoJVwFD27uZIP42T6FPGiekFytVHzSFyU06yIlBEqn6+I7SdEv3cGlzQoYrYTufp6DMtNbfwew/WhnaOq/0rNualv1V0VWoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791596737; c=relaxed/simple;
	bh=VhUiYbFwuZshPcFTJ5ScnAhru/aXt8NKtZldlJ64Ekw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=YyRBiT8WJyCWO+4U7RKYKhDJzFI/du7H9w3zK081LxDGiiSBWrwOWgw8gINdX2StuXhuz4YhSK6GmzwoHYRBphwAqNgmOmUjKjLrLjzi/MHbmtcY3kDkFgLFUIxdyBoDRW17HRRuHxF/olUzXA1BYuBccePTQ3D995X0WBNqjm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WIz562KZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vxAJc8qN; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WIz562KZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vxAJc8qN"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E92067A00B7
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 21:45:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 09 Oct 2026 21:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791596734; x=1791683134; bh=K74kigvhiK
	ZWhRhPlDKKLWJHc5MiGDUgdag7M1h51Io=; b=WIz562KZBwAjWqnIeKY/Wk6y40
	hkcB3Ig3J5+Ctvmf9e6h+id5WoBUPisYBQr6PtT7ceuEHcKVU0h8IDtGQVx4HZZ7
	2/GfFGnlSYWETOsYDm2lXC7tVIy/9Ua8cwCiNJgLcyLD7hHoW0fqBOtvBhCIB3wo
	dtVA/WCmjzqmMZ8GG/mS/RWvRP1pR7BDz2HCegCU0hkeQ5tbkI1irDTK7R9aARBn
	V+Tg6QM1JYTqr1qA0obX4Snq+HE4ZllWIihqsHtzzZrYup8ERbE3uzxL0cRRGiiC
	2Hj9PEebkDsX2SxZWdwFQE70MJ5CmoYyB0CkVIie9oakBdLxVYHfVVFC/SQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791596734; x=1791683134; bh=K74kigvhiKZWhRhPlDKKLWJHc5MiGDUgdag
	7M1h51Io=; b=vxAJc8qN2ofTFW+2UcToZeA7qpAfnbuG+iyDGwCvD9YfxpMoGqj
	Lwi6TbY0Ud6nBgDKFkrCl71ZJZVzLtohKwARS68ZNJUYLScHHwCLXK23V1TCaIRk
	o1Ob1UMMSCP/MlHHVhOZ3P6GTUKRXp2iZ0DpmV9wRhX7/wgpnUrpD82t7BkUtzTG
	XcLClWCxHH/3J6hdoy57u94TJiWNeNs8zhnfeha8rdXOnfb7MyInxhXmJ2m8aADZ
	Zuu6ncRdGxJ5wMOwOjB8On5WnS/033QXwXSUy7KFw32y3M+1cD70HGldIuJtSqh+
	xlCQVFWYBNrTjuh9W9YceSGFWaoZIDsfxBQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791596734; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:dc9qOZiIx/R/qWDuURPhr5Np0qBkLfsThtcbCgMP8V1kS2Y
	APvCtZUxAaMMAYlMF8jEUxnaynsqgDMYIzwHy9qCAtvDJh+wFidavmFXDGIvJQ4B
	m2qC50u+FPU4IrHXDzLcs5mXb+tUkEzoTf+JPG5hymJfrqYOohyWyPu/kK6s8YEp
	PgvY87bFvRwXYYkA7DErqQW2Qm7r6CC7iAVs9lLjMmBWwSz20Y3wegE30tAHU7ZC
	vOdMlqMv/3De0eWQe51N78jwMf2XuyaAgoFfD6SYzFicHtSoWo8bMTmSDBuf+Fl6
	26hhBqU8WooYHbNGWA2Xn/GsHqR/D1kVAOLAyLg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:eopjW6/BrQbVzxNc/gIM+MnPtizKyPPJ0I8tBCSEA9s=:VhUiYbFwuZshPcFTJ5ScnAhru/aXt8NKtZldlJ64Ekw=;
X-ME-Sender: <xms:vpjJaoNXaOTX0XYbc6mZCItyeRTEJiQev6kSNlbao66GUoNWkjKukw>
    <xme:vpjJahP5nkTDDDwGXAWPotaJcjMFKcTGdJlfDhXLaOQDeVCAkmC-T7Z-6L9n4WRpw
    80Ddy_-HaG52rgNDceH1cl28FgWZIV-BCE9HUOjvK9fRn70MM7_WMk>
X-ME-Received: <xmr:vpjJahj7Pg7xAvHgJAtRYtBUgVmzcsXgmzR_d0iqgMtQbzqU0klAjlOlWS8>
X-ME-Proxy-Cause: dmFkZTF5dTe3glZ4qmwcztV5XhpUPEpDE+ROxwVa4xV3uO2VX4XI6WK7ewc/T+Uhn+pTdn
    mXeum2L0NSYSHSs3GACUoJy+jm5XMJwCUrvpExVLkG73ifqHH4Q+bxJiAuRv2Wq8FmGfTc
    6dmawajr9Qm7GHI1RbGtYCQZtvPV+fUlXR4655IYMrfunNE8EdHIJ7huFoUM29XEAOzQE4
    rE3ISDpb5kxyYT8IKRFSjvc5B6i9Eu2wU9ID85sRpVqVM8V7ME/8aXq8jfRiXuP0OAi0hI
    fp+P74jIkoIUTlqtXM4ceNzl7ybLdPR7v9WoXP7x5QtCFi0zFmXvKVr8KZM/CabImTPMe0
    GgR8tNHAqumGnRImJ/dB3fpghXz6huMoTWX1fqj/hz9SlUPkb2m7xKUPKAi2R6i06Uvx3Y
    XrW1BaM8cFbewZIIj4hZ4QqgKDqye7eiNyEtfNzzi/aPc3YYcAI2ZDP9iNGHlJlRlcSsf1
    erU5+3/PDgD+TRnCiE/oElW46GQXEazwqFDA7odDKgFj5lrCGX93eBKU5i0kqmlO/XnceM
    1RB/CkdE56RFeNM/ueBZVyozlWneqvWp7qogU7FwaUg83/GbN40da8gA0b+LtKUmK9Ssoi
    Gznz80f9cq/cuN2apmSL7Yc1LDCyIbAlpCqVEHApdjdhTkOlVaoK43g9csag
X-ME-Proxy: <xmx:vpjJamvnN3_KKuv5eXe9yrS5Kr5ldMI3goMUa2p9eOVhG_297tIXSQ>
    <xmx:vpjJavR-EM28PRn45zWR-mAfpE9ojLUJUtECWoUH3b32gGCYZdW0oQ>
    <xmx:vpjJaq2lUhUodmkznb3UT89xdXpfKNogBrfQxyW8Z8KWfEdUb0IPRw>
    <xmx:vpjJaktUYIqhWDtYt7EwFOhaxHPaGMeZRT9ccqkHuOYi3M9x4NTgIQ>
    <xmx:vpjJagTTerAAhNG7LZHeW9y1e2fXPDtBZcgaRK4YXVrkWsSo7S8prQ7K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 21:45:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Patrick
 Steinhardt" <ps@pks.im>,  "Jeff King" <peff@peff.net>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 1/6] doc: add new gitmergeconflicts man page
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
	<ab0344f947c252b1b7c8bb386586b8641223ba38.1791547213.git.gitgitgadget@gmail.com>
	<xmqqik3arc2d.fsf@gitster.g>
	<b40960d8-3033-4458-973a-67fc41e02b77@app.fastmail.com>
Date: Fri, 09 Oct 2026 18:45:29 -0700
In-Reply-To: <b40960d8-3033-4458-973a-67fc41e02b77@app.fastmail.com> (Julia
	Evans's message of "Fri, 09 Oct 2026 14:53:58 -0400")
Message-ID: <87tsmucoqu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

Comments on a few more points.

>> Is it deliberate to omit 'am -3' and 'checkout -m', perhaps in order
>> to limit ourselves to most common ways to help new people by keeping
>> the description to the absolute minimum?
>
> It's deliberate, we talked about that a bit in the discussion of the v1.
> Can add a note in the commit message.

Being a part of _the_ technical manual on Git, I would like to see
us aim for completeness, and where we don't leave a note that the
description is not complete.  In this case,  between

    Merge conflicts can happen during a `git merge`, `git rebase`, `git
    cherry-pick`, `git pull`, `git am -3`, `git checkout -m`, `git
    stash pop`, or `git revert`.

that aims for completeness and

    Merge conflicts can happen during a `git merge`, `git rebase`, `git
    cherry-pick`, `git pull`, or `git revert`, and other operations.

that admits the list is not complete, I have slight preference to
the first one.

>> By the way, is it just me who finds those "Here's", "there's"
>> contractions disturbing in an official manual?  I've seen many of
>> them while reviewing this to be annoyed enough and had to blurt it
>> out X-<.
>
> I find "here is" and "there is" to be distracting and overly formal,
> different people are different I guess :)

But I wouldn't want you to be "different" here.  This is not your
diary or personal note.  This being a part of the technical manual,
I would prefer to see the same formalness applied everywhere.
