Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4845633B6FA
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770491543; cv=none; b=WT3NDZ4VAgTDaBlCkr/plnC9YN+eNdCiVmeeCE2JfmZJLCUjs9PJ7HewU00EEbUz6LgIY82tck7QqUl2ie2ZIq10fs2vtL9oO0/30U5sEbXUVgkPVqR4imkEknjf1qOEruxtd002s+O8UR3ZVeCu0xu3aTJ0cZ0gbPQ9PgFPWmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770491543; c=relaxed/simple;
	bh=kQVQksnrr5tWMRSC4bUQuR50PHVM0/KjXD02WvbHFZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqLeJel/3rpcD9ukxOilbS+HmUFLVUO65aqQ4R6zxJMsUHnIYIm4W6N8xVXRu/4GJpMxJhyYQYy7Kot03roKKgfG9+fX/uNnTfnpXtntUyuWokN3wnCvoK3mWVXEzqTRzXT4RFwwIZ8onAo64ZX6IbyjXD4bPd89OANVMfFmrOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GV/HL0YX; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GV/HL0YX"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-81e931923b5so476114b3a.1
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 11:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770491542; x=1771096342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=12TcyZNscYYNJSh6Q6Qu8vSvx/bAIOlGFkAmOeD6WxM=;
        b=GV/HL0YXl0ZgIFl49TJQWMIi7022PciXTx7Eb3dIkb4C2XI0ZSGbbn16rANhFuWcXt
         MYFbhQpa+UAD62Iew245QS3I8vAfzA3141fggSZT70tSSEASu2fw5038LoEDzD31Pb7Q
         grqeWXsIbN/SvBx50mxbCjuhEQ4XB8cOTB1K2x7T0ke8kZZ8Yux8UQ8HVJVXD4yS+UZU
         tVkBsI5ZpfPKB8DF8nkGOZssMjtsW89AaP6PqWtZSL27PNxq5cEaJyJdT49ZVDOVOwo+
         vC+WtrjGCDxIREBiXubuzRZh6mddKQ7guQv8esbyTDs+r5515kmrnHfk6vDbwUNYl+pe
         BZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770491542; x=1771096342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12TcyZNscYYNJSh6Q6Qu8vSvx/bAIOlGFkAmOeD6WxM=;
        b=Dc6IGINt0WpM2FykRtoVA5jjM5oyHx4fwrKG37teEPBziJYiVFUgnCzO66QCcinw9S
         ZvJwiPvUh4lEULA7iKjjOJ8fQ8xmUdBndHFgF069yTS4CzZlPwGZYxviiw/X5NtZ7OzF
         tgv7MYXuPjpToxHcTSOy3YqHoBg+XTIoGqxfXuBrGB1HJJ/7mrXi5QXorGzV9ZoOLYR5
         6MAtpqrOC904dW4s21dh96qo2FBCCI/g+kJ7oZRzl37/enyWz7PNXB7ubiu1cRIr35gM
         TgnsHNfM6mS89pXgMD26Hs+ECJMmlkeHdrQfZmCvlpfaBSltjczFcLdmTYF9y2vXqxRp
         b13g==
X-Forwarded-Encrypted: i=1; AJvYcCWG1GDfA5GPTZyF8BQmiBBIOne3b3jfKSLNNND0iOUWjhQYhMuvJ+BVLBhSMoX9midqZAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws9FHUIk+c8DqlAtQLq2pLy3B3P4ff/2W5uKKhsiM8rRy8+TH7
	HG+wbfc+RVFaAqrG0B6DfZgGi/GIs8MHFUxkfKBCOxz9+KCe9aSqOFia
X-Gm-Gg: AZuq6aJaRFlnrBgBAhqpdPHdN1X3x9MhlvhMdjAawl1fs8if7j2jGY2aJQXOZESRY/9
	t56MxTw4iAplQ5htUnerbu1VEpTC260VbdMAnr/vQUm7136a2uprbj6XPjw6OBMyEPO4vgTWDDl
	R7QSgpTnyKQVAaoPiEZKTiDGwf0qyemTr+G7nrZM2ptOcYeYiZj8qUoPSohGMmGZ3s+DO7xVhEF
	6Ka0KwCsrnca/6QvLvprwVyaNn1TCCiIKvLzh4V5L0Cr9b+WfucEjoW3XE5m2CEjLY6HIz25L7B
	LLTvXU/i7Omv5Yu/WhxgVd6gz3NyBMFGqga22BzK23C7XvE6Sr6wr7SGmNC30IyUa2eIVySp9bJ
	Y6PkZEUeMgZoAadaAv1oWoIGVAJ0s3e+qW5YuMei/Qo5rATHFHiLeOHGDMwNarktsAyUEiFHB+F
	Wp+lis4wa11tXGvbs=
X-Received: by 2002:a05:6a00:39a3:b0:823:1077:2e88 with SMTP id d2e1a72fcca58-824417246fcmr4435356b3a.6.1770491542214;
        Sat, 07 Feb 2026 11:12:22 -0800 (PST)
Received: from [192.168.0.107] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82457ef1000sm2284619b3a.34.2026.02.07.11.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 11:12:21 -0800 (PST)
Message-ID: <cc2f400e-49c2-4de0-9c51-9a5c0294735e@gmail.com>
Date: Sun, 8 Feb 2026 03:12:16 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC][GSoC][PATCH] attr: use local repository state in
 read_attr
To: Ayush Jha <kumarayushjha123@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>,
 Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
References: <20260207114007.40-1-kumarayushjha123@gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <20260207114007.40-1-kumarayushjha123@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/7/26 19:40, Ayush Jha wrote:
> read_attr() currently relies on is_bare_repository(), which
> implicitly depends on the global the_repository.
> 
> As attr.c is a reusable library component used by multiple
> commands, this prevents correct behavior when operating on
> secondary repositories (e.g. submodules or in-process repos)
> whose bareness may differ from the_repository.
> 
> Update read_attr() to determine bareness using the repository
> associated with istate->repo, based on repository configuration
> and worktree presence, instead of relying on global state.
> 
> No functional change is intended for the primary repository case.
> 
> Signed-off-by: Ayush Jha <kumarayushjha123@gmail.com>
> ---
>   attr.c | 36 ++++++++++++++++++++++--------------
>   1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/attr.c b/attr.c
> index 4999b7e09d..f2d25b1863 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -848,21 +848,29 @@ static struct attr_stack *read_attr(struct index_state *istate,
>   		res = read_attr_from_index(istate, path, flags);
>   	} else if (tree_oid) {
>   		res = read_attr_from_blob(istate, tree_oid, path, flags);
> -	} else if (!is_bare_repository()) {
> -		if (direction == GIT_ATTR_CHECKOUT) {
> -			res = read_attr_from_index(istate, path, flags);
> -			if (!res)
> -				res = read_attr_from_file(path, flags);
> -		} else if (direction == GIT_ATTR_CHECKIN) {
> -			res = read_attr_from_file(path, flags);
> -			if (!res)
> -				/*
> -				 * There is no checked out .gitattributes file
> -				 * there, but we might have it in the index.
> -				 * We allow operation in a sparsely checked out
> -				 * work tree, so read from it.
> -				 */
> +	} else {
> +		int is_bare;
> +		int is_bare_cfg = -1;
> +
> +		repo_config_get_bool(istate->repo, "core.bare", &is_bare_cfg);
> +		is_bare = is_bare_cfg && !repo_get_work_tree(istate->repo);
> +
> +		if (!is_bare) {
> +			if (direction == GIT_ATTR_CHECKOUT) {
>   				res = read_attr_from_index(istate, path, flags);
> +				if (!res)
> +					res = read_attr_from_file(path, flags);
> +			} else if (direction == GIT_ATTR_CHECKIN) {
> +				res = read_attr_from_file(path, flags);
> +				if (!res)
> +					/*
> +					 * There is no checked out .gitattributes file
> +					 * there, but we might have it in the index.
> +					 * We allow operation in a sparsely checked out
> +					 * work tree, so read from it.
> +					 */
> +					res = read_attr_from_index(istate, path, flags);
> +			}
>   		}
>   	}
>   

Hi Ayush,

I'm new to the community ;)

Initially, the concern that replacing 'is_bare_repository' with 
'repo_config_get_bool()' inside 'read_attr()' might introduce a 
performance regression came to my mind immediately. To verify this, I 
ran a benchmark using hyperfine, and the script was like:

 >#!/bin/bash
 >mkdir -p perf-test && cd perf-test
 >git init
 >
 >git config user.email "malon7782@yahoo.com"
 >git config user.name "ILOVEGIT"
 >
 >for i in {1..10000}; do
 >	echo "content" > "file_$i.txt"
 >done
 >
 >git add .
 >git commit -m "initial commit"
 >
 >echo "* test=auto" > .gitattributes
 >git add .gitattributes
 >git commit -m "add attr"

Then

 >'git ls-files > files_list.txt'

( I wrote it this way primarily because I didn't anticipate that too 
many files would return a 126 error code. So I improvised my switching 
to reading from standard input:/

It didn't result in a noticeable performance difference (Even if the 
number of loop was increased to 300000). Then I started to create a 
stricter benchmark environment to defeat the attribute stack caching:


 >mkdir -p dir_A dir_B
 >
 >echo "* text=auto" > dir_A/.gitattributes
 >echo "* text=auto" > dir_B/.gitattributes
 >
 >for i in {1..5000}; do
 >    echo "dir_A/file"
 >    echo "dir_B/file"
 >done > thrashing_list.txt

Still, no difference in performance. Has anyone else conducted any 
similar performance test? Were the results the same as mine? Is it 
normal, or there is something wrong with my test?

Regards,

Yuchen
