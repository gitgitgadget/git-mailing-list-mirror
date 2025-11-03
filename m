Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1E72FDC25
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180360; cv=none; b=ryqn0hIoI/cq8sbyDpz6hCEaeqpo3jygVLrRpUu/P05ArjxvJXge50HDXgbinRNENDRc9CrXPh2VyV8oClQFTPWGzy0eXG0bylKYcfT5tUDur5IXv2+0XoknOSUI+WG4Uho877vez+G0Xa9/pUWBC4fIk6mWxV8epUJis8M6ZAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180360; c=relaxed/simple;
	bh=ETMocegAbyoyZg4k3ju9AxLnCB9lfhlW8SZtUqJqdX0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hm8qU3O7w9FMEMLz/9IhQ1Qh3/SWMW/Z61U8NPV0qsKqZfu4eHcFHOU91fYH8lrkratkGLS2/osTx83zNkiOCaqe7yGWmbMxdlED5LqM7JiYLUE5Lx38NjImyTvKa4yRksS4V2Y8SjpLVaVqa6Aa5BmmCDGhi92+9yL20NpmO1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Loma5nsw; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Loma5nsw"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429c7e0282dso1847109f8f.2
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 06:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762180357; x=1762785157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cFOPiT9cWcA8H/Hh7/9YpC4GP+QpR0Uu8vly5MVNLZQ=;
        b=Loma5nswTh58UW5/pMsJ/r7bJAqSVHShI2m9NQSzTuJYCDXMsQqp7V3ZxdDimeE4u0
         l+QsP0dAkQ9HEF1Je1BhGZSYIM1ruBt/QZSqntOflZtWFPZDfA+4ofb/AILXcJQyoS/d
         pzUoBKATCDSyJNStQWRKReA/un2dmAEfqe2kWEBulxGIIqyPL8Fzc775CwaJ/u2Si9JC
         tRlHzT4YZCKMQLgJMIJj0JouamXwHERdPul9Lb5+9qzqjibVkrrGdvrJemWbhfQbeKR/
         AYOp0EJRukY6Oj0Q9ErQmJk+lB/KV4w8geocLdVMAbTC4QVsXX9/dWN8f+oXd2KZyepZ
         j2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762180357; x=1762785157;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cFOPiT9cWcA8H/Hh7/9YpC4GP+QpR0Uu8vly5MVNLZQ=;
        b=r+ZY1wYa35EzFTvXPVy4cdSD8CKhHkldA7+90wufWWNt0oXNUl0T7IOoLS3WIUKP/J
         SmmCjWa31DeVGiiJacsHEWslwVzg2tPEtbnm3MIrBxhadn5/7SYC5JsVGjihKAUXJc6K
         kM+/yHr+nd8XF0XeLB2+aKwSM2Z1wxOCR5omXHsP0g/0KZ2pcbtl9w2gIoZF9CdgY4oz
         6cR/xkGr/45GYL92Yd0Oqpi3g9/pZuRebxFV9AbV89DZyQBq2D1DwukgTwj1558ei6Wp
         Nz67zB6t2UKwoOPoT8MS1JgeiUKtbf7FKnuocqhFx4K3louWElC2jxHv2pNLXXwgYL19
         775A==
X-Forwarded-Encrypted: i=1; AJvYcCWLOYnUbL43qfUWF6y34Jp9cG6Weif4IiS0eHvdIbtZpKaSlFbw/wENhISrxdmLp6Hda2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb+gDj4hIfWRpoKkcjcwOVlGfOHdecdr8xn3k5xskV0kt8S005
	QHstqOAcEKXVb8lVHWkznzdPTV5JnMmNeJZGuaO/TWl//zuVfMwuhT5+
X-Gm-Gg: ASbGnctjddVG6H4/CK/Ku8A06UH0oiLt3rNFfs0JWlHu8c2GUNAJNX1ol31CLV9JT0k
	lT2RIBaOo9txLC7Gqn/BPZFM4PeHDEazpkgXNRlH1TGPBE1qbPTjoK5CN28LipTvm/DecFveuIw
	iEF/6GklBSHc0mhKFf/DEj9+9uiH/PL23NL3MffJUpdlOK1cDiDVleoiCKhGDp/WnSt80488rhO
	smQ3QawlVX4iOMUky2Tv9PSQgSjZhP0sKmsArw6nmh4F/moQzbIWD/LLQT/SzKmMyXpvyycfAoU
	2fgzru3Sd6n2vygz9bZHbJbDjRV0MjBWsCCh8xlUe+yukOzx+4OMa96dt/9ZOLWlzNulnfNqSIy
	eJu5QNJu1oAvSc9sNqznqbHMVxdrWNbvg54+tn10cCJuz6ShlY8gWIaRuJ6hvoIC6BMEeYRGcnI
	42y5qHDOQvVpSWBQfFE8uYPXW9TDDLkZXV5I9Y7LCb6uSkkv8twiaU
X-Google-Smtp-Source: AGHT+IHsUVGRRPx209bqjBojcvhQ/c4JtZtoi0zpaC3ZJrM/jIFFWDXb6JQc84Vcm56ofISwUDZkhA==
X-Received: by 2002:a05:6000:200d:b0:429:d3e9:659 with SMTP id ffacd0b85a97d-429d3e90d5emr2575744f8f.1.1762180356470;
        Mon, 03 Nov 2025 06:32:36 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429cde45b96sm10468526f8f.32.2025.11.03.06.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 06:32:35 -0800 (PST)
Message-ID: <6ec34cb1-4149-48b3-8c15-fe3460aae729@gmail.com>
Date: Mon, 3 Nov 2025 14:32:33 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 1/2] xdiff: add 'minimal' to XDF_DIFF_ALGORITHM_MASK
To: Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Antonin Delpeuch <antonin@delpeuch.eu>
References: <pull.2075.v3.git.git.1761686060477.gitgitgadget@gmail.com>
 <pull.2075.v4.git.git.1762034252.gitgitgadget@gmail.com>
 <e81a5d2bd23add19e04184f6b37910bc89a514a5.1762034252.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <e81a5d2bd23add19e04184f6b37910bc89a514a5.1762034252.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Antonin

On 01/11/2025 21:57, Antonin Delpeuch via GitGitGadget wrote:
> From: Antonin Delpeuch <antonin@delpeuch.eu>
> 
> The XDF_DIFF_ALGORITHM_MASK bit mask only includes bits for the patience
> and histogram diffs, not for the minimal one. This means that when
> reseting the diff algorithm to the default one, one needs to separately
> clear the bit for the minimal diff. There are places in the code that fail
> to do that: merge-ort.c and builtin/merge-file.c.
> 
> Add the XDF_NEED_MINIMAL bit to the bit mask, and remove the separate
> clearing of this bit in the places where it hasn't been forgotten.

Nicely explained. This is a useful improvement that should prevent 
errors in the future. After this patch there are no users of 
DIFF_XDL_CLR() so we should probably remove that macro. I'm not sure it 
makes sense to remove the comments that have been deleted below as we're 
still clearing the old setting. Apart from that this all looks good.

Thanks

Phillip

> Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
> ---
>   diff.c        | 2 --
>   merge-ort.c   | 2 --
>   xdiff/xdiff.h | 2 +-
>   3 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index 87fa16b730..6ce3591c5b 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3526,8 +3526,6 @@ static int set_diff_algorithm(struct diff_options *opts,
>   	if (value < 0)
>   		return -1;
>   
> -	/* clear out previous settings */
> -	DIFF_XDL_CLR(opts, NEED_MINIMAL);
>   	opts->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
>   	opts->xdl_opts |= value;
>   
> diff --git a/merge-ort.c b/merge-ort.c
> index 29858074f9..9b2b0fce7e 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -5495,8 +5495,6 @@ int parse_merge_opt(struct merge_options *opt, const char *s)
>   		long value = parse_algorithm_value(arg);
>   		if (value < 0)
>   			return -1;
> -		/* clear out previous settings */
> -		DIFF_XDL_CLR(opt, NEED_MINIMAL);
>   		opt->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
>   		opt->xdl_opts |= value;
>   	}
> diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
> index 2cecde5afe..dc370712e9 100644
> --- a/xdiff/xdiff.h
> +++ b/xdiff/xdiff.h
> @@ -43,7 +43,7 @@ extern "C" {
>   
>   #define XDF_PATIENCE_DIFF (1 << 14)
>   #define XDF_HISTOGRAM_DIFF (1 << 15)
> -#define XDF_DIFF_ALGORITHM_MASK (XDF_PATIENCE_DIFF | XDF_HISTOGRAM_DIFF)
> +#define XDF_DIFF_ALGORITHM_MASK (XDF_PATIENCE_DIFF | XDF_HISTOGRAM_DIFF | XDF_NEED_MINIMAL)
>   #define XDF_DIFF_ALG(x) ((x) & XDF_DIFF_ALGORITHM_MASK)
>   
>   #define XDF_INDENT_HEURISTIC (1 << 23)

