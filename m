Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E7B657D4
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426391; cv=none; b=u9njksMYfLbjIKibiexGCB9Jt3+IavpaMiQpqCua6ib6xlYWFRMKYiq+QkDMi7gQj7Msa1r9+JeoAXLMzevK1FIYxZiE7QUj9FPAeb/tF/74Ul7Y/i665kKjnTYgASHEGxs2yCzhrGJHPV0zMXIbin7Vgw+6AF6Minv1woW5e08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426391; c=relaxed/simple;
	bh=xiezR8/HlRwjDS1qeR1bGEzi010uvgdTI+fYH9ove3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ddNzWt22u34qtc1vYnbOvvAt3ZO2LeKECkK4M9dsy6AeZcqYw2Yf0skej3aTI33uZcSlYSYyDZsZUSVc/bEmt1hG8QrybtxOOeazz1KXLmKPnUDqJGMzWIic9mHXlokL0kBkWa2h8eysO1uOZrNHyur3WZIRSPC5uI0K99xqmGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8Bg7wzd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8Bg7wzd"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4126f8c6b3cso2783325e9.0
        for <git@vger.kernel.org>; Tue, 20 Feb 2024 02:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708426388; x=1709031188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+mtHpXOwSQu4OVOtcGAKLRqRT8qlMt3ZuB8gaiWaNt8=;
        b=D8Bg7wzd0GdoISe+0LQuPIc1o7d5fSGpQ9Cp3V2O8rU/BFf1fYmkUrpVE3aHlZutS0
         cejLbjOWVo367UHJT44Xt4aKczS/eAuZJwhpgYl8dh+8jCFSL5/x7/qTodP3iq/RC/XV
         EmMqS0NouV26fep/Y4iZb7Wfut7g2jwFqwTrb8THnlcs5yZyYXVFedFUzyKZFh1eJNBJ
         LWIcb5OPk4k5xD49kAfitXxdo7UHx8y1kSirBovTvynf/3l0ndaVle8Jempv9ZIlWzB9
         3yo77X5EibDjnSDOIfBhTVJdXvEFY4hMOWIQKNb3Qc6dqCctnUvZDEtGsyCauXtyq6Ik
         2VUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708426388; x=1709031188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+mtHpXOwSQu4OVOtcGAKLRqRT8qlMt3ZuB8gaiWaNt8=;
        b=wgV2RENQMtnjzVJcWuunOoKVP6EetoKlfK7k4hFALLy7tXRmn2CXpKyoykttTlSllH
         O5x7zaZdUfS0HqNgTZU2vcJkco8pD4zqAsypeQlV5KR9YGbZhwdgqFMY4xl3AEANvBcG
         vhYpW6wXzLXbmO8142DxpQytXlBuATrgd5nxwmhDanVPn4E5qf2vfIEXkIqz4Y49mhMw
         E5nY0WrcPE8uCfXiF9jV/Y1RHmwa3DcKbYvBi1o0JwlFSXuZ/ytSTdATyEtJdPJUTKcd
         Rvfo/jIO1sLIaL/09IZ6PfZS6fzelCxgyCZRWZhM6THm5hGZaC8BM1X1gZCel+EW+4+i
         +/rQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3Mw3SUXkObHNq1z/fbgqu94UJbHDME3ZtedKKIViBq4Jis08trnRX4ZYn6LLkUVBUjNRltSWldgCtYhZ55A//X3Qh
X-Gm-Message-State: AOJu0YwUnBg1vjCdD0+C/r/fQ3BEf3AtfWAH49r0TjGoX/QXcdK5AAvx
	zPz+NY+20vfIKWa5kagWSRuvFLAGYb3GrVXqp8Eq7xHZyXvi3ovV
X-Google-Smtp-Source: AGHT+IEsuFDdBYL5vYeXNn7AJyDO9mHrqCVhbME3uZz6MGt/xu0XN07KpLTniIuirN5TMkl8FZ86Tg==
X-Received: by 2002:a05:600c:35c7:b0:412:6adf:3f41 with SMTP id r7-20020a05600c35c700b004126adf3f41mr2984121wmq.0.1708426387950;
        Tue, 20 Feb 2024 02:53:07 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:69d:3501:d2c6:37ff:fef6:7b1? ([2a0a:ef40:69d:3501:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id k3-20020a056000004300b0033b79d385f6sm13080179wrx.47.2024.02.20.02.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 02:53:07 -0800 (PST)
Message-ID: <70a81f5a-32d8-4517-83ea-8019be5f97d5@gmail.com>
Date: Tue, 20 Feb 2024 10:53:06 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/5] promise: introduce promises to track success or error
To: Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc: Philip Peterson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>,
 Emily Shaffer <nasamuffin@google.com>,
 Philip Peterson <philip.c.peterson@gmail.com>
References: <pull.1666.git.git.1708241612.gitgitgadget@gmail.com>
 <bd340a27-bfb4-41b2-a1fa-356ab7dbbd36@gmail.com>
 <20240220025722.GE2713741@coredump.intra.peff.net>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20240220025722.GE2713741@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peff

On 20/02/2024 02:57, Jeff King wrote:
> On Mon, Feb 19, 2024 at 02:25:29PM +0000, Phillip Wood wrote:
> 
>> I'm sure this has been discussed in the past but I didn't manage to turn
>> anything up with a quick search of the archive on lore.kernel.org.
> 
> There's some discussion in this sub-thread:
> 
>    https://lore.kernel.org/git/20171103191309.sth4zjokgcupvk2e@sigill.intra.peff.net/
> 
> that also references this earlier thread:
> 
>    https://lore.kernel.org/git/20160927191955.mympqgylrxhkp24n@sigill.intra.peff.net/

Thanks for digging up those links

> I still think this is a reasonable way to go. At one point I had a
> proof-of-concept conversion of some of the ref code, but I don't think I
> have it any more.

Ah, that's interesting - the ref transaction functions already take a 
struct strbuf to populate with an error message so maybe that would be a 
simple place to start with a conversion to an error struct.

Best Wishes

Phillip

