Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C1533CD4
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151048; cv=none; b=GVUE7787s2PC4OsnGitHNLp2GdtSs+xkpP3Hdy16X/89gqTSOPLh94bsbLBEoMF5dv6yp8TxvfQv3/ywdIwXzDheApEzJmr+QC3s8CDTFAFhGoE8eYUu2jgYTCon2+C1rZ9a2kosj/UezMXp9b2YoclmooqedSOU+VkOSFp15ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151048; c=relaxed/simple;
	bh=qM06THL1jv5zHzy2lkijYvmGNHHPqY0Nv+nJZB6qdcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJ9fWtrN+/OSz9RnT3Xv3wimrwHkPuhr6FsaucSgp0It0QwqmuugR4la7eK5HNcWkQDLFGZI3KWd31IDubYoOnPnwAiKlqy0E3LzwdDJWq9MPBd9JVCpH3jlb11JsSqYP7dmP5XB9HfaWgfX1d4jXlFtHceityuWgspDBI4HHlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgvTKknj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgvTKknj"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40fc52c2ae4so30510445e9.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 08:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707151045; x=1707755845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pgrlx7ObXOOnHSLKiOrnkcnLFCVqV9GiAkMhi/lzs2Y=;
        b=HgvTKknjRQAmVRD3CmVVUB1glI2WWQXDVnoTrHNZrdwDI9D0KfHBeIkKr5yrmVLyYY
         E3Yl4r93Tc/i15yQCqG/X1srJ/E3l/iy3PAj0JBc9lQ20wtz6DQrHPSNT4sDxYrIKYw2
         bnCMZ9akewM9awJWpcP5lxPaVTExzNTvwy5o+RH+LoJ0S5FPeY3cHX7QTkmUFLJFPblG
         vBYVKwL3/iI8/K3bH26uPxxf33mHc3v4CyCpUK8KrSpx1RpPynzvmCff3As9BRdeHx4I
         RCpzhJ5gqNUFrQyp9dpKrWtvILzU2PYLGrKT1o6KOgIHd46qJnzceHMl/ywjl3GV3zib
         1pEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707151045; x=1707755845;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pgrlx7ObXOOnHSLKiOrnkcnLFCVqV9GiAkMhi/lzs2Y=;
        b=tuO6fnUuCm/Ecf7z34Ce/A7Ytdh8ffLGIBFJhcCnyuzGrMK4XQWFn6URZZsRNxyBa4
         QGcWCpQAdwLYZEw511yI7FZiFlNYXK3bXjWkCuq4SjQSaeN8twGrmd8g75KIpRsmWLYj
         4DrVLFgoKPsluDdlBjTG+fXLGtiTAlOhnKpplTnIMDGgVHXn3vq6WgHiqiVI4xvDA6tW
         MlzJDvvrzfBAEcb4Bf7VPmcbZzmGPGWZzmiMI/h7m/GZSz54y7c9yGBaE2dq5xUe9bnj
         jsTDqzAutIVlzNeR0KJ2Ah2d2pB/GwZWpULnWDLVOJXy+DbwqVVMNNvl0nK9TRw6f1aW
         in6g==
X-Gm-Message-State: AOJu0Ywhd4GlsDPJSdQmXf2iN3iUUX8FcwF8jPo+p1RalWx/qyGK0QQm
	oJQgvI7CjUpmIFiNV6j1e3kyPGi0vEvG72RQ5V+JJ0cC6zuD3JwjjV8ikD65
X-Google-Smtp-Source: AGHT+IHb3oU4s01GBpnmdTkHBTcgJQgtBk8nTUPVU1IHfbKwEjDVPBBGF7eoJbeW137cRHixQdn/Fg==
X-Received: by 2002:a05:600c:3108:b0:40f:aabc:d508 with SMTP id g8-20020a05600c310800b0040faabcd508mr223600wmo.10.1707151044996;
        Mon, 05 Feb 2024 08:37:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXOwPgJ9OhyuEANXJOqv50Ruxv/HhN0OAbIV4NCjGEVEad08t8AtKvVkzpEiFPBdoBR7asZ9W+cuOwd8oyDmYJdPrzC1BNaMf6Y17gRa+s=
Received: from ?IPV6:2a0a:ef40:62e:a901:386f:d8d1:628a:e68d? ([2a0a:ef40:62e:a901:386f:d8d1:628a:e68d])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c35c900b0040fb44a9288sm9112937wmq.48.2024.02.05.08.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 08:37:24 -0800 (PST)
Message-ID: <9f9f26f1-5460-468e-a893-5caf7fbea981@gmail.com>
Date: Mon, 5 Feb 2024 16:37:22 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] add-patch: classify '@' as a synonym for 'HEAD'
Content-Language: en-US
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
References: <20240202150434.11256-1-shyamthakkar001@gmail.com>
 <20240203112619.979239-6-shyamthakkar001@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20240203112619.979239-6-shyamthakkar001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ghanshyam

I think this is a useful addition, I've left a couple of comments below

On 03/02/2024 11:25, Ghanshyam Thakkar wrote:
> diff --git a/add-patch.c b/add-patch.c
> index 68f525b35c..7d565dcb33 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -378,6 +378,11 @@ static int parse_hunk_header(struct add_p_state *s, struct hunk *hunk)
>   	return 0;
>   }
>   
> +static inline int user_meant_head(const char *rev)
> +{
> +	return !strcmp(rev, "HEAD") || !strcmp(rev, "@");
> +}
> +

As well as the places you have converted we also have an explicit test 
for "HEAD" in parse_diff() which looks like

	if (s->revision) {
		struct object_id oid;
		strvec_push(&args,
			    /* could be on an unborn branch */
			    !strcmp("HEAD", s->revision) &&
			    repo_get_oid(the_repository, "HEAD", &oid) ?
			    empty_tree_oid_hex() : s->revision);
	}

I suspect we need to update that code as well to accept "@" as a synonym 
for "HEAD" on an unborn branch.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index a6e30931b5..79e208ee6d 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -539,12 +539,13 @@ static int checkout_paths(const struct checkout_opts *opts,
>   		 * recognized by diff-index), we will always replace the name
>   		 * with the hex of the commit (whether it's in `...` form or
>   		 * not) for the run_add_interactive() machinery to work
> -		 * properly. However, there is special logic for the HEAD case
> -		 * so we mustn't replace that.  Also, when we were given a
> -		 * tree-object, new_branch_info->commit would be NULL, but we
> -		 * do not have to do any replacement, either.
> +		 * properly. However, there is special logic for the 'HEAD' and
> +		 * '@' case so we mustn't replace that.  Also, when we were
> +		 * given a tree-object, new_branch_info->commit would be NULL,
> +		 * but we do not have to do any replacement, either.
>   		 */
> -		if (rev && new_branch_info->commit && strcmp(rev, "HEAD"))
> +		if (rev && new_branch_info->commit && strcmp(rev, "HEAD") &&
> +		    strcmp(rev, "@"))
>   			rev = oid_to_hex_r(rev_oid, &new_branch_info->commit->object.oid);

I agree with Junio's suggestion to use the user_meant_head() here. 
Looking at this made me wonder why builtin/reset.c does not need 
updating. The answer seems to be that reset passes in the revision as 
given on the commandline after checking it refers to a valid tree 
whereas for checkout the revision for on the commandline might contain 
"..." which run_add_p() cannot handle.
> diff --git a/t/t2071-restore-patch.sh b/t/t2071-restore-patch.sh
> index b5c5c0ff7e..3dc9184b4a 100755
> --- a/t/t2071-restore-patch.sh
> +++ b/t/t2071-restore-patch.sh
> @@ -44,13 +44,17 @@ test_expect_success PERL 'git restore -p with staged changes' '

It is a pre-existing problem but all these "PERL" prerequisites are 
no-longer required as we've removed the perl implementation of "add -p"

>   	verify_state dir/foo index index
>   '
>   
> -test_expect_success PERL 'git restore -p --source=HEAD' '
> -	set_state dir/foo work index &&
> -	# the third n is to get out in case it mistakenly does not apply
> -	test_write_lines n y n | git restore -p --source=HEAD &&
> -	verify_saved_state bar &&
> -	verify_state dir/foo head index
> -'
> +for opt in "HEAD" "@"
> +do
> +	test_expect_success PERL "git restore -p --source=$opt" '
> +		set_state dir/foo work index &&
> +		# the third n is to get out in case it mistakenly does not apply
> +		test_write_lines n y n | git restore -p --source=$opt >output &&
> +		verify_saved_state bar &&
> +		verify_state dir/foo head index &&
> +		test_grep "Discard" output

It is good to see that we're now testing for a reversed patch here.

Best Wishes

Phillip
