Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA4D2192F5
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744150785; cv=none; b=Q5LhB3bI158+4uXcXn7/jIQG3kFr+f4JukdGQ5nSDWEO0zp8l191wR9Y8O9qr5xa7tmbQquF72hTZduhKGf7sm4iD/NBbnTEZ0c0kEVAs3G8zPutGncs7VEtWs4b478bsaJ3o6rwXNFD7MpdjmSqh8hp3RI2w41xBLXK51zRwh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744150785; c=relaxed/simple;
	bh=OS9myd9kCxUtbVwyMHFHHjc3X8rUNOY9pVkEzTq+Ia0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GPO8ZI7hcjYSCGdlu/dJ9+p3rITt+DbXS1ri3Fruqy00fs3avvSRzB3tJUZ124qzFiZtfoVPUuogo7L9isr6VJE8O8oGmjKebyGSfg0QKRT6chwt3OaoM7pe7BO0bMymW40FpahKQSnHvV6O18lZrX8U/Y9+V3+VAu21Efv67xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NP5PeSwy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oth8qGmz; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NP5PeSwy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oth8qGmz"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 6CE451140165;
	Tue,  8 Apr 2025 18:19:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 08 Apr 2025 18:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744150781; x=1744237181; bh=wsjx3FadGj
	PTAlrou4s6fjbfKdwFGxd1olIFY8cwBK8=; b=NP5PeSwyKripcyQWb4h8vbswJQ
	BcHjZm426pkG4qjW1jhSLsdGZUnpaqSokyhBih1c0MzDM9oDyFDxhx22zYWOB/Ip
	KyRh7uBM3g097E3OsFa2w3bQQxsouoi05rliN2Tto3t+PSJWWWzpIlsSlKIfQU7t
	w9IUDz1JFQndv9MHz9JAyFRkEBbveSFHOyjzinQM+Izjm1Gf19XYny3cohhVdbaj
	+h1FwDtjR37D1yehvsmtZU570N3WvtAoYXRMVisXo+YkkaqNgRki+JGp2C3SJBPC
	nxPKZFlpFs1hjGz3DiYWojl+Gh1aO68DBHQpAtJJaQALMpGz5yPkHxyyOIbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744150781; x=1744237181; bh=wsjx3FadGjPTAlrou4s6fjbfKdwFGxd1olI
	FY8cwBK8=; b=Oth8qGmz9meCJbZwWe5/D9isjKghtMA7FL79SUkI8bmIl4K/tGu
	fRDKE436H/hklJ7FwXW+FDicPjU65Wya5ckRgvCXPhit1kGld1mEQag6twM+urJ+
	L3UbSitWcsBPmPNH7uisiszU3Hbg0sDNmT0ZDpguPI0d2TG+Usy7TN7Ry23Mmk49
	k9uRKCesH9zVLmFOG5TNE9yDho7FgjOS4+RCssR5rcO7wiQ28ca6CGGSefNe02w0
	FANjCpjazk6V3BMC4tM7PfBt7naHgoJMdb3atICcuQnxrg3RfIKt+whQ+p1iDQu5
	HTzhgH53oza526hwgXP6/wWnVvWwoQ3jbcA==
X-ME-Sender: <xms:_KD1Z1oHU4JgWHX0KwA7zb4GJBPlc95H_tqUcMItbQjzAOm3vzkC_Q>
    <xme:_KD1Z3oZ4zCp_-p8W9kKXa5zOfgbZsv_26bt5CKXfNycn4dRXzPsF0gFOWW9-_ruU
    fyNXSHhFQqSr_k2mg>
X-ME-Received: <xmr:_KD1ZyPNbRlYYbrR3wtR0l9QwioP3F5qBCcE3HVQTIPF5rNp-FNQlkOCKZcWAGGcMCxyuhttZ6Gc1XNvgwxuF2wqwdz9ardTnsV1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdegvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:_KD1Zw42NTWL5OHOGMrPGeSg3ZX-n62lgzRN1NdLOEJ2hSK-FG--mw>
    <xmx:_KD1Z05cZKs2YmWlh58043rEGISBLXQ8H73YVYXObNchDjR8chgLcg>
    <xmx:_KD1Z4j9d2F8LCzAOsTjjC31c3WT455-4m_0DQ_SB-RGDjckB3xhnA>
    <xmx:_KD1Z2603GlTByY4qnllzIZBwuad5wbfxjAxSIh3fLqn6gi4f2xrkg>
    <xmx:_aD1Z7ieH3RHU6--LxUfvxRtnzaI5921rWcXi2Y7gnEsc9syxVz0NQif>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 18:19:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  toon@iotcl.com
Subject: Re: [PATCH 3/3] meson: add support for 'headers-check'
In-Reply-To: <20250408-505-wire-up-sparse-via-meson-v1-3-17476e5cea3f@gmail.com>
	(Karthik Nayak's message of "Tue, 08 Apr 2025 16:55:29 +0200")
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
	<20250408-505-wire-up-sparse-via-meson-v1-3-17476e5cea3f@gmail.com>
Date: Tue, 08 Apr 2025 15:19:38 -0700
Message-ID: <xmqqsemiuwhx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The Makefile supports a target called 'hdr-check', which checks if
> individual header files can be independently compiled. Let's port this
> functionality to meson, our new build system too.

Good goal.

> Let's avoid the abbreviation and name the target 'headers-check', which
> is easier to read.

This is a bit dubious.  Are developers supposed to keep track of
correspondence between the long establish name and the new name this
patch just came up with?  For how long?

If we make it one of our goals to name the build target in
pronounceable ways, that is perfectly fine, and it would be a good
task to allow "make headers-check" be a synonym for "make hdr-check"
(and do the same on the meson side), and deprecate hdr-check in a
cycle or two (this is not end-user facing, so the transition period
can legitimately be much shorter than usual.

But we still need to have some transition period to help those who
build from the source adjust their set-ups that have called "make
hdr-check" for a long time.

