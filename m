Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55761303A1C
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422951; cv=none; b=Br4e3AmdpAIpJFBw94xLVkUThZFrPKWRqdQJq+D+glQsxzl13emYzNozhpz4YlQZOVZTQMieSDArFLdGIDQ0MnjzgbEy2Zz660xLNbbxoRKloyyss2Y9/1SXVAyGWuBwMhbeXyWiYOr0E4tnLzHsb+klc9D9csymkaUte1km0EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422951; c=relaxed/simple;
	bh=cKJ5DzxfEFRjDex77hyog57Fb8BuG7hxaFyZcXLyotQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=akjcZhZFEsd3mD/srSCPKOFu6WDiBAQuR+GHTJJHN6B97PTLFKh6/+VvS9IweOz8j9fWcsv7HB1X9CI0peftyAcLqRmOzyBnFIaa0yJvvWmuw8GQe1TqR0tXEllGlkf6um3GX3tU5OOAjoeaTH9YZmUGYg0NwscE3VTBG/ptcGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUL4UAnj; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUL4UAnj"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-429bccca1e8so486080f8f.0
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 01:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762422946; x=1763027746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sq4cHGdQDUNs4wQCaCGYLu7auK6uRWYFe6vpF3BpfkY=;
        b=OUL4UAnj8Kyv8RF4cef9iOGnLhE3FAUCfSBparzCVhbzznS0QlIb+IjJEYOs6SEbLz
         iyd/1tAvW2qaPrJqdt1CEPS1hChkG7BgzKS0sYG5YbvkSQ3kbs36qyz6SsWWVsQ9/1/M
         fk5eS59OxPhvMyqVsFiSBXgJgnZUHYzdklSOnLhNKmlqomIYQ9bbm9pLYkmjnTEVHb0e
         cVyV1jEU1EOpEXOtRw2yS0e6uMbn/xrGL2jWVF4FhCLvu3lWkY2No+ayemn9Amf1he2W
         TjSN4KpJmof/TB7fuAxoUqK/hGdeW5SzHKKNO1V/tvPXaOaOpGCcQia3jEBjrxnJvH3F
         6ZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762422946; x=1763027746;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sq4cHGdQDUNs4wQCaCGYLu7auK6uRWYFe6vpF3BpfkY=;
        b=GPTR96fWa5QVvT28yfwYu9cQDXFTuiRvv0zdZdhSsaHTYocRJrFWaBPtj+oAwvTL+d
         uKP3gl2A27dlJmfCT3o+hhvj0Wdnj1U0Lcc5XzgR2RlLl1PY9VxM/9buha6gab1l1s7N
         fgm2taGUq6iwIqv+KfMefE7KWEn6fXzV9ZsD7AuSIjp5CBLtAmE4D0cQyuXENmtXEsxk
         y7DqRl+4YSZi45OyUZZ9Sa5582cLd+obcH9muude7CAZ1EHiRA+u7AIbQlIQ5qsdHUOQ
         iklfPgDUpaZ3MBbMgXhizwPWjAQZH5m81Wu6oXqPXBERTdKEnlPFw8oy/aSR9L6lFgiD
         gMWw==
X-Forwarded-Encrypted: i=1; AJvYcCWfuBEzEPfR+izvQ8mbEKiYAa3TOo4LKOXWB9R588x6EFpbqMrH1Rs9/VQMCjP4hD6O53k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrDQWR+NoTV0+XNrH2tj/6BOpv9utTauNCSFN+QCEEcDrprUfC
	Df5pjlMho9FqwTrqRZ9eQslPU8F+ktRkzzE/rXiwTLZwtg4/5EgHNE+Mo7C0sw==
X-Gm-Gg: ASbGncsSg5NEljLsHt5KkH1KGTfMsc66aGRpVPA5pNk7+PrPQM2F6u62EGHCuQJH8nH
	ukGGp0DryPrAvvn78jf4OJkOHki16w2wTRTSBGDhQdgmOjooBZJwLJzIDv4nS8uQV8UVULFHfvr
	XtUHb7VTRL8JJdjH0nLXY3bggaR7bG2z31c2A0KWfy5wKuSNjMNIcChTK7OUoda7uEMgyUbxOxw
	DMw9w687M06avAj6pzb2pQbrOpToj0XkvNRiZlfUPq0lhx0TKMQ2G33adi6RtFqim16YNBvJYxg
	BUYEu6FAO0I0zQbBJa6z3FLm62WmiMwL5tFOSWA6HPcJVOe3OHFainiwhYPXwEaSrPQc02+lRB4
	2Ubb8Xm5SU505YseJtnT+58fstG4VOMXb4G+I9QMbcsuHgf6rDVVopF4fdMq7FNv5sxdoj9MYnD
	YFxFDtEEXQMILoMOJeXnbF8EY0pmnwkXLcfYZP2tSPp1K5UvktfmHSW5U=
X-Google-Smtp-Source: AGHT+IEk9GOV5Nwek2PXMQe85ZiIJV+QnfsrxSSFfj60/08tQCf2VrrO4WZFOLg+dr3j5FGv4Mj3KQ==
X-Received: by 2002:a5d:5f50:0:b0:3ff:d5c5:6b0d with SMTP id ffacd0b85a97d-429e32c8238mr5277336f8f.4.1762422945492;
        Thu, 06 Nov 2025 01:55:45 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:7b5:6701:5a25:209b:be41:f23f? ([2a0a:ef40:7b5:6701:5a25:209b:be41:f23f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb410d43sm4046858f8f.12.2025.11.06.01.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 01:55:45 -0800 (PST)
Message-ID: <14496da7-3d9e-4e07-8893-0a5414fbbe70@gmail.com>
Date: Thu, 6 Nov 2025 09:55:42 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 02/10] xdiff: use ssize_t for dstart/dend, make them
 last in xdfile_t
Reply-To: phillip.wood@dunelm.org.uk
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
 <9197903add26e5b8af0bb2dd25bf115670e18e8c.1761776388.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <9197903add26e5b8af0bb2dd25bf115670e18e8c.1761776388.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ezekiel

On 29/10/2025 22:19, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> ssize_t is appropriate for dstart and dend because they both describe
> positive or negative offsets relative to a pointer.

This paragraph and the subject need updating to match the change from 
ssize_t to ptrdiff_t.

> A future patch will move these fields to a different struct. Moving
> them to the end of xdfile_t now, means the field order of xdfile_t will
> be disturbed less.

I'm not sure why that matters but I also don't object

Thanks

Phillip

> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>   xdiff/xtypes.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
> index f145abba3e..7c8c057bca 100644
> --- a/xdiff/xtypes.h
> +++ b/xdiff/xtypes.h
> @@ -47,10 +47,10 @@ typedef struct s_xrecord {
>   typedef struct s_xdfile {
>   	xrecord_t *recs;
>   	long nrec;
> -	long dstart, dend;
>   	bool *changed;
>   	long *rindex;
>   	long nreff;
> +	ptrdiff_t dstart, dend;
>   } xdfile_t;
>   
>   typedef struct s_xdfenv {

