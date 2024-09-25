Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3B41662F7
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727271330; cv=none; b=rrYacJbRf1DTiDRmFi/CbZNJ/dp0igANubnsB7u8R8ckpo6cWpM/Y2THVBn+4ga8hOX8v9sybbIv/fN6udvZhetIt7xcWDAcRX6ax+WkrAebboTNsBe9qLT63vq1ML66gR/8ZhFQfv3ToD/JWRtRbJk95JjgsuT5YN1L2zYAZl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727271330; c=relaxed/simple;
	bh=SC983wluAsdiOWhUikPyuq4WxLZ59dNsXDJjf9HyJcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fm8bbDmMBNaDBjLrvJbJpKZDUhibIFqFPNX0d16PqjXhBB2Ss6hwtCMAXrzP8GWYyD+TcEOg9qsPyx4QajBh4VVI1jm+siB86bMkSblrgNkpBjaURFHu1TxH+iXEL8RE32DTphfxVyLjFsBHhZpb0IWUqthY5ELiOLBc43zjec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqhmW0Up; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqhmW0Up"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7193010d386so5453026b3a.1
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 06:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727271329; x=1727876129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rh2SIpkfbgEnAV/dUld1vy3T9efR2zeTlY2wnF5WtuY=;
        b=IqhmW0UpGOHtP+zStNpyXEwxURnd0RjJvpiSkg9RTsZx41unqvH0Z1MBUE2AgUCz4g
         znKCUvrsQBfMsR1qTtyd18bLm4ApthXF94Q9pGj60McqzDlYJV0waeqg4fN8xzidblzp
         0F/c01C+czzvONy5+JcwM4V5vCoKwDQG2glHhwEijTZyTWwxShsZILedOWGRjAa/XhjQ
         NmjgP7RAYatnzZIKEIcJSgo26xOV9VQPv3UEzSikj+PjJyMx5e0Pus6trDZfQF3iOJGt
         2wFO8/J6dbgqJeIt7av4kcXrIbzoPG3ObXTcFHcmKZq+6C92xMsXOtIVuxT/UGUEOrIW
         dWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727271329; x=1727876129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rh2SIpkfbgEnAV/dUld1vy3T9efR2zeTlY2wnF5WtuY=;
        b=iy16FfK5Yvu+908qYj7w6kb90QEReUDzRwQY2p4QutKdN4jF/HqK4Jn9yfp3SbZ99H
         DleR6DKVo6Lf0Gsx9JLTgWmX5G5iHwuEr9pZG+GKb2XXTVg7Wjp0OkJPJqV2IYrazoQf
         cGQxdYUUXr7j4tBghIEjbBLsdC7Dh2gwcCjwirXsl3Xog5oaGvA8eUtXS6b23GB2gbEo
         0Z9UFAT0n0LGWW1StaHyBfO8tFsOXvvdS8YABA5V8xrkd//hL5KdN+vcCp71Kp3aeuMd
         /Fa6T45P4hgKcT7l3kkOBf7MP0KpWD9ExqU1oPksfyFOtCzkdIXzP2oY+y8Pt2oBxrTz
         Eizg==
X-Gm-Message-State: AOJu0Yxf6U91bqshLv8M72EuLSf/BKcRmf4cZpn55Ih1v2zd3EHz5ZNL
	Z/TUxMMWs0OdyrOyfob5bW7/9My18azu/Xk/wsUwgLPtJVFb1teu83Dl5w==
X-Google-Smtp-Source: AGHT+IFhu0sXMFo4Q52TJf0FpvN7tNnnYV3KbInRVVIK1oIixChyibXLoXOWlKT9BtbFdh5pGhe4dQ==
X-Received: by 2002:a05:6a20:c503:b0:1d2:e793:b35 with SMTP id adf61e73a8af0-1d4e0bb3abamr3786479637.47.1727271328619;
        Wed, 25 Sep 2024 06:35:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:1a:6e9e:b1cf:6f9a? ([2600:1700:60ba:9810:1a:6e9e:b1cf:6f9a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc9390f4sm2759659b3a.130.2024.09.25.06.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 06:35:28 -0700 (PDT)
Message-ID: <5bc7ba07-da0f-4a41-8979-e75221a747a7@gmail.com>
Date: Wed, 25 Sep 2024 09:35:25 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] test-tool: add helper for name-hash values
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
 <pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
 <7e47fc8cb53647ad92c86801204c3089a5dfe8e6.1726692382.git.gitgitgadget@gmail.com>
 <ZvJj7PeB52m_1mG9@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ZvJj7PeB52m_1mG9@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/24 3:02 AM, Patrick Steinhardt wrote:

> This patch breaks t5310 with the leak sanitizer enabled due to the
> leaking `struct strbuf line`. It needs the following diff on top:
> 
> diff --git a/t/helper/test-name-hash.c b/t/helper/test-name-hash.c
> index 15fb8f853c..e4ecd159b7 100644
> --- a/t/helper/test-name-hash.c
> +++ b/t/helper/test-name-hash.c
> @@ -19,5 +19,6 @@ int cmd__name_hash(int argc UNUSED, const char **argv UNUSED)
>   		printf("%10"PRIu32"\t%10"PRIu32"\t%s\n", name_hash, full_hash, line.buf);
>   	}
>   
> +	strbuf_release(&line);
>   	return 0;
>   }

Thanks! I'll make sure this gets in the next version.

> I also plan to eventually have a deeper look at your patch series, but
> didn't yet find the time to do so until now :(
Thanks for taking the time, when you have it.

-Stolee

