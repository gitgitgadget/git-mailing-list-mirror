Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EDD286416
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400822; cv=none; b=fPG5vEs3Og4OdXJNnTMbW623HFe8t1Mmodk0cjK2/frmBL+1XoNXgD1KYTKgeTYxJwnWjUBzvCOFHpb4qFIOkUNHPsiCnLiBBvKhj85mb0o6yzyj86RIgBOjoO8r9NbxVx0rwNzK5Uud4Q6i2sIgmX0sZCeCBMFEQSA08F4xJzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400822; c=relaxed/simple;
	bh=BLjsHFtbivomjflKLLhNlGYMt+3rzvFalWstdAdL1E4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kIGGAQyHg2TvYy+ouav66Ljl59N4TBAa5kyrvHRC/0jA8SZxJYhm+gBuBv4Q6T5olRGPIl7on2tpseQa4E/iMIvRjF5nXAumEepv8QxPDcYMVrEvcPL+UcO0LG6JGbTZcF020roQEqB5EghlMXHEhh01Lj07xmwRJdBaFWfYHzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k/nwFHx3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AARYIisq; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k/nwFHx3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AARYIisq"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8EDD67A0075;
	Wed, 14 Jan 2026 09:27:00 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 14 Jan 2026 09:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768400820; x=1768487220; bh=gDBEOMxLLH
	8ggSxDUCAG3k4ccGVRhML+MIWUuRCZZeQ=; b=k/nwFHx3GW/T8uMY6/MLXtk2uN
	65Ocuv25HMSyCJ3rLPW5bZoA+QCcUOcsS+B9/eA/vzj7bihKxWSoYsCKBQ3Le4QB
	v4IV6zfQ+F9qeOyuGb6p7cYOGJzY87y0ZIi3BSsJI305m6ROmRIbuo5Y++L/Uigl
	YvNFA7rWu5hT6FmE7lAiJKRBlIpNqVMt37SKOsfRTFfSu4VGu/VbUkQwBaJT5/2e
	42oP3ZrMqs0FJpkrufVFWqUHXoj6wopjon6qd4/W5eYRpirPZhRr1zM8rPX4JOd6
	ceH4R+RxrQcWQUONSf4fdHcmK3K+d8s9Xe754JY5lbxRdsnJ+OqgOA6Mmedw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768400820; x=1768487220; bh=gDBEOMxLLH8ggSxDUCAG3k4ccGVRhML+MIW
	UuRCZZeQ=; b=AARYIisqkqno20DXtFTCPH+DcfW5+uFkWJTo3m3tOjJ+61oJSku
	UPaEg2x/iXjJ7w9i9mc+nEs+emGPAsiuorA2mk+5+W85P7Y595OMvwVpA/hTJSji
	zw3FwQBg4yn1/8Ryph2FerAjCSLYAwwsgezWlGG9LW8Z7y2HSHt03YjpiKVO3ftZ
	KGWrI4/xgeuoK08wrCxtHBtQEw+OdY2cthl7f/U4F5tH/smtqXAMj81482MdgQ3o
	zrKTb9XApopBN/OZns+UuX4SSAqwVNxX9Ed4a+s3bU5avmWjWR9h4aZu6k77xh3x
	S04qmyCFcx3VaKGP3QDR+ZCCEMayweMTKMw==
X-ME-Sender: <xms:tKdnabElbKmt-fK_-pXQDr1wSNdWCvVQq4LSAirp94FBTkJT2vezHg>
    <xme:tKdnafwJ5ztxZWwMdvcG5FF-3XXoJdLWZElxggH6e65Mn0E8qgmGFdd1OwGc_9pJy
    xmW1IRDDgbblV7P4jAb7c-E1HjY1mQ9-P4srfUS5JwcqFKwg3aE>
X-ME-Received: <xmr:tKdnaaiwJQX5CAI4T4OgaVpFqikkXgJRdBaMp30Z8JaTTSWtEVFBaPQdXUV2XM7MA0VvvJYK_rLACNajf0RA2cPd5i4fkyD2ff3m4N0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdefgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tKdnaSyrbYHh729rSQ7Zl9XVIzcfhvTCd09CbBzSxNWzA_xhNHU7bA>
    <xmx:tKdnaVLlbAIrsq96vGpOi1UPxxqGGeyBEo2TBqFykjWLOZooWoR6Wg>
    <xmx:tKdnaRTRjmw2fkeJESn0QX-zaDlcBOPWcgZO2laAub9eO2YjIyx9FQ>
    <xmx:tKdnaVoH6gwzzFgDpBMRhPoH8uOjc6Za5FGh0Dc0Xm6R_qMNWV9nZg>
    <xmx:tKdnaf4lu_a1hpWCJN6ja7dPK8P_Zm3XgSzgRltiOFdhQUo_GcqvgX4t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jan 2026 09:26:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2026, #04)
In-Reply-To: <aWcnsvVdtHYPWOAB@pks.im> (Patrick Steinhardt's message of "Wed,
	14 Jan 2026 06:20:50 +0100")
References: <xmqqjyxli89m.fsf@gitster.g> <aWcnsvVdtHYPWOAB@pks.im>
Date: Wed, 14 Jan 2026 06:26:58 -0800
Message-ID: <xmqq8qe0gthp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jan 13, 2026 at 12:10:13PM -0800, Junio C Hamano wrote:
>> * ps/read-object-info-improvements (2026-01-12) 8 commits
>>  - packfile: drop repository parameter from `packed_object_info()`
>>  - packfile: skip unpacking object header for disk size requests
>>  - packfile: disentangle return value of `packed_object_info()`
>>  - packfile: always populate pack-specific info when reading object info
>>  - packfile: extend `is_delta` field to allow for "unknown" state
>>  - packfile: always declare object info to be OI_PACKED
>>  - object-file: always set OI_LOOSE when reading object info
>>  - Merge branch 'jc/object-read-stream-fix' into ps/read-object-info-improvements
>> 
>>  The object-info API has been cleaned up.
>> 
>>  Comments?
>>  source: <20260112-b4-pks-odb-read-object-info-improvements-v5-0-9a6124e95bf2@pks.im>
>
> I think this topic should be ready by now. The last iteration only added
> another test that catches a bug we recently started to hit in production
> systems, and the previous iterations all received reviews.
>
> I can try to loop in another set of reviewers though if you prefer.

For a topic like this with multiple iterations, I always revisit the
thread overview

https://lore.kernel.org/git/20260112-b4-pks-odb-read-object-info-improvements-v5-0-9a6124e95bf2@pks.im/

at lore, but it is hard to judge quickly if we have reached the
point of diminishing returns when the last few rounds got almost no
responses.

> I also noticed that the patch series at [1] is not in "seen" yet. Is
> that intentional or merely an oversight?
>
> Thanks!
>
> Patrick
>
> [1]: <20260105-pks-geometric-repack-with-promisors-v1-0-c4660573437e@pks.im>

It was more like "this topic saw a few responses, one saying the
thing is confusing, another saying the series is good up to one
point without mentioning anything about the later steps. perhaps it
is time to see an updated series, in which case my time is better
spent on other topics first".

Will take a look at them later today.  Thanks for pinging.

