Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6211D25783C
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760384405; cv=none; b=HtNIV+L7MzoQUFFmQNVRVFJtTtGckj79DvSXSGGcNh8S1JbX0LSWJw95LztXcBKNOEw2IppK3PJKL20gZDBc72atTsgJyEfKmwyMkfifTpOOwJP+xlLBLMmMwiMIaNtsL9IrBcB/WUT/7sKEVLIpKpbSKJc+cVBjGZw3ZfeAblw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760384405; c=relaxed/simple;
	bh=WB6BDVXUGUjUI6xyXtNlU/OXJRD2Y4AFfkD0dkyvizA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bx3GomMgDGk0Efe5G80nnZU5OgG/WEuol4+1L4OClAXrUfEIQTcYha8npmczVwBBIPCvjxuCEtHjbdKWjdtKIEcwlMG6N2W4aod4zGb2lFZDsLQext07OhvMNpY1TshjB2As5Rl0RUCVSDcvhnKq3lrOU5aQl1DKMq5FIY6HSYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gurWoWr8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BHxY1I1J; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gurWoWr8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BHxY1I1J"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0D28C7A04D4;
	Mon, 13 Oct 2025 15:40:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 13 Oct 2025 15:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760384400; x=1760470800; bh=reBleRfJ9L
	Li6J6vvE4WeKANhgvrkZMLTUNSG99TIa0=; b=gurWoWr8blvsD4yTNQ8Si19TQ7
	dfTSi4PWLIW81O6hslccTmGArMUOePOoMRSO6tKY/hD720TIChP7ZaDfXfP7rVOL
	3hRjmYKmAevOfeY8z7FibS3Qt+OBsm1bfEnFnvZ6Jh+SuT45ZgPcCpvJlmGD2ewt
	A4rjYv76nK9t6EF1AEsNkN6RDpoxARMmVzTGmxg1tRBwVL5Qrq9YHnTF6N2gx7dY
	QyaP7ZxJr3p4iY9MBzrtQRaC4qjCo5xELsCAfd6b7sMMKa3EWaklKUGK7Xcjb8So
	jJU/Q37PCB1nh6oiI671+fc0aMRg3FBWvlKndmEbyTkNGGZtSMtsUoYBWsdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760384400; x=1760470800; bh=reBleRfJ9LLi6J6vvE4WeKANhgvrkZMLTUN
	SG99TIa0=; b=BHxY1I1JKFmgcYZuZ3qJOfK3xfrZ5vinMY7C6G9K6co55uA/mUo
	B4yr82Z1bH8PnXd/NV8iv+WfVtDLoaXBEkImQCB/vTQ79U20Q5tkWUzmtSoba1Zy
	QFnWCMlYy1HGvZN2ee1U8mbxoWRvkMujXjeqQqGxezhczjBO4l9CbdczmCLg2Urz
	+js1iRzSp8/+pid97pIBhaSi5Jh73GMm7DpBLCxzeOOfJML9WvT5dA7y6md/I46v
	5nqLccl8DrSMm90F6G5rSqYtH6aP1XRas0monQIdCde2DrEDeYs1328vKMhquyrd
	phCRd+WX9WNtZ8hZ9XHBufVU9aVR4RcR6/g==
X-ME-Sender: <xms:j1XtaMiErE29X0zVEKKc446bci7_YZkRSb_yike6QcwiElN6KKv_OA>
    <xme:j1XtaPZNVXGHVgYt9f5nyTzWHAnhtepiS4y0wNxUOcoBwLq2Dv31Dx8TcM_0EX2-K
    9apUw2VFIe_4myk0moWXLnuxCsfzIl0LFJ_Ir-riycoMJX5yXsElg>
X-ME-Received: <xmr:j1XtaKPV68T5elqUa4RcN0_xgR-XqPz9HrHkKLVga4NhXU_72RndDv8f4CPAAc-R9jv0ltx7FfoZUkkVWwSoCHqzw102v6xZVcoB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtph
    htthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtph
    htthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:j1XtaIaMBSLXNaSjsXIVjaoMUpL1Fmou0iCCL5GeJZhfk2ncRk7nIQ>
    <xmx:j1XtaCU-UMwIu8ix3X2AXhvRoi6tczRM4ANS-N8hbP2f5MpA6YGpXQ>
    <xmx:j1XtaPAmxqnfHGWBx8DW6U-yY5cO_ZmCMGEGCDIpeoNDZ4QxfCC0_g>
    <xmx:j1XtaGKkfbZUeoMxw-M1pCR9vylXmZekj3VjDUkxwLZMR_oNUSZIfA>
    <xmx:kFXtaMfzXXKKf7yK0G8_g1bHamuf0P8pe1l9ULSdpjZQUcnYAvlobgZJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 15:39:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  phillip.wood123@gmail.com,  phillip.wood@dunelm.org.uk,
  newren@gmail.com,  ps@pks.im,  karthik.188@gmail.com,
  code@khaugsbakk.name,  rybak.a.v@gmail.com,  jltobler@gmail.com,
  toon@iotcl.com,  johncai86@gmail.com,  johannes.schindelin@gmx.de
Subject: Re: [PATCH v3 0/3] replay: make atomic ref updates the default
In-Reply-To: <20251013183311.33329-1-siddharthasthana31@gmail.com> (Siddharth
	Asthana's message of "Tue, 14 Oct 2025 00:03:08 +0530")
References: <20250926230838.35870-1-siddharthasthana31@gmail.com>
	<20251013183311.33329-1-siddharthasthana31@gmail.com>
Date: Mon, 13 Oct 2025 12:39:57 -0700
Message-ID: <xmqq7bwy1tgy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> **Removed --allow-partial option**
>
> After discussion with Elijah and Junio, we couldn't identify a concrete
> use case for partial failure tolerance. The traditional pipeline with
> git-update-ref already provides partial update capabilities when needed
> through its transaction commands. Removing this option simplifies the API
> and avoids committing to behavior without clear real-world use cases.

Ack.

> **Changed to --update-refs=<mode> for extensibility**
>
> Phillip suggested that separate boolean flags (--output-commands,
> --allow-partial) were limiting for future expansion. The --update-refs=<mode>
> design allows future modes without option proliferation:
>   - --update-refs=yes (default): atomic ref updates
>   - --update-refs=print: pipeline output
>   - Future modes can be added as additional values
>
> This API pattern prevents the need for multiple incompatible flags and
> provides a cleaner interface for users.

Ack.

> **Added replay.defaultAction configuration option**

If a configuration option is added, please consider and think hard
if its relationship with the command lineoption can be made obvious.
I do not think it is obvious to anybody that replay.defaultAction is
somehow tied to "git replay --update-refs" at all.  Either the
variable should be renamed to include words like "update" and/or
"ref" to hint its link to the option, or the option should be
renamed to use the word "action" to hint its link to the variable.

> The command-line --update-refs option overrides the config, allowing users
> to set a preference while maintaining per-invocation control.

That would follow the standard practice of configuration giving the
default that can be overriden via the command line option per
invocation, which would match end-user expectations.  Good.

Thanks.
