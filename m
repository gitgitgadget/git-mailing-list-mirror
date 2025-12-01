Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEB421348
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 02:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764555687; cv=none; b=W4es55thPtWoU36hInBPFaZSicfV4KH1B2T9vhkP1tx2w28VwpmHIuOOCPO4fXCs77k0K+BfPkrL8yytp9PeE0EqR3vGcGaxmS2Wr1qOCwDB3qAOr3sweRujPWTi7kF0FzpTWov52VeMNYr5aPzeG/LyCaXHv6G25Y6iDXn81nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764555687; c=relaxed/simple;
	bh=HH2oUzFJvcZYe3NvcSVJdjbcUUdBdkl7VC7UmzRFnLs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NpsCUEfSvWwNdZYSvitjSeJZ4E64HkbAwKFvK8eQiB3gm9rGMjUGbQmEKcj+aDKtxbNPyiVN5UlEIZNd/nxq/0NfG9U5MFdMI0KCCv52yCyhtmnVHvJRXiVYLsyojeEcZJ0uteQ7zm2rWuZATcL4YgI3Ap7hVKpmi1hizFRhI14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KEL6t0vm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YZ5e9Bld; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KEL6t0vm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YZ5e9Bld"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9F2EFEC010A;
	Sun, 30 Nov 2025 21:21:23 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 30 Nov 2025 21:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764555683; x=1764642083; bh=ux2q5GvQfj
	vVcpDjLmKCTun1XfkFsMwRODhJS8QxpWo=; b=KEL6t0vm2bwT7l7+HOSwuUQ/wU
	janXHJ+Il0Mwc4F+OdZysF/tLXO94XGU+S/6jennOTtxIlvcoYd3uw57SmV2/X9H
	PI46X/VMyTTGQIDcY+LEIq29xAxTPElly7rzS1cplClE5/GeV0zvKArdreKchMEA
	v4ME54qlJkMRZ2zxuk214RqF3EfOsYtq5My4xkFINPmFGE3orYV9u0OnHmRO9Eoj
	Dg6DRzGBLNqyfvVcy4jXD2j/ViT3oVbAZkJ3fIgNicCoh7JFU1r7ujoW8XEP2hDD
	QOq+J0LoECTRcGi4iR1Wjz4SMCvD8/U0rXLq1O6SFD+QWq2yNVXtdlfFSekg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764555683; x=1764642083; bh=ux2q5GvQfjvVcpDjLmKCTun1XfkFsMwRODh
	JS8QxpWo=; b=YZ5e9BldOUrF/mYA8AMKvnoUSkNRAiST4N+7135NGCnKYwfi3Iy
	4UYDJt4991xB/WIwza5DaENYtjntOX8zUmIOJnj6DxU406aznHx0hY6ZD9SmJPCE
	BcRybQ9YVZEmc3kA7hyjq1cQMTMVB0MEXwZnPWDlg+KjIbFGuUFAXslCrz1i6mKi
	kUlelCyRJujnfCGp+/m9nj+odZeejvyFcPnf3I1C7q7llnIOYDRF49k0bNUnbteY
	3Rlu5MDV4QCKZMv4WGU5SyV1m5JWMoGx7yY6geTT038dtoQChWgCnbf/lhsT/JJO
	WeLeLT3sHaulyGGuJe+3KQ5qsRReBk/nDXA==
X-ME-Sender: <xms:o_ssaU0qMmBV4vjxeI7laX5VXxnzEyztptze_AhCJ_llWjgAEG7jtQ>
    <xme:o_ssaWHxhy_Sw2Zia-TuC_7-daA9p0vgviv8u-LyWmY_hFEKo3WscUF72kLplvV7b
    ucA1mMpF0QrhBYy0O-55GnGZEAurRiOnMnrv23GsByaASZEpOnb8g>
X-ME-Received: <xmr:o_ssaR76FHHpDwDMYtVLxuRIHNtdr5Lj1IQwlqo9lzjw1vzpY1CFQ_S4H34oKiLaSOq6BhfOtOhLIAPCnlH_B3QRKvUe1CIqjG1x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheeigeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:o_ssacuAbW9XQ4jsAqIq5Q-Mq59CCQJ_YzrBlIPxxlqSq3gANPYgAw>
    <xmx:o_ssaS5uu0V4HsYxoDSBqFa80XlkXG8CCGZB5sJ3BlHrh7u9Iwd9tQ>
    <xmx:o_ssaXWLydqbl64PlcW7HjJ3r_SJN9PQQN-600L6V1nzQZwxGSrjyA>
    <xmx:o_ssaU-S4si_EGX9hNjQe5YKODyvbuVCkIv2hc6Iytqt8vjlJ1qceA>
    <xmx:o_ssadaxDFGGeleABGwouF6_j-BmSpiYiP1bRvmFUTZ0wbQC9lhQh1_4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Nov 2025 21:21:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com
Subject: Re: [PATCH] repo: add -z as an alias for --format=nul to
 git-repo-structure
In-Reply-To: <20251130203456.28437-1-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Sun, 30 Nov 2025 16:59:55 -0300")
References: <20251130203456.28437-1-lucasseikioshiro@gmail.com>
Date: Sun, 30 Nov 2025 18:21:21 -0800
Message-ID: <xmqqms43aqn2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> -git repo structure [--format=(table|keyvalue|nul)]
> +git repo structure [--format=(table|keyvalue|nul)] [-z]


It's a minor thing but I wonder if this should be more like

    git repo structure [--format=(table|keyvalue|nul) | -z]

> diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
> index 36a71a144e..5a50acf345 100755
> --- a/t/t1901-repo-structure.sh
> +++ b/t/t1901-repo-structure.sh
> @@ -101,6 +101,12 @@ test_expect_success 'keyvalue and nul format' '
>  		tr "\n=" "\0\n" <expect >expect_nul &&
>  		git repo structure --format=nul >out 2>err &&
>  
> +		test_cmp expect_nul out &&
> +		test_line_count = 0 err &&
> +
> +		# Check -z
> +		git repo structure --format=nul >out 2>err &&

Didn't you want to check "-z", not "--format=nul"?  In addition,
perhaps test

	# "-z", as a synonym to "--format=nul", participates in the
	# usual "last one wins" rule.
	git repo structure --format=table -z >out 2>err &&

as well, or is it too obvious (by knowing how parse-options API is
used) that it is pointless to test?

>  		test_cmp expect_nul out &&
>  		test_line_count = 0 err
>  	)
