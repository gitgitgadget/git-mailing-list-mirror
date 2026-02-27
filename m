Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A1C2D249E
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772183048; cv=none; b=SF3AgNuszVt/E9PFJGf53R8DUx4UYgCn3/5MH1ZXFuvwRkHDXmfd+OkcOB4JVz6TQIhT6q6TDxZPjCSzSRIBbiPBuxu9n2KnAC8qtEJvW4Y8R4ULfZ7O/5SV6hluiX8/BsPwbMmZX9jabQ82g05T4/lyTFWLqhyUkXfw5T6aFrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772183048; c=relaxed/simple;
	bh=A0QWxhwjVoV4TkUTlbybeSWy8yJ+V8rjg0+DJEv30gE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jV4ijJ9Z0RLiFypYrZcignfjX2xX/hzFCkeVjl2TKAp4oGvOsBC/9H4PD3pJK0zf+027Vmetwb342kLhhPVvM4dtgqyvy7c5gajogQwbecwkL5oRZwpohGXSkcoG1OTvbBGb/pgX8NtWNG/1NRFstr7uoRGm06F516PH9Hh1kos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIf0a5ts; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIf0a5ts"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-483bd7354efso22890735e9.2
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 01:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772183046; x=1772787846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6tuAAL0hccaoJ70p4t8AHQ5c0nWXrbktNZU4+vC6LU=;
        b=SIf0a5tsDtxsa1LuDmE0QimGUitOirqfRfXgwURBFdBBMmuOZbGO5n+XWIUSM+M9AG
         h6V0DmGZTs4I1xE6yKro6YYw2q8QOAr1kL4YBdMj0nsj3sScB1KOrRDx4mNBxlc0ixHA
         iSN4/xTS3TAGwSnWQ9ykMBu2DG2JSNH9KeytGleFokJUn+Ny80ryAGHJzjCKh7tatqPj
         TaZ3X8ZgVWO25A5PKQlQJabvEtO9Ki9sHQ9iYpgZe+M24dieNWDwLcZYTmlA9fmScHKy
         YthvbdJf2gm9CYT4EsEXJvMXE6VSlWXH8aAVPDKZHWdpQnYKjuli1BNvHcM6VQyoIEXI
         bwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772183046; x=1772787846;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6tuAAL0hccaoJ70p4t8AHQ5c0nWXrbktNZU4+vC6LU=;
        b=FI+G5/l6AWGgJN2uAZDTeWNYpxNYu4C+aXrsCMtnIas5HHk3T408ko0jYh4rGBFMdx
         zIyGkudWUS3kWlDfZjr22akgfG69SwaKug4ZnCGVwpUxEn6oZJXDJDbLjtji0Yf5/jIE
         0IKJxgy3GQUD2FLQb8Ca0Bsbqy7tjxlwZLXiqf9wfrRepXn5AsF71sEtjUArimXO+xM6
         9v3EfdSD/c3vWfLXwfH5VWTvV5Jc/jXlT50+vDmwzRTBa9QXJudl2DA3uJGaAWApm+Wx
         568gFecjeWaQjWgfuuca5juchI8kFAm54GBNu72L5mMl0A/qNvKFUjcid1upvGMOopvr
         1oKg==
X-Forwarded-Encrypted: i=1; AJvYcCX38VALqI/zbsmutKiRavpUYvLw8V16qIgkhKKUX3eQWXlJ8uU2wd1p120+2hiPAaMoNks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuh6yaIj5UAJD7MLNy8HsH2FCToIls2mQ7EISf35p1l6yU6V3X
	dhj03bq1+oaOAL4SreOHvN/j35URgjF8C0FuGIcmqN5CFz/Vza9YEhWT
X-Gm-Gg: ATEYQzxu1q29nMs29kUeUfNd+L320FOQ8fOF1ef41n1f09LWflhvhXeuDEuZmeScDos
	iKnjBGZX7HNUADCWvISrMVoa9JN9sNY5XB0XADNOtUv+exffFEKa9dvVcbr8sQ6yL+PrW34xOTB
	oHYGpswMgSwjfyoWTqHdOuMCJhttKS6wU94uLdE6tGOGD5Zo71JdgpqiAqh0/AHPXBUvRCDHJMu
	5W5fnJLv+ATcTJwMXC5sGBFCsmx1df12PIfO46oq9aHZLcnUeq9VNfOnUMxV3Ksmg5r09Yqdjxp
	eTL+5nT8iKhrKjvtJ3Rg9TnF7HDQtNf5ebobNYRcIETIr9AEO0GZuiTrny25qNCv6JTEyDMMgl4
	oLqcooDu/teHlZThM0oanT3VUn8qFkkfK8pRONh5u0gZcwX7UzRmzLlfDmVZE2tWeGXg8ps8jLB
	Tbo4yfXN4I//no2L/3OlcX71IwUaRxmVUEbVPJ1p2JileIclMYmumqKuZwx+Uf5i6Ovcbadz2b2
	Zui6E//gMz3wnMs
X-Received: by 2002:a05:600c:6309:b0:47e:e87f:4bba with SMTP id 5b1f17b1804b1-483c9bc6164mr26975425e9.29.1772183045693;
        Fri, 27 Feb 2026 01:04:05 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7507adsm222721125e9.9.2026.02.27.01.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 01:04:05 -0800 (PST)
Message-ID: <3c4d4909-4eb1-47f4-b601-8f877a07ddd5@gmail.com>
Date: Fri, 27 Feb 2026 09:04:04 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 02/10] repo: add path keys to repo info
To: Eslam reda ragheb via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: eslam reda <eslam.reda.div@gmail.com>
References: <pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
 <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
 <6d5b9ff07566e1cc28a672cf1f47988e9c8c45da.1772140487.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <6d5b9ff07566e1cc28a672cf1f47988e9c8c45da.1772140487.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Eslam

On 26/02/2026 21:14, Eslam reda ragheb via GitGitGadget wrote:
> From: Eslam reda ragheb <eslam.reda.div@gmail.com>
> 
> Add a path category to git repo info with key-value pairs that
> mirror repository paths users commonly retrieve via rev-parse and
> git-path lookups.

I think that makes sense, I'm not sure about some of the paths though, 
see below.

> This makes scripting against repo metadata more direct and avoids
> shelling out to multiple commands for related paths.

You can get more than one path at a time from "git rev-parse" so I'm not 
sure what this is saying.

It would be helpful to include the tests and Documentation for the new 
keys in this patch.

> The new keys are introduced as explicit path.* entries in
> repo_info_fields and are resolved through dedicated helpers.
> 
> This keeps lookup behavior predictable and makes future path
> additions straightforward.
> 
> Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
> ---

> @@ -74,6 +197,20 @@ static const struct field repo_info_fields[] = {
>   	{ "layout.bare", get_layout_bare },
>   	{ "layout.shallow", get_layout_shallow },
>   	{ "object.format", get_object_format },
> +	{ "path.common-dir", get_path_common_dir },
> +	{ "path.config-file", get_path_config_file },
> +	{ "path.git-dir", get_path_git_dir },
> +	{ "path.git-prefix", get_path_git_prefix },

I'm not sure about calling this 'git-prefix', 'prefix' might be more 
appropriate as it is about prefixing paths in the worktree rather than 
the git_dir.

> +	{ "path.grafts-file", get_path_grafts_file },
> +	{ "path.hooks-directory", get_path_hooks_directory },
> +	{ "path.index-file", get_path_index_file },
> +	{ "path.logs-directory", get_path_logs_directory },

We're moving away from file based refs and reflogs so I'm not sure 
adding this, pick-refs-file or refs-directory is a good idea as we 
should not be encouraging people to access these files directly.

> +	{ "path.objects-directory", get_path_objects_directory },
> +	{ "path.packed-refs-file", get_path_packed_refs_file },
> +	{ "path.refs-directory", get_path_refs_directory },
> +	{ "path.shallow-file", get_path_shallow_file },
> +	{ "path.superproject-working-tree", get_path_superproject_working_tree },
> +	{ "path.toplevel", get_path_toplevel },

'path.toplevel' matches the git-rev-parse option but 'path.work-tree' 
might be more descriptive?

What happens if 'path.toplevel' is requested in a bare repository?

Thanks

Phillip

>   	{ "references.format", get_references_format },
>   };
>   

