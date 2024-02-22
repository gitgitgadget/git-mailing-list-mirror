Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6F414901A
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619758; cv=none; b=LaMefsl5ZqKPBDIpnTG2Nl/N3P0+puhStffMAR2i/xWt+G1VFhDPpLg/tpQSxW3qiiHHDgSnfizZ+FgRbAwQ6WidX4y2vI1F1v+13rbMhZaRRR+EfpRAlLyeerRUATvood+4tD7C/953nvTYv3yEU9o2/uOhJ3M7MvXf8XRkHUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619758; c=relaxed/simple;
	bh=G4eJqz5FxRR8hfYUQdJV2EDmUzIOozYkJaxoTeaJDcA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nJ3vA0k9hPN/PlMZDB9lb2Nj2oyWOxBFr+TqHx13zHvt8T6Q8CCLyUuluyNg829tjDagdX6mDTFynKzKabMpu3G3IFiBzn3kmyyaRAdewQgoWAfdb07SHigMvymJ7O3f+ZN+XPyiFcv18UcZ5vfY7yxGwB8MUfV8yl9Yv+GcP4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2CLe2he; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2CLe2he"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4128f3eea18so1828085e9.2
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 08:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708619755; x=1709224555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b+mTaYkWnjVwy1/HACNuIXZWUju/ZIMf+x0lP2APYG4=;
        b=P2CLe2hec0NvoLQGTnY5R83BbtuqKeT6pu857XswzI6U9Sh7Hj1wcf7ZcSP+8VOXWm
         OS7cjmiCKHQGM73s3uCdXvE+9owc5b+Iyqu4xewU/mfSM5GurSz0nfmlrf12h5Uy0n3x
         k4vOYYojpPVzgMZX73ksitlYjazwIwX87djxPhsV9x0cCElaZCdQZ84Jp5nrRZRLe2SU
         +DNBl+BpWOMb4NO1UtPZ1p5GBugaZ9YN1CE8klofwwHqioWUE121GPYherYXssjmbm9R
         SpKwuxT3PdCG/AIjoR1tVY5ykM7mOROyeXg1AX6zncAd6HLLCoAxkqHBT9UpGAwRxXqZ
         uXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708619755; x=1709224555;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+mTaYkWnjVwy1/HACNuIXZWUju/ZIMf+x0lP2APYG4=;
        b=CZFBuHX77Cw0eHUHah3vcvXXJHKf9Ga1TcsRYkkuwNcWZM9gRzS7fusSmA/d6p6/Lg
         jyk5iC/TDEjIfsGFoICBXFxJDmOtFxxSWZrc7fLlqql2+F2siFGg8gHPr9DURCNC8+Mu
         fyJ+M4B7BZk1/vOXYJak1PMl8kw6LT9xBfztfyAJ2YkKLrqfWjfWjdb4c9p3zgjhfTPl
         y54ifxuOuIJEau526Bva+dnnQWzO9YQMD23ZNaK04lqfekaPiqKf3yBZoPN8i6mti5Lr
         RpHwaUU1ii87rzl716elqrWPZX7d7DmooLTwl1X1B1eEIKJYdMu2I4FhcSEFBWyr6hB9
         FpAA==
X-Forwarded-Encrypted: i=1; AJvYcCUPvmQ8tH8da+r0rviDacRkgziROCq5Kt1i9wMEiBrhRoaWOp8AWOSEm1NBkl49Je1aGbvR+1GBNy5kuEyVjn2/HiHn
X-Gm-Message-State: AOJu0Yxy9LMsTwpAgezDmrzwH3c7xSAr/0rpkiOWgJ+6V5aUj2m1C9da
	jy8jyl5AzBLL4Od2weqJZQ6k1a7v8i5qJF2nuNnZIq5t5i4Pwrry
X-Google-Smtp-Source: AGHT+IFcckKNgFPlJjaSA3UhNxtAuepWvWcOVgOOL6f9dFk/lT3+yWvcA+j+4wwPSBpr2UjEArUNFQ==
X-Received: by 2002:a05:600c:502c:b0:412:8faa:65db with SMTP id n44-20020a05600c502c00b004128faa65dbmr316222wmr.38.1708619755212;
        Thu, 22 Feb 2024 08:35:55 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:69d:3501:4b27:339f:196f:f7f9? ([2a0a:ef40:69d:3501:4b27:339f:196f:f7f9])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c281400b0041214ff06cesm21901857wmb.42.2024.02.22.08.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 08:35:55 -0800 (PST)
Message-ID: <8c2eec1b-9a59-4739-a903-b2e8955f3ff5@gmail.com>
Date: Thu, 22 Feb 2024 16:35:54 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 7/8] cherry-pick: enforce `--keep-redundant-commits`
 incompatibility
Reply-To: phillip.wood@dunelm.org.uk
To: Brian Lyles <brianmlyles@gmail.com>, git@vger.kernel.org
Cc: newren@gmail.com, me@ttaylorr.com, gitster@pobox.com
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240210074859.552497-8-brianmlyles@gmail.com>
Content-Language: en-US
In-Reply-To: <20240210074859.552497-8-brianmlyles@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian

On 10/02/2024 07:43, Brian Lyles wrote:
> When `--keep-redundant-commits` was added in  b27cfb0d8d
> (git-cherry-pick: Add keep-redundant-commits option, 2012-04-20), it was
> not marked as incompatible with the various operations needed to
> continue or exit a cherry-pick (`--continue`, `--skip`, `--abort`, and
> `--quit`).
> 
> Enforce this incompatibility via `verify_opt_compatible` like we do for
> the other various options.
> 
> Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
> ---
> 
> This commit was not present in v1 either. It addresses an existing issue
> that I noticed after Phillip pointed out the same deficiency for my new
> `--empty` option introduced in the ultimate commit in this series.

Well spotted, do we really need a new test file just for this though? I 
wonder if the new test would be better off living in 
t3505-cherry-pick-empty.sh or t3507-cherry-pick-conflict.sh

Best Wishes

Phillip

> [1]: https://lore.kernel.org/git/CAHPHrSf+joHe6ikErHLgWrk-_qjSROS-dXCHagxWGDAF=2deDg@mail.gmail.com/
> 
>   builtin/revert.c                            |  1 +
>   t/t3515-cherry-pick-incompatible-options.sh | 34 +++++++++++++++++++++
>   2 files changed, 35 insertions(+)
>   create mode 100755 t/t3515-cherry-pick-incompatible-options.sh
> 
> diff --git a/builtin/revert.c b/builtin/revert.c
> index d83977e36e..48c426f277 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -163,6 +163,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
>   				"--ff", opts->allow_ff,
>   				"--rerere-autoupdate", opts->allow_rerere_auto == RERERE_AUTOUPDATE,
>   				"--no-rerere-autoupdate", opts->allow_rerere_auto == RERERE_NOAUTOUPDATE,
> +				"--keep-redundant-commits", opts->keep_redundant_commits,
>   				NULL);
>   	}
>   
> diff --git a/t/t3515-cherry-pick-incompatible-options.sh b/t/t3515-cherry-pick-incompatible-options.sh
> new file mode 100755
> index 0000000000..6100ab64fd
> --- /dev/null
> +++ b/t/t3515-cherry-pick-incompatible-options.sh
> @@ -0,0 +1,34 @@
> +#!/bin/sh
> +
> +test_description='test if cherry-pick detects and aborts on incompatible options'
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +
> +	echo first > file1 &&
> +	git add file1 &&
> +	test_tick &&
> +	git commit -m "first" &&
> +
> +	echo second > file1 &&
> +	git add file1 &&
> +	test_tick &&
> +	git commit -m "second"
> +'
> +
> +test_expect_success '--keep-redundant-commits is incompatible with operations' '
> +	test_must_fail git cherry-pick HEAD 2>output &&
> +	test_grep "The previous cherry-pick is now empty" output &&
> +	test_must_fail git cherry-pick --keep-redundant-commits --continue 2>output &&
> +	test_grep "fatal: cherry-pick: --keep-redundant-commits cannot be used with --continue" output &&
> +	test_must_fail git cherry-pick --keep-redundant-commits --skip 2>output &&
> +	test_grep "fatal: cherry-pick: --keep-redundant-commits cannot be used with --skip" output &&
> +	test_must_fail git cherry-pick --keep-redundant-commits --abort 2>output &&
> +	test_grep "fatal: cherry-pick: --keep-redundant-commits cannot be used with --abort" output &&
> +	test_must_fail git cherry-pick --keep-redundant-commits --quit 2>output &&
> +	test_grep "fatal: cherry-pick: --keep-redundant-commits cannot be used with --quit" output &&
> +	git cherry-pick --abort
> +'
> +
> +test_done

