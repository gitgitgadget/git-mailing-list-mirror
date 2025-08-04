Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370904430
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 22:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754345066; cv=none; b=XGfWAf1oINYMAf6RzjZQzKVqJCwL/OaNufFm+mr1mUITkffVWNvNu2WIYwWUzR4YpJcpss74Xn534n/obUIan49vNziQU7JoSjcq3t9OfyVf8v5t9KY8qTzgs3kNZTp5PaS9KaiUbiX+D1TjMCGati7sibGmJFvLqThjMMm6sko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754345066; c=relaxed/simple;
	bh=OqOAAUKhQojRp+xR+ktuRYpYGbf3IzmnhfkHCcdMhg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccuTvKA2Ai2NqhKxypNaI5tzNsfTDx2f21XK8MrSFxna04GdxuNXkOw1ZJCPAIKOudT4xMWZy/ma0EhsK/Df7MIIXiUkR4Zy6m5RPArrYMdqf46weLMCVfz3e3AeU4Z5Whjn32riIcvwmbw7QhpmU7x8Ec0OVgwSbYxyXkjGmcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=L+a4L0Uo; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="L+a4L0Uo"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3e3f378ea68so33161135ab.1
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 15:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1754345064; x=1754949864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qTSD7Tnr264BYWMQY6jDmUcQxdEWC6auOyzfWz10OoE=;
        b=L+a4L0UoiAibLb2emZmXIFq3H/ITeptu4QKgZLq2fW3ETOWXj1Ncqtg/MSuBr2XtPX
         oTwVT7ctGA/aSgEzkUZJT9qtpHupxXtXbFpfQm43ZbjqNpOs48TjUQthcdUZD9Is2aDB
         UHskiggQaAV53LAaJZslqHXCl8HszD3DApqNMAuwk9jPdr0j20TEGROGxja2ecvgP/cV
         CiP7MpOJlY1zPD30bV91FHpOrLK7wyilDMYyQdUf7B/mr/+O4Tlwei8/tX9T3omMjRpQ
         n7QZaeEMjEujcLCStvRGDFc4m3Ycoc1+TZjX2Aqg6oGUstO5U0BrXEw9vTxcVzq/75Rr
         ORNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754345064; x=1754949864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTSD7Tnr264BYWMQY6jDmUcQxdEWC6auOyzfWz10OoE=;
        b=bIJ16EFmd9lb9umCxTGea13J9MECA6mRB41jgfUZLytaVRQqemedpje719Pijs1pyK
         8Qaq9ZBoA66/7Y51nyhxsV2u4Y+3JHSVtCbyNlKcwZEm9e0czEpxmssjGUNbFUL334zw
         H8uTm+GFRKUNAsafkDsvuvi3tV6vIGKzvet2isaDf/smhW55WPamYtFAo8sxAnc1wTIN
         YKF8WfnJ9EVuW4bTwqpOtx4F8UvBV4Xuc4lTHd15q6Z6pfHPeTUBM4NKwuzXsDKcyjOx
         cw7xCQ5hypvcq3V3/fI07KUsfucRr/dRF8BEXGB7NG2k9DkpnCekm9zzhWhpbxhgByRd
         7QDg==
X-Gm-Message-State: AOJu0YyHPkWgndaKWv33ZWxYMOZ/12RrLUQ1MkaqIBKD6xiZYSLSFsXT
	ATc6ahtlziwqCNad3nTZoGFUCHX/eJC4cdZG5tjTOrywyaMD3IX+zIqpL/8GnoQwgz4=
X-Gm-Gg: ASbGncuD8ICy/sTZvou+ZwmMf6vOg8expryU4zR9NwBCxrW6I2ELIIfl55lWCQJsqBV
	TMZretojjhVlyQljDO5JlAwwpUeSqrIWYeIBGeNpBQ/0gzNLdlYWqQV9aGybY7lSVQc+qLoUqZ9
	sJ2RNCUVFxgqNUJwUQ1sa/w5XL1JDB9SCHXTEqvF2vq53oIkkg05Ktg37ZhN7twUJc+v+VQnJHU
	YVX3029wgQ1QPv8c96Axa2G0aqXsxqJTpnscG2+VCOaJCIrUoxbtpqmc9BL/DkCCXZCBz+EqkFE
	UrScgNE8s3w4QyOPjy+v2YWM+GXLuW9ZrDigEy9BsC/cvtceIPR8cLwWL04HNHUDXBd5To2+aLs
	Wyj1Zg8grJcUIPyQ8Fg8PAba+S+TseaYuxYjG4fEw1lfOK2A8snNeJCi7WWOeRQCPAGemOw==
X-Google-Smtp-Source: AGHT+IE5XJLZpCTykAqS6No2bQVMqNLQOPLkUDMqa6sr0Km+UgjGywOsemRpmVWm4S+7/nBFyhmexw==
X-Received: by 2002:a05:6e02:2382:b0:3df:347f:ff3e with SMTP id e9e14a558f8ab-3e416116d8bmr208289075ab.7.1754345064145;
        Mon, 04 Aug 2025 15:04:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-50a55b1c5b7sm3451668173.22.2025.08.04.15.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 15:04:23 -0700 (PDT)
Date: Mon, 4 Aug 2025 18:04:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/9] commit-graph: fix sign comparison warnings
Message-ID: <aJEuZnhxbJcfdWFw@nand.local>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
 <20250804-b4-pks-commit-graph-wo-the-repository-v1-4-850d626eb2e8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804-b4-pks-commit-graph-wo-the-repository-v1-4-850d626eb2e8@pks.im>

On Mon, Aug 04, 2025 at 10:17:20AM +0200, Patrick Steinhardt wrote:
> The "commit-graph.c" file has a bunch of sign comparison warnings:
>
>   - There are a bunch of variables that are declared as signed integers
>     even though they are used to count entities, like for example
>     `num_commit_graphs_before` and `num_commit_graphs_after`.

I have similar thoughts as in the previous patch about this spot, too.

>   - There are several cases where we use signed loop variables to
>     iterate through an unsigned entity count.

Here I am more sympathetic to using a size_t to count the number of
allocated elements in some array/buffer.

>   - The bloom settings hash version is being assigned `-1` even though
>     it's an unsigned value. This is used to indicate an unspecified
>     value and relies on 1's complement.

OK. I think that comparing "-1" to an unsigned value is meant equivalent
to saying "are all 32 of these bits set"? But making it explicit seems
reasonable, since it's not immediately clear from reading this function
that 'hash_version' is unsigned.

> @@ -622,7 +621,7 @@ int open_commit_graph_chain(const char *chain_file,
>  		close(*fd);
>  		return 0;
>  	}
> -	if (st->st_size < the_hash_algo->hexsz) {
> +	if (st->st_size < (ssize_t) the_hash_algo->hexsz) {

I understand why the compiler is telling you to make hexsz a signed
quantity, but I am not sure that the cast here is aiding the reader, nor
am I sure that it is making the code safer.

Thanks,
Taylor
