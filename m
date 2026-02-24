Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C1E284894
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925621; cv=none; b=nryjqJKFDRSUbPzhAf/4RqoWsY4QGgMKYA7zx6aIl13NhWTHPF4X1W1cQa7v24B2nVJ7oXwItWuqLoHOycdQfbZhXvCm1VgWlTDBqBqOx3y7AXLYSFGQozsA9GKAz8I5CLSrYq+pdK42fmgy6OAGQ9wWms4Xvbc0T132C3QlY4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925621; c=relaxed/simple;
	bh=y8o1JPmp7eozPdC4o0ZZjZ7pOZ7OCJ9DDk9x5HkOIwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iohTizCZWybC7V0ZvKIbyamAbVAOoiwVGugND513e6IaSstKrgb5+++OOH904y3k4vbQjprEqUkP772frv2uplPnFs9P8JnlXbGtFHNo0LO/A97D92emORTaX5p5gGTciOSi6ihbCmPM/Ptmwdwdubott6s3in7ILzKeBvzWxLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p6TmyeMM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XFCkKjVF; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p6TmyeMM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XFCkKjVF"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D2468EC05B1;
	Tue, 24 Feb 2026 04:33:39 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 24 Feb 2026 04:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771925619; x=1772012019; bh=rAe4qwE9eh
	xWXJYszn9l3jFWRes5CuCDyqRMcnnNVuc=; b=p6TmyeMMlto17+/VgWbMd9MOZt
	FsHK9MTflt6MacTOgcvtS5uGJfdAdYSdaQrgTpJJ7lUS0CyHRPQBkihGYFz4fu3i
	eBGV2K+VoWAKgJfE2LKJuZW7UEk/YEWwiyVZoX7/ZDDp7KKLev0Uv7x8itsbHdGU
	uFwwBO2CQlISP6p9Dyc1NUvYSGxLoUcm5SMccyKfnf4MRbBXAudNUgtW+Lly16oj
	/cFk7oiIvuP+wryWF0dr45KuielLt2w83qKvlYoD3D/Ybqxedope9lx/fPdr6pO6
	3ss7OEr3TeWc8NnQ8sFXFGXlpjjK4xDixp+LcxHKhDAZZEPjx1lUfa+oFxag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771925619; x=1772012019; bh=rAe4qwE9ehxWXJYszn9l3jFWRes5CuCDyqR
	McnnNVuc=; b=XFCkKjVF8kNwE8PAEaLaBMbatI8mEPYWvkc7lqnQQj666QzUt6g
	HEv5QCqcwHz0YKyTqnyt/GS4hKVl5lh5ILaBh8k1Vu7Cxb6itoSTw9PKKWtXjdWv
	oxWL+WkUl5bMlmgH9xVEVJc3SvF8k5jFgHB1a6wVSHH6Q0GWcTnZxUs8Um4baS5t
	HN5iNcmXQ1vTAgu4ozYP83nocMbxOjtjADk8ZdCQoobUQdKzw+xsOQkxCIzI5U1/
	IhObQhupt7yDNQb2HTXvxqySjNcvM/4I5gXclnCfLY+uT6gblEKUBjRiPr1yfu0C
	BsFVDC3Y2tlg3ITBI95oL4TRDPi5KG9u8FA==
X-ME-Sender: <xms:c3Cdaea8xKzOZZv9dNzrIztLxmAzcHCJFK72_BTRfw1JZs_TgPcVvA>
    <xme:c3CdaYbSsUxyGZTDwHzDRHiqBNm8eXxPpUvdMtUTfOAd2nKDHwqb4FtyhRJVHaAFJ
    S80Bj5buaRDU_zFUxFiF1MP-5fv43quiflT8mwZ9Clm7Zv9zGpJFA>
X-ME-Received: <xmr:c3Cdad8UTSA9yT2SD0fyb4g-PCUsLRTFXgFbgem7XTqGA61N_pR9R1t7SWQKGizPVieTA_qiStcEBoBKmoifJTd4ctFnsyTfrnGU3ujejpFigw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeelkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtoh
    hothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:c3CdafhKRnqOnN751d7_Uy4t40FHvVWov2mR8FGrYXlY8syYjx5PNQ>
    <xmx:c3CdaVfxKRFIYIVqtF-9ZD2QciDoRjmLl7SBe_J9WQrhq57aRMFnaw>
    <xmx:c3Cdaeo5ejrerpg_KmZxcv6XETT7kSW8Z0Nfj2nrbBY28K-rZUvS4g>
    <xmx:c3CdaSD4tY2M9V-U1hBpLKlaVPe2m95y92e7Xm7NaSFhkHK7QAoetQ>
    <xmx:c3Cdaf6yx-2lAYHqi3HF39daeA7pRpXxkhUsZd5zQVHq4C0MIEZKU9Cn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 04:33:38 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b5dda271 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Feb 2026 09:33:36 +0000 (UTC)
Date: Tue, 24 Feb 2026 10:33:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net,
	christian.couder@gmail.com
Subject: Re: [PATCH 2/2] fast-import: add mode to re-sign invalid commit
 signatures
Message-ID: <aZ1wblYGQssyNYsk@pks.im>
References: <20260223194146.3476768-1-jltobler@gmail.com>
 <20260223194146.3476768-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223194146.3476768-3-jltobler@gmail.com>

On Mon, Feb 23, 2026 at 01:41:46PM -0600, Justin Tobler wrote:
> With git-fast-import(1), handling of signed commits is controlled via
> the `--signed-commits=<mode>` option. When an invalid signature is
> encountered, a user may want the option to re-sign the commit as opposed
> to just stripping the signature. To faciliate this, introduce a
> "re-sign-if-invalid" mode for the `--signed-commits` option.
> 
> Note that commits are re-signed using only the repository object format
> hash algorithm. If a commit has an additional signature due to the
> `compatObjectFormat` repository extension being set, the other signature
> is stripped.

This part here might use some explanation why this part is not done so
that a future reader that ends up here doesn't have to wonder whether
this is done with intent, or whether this was done because it was hard
to do.

> diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
> index 479c4081da..b902a6e2b0 100644
> --- a/Documentation/git-fast-import.adoc
> +++ b/Documentation/git-fast-import.adoc
> @@ -86,6 +86,9 @@ already trusted to run their own code.
>  * `strip-if-invalid` will check signatures and, if they are invalid,
>    will strip them and display a warning. The validation is performed
>    in the same way as linkgit:git-verify-commit[1] does it.
> +* `re-sign-if-invalid` is the same as `strip-if-invalid`, but additionally the
> +  commits with invalid signatures are signed again, so that old invalid
> +  signatures are replaced with new valid ones.

Okay. It's a bit curious to say it's the "same as `strip-if-invalid`",
but I get what you mean by this, and I think a user would, too.

> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index b8a7757cfd..e34a373d2f 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -2836,10 +2836,11 @@ static void finalize_commit_buffer(struct strbuf *new_data,
>  	strbuf_addbuf(new_data, msg);
>  }
>  
> -static void handle_strip_if_invalid(struct strbuf *new_data,
> -				    struct signature_data *sig_sha1,
> -				    struct signature_data *sig_sha256,
> -				    struct strbuf *msg)
> +static void handle_invalid_signature(struct strbuf *new_data,
> +				     struct signature_data *sig_sha1,
> +				     struct signature_data *sig_sha256,
> +				     struct strbuf *msg,
> +				     enum sign_mode mode)
>  {
>  	struct strbuf tmp_buf = STRBUF_INIT;
>  	struct signature_check signature_check = { 0 };

Should we maybe call this `handle_signature_if_invalid()`? Otherwise it
sounds as if we already know the signature was invalid.

> @@ -2866,6 +2867,30 @@ static void handle_strip_if_invalid(struct strbuf *new_data,
>  			warning(_("stripping invalid signature for commit\n"
>  				  "  allegedly by %s"), signer);

I wonder: does it still make sense to warn about those stripped
signatures in case we re-sign anyway?

> +		if (mode == SIGN_RESIGN_IF_INVALID) {
> +			struct strbuf signature = STRBUF_INIT;
> +			struct strbuf payload = STRBUF_INIT;
> +			char *key = get_signing_key();
> +
> +			/*
> +			 * Commits are resigned using the repository object

Poor commits. Maybe s/resigned/re-signed/?

> +			 * format hash algorithm only. Consequently if
> +			 * extensions.compatObjectFormat is set, the
> +			 * compatability hash is not currently used to
> +			 * additionally sign the commit. If the commit payload
> +			 * were reconstructed in the compatability format, it
> +			 * would be possible to generate the other signature
> +			 * accordingly though.
> +			 */

Same as in the commit message, we should document whether this is done
intentionally, or whether it may require more work going forward. If the
latter, it might make sense to add a NEEDSWORK comment.

I think meanwhile though it's okay that we don't handle compatibility
hashes yet.

> diff --git a/gpg-interface.c b/gpg-interface.c
> index 87fb6605fb..e7eb42d9d6 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -1156,6 +1156,8 @@ int parse_sign_mode(const char *arg, enum sign_mode *mode)
>  		*mode = SIGN_STRIP;
>  	else if (!strcmp(arg, "strip-if-invalid"))
>  		*mode = SIGN_STRIP_IF_INVALID;
> +	else if (!strcmp(arg, "re-sign-if-invalid"))
> +		*mode = SIGN_RESIGN_IF_INVALID;
>  	else
>  		return -1;
>  	return 0;

One thing I wonder here is which signing key is actually in use, and how
the user would specify it. In git-commit(1) you can for example pass
"--gpg-sign=<key-id>" to specify the key. Do we want to allow the same
here, where you can pass "--signed-commits=re-sign-if-invalid[=<gpg-key>]"?

Thanks!

Patrick
