Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A4E2F84F
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773171309; cv=none; b=MXx2TraMdQ5P6DlcV/loBzvj9q8cd2kJgw6UzZqqp/PZXZnauBMzlBJeiiFO8UAkz93x7gmURgB60T3nN3qXcgoMJiXtArLYXJuO8sJRFiFPtDU34oXCfICAetw1fPgZJLSpKim1bQLBXEaUIDkRX1LTWAWKIgFhTrN0EwMlqOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773171309; c=relaxed/simple;
	bh=gpaaBvE9/tcIkYx9X0/12Op4An5sCnXfCtXjWQ5jjzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LFJ44cBR014teMTTEhECG4GnSTqW7JRrEZeRFISl7PfSW4j0xVsMxQIC6XA5j1LT33QONXSPcAxL1ujS4Jadb3UH0PpB9MHwb4l+ZKQrm+uCnw19N2sYMJmptUCGrQev6MAmoM0h3TLeIhKHaqNYcOjbBfW7lxcyCUkMajzDdrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UQSCWsOp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FgKIkTOl; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UQSCWsOp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FgKIkTOl"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id AE25BEC09F9;
	Tue, 10 Mar 2026 15:35:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 10 Mar 2026 15:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773171307; x=1773257707; bh=KkwkOUC2Lq
	4P3J+pWZsGFW1qK+J2Ol0rKF6TGiQSuSI=; b=UQSCWsOp6E90HNfrK5IF6MB6Cg
	1Tw1l3AzJMmpljrVNtbBTUHS5F+hYwFsE0ZrDHgjYIhO51B1loRKSDK0LPBls7GH
	tcgxRzOYIuvQVW0YFrwFSkrMWg2iOlybR+QHay6gRNnVL4pqgS6gzknyD7BNuQ83
	4pA1+WNPDYhOL94eHxmyY2DExeyLltaBwb+W1gb9vcMzq0DOAQVAFAscV72ggCay
	Psr0bMunACx6hDRBdQZPUIUggwjUBHMkkVLFf6biNmJEUVG2qFbu5dWRIOZivOeg
	g/QJO/gNon2ukU0lhIihGGT/R1k3n0Hd+RhDKtVkTKVZXop1ycCEN6vJmNQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773171307; x=1773257707; bh=KkwkOUC2Lq4P3J+pWZsGFW1qK+J2Ol0rKF6
	TGiQSuSI=; b=FgKIkTOleUMEW4HVC0SkzFysE0g6miwhK4TUBBok9EgCxpDkkOF
	uLHfgDhYcWB5cjwcYm/9SujcLMZPC1d+lLkXXx92ua4Zlo/MI+RGg2p9H4i3aVIr
	C0Jqj9kArrl0y5MwSBHLGek6xv8XQomrF2cOmUrjMdLQ4Amt/qOPRSSRAaLAdOXB
	HmrPUxnNOimUFAcMUF3onL++kkUG/97a0LedLhvjl+pgJllsVsG6u08BmPKYH4F4
	faYlmbCyI84kfZtdqUGmIIaJMCCTE+0/6p/MasWitO/YhTgtxxoMQTXhZDIELlxN
	kBDI2CjDhYJBCTBGmFuYax5VBsbyltwXeXw==
X-ME-Sender: <xms:a3KwaRRkP44UA9UYFrkKmSHNSKtVKAd-gW4Q3tPDz7nAYaW2CQ6CjQ>
    <xme:a3KwaRxVhoKLVpmbCyD6SwWrh9zMrCfZWGbGGGqn8WlmUy4U2_MNDn2miDXK85EWN
    JuEmi5uGtoMm5cig6GfhWDKp3tgbwEn4JUkpgYg62_79etnDimi4g>
X-ME-Received: <xmr:a3Kwab1yY29JkC316xr0ExBGtmd7LX-U50pA6Kc4i3O2hetsTZRTAprGrB2xtLk96ZxmV2J3Rg7m35Wpogu1BOqOGGyGeCeGNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedukeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhdrshhiugguhhgrrhhthhdrshhhrhhimhgrlhhise
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:a3KwaX62yUvK1O1R3ihcDd3SCflVQxz5dFs2jTpFp6oin5RbKpiKqQ>
    <xmx:a3KwaWUdQaw8rNzlTp8Cxwf_a5qydeTVmLCciGe1lyieFQwwT_bLQg>
    <xmx:a3KwaeCP1NVLBZCB6D5W3AGdvBo3Ol86qx6cg1euPmDW9ulPXC3j-A>
    <xmx:a3Kwad6VL28nVb5c66iZWlrwoKhhNBKbmBGZwXg_bHpO8uGI8TPvHg>
    <xmx:a3KwaTWH7RrJwn5foBNGuAww3UhSnSgAMW3XjCFKF55r77i80CYVmiI_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 15:35:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2] submodule--helper: replace malloc with xmalloc
In-Reply-To: <20260310164412.47403-1-r.siddharth.shrimali@gmail.com>
	(Siddharth Shrimali's message of "Tue, 10 Mar 2026 22:14:12 +0530")
References: <xmqqqzprwu1q.fsf@gitster.g>
	<20260310164412.47403-1-r.siddharth.shrimali@gmail.com>
Date: Tue, 10 Mar 2026 12:35:05 -0700
Message-ID: <xmqqo6kvtr4m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:

> The submodule_summary_callback() function currently uses a raw malloc()
> which could lead to a NULL pointer dereference.
>
> Standardize this by replacing malloc() with xmalloc() for error handling.
> To improve maintainability, use sizeof(*temp) instead of the struct name.
>
> While at it, ...

I think use of sizeof(*temp) and dropping of a cast from (void *)
fall into the same bucket, i.e. to improve maintainability.  Both
are good changes.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 143f7cb3cc..f3e132888f 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1160,7 +1160,7 @@ static void submodule_summary_callback(struct diff_queue_struct *q,
>  
>  		if (!S_ISGITLINK(p->one->mode) && !S_ISGITLINK(p->two->mode))
>  			continue;
> -		temp = (struct module_cb*)malloc(sizeof(struct module_cb));
> +		temp = xmalloc(sizeof(*temp));

Looking good.

Thanks.
