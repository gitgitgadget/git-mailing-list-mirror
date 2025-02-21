Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4411EBA0C
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740167759; cv=none; b=PZdQFr4Yxh917x1tsvdwPVXT4kxvPS4Ch5XPWSw6uG7J4U1cDly+p5ZDpGTqKnxlxtCD7Bm/cFDBjiGfkFA19bQE8WYWkXMyRAGkvMjy0atx7Qewqv8L3ONRPPEd+NzikhuqpNWoR1Dcdy5YHzcXySEp225j5mjvukvyZSbrN4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740167759; c=relaxed/simple;
	bh=twKalptMKKBB2ahBc1eWAHKx36yRoKsTN4vKy15GTmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtGnmvrdNEIIt7Y63T/Qi9H7Tk7ord4Q3X5O7NLh9AXjB0VLLvfP4/guNdu8UPOerNpAfA9evXlCbWHrP97Xa/Pl5MCmpaFdAzgRhmrXpanjLAMJ4sQwX66Ke2w5Oy2L2vA+cUQVtazrN9jb/DBg4pDPcAYBawe+W/wVYxzcMkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJvJy/mu; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJvJy/mu"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71fbb0d035dso1546785a34.2
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 11:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740167756; x=1740772556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ckTLZo2sAlwCw95zwNLBZr2+/jtxiLOnUWIlzqZQ3Bk=;
        b=EJvJy/mug3nRk2frsLzdOgpfRQ0n+vxKAgh9E/mZrY3068qEjuxzEt5vcYI0/Jq38z
         9L64OFiEPwWtQ+/B8HkC0zCBcDupwn+hOXwVMXg2bQPGs5z8sfycoNDypiRJk1+uRpZr
         jfgHdwOXk3aN7kM6vatYkXd1nPla2l469w/Y8HXlX/mR6tww2g9dsNNr/tDS+6kfBrC/
         msA7T6LJhJDvz+OHRhc+/M8r7r7Tam7tODJODZiwOSurgMLjMgAXTYibf73XeglNIFmT
         r9BptRGFeIbhyTLNF1vxj1z9fs4QDYHQXBCtMuHiYkTr0nYZEPAHh8tBn17Eraav0k5+
         YlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740167756; x=1740772556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckTLZo2sAlwCw95zwNLBZr2+/jtxiLOnUWIlzqZQ3Bk=;
        b=jjMzBk8CCQ+Lo2+IHOOGXqXdjPVnSrwwmKz3jXOIt2nhbKxTJ1Fuf6953CoktDG+97
         AufFmvx/+fA7BfbM1iyrF1Hg+f9FkYXDG/hpVnH2uFbG69bAEa1XKN4UtvnRCVCs66Ww
         UtyQAImX2tgSXI/H7/nqscE/VL+zs4dtFPhLNST/1itydS0G5jtV7Fs+WbHMxKi1VyDD
         QSZhel6TehAedCPKN85lBjpF/eeqzN7TkearJQBbTNql0P7I6NWNzIIDjDwBQZ9eDG/G
         ttVwfYVE/1xMvsPj8WERHlOtAR40/7zEtcHm/3L9/IL8tmc3OIgMHufu9GIM1Qjm+BVV
         UvKA==
X-Gm-Message-State: AOJu0Yxz5o/xOyh0MoaH1oKZjKTFIPv3o2EB2zAWzSng91dnjPuqUOhv
	XQXVlnkT5Lz3rFesAoh+JDzwUg1bZtGDEJ99iMB6Liho8ax4Hwm1iTM54A==
X-Gm-Gg: ASbGncsOexzS+z9pE/clBj5L01yrTG9CLg+Zqe4BTczrVbky/ydCmSTTPL5NnjW1EGb
	zltSj+kOk1ViF4FjwJt2kf4/hUQHh6uFB19QBZeK9I5jYwB4ahzNdVHgEUPf56GAvWnrylajecO
	DvdfVgnt6BYz5GsLlwgqKqRwHa4ZoMGZxvNxHwCFTSYDq+XDLQPszGRHfetzkx3nEjRKfvN/S8x
	GmCpPlUORbhfA1EOO4LkUuZBFjTATQPZKzfEsTfHkGUYn9Y7FlQq/lmvI3W/hLEbZAWhbFakEMm
	tiwDZk2zqMkigTS1IWo=
X-Google-Smtp-Source: AGHT+IFDMY+9zD0o44Lii4gc4aFrmstNalK/c+MbKT7HutSqzZAQL9DQ+Fcj8LL65Y675RE7hfJhkg==
X-Received: by 2002:a05:6830:6585:b0:727:3746:816b with SMTP id 46e09a7af769-7274c24391dmr3931884a34.26.1740167756408;
        Fri, 21 Feb 2025 11:55:56 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-727378237e4sm1650752a34.47.2025.02.21.11.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 11:55:55 -0800 (PST)
Date: Fri, 21 Feb 2025 13:52:45 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/2] add -p: mark split hunks as undecided
Message-ID: <yaovhzc7obyk5oz5f3q4oa532vgwu7e3gffgbviazt2bjl4r6u@3pf5tj6exdg2>
References: <pull.1863.git.1740149837.gitgitgadget@gmail.com>
 <43a0592a462cf68bcfdc54373da2319431c3c1ca.1740149837.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43a0592a462cf68bcfdc54373da2319431c3c1ca.1740149837.git.gitgitgadget@gmail.com>

On 25/02/21 02:57PM, Phillip Wood via GitGitGadget wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> When a hunk is split each of the new hunks inherits whether it is
> selected or not from the original hunk. This means that if a selected
> hunk is split all of the new hunks are selected and the user is not asked
> whether or not they want to select the new hunks. This is unfortunate as
> the user is presumably splitting the original hunk because they only
> want to select some sub-set of it. Fix this by marking all the new hunks
> as "undecided" so that we prompt the user to decide whether to select
> them or not.

Ok, each hunk may have {UNDECIDED,SKIP,USE}_HUNK set to denote its
current "use" state. When splitting a hunk, the new hunks always use the
previous hunk's value. This means that, if the hunk being split is
already set to skip or use, the new hunks from the split will inherit
the same value.

If a user wants to split a hunk, they likely intend to select only a
portion of the hunk. Setting each of the new hunks to same value may not
be the most intuitive behavior in this case. Resetting the hunk "use"
value results the user being prompted for each of these hunks again.

If you have a very large hunk that would get split into many smaller
hunks, this does mean that you will have to explicitly set the value for
each now. If the user only wanted to change a small portion, this could
be a bit tedious. I'm not sure this is a big setback though.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  add-patch.c                |  3 ++-
>  t/t3701-add-interactive.sh | 10 ++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/add-patch.c b/add-patch.c
> index 95c67d8c80c..f44f98275cc 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -953,6 +953,7 @@ static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
>  			* sizeof(*hunk));
>  	hunk = file_diff->hunk + hunk_index;
>  	hunk->splittable_into = 1;
> +	hunk->use = UNDECIDED_HUNK;

Ok, we reset the current hunk to be undecided. Makes sense

>  	memset(hunk + 1, 0, (splittable_into - 1) * sizeof(*hunk));
>  
>  	header = &hunk->header;
> @@ -1054,7 +1055,7 @@ next_hunk_line:
>  
>  		hunk++;
>  		hunk->splittable_into = 1;
> -		hunk->use = hunk[-1].use;
> +		hunk->use = UNDECIDED_HUNK;

Here each of the new hunks are explicitly set to be undecided. Since we
always override the initial hunk to be undecided, I think the new hunks
would already be set undecided as well. I don't think it hurts to be
explicit though.

-Justin

>  		header = &hunk->header;
>  
>  		header->old_count = header->new_count = context_line_count;
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index b8a05d95f3f..760f3d0d30f 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -1230,4 +1230,14 @@ test_expect_success 'hunk splitting works with diff.suppressBlankEmpty' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'splitting previous hunk marks split hunks as undecided' '
> +	test_write_lines a " " b c d e f g h i j k >file &&
> +	git add file &&
> +	test_write_lines x " " b y d e f g h i j x >file &&
> +	test_write_lines n K s n y q | git add -p file &&
> +	git cat-file blob :file >actual &&
> +	test_write_lines a " " b y d e f g h i j k >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> -- 
> gitgitgadget
> 
> 
