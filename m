Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC65E3B4EB3
	for <git@vger.kernel.org>; Thu, 14 May 2026 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778744266; cv=none; b=F3Ua8Vr/7PD3ERaqmEr9RXu4XKi+lSbzMe8lKpiTRMaYm54fnr5FhPglQVQO9zOp4n/HR6bVRxG7kdhB2v1TvnE2lCvlAix7xBti54KVVael7+WdLuExQddTIL5JCadnK/RP4I57AF3eDkjuu4kCEzm35F61M+6cugM97R8iPFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778744266; c=relaxed/simple;
	bh=PwD6B+SghfaD9Bn76N/Bqi3JXfhhrb6Yw/MLJJlxVJU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KfqLLX166BzrKAi0RSLye6fo3xIX5u1BKuPTiR+3EzqiK3tZDXHck9k+erhCpI2VlJEeLzZfRQFlOBEsv4VZnpDcSeOfo70cr8wGTbmq61q9BwOVo4p+r/MiGxil5ztxRODegOnO4PTluP4sMdsbYDdg6irNtq324WQGytFZKjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jEMy3jX7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T1rqj0op; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jEMy3jX7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T1rqj0op"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 9EE09EC00C0;
	Thu, 14 May 2026 03:37:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 14 May 2026 03:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778744261; x=1778830661; bh=C9jw/mVPmJ
	AqdAdkahq/2DxqNXWYwp6c6E93UW3rU7A=; b=jEMy3jX7vHNsgl8EGb65jjPcmE
	p4coE3qpQISn8cErPr7rM7jBFM/VNd4ZU4mK6FwrdSWy7dRNERS8k4qGkuiW3ofL
	e0tSXN5KTeTWmQvdxeYou9u9Ue9q7t4uk2c0dTquLRGTjCt8XGB4Q8iu1h7Ed+bH
	1rw68pwwyZuvHXM3S2w1Evx5PS5rdrKidDS6JIk0BN/iPXN3JLOJ9BtY57RfcelW
	tSGIKJseTqRm+uS+BVa1TV7MfQi8fLOJUmP26hxXL4fvZHDmieVymExEeR4FE7zs
	GZrwy8fi+Lx35jbI9Go1VdWSn99tXwhCMZkspHUG2qIyJb2ZdGEutTxFTP/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778744261; x=1778830661; bh=C9jw/mVPmJAqdAdkahq/2DxqNXWYwp6c6E9
	3UW3rU7A=; b=T1rqj0ops216rxaz5XTqSiz714Qhn3MBzzlxBHGV2uFt9RebLsN
	eSpU47l0vLDBDrn5U1AqJt+cQeeJ7E2zseoPDCf1eQVNWYyTBdslOpEyf0dMhgoj
	/XhNkN8GhBaRlyF5H1t3/35Q0kBV4fZby4nShgyRrefylkhVYVUrirThrGulsb37
	QEfv+wPAIbaIcjeAGoxPZ6QXFQXxqsc4P8qAjPFJEZEm04i2s30weITX7nhE+QC6
	dIIJeK1KrucQLwAdZliUyjs9TxKyzKtx5vlp1h6x7W8oGIyfcSUz+7HmQRT+C2IZ
	A/MTDDQBpOgyq56ZdXWVwLmDKTvRu1yiQtw==
X-ME-Sender: <xms:xXsFauo7Izlsnw1JuGW3BsYTL2J_9Q7eItemEuF6aalTUZA1jmuOVA>
    <xme:xXsFajiluT6d7v6qx1A1CkUHUUSP7-GzDZpyOiVWIX3G6cxSiuqpGo-f2IJNbD3pO
    KdQsmNft02Q2iLuv_r9UpcsfdlDr9lb3G4RRm_im7vzlNKs2-rR15Y>
X-ME-Received: <xmr:xXsFarg7LgIJhG9uoORk-_Hq6mgzYzZ-EjbgX5sr9O6aYzUfGg9XiNSf6-pailXy0-i6mJCtD0GjRVOLhVk3E0-JT7xys-xJOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdeileegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhmohhnthgrlhgsohesghhmrghilhdrtghomhdprh
    gtphhtthhopehvihhntggvnhhtsehvihhntgdujedrnhgvthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheitheskhgusghgrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xXsFapjnl5oznmLyvSdpTpdr-5Fjl-QAK9aV7rk663_kJFvcsCu9XQ>
    <xmx:xXsFarLo9dG8ILgJYEWrW9M-MKFVqnefh46J0YN_VaAl37W0stMR6A>
    <xmx:xXsFaoFZ2Djitt5bout2P_Q0MINh-1m4F19d3XYxoHjJKT-du0ljyA>
    <xmx:xXsFavRJrUvcLUIBPw9VFRXKvd3e10vI3BU4BqVpxJjxDTmO3-0vlw>
    <xmx:xXsFag--06qnSFiI3HSYIoLVfE3BVvFKllwvsFxCXWnC5fS8txusf5Ra>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 03:37:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: vincent@vinc17.net,  git@vger.kernel.org,  j6t@kdbg.org
Subject: Re: [BUG] "git diff --word-diff" gives a diff while they are only
 space changes
In-Reply-To: <CAC2QwmKRyYfE+30Fh75gvAEmJjk8g-3k+G=RDiEJ-KGNExAEow@mail.gmail.com>
	(Michael Montalbo's message of "Tue, 12 May 2026 13:56:19 -0700")
References: <CAC2QwmKRyYfE+30Fh75gvAEmJjk8g-3k+G=RDiEJ-KGNExAEow@mail.gmail.com>
Date: Thu, 14 May 2026 16:37:39 +0900
Message-ID: <xmqq8q9migqk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Montalbo <mmontalbo@gmail.com> writes:

> @@ -457,6 +457,11 @@ endif::git-diff[]
>  +
>  Note that despite the name of the first mode, color is used to
>  highlight the changed parts in all modes if enabled.
> ++
> +Word diff works by finding word-level changes within each hunk of
> +the line-level diff.  The line-level alignment determines which
> +changed lines are compared to each other, which can affect the
> +word-level output.

The added text may not say anything wrong, but I am not sure how it
helps the end user to know the way machinery works internally.

