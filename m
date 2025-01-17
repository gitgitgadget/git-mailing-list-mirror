Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3CB1F76D6
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737106168; cv=none; b=F/sNHci4/roO3BWXD/oOdoKkpJ/otMiohNxg/r4KQxEWKfa61NhAIf4R/+q9iEfQKU4mJwana/FL0CbCwW/4FX2D7+snsjOJRJbYvRrya2rulsSDQxFOp9ArM3gHtSBMjy4jh1GdYOUrWs9Kzn1vWMMtKewLptyya56lFbZjrl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737106168; c=relaxed/simple;
	bh=16vUK6GnE4qg0d3DA8TLPTAdVMa1GALfyFNdCRR1big=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhKiT+Bwc+HDmZqTZf2F6mYaHeixWC2dP/zty+QuRIDQKTT9hygLHptR769UdBNvmAGnj3ZJCeaPXq8j7nI6KHDw6JRdoBdCOlEyom+o6T9HlgvsBqv0ESsCOkaoRbSfyGYoqMXY/++fkhC0O/bCN3YHHZxpM7dtXYLT4ZiX4rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PCjfqJYV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ByGU5GVE; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PCjfqJYV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ByGU5GVE"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7258B138026A;
	Fri, 17 Jan 2025 04:29:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 17 Jan 2025 04:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737106165; x=1737192565; bh=cGT3JvIzO7
	1ffUj+kkGnscofHHtnSzYM4JhGWHPQS5Q=; b=PCjfqJYV83K2uasWVexI2tIoSL
	YquxbOVE2V/1b8mNjkcywTMHWTb+D2B7s7C8g+0/F42CP+EwJQfdjMptgUiFSoBi
	MnpjZ9QU/xYKZ7W6RmfnWFndyXxmxkwa18sqOtGtZ2QQxOaiqY/4sIdmN/XICjts
	voV/rnxwgGKWSpGuRuH8V2Edd8LFgrDmKyen5PyfkZvkLGmfW2TmKSBa+jLcgZGE
	YsgXPZBqVOVmPMVrB/3h8G6hDb3qe/1nrgvzeyRqXFbSB/nb/UEwdiA52V9nDEbr
	4+Po8nFcZZQnukD0wTLCcROBn+e+2A6iA6rBGrutIpkeMddcUeYQQ32JxsZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737106165; x=1737192565; bh=cGT3JvIzO71ffUj+kkGnscofHHtnSzYM4Jh
	GWHPQS5Q=; b=ByGU5GVEw2AIqwzz4G8sBvC+YMxGnxX6OY3RcGDGlpc5epKEDH/
	cFUYZ93o3kl3yffTiV3lpIkRMpmMFqIoKZ1j2j+bSdysWH6/F1GENk0p8Zc+aHZL
	76V0ECIXpMYJOJs29bzlR6pPfDsmHHIWZJg+waKv9y6JbZv8U/p7YrI1PnvhSmiw
	1/kFM6fqLXoCLZXuAj3VJXBLL20qiOSysF1pVgNgtnKS/SOdcqSuXn0wz6zbTw3G
	8U5p5XXuGhzHjwyye7DCCIzjxnxRFjd8xKcygsW+jLilRNwK4jLsT5ntakgDwyuJ
	h4MUyl6YextosT8ZoZ2Q0WpyRJK4idbwppg==
X-ME-Sender: <xms:9SKKZ0dZ1Ebm2DMv3lQjrL0rT34Kh9TkjHkJZL6weo9bFg0uDdFSVQ>
    <xme:9SKKZ2PpCRhoDYQrwhtcyw5YpsrUVBjHhFrxnFAdwdAieS0HFL_a4FjMLN4OPWiPu
    TrMKcyqsOFJtYE0RQ>
X-ME-Received: <xmr:9SKKZ1ipixyk2eGM7xYH4L_X0_w2DPE3rvAfk6nmBTg2l_4kHP0_w5wihIBCWttDUfz_1C_5KZPi1bqBaZMHV89ziZFKT4hmV8UqDHJDKREWFcc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:9SKKZ5-Wn1Mz6MR2-L8jM1i94qtUYRz_EjT4CcAEx7mghqmndNUs7A>
    <xmx:9SKKZwvAHfULqL4A06bZIjnVV75mE_mFVAcpb5FFPPFwp4FW42GXEw>
    <xmx:9SKKZwFDPy1XNApM-_5AL6Xhl2covX6JaV_mJjXqztTOr98t3kL2AQ>
    <xmx:9SKKZ_P-qy88Yx2MZOj1U37doatXQfK4Vx4gbalTmK7fZrlVTWvYEQ>
    <xmx:9SKKZyJZlRNkz0_D6KJqBq3OO-aE4lxCJhH3ji9W60lMpn1MURONPgMU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 04:29:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id db4b075c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jan 2025 09:29:22 +0000 (UTC)
Date: Fri, 17 Jan 2025 10:29:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, gitster@pobox.com
Subject: Re: [PATCH 3/3] reftable: prevent 'update_index' changes after
 header write
Message-ID: <Z4oi55XewgX2deTm@pks.im>
References: <20250117-461-corrupted-reftable-followup-v1-0-70ee605ae3fe@gmail.com>
 <20250117-461-corrupted-reftable-followup-v1-3-70ee605ae3fe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117-461-corrupted-reftable-followup-v1-3-70ee605ae3fe@gmail.com>

On Fri, Jan 17, 2025 at 08:59:14AM +0100, Karthik Nayak wrote:
> diff --git a/reftable/writer.c b/reftable/writer.c
> index 740c98038eaf883258bef4988f78977ac7e4a75a..c602b873543790e36178f797ed9f98112671f97f 100644
> --- a/reftable/writer.c
> +++ b/reftable/writer.c
> @@ -182,6 +182,13 @@ int reftable_writer_new(struct reftable_writer **out,
>  void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
>  				uint64_t max)
>  {
> +	/*
> +	 * The limits shouldn't be modified post writing the first block, else
> +	 * it would cause a mismatch between the header and the footer.
> +	 */

Can we make this *even* stricter? I think that this is something that is
easy to do wrong, and the fact that it only triggers in some situations
of misuse may easily make tests miss this issue. So ideally, we should
assert that `set_limits()` is always called before queueing any records
to the writer. This would make us error out in all situations where the
calling order is wrong.

There are two ways I can see us doing that:

  - Detect any state written by `writer_add_record()` and error out if
    it's set when `reftable_writer_set_limits()` is called.

  - Adapt `reftable_writer_new()` so that it takes the update indices as
    input and drop `reftable_writer_set_limits()` altogether.

The latter might be preferable as you basically want to set limits in
all (most?) situations anyway.

> +	if (w->next)
> +		BUG("update index modified after writing first block");

Let's not use BUG, but rather return a `REFTABLE_API_ERROR` error. It
requires a bit more plumbing because we'll also hvae to adapt all
callers to handle errors. But on the one hand we don't want to die in
library code. And on the other hand we don't want to keep on adding more
dependencies on "git-compat-util.h".

Patrick
