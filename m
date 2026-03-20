Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4540E3D3494
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027125; cv=none; b=nEnCRHjvzCOWT1mP07uV6QJcA3u0Vea2ycrxaFIdrXzAhb33v4eZQsEkeoXCGwYYOslaSyJxhK2+U37FtAPq5pQCxQftAhAFbRtj7kIShMO1czVi/qXUuNsPRDClSi0wdmnrAo0Betci5dez6xjtKFaiOOsVfxOS3URVmlpvXr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027125; c=relaxed/simple;
	bh=E04BFAGuTP2ItCLgpEk0jb+b4N1sLG8ZAWFSZ4u9dZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5ioyuAfLutiKug+WkpcDSwYMf+3KYmW1t0IxcdPbRBsVm4cf5XnvuP3RMYvRDFzOgPKc9Lvu7MmKM0B2nbsvt2ZgpWIdE67Jq+1BxSCpYJNtzHMgTGpbdKQOh1iuAgYR6shXL5QEeBloiJ/IZtHbvg9858lWNFD4lklMaXtqts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzitNs3j; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzitNs3j"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ab08e6c553so1995005ad.3
        for <git@vger.kernel.org>; Fri, 20 Mar 2026 10:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774027121; x=1774631921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tVf/s+ueDobHMC5Mg9FKz0Pvh9UnvzlCErtoD42tcm8=;
        b=bzitNs3jI0KAsIFCcEy+7EDvGctaO+E79jlJvxfin3eq/K6yvE6iXoQPSoAAytd+cn
         RBZQZUodTg92fH4Lp+PK18Qhmo4bfmBKaKMVBg3TaSBURcyMojIhabecd41A+loMrjZ4
         e50PSJU9W+Jea+9Ye4WSk6/fhauRwljM1Pk8MGObdXLozjXARhqvAlKuy2d0RiqXKP18
         Gt+Zc1H1ByOnU+VSHFXnQ03urS/2BqY4SdVML8sPPnsLi5PSDozDv+qxcm2c8MKc5Spr
         5J+yWR0eWdu6GT/5ZEQH/LQOfxaH+MUTdQ/xXB1bZ4f0IPNYsgKPgmQRJjehWskSnB07
         iawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774027121; x=1774631921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVf/s+ueDobHMC5Mg9FKz0Pvh9UnvzlCErtoD42tcm8=;
        b=MNUHtYkOMNiSXP6FJfXWNy45/0cV++drFcPqaxJj57uWQLmnGERLeJfBn1Sa/9nH9K
         LpXBUrsDMpCxZG5sg/WYAmnThBD58n8cRgo0DQyHDLDUJwLDlUbE3LlOobnjIyFnQPtJ
         B4u6hbNVMuHSBZ9hdFmi7LkhIO0Shx+E1Zuzj0dCSAaLkT9tW/QSNw+7gM+jHG0SGgo6
         ZjTA0SS1ytDpwvrwvVDr+qvW57qsWum9+uvnEYF31tamlH+vscFhNvAtsIXdN+SsTR9h
         1y5lyxWBhmLLUpH5kxNxZiGHYdLJlPF13Yw9DfibD1j7HQtoq8EYhfvjdjSG7J0AIuYZ
         t46Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5vv+GqMGQJa7DlpX2v4lfJ2Cn2Dmk43E78sQZ9VfMwC+oQxbnLkALTMi4rvAdvtZQJCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznT4uUepc641BYbH7YC70EBfx2DwJSgxXa4GQCpGIiEfpDjDUC
	wB/gmRjDVIOAogvZR1/Y/bbYMy8sIwF8VmB9MAXZtLHC8AYH/7I+/zAc
X-Gm-Gg: ATEYQzwtQGPrXYYuPIikj9JQAax81nFJ3hfx1LnoTgmfibNsL/u/Ho5lINK+UbTJ7TW
	PgxoIDMTL6McY5UWOaxrVruwFFBQnl/xGbRWezDaYI6BAdyVKFKQHHLZTJ3IeYa5eibSikG78iE
	xW8CO7pykR5+wwlGCLG1agFvUu9OocxHu8ebD4NF+6UDDFAVQSdRZUt21FospUpSKGf1+5QVSEY
	fHDKsnojMrXNCNYo+kZCGaB3U9FziqupDuED9htUBG5FLwcCVZKArgNQHPcGUVJIVu4Gc2Vbvch
	yKV1kLpmmQfj447FHCTlS3CmMfNGVMo+4H7dMVs5RECbjW7XO2wtSWQOsmojdNjBjQykGyQwKqC
	cgnBYQtY1SQgFX2DvZpg2Wi8rs8E2ZwToyKFwYj7qpxxLt/AhNbv3MBSIMeRT712GqBVdg88Igd
	WAkk0RYfaD1aeLgQo+a9ut4rPz4MPpIMEAUbqgekxZlSY829gc1iUqCMb3ut53loZk6gfBkk4S/
	B/3wr25AKM=
X-Received: by 2002:a17:903:1a2e:b0:2ae:cacf:fc57 with SMTP id d9443c01a7336-2b08275dae1mr21587465ad.4.1774027121188;
        Fri, 20 Mar 2026 10:18:41 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516194sm27323155ad.4.2026.03.20.10.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 10:18:40 -0700 (PDT)
Message-ID: <eca1a469-2e15-4466-ae58-978ffc23c177@gmail.com>
Date: Sat, 21 Mar 2026 01:18:36 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] path-walk: fix NULL pointer dereference in error message
Content-Language: en-US
To: Yuvraj Singh Chauhan <ysinghcin@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, stolee@gmail.com
References: <20260320114556.3151040-1-ysinghcin@gmail.com>
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <20260320114556.3151040-1-ysinghcin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Thanks for the patch!

On 3/20/26 19:45, Yuvraj Singh Chauhan wrote:
> When lookup_tree() or lookup_blob() cannot find a tree entry's object,
> 'o' is set to NULL via:
> 
>      o = child ? &child->object : NULL;
> 
> The subsequent null-check catches this correctly, but then dereferences
> 'o' to format the error message:
> 
>      error(_("failed to find object %s"), oid_to_hex(&o->oid));
> 
> This causes a segfault instead of the intended diagnostic output.
> Fix this by using &entry.oid instead. 'entry' is the struct name_entry
> populated by tree_entry() on each loop iteration and holds the OID of
> the failing lookup

Checking for NULL and then dereference the pointer, a segfault is bound 
to occur. I believe this is indeed a bug.

> ---
>   path-walk.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/path-walk.c b/path-walk.c
> index 364e4cfa19..839582380c 100644
> --- a/path-walk.c
> +++ b/path-walk.c
> @@ -171,7 +171,7 @@ static int add_tree_entries(struct path_walk_context *ctx,
>   
>   		if (!o) {
>   			error(_("failed to find object %s"),
> -			      oid_to_hex(&o->oid));
> +			      oid_to_hex(&entry.oid));
>   			return -1;
>   		}
>   

The change itself looks good to me.

However, I have a slight concern about the original code implementation:

 >      o = child ? &child->object : NULL;

This means that 'child = NULL' is the expected failure path. But why is 
'NULL' returned? Does the object truly not exist, or was it simply not 
parsed? Is 'failed to find object' sufficient to describe the cause of 
the failure? I think that's debatable. (I’m not 'suggesting' that you 
make this change; I just hope we can all think about it together ;)

Also, it looks like you forgot to include 'Signed-off-by' line when you 
committed the changes. When you've gathered enough feedback to commit 
v2, please remember to include it.

Regards,

Yuchen

