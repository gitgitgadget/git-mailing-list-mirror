Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C77B3B8D70
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158629; cv=none; b=n0NodV5QiufARDpOC0RMXk4XEkrM/PKZWSJ8GmBSXG5e4gwXoqigFsT4z+KBaYLoXHqZt9kBl9UWlN7/o07iVc9Hnqc/Pc/iU30ytwNkfiE77rDWuVeSH+/4Yom8vCggwxdyBYrFMZxS29oRwwRpZ4iuIZ5mn3Ei1avRA8UzDmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158629; c=relaxed/simple;
	bh=GSpp+qQVaI4s5ocO4R2Qo1SAZMVy6RI5Esvz16AMdfM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H+QNYN/BH3jY/Gz1Z6Ks7+7bR20iG99OEN1T5rDm1OE2q0HxhCrBmjIYgbhuwi8O+26P575+025XZlbh98yA5Uk67f2pDr8xg5Zol5Xy4aTZJIRjEP2zf0e27vIusuUxKzxSKYpXLThB7IOEmMG/URE8WdUeBbdn3Y3x19ULeDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MRzypUuh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2QmAy2/Y; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MRzypUuh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2QmAy2/Y"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 689A0EC027D;
	Tue, 10 Mar 2026 12:03:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 10 Mar 2026 12:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773158627; x=1773245027; bh=6FgLOize7c
	altxjlXUTjzpyUOLtbG1XegyBCHqsibwk=; b=MRzypUuhSG6XpocYu9F0OgNxxq
	h5zq09kCVHJJ6khEM9Zj63MXU20veXY8jPunF5nO4M6JedoMwmEbybm0gEYwIbRG
	HE7TPc4/tWXDxtSWGOSqU+9cPALL2/UeoASMrJx4BH/tYU19jeylop2LqCLMkRdh
	aBQw7iuZD8MiFqwwmkPtNYm/RmuThFasgDM7YGWT5ii6O92m8+o7Hr7fDH/SvOVz
	jgPCr4xPs2U8lJN1JuW6vdTd8KEbpRJuqgmCTsHwNd+xYk8gPEkD0Ui2aHQmz5ip
	gVaXMYBwZOnDDEp0ORg2wyCiBlys2r1ybtiPzOZ8RoL4PTonsuRnGmt+BOQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773158627; x=1773245027; bh=6FgLOize7caltxjlXUTjzpyUOLtbG1XegyB
	CHqsibwk=; b=2QmAy2/YXi8hyjHaS7wuYF09XVOasl6eQ08Ttxw77D8M3xXcljL
	c8VsnA6WElKukqevFzO2xhBWdJZxJep0JqpBlwNOmos+0ccuvcypCdMUWPurmDmY
	f1IOyrK1JfYdmaH17AEu5RgZyb/ryDF8Y9eDnnRvIU9KeJehhjkRxrVmvOSX0O/i
	RZWfQndB5vhiy9ymXNXVQmVFlHpWeCJBeNw4ehwRoCGPAhU9xUln2N0nwMhVGVI5
	W+/z+anTThTzB0c5hL4zZ+wpUu2JpVzhdJLfZR4yr1GdvCrA0mS+SUawn88Mn8ms
	7GA5XyjAKVfvvOGrVIl+NIOA+Qkrs2DPUyw==
X-ME-Sender: <xms:40CwaeLyD1mcJBx41VtxWv59ZwdmrGS3QygeAP7vQTvXRFmfH0XWGQ>
    <xme:40CwadI2iIeCUDmvxJPv9YgpszUMfNUT8VpIMOBgboYOMib4r7qH8iqy2RQnUcNs0
    hLSxTWoQmjFjJPbzO7R0cWEMSX8kryjSAIDKvgIITwr-6C380D8hA>
X-ME-Received: <xmr:40CwaTsRwikanAyFNckosXtLTq0wFVjrkCiwICQt8Ibt0oBGKz6nnrFAjheHcmGXG3z2VHELmguWEKJK5T7Tu3NvZWhAKuF1xA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedugeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:40CwaSRmoAjOpJ9QBOpeKLqYqIGXxvjv8PRMAeL8lTLBm51cakTprg>
    <xmx:40CwaRMLgdb-0iAsin66QghrBsvSfFhE--gnf0Woyyb79Ti6iRQUzQ>
    <xmx:40CwafYW_0JaRA-vFcWLuOywBqWiBgK-QZ-9v7xWzchrYQlh1L3vdg>
    <xmx:40CwaTze8LuHBrBR5lb35w53EDzz1V9BDC4ZX0S3mZFmybT_mXQ5Ig>
    <xmx:40CwaTPvFRmKMLTcjgUaqOVhKXtt21lPMghrvqLFBGyd2AfNGPKE3xGq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 12:03:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH] submodule--helper: replace malloc with xmalloc
In-Reply-To: <20260310121013.39291-1-r.siddharth.shrimali@gmail.com>
	(Siddharth Shrimali's message of "Tue, 10 Mar 2026 17:40:13 +0530")
References: <20260310121013.39291-1-r.siddharth.shrimali@gmail.com>
Date: Tue, 10 Mar 2026 09:03:45 -0700
Message-ID: <xmqqqzprwu1q.fsf@gitster.g>
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
> which could lead to NULL pointer dereference.
>
> Standardize this by replacing malloc() with xmalloc() for error handling.
> Also, remove the unnecessary type cast and use sizeof(*temp) instead of
> struct name in xmalloc to improve maintainability of the code.

The proposed log message should explain why it is a good change to
lose the cast.

>
> Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
> ---
>  builtin/submodule--helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
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
>  		temp->mod_src = p->one->mode;
>  		temp->mod_dst = p->two->mode;
>  		temp->oid_src = p->one->oid;
