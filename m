Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5495612FF93
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968175; cv=none; b=eNhOvIFIDucThZd5t7CKb1THpdrfjzVODFaprmDE492r7cqqxm4jZEjpnLuEpn7W1XQv79DV1dXWJ/9k1WHsMJmCcoTHZFukKJ1POHziWyauqsMay7J2iwqmZDDBaSRWr9EYjDcr3+9pm0GLgN8IrBArSpPVoS72UWK6TCrOEp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968175; c=relaxed/simple;
	bh=rtvBiT9WdrObr1Kak02yZ2CMs6C7NoFCNc+/1WZNg8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=temXwzAfLxi2jCg+PbP7lIJ1gxurOzgXOtWr35hEC9x96GCs6pcfjHk1YEZqcMxAAY6ttiNfRpWujs3Krik+Wa9UTRSMqgCdTIyDLEyYPC9W2Ct9s4U/NaYzl6ytcf0Yy9nVpnsIt3ilsGGIrqGQJKibgSwylIz6UbsD0GdPRz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcFo2pIW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcFo2pIW"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4129ed6f514so13291275e9.1
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 09:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708968172; x=1709572972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94W21UQhWIPxE9YIn6uJcETDPjVg65PfHnzDbxfCetI=;
        b=hcFo2pIW/wBlirDHnByBFWA857CEvnaT4+3RhVXBLgOSaF7Qx0e5h3Hirf4um2K93e
         yMR9FO0Th8MKckAaTapbfB6CyJw+dE8DlbZludXDRlASnaEKL5argRHLtyuwObBs3nOG
         nqM54oPnYKart9Uyr/w4At/5CYPaFKWpDjLQO1uiqR+hGB1gEfBaRfoDFpDr63kjRCYn
         LshlJVZuZXfiWJ8NCI6HtSibfOEujHqcwxuws/2AyTpSCixOVAy+GNpYz4vqkHAOFVYv
         tDH0/gr30/aV+YIaV9LhTdpOt3u/kJf/O5hrbZe3p59oxYqF3JL872E43aNbNFvJEJn5
         0YDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708968172; x=1709572972;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94W21UQhWIPxE9YIn6uJcETDPjVg65PfHnzDbxfCetI=;
        b=PHHIt3DX8HEaoeKCiDGYG+wo3Cpir9/KW4jMB1r+HpTOSnPF674TigUjoBmnxn6BgL
         lu4YbOxSyrBO/KpMDdUWEUveYOn4Q/2T+6u/TA0Z2Lz4DnxqTC6BIgIiYuk8Rx3nU5tc
         xirN505TNb5D+r9WLj/NsIqQh+fwg0bqFU9KB762DdtQEGkxD9hf1Ssv+KVPN4FKqycQ
         lmHkdOd1yK6zbkANXDqsu0Z+dU7ajpLQ00gKGcms9cok3INw/gHiGWCzzJxuZBYSSQ1v
         FLDU4GpS5eDuJbIb4iICx4R9/QenuaDsyBjWMEafIfc+lFGv8hpkICcjtTCDXoobSEJB
         NaTA==
X-Forwarded-Encrypted: i=1; AJvYcCWaPFyP4r8y+rrjRLCMaqLdvguEz1wCCiHpEpbZwdAnYHRUu11TSpIwy56j+5Mf/HatxkFCZTJciBwHgPPrx6GD9ftY
X-Gm-Message-State: AOJu0YwqSeqpcR5W4HkYu4GD/fj8pWBSTx1JL3jVwTYKpG9yf1hU6nS9
	g1s34Kpf2fBNpkb52Xfnxl+/TWSB2BCvNNWh53aL5rJKrpDTltLR
X-Google-Smtp-Source: AGHT+IEl6c1KgouA6XZSFRhO2Jqos7QkGsXX5nbRB2LtvpqWf17V/5IJPs8PSpfpdsmSOa3Qlpdfiw==
X-Received: by 2002:a05:600c:a04:b0:40f:c404:e2d1 with SMTP id z4-20020a05600c0a0400b0040fc404e2d1mr4875270wmp.19.1708968171398;
        Mon, 26 Feb 2024 09:22:51 -0800 (PST)
Received: from [192.168.42.68] (home.tribuavila.fr. [82.64.51.39])
        by smtp.googlemail.com with ESMTPSA id bo28-20020a056000069c00b0033b406bc689sm9221817wrb.75.2024.02.26.09.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 09:22:50 -0800 (PST)
Message-ID: <c46a0a4f-63dc-404a-8ee2-64a34f474c5f@gmail.com>
Date: Mon, 26 Feb 2024 18:22:50 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] revision: ensure MERGE_HEAD is a ref in
 prepare_show_merge
Content-Language: fr
To: Philippe Blain <levraiphilippeblain@gmail.com>, git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
 Michael Lohmann <mial.lohmann@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>, Michael Lohmann <mi.al.lohmann@gmail.com>
References: <20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-0-af1ef2d9e44d@gmail.com>
 <20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-1-af1ef2d9e44d@gmail.com>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>
In-Reply-To: <20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-1-af1ef2d9e44d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

Le 25/02/2024 à 22:56, Philippe Blain a écrit :
> From: Michael Lohmann <mi.al.lohmann@gmail.com>
> 
> This is done to
> (1) ensure MERGE_HEAD is a ref,
> (2) obtain the oid without any prefixing by refs.c:repo_dwim_ref()
> (3) error out when MERGE_HEAD is a symref.
> 
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  revision.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/revision.c b/revision.c
> index 2424c9bd67..ee26988cc6 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1973,8 +1973,12 @@ static void prepare_show_merge(struct rev_info *revs)
>  	if (repo_get_oid(the_repository, "HEAD", &oid))
>  		die("--merge without HEAD?");
>  	head = lookup_commit_or_die(&oid, "HEAD");
> -	if (repo_get_oid(the_repository, "MERGE_HEAD", &oid))
> +	if (read_ref_full("MERGE_HEAD",
> +			RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
> +			&oid, NULL))
>  		die("--merge without MERGE_HEAD?");
> +	if (is_null_oid(&oid))
> +		die(_("MERGE_HEAD is a symbolic ref?"));

Following the thread about being less passive-aggressive, maybe this
could be rephrased in an assertive mood.

By the way, this string is translatable, but not the one 2 lines above.
What is the policy around translation?

>  	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
>  	add_pending_object(revs, &head->object, "HEAD");
>  	add_pending_object(revs, &other->object, "MERGE_HEAD");
> 

Thanks.
