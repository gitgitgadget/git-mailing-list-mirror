Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5FF3B19A
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753190297; cv=none; b=S/0dU6JtrVP32AxxZomTt9zUzANOr6Q80a4UmE3NXtcyX7zWx4IIPaJ8Vd0kWzjDarET1Tn1hImVuDDangNnHzKFr0YNk4gPqr8pNctLKW+Dxx4PMG9s/tk+Btz32IuLG+U2bw2qyYclw/lE7L/6TdJs650Vaz8H1mnzYqbW6rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753190297; c=relaxed/simple;
	bh=aIoIznOH7YIb+Yx1GGEMw0+b/TqZcXCgMgRC+soq92s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a9B2E+xfnsQ8zYZ7APr4mCC+BcnAMm1peUMik4Ro/dImFBxCYBQ7KR0bxs7e86uSnPAY9sGjVOmBbfciQMvGgx1ucZIQQ2GTRN35UkI95ot8TM9aSDxm11e34Z8jUgtDa1KcLlkipkHqxZesZJRR8P4PVXrLHkDk7qaoWm5wUwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lo6NQLN4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mh98vUSF; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lo6NQLN4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mh98vUSF"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id D5BACEC0327;
	Tue, 22 Jul 2025 09:18:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 22 Jul 2025 09:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1753190293;
	 x=1753276693; bh=Mkw4u1bHGUuT2dqq1obcXj56uZZUULU0LaYjKZdUg/Q=; b=
	lo6NQLN4kxWCPQo9Lbtu2slt2o2F6HtWxSTMUCFfzMdeaQP6CQ+0bjwp6xDFxFHK
	gYM8yrhv9yuc/ASK5id+ax8uCv+3ZbVKZ2rHi0/6EBiqv30T6Fgo2ZaXiqKCREKB
	QwPhfc4vzG1ls4pAcIMuHFc9dKpKHA7EzOJp3AZj/NGH4ugqUAK1PxUG3Z55KYN1
	+RX9XoFY5/AJSwFbUHmI4mKyYjE7X2Qg5lxQDh5GV5H3bBI+DLVveh0VWk5bd2iA
	FsxgRu2Qn7PHiAYJ/BZ3pxWYfGoialKoo4adQ3K8LLD+4aL9Ud0S/B9Ey1XNBjr3
	5/pc8lVpMOgP97R3Rw94Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753190293; x=
	1753276693; bh=Mkw4u1bHGUuT2dqq1obcXj56uZZUULU0LaYjKZdUg/Q=; b=M
	h98vUSFtymxLzTHaTT5bMQWB8DOd15Y3ReGk2WEwn42Oq/ncHht6TlXg4re8EjvT
	HM+Ku0Xzz5zs7zEBl3oqft2BpoXungHbr1z1dMdGyBtpFr3USoDwauWPpeXep8ma
	bZtH2b4Z1WV4IgRrw7KyKIF2i+2hm7wUI1Ecd6U65zR/2gXsq265mWgJBM6IhkRD
	1fTFdOtuFK2/DQn8wJgP6DeVLGt6YRJIZJ0+50FvwvAQ32t15dDr/gGFBU/kkU2Z
	iX4XwEA6fowBIG94q5qhABCkH/UX5lFh4UddPX2QstWsu0R5XwzS68PvgqqjJObR
	LYzxo54P6fwNuQ9uyIMsA==
X-ME-Sender: <xms:lY9_aMDx6msbgs7KoIwInkHRb7JXGHIrhnVRK4L-0p1bZvJE1YwMMA>
    <xme:lY9_aBx3uZnWV8ePwZk2W0FY888Zy6YXDBgLlyqcZkPpRCMKBLXnSDFdtqFUu_R8u
    8TV_flPxZEA5Uaqmg>
X-ME-Received: <xmr:lY9_aJBilRMOXk4CUXXa9ngDyRHwsjo9lg0SReMwXBax8h1bSMnMbVkDYHaNk1tWLiLnbkyI8r1Yq8Tljmw9yr_QE5k29Du_fCX4xeM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejhedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekofdttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkefgtdeuvdejfffgheeufeeugefhtdejhffgkefhhfetieffteehleehtdfg
    hedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:lY9_aObSSbSTiOKMUl8qbh4UHQQl6ZV5_UJMgU-9HdxM1GFjkVWabA>
    <xmx:lY9_aBjxggHdJrrfi9JDQw62YEywG6HcDR__aHFefeVofv6p_-33-Q>
    <xmx:lY9_aA5BT8mkl_GLA46FlACiImPb5ELirOpYt1bixMy5YIv2K_LeVQ>
    <xmx:lY9_aI4HSGtXMWy8Ye_Z_zOIhhHRV8VdzmAAqHa_0Fz6Ews3i9eI9A>
    <xmx:lY9_aBUAlE-esJv2qZyfUIdOg0E9_7NViTlORGRYwxGp2Kr3YouoVWl_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 09:18:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] rev-list: update a NEEDSWORK comment
In-Reply-To: <1599cd31-436c-4ac7-bbef-be7dfbff00a3@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 22 Jul 2025 10:41:02 +0200")
References: <xmqqa551127o.fsf@gitster.g> <xmqqecu9w4a5.fsf@gitster.g>
	<1599cd31-436c-4ac7-bbef-be7dfbff00a3@app.fastmail.com>
Date: Tue, 22 Jul 2025 06:18:11 -0700
Message-ID: <xmqqzfcwuzxo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Tue, Jul 22, 2025, at 00:46, Junio C Hamano wrote:
>> The comment was poorly phrased and it wasn't clear what it wanted to
>> say.  Strongly discourage this broken pattern to be copied and
>> pasted to other code paths.
>
> Why “was”?  Shouldn’t it be “The comment is poorly phrased ... so
> [change it]”.  According to SubmittingPatches, “present-tense”.

True.  Thanks for spotting.
