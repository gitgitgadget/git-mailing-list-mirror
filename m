Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F2E1862
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768333104; cv=none; b=jBAhJ7ZVcLIBG+GfNsjpgLTr5dC8DGLPdXhkFR9LEEwBeZ3SPbUYqJCCCK5U7IjjfeR4Ovt/c5z3svbs0+wX2/sVY162Hv1uVFzepEWoTyaHNCdFJy1agLqbkMBsg0sp56LvtToHvI36rMmAKeNLiI6E1fA19IeYIbNj45fZmbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768333104; c=relaxed/simple;
	bh=yEAv1pMnNwTqaFg7zsFPR1WndTeQI7ojMw5uv8fvwdU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I6CKYFP+C2wE+DFNVIZ7Al7ocn0i5rt18rwbM0APZTYpf8S3pjcMRcJlsq8z1AdaGjVmylRo1zHi34PxgWvkLcXT0UfQoJKk3J1IsLq+buWuUQdWDoQ4Vz2oknq3RNMJjqO6rYdWz1OsTvjyRjlnCzZYfmizQbLfBZ+M4UWXowI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PTp+zhus; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u6Fj9Kss; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PTp+zhus";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u6Fj9Kss"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E6CCA140014A;
	Tue, 13 Jan 2026 14:38:21 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 13 Jan 2026 14:38:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768333101; x=1768419501; bh=Vw0cLz15ZF
	x3YrmLP+FazqGnleFHNbE6tm2flYF4onQ=; b=PTp+zhusgrcBsRuxQKd9oeTqqD
	yhvv5Hu37p7jzM8ETXRrqIBKiqghd7Q0V2MCLWSftneKPEunqqTcju9bAm/VDMqs
	rG3e/DszrR9h85dZACTl2uMvggQ17lE+fyBL0x6dU7E07aW3XqOHCBuRQnqZK5tl
	lCk1xZHxn0Eut6bbAstu5m92ZlJxFIPzmosNCPkfqpIE+b5hci2Rv+XYxGfZ1S6M
	KTZyFF2xDI/pJ4qWrKQoiihtuPCtAt89CCYWt6RAgxmxidMqW7DuFBpecUf0aZ+Z
	eJgC/pg9x5nmFiUFA6yR/9Bbkkw7/2Jgv1R6W75Px01vN3kHKsDrommzbBeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768333101; x=1768419501; bh=Vw0cLz15ZFx3YrmLP+FazqGnleFHNbE6tm2
	flYF4onQ=; b=u6Fj9Kss25wfGL4sRkAjb431FNJ6Qy0gB45VyywKBKnApbsrma2
	hlxj9L9PWGDMsXcqKeNKJGtzC6brIFr4fNWNaMGgYgjeAmPo/MorVK5Gonp/npMH
	y0WRrGxOipH2QttcqTLYkByFP55a77CXEeEpcI2M3rEv3zBzl5oygf6on+dq0u9x
	f0VyKN1UMpMDVNAp33DgeE5xEh5XZBrsJslMKmxbwHDOd7unLTCJA5LbkdmqXCVq
	p8J75nS9bXZTmFGHPBXi6vgmjoP8ap26oAEYoMSS5pDC4Yp4b9XjOqdA2PS+/3Dg
	oAiQF7av9gOIpIziaag2lNMt+lNfaX1GOaQ==
X-ME-Sender: <xms:LZ9mae4kFKI0EoNlNwFoDC2t5BpHx6Za7cX2iUuAasnrXp0RdnFcTw>
    <xme:LZ9maadt3b2O_AJadUD8auHJsSJvyJi6LHTYwKz0JxLFXyNzEWbcka_-Hdi0LbJP8
    9Peatyp55BADpNGTV6G1eT5Y3YMXQFIPnD4BVmQthCA6OKqTsFJ>
X-ME-Received: <xmr:LZ9maRGP3TbINoGePVCxgPH9c89P0RnUykXl7vOW9bQaC6JS_IWfyB7WsHwynQIwzWu1BGjOS-g63kcEYFii_qVz2BpOuMmJM9BlUGs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdduudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghlkhhi
    ugelkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdr
    tghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtg
    homhdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtgho
    mhdprhgtphhtthhopehkrggrrhhtihgtrdhsihhvrghrrggrmhesghhmrghilhdrtghomh
    dprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:LZ9mabTlFxpcDUqfzooGbaOqaunc35pv5OhmkuhCWQRBl4bjQ739XA>
    <xmx:LZ9maXa1_O9Bjc2P5aozFnIcGb_ZaFvZeO9ZJmvNxkp9REYE_Nt69g>
    <xmx:LZ9maW39Cujz5CvL25M-IhotrK1tiRQ8f6O6B4MxCMakmpVQsjOPaA>
    <xmx:LZ9maarR4JsuauLsXMpMaM8Upt_ffHDeV4JBImOTfMNQFYcLj87GeA>
    <xmx:LZ9mae7g0BsEwLOaPlzAyCdVyzqOsAv1ZUbFVvxTLVeRGViwETrTX0hm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 14:38:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  christian.couder@gmail.com,  usmanakinyemi202@gmail.com,
  kaartic.sivaraam@gmail.com,  me@ttaylorr.com,  karthik.188@gmail.com
Subject: Re: [Outreachy PATCH v2 2/3] environment: environment: stop using
 core.sparseCheckout globally
In-Reply-To: <1e83c077f274d73aebe183ae61157593f4a358c2.1768318762.git.belkid98@gmail.com>
	(Olamide Caleb Bello's message of "Tue, 13 Jan 2026 17:44:01 +0100")
References: <cover.1768318762.git.belkid98@gmail.com>
	<1e83c077f274d73aebe183ae61157593f4a358c2.1768318762.git.belkid98@gmail.com>
Date: Tue, 13 Jan 2026 11:38:20 -0800
Message-ID: <xmqqsec9i9qr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Olamide Caleb Bello <belkid98@gmail.com> writes:

> diff --git a/builtin/backfill.c b/builtin/backfill.c
> index e80fc1b694..90d5312240 100644
> --- a/builtin/backfill.c
> +++ b/builtin/backfill.c
> @@ -1,4 +1,3 @@
> -/* We need this macro to access core_apply_sparse_checkout */

Why this removal?  You'll need to be able to access the_repository
because ...

>  #define USE_THE_REPOSITORY_VARIABLE
>  
>  #include "builtin.h"
> @@ -139,7 +138,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
>  	repo_config(repo, git_default_config, NULL);
>  
>  	if (ctx.sparse < 0)
> -		ctx.sparse = core_apply_sparse_checkout;
> +		ctx.sparse = repo->config_values.sparse_checkout;
>  
>  	result = do_backfill(&ctx);
>  	backfill_context_clear(&ctx);
> diff --git a/builtin/clone.c b/builtin/clone.c
> index b19b302b06..b6b19e83d1 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -623,7 +623,7 @@ static int git_sparse_checkout_init(const char *repo)
>  	 * We must apply the setting in the current process
>  	 * for the later checkout to use the sparse-checkout file.
>  	 */
> -	core_apply_sparse_checkout = 1;
> +	the_repository->config_values.sparse_checkout = 1;

... you'd need to access this, even if it is now called slightly
differently, no?
