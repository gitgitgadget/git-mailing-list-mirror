Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230BC18E20
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707908776; cv=none; b=Fn20yp8S3+Ql6eP6dQ5qmfxcL+TjyrNlibInlisQjcL+tCA8XXFfOHaz2OEe5al3EWVvbMjpZCqa60lmRvoteXGrLFdS5Qp+rtIh5u3GtuCUJmkQXpY9D8GpoHkpF32PQthA04xily1XshfvxpswDXseafZwbugYbw2dG+RspTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707908776; c=relaxed/simple;
	bh=2Fy5oYDLFcKPTQ1fNfGiUoqWBBSmCfrIfW71zwit41k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=S56stlIYjwZ8H4PrNhbf7CEGPikiyjVYuy7YMd/VBBjEnRb3pf+MppU2WZ9MIJjKJTzSMlR/EYmMclow28zguYIjZdRw1gkKxgoClb3IUIgNgtGrej9pbxepmtlwCewTA0tKHtmKfpECnzL800KXIrvhDSMisk44U3iUhMpRTZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3UNAgHi; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3UNAgHi"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-511898b6c9eso3935517e87.3
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 03:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707908773; x=1708513573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XKquKGf+F7ZJtx6K1k4NM3canoGUpCoK6nrXQOplq8c=;
        b=l3UNAgHiSQa0BiaGlfHcadH/P7tBDPw21jTbwqZzNQkBkiPtp2egnvcbeOibDm29DZ
         eDX9c/95zBq83WawI3xVRYyMFSJncKKR4RVZ8IDBKrq2rt98S+TqMUK/TwRem2LKQF+1
         xOARAWAg7NYsnWAPRzkmy/RkSCWmG4owAXMS6L0zMV2rfjea0bqulo1NDHmzvtoZXcMe
         +25EGS2p5YVBVKoC41QbwgzIGxnIIVLTe3naO3YkTO5gYObl0f4pFyk0WfkSE2teWcCS
         oPG0JBt+wbW/Icdq5MJrN1/s5XyOW/d1La/oZtRmNQ3Zc7U27dK6KfyJ3XVgBUZmTtCG
         ddDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707908773; x=1708513573;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKquKGf+F7ZJtx6K1k4NM3canoGUpCoK6nrXQOplq8c=;
        b=Swis1JJiBcIumOp7whwcDrLBJh4cHN8XjBwPLTI79BI0UvIJxOz5Ld3C4UOVFu4hYP
         slyYw3QWzKlzseNzpUrTCCIszgCQZ87AeMARG8v0EiQALNoBbWeh6mHbFPgIV9Hz5oqC
         kpomgtblGdCKL+9Hrj00QqJOF2bvTDlC7Q/BHPQ0oWawK9Dn9ZYZbpoZBMKvYW9FcUNp
         vi0dBs8/bhLu93+dQ47zmX+s+lzsPzFt6U5Lw6jgY7OA+5NCT9YUDHVapeyU4MLvlRIJ
         IQvOxefkKIJcMZduZluL0ALrBgqktkd0mUzVpQxVQNdKlC2G+FBK650UU/sqrnOdjvgO
         CqWg==
X-Forwarded-Encrypted: i=1; AJvYcCWpiWxEN5BtK46eUtOCa015Ef3dDJJI059ZbE/dG3YH5O/qQRxUBS887eB4y20JVDjPGzbT+1+1/jHH80Tbtbo0gLJN
X-Gm-Message-State: AOJu0Yyha7+20HKzJo8uIrQcC+dF67/uvrFbe/y/qnrL6MTkq5d5/K1z
	utgiErJeFVBCmCy9T8rb5Urj8P0hJOKWyvCIVhx1DwrqZfpm1dH+
X-Google-Smtp-Source: AGHT+IGQRf5gvKZbd4/VKWnm5vaDHFveR/GZ4k86+0BrB83fv3v4CoM2J437TIidvePOcISgatDEkg==
X-Received: by 2002:ac2:5637:0:b0:511:621a:5d5f with SMTP id b23-20020ac25637000000b00511621a5d5fmr1470337lff.39.1707908772808;
        Wed, 14 Feb 2024 03:06:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVShFfzV50NVTrHryaXvylrfAtJoBs3YchbFK+1ARUITAj7H/0PH+BPB0vT2yTnVFm1bMkwOqNLfObbJgssrPCaTNRJMgCYJgmAaHDZUo8+Y/FlMLmVL2YvCKBfYvJF+VQkHW3wv+ko
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id h14-20020a05600c314e00b00411ee1dd5afsm1196183wmo.16.2024.02.14.03.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 03:06:12 -0800 (PST)
Message-ID: <497155c2-43d0-4e3f-884f-b0296a56823e@gmail.com>
Date: Wed, 14 Feb 2024 11:06:13 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 0/2] add-patch: classify '@' as a synonym for 'HEAD'
Reply-To: phillip.wood@dunelm.org.uk
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, sunshine@sunshineco.com, ps@pks.im
References: <20240211202035.7196-2-shyamthakkar001@gmail.com>
 <20240213000601.520731-2-shyamthakkar001@gmail.com>
Content-Language: en-US
In-Reply-To: <20240213000601.520731-2-shyamthakkar001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ghanshyam

On 13/02/2024 00:05, Ghanshyam Thakkar wrote:
> I just noticed after sending v5 that, in one of the tests, while
> moving it inside the loop for also testing '@', set_and_save_state was
> not used therefore the subsequent tests after the first $opt will not have
> the changes for which we prove 'y' thereby making the tests useless.
> (Although it would not fail regardless of this). This got unnoticed by
> the previous reviews since v1 and me as well.

This version all looks fine to me, thanks for working on it. Thanks for 
removing the PERL prerequisite from the remaining tests. I think the 
change to "git checkout @" is a good idea as it makes "@" act like 
"HEAD", hopefully there aren't too many users relying on "git checkout 
@" to detach HEAD.

Best Wishes

Phillip

> Apologies for the oversight and noise.
> 
> Ghanshyam Thakkar (2):
>    add-patch: classify '@' as a synonym for 'HEAD'
>    add -p tests: remove PERL prerequisites
> 
>   add-patch.c                    |  8 ------
>   builtin/checkout.c             |  4 ++-
>   builtin/reset.c                |  4 ++-
>   t/t2016-checkout-patch.sh      | 46 +++++++++++++++++++---------------
>   t/t2020-checkout-detach.sh     | 12 +++++++++
>   t/t2024-checkout-dwim.sh       |  2 +-
>   t/t2071-restore-patch.sh       | 46 ++++++++++++++++++----------------
>   t/t3904-stash-patch.sh         |  6 -----
>   t/t7105-reset-patch.sh         | 38 +++++++++++++++-------------
>   t/t7106-reset-unborn-branch.sh |  2 +-
>   t/t7514-commit-patch.sh        |  6 -----
>   11 files changed, 92 insertions(+), 82 deletions(-)
> 
> change since v5:
> diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
> index 0f597416d8..453872c8ba 100755
> --- a/t/t7105-reset-patch.sh
> +++ b/t/t7105-reset-patch.sh
> @@ -29,6 +29,7 @@ test_expect_success PERL 'saying "n" does nothing' '
>   for opt in "HEAD" "@" ""
>   do
>          test_expect_success PERL "git reset -p $opt" '
> +               set_and_save_state dir/foo work work &&
>                  test_write_lines n y | git reset -p $opt >output &&
>                  verify_state dir/foo work head &&
>                  verify_saved_state bar &&
> 
