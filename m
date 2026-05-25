Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F7F37CD35
	for <git@vger.kernel.org>; Mon, 25 May 2026 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779707370; cv=none; b=M4YwkJWeAkQ6WqRqe6Yq2Dl0UYWCcYVw+L8o1A4PHw5kIpm98Qh/aW4xQC/vc23G2dPSIeQ/X8zYxL3kqgseFFKhJ8pitExgqcii5xc/dJNa51VJH9gHisz0bS5fxkNjTKOZN7QYXyb/t7rRZ5vo7pi5NyBuhcHFbbLyH6qkACI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779707370; c=relaxed/simple;
	bh=6q21O2yG95gQrQPPGYdJ2/8YS2IUC1FYTMBThw5isdk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kKK50QVCipfT3u6ibc2TDBKmM1Ho7ATj0wMOjsefhIEsSoI3mWf0LqhbvKYfn/qh3dGrpt+xrVYgK8b5kiQ61qxbk5zeSgfeFzHW+OrgESzwkpzuCtLR/r1UjOR5OSYlj25pyKR+jy7OlRQCq3h9d6QP5i3y/hR0/P19iRwhvBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AhCnB/eE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j9M7N+DS; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AhCnB/eE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j9M7N+DS"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 8DC13EC068B;
	Mon, 25 May 2026 07:09:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 25 May 2026 07:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779707367;
	 x=1779793767; bh=8b6nv2/00xHcigeFtuQCyznyf5CmWTNflwzSjDAYes8=; b=
	AhCnB/eE0zT94PCXtvHibhEuFinR2M/q4xc+HOwv8qSB7jlr/ppFEuHptlYFYxsw
	ugag340nmdoBj7815YP9/34fNEGAMNG3JZ3Su6FHjJ/Vkzz8PLrw7uRU7EggQAk6
	GjcN1oLPHiFlOWnjqJ64eHS4LU37RneViovRi3vOgMF/xXwuSEcR9cEkwho49fUg
	EU5gm7qELLMSkOqfqJ/VFw4eFa5Ti4trGnFJ87jLfND6ogPPbikT7kssFUPUa9KR
	kPIMa6J7U4uwYbALaikJEUyiFm6UiHlRo/bfhrX8kOja8frS1+Nw5Jk+ha5ZbQOy
	F7h1sD8RjMShepFmxhRUBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779707367; x=
	1779793767; bh=8b6nv2/00xHcigeFtuQCyznyf5CmWTNflwzSjDAYes8=; b=j
	9M7N+DSQNmR6NNFgSmmyxV0abfi5t9KhAvFJZ/Xel/I4lmash0uqMOvBy/oUb/qA
	wX1966eA3/9ITRMTdTgnV0+FkCLwcU9hiICx+S6c8EwNDZKAkmlqWtZ2vj0/HlTo
	iSLnkbep+YSDHhmdjHBj/s5awT8ALbptiKBT2HjznnrOD9uIci7iBr7gfT6ABNlA
	1GszsbcJ2JCp8R/wrmyijXKhUGtrSwjBKTDoU8TBeELMxYaNtrfaGMGmq12gDAQS
	lyi/YkWROa+QfRH8ecSONEGl6VUrdBIulnG5zAGfyIA+hw09U0HSiG1NeJgkZ8fS
	as66jRvYz32KwGqBdT3Ew==
X-ME-Sender: <xms:5y0UakO6fyx0UnD78Yga_6itwTptxxCnMZpmUdxHoAvwHhTYzuw3Sg>
    <xme:5y0UaurB73ppvuevlj_D85fAUuaph9BNPaeOQHJIDmUfnkMpX0MdhVYymLaZoW-8v
    ZGALznySnkwoAteIW9YJCxnFo2SkfAxnq3XLUkai6JVkVltPqOI>
X-ME-Received: <xmr:5y0UalEnybjGJ3832VfUseINnLPz9v_jecutKSIMb-XOTXt8C-K6KrsLSDxCFDO36hSh5TUrr8JBD3Gp_7xCXOubA2_MjlYkVk2g>
X-ME-Proxy-Cause: dmFkZTE7vTV6V9JaqQYfY7+0lSiyeyTTXXJV5Ee9KWJZnn39SrrcbV4VCvkw498wBm4AuL
    cEgGd1Y21laYKADI5c60xsqrsmkYsWxstzPSE9HQ7Y5D9O7L5f8kiiLVqkxmLHgmyuhjFe
    JLlnpX52YmY6pXdvMgURxbVztVqcFNNSBNlgQnilAyn69ozvYi9nuJlhUH6P6rE3OhyBMZ
    FMxojS++tznDgltaMeBlOgpeaHvWM6egi1vJWsjfWZw0Tu0lWOzufYBMJc9JenHymzF92X
    n1XiLNbQ+OEXcpNRzPpINcIdd5yFZ6c1NBX6kAjY93FvDsR9h51D1vUxh+GP8wpm0djatE
    Mf3P0wt9N1sYaANwhyaVKVXpJK9ruAe4rtddR3JhHhjikIFG5fRQjdllMY2PlJwa1Ylyha
    +JpdLO8xN9dH5xdb/CNSsRTGxWsEGLZvTQR+kY153i1n99GrR78oitvaSMv9l2sMU6EgjJ
    A0Wd/UyUoz29cw7w/7dd9tiDsg4ENeISq+7MO0XnQICGk87rGnwkVXtQQwEP+Jym5VORqZ
    IUH5LGndVe8egq6gymaFCmY71dV+cMm2dsxKIxTRTi6kUuyAyFXgdGBhkgrosAAEi61DBz
    CrCTGVW/U3G5hiE+SXh59og0YTNtw+fcJHF0+5epO+HV/BYKQwSiexvfy+wg
X-ME-Proxy: <xmx:5y0UajrzkcfMATtFkPVFOMPZDKLRgv7Gw_xHka_Qs1jb8AoI328r7g>
    <xmx:5y0UauZ6mAUUFaFN82LOQc1yFzraSEy85ZgeoobOdNjctq6Cqmn34w>
    <xmx:5y0UasUWj69prxC6Ni2M6Tkm5OfTPto59HCzLjTkR0wAI80ST0hgOA>
    <xmx:5y0Uan8mBjABCF2MGZDu0IbzIThIsBv-444uIMTN3-QtUHpBMZb3YQ>
    <xmx:5y0UanEglDd0AVME7aDEhbfcF_v2v3ylmb5WJdRbp1LPsel4-sFLYp6J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 07:09:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: kristofferhaugsbakk@fastmail.com,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>,  jn.avila@free.fr
Subject: Re: [PATCH 0/4] doc: hook: small improvements
In-Reply-To: <87fr3fsql2.fsf@gentoo.mail-host-address-is-not-set> (Adrian
	Ratiu's message of "Mon, 25 May 2026 13:58:49 +0300")
References: <CV_doc_hook.6f0@msgid.xyz>
	<87fr3fsql2.fsf@gentoo.mail-host-address-is-not-set>
Date: Mon, 25 May 2026 20:09:25 +0900
Message-ID: <xmqq4ijveoey.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> On Thu, 21 May 2026, kristofferhaugsbakk@fastmail.com wrote:
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> Topic name: kh/doc-hook
>>
>> Topic summary: Small improvements to git-hook(1) and the associated config.
>>
>> [1/4] doc: hook: remove stray backtick
>> [2/4] doc: hook: consistently capitalize Git
>> [3/4] doc: config: include existing git-hook(1) section
>> [4/4] doc: hook: don’t self-link via config include
>>
>>  Documentation/config.adoc      |  2 ++
>>  Documentation/config/hook.adoc | 19 +++++++++++++------
>>  Documentation/git-hook.adoc    | 11 ++++++-----
>>  3 files changed, 21 insertions(+), 11 deletions(-)
>>
>>
>> base-commit: aec3f587505a472db67e9462d0702e7d463a449d
>
> LGTM as well. Thanks!

Thanks, all of you.  The topic has now hit 'next'.
