Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F3C34253B
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 03:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774150058; cv=none; b=fgM04JYKgqBwVvQ7hCrbZlycjMn1EF5/YkC7b3Zx7QPefNnA/wvt0ly2dmTdW+rlVzNyX/kXI0F0XCMrTsHMPijaPpk0LJwvBstxx4PNagIoVsYN4XARj66hWC9or9xNAQmtSj69FL7FEzOvOQKEnPx5ZgyHzPnxuV42RVavSHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774150058; c=relaxed/simple;
	bh=VsoO656RzBzVOuFvlCd1grI16SShp8kZ0ZpOhxSKtwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7Ucj7IY+cgy6+K9e5i4WjgbIj3gdXRm1OdAXVm9WcgElwX+MOU1nJhQczBh2L/xLPNEJuf9N8BjudokJErj9I5llV/OEBzgK837vqDPzjnUKX+fP+Z/7QPjLP7q1+nPor3xaW8t4mZlfYpYtn8M6zFSqSmWM1R0b34NxB2NViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmjFu33+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmjFu33+"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ab1c8fdc40so4866205ad.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2026 20:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774150057; x=1774754857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W8jAti1FtMv8jXaNYjG9VqjTW9z24wfKC96n3yEF+h4=;
        b=GmjFu33+TOWsizz23qun9KyoT/aVWmMCZykCxosjHfxHH9UoQOe1tK6YaXmFj3IXCp
         u3bKql6MCZnFiLGx/DQyXa92fzcYdtfLkWEv0E/LQb9i3j/ZYHmmWS6WctRZT9RCy4S2
         P/NkUd3msZURubrOrMi/BVRiNGEO6+RJElHTaKhH6GVSoXO58lml9aFDpT5kI0Lrgjsx
         qW6ePWGvYzzV1GhLHErLZPJb7rLppK/7HX3xGyTz8sOfsmrRduPGn7nyRkIfrN3jGOBa
         QEQq7LxiftDLOiSNxPCaMk6IieVX6/tKkuEiShYfvhZf3PhNd5hWByKp1mHeInw7bQwp
         RRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774150057; x=1774754857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W8jAti1FtMv8jXaNYjG9VqjTW9z24wfKC96n3yEF+h4=;
        b=dWEAcjMgptNv9suI4qRJ5ZR6t7AbYjRXujSFqk293tR87pqzLevuyNK6XrELImK3XH
         1jlaEL/3VXXYhsnoQ7dMtchHKVWbXotmhfdUnbgAxUyXcg6v6Hx3dAQb9u94inyqAIAh
         CnEL5CjydIDkPkiT1fl0/RET97rNMfuiI1Sq9cYgk0e3OK0JNrauOULaxu/0DVl1euG+
         DkDoYGD1sJXPhluftNCLhz80TaLB5YPBdDOxhQu/C/kJ8JJi+q+cTuVN+QFfFSbX1YzK
         ejBF2XKAdvjuFdo445/m+rSLU5HCP3DWK/3jCNZ8HI5wyF5GaxsiUd2z0tuFarSVDXIP
         cIMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWx0DWtidS8hEf2WC/Wa4sPQSES2kZjAne3UsXHII9J/Wmh1MxOuzXJIimbKRqntgTzqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUDnv/Beopv1O6smx9GOsx9H+2XcBehfDY7ECLWkXMxYuhH+xh
	FNAcOVjHOctSk4n2H8ha7z6V8wE5qJwhAl1e4yfT8jaDwM396GBftOD1
X-Gm-Gg: ATEYQzwtn/DsXe9gRsvHii+2wUx/Q1QWtuyjwXCLnPJIwLh5zd6OgEqcAs3NK5WLVZe
	w/KSmqzlXGNPRuTb8qnb+qcJ3i3NKlBExrrsug2ghpLUfk4ih+lmL8ZxOoNU9/dNtVaun6egMW6
	v+stPEuDHLrT6yAq5fpD1vyTYlUBSkGTTJsH12DrjtX3QIkSZ0rHkFoRXY2/mP92DeyoxcHIkld
	kOCA92YiKtIvk7Nb/ycJq1EnY4PZrSWB+RUskCdiRTfxlAX5/954QQrGUbCruYH2LewYY+9Djho
	MxYuevWiHxWomywgbxYe/FDykRsCeS3NeSz/YereTUqLWsptdIXwRrzb5M/iqGUW1tyu7QypJv+
	8R+WLpm7YiPrUa+B41YCph9xhE5FZ/rSpfD9RpZ2dBG1QWxPoovtFFgE4gQEWBsZ8GyOJbkI+nJ
	NTJmm103MSamyrGClHdkR0W3dpbZgLE2gE+6q3LOt8r7NTJRA1MFeFptYQTbBzD9KpVSOs48IS9
	AZ/+iY/0+0=
X-Received: by 2002:a17:902:c410:b0:2ae:5d79:a163 with SMTP id d9443c01a7336-2b0827e3cffmr55590635ad.5.1774150056918;
        Sat, 21 Mar 2026 20:27:36 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835298acsm68472955ad.22.2026.03.21.20.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 20:27:36 -0700 (PDT)
Message-ID: <90c5b9a9-b77b-43ad-9c04-a0addc058aa8@gmail.com>
Date: Sun, 22 Mar 2026 11:27:32 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] repo: add paths.git_dir repo info key
Content-Language: en-US
To: Jayesh Daga via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Justin Tobler
 <jltobler@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>,
 Jayesh Daga <jayeshdaga99@gmail.com>
References: <pull.2242.git.git.1773766519857.gitgitgadget@gmail.com>
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <pull.2242.git.git.1773766519857.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jayesh,

On 3/18/26 00:55, Jayesh Daga via GitGitGadget wrote:
> From: jayesh0104 <jayeshdaga99@gmail.com>
> 
> Introduce a new repo info key `paths.git_dir` to expose the
> repository's gitdir path, equivalent to `git rev-parse --git-dir`.

Here you promise in the commit message that paths.git_dir and git 
rev-parse --git-dir are equivalent...

> > This improves consistency and allows tools to retrieve the gitdir
> path without invoking external commands.
> 
> The implementation adds support in repo.c and integrates it into
> the repo info reporting mechanism. Documentation is updated to
> describe the new key, and tests are added to verify that the value
> matches the output of `git rev-parse --git-dir`.
> 
> Signed-off-by: jayesh0104 <jayeshdaga99@gmail.com>
> ---
>      repo: add paths.git_dir to 'git repo info'
>      
>      Teach git repo info a new key, paths.git_dir, which reports the
>      repository’s gitdir path (equivalent to git rev-parse --git-dir).
>      
>      Documentation and tests are included.
>      
>      Tests:
>      
>       * make test T=t1900-repo-info.sh
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2242%2Fjayesh0104%2Fmaster-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2242/jayesh0104/master-v1
> Pull-Request: https://github.com/git/git/pull/2242
> 
>   Documentation/git-repo.adoc |  5 +++++
>   builtin/repo.c              |  7 +++++++
>   t/t1900-repo-info.sh        | 10 ++++++++++
>   3 files changed, 22 insertions(+)
> 
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index 42262c1983..d17d911ec6 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -95,6 +95,11 @@ In order to obtain a set of values from `git repo info`, you should provide
>   the keys that identify them. Here's a list of the available keys and the
>   values that they return:
>   
> +`paths.git_dir`::
> +	The path to the Git directory for the repository (equivalent to
> +	`git rev-parse --git-dir`).
> +
> +
>   `layout.bare`::
>   	`true` if this is a bare repository, otherwise `false`.
>   
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 55f9b9095c..3067107cad 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -66,11 +66,18 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
>   	return 0;
>   }
>  

...

> +static int get_paths_git_dir(struct repository *repo, struct strbuf *buf)
> +{
> +	strbuf_addstr(buf, repo_get_git_dir(repo));
> +	return 0;
> +}
> +

...But your implementation here doesn't quite feel right. Check the 
git-rev-parse documentation: the output of the --git-dir argument is 
context-aware and depends on your current directory.

If you are in the root directory of the repository, it gives '.git'; And 
if you are in some subdirectory of the repository , it gives 
'/home/user/.../repo-root/.../.git'. I don't think simply calling 
'repo_get_git_dir(repo)' will achieve this functionality.

>   /* repo_info_field keys must be in lexicographical order */
>   static const struct repo_info_field repo_info_field[] = {
>   	{ "layout.bare", get_layout_bare },
>   	{ "layout.shallow", get_layout_shallow },
>   	{ "object.format", get_object_format },
> +	{ "paths.git_dir", get_paths_git_dir },
>   	{ "references.format", get_references_format },
>   };
>   
> diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
> index a9eb07abe8..63be0849c4 100755
> --- a/t/t1900-repo-info.sh
> +++ b/t/t1900-repo-info.sh
> @@ -149,4 +149,14 @@ test_expect_success 'git repo info --keys uses lines as its default output forma
>   	test_cmp expect actual
>   '
>   

...

> +test_expect_success 'paths.git_dir matches rev-parse --git-dir' '
> +	git init repo &&
> +	(
> +		cd repo &&
> +		git repo info paths.git_dir >actual &&
> +		echo "paths.git_dir=$(git rev-parse --git-dir)" >expect &&
> +		test_cmp expect actual
> +	)
> +'
> +
>   test_done

And you’ve only provided tests for the root directory here, which I 
don’t think is sufficient. That said, considering that you’ve likely 
misunderstood how to use the --git-dir parameter, this is understandable.

Next time you create a similar patch, I think you should take a close 
look at the documentation and source code first, and try using the 
existing commands a few times on your own to understand how they work, 
right? ;)

Regards,

Yuchen

