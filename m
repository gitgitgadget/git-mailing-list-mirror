Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBD11C1F22
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712603; cv=none; b=S+wVjAn34AV/8cBzmeuXfNwZf7P0W3tTNB4LMKjGmPyG0qFI5DmElrAAl77HmzRsRp6zAQpA95sIoT1zritV8eSQdvk68/PnwbU5LF5e6Y+q3NLfpytiSr2PWVeRRd4ePe5dGMxYkxPGxafJHApF8/9nrCqByiqi0BnnYSObtpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712603; c=relaxed/simple;
	bh=3gulHekaTM7qMXXj56zNJMi3K/v1O+OdJ4a3V2oEkfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XWr8HlJCuvg51gbXC8A5vWPsKhLbkukIpaFBvgqDibVdiwqgl/bpzCgh+LrElo32+0qaeeUrWvT8HqTge47oKQsW0LR5YCncPu5/ABrC236Jjjq/5HKUxO6r8VhXKjXxCuxiKfkPpdnuMNYumk40Rq18S93ORc9PgBcY1cMpH2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HzWW8vh+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GThlVcnB; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HzWW8vh+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GThlVcnB"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id C087B11400BB;
	Tue, 11 Mar 2025 13:03:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 11 Mar 2025 13:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741712600; x=1741799000; bh=3gulHekaTM
	7qMXXj56zNJMi3K/v1O+OdJ4a3V2oEkfQ=; b=HzWW8vh+sEcjV4xDPVbd3sM4Rg
	2opFrixFk5PSgzhlHTP4UXVWngecAfT/iFuTCMSBjNEGrLFxiFA2+8uR1320rRh/
	eTbfAWhXvjmQ5t+k4Rc8cZtJw1uVLqYrPKOZLFOO3e66lAIHJ0bgSs+FnKOvjgZC
	DoImvzjoTCCy3Nc69gNj49uAw9U6EXDi6h9+KTIiKUdxDzaoK4OlbtYlKbhnAdbW
	tXQEqHgLBKDvrFwX6FmWS4U5/BSQRhYgyQhJqwyGOv4iz4QmivAtpIbn4JFopPo5
	rojoARDrHwTlBFfI5yDQIFnH4ea+YgtrfBgdDirO/ZtcKvjesrdSIy1WSb8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741712600; x=1741799000; bh=3gulHekaTM7qMXXj56zNJMi3K/v1O+OdJ4a
	3V2oEkfQ=; b=GThlVcnBITxH1umXRj/MxUuAfQb5NQccK8KAbx7t43XdTr9JPyZ
	rJur6GlnXhpdXDu0gOg1MC7CuYuek7e38tfLfN4QitbfhnK0xZw4E8YKpqCSXgAY
	HXGWqCDiaz7fB4zb0IbhNF04IlWWaYDuaRC4OZRcjMF3b/Eaigv9stzM8eOwvhpu
	YVnd7shqkLtjqUfcZ8XmnHeyHAZkH5tM+IKkfHZMzMGH2B+u+EjtTmerji+k1jbz
	PdEtzAb7HOMah10anhJQ/TXpWVxnBXy0DaSdJN2Mnw9VqC5T5jUdN2QBwO4VyEUD
	FagJb1Y4jGBX21mYoc+BvNcfBi9lDdj33bA==
X-ME-Sender: <xms:2GzQZ7QHg4z3CeK8Nhx93sct4a1OLLG6KeZGjk7uZnIvnT0psw1Ikw>
    <xme:2GzQZ8wbnAYHpRWUFjo77Z7Oxc_WEub5qRyK26GpGGySK-x5UBPJh04iiTIlXTSj2
    4BuM47hrhCEz1taBg>
X-ME-Received: <xmr:2GzQZw124ZCli07wWTEGkZ1Up07GCrAnlQHbXVw8setVK4nWk7Ulo013sYBtsDAJnZujNTjpdvXiskRLWHk4mmAT_hdsoL1tMPX5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlh
    huohesghhmrghilhdrtghomhdprhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:2GzQZ7Bd7p4tYROoFU6L8L5JVi1o8-KRFdny2THCdCMBc_qYRoPZ9A>
    <xmx:2GzQZ0jILQ4r5HSTYbRCiGWhc1rCrHl-uHPlNdBhXWX0HF326wNlXA>
    <xmx:2GzQZ_qStb5Hk9O2vtd0DvFk2RGeOz5COZBV9Fh5pbnY_i4JzA671g>
    <xmx:2GzQZ_jBcRKZ03jfy3TovCXrEJa_Cintv4G9dhOykQ4sOT24uDb3SQ>
    <xmx:2GzQZ-Zf1g8cPQ5L6Hwf2DsFROyN1T3VK2gUfDEPdvF6eHEHD4pt3Gw6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 13:03:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [GSOC PATCH v2 2/2] attr: use
 `repo_settings_get_attributesfile_path()` and update callers
In-Reply-To: <Z9BLMLXJ7Desl-n6@ArchLinux> (shejialuo@gmail.com's message of
	"Tue, 11 Mar 2025 22:39:44 +0800")
References: <20250309153321.254844-1-ayu.chandekar@gmail.com>
	<20250310151048.69825-1-ayu.chandekar@gmail.com>
	<20250310151048.69825-3-ayu.chandekar@gmail.com>
	<Z9BLMLXJ7Desl-n6@ArchLinux>
Date: Tue, 11 Mar 2025 10:03:18 -0700
Message-ID: <xmqqcyen4i09.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

>> -static void bootstrap_attr_stack(struct index_state *istate,
>> +static void bootstrap_attr_stack(struct repository *repo, struct index_state *istate,
>
> I have scanned the definition of the "struct index_state", there is a
> "struct repository *repo" member in this data structure. This makes me
> think why do we need to pass the "struct repository *repo" in the first
> place. A design question, should we just use `istate->repo` directly?

Good thing to notice.

As the attribute system is all about giving extra information on the
paths that appear in the index and in the working tree, it may make
sense for the API to go from the index state which is about the
index and the working tree to access the attributes, rather than
from the repository structure, which controls a lot wider concept
and moving anything and everything there will easily and quickly
make it a messy kitchen sink.

