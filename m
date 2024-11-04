Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3851AB6EA
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 22:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730760320; cv=none; b=WPfywK9uGRBpiAeJ2jClffg3+B//N8M9YbKzWqJolqxGF1uTmwG0e1O6T+/Yt8QqZVPx6NI2pB7Rjye2ZiMavl/wdviBRqr+34BymSI/YPjtGSFMhDNjzJkSo1vQIsxdsroVzRaFg9OIL6ayQvKDlflEDy8LegMBxzqvmvaF0h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730760320; c=relaxed/simple;
	bh=pvAAN3bsr+05NDijJx5YNoR2HCeFixWvTY/7679aufA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAX5x05RHUlwsSOoWqiFX4qzqliYt1R+7sAE5KtsuNKyf5zdzVx5QQwGbxv72WYbN47um/aV6sNE5Ew/yHWzc7knY1xTZjZSC89nGAgljMd3w6Ww1FvQs6+u2/T7VvGalSWygWVS3fZjhssRzRg4lCZYVP3J50zHI5OUWyk0txw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJfTNJ61; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJfTNJ61"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71815313303so2354584a34.1
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 14:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730760318; x=1731365118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fiqgYfbAYo4qPbtXZyjepmxzpWHtVoipQzi7/L+FJb4=;
        b=VJfTNJ61XmQCfYb0fnJ2hQgyanjcp0/mKu4sBzyd9/WG5YHY7BM6kx0Wc1uB+1QMgV
         0sQtCSsELon/epY8ZrugJdJW0w1H9LiUppmeKZeLHHAC8kDbKCi3ax/KKqJpUBitMbqF
         jh90zf4C6mWCbzNjGCilIMvA9DtBHXe5Weu5MdNM1pdyypL8wwdmGgyn5B0hmLC+0Qh3
         wvsq3Qs60hoF/5E0AOPnkGDYX3Ne2MyhvOj15GhPdO/qAYsOK6/+XVQakHx/VgCjqYa2
         pD0kqog5l2BfC5B5KeGPtepzUiLQuJFU2uoY2UM1sy0GW9DW70CYfxbu9i4MgWFXdeXd
         DACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730760318; x=1731365118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiqgYfbAYo4qPbtXZyjepmxzpWHtVoipQzi7/L+FJb4=;
        b=HSh3i5oHoWqv2xe03Rp1djbUWYAfW5Xv4a1yf76e3eSVIdFSoN3TObmmDU76DPPGHB
         DBVm8t9Tw8WvWL1rwFU5pWdqmaO0RjsJXyBF6InzpbhPidOCU5Xun+dNDkwDG2TqArV4
         IGyY8PfebUGK5Nez1DRKGnPgJkNrj+B2JrnuI2z/PfpZ9+eaHWtANtXOlwA3RcXzoDjY
         NpyDjWNAFi7wtSuWt61Ujkrc+2aUL41ryO89GTshC9iWaz+xGzGE+TxtikXiqG4iyTRM
         T4j223X2TC8jdTzKFxPbZkMDyVMCUIc7o+Xo1G72olFNdMeVdpNrR4GeIY7xZNkrB6m/
         MetQ==
X-Gm-Message-State: AOJu0Ywg5INqbmRYvhfDQ2q+spqc1vY8AZrX3IPZ1COuXotew42KlrEk
	V1pCAVewV9bxN8QSb+KulYLr+a91Xb0il6SaeB5brsZoTmItcOCuF4ZfkqKk
X-Google-Smtp-Source: AGHT+IFJvcAkAX6+ZNEEcVrDLTrDprBUpn/2zv+pR+9X5uzMUyOe7er2q8H5s3y9hgCcDZzyMb5Z1g==
X-Received: by 2002:a05:6830:3489:b0:718:c7f:5cbd with SMTP id 46e09a7af769-71868295b3cmr32501358a34.28.1730760318226;
        Mon, 04 Nov 2024 14:45:18 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cc7e489sm2194195a34.33.2024.11.04.14.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 14:45:17 -0800 (PST)
Date: Mon, 4 Nov 2024 16:43:38 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 15/22] combine-diff: fix leaking lost lines
Message-ID: <rbjmoxqrfpcpz2b5oqxcchuwpbvw4uz4ps4j7ctkd4ux5h4xwj@n4mngoog4ffd>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
 <76bbcb3fe301fe273578a71849f99953ea94695c.1729502824.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76bbcb3fe301fe273578a71849f99953ea94695c.1729502824.git.ps@pks.im>

On 24/10/21 11:28AM, Patrick Steinhardt wrote:
> The `cnt` variable tracks the number of lines in a patch diff. It can
> happen though that there are no newlines, in which case we'd still end
> up allocating our array of `sline`s. In fact, we always allocate it with
> `cnt + 2` entries. But when we loop through the array to clear it at the
> end of this function we only loop until `lno < cnt`, and thus we may not
> end up releasing whatever the two extra `sline`s contain.
> 
> Plug this memory leak.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  combine-diff.c           | 2 +-
>  t/t4038-diff-combined.sh | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/combine-diff.c b/combine-diff.c
> index f6b624dc288..3c6d9507fec 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -1220,7 +1220,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
>  	}
>  	free(result);
>  
> -	for (lno = 0; lno < cnt; lno++) {
> +	for (lno = 0; lno < cnt + 2; lno++) {

From looking only at the code, its not very obvious to me where the "+2"
comes from. Not really worth a reroll, but it might be nice to leave a
note with some context.

>  		if (sline[lno].lost) {
>  			struct lline *ll = sline[lno].lost;
>  			while (ll) {
> diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
> index 2ce26e585c9..00190802d83 100755
> --- a/t/t4038-diff-combined.sh
> +++ b/t/t4038-diff-combined.sh
> @@ -5,6 +5,7 @@ test_description='combined diff'
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
> +TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-diff.sh
>  
> -- 
> 2.47.0.72.gef8ce8f3d4.dirty
> 
> 
