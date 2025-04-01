Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832591E5732
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 22:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743545285; cv=none; b=C4B8Mpq9DPK8mFVPf/p21JWtarsl3jubSgEtiBqzqIeF6sP04uDS+Tuoy6X29p4QVCWU1SNsl03pn4a2ma+gylSqAFtZx/H9caXCesLVVLZnlun0Y2g+Xvj+yvVHrBJRv5UKMYhqtJ8Eu85dm+afsMPy+8yMG+00G+x6Mv7RwaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743545285; c=relaxed/simple;
	bh=7LV/jusIz21R6oB3D5CDbGetVR1cgnoxOz7K3Wkcccw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FMdAFHtQ7ygwqDyAyczqdMU+DPBowOA11ffDRgzhVJ+jdUU8DSJEKMM2nGHzKvgUSYPaIABjst6n/g1wDRFmJUWLa/PiBlYDgkJG2w70/iXff+Yg3ElyEEuRZ4zT+5zC8zBz/ygAMy+b24eHprsjjWngX7Fn9mMsEDsGRNxtf+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=piKTUuEl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vMCIWFjR; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="piKTUuEl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vMCIWFjR"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 75E881384357;
	Tue,  1 Apr 2025 18:08:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 01 Apr 2025 18:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1743545282; x=1743631682; bh=7kF2wD2G3t
	ypgRaVlGjABtmYZo90w0aLu3n+iiAMK/o=; b=piKTUuEleKyrdBUEC0cTFsER5f
	qOVSn3pQzitWwfk+KmHwIrTPRV6eioIBj95RxuzZlzg32ZrH1DKyQIgoez5xzxgS
	MKHpQEnv9msHt2hBzTHEV9XkthpF8owFyS/8FTo8GdrryrlAV/viw5NAKWyeCGCi
	eieagr4NZ367eEQzkmJMw/LnXyxy8YuWED2javssTRv0SZUtSljVFQBG/O5SjUUF
	M729EC4AUgT/Nz+OSGyFycbeL2G/UZpYip7kNDG4nJgB6ngsVANdicKMPfglt1ay
	kHD7xObX2NWmsiuKX9gFElAhd9WQZtVCvZRhiC3sNpmaT0sg0ShTqVdneNQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743545282; x=1743631682; bh=7kF2wD2G3typgRaVlGjABtmYZo90w0aLu3n
	+iiAMK/o=; b=vMCIWFjR2tl9FZC4tVQvPJJSxwR8Pz9y7PpPnftBQH7htOC3Gz/
	gemF56EB3s9Hyxlq02UUPwNKvUGzKIKj1xaaxEFtuOIxd+00hDnu/f1naSO7g48o
	ZxHQZD1RHoC4Q3i3AustX7Th776urlXGN+KdlfwxoqUm5gtN657k2U5vUuEaV+EG
	0N3CDSnpBRaus+SoZHcbtAzs+MRWlr14FSEi8NQNUvcDSmIpKwK1+cwcYCdn4N46
	h5QwT8/QX60TO1ZC/90qjP0xSKEhZE1+pwJZYjeLHs9QMX7ot0dRtkQuNkvhSeu4
	hfFX1YECAgipFAiLTJ1tySvR1VTxICfMXXg==
X-ME-Sender: <xms:wmPsZ6n9uKd17Bf8Qnw4IK6eSLryQRACwOl-mm6KUMI0jip7Y5VYoA>
    <xme:wmPsZx3za0twL1O3e1WujWx4VxeBGqJB7oPBOLzkzTOA_gmDlkLBT_jz8TPzYaB9d
    f_9uL9HWqB34rcGgg>
X-ME-Received: <xmr:wmPsZ4rpflW15XZZPd7GtN6Rw2XTB5qiUZ9-5Yx6gBpVGjp74wrXoGwxsachxcxAVqmdjHjUr1W0L4zSR41tmlwiT5zjL1Drl21i5Do>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeefleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wmPsZ-nX9qiTzJkxtmaeafiHrD0LxMu4M17HdgDFoSXPSFj0CFU74A>
    <xmx:wmPsZ40IJQy4lsr2Ny_OdsRF3aKU42Tdf8vOzP0HSE0_yyUCSKgWVw>
    <xmx:wmPsZ1vuVRqOnXUXc0GnxoddO3-xQ2Hf4vUsayDTjC7b-Mx1DdSrTA>
    <xmx:wmPsZ0XQPYPkf4TJgJ44dn3kctYiBEfKw0loXJ--hlqGm4AU9cJ1Ng>
    <xmx:wmPsZ1yk7aEvRIdqF61NmdbOLtmOhxyePYMM9WZWkjBXO1qjkp84hXej>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Apr 2025 18:08:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 14/16] reftable/table: introduce iterator for table blocks
In-Reply-To: <20250331-pks-reftable-polishing-v1-14-ebed5247434c@pks.im>
	(Patrick Steinhardt's message of "Mon, 31 Mar 2025 10:41:32 +0200")
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
	<20250331-pks-reftable-polishing-v1-14-ebed5247434c@pks.im>
Date: Tue, 01 Apr 2025 15:08:00 -0700
Message-ID: <xmqq8qoja62n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +	for (size_t i = 0; i < nrecords; i++) {
> +		records[i].value_type = REFTABLE_REF_VAL1,

-Wcomma,error

> +		records[i].refname = xstrfmt("refs/heads/branch-%03"PRIuMAX, (uintmax_t) i);
> +	}

An overlong line.
