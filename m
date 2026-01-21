Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A822D46BD
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768992003; cv=none; b=Y3MeR5wMOiXEErAGRtLUPvwe3eZwOIT3d76kZm6fwe4iU6ki6uOJRpFK1YTk8gqbk+Bo6HPPeq+QCfq1eEu+eUduQwQJpWzKSPuH7MN2DHnnNWaOLw4ox7vdKkANfWwvOKexQ6Z0DHr7bUeU5IplWPlxk5KKQjDoN+fRVLkMQWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768992003; c=relaxed/simple;
	bh=ycXNXPwsAm1gDsh5XM69zRo2R/uoaZtvsvGFj8UPLHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AI60wi9Exqk/aE7N+4fISUsanrPHZCFtf8JkNmuUMroRIdErppMedCqQUvefmWhKwV/Dcqns7IcyA/pSDFbRSd7Bz4Ea5iGkQNpe2ML//kgiEoGcJ7w4G7qik7z0Bc1kJGdlQJVnZWRIr6jaT/EVMaxd/zZXCNj3jvcPOlr+FGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8Uu1RD1; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8Uu1RD1"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-42fb6ce71c7so5602495f8f.1
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 02:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768991999; x=1769596799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xPO57E6TJHLHg518SY9n15Y7XVS17ukFSaBRW0qHOo0=;
        b=Y8Uu1RD1XHuinLb5i2c6oMc2dG4+UeM1TVkRgOuR0z0p8rIY1hYl2CmzLcLMKIqut1
         wonEC6mOWP8ouHRDVUzY8LxkDuc1a0fnz+kzNPtBuytx53wKYiHQPfacKicJHzzH+LO0
         i3XBwc4PsipjXSTqoHIDciVs5bT2zO3bGVa6pqRZQ+sbO9POHCcBv84ESe1j7dw3C8r1
         y9WIDg8wATkAcoHYe/flGvOkP9XxIpFeFGCO1rgU8i0AGyINkAg+tyiscKg+/7dkkJsP
         uv9ejvqnSnv1JXJnlSABfK3OA/+vJKxHOAhOaP9ygmTGPT3IAswZIMeMLCA/FswCPLnN
         gWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768991999; x=1769596799;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPO57E6TJHLHg518SY9n15Y7XVS17ukFSaBRW0qHOo0=;
        b=DAoM3FwclgcO2hbqNYIYPcEF8sKdp22wvPxyF1rclELNZT0i4xARiqDX7tYydaREx+
         Z/qIOvIvm2iqIh46+qBlhcF5GfAlynrQnCHwpWl9j8/d8LlNkTwwvQAp173s/KPLEX1P
         7lZnAKOZ9zrH5liqyVmGVMtrB9pLee9RUNuIR/Rwuyn3Tcg1ngNQc26RiMGJ1F5yOtEL
         CJnuaUxDqnzTausKCp4Nj7nAQjYpODfs61ExauYeH6wy1kH6KNhjeuRj2fZw/Vb+0Bx0
         4bB1AYrhUAht33eEjpM224vYSZ1kYKLqvr3ybW/bMUhUJH3FWgLW2JqrZW//FACLgK0q
         fEfg==
X-Forwarded-Encrypted: i=1; AJvYcCU/F+RhIr6buqhHlEIpiIpdPyL5Gsqu0w5HqJMvg2j0wTE6xdRm4/zVo6oDIHt5wTSiUjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy95UGwJsJnQzdfQhUdol/EnY4mb8YPvaBsw18tK/QpU58P1S8W
	KBQfGwp5Kt/5MMHLhSN8BCIR+xvBVaHBvvsHO70IJ9N8B7Kh2i9St5Xs
X-Gm-Gg: AZuq6aJOWvQtYSB/EwgXKhxOI9+gsf9MavwrEWSFn4zImQyH0Tl73zhaWB3LCzLvOtS
	owLP3eMF4ugdiNcZ/6AnqIJVm5LrwOivTB8ZQll8QvTnlmFUuaLyVgrHLxdrpDUrhXiRIj/VFD0
	702PN1yuzhZixsotvTo9C2H/yLc2DZSVeYjZLuJ0yemwzTJozUNUgD2VFpRJUOTcshr23szZXK8
	WMSbqYuiZEhojtnnLjj+hWkuPE9Pj3Crj+hFYNkJ+M4MMpVGzu0WlCSr0QaRXQmk8o+OUYfFYlN
	aO92WEbdYGD0EnYy5eOszzHWNuWI4WaQ586HHG1dPFhhyfI/kKi6CZgl80ThpQvfRiQrncWs6BO
	KvJZ14z6e7VEG1E3Fx7QYAWBzm28dGI7PrM85JkAP/9vEHgtYGIYW526u6k1WqBTrD8btXBog5H
	9cpB81kWz5Fa6EqDlg/i7YlPGrkTwydUFgbCwdf9CmaP3ACLh/cqxqmkDXvMia4FcyVxoDyPVJt
	siv
X-Received: by 2002:a05:6000:288e:b0:435:a2b7:2508 with SMTP id ffacd0b85a97d-435a2b728efmr716847f8f.61.1768991998583;
        Wed, 21 Jan 2026 02:39:58 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4358f138e26sm10591915f8f.17.2026.01.21.02.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 02:39:58 -0800 (PST)
Message-ID: <7b5dd0c4-0ca0-458e-89db-621a70dac9ae@gmail.com>
Date: Wed, 21 Jan 2026 10:39:57 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] show-index: remove global state variables
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
References: <20260120140901.517928-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260120140901.517928-4-shreyanshpaliwalcmsmn@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260120140901.517928-4-shreyanshpaliwalcmsmn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/01/2026 14:05, Shreyansh Paliwal wrote:
> As Git is in the process of removing global state,
> this function still relies on the global variables,
> the_repository and the_hash_algo.
> 
> Remove the associated macro and the UNUSED attribute from
> the repo parameter, and replace all uses of the_repository and
> the_hash_algo with repo and repo->hash_algo, respectively.

I don't think that is a good idea because repo will be NULL outside of a 
repository. For a lot of commands that does not matter because they 
require a repository to run but judging from the first patch in this 
series this command is supposed to be able to run outside a repository.

I'm increasingly of the opinion that adding a repository argument to the 
builtin commands was a mistake as they all just use a single repository 
so using "the_repository" seems perfectly reasonable. It leads to 
problems like the segfault in this patch and takes attention away from 
the much more useful task of moving our library code away from using 
"the_repository". If you're interested in contributing to that effort 
then there are a number of instances of "the_repository" in wt-status.c 
that can be trivially replaced by the repository instance in "struct 
wt_status" or the repository passed to the function. I'm not sure how 
easy it is to remove them all - you might need to change the code to 
pass a repository instance down the call chain in a few cases but there 
are certainly quite a few that can be easily and usefully cleaned up.

Thanks

Phillip

> This modernizes git show-index and makes it more compatible.
> 
> Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
> ---
>   builtin/show-index.c | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/builtin/show-index.c b/builtin/show-index.c
> index a9c2f18b73..96adae14c0 100644
> --- a/builtin/show-index.c
> +++ b/builtin/show-index.c
> @@ -1,4 +1,3 @@
> -#define USE_THE_REPOSITORY_VARIABLE
>   #define DISABLE_SIGN_COMPARE_WARNINGS
>   
>   #include "builtin.h"
> @@ -16,7 +15,7 @@ static const char *const show_index_usage[] = {
>   int cmd_show_index(int argc,
>   		   const char **argv,
>   		   const char *prefix,
> -		   struct repository *repo UNUSED)
> +		   struct repository *repo)
>   {
>   	int i;
>   	unsigned nr;
> @@ -37,7 +36,7 @@ int cmd_show_index(int argc,
>   		hash_algo = hash_algo_by_name(hash_name);
>   		if (hash_algo == GIT_HASH_UNKNOWN)
>   			die(_("Unknown hash algorithm"));
> -		repo_set_hash_algo(the_repository, hash_algo);
> +		repo_set_hash_algo(repo, hash_algo);
>   	}
>   
>   	if (fread(top_index, 2 * 4, 1, stdin) != 1)
> @@ -63,7 +62,7 @@ int cmd_show_index(int argc,
>   
>   	/* detection of hash algorithm
>   	Only works for small files, i.e without large offsets */
> -	if(!the_hash_algo && version == 2) {
> +	if(!repo->hash_algo && version == 2) {
>   		struct stat st;
>   		size_t file_base_size;
>   		size_t table_size;
> @@ -79,9 +78,9 @@ int cmd_show_index(int argc,
>   		hash_size = size_rem / (nr + 2);
>   
>   		if(hash_size == GIT_SHA1_RAWSZ) {
> -			repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +			repo_set_hash_algo(repo, GIT_HASH_SHA1);
>   		} else if(hash_size == GIT_SHA256_RAWSZ) {
> -			repo_set_hash_algo(the_repository, GIT_HASH_SHA256);
> +			repo_set_hash_algo(repo, GIT_HASH_SHA256);
>   		} else {
>   			die(_("unable to detect hash algorithm, "
>   					"use --object-format option"));
> @@ -89,10 +88,10 @@ int cmd_show_index(int argc,
>   	}
>   
>   	/* Final fallback to SHA1 */
> -	if(!the_hash_algo)
> -		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +	if(!repo->hash_algo)
> +		repo_set_hash_algo(repo, GIT_HASH_SHA1);
>   
> -	hashsz = the_hash_algo->rawsz;
> +	hashsz = repo->hash_algo->rawsz;
>   
>   	if (version == 1) {
>   		for (i = 0; i < nr; i++) {
> @@ -114,7 +113,7 @@ int cmd_show_index(int argc,
>   		for (i = 0; i < nr; i++) {
>   			if (fread(entries[i].oid.hash, hashsz, 1, stdin) != 1)
>   				die(_("unable to read sha1 %u/%u"), i, nr);
> -			entries[i].oid.algo = hash_algo_by_ptr(the_hash_algo);
> +			entries[i].oid.algo = hash_algo_by_ptr(repo->hash_algo);
>   		}
>   		for (i = 0; i < nr; i++)
>   			if (fread(&entries[i].crc, 4, 1, stdin) != 1)

