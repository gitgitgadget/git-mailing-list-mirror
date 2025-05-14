Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609461AF0BC
	for <git@vger.kernel.org>; Wed, 14 May 2025 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747233542; cv=none; b=SpGYFgi+sp3Y/76keRtRdrRQwB2Xyg0micPX6lt4ooEZMwdB1vDVGi1wImRIoYbcTedHKXqJABr5AU+WiJkCQJUYfxV51Xc2H7hd4vCSOLUax3UMOSlz2TJnavOGw/M0A9Ag8xuplBOUI91kOqq8KJ8q63w4kIdaXFy1H8/EOro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747233542; c=relaxed/simple;
	bh=piirqJTnw04EDVm6lA1s1uOH1U42Im2uj28qL3HomrM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WFHSNmo+r0ZgBrDkrzuQs42J7W6Plbne7tz0qBI96YtVU/mCQykoqnMYv2f8GnfdIHrhIF6lX81+d8cIX9IJhSFrNae6ytL7pzvxe8X0i8pAhUM9a3JN31vPTH/BI+E3Gy7bjQNjgX3zghbwsfME2Pl9cujkXABuqKvW9doHXUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fEgT4lrg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lr5m002p; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fEgT4lrg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lr5m002p"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5EEA611400E9;
	Wed, 14 May 2025 10:38:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 14 May 2025 10:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747233538; x=1747319938; bh=n4ZVgWVKUZ
	ncAa36+wsE8ERwfPY5nJhDcFY2Ffi4TFg=; b=fEgT4lrgb82hfSkkVY7sDVw0+R
	XpPLbUTFVudJiPabWmkItSuBP2a/DQkuMuSnOwCGU7IuDo9e9HfFY/GV+/nVxEH7
	HSJvG3o3mv+iDtDxceE4Ux8ElF+yosAhnoH6B9JGWu/HQNS5rif5JCydn14dYtF9
	aFfV5v7EB17yLCKkrS1O3Gx2425eGiGX33DYdg6oJrNXhf0LFVNZo4RphqFw3xrV
	DH4RlNm/3S4yA2Fr2jfYU+0hKKcu3b3YsRLJVH5i3M5fBnezsgM5JXoSqacnN0n0
	G6NHUyp1T1JhERA4j+SkhZLtcQu6XO5Z7ru7PnLnwpq1ujnHpgqtNtPDSkqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747233538; x=1747319938; bh=n4ZVgWVKUZncAa36+wsE8ERwfPY5nJhDcFY
	2Ffi4TFg=; b=Lr5m002p7URoogULOS8zp7J9yAJFHBaJs/AD3Y/EjyDIGkAC6+H
	Y5J1+jvJvqQGnszmlTabTO2YS5uwQNds5RLsajkib7XsC7NHnRCYKgt6iL64mk5T
	Br3c4dbwBQu3SkEWRLEaJOho5VbFKE1Te213bQJwikasUdj7v0QMtQYN9uOe7rMU
	ddELAkxLHMduromb7IT7gLcs2Pkp04FzzUYKa76sHGgCjwIhYs6Mvn9xM6GYEmu8
	JDF6dSF36MOCsXWUuTPDoyoiCq9V4Nun+UcLt8eH7qn/Ink4JyHYtR78qjnyVyes
	1SBEEy5AmBBbfoHEZ9/TaAL6UAJhysabDNQ==
X-ME-Sender: <xms:AqskaOABGT_5fgx_QR_uRMLm-vsZXujQiuF6tUm1M3HMfcJ1uXiEBw>
    <xme:AqskaIgoy5eQDgSg5cxa-sLl4NBG8Vy0pN1vQaXnN-otgHJ4mcgdNSJvs6CFxgnAf
    lHwQxc-VTUJEhrcuw>
X-ME-Received: <xmr:AqskaBnKqmz2zatwzISRGlb7_GV7YQN_Tybi_xXWthxIpHZL7mQJI3A2u0Od0ljs5gcjU_cxQyV9cY_RImkzeopUK_kaScALPKQWB1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:AqskaMzuOfjr17zIAeDwacj7ShxY4tJ6S09WKzkA3B5r20efvc-rFQ>
    <xmx:AqskaDS5iQVIYDxrw6UXtvV_hA-mtrE9xkb86GixAmYNQWsz8SypvQ>
    <xmx:AqskaHYv32wmkqbVHXQbN3P-KYpME331Ngeolz_ok7OKkL5gihESpA>
    <xmx:AqskaMTKEGfNC-zIPVSvZpkzt0TakRzxchZkqZszXmmdIrDYEAK3pg>
    <xmx:AqskaBpWmtCVlGtd71RulO7IKIUJflG7V8fnMTQGWC_Q_eFEawp_IKgA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 10:38:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH 3/3] raw_object_store: drop extra pointer to replace_map
In-Reply-To: <aCMVfHbB7pJ6Mo4j@pks.im> (Patrick Steinhardt's message of "Tue,
	13 May 2025 11:48:44 +0200")
References: <20250512185006.GA1275914@coredump.intra.peff.net>
	<20250512185233.GC1276214@coredump.intra.peff.net>
	<aCMVfHbB7pJ6Mo4j@pks.im>
Date: Wed, 14 May 2025 07:38:56 -0700
Message-ID: <xmqqplgbb6kf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, May 12, 2025 at 02:52:33PM -0400, Jeff King wrote:
>> We store the replacement data in an oidmap, which is itself a pointer in
>> the raw_object_store struct. But there's no need for an extra pointer
>> indirection here. It is always allocated and initialized along with the
>> containing struct, and we never check it for NULL-ness.
>> 
>> Let's embed the map directly in the struct, which is simpler and avoids
>> extra pointer chasing.
>> 
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>> This one may be more subjective, but IMHO it's good to avoid extra
>> pointers when we can.
>
> Yup, I agree it is a sensible step. There is no good reason why the map
> should be allocated, so let's just not.
>
> All of these cleanups in this series look good to me. Thanks!

Yup, looking very good.  Queued.
