Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9AD1FC0ED
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089937; cv=none; b=OqNjd+RKzdecUPn3CXaJzNFXJoRI1pGyykuVRjTcRmgjZGDY+L74Rpt/2+RNhUPsNkLemHJiXaz9vaagoXhuuQFdCVAbPqMhBZxLxtzI6d1r+45itzvrckzHrgR8m8BMBCcw9nwx6ohm/KvA4D4S5h8TGPn6gf84Eme6GV3Cms0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089937; c=relaxed/simple;
	bh=TChHTG5knbhvOQd4FSq0XKg/OB5bRtxiYxMbzWecSTo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FRuiMrd1Li5u780fMBMu0g2R2ztTpRQWStl4QfTi5ol8wVpy7Zv7ZZtJ9vTEJJQxFsOCTbL4a/kCcWt8wjVU4emviXZedueH1MmDwNxZMqJ0mUF0wzyBtxX/zt7OtMFr/UASDjPC13qFXeBAduc5uj1DaBhBWPocJtyj01VGsPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g1l6JcmY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DQv12qgS; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g1l6JcmY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DQv12qgS"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id BA134138277D;
	Tue,  4 Mar 2025 07:05:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 04 Mar 2025 07:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741089933; x=1741176333; bh=o8QUI/jx+E
	wMiaNu0yUANHysIsjl2DNVZCYYP+1W34U=; b=g1l6JcmYjafRj60LiovsYLjaUx
	7hL7RtchCd83/DMRiACXHe8S1Sh54Mfpee4/F+Gly6ULXOHFHcMVZhBxf/Wo+mkl
	+X3otZPoTZyxKRarkii5tn3bPxRhksI6kBqjZe1ZfBjDYRo7M9bu0Qm5r7VCZeF2
	MKOA+QC1y6LEZCFLadmG/fodsZpuKZDzXhNUAtB1NO+1jg66/pZCMHENmQyzAMcp
	bqYrYtdtG+z+nHf8a0lvbb4FTToFoMvESheL4TB+xOLsApPDknfuCxV7G0FVY/EW
	ExAEjPPBd7/zh7icy2Dp5bM0YSNEoH151MlSGdZyim8TWqCRoHBP7uCSE1uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741089933; x=1741176333; bh=o8QUI/jx+EwMiaNu0yUANHysIsjl2DNVZCY
	YP+1W34U=; b=DQv12qgSANHme882QO2W7G9/8oR56h8xJ1vFvk5iAlyiLh4t8EI
	OCV9j3IBhcBhUymUV5nz5XCTU33UzhnY65/iarrqbjn2ym+4nJh/xp0nmis5fQS7
	UezI9wzWXB2blB+Fif+H6SIlZoRkxg+xR5NbNOA/aIdCeSerdCpGp/Ew97iQTuZA
	hvPTtBhrvfge6+cCQj0F1NchyVoYxLpEhMMmRWdw8BTuxSndWiopAHtePB6nmvKf
	8/Unqnr6dxn+BUeGRNCbM4exPV790nPBa4YZn9EnWJ5uows1PeEq9ibWlsihuQ0a
	Vy7AcjLJqRPhs9j6T91nrOSoXgpfxL8e2NA==
X-ME-Sender: <xms:jezGZ0VzLrupBm0mpVvg01OGTi_-ZQT9hl1df-74O22TZ9xfV0a6Wg>
    <xme:jezGZ4ku6c_8I6pgw41m95NvO905veZkk6b20Fa5aCFk3OerbRvlWue1HzeodBl10
    J2VsBDN73GvX7nlzg>
X-ME-Received: <xmr:jezGZ4Y-xLG7pSrsTNdPW_Ws00Z6WOIV3XSLKAJ51qA4UGFZnj4YqjYJqkEb9u8dRK3otDIFe8SlVbq9gQfygPggDNLruHgzMP8I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdduleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnhhimhgrhh
    gvnhgurhgrtdeltdegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jezGZzVvJh326AqMtMDIuVdIvI_0SwJYq2G4vAPznTBMRcV9dnMHyQ>
    <xmx:jezGZ-m7Zqjo9D7MWwf4RsEVjs1X2HpE26dfWSGmd03-xkccmwH1Fg>
    <xmx:jezGZ4f0Q8r--mSA6dnczJSt6UrLiHPRINQ4XJ4r23UeCvy5zHKZHA>
    <xmx:jezGZwH5sR0R5Z-ki7VHGev3tQCRUO4sxyHEqr29lWSl1-Jhp8xCVg>
    <xmx:jezGZ_BGr075JyZMOkL34M3i6DosdmCu700ywNM_t8Qq1cPP1KCwyvpn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 07:05:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mahendra Dani <danimahendra0904@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 1/1] t1403: prefer test_path_exists helper function
In-Reply-To: <CABGrwBB1-UiiPEOptN9csVP1WYg2X=SWeMxxiyDfz02VmDp1vA@mail.gmail.com>
	(Mahendra Dani's message of "Tue, 4 Mar 2025 07:57:25 +0530")
References: <20250301105838.1481-1-danimahendra0904@gmail.com>
	<20250301105838.1481-2-danimahendra0904@gmail.com>
	<Z8WD2MeHpOH7Ni8A@pks.im>
	<CABGrwBB1-UiiPEOptN9csVP1WYg2X=SWeMxxiyDfz02VmDp1vA@mail.gmail.com>
Date: Tue, 04 Mar 2025 04:05:31 -0800
Message-ID: <xmqqldtlt304.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mahendra Dani <danimahendra0904@gmail.com> writes:

>> >       remove_object() {
>> >               file=$(sha1_file "$*") &&
>> > -             test -e "$file" &&
>> > +             test_path_exists "$file" &&
>> >               rm -f "$file"
>> >       } &&
>>
>> The refactoring is true to the original spirit of the preimage indeed.
>> But we could also improve it even further if we verified that the path
>> not only exists, but exists and is a file via `test_path_is_file()`. If
>> we decide to do that we should also explain the change in the commit
>> message.
>
> Yes, sure.
> I will improve it further using the `test_path_is_file()` helper
> function and change the commit message in v2 patch.

You may want to think about why there is "-f" there.  If we remove
it, do we still need to have any check there?
