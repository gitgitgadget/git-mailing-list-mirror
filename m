Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627721EB33
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 22:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709679330; cv=none; b=nq+Nxbsf0RUR7/3tRj/fValhVHpTQqn/aua8xEygOi8Y1MLfTCYgVozFyWAh5kAZCO/haG0N6G/ODZoLk6xH/IT8JYJgDKH1qavrw518pIpX935JrKu0i1vTDt8NlxFZlXJaYRKU3RC4VBX6BEUnMxRL2CIXeWHaO8G1Nc46+dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709679330; c=relaxed/simple;
	bh=O4nC7waD35aPjqBSgSXoR/z6YZRZzIKaea10v/oBvFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmY6zf7C97IF36k0Io6QXymUEDWpI+ZGG3wYYcxQfYEfCNTDZ3WFMWoaNh7jUd6wBHGh4YJTpLDIlMO2/h1/cdQa3D3GvJWzZcZrNwzHit1XeENjjaI5X/EtrqLgx+i1ZXdJpteT1kk5iIkGGXzW/LCcvBmF5b8PCYQSzY9Wrkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNsUR131; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNsUR131"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412eddd165eso7309025e9.1
        for <git@vger.kernel.org>; Tue, 05 Mar 2024 14:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709679326; x=1710284126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q/y2vzhNyoFwILLTybls0XeAbgYXS3Ngayv7nFNyKcc=;
        b=kNsUR1310lbSQp8v6NCPTNgSMQy7aC6DZHKh+/vE8JnFbEP8zXkYyOuo9ZvLlMbJy4
         M+I/CoKHpkwCNeX3qNsdmOt6j9gh8vFP03+Xs3m9m6IkoiPyEEt5EWGByVRVolpOcFPb
         5lA1izm+jEFwHe5+Hmrbw+PEmhzWH/1lnxOhpDAizg731tcdf5EpTkQEqvyq0d1HZG80
         LmFwZxtN5G9JMxGsba/DYDncVPMwug/4aZcghzLrHBNOPgrVncKFteQQzVBEPIywP/RH
         UIgfGeWNFblw41/lBoIqbwzkwTjM4w6vJTTXlkwLKTbpOO0KW9G3R2AAk33PHZzrpSjn
         UJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709679326; x=1710284126;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/y2vzhNyoFwILLTybls0XeAbgYXS3Ngayv7nFNyKcc=;
        b=CM9/Msw2htHa0VvrlBDJlKH7Ztagn5mGjM8Vl8f+bKWU0YBsdygixszVX7yL6IeOi+
         O+atWPC0CKhZzstghJuhN98vM+8ywjoipNWUz47/pSQpPa3O+r5AZT4Z2AxmC8VDqYyA
         yhjYslbfC2f2wBC+4ZyxGXW0zY9ierMkQ9Tr719aF6Qkvf95CmgS819FXklqfkEo4vSt
         K/l0fcwh6zj8OUHfoQaVkWTUrC6Hqq5mSRD0rR24kt+n8gpK8JW8YvN49r2UXlz2UtFf
         iOqYoReXdjia9yC9eG2MYYcQvLPYGyi/KO1ckAflPkRaKAcTntSoWBkBHW5dyj2mBiZV
         9FzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpgFsEP2DP7pLTsrrFsSzowxV7pBCbkUX0/HfzsvKjwVBd06jLexqM06JGO0cT5e1CfzcEIoxJThJ2Qu/Dy+swpmtf
X-Gm-Message-State: AOJu0YzLQJExRsxTIaMFhut0EcM2bmQqYn7pcQVi3n86CnblT+vYOPch
	PS5iwx33EMq+TKLwAaOxX4qCBQmrmLgwoVJMx2DuK4THhsVMrAkHpDdRm+7W
X-Google-Smtp-Source: AGHT+IFGP47OoOWzI3Oae0JGzIdN5OLKcq7hsrMkWJlsTpHJJvnP+eCQaU6WDAB4iEEchDhnT06/oA==
X-Received: by 2002:a05:600c:468a:b0:412:bcc9:32dc with SMTP id p10-20020a05600c468a00b00412bcc932dcmr10762360wmo.31.1709679326616;
        Tue, 05 Mar 2024 14:55:26 -0800 (PST)
Received: from gmail.com (59.red-88-14-210.dynamicip.rima-tde.net. [88.14.210.59])
        by smtp.gmail.com with ESMTPSA id h8-20020a056000000800b0033d2ae84fafsm12637842wrx.52.2024.03.05.14.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 14:55:26 -0800 (PST)
Message-ID: <18dc05ee-d0fe-4de0-87fa-256816125489@gmail.com>
Date: Tue, 5 Mar 2024 23:55:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/22] git-quiltimport: avoid an unnecessary subshell
Content-Language: en-US
To: Beat Bolli <bb@drbeat.li>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Beat Bolli <dev+git@drbeat.li>
References: <20240305212533.12947-1-dev+git@drbeat.li>
 <20240305212533.12947-23-dev+git@drbeat.li>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <20240305212533.12947-23-dev+git@drbeat.li>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, Mar 05, 2024 at 10:25:20PM +0100, Beat Bolli wrote:
> Merge multiple sed and "grep | awk" invocations, finally use "sort -u"
> instead of "sort | uniq".
> 
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  contrib/coverage-diff.sh | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/contrib/coverage-diff.sh b/contrib/coverage-diff.sh
> index 4ec419f90048..6ce9603568ef 100755
> --- a/contrib/coverage-diff.sh
> +++ b/contrib/coverage-diff.sh
> @@ -74,8 +74,7 @@ do
>  	sort >uncovered_lines.txt
>  
>  	comm -12 uncovered_lines.txt new_lines.txt |
> -	sed -e 's/$/\)/' |
> -	sed -e 's/^/ /' >uncovered_new_lines.txt
> +	sed -e 's/$/\)/' -e 's/^/ /' >uncovered_new_lines.txt
>  
>  	grep -q '[^[:space:]]' <uncovered_new_lines.txt &&
>  	echo $file >>coverage-data.txt &&
> @@ -91,11 +90,7 @@ cat coverage-data.txt
>  
>  echo "Commits introducing uncovered code:"
>  
> -commit_list=$(cat coverage-data.txt |
> -	grep -E '^[0-9a-f]{7,} ' |
> -	awk '{print $1;}' |
> -	sort |
> -	uniq)
> +commit_list=$(awk '/^[0-9a-f]{7,}/ { print $1 }' coverage-data.txt | sort -u)

OK.  Not worth a re-roll of course, but perhaps some wrapping would be
welcomed here.

>  
>  (
>  	for commit in $commit_list
> -- 
> 2.44.0
> 
