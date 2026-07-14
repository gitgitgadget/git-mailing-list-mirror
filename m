Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED63364953
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043297; cv=none; b=TZJ+jWURAMogc+rJcKG0V2K1ST95WTpsCqPWBmbdTqlZzuNw0923+hi4mYuA1NpRCjJ2URYOTlpf/+OaJKjQKKx4PwK+chaS/qvp5ttG1uT2gjUnqZIYoyXSRqeE1P/aze79ORT8+dTnecu/BDP/rAGEykYCddR+rmXDG53r1yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043297; c=relaxed/simple;
	bh=MEEa//wuMm9KwUh1R1vQTiVC+m6efJjLP5HQ38sEoBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p2TVt05VoNep95dwgmt1+UEjT5wvu4MaZ/+GhxyRSGGkyMAB9DiPoTJoBliS+hScgcmxVlpL0/fkr9kP2ilMuqsn3bXoJSdDriR2h76VxnkT/Yr5q+KWyLfa/lkVdia9aGK5D4L3YlA9l5BHDqSVLe1JLWVIrEh9ydzgKzu/xlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ab7OdUCs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GEhtkovQ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ab7OdUCs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GEhtkovQ"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 2D2F1EC017B;
	Tue, 14 Jul 2026 11:34:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 14 Jul 2026 11:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784043295; x=1784129695; bh=zoOIyg5SIh
	3k089lFFr8k8zqfouTWO1cZ0rlP2DP18k=; b=ab7OdUCs9k5HTB4KEhp9aCbx8q
	CfD4eZ1ZL9eGSDcm3/1L+FVesddCs8umoA6GovaTnQHPMwljofMELkXeG/3jLlO+
	fLpUUsN1AQbvANNDKmG/kB7NannQZh/TLZnhKPadnPhaxAHc3f8rLL8G4R+kQKAX
	5OY+5KZeFUvnLqidGnBxNUNe+wuhIsuqTSMCNRJlZU7Sb6bWtrgpylQJl5N5vuPJ
	0cJDDp7eqicrejP/6hhmciL/c911u/h3ePSqQS/7i6veMZ+UdGrkBOxi3/NtrTO0
	2jG/mlD8yRwKbL2iIN5Jx7ZsPW/3fpMPiJx7I3yFgSO06jkWz8UByABsva9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784043295; x=1784129695; bh=zoOIyg5SIh3k089lFFr8k8zqfouTWO1cZ0r
	lP2DP18k=; b=GEhtkovQ7/arDqy7FBk9EFpA7yRn9c5tZ4WxjWdUPoMZDc9Imee
	A03iUrj2zjj/Rr8Ah/e3tT3sxoCDhnccHFkQ+XBrZQLo09Qy4z+VEObhGmdAXve8
	hXAnIkkftdK2vXbhIopxP4MqpD2mBBA4iwavwBTbUpLrr3ry/axh9zAQLizUmP3F
	eLjfYWrkUa8EFwV1ajbMtDixWWy/l1KxzIZTYkmnR2XcUUMQDQ88zGGSmLBLLB2m
	WGa52j/H5AnRsK/D4XcJR6D2J4BRvogeXX/gE19j8F9xcMlfNI65J8ZwiKK3bVG+
	k9abyoFp0MEqpzkBx6aOoGsKJzvm1M6/j6g==
X-ME-Sender: <xms:H1dWaju9-V0n_tRkycrIjcK9I1kgxpC8vpxwUsFXHsYhjaj_CZoiiQ>
    <xme:H1dWardU62IZPkGMWgXk6rsIA49k2jFJ_QdpPplfbo-ATb15_QzDRr9e6PINUHvK6
    H8jOuFqEIhmZKAsNZYyD4POhFxYPdVFDwEd9Un2YBzTxjRJiAzGVA>
X-ME-Received: <xmr:H1dWaryJ7cSQHQlUz49YCq9fVylWBDPoqZW3ygy4vaD-tr5ZNFFzh2og1XH0VIHR1usZsnoi34JTiHY3R7msEAwL1KRyBRWAmbHo8XY>
X-ME-Proxy-Cause: dmFkZTFpgfZBE1nYwDmlhBCm1PpOWHh+yE5bfzWaeEoLl4QXbtooPd5R4Ses883HDVrrVi
    5i6dMp+a64ICJpr7lRtDJ95ppfeDLeXnYTXI/FTsrDRNVN272Wjx+DrYV+6jlBVQTDGiOU
    CZCii5tUdAf3slku6sF5/oLaVACeCki4noWIm8K3xYk4R011LMjWFcR8bWKvVbPcOeHckd
    VpphIPsrC4qEDBnZilZoVt0LjG222LnHbcY8t6/a9Rf/C3B+DpHaJGZ6ctjHZPIZnPbsSu
    H7syPtgIMqHRyF1Qdbt51meHRKoqCpPpP6oL3ltm4MLBvx5GF20eqFMg5/eOPZVnmPo4P1
    8lndRxilWLvrtThgnmiyk9cQ8+Q+PyCjooqiXK6N6lXGbocRT6MX6wkPt6WwFk2I2b1dO7
    UKreP8KRDGLO5E+DbHk9m/Fh96vsZy8AIO+0+9UIlNmDEYsZjCOHoorjVTuwZLp3qqaoX0
    GilSm8ZX2FhG6aD2l4yZjDSzBg3f01qkBd78X1O1vsCLcL1hosPNfI+vtvB/4TOeQCWcKT
    A+R5/vPHbpjAMeFcvCo8ld0GE7wW8ROc3ZaoRNcp3OEGbOvxP61wO4NPOcVTmr870jGlH6
    nphMm/eGh72GfIpqo9yCFhCRF5HIXhJUPZjBeP8x/MdRn7tPF3hVj1ohrYGw
X-ME-Proxy: <xmx:H1dWahGbUh0Nn2FA9ejpDqsq2LgZ9pO7OKtCEwdmkmqieL20CZJKZg>
    <xmx:H1dWavyBahINh0TVb2_W0PgyP2LwoEXCOpHadsx_vri4MUNnPGFXDQ>
    <xmx:H1dWaisOCDMKZXxtPWW0cNgyG1fsTCbZwsO2Sx2wZINIzrjMuwrmOA>
    <xmx:H1dWas29t9j6P1K2tk6HOwyk_kOPz1mbyHTk1af_8hUnnby4mQHSyA>
    <xmx:H1dWavSy--QhAeIE7COyEc_vVsOM8pkDzH8F-g2fDXwjZo09xNhkvBuZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 11:34:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Shlok Kulshreshtha <diy2903@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] t1100: modernize test script
In-Reply-To: <alZADk3gB5GRxUiC@pks.im> (Patrick Steinhardt's message of "Tue,
	14 Jul 2026 15:56:30 +0200")
References: <20260714071633.35446-1-diy2903@gmail.com>
	<20260714122033.61947-1-diy2903@gmail.com> <alZADk3gB5GRxUiC@pks.im>
Date: Tue, 14 Jul 2026 08:34:53 -0700
Message-ID: <xmqqh5m1vb36.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jul 14, 2026 at 05:50:31PM +0530, Shlok Kulshreshtha wrote:
>> This is v3 of the microproject cleaning up
>> t/t1100-commit-tree-options.sh ("Modernize a test script").
>> 
>> Apologies, v2 crossed with Patrick's review of v1. This v3 folds in his
>> feedback as well.
>> 
>> Changes since v2:
>>   - Patch 1/2: also drop the extraneous blank line before the "flags
>>     and then non flags" test, as Patrick suggested.
>> 
>> Changes since v1 (carried over from v2):
>>   - Patch 2/2: reword the commit message to use the present tense, as
>>     Junio suggested.
>
> Thanks, this version looks good to me.

Thanks.
