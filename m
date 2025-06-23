Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612E223B0
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671737; cv=none; b=UDAAv4SVOVBFlBCuUkoRJJ7UtTudH2htwujXTSbttMYv7lU0ul8XT4i+E0PVs3VR2uAU4zzpjtEpVXUjEeUv6ODV8+JBOGgRe6eUylyTYA5Ft6clkZkWN0iuWsnfElPHmS71Dtl+E+0sgT7QNJ4RdPByWbjEjnOBbGQQ9RcAqJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671737; c=relaxed/simple;
	bh=5NTENlCvW/2NNaCWsFVOGSbRnM3+XM7rHDywOJc+dSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BpZK27FwlSnmydNg8t9jhigRPP9h5k78kx/GReL+Cz1yiXEmFTPF1vjeUs/gLBmXCmZU3QT0CvQKO0fyn3kXWHaiGNjEaYQTmZYD+fpom+RfOCcsZ4LnjjA13gEWQnJ2ure4IjEqmC1bQkyRizS2ESEiVgRBl96vnkYzSxrvlQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6sVC6iu; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6sVC6iu"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so27272945e9.1
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 02:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750671734; x=1751276534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oyDpzfY5EWgx5P9EDbJ37gR7W1LvjqAovbyTMvblG5I=;
        b=Y6sVC6iuq+RDKYHvaSb2YxjM6GlVrCZ4A8SyeIUGNPnl+eyNuvQbr4BwtyOtrJCsHS
         MfitIk2enWPptj1WwEiwHQtROAYKNDtMnvf93OM+KkybQ0QC19p6q3U1i5EerBcLntGX
         nyj3rYS31fSnaoqcnSMwOQkMQ9LfaNLRUd1TUt/8ew2i8drml7553Qkwppj/gQOUgkzT
         9yfcLWn1U6AAmTUaag4te+EYcESnci0egZ+jzJUV6THuAACl7D73cGq29EgZLINWG6fI
         lAMmIEOcCh/GQ82O7LpXKEt9Br+PlnbdPgiqUfP7A9qf+qN0+8HIy5iHshwPxcPoBrx3
         YoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750671734; x=1751276534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oyDpzfY5EWgx5P9EDbJ37gR7W1LvjqAovbyTMvblG5I=;
        b=vkAJOjhi0JsKS/I1O1sdwzdU2M7+jRP9tCarUSDhSH9D90vEgG+PWKZ7mO3Jgavc2B
         wNA01VtG3wwSwOz2QHWasu6/RFS3sU5ofbb0iPziPq18Y6UC4Oe4VelxgMcWS+K2HyEw
         2YRLvOr+it/e19eN+RbDKw1EjwZxUuwBvbB7JEbq6UYcSl5TJVy8hVxZBS4yC6nEDZes
         u+YSm9LDAmNd2qaxMUuHjqp2vWg3i+BF2ItSoPrROGHj75K9oRam+LfBUnj8EhpthuRq
         1fjJZfJAaSSLpZt1tR718ODnooaRnTw9uVUqRaCYaSQ1zCSaukwyAlPH/9QNO6I9LArN
         TBCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGLIi6Y/IiuuXMhPF5ShVBe+cVWpQOMSazR0xcy7ssS/tOXqmZT7NB3zjq8Pnm+L+mOj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1dkmrALSYtRz49k5qiLYR/tC7mGUOqvECHRmeoN92kXpZnqAn
	l/B0GwQNsCG2vU9b750QV2tpNYt15ZiOW190EFlGwmvMl9GBqi8N5x6+
X-Gm-Gg: ASbGncvzOFJl2MdON/MJfHkNmNDtEZzyH60xubupzokNHROXShl6vhMuoEchnfmucnW
	O1FsM+sjaw5kdZAy2zDgWRk1la9Pc5lsJclJY6lJSGsLZeKkonsqYXktU7tgHKaPS9VF0E/p3XI
	M4Z8cetCqI9oMmcTqLH6gx1ywd0zxNd8pMkxhnwRFQZ4kf+6B72ilJse2nHr67J05hb3rD9FLLZ
	ugoulz2FAR1rNUBydcE/7ekFcdZ9PZwlChI1n2XMrhUJ5777k/kz4vizeKsE8aWhyQuXi1atRLn
	mIMA2fsqVZXWr9P7sIQTDzee4TfUDmw7rU8DWqrCxkW4eHbsScXnWuM4jAvw+OJspA1cA9Tp7jj
	D3qUMGBSrQdKB+QoHfFppIZpoNsJ/VJWlY6TqbQ==
X-Google-Smtp-Source: AGHT+IGkryj3tz43Gw+Mbg6kMfHq+tP0j2QtGmARSwmrI1xCaZVmKbAzNe49+lEtZpKnLzkVmN8ZTg==
X-Received: by 2002:a5d:5f07:0:b0:3a4:f7dc:8a62 with SMTP id ffacd0b85a97d-3a6d1038498mr9028293f8f.0.1750671733564;
        Mon, 23 Jun 2025 02:42:13 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d2236452sm8829427f8f.59.2025.06.23.02.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 02:42:13 -0700 (PDT)
Message-ID: <d6e22dba-637b-4b5d-bd88-25fa320e22ff@gmail.com>
Date: Mon, 23 Jun 2025 10:42:12 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] Ensure restore_term works correctly with DUPLEX
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 James Duley <jagduley@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 James Duley via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.2000.git.git.1750186571037.gitgitgadget@gmail.com>
 <xmqqh60euqhc.fsf@gitster.g>
 <zpv3nkpsjqlg7evklw4ui5q7wonak2376rclu5ksmumdvk3tic@tfxmcpjmj3nw>
 <CANZAkJuPUYSCd4yGHFhs6hfERovzjwWoM2gU2MyAHvY_AtjLkg@mail.gmail.com>
 <ckzjxolc5jthge62zcm5abnssefwntc3ryu6sumpvrdontmyyq@d4ahvg5umked>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ckzjxolc5jthge62zcm5abnssefwntc3ryu6sumpvrdontmyyq@d4ahvg5umked>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/06/2025 00:43, Carlo Marcelo Arenas Belón wrote:
> On Thu, Jun 19, 2025 at 08:38:29AM -0800, James Duley wrote:
>> On Wed, 18 Jun 2025 at 22:07, Carlo Marcelo Arenas Belón
>> <carenas@gmail.com> wrote:
>>>
>> I thought about something like that, but I figured:
>> * restore_term is only called if save_term is successful
>> * hconout is always invalid before save_term is called
> 
> but it is not always set to invalid at the end of restore_term()
> so it can't be relied upon either.

Are you sure about that? It looks to me like the only time we don't 
reset hconout is when we use stty in which case I think hconout is 
already set to the invalid handle value.

>> * 0 might be a valid cmode_out that should be restored
> 
> cmode_out == 0 is not a valid mode that should be restored,

cmode_out is a bitfield. The documentation for SetConsoleMode() says the 
mode parameter "can be one or more of the following values" which 
implies zero is not a valid mode. It seems very hacky to be relying on 
that when we can just check if the output handle is valid though.

> and
> indeed the original code was (ab)using that fact to decide if
> SetConsoleMode(hcounout) would be called at all (as a proxy to
> know if DUPLEX was used or not), hence why it is a bug not to
> update it, as you pointed out and found unexpectally, sorry
> about that.
> 
>> This is my first patch so I didn't realize git-for-windows had a
>> separate fork. That makes sense now because I couldn't find where
>> save_term was called from in this repo. To test this works I had
>> downloaded the artifacts from
>> https://github.com/git/git/actions/runs/15692373534/job/44210362705
>> but is that right? If I should submit this patch to the git-for-windows
>> fork, please let me know. Or, if someone, who knows what they're
>> doing, wants to pick this up, they're more than welcome.
> 
> You are going to need to get the Git for Windows SDK installed to
> be able to apply this patch and build your own version of GfW.
> 
> IMHO getting the change that makes "cmode_out" reliable again (which
> would include both our changes) should be a good start regardless,
> and at least that change could be submitted here.

Yes, this change should absolutely be submitted here as it is fixing 
code that is upstream of git-for-windows.

Thanks

Phillip

> 
> Carlo
> 

