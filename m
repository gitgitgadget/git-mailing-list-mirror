Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C197738A9D4
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 12:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768308868; cv=none; b=fwTphl/phlTqjvXJHxFJH4F2c2kNXNNs24FdxpkJ9DsmHU6ZL7IhZR3oFeDBsPQrBZsUjPcR+bgrKPNGxIC1CghP3lh7UBd6k09hZk7F/9K4yViVBfRvUstV+YMOwjXDgRy+SjklVdw6FQrICrcKV0Co08JQsRl+kdAQqVBsBNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768308868; c=relaxed/simple;
	bh=pPGitv4hFyxUtdvmNTYqA8ej4EzliQ86ciTDsrOKNSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FiiC9ww8R78ON3VXqUqABnKPBpuSgp0Aocj/YTZ6l2FbR01m4vxko2mq+kkHbQp9fgYcu/q96aF3HViTICpPyAyiEHQZdP87jTRs+bOTxYozjdbpVbgd3Quqy+A/0feTBOkOmRXuBZG2FU1qTe6Ob9JyjdJgzdFEwyVO3sJdqmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eqUEVadd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GNDJHjMU; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eqUEVadd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GNDJHjMU"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 184DE7A0162;
	Tue, 13 Jan 2026 07:54:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 13 Jan 2026 07:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768308865;
	 x=1768395265; bh=C3jqc9JADfjVbnnxKxkoeCQBeTVRdvhoTmIdKHfieWw=; b=
	eqUEVaddXaqRhMVEzx2xKADtuTdLW6GaEsOSAtg3b8QmE12fyd7JfLOCfgxJ45ho
	OfDSaG8oMmbeqw0rNDbmFcLyRY2lF+7gKWfDAE/eyUlu4MHrWjj3FIreY7v8tDh4
	OQVIFjioMvTwu2UCds2I3Rd2bFkaHYET0CkzGMwz+tVhIxSIbakXRA3rtmPVaDyf
	gcv4KCX6tNGsEKKy2SwmleuvEaAwo2JyUmPNDhQNvuQ0yRrBvIR5LSiJyWTb3B/d
	CZXUVteZrKy0cao3B5RjxQzmWNK3SosizNDAb6B+nbxEkMzm1xJ57RT0o9T2lpRj
	f84AlfMxJlWO4q8foZS+9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768308865; x=
	1768395265; bh=C3jqc9JADfjVbnnxKxkoeCQBeTVRdvhoTmIdKHfieWw=; b=G
	NDJHjMUafMKHj8H6eL1/+sDSttd8VJzN5OuyOBzNT/JMHpVMWuRw2i+gh/xjKPS+
	O5qROZgWGY1qkJL4zTNue/Th28W0UgrmcusY73VzXWeF/LpMtmVw6Qffuy2hC/6F
	Q9ZLGgH7ve5LL/hAz+Hx5DJMbyzj36m3b/AfL9r62DHlBleqPrYjTizJPZ7RT7a+
	yHKbCtIWej8Z/A2QxfsJJdpxn3aW02AM9wZIRDktaKfYeJtKD90wdXU7au2gaW7h
	foo8H/XG9f/9b47pa9jv4R+ta/3MU+f0zuSeaU45l7he0GLot33Ed9+eAx7kQdAr
	55Kf4vjYKtm8u3xNWFV9Q==
X-ME-Sender: <xms:gUBmaVho7V4F4tznJhAxkF3z3fsHouCzOAUdEH3BHQ2vAMOla6oNPw>
    <xme:gUBmaX2LFBHUDMD-93r4_dyph4QeGi_sHThAIYZutQMVpTFiIWICRj76U3Xuy9TGC
    Wvr3z65Wrk0Ns7YK_x9yqng8a5W6VDVa8rosOIipBRb0fhlhIoG>
X-ME-Received: <xmr:gUBmafjnjmWSzSS_DlX2_rfuxyZLv3TNbsIBFQCAgFDH9F0Bkr0eHa-NWTO0XoLRURsCE5FPtvaMPO6-N6sIllXd8VV-g0KFpmcu1ac>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddtfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkefotddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeekgfdtuedvjeffgfehueefueeghfdtjefhgfekhffhteeiffetheelhedt
    gfehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithes
    mhhitghhrggvlhdrlhihohdrnhiipdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:gUBmaXfid9l8uXIlW5mZI89SyW9xMaOatb5a4Z-59KOgoXbP1s8bHw>
    <xmx:gUBmaSlqIc0Eh-GZnFk3Ec9zwQz-1X1aPNO5AcmOwHZJGXUmp7bbEw>
    <xmx:gUBmaQvwk-MH5ZhmazxpGVp9ntT3ehPNz0qFkE04XZMl2abXjdfN8A>
    <xmx:gUBmaY-p3UbK8ZWf0lLtYdjzxScOuEzmVzkiJHZFtCzIdB3uJXCT2A>
    <xmx:gUBmaRIQGtWx1AxgAxej_ispJF747zZTI46jCLrDy1USGdosNc16oyHb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 07:54:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: git@vger.kernel.org,  Michael Lyons <git@michael.lyo.nz>
Subject: Re: [PATCH 1/1] doc: git-bisect: convert to new doc format
In-Reply-To: <4705928.LvFx2qVVIh@piment-oiseau> (=?utf-8?Q?=22Jean-No?=
 =?utf-8?Q?=C3=ABl?= AVILA"'s message
	of "Mon, 12 Jan 2026 22:23:55 +0100")
References: <20260111204316.836446-1-git@michael.lyo.nz>
	<20260111204316.836446-2-git@michael.lyo.nz>
	<4705928.LvFx2qVVIh@piment-oiseau>
Date: Tue, 13 Jan 2026 04:54:23 -0800
Message-ID: <xmqqqzrtllkw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël AVILA <jn.avila@free.fr> writes:

>>  ------------
>> -$ git bisect run my_script arguments
>> +$ git bisect run <my_script> <arguments>
>>  ------------
>
> Here, if you want to use to use the synopsis formatting, you may replace the 
> verbatim block with a [synopsis] one:
>
> [synopsis]
> $ git bisect run <my_script> <arguments>
>

Can you add a bit to "if you _want_ to use" above?  What's the
pros-and-cons of doing so or leaving it as the way it is written in
the patch?  That would help people on the same page when they decide
if they want to use the [synopsis], preferring over the verbatim
block.

>
> Otherwise, LGTM
>
> Thanks.

Thanks for a review.


