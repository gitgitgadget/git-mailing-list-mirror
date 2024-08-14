Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD3919F
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 05:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723612677; cv=none; b=qAdZ51wYqlhLBHxa3FWcFyzpfBPKkkLVInssgFQhVjy0trYQLQAVjMEkAcFOQY752DbbGPnasu6jgxRIZx+iWPb5OEGDElWV6WcgOlCimUQrxRX0DGHcxG17ASMG791Nw/Q+OfdudcET6EgD23TGPHI1nFhy8hZHhFwyVYwICoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723612677; c=relaxed/simple;
	bh=QS40m/JPmi93NcZDVhCIcnMwIh1neR/zG68eluSCgpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVn6VM9NCll9umEeXrMc7tcQT9HkbNTZCAC/P3D3CmoWmEHa8jV0JMo53/n9kdLvfi9pYwf0BVZEaOKaB87iL1wghpfrtybt8BxpQnLg17Yt3v/S94bj2Athc+shOqqpTyQLWV5RRvdJxb2IsdyRh5A8gyh+tWUJmAGVlGYK5SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6Cbf4cW; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6Cbf4cW"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70eae5896bcso5575731b3a.2
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 22:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723612676; x=1724217476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0KVxgCzBAzd00xk3aLEgeCkfM3XyiB8PA3fAjFlZvYs=;
        b=S6Cbf4cW41eQYkP0o0tx8Becw/uh3OvRurj/imvINZ5DFK19suaBPsRwDGGAerFdh6
         S3susS0bU93A6919ZquBHpqwPsUcI9TR1yPs8ocFT/fDwzRrZuYX2ILVfvlbhjLjiB6l
         3+4gF+xKdeH1xohaEns4mBqySGd3+48vrlfMlKjRudzBVpq9YwCel1PjOly1h4CIYa2V
         +d+/6Z7EIwtKRspMFFZg5e5lIs1bEZ6KV6sRVFB8MO2PAxC3aIbedMSmm7FlqINDe/a8
         dkUMtzEQs/5gAJgf8eMWw+oGPaijQkudKfOBLZX4vreSyCZW+yVn2OV5tdGj3oObgUmb
         m3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723612676; x=1724217476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0KVxgCzBAzd00xk3aLEgeCkfM3XyiB8PA3fAjFlZvYs=;
        b=jUC0FllTUZGD0dCO9nCVtwjTKa4bzAwk+BZDymxdDfRbHz2SOYF5zJ7iQebY4oubsh
         EyF1l+0torYcNlghRSJlvoahlQGNi41TR0YgYHvbryvbZ285T79Vf4hvbq+H6Tm7lAt+
         SmdrG7L28lkaMupJkKHGKdqHAEs/SCMdWe2VkeD4tz8iude2m98Uf8NbO43VXU3eIEhz
         XdtiX6lLyZjx2Uu3IvhBrdV0AhfRi/Chw37Fi9W2PhRwR61tltJ5Kkp07mTIWUYeBugN
         /L6fjnZK2trHlwUL16ez+yXngzn+413CvzQtQbRMWiy++UNurfVcwwNbMeNlpOoEKVKc
         OKig==
X-Forwarded-Encrypted: i=1; AJvYcCWW3cfWO+K86QGZzPhwDVTAOONj7VoaqMQPKCnSQ1ZA3IkH4n3MxppXLPPy8+gu/PLy/2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfmPWrlByQZfGW9goRj5gLpGM4gaU3hfK/WCBzMqx/yb0s87CJ
	T2nvVYT3yoz0U8TdrlUuulZIW/8kBzFxtphwgSTXN+KHV4DYKDYEqaDXQA==
X-Google-Smtp-Source: AGHT+IGsC00hxqUGmr/HQI+2TH/sl4QMYO0xxqkN3rOCpcZvTCjRpqieLDXqU5RSlWYXPBgcxlJ6ug==
X-Received: by 2002:aa7:88cb:0:b0:70d:2e24:af66 with SMTP id d2e1a72fcca58-712673a3442mr2025536b3a.20.1723612675600;
        Tue, 13 Aug 2024 22:17:55 -0700 (PDT)
Received: from ?IPV6:2401:4900:4acc:78b2:495c:15af:d322:f4ed? ([2401:4900:4acc:78b2:495c:15af:d322:f4ed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710f7e1b345sm4986870b3a.151.2024.08.13.22.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 22:17:55 -0700 (PDT)
Message-ID: <4c14e3bf-0f0d-4600-8e17-5b5d15ad7447@gmail.com>
Date: Wed, 14 Aug 2024 10:47:50 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC][PATCH v2] t: migrate t0110-urlmatch-normalization to the
 new framework
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Christian Couder <christian.couder@gmail.com>,
 Christian Couder <chriscool@tuxfamily.org>
References: <20240628125632.45603-1-shyamthakkar001@gmail.com>
 <20240813172432.55487-1-shyamthakkar001@gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20240813172432.55487-1-shyamthakkar001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ghansyam,

I just wanted to share two comments based on what I observed from the 
recent changes.

On 13/08/24 22:54, Ghanshyam Thakkar wrote:
 >
> index 0000000000..e0dd50dc11
> --- /dev/null
> +++ b/t/unit-tests/t-urlmatch-normalization.c
> @@ -0,0 +1,294 @@
> +
> +static void check_normalized_url_from_file(const char *file, const char *expect)
> +{
> +	struct strbuf content = STRBUF_INIT, path = STRBUF_INIT;
> +	char *cwd_basename;
> +
> +	if (!check_int(strbuf_getcwd(&path), ==, 0))
> +		return;
> +
> +	cwd_basename = basename(path.buf);
> +	if (!check(!strcmp(cwd_basename, "t") || !strcmp(cwd_basename, "bin"))) {

I think comparing blindly for "bin" would not be an ideal thing to do as 
this would let other locations which have the "bin" basename to be slip 
through. For instance, running the test from "perl/blib/bin" would 
result in this check letting it through. I suppose we could need a bit 
more specific check that ensures that the test is indeed running from 
"t/unit-tests/bin".

> ... snip ...
 >
> +static void t_url_high_bit(void)
> +{
> +	check_normalized_url_from_file("url-1",
> +			    "x://q/%01%02%03%04%05%06%07%08%0E%0F%10%11%12");
> +	check_normalized_url_from_file("url-2",
> +			    "x://q/%13%14%15%16%17%18%19%1B%1C%1D%1E%1F%7F");

When we run the unit-test binary from other directories, the error 
message is thrown appropriately. But it seems to be printed for every 
test case which seems a bit spammy. I suppose it might be helpful to do 
it once before actually running the test cases and skip the cases when 
we realize the binary is being run from a different directory.

--
Sivaraam
