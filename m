Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D68014265
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719540586; cv=none; b=lPdF4b1sFTXvXuusASE8aBKRGd9QAz1dsAReTCYwm3XKGfLKb55fjvK8sldVjGrGF4wMhO750QZCW8kmTXhNP5bgJNih9h/hP5LG+vGQmiLVB7uvJVznw3rwwmMK61e3NkK/4O1Kss0vcejC9IVConT6heGyRNC6VGE0Sivyprc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719540586; c=relaxed/simple;
	bh=v+3hE0BJ15nrs2B1a4Ws1fPo1bJdZqmHCbYCYi13KGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFtbkun6RYjdJY0nkYEnXyv2SRFoIGJcHL/nPzzP4BxpgMY838UWB6uXMepf1AgtjZwnjI0GulyhJkOWYa/y64sv4Z8pJJ4kFLJ9maPm0ygYcgdSkADs0XNOXJ//5qkdlFaXsmdZ1pekbpgpRZVBTl5z3SeUuwy7eyGAXW5334M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfDBFyqb; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfDBFyqb"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-64b05fab14eso530767b3.2
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 19:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719540583; x=1720145383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dwfVhdzAuMB05zVokiJjOxsOYJZuM/7sbu4vr+X/kcE=;
        b=AfDBFyqb1xnLiASAvaHp0j3DcJ8gTuuhb+MpBKBeQLk8W5VIOLVsJdqjRBXPql8oYr
         IsvGVveOMQOZxlYJuTG5o8LxMAZsKnL9CPTceMh1+AUvOdHOBhZi5ilFLYcfPWh2cGM/
         Xpn7xPZbOEb1F07E+RvIrJpKwCb+yAhK69c8ct3vWJ4aQ+XoCrGqne4WzOLuidkm/yHO
         cmmtBL9sR7ZNHj5IgANxDeainp7JsMyM1YddyAqcaimczO4wy2j4v8YM7L4h9zwHWj54
         E9ahSfKI70dJFxPGG81zOw5Gc1xImOe3JH8EXPhpTXZC4PgLjqaD2MWTuoAD19NTY65D
         3R+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719540583; x=1720145383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dwfVhdzAuMB05zVokiJjOxsOYJZuM/7sbu4vr+X/kcE=;
        b=VV1zWwA+UaOmDbGTlORU9FutkEnwHxJUDz/S2LU1kJC/j4Vd3PkJkYt1k1qBHg5xE7
         xX+M0L/8spaFMlVa6k0yaLjeUYNuHmXNLw4mx2Oo/BQA0so7LJvi1FiZiGOdgGVT9chu
         +o3iqwWRqQqvSztx5eEh/QEcfrbRVO6rK9akQIn7Dq5RsgGVMMBe0fAosvGnLRdKOh5z
         1uf6dlTo2KIgl21AHZdCJC6C7PSnyWFb6sQODvVdosEMXX3BqZ3JHTycGuyqaDx0g/+Q
         3Z/KTeojNcySozoOgf+cFiVuPiAYWC6MZmzPtHqKbD4mwHDOs1W4KxUyuYiZ0hW2+kX9
         wixA==
X-Forwarded-Encrypted: i=1; AJvYcCW+stoUdHSIg95NK/R3vkv1jB0MEgnCXxo+a0gUc+UACMkvZsNfqt0cZZEVruzer3CpUj1oMzG9HtIH6mVq3FOv2zOV
X-Gm-Message-State: AOJu0YwWy774ovcwOOZbjaoVmRsJZyo6KLGSFwhk8BdGjxe9AWdWPCBx
	VlZawGgTKRGw6y9fGTUo6eJizNMTyrdjxUkDCdCSQrpR0EUtcWSi
X-Google-Smtp-Source: AGHT+IHtB/pRhLtngssmgcC//wATPTPK7H7EeKdZ3k818xLnRTG1ofYIJ7HUZVGkAHZak4Dx2FVcIQ==
X-Received: by 2002:a0d:e814:0:b0:61a:d4ea:b856 with SMTP id 00721157ae682-64af39fbae4mr3373887b3.40.1719540583413;
        Thu, 27 Jun 2024 19:09:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:5cca:8078:1e70:3d3c? ([2600:1700:60ba:9810:5cca:8078:1e70:3d3c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9a23bad1sm1777007b3.31.2024.06.27.19.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 19:09:42 -0700 (PDT)
Message-ID: <0df65763-9419-4ed4-ba28-a82ea1ac6dcb@gmail.com>
Date: Thu, 27 Jun 2024 22:09:42 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] merge-ort: maintain expected invariant for priv
 member
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>,
 Elijah Newren <newren@gmail.com>
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
 <pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
 <d1adec6d10556e247c21f94420879724fa2c6436.1718766019.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <d1adec6d10556e247c21f94420879724fa2c6436.1718766019.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/18/24 11:00 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> The calling convention for the merge machinery is
>     One call to          init_merge_options()
>     One or more calls to merge_incore_[non]recursive()
>     One call to          merge_finalize()
>        (possibly indirectly via merge_switch_to_result())
> Both merge_switch_to_result() and merge_finalize() expect
>     opt->priv == NULL && result->priv != NULL
> which is supposed to be set up by our move_opt_priv_to_result_priv()
> function.  However, two codepaths dealing with error cases did not
> execute this necessary logic, which could result in assertion failures
> (or, if assertions were compiled out, could result in segfaults).  Fix
> the oversight and add a test that would have caught one of these
> problems.

"one of these problems" is key here.

> @@ -5050,6 +5050,7 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
>   		    oid_to_hex(&side1->object.oid),
>   		    oid_to_hex(&side2->object.oid));
>   		result->clean = -1;
> +		move_opt_priv_to_result_priv(opt, result);
>   		return;
>   	} >   	trace2_region_leave("merge", "collect_merge_info", opt->repo);

Removing this line does not cause your test script to fail. This is
understandable as this case only happens during a parse failure, so
it would be unreasonable to generate a test case that only fails
for such a reason.

> @@ -5080,7 +5081,7 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
>   		/* existence of conflicted entries implies unclean */
>   		result->clean &= strmap_empty(&opt->priv->conflicted);
>   	}
> -	if (!opt->priv->call_depth)
> +	if (!opt->priv->call_depth || result->clean < 0)
>   		move_opt_priv_to_result_priv(opt, result);
>   }

Removing this change does get caught by the new test.

Thanks,
-Stolee
