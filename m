Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74E538425A
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 21:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785360915; cv=none; b=m8+Ey2SI415KCrq2+eBnhFDEIhBTk3HdIvNqQ7FykT6KuyEXxMu1mUxA1eS4L2sKHRSU+YPatq/FxnJewPtvim1IYWYWXwPFnh1OANVijzr6o81DJpxLcXPXHIJCuJs0J5+mmJdbxB2jBtD3myvRNgBl7a9TvlxerlMuSiOVdqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785360915; c=relaxed/simple;
	bh=E0dzL+oZ+29FbqOpyxe7onRlvSYt6oY8t88A6RN/hps=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mt8GWSMumIPzbHjICo+YM68/6vAbin8D3AAuTiULbszLU3tR868S3982DIaCxXmRB1E0KyGQQv1lYQ6GFweLvBAHF8kSrJEjmcJfKathv8gEiyARuRsg4paWdIT5y9J1G+QmJNVcQyUvrFPO4C7eg3l1IucxE1XXtcAnJ8Qq9gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lqSjN5x5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lbAjFy/J; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lqSjN5x5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lbAjFy/J"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F09C514004E0;
	Wed, 29 Jul 2026 17:35:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 29 Jul 2026 17:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1785360912;
	 x=1785447312; bh=X6JjElm8B30hANZLMgeWs4wR7EanKuJarfTy02LoLVE=; b=
	lqSjN5x5VRegP//9E3s6yCk2wv/+mhx3Lo6h1k0Hf+TORNb4XG/lOCTVXyAo5ku9
	Q5Ey3obAT9ChGuI5/vdSupu/Y6DgD8wkGLUhNrvMGoq3r/a+sZMErgapApya3JUc
	+DXhcta1iyYbbzTOgAdG3mgd3xV1lMUtaT8SncV4M9GqYi9AVAmXFhHdM1ZvXGRk
	67/YkCceK1+z+kiFpLIGzX8B5e+Dq1g/424Axen21tgbjP5d7OZzRhkzC1NgO49t
	JBQ35qDQGsDnbSmUMpOuA8uuUtkOANzUIkKiU+x+91V/rWADQgmnEMwzBAAwpFwT
	9HhXPrdJu5Lg14PbRHw3QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785360912; x=
	1785447312; bh=X6JjElm8B30hANZLMgeWs4wR7EanKuJarfTy02LoLVE=; b=l
	bAjFy/JyLZM1rgxc97mOg1Tt2EJxZoff0NyIv2x9BeE5xSXDnglDo/LukN41DyEh
	pCG/D7ZUZbSidt5fN26Tyw2R1miDoMS9q5+KIfaXAcFD+V3+iWILvOv8F9UBgGjs
	tU6AhFhUit7Xm7fJzVJUPIh3iAer/ytR5Eke5PKXtG+DqDZkdmI14sNHsxf5Z2LF
	0mYLhIY2IfBVJFeeuiycDo6NJkwr9rkHcJLnO3XW/9k9EMG5nCfU/CD6QACodDf2
	zjiUh+hHUM/GoTWY7qPq+1mWFnILn2UCmw9k4Hy17GSau82KDGgTlXCixQkPQql9
	c6pqloYvPemTJA22lY7NA==
X-ME-Sender: <xms:EHJqamuM2HRGcukup6PczboELUZ68GZeG6mAjspQ8Zmem2e4mSpiyg>
    <xme:EHJqaiXSLKZeVecUn37QmCqF1XeWCG7EuzZ3V5_T5AUejlol2SFvAPwiHt2ZAIKZ7
    XirzZ4LW7LTl3wbwej57wDctqpg5LMgOKLvzkd0MALtmms_u40K>
X-ME-Received: <xmr:EHJqaqFKEXm1RWbHjlf-aj7zjpwjudeBdC89jHqlKUqA7QIpB750oV-JfxF3lrZ3Q8PToEQqICyC9rfMTDN-EYWUm3hK2IZd7Q>
X-ME-Proxy-Cause: dmFkZTGLmHSfItfNkSgUBYA3P+kcINYLpu80448dVNvNFtp/OPEsI7di+jmkSs42XCh3Sq
    6R1//CTfVChibR5YZsFhNTrIKRbjBi5TdrtQSWOkbWCDZiQZ51nSWJjlrtWiJwxSD8Kauf
    XLRZNR5Nb04xp/tMHJM1+/8XV5T2aICDybyKZ6IJ/7B2lK0yRcUJmc07A4ZVFH674wPVCl
    xo/rbwoFx4CY9JtJwXY/0f+WAqyCBoczDVDuxnLxRr/q3cuuWpfGxbqJBJVtw7AdqwvU9k
    C67fD0dG5BvbmZo7B3FxHv51YvNVYPp1V86+TYik4SGIA3bpBciMWsp6OzvAFvtpp13THd
    fLYqA0yeHwFISZqE+/G5viZU767/52OSaQUF0qe6bipD+0PAdhZe8iI2yqzn1HBu/RPa1p
    0H99/j8aVDKg+hMaaf8oNvtW2wF+tK0uadhGDId2YjvREPXJk4qd5+HpxXKkcXciVWDMz/
    wxm1V+W3NDnFgzpYuEd8SvIKeSCStrYz2G3pOYLR2q+HkrEppL50+ZuVhrkvF/w1Ajmfa8
    SrSVY5mUAugBYqWfyGLMInyaZRLIQ74cbJsTEoclUk+Cck9mx521zdhkdBYEWzRoC/3BAM
    64sNjqo6yFtaliab002hHGpf38nTgkcLO5NeblJpdPZb1u6R0gq8eG2gZmrQ
X-ME-Proxy: <xmx:EHJqas2WdgUVgGYGZjW1MLgJkGaN0mpvl4CLg84KPz8GzKHP2dZW3Q>
    <xmx:EHJqakMgDN8MWMOCJ7WCXNRc3ZO9hZKv2ph1i3ABuz1ovzEkyd57aA>
    <xmx:EHJqaj5I5riJeOKlB3G0cKN_1f02eagv-uC64p8azBC6nNia9tGoiA>
    <xmx:EHJqam2-VVJxEX6zTCzZykucZvsRPnUFNTQsbAgxhsmjtuXQKGzGhw>
    <xmx:EHJqapUWrCsQk9li4OND5b2xyOx-O2h45TiHb0OVZVBD07L9-lGOPp3K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 17:35:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Taylor Blau <ttaylorr@openai.com>,  Derrick Stolee via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] trace2: tolerate failed timestamp formatting
In-Reply-To: <xmqqzezlhgyo.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	20 Jul 2026 07:29:51 -0700")
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
	<alpXW5U6sndZtgqV@com-79390>
	<c8d443a5-3cfb-4752-8716-cf0d8fadd9d3@gmail.com>
	<xmqqzezlhgyo.fsf@gitster.g>
Date: Wed, 29 Jul 2026 14:35:11 -0700
Message-ID: <xmqqh5lho4xc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> Derrick Stolee <stolee@gmail.com> writes:
>
>>> Would it make more sense to fix the xsnprintf()/libintl boundary and
>>> treat Trace2 reentrancy separately? I still can't explain why the
>>> allocation failed, so there may be another GfW-specific piece I’m
>>> missing.
>>
>> I think that your suggested change has merits and should be pursued.
>> I'll explore it a bit to confirm.
>
> That band-aid may be a good idea, but I would prefer not to see the
> conditional in a common source file like 'wrapper.c'.  Somewhere
> MinGW-specific would be more appropriate, would it not?

Did anything come out of this discussion?

>
>> The other justification I'd like to make in my patch is that the
>> xsnprintf() calls die() and the trace2 machinery should be die()-free
>> whenever possible. Solving both possible causes is likely the right
>> long-term approach.
>
> That is indeed worth considering.
>
> You mention a few calls to xstrdup() that can potentially abort, and
> I agree that anything that triggers malloc() and notices that we are
> out of memory can probably do little better than to die.  But are
> there other operations that may cause us to exit, even though we are
> not in an unrecoverable state (such as an out-of-memory condition)?
>
> Thanks.
