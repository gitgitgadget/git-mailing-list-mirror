Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6F11459E2
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334933; cv=none; b=te1tL158WaBNw73KLwN4K+9XNSBrmquuF3hhGT6wmLjjsriKQHtKpToxgAqkgmuDIO+cFLWMI7HiERvFgIumeHglpPUyxNIucvvC871hc7V1z70g0xpoJqPoMbp80YuT0hDDNufopbpJOwWuaL3ADlDFUz0lonWKc5QP6AvnTTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334933; c=relaxed/simple;
	bh=dRchbzRt5DIDFi/9gB77o6l/Cjf7Y+f/jN7Z1avA+MI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p+6hUq8La3cvWCBUPC7jwczobKk8a8y6My5KkPe1u8LTiaR0NVKs9IWTrQpXOH2ieDzwq4Cn1eh3nhR47iAka9GQ2ZIlZeAflorlZ7SXePP/F7XfIOLqSSCvbNSY0joUyNqpjEKhUhSMAuUHXG6f4DmHeZy21PZ+Shv4DOo7Xlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Btz2tIuS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Btz2tIuS"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-424acfff613so41545e9.0
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719334930; x=1719939730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZM/TioJPhDldoglcwA4Qp1PM9mcMtTSLo0Lq8lzGdZ0=;
        b=Btz2tIuSodQpeO354WLcn7VpfplgML/i0lPOFZXrWNWIEITSFNoVJ0Wjnux69AC7Bb
         phvXEXTC3bkXaBSDAXTEh8cb91UI9mYBhwS55nX4L7tGnWw3Rqq+0/rUZEiVHFex2Qoh
         8gwvYyM+2lmBy1gCj3ChcEl0+NOXhyYXFX37r7sK5Calu4hC9lMJvSJuKD2H7BH2rBBF
         oABPP87Zz8bBTdivRL11Kk8uhVjFW2s0+vs/Vo+fOLPihlsuO9P/hhsnh6/mlPMbKR6n
         QX3ga8wc+TJJin19LZUr0kVxsl3nFKnPXSdfhTMdGOLOCmXjhLB35RuqbuI3dSMZ5gen
         wLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719334930; x=1719939730;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZM/TioJPhDldoglcwA4Qp1PM9mcMtTSLo0Lq8lzGdZ0=;
        b=jUdfgIQ06hi65GrCD3ZvDs/C4FC+gjDue0Zm1h/9yzfcjqI41wh05hqFpQFV0rO1gn
         TCChM3ZgqMW3spPaHBularxWH4KmLyCW+cJEu+jpCFvJXp1euIIYAx5isR5jw5SRla4h
         +okV0h/QrHplG24PmXSMIDu+1l3Uv8PwgXA8Hn2XCIMTiQOChKATjPIFQ+xIJmpXaqTY
         n/WzMEa67aZlb341hYbhInYjUBltiTOV17FfH7A8JRYjD8CZjhYPr/wB79KqsyZrp5um
         Wk4SGVIJZsH7wvtN+laWjMq1qEZeT7oTJeXdJLCAerKyRVWOlaH5zlhP8/gziR+YIZuc
         Ryow==
X-Forwarded-Encrypted: i=1; AJvYcCW63WVfZhxYYgpwaHRXWcizHlQyHlto/1CcReNlmVCvjeb2ENzP11FvC8l4Pyg0JWUcEhQO/UW03hgXawU+V02y+CNc
X-Gm-Message-State: AOJu0Ywor1ldyIp1clPiYPt2fZ8XbToTo4ldEvJKmaGCpAPkln6YjyrT
	r5JsVagW7jfsV6WqSpuGNYCdjX3j6cs4a3UZob7pLUhWEv9KOTTI
X-Google-Smtp-Source: AGHT+IGH8+iNHqtHKxi8155x1Zai5s/eguGxTbuGybqe8jeTATNWtLFJXT1i9I5/eMJvikYGaQ0fMQ==
X-Received: by 2002:a05:600c:511e:b0:424:a587:4392 with SMTP id 5b1f17b1804b1-424a5874419mr16003455e9.18.1719334929585;
        Tue, 25 Jun 2024 10:02:09 -0700 (PDT)
Received: from gmail.com (123.red-88-14-208.dynamicip.rima-tde.net. [88.14.208.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424819227a8sm185306375e9.48.2024.06.25.10.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 10:02:09 -0700 (PDT)
Message-ID: <82f15196-9b44-4805-9560-fd5381e5c5b2@gmail.com>
Date: Tue, 25 Jun 2024 19:02:08 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Jun 2024, #08; Mon, 24)
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqbk3pakol.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqbk3pakol.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Jun 24, 2024 at 06:13:46PM -0700, Junio C Hamano wrote:

> * rj/pager-die-upon-exec-failure (2024-06-21) 1 commit
>  - pager: die when paging to non-existing command
> 
>  When GIT_PAGER failed to spawn, depending on the code path taken,
>  we failed immediately (correct) or just spew the payload to the
>  standard output (incorrect).  The code now always fail immediately
>  when GIT_PAGER fails.
> 
>  Will merge to 'next'?
>  source: <0df06a80-723f-4ad7-9f2e-74c8fb5b8283@gmail.com>

The version queued is:
<6850f558-ad20-403a-ae1e-5b9826c53790@gmail.com>

Hannes pointed out a minor bug that's worth fixing.  I sent an update:

https://lore.kernel.org/git/392deded-9eb2-42fa-b6f9-54c22d3ffd33@gmail.com

Other than that, based on the comments received, I think it is ready to
be merged.

Thanks.
