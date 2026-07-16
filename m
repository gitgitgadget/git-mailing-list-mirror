Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC44324B06
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212608; cv=none; b=dKx37VgmOjZYjj65I9Lmd80yKNJ463HJ2sfmT/VIh2SrwrHMZ5zN039XhtR0AJkTPVVaHBjWZWqpvfyTiKKDYY/jyB++3ATjxQTBof93XzvlBF8oe8qX/1CUadKkv2vc20blXqTOQHa5HAtbptV2Zp6Yi5XCGUd+tqMHpdu1sP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212608; c=relaxed/simple;
	bh=BoZTSmoF/9YPb2+f5cORs1yMn2iAuHOPyAJgJ2ayrko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nVYzgt0i0BSnZnlRkkA7GoEm10uA5MLOqtR6808GoqdctoaTCMuMeVLhcHSk4M3MzksZ6F/Xd7M/RxErgC91GWfGhwGEurwAmVHIWeew7RD2z62HtTFM4mzvhWscPQ0Ne/ebUkkM/Sr5z3ZXRLqi2T1qa5VVNmg5w3/ZOCPkr/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Cwdj2VXM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XGUw4NDg; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cwdj2VXM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XGUw4NDg"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 30BA8EC00AF;
	Thu, 16 Jul 2026 10:36:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 16 Jul 2026 10:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784212606;
	 x=1784299006; bh=J08QMAxe0Mj/z9QDR0Bn/92cok3GAJUvWVgWoFTzpOE=; b=
	Cwdj2VXMDhKZONoyjFScn/E9tUO+Gi0KzJp8u2ZSNdrNB78fI+3z4gynM22HEr/d
	fMZ/KdnBZvMTluFiH6Z+7ptjniZahQD0wG9+Jvoh9Xnp0+bgr8y3CWniXjJtCgGP
	v8hf5epIaZnK5vCYpu05FikY6Ca/NPPCFy0UGeLzIeQxzhwXQAg81mVGW+VzYtdR
	clP0Jy6m9iIHRpA2Pdl9hgsYcfwTp/Dz63Owrm6f4Iuiy+JmN6oDkx6Udyyd4/YA
	rbjChPVSKinXHx4EdQpaOTwR3FLi5GmNEJUBQVyvb79+ehW2SRBqeRq3MtB8U0KY
	Jmr6E0A0a+sBWxbU6YUiNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784212606; x=
	1784299006; bh=J08QMAxe0Mj/z9QDR0Bn/92cok3GAJUvWVgWoFTzpOE=; b=X
	GUw4NDgY7lYLxgKicwNDj80KcDmVscSDHOd3jqs1tGt/NarnBsINvRkT4vu+XoJz
	TKX0+ZkoYiMVZ9vhAXImoqKOmNLapdY7tq4+uLwYtXLggxdk6fZ4WFpTbW5TwX6R
	LWDO16JsZ7E+JmS/fURTPsQUPMjRnKwPMxl7/x3oS2S6JMnF8SMVOIq1hNoUt/LG
	pGh4v6osqXNDU1rGq0EiWMd1I/wsyHrJ4S6xLgs3cMcf73wyg0u6L80GSftTbmRI
	lin42WMLS6OadLU0M8HYDnDWo2wKKVXmLAY73BfF9jpVya/6q/FfTRva7VuGpFmS
	JMxO/BmmS3XXkBqufsQXA==
X-ME-Sender: <xms:fexYaphoLT_iE9QjKYR-4Zem83gc9sm5bbKZ3ywsYP-mANP0XgdK9A>
    <xme:fexYak7_mgkZEJiYiJ_-gAyR7pHJnXqs7hYZtluKTWjeJrHwnKQRRdiG8saj3hTZu
    1HvyW0bErUAx-UuZrn5O2FNzbEsZm7Aq05LcIkHtMRbeQOMvfmM0A>
X-ME-Received: <xmr:fexYahZbWft-OfkBPKSCA6iop_or30fteAPnG8XMxhN7Z6CJ5f9Nsl3iKC_C_ZY18sw_HWDFM7UhrWjE_eJaHr39Ia4LEV7H38TgzIs>
X-ME-Proxy-Cause: dmFkZTFczj9Cl5vY3oKH6PR7SeBhSU7UlEQmi+hQA3mx746ulWWGT/39mjdb7zo8E9Vwoi
    NxB2fWmeL1RLFOR3nkJUP1IScsJHrxRPbRMKxBp9qo17OvJ7BWdPRmmZw36Ys+lhTKrstP
    ZjYhNJ25ohiJiygqTxnBUJyf5VZDaoZuzTPmu0jY1baDU+ZmDP94VpoOhpW8yjlyh34K23
    f7CFPm6nbaPQdSA/GPW/IaYLrAXQHRs1vDZKeKrXtzXO3Sq3DARglReUOJKcKhvV+K9w5x
    538bRqiW/Om6TVtt+ZRzdMUuvUMgutGwOYquNBKOVH1kmHL9HKMHMExwMj3aW6fZGm2mRg
    aB8eirYqo02Jf8fRUEB8ALRJvD6kRuMnhpLOj1sLOnH2k0XHKFIzT00ewRDWf9XM6Gy0/9
    eQUyZ/YLT5P7+LBoLvCoiIAyVgj9X8Ljy6qmDv167XLsiUcGL5on0NrZQgUf+NPNsAS+r7
    yfzDBVFWY7/2JzDtC7bM80RRX4aIRD8Xb17beTXn2Rkkpztg770jb7pdg1AKZ69NyNxsm9
    EAeIsjZEyFU/Rj2pKALBM+3qKhblZnLHDOXl6YErsloHg2TDHorCvKtM7Vj2jA+9p3Og0X
    OVGVCUiBKMgd6wZlYUPcB4bdwULZ73F758fALMZcjOyE2w5D6BPWv/WHj/2g
X-ME-Proxy: <xmx:fexYap62yt426IJckmKg8334eLxf4Wdw9Md18ObHFIAbXxFnuMiJnQ>
    <xmx:fexYakByH482EgMLhF_rMSKB3h56Qi1jwz9o7xtq38g5MGXdrQPCDw>
    <xmx:fexYavd-BQj8rzxcOgaOLc7SqmoKQrFk6KENMCG-RNdWShw9DhadJw>
    <xmx:fexYajJBVu7XkkXXuG7k3ql6l0mPDTZuqj9hbyPyVf7sZj2wOqwU_g>
    <xmx:fuxYarWpP4W3Q4fggpA99pcq8EdAmTyTE-A7VkprVz5Yl6Ga_nlevO-W>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 10:36:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Toon Claes
 <toon@iotcl.com>
Subject: Re: [PATCH v3 0/6] refs: remove use of `the_repository`
In-Reply-To: <CAP8UFD2e15P19_XCVyf-NQHz8Dj8R4UshxzWL-i6R8c6prmc5A@mail.gmail.com>
	(Christian Couder's message of "Thu, 16 Jul 2026 08:53:05 +0200")
References: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
	<20260716-pks-refs-wo-the-repository-v3-0-db0a804e0224@pks.im>
	<CAP8UFD2e15P19_XCVyf-NQHz8Dj8R4UshxzWL-i6R8c6prmc5A@mail.gmail.com>
Date: Thu, 16 Jul 2026 07:36:43 -0700
Message-ID: <xmqqldbbhuh0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Thu, Jul 16, 2026 at 7:33 AM Patrick Steinhardt <ps@pks.im> wrote:
>>
>> Hi,
>>
>> this patch series refactors the ref subsystem to drop uses of
>> `the_repository`. These patches were part of a discarded attempt to
>> make the initialization of the refdb eager. I guess they make sense by
>> themselves though, so here we go.
>>
>> Note that these patches contain a slight tangent to also adapt
>> "worktree.c". This is one of the subsystems that caused problems with
>> eager refdb initialization because of `has_worktrees()`, so I refactored
>> this subsystem while at it.
>
> The changes in this series look good to me too.

Thanks, all, for helping this topic.  Let's merge it down to 'next',
then.


