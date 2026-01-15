Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D9C31A7F7
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 20:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768508829; cv=none; b=KWyQHey9EoCspqCxtbPGQJDiI/Zr09Kdiu0Sea5uWm2/AxNkh18/Yzr7FXs6Z5vdy/h7767toxJaMsGAuHhzK8a2OUDfq/4MHqpQm2N8x6OGYSoXnd/4QpulfL5hqjohcN8J38MYDUYzXo8mae0ZJ8FuWS/1lNfWDI5Uu5VW1aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768508829; c=relaxed/simple;
	bh=ad/J7+pLtLjf5jbDqae3KRokHJKN4Y3Uav/Mg0LnSIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OW1cDCL73OBf6yMe9ZWcSB0zdgouglQmuEUExGIXqzITBbIk3RtSZT92YZrbZK70FNxrNMyO2VqSRr44I/VnGl61BRcYdleni0FFu2GGTos5/6MjLiCkEuZqbhgZBDZUTh2mJxFChSgTXN+9dNr2bjYmuNiH4AX+al2mUch1b2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mi5XkKWd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RV37HWLl; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mi5XkKWd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RV37HWLl"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5B29D7A0063;
	Thu, 15 Jan 2026 15:27:06 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 15 Jan 2026 15:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768508826; x=1768595226; bh=89vkCpH+Gz
	6BK1ekk92x1o7CjtyBiwXtJq6dCfK0kCE=; b=mi5XkKWd2j6In7hMjbtKsiVRGD
	bQ3pPKfDIGSnxkkVE17tkIuzxyeMzxxSirrt1IwejgL5Be7wDCXWqbLtAt7+QV0R
	KRWv5ZDaMSVcoC18vQOslFLKh60fTNPru0ehuT7mshtLWmco1xsZ7bWGI2pskC3t
	9Nfx74kiOsNqP4MEKjXDrxxnXszyR4VaOVTEAlQ+aCdr+jnCSfatlg0shdLxhuV+
	iwMlB1F/3A5QqKl5JEumFALJfNUdh2m93hu+/vAF9KO+eH5r+z6CsNF/1HFbQvoc
	hUY3SyHjE8AnEM0sxfYe/sJ01Czi1Fw8k+qGfID9L3osJx7XgWRtDJ1LhcFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768508826; x=1768595226; bh=89vkCpH+Gz6BK1ekk92x1o7CjtyBiwXtJq6
	dCfK0kCE=; b=RV37HWLlm6j7FncezD8M9Y+afaw3hGnwKf6pEw0wtRg4LOdJpAC
	cLQxtxx/j77l6Jxs18dSv8SWKen8Tx0R5aAN4kfUCuEtyADAMi12GF8QjWDGOQOo
	Qq4GBphg9E0TdiJO4PhwlLS8LqZqM0MYeDkBE2Hzn0zVAVqJvh39TXJzVBCTGwhl
	Dt9MAQM1yce3Fh095yu0y1nflg0E0Kuj8sgUjuwU4JwlnLBKSj7dmQZQQ582AB7G
	VNtsx+cJJw5BW3Rj4v7Zkl/F6DH+rfkZn4tR6zAGgFo2HBYFAuBR19OgBP15TbfP
	PkbY1Xmm5ON6agJQXNZ6T+/BtvyVb0e52dg==
X-ME-Sender: <xms:mU1paSYDIOASVzcOLgihp03zLBxOiqdcqD1R3olf85sr42gXuX8fiA>
    <xme:mU1paUd25pkjOvc66z8lZUfzAIlsmfj5t4bqODtwocyoWHbYN28GAv-YRy6KN7iSa
    1VB9LvDNHuc7ltwudi1zepCH1ef5E1LHJScfX762xXZLg_9c525pg>
X-ME-Received: <xmr:mU1paTLkZMSOTqOScxPVOCdjFpesWcdjLBP8181ydUAWOrho4JEe9XfG0V0ie0-9Yjq2_3dK1a3aRRbXKg8nvh8afirq-iTuiYUiyFU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdejtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggr
    khhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtoheptghhrhhishgusegrphgrtghhvgdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mU1paRIz-3K50etu1t4DjAVe2gyspbAlqrHD69ztj52xL00fui1jGg>
    <xmx:mU1paSV5rX06T4li6u9pMX_bI_Jg6nqjg4aua6uxKQuoW-4b6GYbDw>
    <xmx:mU1paanQhwI33fjVyhYDtZMmn6UHvMrXBZqG-cz471kAmfBYXdB7uQ>
    <xmx:mU1paYn-2oXToKEfVVTfomaJByOUn82SzNxaskGvB7r7yQeBSeGhqQ>
    <xmx:mk1paTk8sXQf3L2zD3b_W9I6lXzdW8wCmNmwRqHzvVCRJ4zV10SyuE4l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 15:27:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Emily Shaffer
 <emilyshaffer@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Jeff King <peff@peff.net>,  Chris
 Darroch <chrisd@apache.org>
Subject: Re: [PATCH v3 0/2] Fix two hook conversion regressions
In-Reply-To: <87ldhylq4e.fsf@collabora.com> (Adrian Ratiu's message of "Thu,
	15 Jan 2026 19:53:05 +0200")
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
	<20260114185731.2381550-1-adrian.ratiu@collabora.com>
	<xmqqpl7bc68b.fsf@gitster.g> <87o6mulrnq.fsf@collabora.com>
	<xmqq4iomdbn0.fsf@gitster.g> <87ldhylq4e.fsf@collabora.com>
Date: Thu, 15 Jan 2026 12:27:04 -0800
Message-ID: <xmqqfr86bp0n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> On Thu, 15 Jan 2026, Junio C Hamano <gitster@pobox.com> wrote:
>> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>>
>>> I agree with this.
>>>
>>> We can't let these two regressions enter a release, so we have two
>>> real chices:
>>>
>>> 1. Merge both fixes to 1.53 or
>>> 2. Revert the 'ar/run-command-hook' topic merge.
>>
>> Hmph, at this early point in the late release cycle before -rc1
>> (yes, rc0 is scheduled for this morning, but that is not really a
>> release candidate that counts as anything), it is tempting to take
>> #2, actually.  I just do not know how much damage such a revert
>> would cause to the tree.  I'll experiment after I finish cutting the
>> -rc0 preview release.
>
> I do not expect any conflicts and, if there any, they should be trivial.
>
> Let me know if you need any help.

Thanks.  I think I got

 - revert of ar/run-command-hook directly on top of 2.53-rc0, which
   would become the tip of 'master' tomorrow.

 - rebuild of ar/run-command-hook + two fix-up topics on top of it,
   called ar/run-command-hook-take-2

as the "take-2" topic is totally outside 'next', we can rebuild the
entire topic and get it right the first time, instead of
incrementally fixing them on top.


