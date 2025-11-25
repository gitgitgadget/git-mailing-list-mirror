Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F301A32AABF
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764091148; cv=none; b=qiNjEAjjB31vGUOXA+w4jQVZM/5f1U51/bccTVClb7q0zSvYcai6aNIgMetdHNgkmIR3sFgKVrQhXsG9KDoknbGkWUycsPu5AKgdNSo06IOWU/uIJE5Vd/IBT9ZhVleKkHh3lB0ZTRF0JwTpJ2m9YsI83DvXNCUy6O034m5M+CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764091148; c=relaxed/simple;
	bh=w6jOknGgN7CjyMXGqfuMxDBSedTzXEPn/yNoaMyf2rc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NXUbeBZx3jczH6bKsA4sgnL6tEAWPrH4fUwcYOThCxb4ahReNlCbOAMSqYdXfvrVFcH8bv/dz2c+5jTG6mf4ykb/3APVHyh/lgwriavftxyNt5bhTbo4D5hlc/zVBtrDy309y/CHppGBQWlFD34wL4IR0vOf6moQkRU7s1m4Hzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RDeof5oP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lH21qKnC; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RDeof5oP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lH21qKnC"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E2DF67A01A5;
	Tue, 25 Nov 2025 12:19:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 25 Nov 2025 12:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764091144; x=1764177544; bh=nxP5usz0eJ
	yPn1rmFw/7QPDn2B4PP7ZUJLOoaHdfftQ=; b=RDeof5oPbyg3brj18ml3rTM+S3
	2o2MZEH4DkEcF+AuDDiNU4Rb42oS6EYedz7nPRVyaBDcMAOmVuAjDj+ZlCWjA/7W
	9lXiLcZc5mBtMXZj/VC6xwMwitOzL68Vjmdnra576X6YMR8K86623pFeFMHKUgal
	vz76N00zAwUhY/L44BBDVyo2mwdrOaNojuoPfCclRWFUt1d++v6ruj4IDrDOhxwZ
	MRP8JyVZI0hGi6ccWQVBOv+c8xEhyoUPXEl/savKRVSp4z3IR5B32MNm/diJ+HCo
	0hXwCOT+XEeuuE7vVFpxGZ3RDFqGF1uUBxnqO9jrh71sNDMojiTHP7RQz+zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764091144; x=1764177544; bh=nxP5usz0eJyPn1rmFw/7QPDn2B4PP7ZUJLO
	oaHdfftQ=; b=lH21qKnCRUlkFuyFuMQef5ktWTOOjo4Nqyi7dVoFCqYDaVfntTq
	HHyyI0B7qz5YJDPce6bUSZAvizjrC4qaz80HRNH7vLpkDtkYkfqxy+gUXCLnOt+3
	F34GevZkDpQnk3dDiuoWk0LVyXk4G5zcYBpSY3wecwz4cOYeuKTIndIDBM+ZfBJ/
	/2m3fkwGDA8hMMpXBKCSgAvX5Hc6REK8k4a3v/5cvcDM8xrzGQDh/GoxYBqb+XAz
	4dybaENmogwWvahtowJ2TE8DcokZF6dwMPPLknUcpVwsj743aBLa7EVoAQwValFU
	pAOzxeK0b6qLZUyewZooMTLZkOgMOIUg6sA==
X-ME-Sender: <xms:COUlafDyIJMJEGPyV1E34v_zYytxtk25ttEEhznPlTLQ0pPuZoFguw>
    <xme:COUlac8HXQZrkvjm1Jl1b5iiqiyic_jbyk3N6DtxZ8i_b1Ljb06EEIdnppGtlHcrI
    L9TxbG2K3KbbsVyxrDoQ-BLyryJz53FrFrqeGTPu2fNG4YmK72I>
X-ME-Received: <xmr:COUlaX9V8jM_0KFTVz6NP2UTo8tI-IRu0dCm8z8rONw7SRAvn4C5EesVCvL9S5LMyhqNI1CYhbuV3TdPoI2dOkf7R1n3ThojYTTi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedvtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:COUlabcE3bIukug46IqvoYrga5GjYEbjikpMf4ooDJZbmlqwkuKmkA>
    <xmx:COUlaYHnbC-AKig8B0Tgw5lCkJKneVxviD3r_tiuo9Oiw-46zWn3hA>
    <xmx:COUlaRf52VyrZhSQ4lYB_M5ltTGBBg24z4cpnsC6cCRz-TdWOwt2UA>
    <xmx:COUlaaHCoF_FWIWwZ2bGGtIU13DH9fSD2zDxXlb5UVf60ozjs0RO7g>
    <xmx:COUlafnPqiTUQMOKUMCSPQUWz4liyan2XHuoDYNZasbx4NkCdiudlIDx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Nov 2025 12:19:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2025, #07; Sun, 23)
In-Reply-To: <87ldju5oim.fsf@iotcl.com> (Toon Claes's message of "Tue, 25 Nov
	2025 12:40:17 +0100")
References: <xmqq5xb0yqj9.fsf@gitster.g> <87ldju5oim.fsf@iotcl.com>
Date: Tue, 25 Nov 2025 09:19:03 -0800
Message-ID: <xmqqpl96rpx4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * ps/object-source-management (2025-11-18) 14 commits
>>  - odb: handle recreation of quarantine directories
>>  - odb: handle changing a repository's commondir
>>  - chdir-notify: add function to unregister listeners
>>  - odb: handle initialization of sources in `odb_new()`
>>  - http-push: stop setting up `the_repository` for each reference
>>  - t/helper: stop setting up `the_repository` repeatedly
>>  - builtin/index-pack: fix deferred fsck outside repos
>>  - oidset: introduce `oidset_equal()`
>>  - odb: move logic to disable ref updates into repo
>>  - odb: refactor `odb_clear()` to `odb_free()`
>>  - odb: adopt logic to close object databases
>>  - setup: convert `set_git_dir()` to have file scope
>>  - path: move `enter_repo()` into "setup.c"
>>  - Merge branch 'ps/object-source-loose' into ps/object-source-management
>>  (this branch uses ps/object-source-loose.)
>>
>>  Code refactoring around object database sources.
>>
>>  Comments?
>>  source: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
>
> I've read through the patches, and I've got no comments to add.

Thanks.
