Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865092F49FD
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 22:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770158941; cv=none; b=sX5uHYd9puCHpmNzfI4c7Z1jd1HIiANS5ai978bv74sk3DwirEskWz/wl0bPnn8MW82EF8bkDZWCLwUHbWPnk6EotcFvJWZGmzD2ld8Zhc902oDpJ1eLCNwn5AHibFkxbRMmyGL1ocYa17LPBzgpdUZlVlHwmTs4uif9V/EzgiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770158941; c=relaxed/simple;
	bh=GRndmk0VOACX1F+pFqvK8syaJolSvJ8S+HYIkguCc9o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PYfb5k2u1uFAFTT3PirXhpbHPQhuLTNVSecppcTN8HmUFI13pA2bK6b0Gw89O4bYnSvJEzBGzkn36Fa4onfJTftoremDyK1nFDA8Me2Nmcyn6fbKk8LzhapAeqU6sbCVTK/0GsLuBXEEE+EB1+oaFRp1Dg1HOmaMbImLoTsWkQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hALWVYzc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ceNrIXMZ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hALWVYzc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ceNrIXMZ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C58501D00113;
	Tue,  3 Feb 2026 17:48:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 03 Feb 2026 17:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770158938; x=1770245338; bh=GRndmk0VOA
	CX1F+pFqvK8syaJolSvJ8S+HYIkguCc9o=; b=hALWVYzcS+vHGEplBKaLByBXWW
	oDjllZM+Ia/8oCm5G7XiHECTIyBoPL9lKfu8X+Zl2aAGbvkNbC6FsjC/xXVN15/D
	aWw7u0i3/cN8Hgwk8G2g0tIy8w6dE3b9svAy2XhB+KFPmrPB95JY9X0zo4buLceB
	o089TUjM3htnxOJ+lJIZvzi7wljqiie/1yHVGftYdETTCWo4BAcqxi3zX2q9xE6D
	qQaCzE8hCC4F5ElIbe11oyIiGoJWMAR0vxihFu7YoKNlAxCYogdiH5rFHn1KbwIs
	xsBtgDbfq/VETzonUE7f14rMvkNi60FKBMPp0yhQIRdfvI2t2ibtJzzqjYdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770158938; x=1770245338; bh=GRndmk0VOACX1F+pFqvK8syaJolSvJ8S+HY
	IkguCc9o=; b=ceNrIXMZSX5BCfcBMlrxFS27g83NdSG566cuMdPbL4SdtXDrCXM
	0HNG5L1pJXIoSPbmmkYnRcs3rFUjoYaKVxPkPMzZV+NRUiHFl/STRYui8FOnKL5i
	AjdIms6mo6bo44/hNWL+y3d9VV11sEvrv1ZHQ3pVtlAlHHN1O/Muhij59j+fRZBy
	0+jyhbM9g8tcxXcqQHmW4u5bt/gaey6DWD2bAYGupEHTBsg9HMB75yrQaWjbfW51
	kGnxOJhyioOZeLcDKe8kYIrLQTZ1WrEvWG4PuoFSfmK+hSxvVFfmPExR7+PJUWWQ
	epPRZX+1bxEkMdhbgqIxSPJlakpWTEeR0ng==
X-ME-Sender: <xms:WnuCadWRldq0559k-jAhAxmY1H97n43g0VV2Rumg8HXDp4qYFw1JHw>
    <xme:WnuCaVBt4krgaJlJ-kVAMFuiHOYmKH64Ghs144_bxKNRym_BoGoojoF1ca29UA92y
    w4hebSd3-5ZWViRqo2eDwhU_MNHcmPaA8DxJ_dLNZzPOQTcRRZGjQ>
X-ME-Received: <xmr:WnuCaWxz3KrdFJLY1IngZjJsGgbpjh3OcM0qfZd-eMcan4qxgIuGKRPGC5b3goUBvCOz0vw-al3FjUTDbYqaAU8idcJEGjQdOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeduvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:WnuCaaCw6sepVCRAv0f6v_WmvrvyPnX6K7GvbvXlDcwkYa2V_QrwzA>
    <xmx:WnuCabZvfvd3k---ZmHTl0fUDWpfpqiiT8jX9YNm2Kfq7ileqDiVgQ>
    <xmx:WnuCaaiVjNNfM_pFxBEXvpTnPdWIXgAxjDFx5UvSgJ9H1fk-B4e93Q>
    <xmx:WnuCaV6yA3YsLUFTTcOOETsyMPXJV8G6G89Is5ZHJMwWB58btLictQ>
    <xmx:WnuCaZDbD0g4nGvLUckj-s4_T0LXm8_VhMC2Hm8omoa9yjlapso1n_Wi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 17:48:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/5] builtin/repo: find commit with most parents
In-Reply-To: <20260203221758.1164434-5-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 3 Feb 2026 16:17:57 -0600")
References: <20260203221758.1164434-1-jltobler@gmail.com>
	<20260203221758.1164434-5-jltobler@gmail.com>
Date: Tue, 03 Feb 2026 14:48:57 -0800
Message-ID: <xmqqpl6lqw86.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> Complex merge events may produce an octopus merge where the resulting
> merge commit has more than two parents. While iterating through objects
> in the repository for git-repo-structure, identify the commit with the
> most parents and display it in the output.

Does the size of octopus have anything more than a curiosity value?

The opposite, the commit with most direct children, might be even
more interesting, but that may be just me.
