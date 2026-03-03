Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1D9381B1C
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 18:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561457; cv=none; b=i/mZ9fN4jpytuNWeNaoBNuhk947uaim/MAcgtgyZQ4XISlUDFi3esHYbrxHguDYP3vInkCS6SHkLZbyveJVQ3E/kovVV0ftd+ZIYKT9v+k9I9dCbJorjw5qTvaebWPgWLWo2J+IgvObQNgg3SBOGlZEPAY9xF5S+O8zZspDxk3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561457; c=relaxed/simple;
	bh=Wwh3j5meUxe1NKrOiWTAcEolGXLaiewzm3DJkdHJAzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mTL7ofTURCjxSAGR9U/XSst5wW/bqK7a8zUPK+7rf8JJTIcDGDz/zns6WgZMrxfnu0Gt22hnIZpTtNqAqQSXVvQt30nxflsidDLFJKiO+2ReLf3LJ1OWBf8uHvYq43iC/0AzBoq2ds41BLdlXyVqziuuOkADfZ5bbnglA01gsXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6fVOlZU; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6fVOlZU"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89a14be4733so4545216d6.2
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 10:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772561455; x=1773166255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x5mqPsbRC/uE+coCMik3nCC2menPwkxxv3G9+lufxiU=;
        b=O6fVOlZU7S+nT/Cw8YYX3MLj4BCIxzj9gK/Oj95lSkPHrOosFg53Q6Zxx0pX9xgOPC
         5CEZQxkK1VojdLtVu5Vogv5lfibmNkpCLU7EgXWoBUPEPO+ANMYGEwza57Qf6610WMm4
         0q2yjD3o88qh55r/3CveRIq57lFSYXjQz9gJrecaSXkViCr803cLKIfM7Kn2ucua3jfR
         /K0Usuf+3/qUpGk6gnc49RZClFJeFTvrxW+jdPINHycCofh8GWmGFxx4wW/qHw9djjDG
         4CCGF/sKFTjjyg0XDeLcNxhht2Pdd8nnWwSKaBCsaL9umaWVEMe8jezhOsCuI5gJ8JR/
         8DvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772561455; x=1773166255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x5mqPsbRC/uE+coCMik3nCC2menPwkxxv3G9+lufxiU=;
        b=PxSYhuPdRsjxFccjSRcUzOivVQqe2RgkyojhyrGMLvD/sS/2DEehTa2SY2vxZXjUhK
         zfRcv6bB+Y4nTys46X6xWUQuTREj/vAYk0R/XXE3bk4Q6CZ9Xg9x5Hjgk+0ssgsQl5SU
         NSdNtdF8CWyusITKUIOEQ7fjT+S6oV+a4Rns7Sdh0ZO+m5a83/CbJVJOqA7ZhwGzf1hy
         mcLQB1dNUVEAjBbDZLEvRd+vUbiTDB5Uc+nYOdcoST0LX2kYxdve/dTq/3/toYqs/XZn
         fex3p7NysvqXfzeNVBfV8J4adNCXg0jZgMTYrNwcScLDKu73evAEXrQxVnI+xJm5Vqzd
         u3NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEK+/BE/tE9EBmhKBX6LrsBAe3DjJ9RnW/mLjNW1n6No+39Q/sBikRsHMZfk45A4s8Z5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuIuQ0OCF7rOx578DNp50yPoLJxbNCDKDcCayQLpA2SiGViqdP
	uS04/FFrTiYSyzDjdXyoJy62tMsP/6CojeozO3j+mMBbuXhEI8bJLi89npb2bA==
X-Gm-Gg: ATEYQzxAxKU0Uyx3OEugUALqtdBukP5d3YWtOh3WS3Z2GcasUdJJkgewYqL27llaDWx
	1CH/uXC6CIBvS2fv7D4PufmNlTSF430Xuzphkjnk+t+hvRBKimjaB1/DlwWbINXNyi3dQVfkv7o
	qrepNBTalT5KgX5h9fw5ZpX7V/7pjftyFD/OnRCBJz5XNEIeywlq1Y8g2xZKkWABcB3AEt+ZY7V
	y/oTYCwKX9mUbx4DFM+rd/ELCGsCVK4UaE9UotBQC/BXiYE95AhghCqnwkiqJaKMIF7GTUQah+u
	6KMC0+MvEKPK9Q9FK3tPDed/pivPQR6Hz41KLCUbSt9GBHXpRJcVZZMIHE1DbXHsC82cSIg9FRv
	eKQ6Ya3RBzGHDlg+kQeUNoZ+s+6nbxJZGos8w473K7N0m9NemnOXFtmTHYibLrxQSROG0bI//iz
	RZNzt+yXlo+/da1OH7CoDT9+Km/IdryqY+Xh48TTrJpN4Zoaw6SRvMPT/7dprDlALaQYsGNA==
X-Received: by 2002:a05:6214:18e8:b0:899:e979:515a with SMTP id 6a1803df08f44-899e9795dd3mr111088906d6.49.1772561455142;
        Tue, 03 Mar 2026 10:10:55 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899fdf30e99sm46148476d6.3.2026.03.03.10.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 10:10:54 -0800 (PST)
Message-ID: <5526480d-ae9e-45e4-b8d2-c853e01af296@gmail.com>
Date: Tue, 3 Mar 2026 13:10:54 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Mar 2026, #01)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqbjh5fvsn.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqbjh5fvsn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/2026 10:15 PM, Junio C Hamano wrote:

> * ds/for-each-repo-w-worktree (2026-03-02) 4 commits
>  - for-each-repo: simplify passing of parameters
>  - for-each-repo: work correctly in a worktree
>  - run-command: extract clear_local_repo_env helper
>  - for-each-repo: test outside of repo context
> 
>  "git for-each-repo" started from a secondary worktree did not work
>  as expected, which has been corrected.
> 
>  Will merge to 'next'?
>  source: <pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>

I just posted v4 with some final polish [1].

[1] https://lore.kernel.org/git/pull.2056.v4.git.1772559114.gitgitgadget@gmail.com/

Thanks,
-Stolee

