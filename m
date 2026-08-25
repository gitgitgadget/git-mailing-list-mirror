Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CFC3803F1
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678412; cv=none; b=YUYUFqkG4McAy4h0jc2gn1LtuMKR1HM9KMyG9f8fFLaSuzbBQJVREGWfuK8vhiHsnPtQ8Ud1+I5g0lxGSEJCips9MUr81Yi78oZc411rcOABWaytg9oI725n6ihOTAGj6eD2JKakbhhNg9G5Gg7bVZLOC4XD3LEjxd2JX5wgn9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678412; c=relaxed/simple;
	bh=7OEaQGDkSD6ohD1cA5EcCyrWkWeAj8WG38130yR2aoM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jjHXzpp5CxvmJTBXbt9OhTbDi+iKR1UdYhRjfp0XHSXdLFOuONJeJrUZvykmABTJRNwg1ksH8RuSWQy7EeS+frMWmUnIOQaj8F/PlnZHq6AOUUsMLGsR19dZwhLOk9eaNqLmHNMWOFs73qPL+vEA9HO2SpO+6hiKyZoTf0jBo7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V+tP6agT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IY8Yk7+n; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V+tP6agT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IY8Yk7+n"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7DDFF1D00171;
	Tue, 25 Aug 2026 13:20:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 25 Aug 2026 13:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787678409; x=1787764809; bh=u/Br9B6eTE
	2MQLQvQ9CYFwedfI0a6sS/+Pq181e47e0=; b=V+tP6agTkoyVo5EdnbBnDptjHe
	GbmeLdjsKlr61nO8Ee6vUAI62Opmky02BY7lb7AECKHVEEV+Efgc97hhH6aggnCz
	MFj1iKPNKDKu+Zw2tJRuDkujdxf6Hzbb4DToehhcw7E48F/bDWYzkwsVQgsF2oGZ
	RvX/ELP3vnHjRKWc42EMotHCi0C1I7AQBqrlCIUeSV8FylrRGLlIJhjy8OrJ1hQ4
	epTcNuO+lQ3/QMuHE16ptjfXdNIZWs8Lxmpo/Iu8gdyP7rVCxichXzCl6ul3sbkj
	izKwkv96rAEHXj+j80TMc3kp8erPRTGCTolef52g/Ure4pzUCB9qknHmgGsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787678409; x=1787764809; bh=u/Br9B6eTE2MQLQvQ9CYFwedfI0a6sS/+Pq
	181e47e0=; b=IY8Yk7+nhm8d6U/beYQMjL3s5CnTNioOn08TOr44U9rws/LvHAY
	G39cV4sBverIF48m+0InbTnCyB1jFNbRermr8G+wxVplppQ6/6auOqaQZZ/Eb59D
	ppiWiXbIlrW/2H8/TFbJUiPbnLrebuoRh9kumUjeC/9JbdtRmFccHZc+LZJC58wo
	zdbnNgc4lZo+lo+8Azki0LElcFermd+7Tb9eBcyhBkNbWpsp+/7KmDsnZ4UUtu/x
	3en4JWbDF3WnMCK3l3W0nbtZbsbU/B1CwY8caqzs791JbQSJM7TKZjU0SYaPcL9S
	lMT2wRX5VqEp2JVMNxR29Bku32N6zuESHxQ==
X-ME-Sender: <xms:yM6Nap_sSuRMwycpae6pL7zQ0W5-HlyEkoPfsQK1q9a6h0peqx06JQ>
    <xme:yM6NaqSA3QBBr56OIr-nuEOD8OW53toHfisGLCSVt_soFxo8TH3DBd3rFCNnXkOIz
    lBl28PiQfHZKUklbsbSv_6U5kvScsxT-1bKmFedw09lK7GqNevx-vw>
X-ME-Received: <xmr:yM6NardWuaImtGAyjcMxg2gXwz8jtonCa4eUUwKNzdJU6DhGx8ii39ge98q816Bi4ldrVDK9ZRho0DI-sABF21LxIY1NxkLuAw>
X-ME-Proxy-Cause: dmFkZTGh9JP5460z3eVdR/YzVdKk0Qac//fS6eOtFtF54iQaDR2ooRoTuWbThsTKg0WM4H
    GnQFM84/A2QwcSeIFG1s0oV1ojg0t0tL6/9OMpHiz/qqjRWXdmcG2OCxXUlwauIpXn8D6z
    rSRTUGXPHZSC0CR4LeATzL2p2qzyLtMe36IclsyBC3P5z0WZeOj0Lp1ypSYDBS0lUKrpDU
    50nmNl3spisAbI6t0rd0K3QJCDjq/2GGtI7CAZbO52FceuI/SCo+O1u7T3NEaZK2Uwq6c2
    8wJiCsrBXJo4145Z7IlCWuzHGm2kRC52Y5giVdW+0aX50Q8H5jE2Rkjw/dt72sbuI216X8
    2pMnc76QCOVmLcs22u63q+N2lkgS1HZmyhngln17SHkba5zYyEv7yxpzwhmjze4kxKbvUv
    1YprZNjIcE9mKyT+PqEENqMKWxz+ByFSCHsJ4PTW8f2ITVlT848gRrrHoF9h89qKe0FY2+
    8dnVaVyROGxDKJ/TuH8kStG2tI1ssSttzJ0W05LpqZjohip6p1FyRyIfmxAChWPFmvnB6n
    qfcQ8AZ1VpuBdHV2pKuXkFV3nAvJdtFuaCniaf/ouNT0Ybu0d8KFOfhJZiS3Y66MGw08v4
    ci8A323c4AdOs9o3xscClPkkSiAFeXLAxfOkNmIlP9swp/mOhGK5A0GSALKQ
X-ME-Proxy: <xmx:yM6NakRX-58WO1fM2uOrmyT6RYTR2VsmPOTbgKYv3McFFuAiurtS3g>
    <xmx:yM6NavIXObUAeAndNuWloYHWQnzzUqJUrn4-A4Hy9Tw0qI6gMK_rQg>
    <xmx:yM6NapIV7Tz55Gixc6m6_j81o_GkwXrQyZlozc4lOhl0QPe6GYO-kg>
    <xmx:yM6NaijEqwTrzVL_TKKBGMvmA_Z6f9OZVNF4ymlQzkGJtOdabB3yQg>
    <xmx:yc6NapNDHIJe2GLkWPxmZZOaKgbrulDmdz8s6wt4306xaHBqhvswGVAB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 13:20:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Matt Hunter <m@lfurio.us>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Tuomas Ahola <taahol@utu.fi>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v14 7/8] history: create squashed commits without editing
In-Reply-To: <39664e65-6997-40d4-83d4-1d2cae27ac50@gmail.com> (Phillip Wood's
	message of "Tue, 25 Aug 2026 10:08:17 +0100")
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v14.git.git.1787249432.gitgitgadget@gmail.com>
	<03528d3b34c202b990cc42865a009a5786255b7c.1787249432.git.gitgitgadget@gmail.com>
	<xmqq4igov9h9.fsf@gitster.g>
	<29ada18c-b849-4bc3-aad3-b4fdc09c81f9@gmail.com>
	<xmqqbjarsgjd.fsf@gitster.g>
	<39664e65-6997-40d4-83d4-1d2cae27ac50@gmail.com>
Date: Tue, 25 Aug 2026 10:20:07 -0700
Message-ID: <xmqqik4ym81k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 24/08/2026 16:07, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>> 
>>> On 20/08/2026 21:10, Junio C Hamano wrote:
>>>> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>>
>>>>> +	/*
>>>>> +	 * Allow "fixup! <hex object id>", but not "fixup! HEAD^" or
>>>>> +	 * "fixup! main". If the target is not being squshed check the subject
>>>>> +	 * to allow "fixup! abc123" and "fixup! <subject of abc123>" to be
>>>>> +	 * squashed together.
>>>>> +	 */
>>>>> +	target = lookup_commit_reference_by_name(s);
>>>>> +	if (target && istarts_with(oid_to_hex(&target->object.oid), s)) {
>>>>
>>>> Why istarts_with()?  "fixup! ABCdef" should not be accepted, should it?
>>>
>>> I agree there isn't really a compelling case for mixed case oids, but
>>> accepting all uppercase, or all lowercase seems reasonable, or are we
>> 
>> Tell that to brian who wrote the bc/restrict-hex-to-lowercase topic
>> in <20260729233215.398654-7-sandals@crustytoothpaste.net>.
>> >> planning to completely ban uppercase oids as brain has suggested? The
>>> aim here is to accept any oid that rebase would, but not accept ref names.
>> 
>> I understand that we never emitted hexadecimal containing uppercase
>> letters ourselves, so 'commit --fixup' and friends wouldn't have
>> added anything that requires istarts_with().  So accepting any oid
>> that we would have given the users after "fixup!" but not refnames
>> can be achieved by starts_with() just fine, no?
>
> If they're using "git commit --fixup" then yes. If we're going to reject 
> uppercase hex everywhere then clearly we should be using starts_with() 
> here, but if we keep accepting uppercase hex elsewhere why should we 
> reject it here?

The point is not to add any *new* places that accept uppercase hex,
and this is to participate in the move to discourge the use of
uppercase hex.
