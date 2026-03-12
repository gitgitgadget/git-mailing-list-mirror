Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1773976A6
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773342549; cv=none; b=L2yXSubpiP9Yu19J62A+/vm5s63Ob5LzzDCVbnwaaoqjY4RN+SCr4K64sgSWhZCNDoW2vJ+Dcvtv63DbwxiNPJqQf/WGAlkSlxq6KDiT6sTsylH7IvyCeMoAsCCv2r+9iiFaT01Ou5lnLzlCGmuKiaPzSApLN3TajOWtdmo5rxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773342549; c=relaxed/simple;
	bh=LSOtEgV4fdFXMTDbJmvRjE9Brxz7Df9oGj90DvLBWXA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J6R5+atMz/OPTL7bA3nEnelZnXe0xQvZKoek4iVeYM/ZdSC/gXbgB+suLi9Oy2ZZ5UnmR7XPc13MZogBv90n1YT2tx/LBPF3kj98vxonirSLHSbbhuu6dkto6ejcU9rj321FM2YITdyIS0cfFnAfYTHrS9a5WgVKsJExbuOYxlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Jnz1wx6t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b26DAxDl; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jnz1wx6t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b26DAxDl"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A715414001DD;
	Thu, 12 Mar 2026 15:09:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 12 Mar 2026 15:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773342547; x=1773428947; bh=X3kxfLeGF8
	qqYacYsU7QvzP07k87MVpKfyGHsWjo/DM=; b=Jnz1wx6tV0ZP1W0UTvF2Y5Vfst
	7NInnyMhnS8ZBqtkECRAoXp3l7lROW3i0QgFpaCS7fzdBn1BANoh1y0O6zHjEXyW
	lik2iexRz5faKFCAfIkRHGIvb/kMQ/kKFhRzOT1EGJnHpLLVzWq3vIn4pWw2M4n5
	geq8QMlEndV+airKidOI+fR2C7B22E2Q4udofbXvUrM+IplYqGVCeD2i0DF+tuQa
	6pIJmyh83QuV5DAFET/sj+4yxQBSZvPbFnaFobLnAn3chjtL42P5cjUxFSCmzOlz
	glXDKsEreg1GjI0z8hqPulG4OcQjXaJ9a3K8FVRkknMhek9GU5RYBnW4JNTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773342547; x=1773428947; bh=X3kxfLeGF8qqYacYsU7QvzP07k87MVpKfyG
	HsWjo/DM=; b=b26DAxDlgMhI3ElO/NLCc88coKt6jn0t5+4iIRtxX+kzUvCeX80
	QtXdll/jSF/zQFNovxsPBnzr7gsMEYaPIUmn00HBGLvL4V81DPEhMv76oe+A3F6X
	ojWN1c3QE119bep0O0EESx+MIa+LlrtmSlNRfypMLHbgHij2Urf+iake6z9FIt/D
	N3rkJ74Up1y2wXKWuHhvGvUr0DH3y+9ynneOPL5V5I3lIpT0j/7q83RfaiNAmF7g
	Mz7Mcb+PuGNozfnwOoYNbvVPNpC8s3exZVC3d/LvDBMfdSyzwqJkYQNnndyCUgqp
	WdO5rU9U22dJllIVxL6y4gHIOePROPgapXw==
X-ME-Sender: <xms:Uw-zabTeEN2OaqeqGOxQonQ3mIx7c0Tp_ShjjhKOWbCDsbIcPTKT6w>
    <xme:Uw-zafCOAq069XpORnj1dQ35-KCv4YuB7ZCcKnw7sPM3wb96hFE5WPIYGek-VR92Z
    TBfNgWuyYnXJ5Xw95Tuu09W67IvLjhR0KeQHG--GLWwHJkOHg_uoA>
X-ME-Received: <xmr:Uw-zaTFYBse5EvOQdbCIp4j-taKA-twADi-5qJ_cQm6PfXTsJSY2Hj6bR3q5-ewsPDxx8S0xV_nexo2fLoyA-qXXv-4ZkKuvZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehrrdhsihguughhrghrthhhrdhshhhrihhmrghlihesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthht
    oheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Uw-zaRABy8ol0HbEbQmuF1eNR2QBYYdtiVxkusiotxM_EUcHsbdvJw>
    <xmx:Uw-zaTWo2N0gE6uhFezCneAoHHFSVkyJEjx6po8vKp6cocGFLlykaw>
    <xmx:Uw-zaVqciHUZGlXNba7_q7Qi34hRXohUHsLBXwuu5H70SqVKON16eQ>
    <xmx:Uw-zafTJdWpDPk8MIqG9hZ4f8JjZRIIgDyskBTV4tiYxRpPcaWj7Cg>
    <xmx:Uw-zacrhw-az2rof2y2i3kZVUf4T1QrfGyP13CFL59nGkJKdl_uMTSZP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 15:09:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>,
  git@vger.kernel.org,  jonathantanmy@google.com,
  christian.couder@gmail.com,  karthik.188@gmail.com
Subject: Re: [PATCH] t0410: modernize delete_object helper
In-Reply-To: <CAPig+cS3v=OT6BJ0WWh=qvWBm1TVck+O7eKd7gJ2fe_d5Rny_A@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 12 Mar 2026 15:05:24 -0400")
References: <20260312125030.7799-1-r.siddharth.shrimali@gmail.com>
	<CAPig+cS3v=OT6BJ0WWh=qvWBm1TVck+O7eKd7gJ2fe_d5Rny_A@mail.gmail.com>
Date: Thu, 12 Mar 2026 12:09:05 -0700
Message-ID: <xmqqo6kseuge.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

>> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
>> @@ -11,7 +11,11 @@ test_description='partial clone'
>>  delete_object () {
>> -       rm $1/.git/objects/$(echo $2 | sed -e 's|^..|&/|')
>> +       repo=$1
>> +       obj=$2
>> +       path="$repo/.git/objects/$(test_oid_to_path $obj)" &&
>> +       test_path_is_file "$path" &&
>> +       rm "$path"
>>  }
>
> Despite what the commit message says, adding a call to
> `test_path_is_file` here does not add value since `rm` will already
> fail noisily and exit with an error code if the path does not exist.
> Moreover, because it's unnecessary, the `test_path_is_file` invocation
> may confuse readers into thinking that something subtle is going on
> that requires extra scrutiny and care even though that's not the case.
> So let's not add this needless extra code.

Good to point this out.  Use of test_oid_to_path would still be
good, though.

Thanks.
