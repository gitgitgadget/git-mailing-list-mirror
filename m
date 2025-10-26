Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DA01DF99A
	for <git@vger.kernel.org>; Sun, 26 Oct 2025 00:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761439052; cv=none; b=qJ+oguPIv+J+DAE/CJiMJ8CHm9hrCiaQczPv27Lgsxtb5CxtwBYzycmj2iNABHXarHrg0MKZvJ8YUZdqPy4lYo301PbLnPXzUiC3FQE4mnW3J9M9F4cgiOFb9/XQ5zMxsMxZafwjB+eb+LVe+tOPLOI+4peSQiuL/BVTjc/wZVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761439052; c=relaxed/simple;
	bh=pt0zZl2cG9TJT+t4/zwq4JJKA/TM701Z/abwKeDxUU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gyApY7T/nbeHBVvGKwL+HYwzXtkZQRSomgNVIGvvrGqidIjoIrc/8a+/gVAGBJoVfZ0i3HJYm1QL8TEzPEZMiXdSN79AxYjSm0CAKase+Jlm3vH/VRLhoI0m7ZL97QBOsgdJrD8uj1N9ePe32h4YjcXLkk07ZJ5Ci1wSBKasLs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c4wGo17V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rD8CWXaQ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c4wGo17V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rD8CWXaQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9C77914001FF;
	Sat, 25 Oct 2025 20:37:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sat, 25 Oct 2025 20:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1761439048;
	 x=1761525448; bh=B7gh0kgS5ZMS0U7u9kEEyo2lSwd/F0Vul/LznIBSdVY=; b=
	c4wGo17V5jiwv0kZqPnuA9ZSOfT8zOF/Y5SAmk3Rx2ijOrXkQJogHkTqmOFBhJDY
	4OTEW9x4yEBcCW6t0FKNdwcTFXeRUzUAJTMbaDu0wRoNCTH46eWPrOlvNQ6QY8nL
	FcB5svpf4fH+lVCX+BuDUQtbRrbtB+cAtJpIQr5+7uuMO2agcsvMg6VySfXNBbnE
	iPU5WZoagSFl7l3kDgTdLeU01AWW1Dmj1/Yli4lMhqhhajYWcyBsgmZB97vn7EYA
	Mv75ImJZ4Ibw2Y4ZENldeiZ45RmoApeaR30qK/FbGkGC6tKK9BW0KcASDVNpcRW6
	iv7bJVt+5V0EMA2jrfewiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761439048; x=
	1761525448; bh=B7gh0kgS5ZMS0U7u9kEEyo2lSwd/F0Vul/LznIBSdVY=; b=r
	D8CWXaQL46aGvInChJXtKFKEann7OOPAn7vXs1sOkkdnI7s2/opTx/os8UZ3+5Va
	t2TirF4Z/+Rc4xjCz2mznh+pig/8wCHMDT/yJfcyMRERW7CeNTIFKLOhaFlY2HUR
	lR6dhyfZ/buDhP2mtQ9rvX23J8h9DT/0yDw6H8Pzd0YeZzBjtJVWkxXb4agYXeac
	xSlctEbVb6xUesogfT4r4SIhCj0uu3ATsbJeDIcmKwErDr5uyA9XTxCwBmElOQ+1
	kQGpuQm6rwKg46qR+OAcDf2KptYy25Bu3vABXD9u1hwuzB3lgzjooU8XZ/hWYFpM
	utff9dnZadDPoLj6FuctQ==
X-ME-Sender: <xms:SG39aHrwy5OWQH6OKzt3zipXVV2zSooSEbFMHEWxNBTfbUVwJIglpw>
    <xme:SG39aJH3LFbFTEo61UEGXTexqdMOw7W2hipXA5an_0QQAMMhItzz14GOEw1ECvG-b
    nLPEqVr17gz0jRs3EmjlgEovsr2RVamQWi_xqZ4suVPe9GbODUHCQ>
X-ME-Received: <xmr:SG39aBm3u0NgU07iiLHwWAMCb9HXNhuLw8nkOiKAWMa_ib6Ov_pjCPUfqQzgtAp8MvTnICsnb_2d2L6CbLN0mYoK-ASYUQkoxPRK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheefieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdr
    rhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SG39aEnvQ99MEJ9kDVkIFrzuVLpeN6BBA49npkJleOSFLSGJcfKorQ>
    <xmx:SG39aKvzlWhfUpyWRzYRq84x6J4j2xZezp3HhHScIQcYxstr0U0vBA>
    <xmx:SG39aPni-TbNdAfTrAiRaqTIOGhlo7gPAklF20rW_459hUl_s9cK9Q>
    <xmx:SG39aNtjsIOlQRHJh3Rt7-nstoXFb_BOM7JWihU963qWle-bVhUb8Q>
    <xmx:SG39aH2uQSUsp6HLpO_NV9J1PGg_SlcUAm2G9rKvc09XMLP1gk4SdNxB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Oct 2025 20:37:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] add-patch: quit on EOF
In-Reply-To: <06b8485e-1e64-4c57-be3a-34b1f900c526@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sat, 25 Oct 2025 19:23:26 +0200")
References: <0985f775-fb01-4de0-99a8-4775b602829a@web.de>
	<13529bee-1e02-4c20-9461-6569312bfe4f@web.de>
	<xmqqfrb7nebp.fsf@gitster.g>
	<06b8485e-1e64-4c57-be3a-34b1f900c526@web.de>
Date: Sat, 25 Oct 2025 17:37:26 -0700
Message-ID: <xmqqjz0imrax.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> On 10/25/25 6:20 PM, Junio C Hamano wrote:
>> 
>> I wonder if we want to 'echo" something in this case, though.  If I
>> say 'q', whether interactive.singlekey is active or not, I see
>> 
>>     (1/1) Stage this hunk [y,n,q,a,d,s,e,p,P,?]? q
>> 
>> on the last line before getting the shell prompt back.  With this
>> change, I won't see anything after the prompt.  Perhaps it is OK?  I
>> dunno.  Perhaps we want to pretend as if 'q' were given instead of
>> EOF, like the following?  I dunno.
> I'm used to no feedback when writing to a file using cat and finishing
> with ctrl-D to signal end-of-file.  So I don't need a q "echoed", and
> would actually be slightly surprised.  But that's just me.

I do not have a strong preference either way myself. It just looked
a bit abrupt the way the session transcript ends, when it gets shut
down with ctrl-D, but after all it is a shutdown, so it may be more
natural that way ;-).

I am kind of surprised that this EOF behaviour has not been brought
up until now, and your patch did not have to touch expected output
of existing tests (certainly they are taking prepackaged series of
commands but I would not imagine all the previous test authors are
careful enough to end their tests with 'q').  Perhaps we do not have
enough multi-hunk and/or multi-file tests on "git add -p" and when
the tests react to EOF they were already at the "final" hunk of the
"final" file and nobody noticed the unnecessary output to skip all
the remaining hunks and files, perhaps.

