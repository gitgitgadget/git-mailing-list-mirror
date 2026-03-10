Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F2B3BD236
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773145330; cv=none; b=d/FgLEkdGJvI1loFH+j5K9DTMbi5J+b/0uXcX86mwc5e52noE08h99g5VCFzGCkm1ezeQT/aBbaJrcAN7B6j9JNTd7eyzCSltnHaKn4PpauHOnpffsngTbgOapSuRRWrSTZAqoI5iX6SIsbQCNMXXPxuGyP9jdJjPkr8h6At99Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773145330; c=relaxed/simple;
	bh=rJCvopWp5iiDLccoYd5jWA6yqz+XgfhTotF/3HquArg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLBbuMVxfxpv8o9RfA+Z9EFoRm2KFVHkzipdykrQIIXvLJO1PSxDYFSfi3LZfblSyeb+RanemME8819Zj+hV+j5oqhlu2pbwoCgNxXwynyWbrz6MRf7exfCm9ab15yesB5XOcpzaPRGiq39TjKRAj1CsYSzu+ju0mazDUUoMhRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nh4h92EI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TMBllGQ1; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nh4h92EI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TMBllGQ1"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5EE2314001BD;
	Tue, 10 Mar 2026 08:22:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 10 Mar 2026 08:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773145328; x=1773231728; bh=RBmkbI+vZZ
	RBLumob0ydrClTmKpcw2QqDzCtRIR4JmY=; b=nh4h92EIIyV0G7iWwMeacK5gUF
	DJP5q6vkArdfWno69YyM4qN5E4vmWpjUhrAoRcpKSVGlTOyw9aVWernv8DRID1Cu
	oBmw5IOZxKvbpSQN31pSW97PEcExNmqV2r466+KHfQHY2gnEQvUy7WWxXzDQLzOB
	auHpSQWYuffhxxNPYGoivwz9gN+JgnMh+7LMxw08wDB937ijquuVWWp9HrHDiMmq
	nNT+iyLTYTpWaggSnGbmaBJgQvtZt9Qzmo4AoQmWr4eGz+kujEoZCQh+KOEYgkjq
	xA2CR/Bup8G5S1UoBPY3Z+5Epm5sxZy5VFzM+ksOpMm/8iasqJMEVv1/3PIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773145328; x=1773231728; bh=RBmkbI+vZZRBLumob0ydrClTmKpcw2QqDzC
	tRIR4JmY=; b=TMBllGQ1HokIOEryS4KS6luE3OkWKk54zlFijdmKFmSsyKcxMU2
	ao27Gyv0kI88CVOOtmmm84afd4jbA4dF2s5Lqp/LQmvQK1jSoYD/MUICWnZOyGHj
	3Q3mMT+ALuQ5Gtw2GBDruPWPyAiiLw0niEklBjKlux5Y45Ve+7bTHQcTiWIO8AKb
	OCsto5Y4gu91IWRLyprPxYbta5JIcNsaqeoxSHwaeoVuBSxse+FdkvR7cf2zZR54
	ZbRC1i+V+m6td1YU5ldIGhgJl2D9fPC2GwF0/toKCdmznVZGb/ro0A48h+feGej0
	k9194RT58MauFDRaDx966KHdw7kl776CkLw==
X-ME-Sender: <xms:8AywaWGjQBVnguu7Me3PA7gpaZ9YDwIaLHAFtqv4Nfksw0W-am5RwQ>
    <xme:8AywaeytjIyrqUAltyOMAeekOIl25eZHGgKKg8K4gRg0uXV-00LeHFlQOO-Abwruu
    Citm2TzplYKGzjaj4aANn6UEfpFkVu2EtNZbxqanrPC3NAlAsbHvw>
X-ME-Received: <xmr:8AywadgdNm74ddkXZMvo2ibym8AtanVIr8TTqLWhtIOMaUfR-oYXmDM6oBErBRVrLngEmGfj1azAvjeESS82NdxMm3mFblfd3b9Q1K34>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedutddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhdrshhiugguhhgrrhhthhdrshhhrhhi
    mhgrlhhisehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:8AywaZxIxUdhu5mQKrIvS_sp3lQBfmRTkFyIgnTO8akxk_8r5hjghg>
    <xmx:8AywaQKObXDWAVwzLASgUnRzNfzZHunWhVkstzhy14jZtFfLXSJB1g>
    <xmx:8AywaQTEpPzaHhYytvnSu6L-oSWPQFDvrTVErMMhC9W13-ibLV9IuA>
    <xmx:8AywaYoXxjNp0ZErRzn8vZi-48vG8W8yiFQDz0mBBfigIuL1bRUCOA>
    <xmx:8AywaSx3uhJY2LC7qoiBin-zlQQEHA9O2ynp9At39XMr-EF2Esr29chd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 08:22:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2b258faa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 12:22:06 +0000 (UTC)
Date: Tue, 10 Mar 2026 13:22:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] submodule--helper: replace malloc with xmalloc
Message-ID: <abAM68lOLFVwmN5Y@pks.im>
References: <20260310121013.39291-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310121013.39291-1-r.siddharth.shrimali@gmail.com>

On Tue, Mar 10, 2026 at 05:40:13PM +0530, Siddharth Shrimali wrote:
> The submodule_summary_callback() function currently uses a raw malloc()
> which could lead to NULL pointer dereference.
> 
> Standardize this by replacing malloc() with xmalloc() for error handling.
> Also, remove the unnecessary type cast and use sizeof(*temp) instead of
> struct name in xmalloc to improve maintainability of the code.
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

Yup, looks good to me, and all the other while-at-it changes are
sensible, as well. Thanks!

Patrick
