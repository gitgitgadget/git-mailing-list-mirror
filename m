Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846A130F7F1
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764170182; cv=none; b=B0uwpKswhIWdf0o0HIa7bNwaB2xvdhMu0qPAgbGU04IltDinjupkBElV6IC89mlXOvBPNi0BfFo8Au2YlANpKX9+Q0FvCUvLE+PPHbOMJfoT73ftytm8oPRcWuZulPwZ5u+khKKkfDJAP1wlN7M7eWqZDwxbZ99cxOuC/gKZgPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764170182; c=relaxed/simple;
	bh=SbLqY/lzlxiT0q1+5/ejmgRj4qbVmxpUDs1RQvkXNZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r+7CHX74MCq1ACCS3pzXPDYnRf6GJ1328bslLfKMgIMVPw/JgEOYoA7ldiKISXcw9UsiYRlgSEMaVS/5baENIeRt6N3RlINpBFqFTr8hrCYorrX2RGhxFZ0f4SF7T0CIKd1STswreaxgy6Judli0kRNMO/z/8D0lXVjQ5b2/Nm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WmW/Hoim; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EF26rGKU; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WmW/Hoim";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EF26rGKU"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 48AD914002B6;
	Wed, 26 Nov 2025 10:16:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 26 Nov 2025 10:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764170178; x=1764256578; bh=LSNbjLpGgf
	8Gysj+w/nwUgil/5wzwQv+AffPT4RtRVk=; b=WmW/Hoim1IEdCcM7kKIJKYH+9a
	wXcCBmgShIns7sC47W/7+EkOx6eI5gMZzh94aw0cnboVNWqmoVx4rwTrrcVJl3gw
	Oy9hHtcVtbZpKZrx62/p7g7BInw+Ri6SrBZ/jm+c6QYSja/MCUQwJmgIUIQG2ZBs
	4l/coXJGPmX0LWR3uqae5qRYIdxTDxffA9vr1v6lNf8NBj8m5vcNzlARANT2WWHF
	+tv6sw4BeRrTuAqB/gmEQJ4VBGVYBMAv3wVq+FCbnwPlf72JRyHYqGzlkpxnpYLu
	9ouCLUO64WHCr/rMTwNn3/5wo+mvN3UlPahyNifnlXl6VCBuvg9vsBpdO+Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764170178; x=1764256578; bh=LSNbjLpGgf8Gysj+w/nwUgil/5wzwQv+Aff
	PT4RtRVk=; b=EF26rGKUMgPDD7Cw4DDKdeUaRkk4J7iwSC5jgDwkz4Xc5IdHI2W
	DQDHLPPIPD7ztr4IPny1FADfqbxOLozJyqMMuMi/avlvoil10bRPgA4IVO6WxQk/
	gcD4ypYu6Ot36wwfOlqtJwnjialXf7wWi90VTuksPJQu5f9PE3z09n3b1OjnOkul
	xUAJTbP3KYZia2mfIivirPj6hz8RPwY3I5nvDr7fIwiEoUpqibLHXsW/zJ6n8tMA
	af1EUvC3J32f1dCHPVmDbcxnej+L5gl/WbkNXmkmm47TwMLffnTSTRvvZgL9mF4A
	CpIuaB3pY9rEqy1O0Tnr+dUlILusZjElvXA==
X-ME-Sender: <xms:wRknac7c8RSfMPkbaGeyCHFw0U0xMviqT_ZABp7PY0XwKjVcXF-PlQ>
    <xme:wRknaRlZtWAageZEEFvAfOLPx8gb5UR3Ass4MUFKOn_ZZCl1lJno054510s3Wjztn
    9nUepFCitrKAlcHCchI0J2dPQBKinc2V3SwwZIJS_94SdNZd5T-Nw>
X-ME-Received: <xmr:wRknaVTAEjURzEn5hx-Vornpt82ZiUgwfQCMw-2kBYwzPM758x4w-SQkuNkdYCHxfr2Y4qxI07bzfgJbeoPy6OR4BtNshgP0rlT7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeegieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttg
    hlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wRknaYHLJHvTDboqnOG97_PFwaONoRNN-5TNOXRkdmk2hpfB8cVnbA>
    <xmx:wRknaSFb4lwq8AHiiBOBAUx38_To2wkliRzOilEmP_rWKdd2z8nhIQ>
    <xmx:wRknaeSR3BnK6V91ZZXBCC2YXp2o9y5yvXjucmjH_WdZSn8IctrhAw>
    <xmx:wRknabJsNXLer2CZhuXTN0_ijEPFK1e-IIz3cHeN5ByW2jzMhPC8dA>
    <xmx:whknafCJSVpzGAi8gopiJEX3Pc0IZufZN6jGk-u9xhBVeMdkFhLKZ_qf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 10:16:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  toon@iotcl.com,
  sunshine@sunshineco.com
Subject: Re: [PATCH v2 1/2] refs: support obtaining ref_store for given dir
In-Reply-To: <20251126-kn-alternate-ref-dir-v2-1-8b9f6f18f635@gmail.com>
	(Karthik Nayak's message of "Wed, 26 Nov 2025 12:12:00 +0100")
References: <20251126-kn-alternate-ref-dir-v2-0-8b9f6f18f635@gmail.com>
	<20251126-kn-alternate-ref-dir-v2-1-8b9f6f18f635@gmail.com>
Date: Wed, 26 Nov 2025 07:16:15 -0800
Message-ID: <xmqqfra0q0xs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The refs subsystem uses the `get_main_ref_store()` to obtain the main
> ref_store for a given repository. In the upcoming patches we also want
> to create a ref_store for any given reference directory, which may exist
> in arbitrary paths. For the files backend and the reftable backend, the
> reference directory is generally the $GIT_DIR.
>
> To support such behavior, extract out the core logic for creating out
> the ref_store from `get_main_ref_store()` into a new function
> `get_ref_store_for_dir()` which can provide the ref_store for a
> given (repository, directory, reference format) combination.

I am guessing that this is meant to work with the REF_URI thing, and
the <path> part in REF_URI=<backend>:<path> corresponds to the "dir"
parameter here.

Looks like a good no-op split.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 965381367e..23f46867f2 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2177,6 +2177,15 @@ void ref_store_release(struct ref_store *ref_store)
>  	free(ref_store->gitdir);
>  }
>  
> +static struct ref_store *get_ref_store_for_dir(struct repository *r,
> +					       char *dir,
> +					       enum ref_storage_format format)
> +{
> +	struct ref_store *ref_store = ref_store_init(r, format, dir,
> +						     REF_STORE_ALL_CAPS);
> +	return maybe_debug_wrap_ref_store(dir, ref_store);
> +}
> +
>  struct ref_store *get_main_ref_store(struct repository *r)
>  {
>  	if (r->refs_private)
> @@ -2185,9 +2194,7 @@ struct ref_store *get_main_ref_store(struct repository *r)
>  	if (!r->gitdir)
>  		BUG("attempting to get main_ref_store outside of repository");
>  
> -	r->refs_private = ref_store_init(r, r->ref_storage_format,
> -					 r->gitdir, REF_STORE_ALL_CAPS);
> -	r->refs_private = maybe_debug_wrap_ref_store(r->gitdir, r->refs_private);
> +	r->refs_private = get_ref_store_for_dir(r, r->gitdir, r->ref_storage_format);
>  	return r->refs_private;
>  }
