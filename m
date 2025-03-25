Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D9978F24
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920118; cv=none; b=gUIpSl5Cs2Ujtk1o0mQF2ubDXXdM4xx2j+6rHybDmMkWPu4SCnmHZmWnRnBFLMB11DAm69NCde7xjA9jpJjZG73Ys3GfxJ1SEYKIxLEMHrJ/AKHe1kINcWjWVLcwP+IGBfybRPSFw8RE8rX0ya+S1cqlH/WwK6kcDXqXWa530pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920118; c=relaxed/simple;
	bh=DOJUufUSLK1ak6l1CEu9sarUKOIeq6ry6MkQDUO48rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Htc4G/Fhef2MbB2T1n51MHxg3O0LqrdE24o+g09pLE1c7NPHVYQlSNxznzKd4vk9mhPiR65VsCuBGcvHa5Zz7J6wyrPScHABwy51dwaBDtUzS+BYrPTUuMa9/Q3SwkvC/6epValv02UjijafFYbuz81/+6b5LbLwue3ovgveMJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeYeWweT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeYeWweT"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso39730685e9.0
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742920115; x=1743524915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4LVRuTdGFfrsFlLUWqwZaV1Lh6wnzwCyoAKv65gyazU=;
        b=XeYeWweTAA5++KfA+nLyWfU8c0HK52FOGtPj1fu6GVkILlKQkBuZjuHTfvA46xgNMZ
         7qx3nCvUwoLliirafQHwUAOszXvhE3Xx41azE1wwA/YLDRrmu0zW/6XJGnkSAuIA+XsH
         u3rnmSWvKP2OeKDEc6Bh7+I4d84/Y2QrC4P/6GwkIRSz64iaO16FMzTzTQ9Irx3tqSAD
         ErBthS3aunjgR52xa5GvHxeJBYt9seJa/mUjc169BUNWQ+XDedzW/WlGCRBhDF04pjLC
         UQHilmi9lr23aoOiaBuiwJXmFEcY4sJ2lea24CJrIl6dBJpD/BKVBPnrdjh/nJEKBvdx
         Xxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742920115; x=1743524915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4LVRuTdGFfrsFlLUWqwZaV1Lh6wnzwCyoAKv65gyazU=;
        b=uYXZJPdmP2EnKruWZD3F6AKAXpT0ozjvsh5F6URVYRnzxSwOchjsgzTy54lQRvWsp2
         MnnRlRp4BHbgBTp+3u7V96HdO2ATeTpxqJsDgYbkjsOnbfd/loEjmvNhiZNX25L3yl6G
         iJ+1660cTkPJBuNZbv4Ua/qVb2qaAKFBZkhOtaZTak/GG9RVtjPaxJ2rcFKTT/PZbF24
         JmZa/on7i1FfbDArc0Dl8RQEQN8mCbv1ICW1LGLD2RBNpb8VO8apcHaDWvRTZR7pKmBd
         /OdR4m1mRfMt1BYTrw/+cJQ2drXRGt/2AjGK8jBdnm1P8uspI9BXPLYfj8NOt1gTPmHS
         1hOg==
X-Forwarded-Encrypted: i=1; AJvYcCWjwSCfg2t3OAgNk/V202fecjMNRKuiBMWNl6dI62vgsD29KweCSfQx6yCoVa/SDGYlmSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVCDthrUYiBj2kx4yzbeSO9skCa2DNPc92SswXdqhUeNWEZ3gl
	VqipaQ6oOGjSqoe/tysvuX08DmA7LzWoEysy4P9/uZtLaN8i6KYG
X-Gm-Gg: ASbGncttQe1HH34EBmSL4tj9KcR1RUJZO/uLdcd9HCfxQidBUtcL3MRCwcVQ4J1IQW0
	cp8c+y/S5y/ZTpd6t0FpeJpzL0f33bB+0E1Gm13PFhTwrwgnX8D4OfgQqLVUj/Uc+n1jIdMAw9h
	pnr6zLYt2YzWKDJLVk5pdc66Oo24e9G0u8Tf/FaTMvfObVxfxPv+XPxkZKsMtlwEcSo6ey2Qvme
	63Vzy3dr6HHI+ADInVuemBSKLZNdiwGxHQKwJv2tDAJDkBREilJRqALPWryNF9ZfRHhU2jAs7I+
	E5y/DkbCuF2vyFftCd2qybBpr4VibZ/LEgdIsdpMFjlIojZjNz9uHCkzvJiY7lJRQVimlynY7gw
	zGqeBq6Iii3u/amnUiHrg
X-Google-Smtp-Source: AGHT+IHx2W0/nxzXkwJA/ONGibvHReprK024TTdLw6X/6MLwZAyCyo1u8h2eTzIBBcpNY4cTr2tfXA==
X-Received: by 2002:a05:600c:511c:b0:43c:fae1:5151 with SMTP id 5b1f17b1804b1-43d78607482mr56355e9.25.1742920114831;
        Tue, 25 Mar 2025 09:28:34 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd187fasm157246315e9.14.2025.03.25.09.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 09:28:33 -0700 (PDT)
Message-ID: <930b4c9a-826f-4124-a70b-e0400a3fea5b@gmail.com>
Date: Tue, 25 Mar 2025 16:28:32 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] remote-curl: avoid using the comma operator
 unnecessarily
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
 Karthik Nayak <karthik.188@gmail.com>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
 <e3069fd4564bac68bdaf2079151b9b921867e277.1742889711.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <e3069fd4564bac68bdaf2079151b9b921867e277.1742889711.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

On 25/03/2025 08:01, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The comma operator is a somewhat obscure C feature that is often used by
> mistake and can even cause unintentional code flow. Better use a
> semicolon instead.

clang's -Wcomma finds another instance in this file

@@ -1239,7 +1239,7 @@ static int fetch_git(struct discovery *heads,
  	packet_buf_flush(&preamble);

  	memset(&rpc, 0, sizeof(rpc));
-	rpc.service_name = "git-upload-pack",
+	rpc.service_name = "git-upload-pack";
  	rpc.gzip_request = 1;

  	err = rpc_service(&rpc, heads, args.v, &preamble, &rpc_result);

In fact it finds a surprising number in our code base. I was worried 
there would be a lot of false positives but so far all of the ones I've 
looked at would be better not using a ","

Best Wishes

Phillip

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   remote-curl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/remote-curl.c b/remote-curl.c
> index 1273507a96c..57b515b37e7 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -1401,7 +1401,7 @@ static int push_git(struct discovery *heads, int nr_spec, const char **specs)
>   	packet_buf_flush(&preamble);
>   
>   	memset(&rpc, 0, sizeof(rpc));
> -	rpc.service_name = "git-receive-pack",
> +	rpc.service_name = "git-receive-pack";
>   
>   	err = rpc_service(&rpc, heads, args.v, &preamble, &rpc_result);
>   	if (rpc_result.len)

