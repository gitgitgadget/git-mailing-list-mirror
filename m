Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8721DFD9
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719839846; cv=none; b=ZPYjiqE2I1V76rjQnNRx/OitYM2gdgqhLPxyrz6Vp5pSA+HIzihj+OiAJNnLM91tFpCmLoBiYjmjCwt+MbF1Ag/bD8wc+yYydmoSfF1h7KwK1+SdTzhinJeBKI+h4auEbg244YKrIbJOZ8lNRMq3KaP9lMORt8lmKmmrnZ6iL4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719839846; c=relaxed/simple;
	bh=W7zazppIJQ+FsIj2hJmutWWN6Z2QT4ccMgHxBEViRxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jdlp+PZbCZe4NoMGojecWHB/jN7lHSWpGXbJRJ1bnd+DkyLGlwiPq5W37RbTAPcpej0D3XjVZ4PJboOsqbcSFktYALqDe4xvDHW/+OUsXGDMBYjyyPv1fm6vKGI+duoabmrFe5woTP8BfwYzWaUJNkrN/KNmOlnmUJ0OvPFxxtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zr2G3UtM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zr2G3UtM"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4256742f67fso22249705e9.3
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 06:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719839842; x=1720444642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RReyL7J5gNLTjO4PIBob4kOl7LbVSBd5+BcY1VCe1dw=;
        b=Zr2G3UtMy78s27erpv7NML2udMqs9VcpVBhRI4mp+p/X74aMyXmVeWtGG3rloci5Ea
         ihDMkllSKI9ZMiuBX7Wy3AWcwSep6HnVxzspirGF4st1tubWhry2CYEZt5fJ6vLdcBR6
         wCiKiPos1VCT8mgnkOWtKvvAub9VM+/9qJ5FMMxwK5deTX/WzCOT5UerhpBLaAKIxNM6
         v2Xn3TzjwRlHbGnuQx/kDekOtmXxWgQyLQyfZ7fnrhz+kk6KLUZ7yh6cp6miN9bEtyqN
         rZdPPtzIEpUc7P+knDGMgLzU7ikYWfrhgL7vnGTI7ilRc8oYCk20ytrNjAEVT95GNs4O
         /i6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719839842; x=1720444642;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RReyL7J5gNLTjO4PIBob4kOl7LbVSBd5+BcY1VCe1dw=;
        b=nrUotaaqhCR18NubHfnwUcqMTeWgMkPnQOLT1kLRiKcfi4OmhDbOgcSUqmSpOSzDPR
         a6TmWvkT5cOeRQaBdlMetmPtAF1UrJJg7H5utX/Jej+wC27H/pLFTg4ALANtidTqePK+
         w8f+UvxMMmwczZEIcgcNP1/GvjYmBRqTDQ63WAHz2Qtd1NcQf9psUyI867IeDXfAh4xG
         WkUfs4ERQDBO+WIRArcoepnTZh5PK/r2z/Hmu0cUxPT5iEHEtr2f1jvQOl2f5lHggLVr
         iEn9R8odyMPq/dr4KaLfN2SwVLGbC9OP8yVihGvyCCFK9qzCV8zSAJnvOPpDvB64Dm1h
         QjlQ==
X-Gm-Message-State: AOJu0YxBHSuYk/sWZvng0qrpJb6g0NAoCY5qUOM9B36AHXwuWhwwQIuF
	rPFqLAxbLCZT0bF/RGBl7dHSCfJVgcLvgy00f71seVmusePe2tYoDDBXhg==
X-Google-Smtp-Source: AGHT+IFPhBxfDrno6DSzkDmgi1M1gUKKVa7Xx2+oNUSagYoAYxBFJYt/c33Sc3vitgTpdU+nmjREYg==
X-Received: by 2002:a7b:cbd2:0:b0:425:5eec:d261 with SMTP id 5b1f17b1804b1-4257a02805dmr44621785e9.34.1719839842345;
        Mon, 01 Jul 2024 06:17:22 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42588492b4fsm12021355e9.4.2024.07.01.06.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 06:17:22 -0700 (PDT)
Message-ID: <bfa964a5-c366-47c7-a325-44fa4687432a@gmail.com>
Date: Mon, 1 Jul 2024 14:17:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Confusing treatment of "head" in worktree on case-insensitive FS
To: Jeff King <peff@peff.net>, Julia Evans <julia@jvns.ca>
Cc: git@vger.kernel.org
References: <A72DCB1B-8D81-4DD7-93AD-BF37E88E9D63@jvns.ca>
 <20240701033145.GB610406@coredump.intra.peff.net>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20240701033145.GB610406@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/07/2024 04:31, Jeff King wrote:
> On Sat, Jun 29, 2024 at 10:39:29AM -0400, Julia Evans wrote:
>> $ git init
>> $ git commit --allow-empty -m'test'
>> $ git worktree add /tmp/myworktree
>> $ cd /tmp/myworktree
>> $ git commit --allow-empty -m'test'
>> $ git rev-parse head
>> adf59ca8da0ee5c4eb455f87efecc6c79eaf030f
>> $ git rev-parse hEAd
>> adf59ca8da0ee5c4eb455f87efecc6c79eaf030f
>> $ git rev-parse HEAD
>> fbb28196d08d74aa61f65e5cee3cb11cc24c338a
> 
> I admit this is an unexpected case, as I'd expect both on-disk files to
> be spelled "HEAD". I didn't dig into the details, though, so it's
> possible there's something we could be doing differently or better. But
> I do think it's mostly the tip of the iceberg for case-insensitivity
> issues with refs.

I think what's happening is that the checks in is_current_worktree_ref() 
are case sensitive so "head" is not treated as local to the current 
worktree and ends up being resolved in the main worktree. I guess we 
could make those checks case-insensitive but as you say it'd only be 
dealing the tip of the iceberg.

On a related note do MacOs and Windows do any unicode normalization when 
looking up filenames? If so then that's probably another can of worms 
for filesystem based refs.

Best Wishes

Phillip
