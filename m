Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7940B22097
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 06:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768027721; cv=none; b=qsaGv9BeFiougqAEeSQbWVawFd9IBuiEH8hwr3TdbtT8dO9K33ruKEX141ajSK/a3wCNA0pVMdfQAE9Sef4DbkG7pK3oRHcdFgsJgOLPetuqwoV0NGqyOmWy17K7VwJrT8BIpfijxBCOtClsORHrjmWXeMmy9cSk37Fica3SrOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768027721; c=relaxed/simple;
	bh=G8IcfGkCl/HDdi1WAxkqBsJfYbSO2tgUsnZxgwV56cg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ojq5YEmcI0tN523hPciIGg2rmXa0iZVUDM8LxoXDsP4k3VLPtB+vd5gkRDlmsU3EFEGcrkB9wR6x7bAI1U7x3drWpiNuDI/NWfL8+ykKc4skPMsBA17msZ9gV9OOS5aI32mqjzalecNoZ4WJ5tenv19k+qeFhnXo7uPG8q2LS38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EzQxfLkl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ODjbYUGt; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EzQxfLkl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ODjbYUGt"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B1458EC008C;
	Sat, 10 Jan 2026 01:48:38 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 10 Jan 2026 01:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768027718; x=1768114118; bh=mhZy6QpA/B
	KgPpcmqWrWOgu2wbJsFq9SPetjvp4x77g=; b=EzQxfLkl4T8JdqyB06EyvMV7/H
	+XzLsd7pR4lN9SerAqQkFdf5Ww1SlgmjoajLJ3V/BJmlEJIBk2SZibI0yrULE2Wy
	8sD4Ikwg/b+WJFI4x9fehKP8i/Iu1pQuAOyZo+yDnKtbDMXpU/rXM/cJEDpmxcGI
	gtRsZgYlw1Fy5YfHMJ4pKDmlExi3P022ypCLubNZzV7H2h1jWTlHKidLg396vOH+
	gomlQl5PXB1rDXKWMYWn9w2EQEYxAy1hm2tGam5OkKAZdHUbNuR1iWDcrTVrMnHy
	aS+bZkHdjZoWE0w7FjOniWq6fFK4KFdsP9d8DGl5NVUjPtGdqoHbpdTq6/AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768027718; x=1768114118; bh=mhZy6QpA/BKgPpcmqWrWOgu2wbJsFq9SPet
	jvp4x77g=; b=ODjbYUGthxj/9XADet+HDa0yB6Q3+J/RmNKBfOJ4XEHyAfAUCqX
	qchnRBACpT8fTODBSUUMMozAVx/aX41L7ESKiz3CrQWH6s4ht1LdNNftfbGVZwBG
	o7rvYUWGiFoSF/dTZRu/NgS3auSixZNJobDJZyirGPO4fnbv0ipJd5rdfliOkUc9
	eEiD600PUJVbZwkHojfIewXsCcBo0aGZZZaxzVMVYNs4qJ3OaPceknleF7rkvs5j
	IgraJMcdnAaQNT37u90nkKamGepwyq6HhnSFOVZq56QHSp3G4pk1JJmspKefT9ns
	JpenBZBhux4AiPDf9HHmim65fyYsHiFvQOw==
X-ME-Sender: <xms:RvZhaf6XbEXNR-p2lFA3BgU8n96mfmEe9FlAuIWU0oFRhTLIhlmIKw>
    <xme:RvZhabzRH52IK32bjUD_KQTn3h_QCjsFxRPJfPUs7g_bwPO-gnIZgr3TEiRZH-wVM
    zqSiUnWWtVRKr_bIUnO7gjNdwb5aRTkPOrH68Ozru0iqvF9Ca_-GQ>
X-ME-Received: <xmr:RvZhaezHXYHA2mAeILgYxYFk6xMYaYoquGZMtB5pd_oVap2pDt83lmb1FTAUZxLFxNhrnGrguKA3GMrDBZl49t7EbNcoWlD5hKR1Zdk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduuddutdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:RvZhabxRvdFO5DOPyCUAKdxXPPuIMwL24iHdQyPMAkGrDsxOEhKzAw>
    <xmx:RvZhaQZycPtHkbQL4W7S0r_bhmg7hLSOgQe1b6AvK5UEpcU1bwCPtw>
    <xmx:RvZhaUVK1mpieOWbaqmOpoV2x_cUWGnb7pXrdlu7nUwj_kftOjRnEQ>
    <xmx:RvZhaWjlzKdylGNn-UPbWiuBxghYnhpiiDhPVWo1I3JFD4v4a_pUyQ>
    <xmx:RvZhafC20MDoTcv_PqQ0fEg4Y1liAtIKr5NdeDYRhqPI2VbW8xaYRoXU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jan 2026 01:48:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com
Subject: Re: [PATCH v3 0/2] repo: add --format=default and --keys
In-Reply-To: <20260109211554.90828-2-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Fri, 9 Jan 2026 17:31:51 -0300")
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
	<20260109211554.90828-2-lucasseikioshiro@gmail.com>
Date: Fri, 09 Jan 2026 22:48:36 -0800
Message-ID: <xmqqo6n2rmij.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Hi!
>
> The main change in this version is that git-repo-structure now supports
> `--format=default`. This way, both git-repo-info and git-repo-structure
> now can be used with `--format=default`, which resets the output format
> to the default one (`keyvalue` in repo-info, `table` in repo-structure).
>
> I'm also cc'ing Justin to see if he agrees with this change to
> git-repo-structure.
>
> Lucas Seiki Oshiro (2):
>   repo: add a default output format to enum output_format
>   repo: add new flag --keys to git-repo-info

How does the bottommost commit relate to what has been queued on
lo/repo-info-keys topic as ac3e74d2 (repo: add new flag --keys to
git-repo-info, 2025-12-09)?

