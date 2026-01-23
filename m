Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA79146D5A
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 23:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769210823; cv=none; b=GkVUXcGcXO9fefzDHdUqhYhjamVR06GnhnFzfoqEF93Qr530AhB6Hne0iPYXu/wytamiOr/FzE3GsrXLm6BdxWOMIFxv+zqcS0MRwPRlM57vwQA5Y/idaJHOhl278Kb/UocoDCwvNsdXY9imR4JBVDitMGKVEfaX5vsE6lQ9FD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769210823; c=relaxed/simple;
	bh=+eOTQWOkperQEmkREKb60c4VyD1BWwOJ0fEXxHA54G8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CfPC0nA+dJpJnFlqxQH0oYkSwHOh0VMrHXhw6LejatUghHSpRLelyiZHiWGlH3JcpQep0Mq3Uem5/59DHz5vdJAfCMJNh3hubQHTc/pil5BKAMrBFRJop+VrG3H4FeGRIAX4mB5z54C5u+kZu8ARcRsjxfbei8hzQx4lLOkl3VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sv1OYMM3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zLTgbfBl; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sv1OYMM3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zLTgbfBl"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 432FB7A00EB;
	Fri, 23 Jan 2026 18:27:01 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 23 Jan 2026 18:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769210821; x=1769297221; bh=B2f/h6T7+v
	vF2wVLNLfeoVqkkwrzZ1dCJkAcvpr76M0=; b=Sv1OYMM3NZyQSDCvkDW2jFgHpM
	9yMIaZu/sFDRNmb3o9fsGbZywWLn/r2frizt82DxRawqzwA1yNvVBDyzRYqVvtWf
	+nw2UaJ73SZU3K8SZ8n5hlIsULfg5jUT1VWCfYTPhdQk9DjHp6m0lhSps4mkqYoy
	aotxSzvdlHYVk34kzVpGEJM4h7rN12KLZJncc4rC6/OT0QlT2wCgHyEl43cmyrBJ
	75jagJYVX+XqIbVhN+UxPwClMwZlsqFAV9KQcw3fcGTGaLo33XCE3SVWGeOuU6U1
	Zv4+tdDOKlQ6nYnXCZlLS0Lk8tkEd07CNhDk5BO1FHhhui05pITTfHsm3KhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769210821; x=1769297221; bh=B2f/h6T7+vvF2wVLNLfeoVqkkwrzZ1dCJkA
	cvpr76M0=; b=zLTgbfBlcT9YiITykXk0c10B9Ekn6SKyTQZQeu9f/ALaMg13cHI
	yS93Vq9D9OTwtqS3GzfB+PGbjpZcpuF8eMyfdmuNbaPZa2w/0JLNMz+D8zG9jKGr
	1YOamPmSTsUyZHR5olLIQaeK7Pp8nbloqhnGjiU2JcX6ccUmo3rASPGMXO6mRn7F
	Sc4qD7L9L3pfDjg3zzMTXZsa5azidXh+kyFMi2CEJO/OaF5c/fg29HnOjmuXbjtg
	ReEdCMAWYNXI+bxBwgBeTMrFxZB3dm7fizVl6ZOtMs5emnvxJJGzGkfMKt171CYz
	xjqBhFXJHDPONkepil45/TeTspjwSBWu9dw==
X-ME-Sender: <xms:xAN0aQss5Dp1iZLIs3zuJG4yM8ycNeM_Jyh6v6nm37vwkrG_BmSNMw>
    <xme:xAN0aWwSyhoiopWvtnaBugU-PLLEPtjsLmKDC7eCisjEgLQI7ACsqhddZVubliotA
    yl7QVYPjh7IVFojSb-A5BFyEVOOHTBUcMcxwToc000Z4NZpetl1mA>
X-ME-Received: <xmr:xAN0aTCvnP4_7dx4Yg7fcpM0vnn4qEa1GC6lYDuqDPQ_GIeSHSY6N5Ttp7CgeMw8KOfCLqrpFNBnLnNZgm9F-U_CzsP_csg3vxg7aio>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduhedtfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnrg
    hsshgvrhdrghhrrghinhgrfihisehoshhsrdhquhgrlhgtohhmmhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgt
    phhtthhopehjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xAN0aUfWi90Lp9boB1dA6c5VizPDC__Nf2ng-SuhEgy4DCbwVM435A>
    <xmx:xQN0adl8iiBVeox68Dh4IMVKKf6boZRjUoGVLVlajC2HrGXNoBM-iw>
    <xmx:xQN0abEi_IsTjNYay5xMyklX6KF-7DSejJsVN80tx3ny566SOzx7MA>
    <xmx:xQN0aV6n9YWQmLICdP4j3_2gStkWz3gLajn3KA6ysCjiplbwR1LRHA>
    <xmx:xQN0acxBUiOQixGRPcdxkdZoVq6Tiv3mk7dLjv74oOUutT6fFPPrWhtB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 18:27:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3] submodule: fetch missing objects from default remote
In-Reply-To: <20260122152722.866341-1-nasser.grainawi@oss.qualcomm.com>
	(Nasser Grainawi's message of "Thu, 22 Jan 2026 07:27:22 -0800")
References: <20260114194815.1049888-1-nasser.grainawi@oss.qualcomm.com>
	<20260122152722.866341-1-nasser.grainawi@oss.qualcomm.com>
Date: Fri, 23 Jan 2026 15:26:59 -0800
Message-ID: <xmqq4iobhpvg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nasser Grainawi <nasser.grainawi@oss.qualcomm.com> writes:

> diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
> index 45f384dd32..faafe31409 100755
> --- a/t/t5572-pull-submodule.sh
> +++ b/t/t5572-pull-submodule.sh
> @@ -257,7 +257,26 @@ test_expect_success 'fetch submodule remote of different name from superproject'
>  	git -C a-submodule reset --hard HEAD^^ &&
>  
>  	git -C child pull --no-recurse-submodules &&
> -	git -C child submodule update
> +	git -C child submodule update &&
> +	test_path_is_file child/a-submodule/moreecho.t
> +'
> +
> +test_expect_success 'fetch submodule remote of different non-origin name from superproject' '
> +	git -C child/a-submodule remote rename origin o2 &&
> +
> +	# Create commit that is unreachable from current master branch
> +	git -C a-submodule checkout -b newmain2 master^ &&

This test assumes that the first branch created by default is
'master', which will break in one of the CI jobs:

  https://github.com/git/git/actions/runs/21304166518/job/61328461844#step:9:1942

If we are assuming that we are on the default branch when this
"Create commit" step runs, perhaps you can replace your "master^"
with "HEAD^" to achieve the same effect in a way that works
regardless of what the default branch is called?
