Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9331AC451
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726074972; cv=none; b=t4ZZOFVfKe3RW1KY2lCryGwPyQpupTNABTMRZuiWbImCwt/043hDNFzb5joj2eKg2ZvKwK4zZJAOCLhk5rskR8obq0O/T+8ZK0zlgaXMSJYkL6zzHZqmm2A0tVVVOMfdD9tYvTL2NWedA1Dyk1yh5oaD11cG5PAo9P9yIt+lUOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726074972; c=relaxed/simple;
	bh=x8yEVGAgNeUj9bwtB8Yn49gHfEigXCHGtZk7LsI0Kzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajcxT/2qCV6Eo9h3UazhwnH4cgUjQgHzHBsr9ElX2z4FoTTOAiZur3fy44khSEfNCo4ugcCb/9L7w51ljFrZ4/UsqWg0+065vFZzTBD6S16At1i7qxcivA4u0UNTvahTbPHwfRue4Su7UvtQk+0ues27ZT/FG3wa0c83DthbzWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hg0z1Wzt; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hg0z1Wzt"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-277dd761926so5974fac.2
        for <git@vger.kernel.org>; Wed, 11 Sep 2024 10:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726074970; x=1726679770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uGKN1TK2Wq2aah7Gf+aakrhAv4Ja3bCURgMWgY/uxeo=;
        b=hg0z1WztEAkmsfONEs4hX5aeQ7RXfoggdKsySLEkaQx7WekvMspBtx3yxy9jqBuRXS
         ebmd3cEl1wM3hkc8pFMJSDojPvT3t7G0O3OKHoGAHdwRXDzozLDxUzShJwvOhDSDj/4E
         YAEzMrFoOl6RsW3pDUor+lzvFv2ILf1CoByRoo19/fqRxHf4/MtWQ7a38Q1N514Yg9WL
         fmHvrrbqe41glzWxgy99bzcIO4tK6WOHA+K6xHvLA0qo+FZmVBm+o9wDenkoLlZqHkux
         NDTTf8QZhV5nIMD0yhhi7TVbhnfgQXCX5E3ShpmXDWtIuQ7lhql77InNjh3Y3eNbvcUQ
         tDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726074970; x=1726679770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGKN1TK2Wq2aah7Gf+aakrhAv4Ja3bCURgMWgY/uxeo=;
        b=s/wOTn7Qec/dPymMksQryrOxlSu614L/Y3yX9uDSUXP9/GGN3HPKil4JfCfNpqdOdQ
         G4P5RSB8TUAOqaLZf6n+nUrOYkkOt1s+hD28TFyL+g9f4rOS+ybfS8A6xWJ3LGOCtOPQ
         L2nqnzuUTwgw+57oT/qAhFhDzoAqSsgR0jLqcD8ZLCW4DKHpey8BVvHIUKrWx5fFxYsq
         mfny86Z8nyFacKshIG2l9NltTxW2/1prm1X93KIhBEyEnfAIq9nUJaJb4E4bAXqd6HQI
         wYRUJphAWPbchq0LCYxQ0Ly7Lsga5zGYjTYrNqbaw05AZaSgAJ/JkCEtlagPOND+JmAW
         BL0g==
X-Gm-Message-State: AOJu0YyYjmvOdl4kT/TOtuylRL5C9loscvyEol2VVTUiBTL11RGwHez5
	7F4uD8XP2U4OL8BOhxjqkReN6TyhPtYaak9PSaHC5JXuO/f3hbhm
X-Google-Smtp-Source: AGHT+IGkjLgRFD3F5oNwGQi1sc9/oF8yJ7D05FcFYWrv1h35Nma2VZdZQR9UcUlNCbDFsUBT01t5ng==
X-Received: by 2002:a05:6870:20d:b0:270:130f:cee8 with SMTP id 586e51a60fabf-27b82dcafdamr18146368fac.6.1726074970202;
        Wed, 11 Sep 2024 10:16:10 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-710d9d6fb1bsm2452524a34.48.2024.09.11.10.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 10:16:09 -0700 (PDT)
Date: Wed, 11 Sep 2024 12:14:55 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Calvin Wan <calvinwan@google.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 16/21] branch: stop modifying `log_all_ref_updates`
 variable
Message-ID: <6hoykgw3gm5hchmtfaci6gwwha6iouidtqvupx55vsjfoedquo@nfgaumnmu4po>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
 <fc30365e1f13d47eb89339603f6a4744525b3967.1725008898.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc30365e1f13d47eb89339603f6a4744525b3967.1725008898.git.ps@pks.im>

On 24/08/30 11:09AM, Patrick Steinhardt wrote:
> In "branch.c" we modify the global `log_all_ref_updates` variable to
> force creation of a reflog entry. Modifying global state like this is
> discouraged, as it may have all kinds of consequences in other places of
> our codebase.
> 
> Stop modifying the variable and pass the `REF_FORCE_CREATE_REFLOG` flag,
> which has the same effect.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  branch.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/branch.c b/branch.c
> index c887ea21514..08fa4094d2b 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -601,6 +601,7 @@ void create_branch(struct repository *r,
>  	int forcing = 0;
>  	struct ref_transaction *transaction;
>  	struct strbuf err = STRBUF_INIT;
> +	int flags = 0;
>  	char *msg;
>  
>  	if (track == BRANCH_TRACK_OVERRIDE)
> @@ -619,7 +620,7 @@ void create_branch(struct repository *r,
>  		goto cleanup;
>  
>  	if (reflog)
> -		log_all_ref_updates = LOG_REFS_NORMAL;
> +		flags |= REF_FORCE_CREATE_REFLOG;

I'm trying to understand how setting the `REF_FORCE_CREATE_REFLOG` flag
is ultimately equivalent to setting `log_all_ref_updates =
LOG_REFS_NORMAL`.

From my understanding, when `log_all_ref_updates` is set to
`LOG_REFS_NORMAL`, this is the equivalent to
`core.logAllRefUpdates=true`. This means if a missing reflog file is
created for a subset of references[1]. The `REF_FORCE_CREATE_REFLOG`
flag seems more analogous to `always` value for `core.logAllRefUpdates`
and would create reflogs for all references. Is this not the case? Or
does it not really matter?

[1] https://git-scm.com/docs/git-config#Documentation/git-config.txt-corelogAllRefUpdates

>  
>  	if (forcing)
>  		msg = xstrfmt("branch: Reset to %s", start_name);
> @@ -630,7 +631,7 @@ void create_branch(struct repository *r,
>  	if (!transaction ||
>  		ref_transaction_update(transaction, ref.buf,
>  					&oid, forcing ? NULL : null_oid(),
> -					NULL, NULL, 0, msg, &err) ||
> +					NULL, NULL, flags, msg, &err) ||
>  		ref_transaction_commit(transaction, &err))
>  		die("%s", err.buf);
>  	ref_transaction_free(transaction);
> -- 
> 2.46.0.421.g159f2d50e7.dirty
> 
