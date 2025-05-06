Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E552FC0E
	for <git@vger.kernel.org>; Tue,  6 May 2025 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746558904; cv=none; b=iMbHOkX2Hg4Oaaz176JiFRt8K1lfxWLd1YA766PgbATUFlx7/vsH4DZF/v2L1E567txq2QUSni/0taTRhfK9EU75ean9F8mIWXelqa1kItIHVLC2jRCeQP8TvmT/tvrDjrpmUtVusucfogj6pd5C4DLqqw9LR7Bn00qqVbRzZ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746558904; c=relaxed/simple;
	bh=woEAUANEN3y/jIRSS0sbkBic5O5RJx4BBZlt4qZ2BOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jF+9lbLbdjEngGJmNCCYeeu+nPyGIb+y3JgJZ89NiRwuMThZDNmvsh0mgRW3PqDPCNA9Qc16fn/Cb1G2OecAV13pGMVB4CqZxtkLitxpVLPxtBaw5ZY7lG9AtKv9LPDQtU6ZN6vQnZoXo6CdvlJwXHaFQibjoLxCwLiIJHIVgig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gw7lmkKe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J2eTgLzU; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gw7lmkKe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J2eTgLzU"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3755A254021A;
	Tue,  6 May 2025 15:15:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 06 May 2025 15:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746558901; x=1746645301; bh=Vwkz9EWdK3
	yOqK0fGirUXtm52+31L8B/a+1NCag/+Po=; b=gw7lmkKe9E0KAL1ZwibrieuI74
	5Y15qe1H87jjUL06G9GLHYa7gunoeoeO/WwZbLGQWbZYTx4iEMGHBEgN3WNzjGj8
	4jMpV2uk1/mtgc1YBLCWaVoZmDNEgTt318MWVdV7WnRx3WrD11/7v4c1DKa9NT2B
	OItih+fTZ0oyaKVJwTXLJt8of+ROxmolD5xNxx/W2JuKzOEiwvibLT9wSjApJ0d4
	TLYtp3ZxauQV7tOSiHVM6pOd5/4WpFb4bQuCb50//IC1dT1TcIG3w/62wGy+s5Pg
	RDn5gDsCNfvpKjlQlyQwR1b8HF20ZcNBLmr9Hm1O+Nrhh3Hhon7CJ3LVhWQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746558901; x=1746645301; bh=Vwkz9EWdK3yOqK0fGirUXtm52+31L8B/a+1
	NCag/+Po=; b=J2eTgLzU9rPepRQFv3O3iFN0aFKwz+1/5T4snvsqYx4RIeMCYtR
	oVVvnjnSj2zBpOyGja1rFryRBc37Op1mBV9uKiF7KBjAPyobg/hFTb7tv20jrEqJ
	S0dcIcO/eU2EHVm11U5kRwYsNI9bo3F2vv+zUZUB6dFmj+XlzkXkX3xgzwkJ81b8
	RgsA2IBWa8aYy/aKEiyqAVMcA+ujHYRJAs7Q1fyszGha1kHrhhbQ8iP0zlD0zwKN
	0++I5qrvBLZeIx6xQKHWJfEauJxXpxIdOKriAgq4z+1Q3bwrsWqxEu5ryr0JeZK2
	jSMgcp9neAozi+dYRu2E6vtROo81W4qCqEg==
X-ME-Sender: <xms:tF8aaC714ZvGhMKYIoSlU5riBbsuITa3RqpXVNMVfyYWd8-eGfRaqQ>
    <xme:tF8aaL7U2pNa6I5-E_5lqmvHXOc1DmAN2Fs8h7lZku9g55c5fD_G9Zjlq1GBcZ1uV
    6qCocl57NYh1OSFcw>
X-ME-Received: <xmr:tF8aaBeh12mqE__VKfeQU062daCDlaTcRfNzS_JXvf-lwxT1Xbz6QoZvoAru-frdgSxbivlVcW959LaiVMM-yzTXM1AHFwPuQORA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlh
    huohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:tF8aaPKsoYPRo2NPG1y4GsaUc2XdI_asQFylsZiJTmgcII4uQiKkIg>
    <xmx:tF8aaGLTk9SeVv8hNzqdOFc_eFjerFtCwTkMK-7paSNislPuJYGcLg>
    <xmx:tF8aaAypGa5xJWEdaw2oWfUGsSvtkJYfhN4l_afEMcEIa956rozwSw>
    <xmx:tF8aaKJTe-DgngkYOZIVE9o3d-MKpcejr9rNfMsdB17N5Ruu9VmYiA>
    <xmx:tV8aaDFaFjat5lGZckNq-H4CjSgopyLhLM75YD-6Qc8AXB-KQynW0pnB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 15:15:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH 1/4] packed-backend: skip checking consistency of empty
 packed-refs file
In-Reply-To: <aBo7nBOl18WWYIsA@ArchLinux> (shejialuo@gmail.com's message of
	"Wed, 7 May 2025 00:41:00 +0800")
References: <aBo7OiCKHTyT4DzH@ArchLinux> <aBo7nBOl18WWYIsA@ArchLinux>
Date: Tue, 06 May 2025 12:14:59 -0700
Message-ID: <xmqqzffpima4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> In "load_contents", when the "packed-refs" is empty, we will just return
> the snapshot. However, we would report an error to the user when
> checking the consistency of the empty "packed-refs".

Neither the commit title nor the above paragraph hints that this is
talking about "fsck" part of the packed-refs subsystem.  That leaves
the readers confused when they read "with the runtime behavior"
below.

> We should align with the runtime behavior. As what "load_contents" does,
> let's check whether the file size is zero and if so, we will skip
> checking the consistency and simply return.

How about

	During fsck, an empty "packed-refs" file gives an error;
	this is unwarranted.  We should instead just return an empty
	"snapshot" and let the caller happily declare success, just
	like the code paths that implement the runtime use of the
	file do.

or something?

As to the title

	packed-backend: fsck should allow an empty packed-refs file

is shorter and clearer, I would think.

The code change is trivially correct, I think.  Nicely found.
