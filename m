Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3B63431E6
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772477492; cv=none; b=nghz867nsiEnDYJrLLva/2r7JM4YBecRdql9O36rtpAnEaeNhep234ddQ1VBK4+OWVVTrkVAWtL/zLF0u3yYiqPR4XVyDOQFLDjkUbuf6aYObcyWKI97QQ9owNKtpQrZ8FfKSgSDNcBvjhJxSMZ5e0TsWwcHStEFbHgogVy4vMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772477492; c=relaxed/simple;
	bh=HJHLqhc3fuUglz3f2Q9X5cD9R3BOnIVm/pYRdRanlQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCeMDFH+beSQUtBJKUm6f+Wk10BaB9UiWDREO5v4c7j22o0QS0KNcs4VljrHZKkCYKQGqeY1quG+hS+lFWgY3ZRq6+IENy7Nw97vqgE3fRX/Vq7zvgmWI9pN1HRr2nLlo5sfs7qYhhnEDHnSm4E11Bc9Nn50P1a1d7/cJBkMktM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Llb1R25a; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Llb1R25a"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35448ca4689so527693a91.0
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 10:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772477491; x=1773082291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NSbD+I46bBcVzyF4fILNuwkpxyqS7moFxBHChjNEUIc=;
        b=Llb1R25a8/1Y5Z62MWSP6SvCsZXnkX75JEFOK+0THyAzQu4n/9tG0CMRNlc/YvTZbM
         /ikz4oCbswNM09PAPQ1bbw4eHopgc3YH7cGRCZh+wX4bgQQ26RaGnWkyWRmAL3tjtTij
         ULYzOsiVuB38Pw3UzqjJE+3VsPWbmB9/w0kdA9eYGePM+/HqxXyHGAegmxh8kuGyx2jV
         wYmenHimTUsEIZ4KDPFbfQpxQr9VBz1+eW1V0Z5pXuL3114wILLJBF2xeFsyo+enWOyj
         5h/Osyz50EewLlsfelM+URz8t5bRkLxqYvd41HkRg3NoP1hNdisBGn9/8HtjriQcm8K7
         qsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772477491; x=1773082291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSbD+I46bBcVzyF4fILNuwkpxyqS7moFxBHChjNEUIc=;
        b=oofvaHW+Bh1neh7EWlv0ayQ2Z4J6EoHC4Mfh7JENDi/bURxw6KZF4bkXIaQdVKWlQX
         SGg4PVwYlYfY+/FfAnSxmZ45/gCtURmhTVSkfLFg2SL5MdwESAGMQ2a8v5f6elUolT9J
         SyeK8sXG/i5cWbYERXwO6o9vY9xtDv5tBgEQVRYnsdiTgbxeUKipLffqRQcg0Hu6lCd3
         B8BW2npWmEGcU1jpXt1ZWDdlJIOZx/EkjzCmUC0bmZpi15ECaK5odFev1BZKLsLXY4lA
         vbfIBGZiy6dxUHIkxPiTZr6XwPGnGyauiCVRhvGQV6PNe59rMkqHQNCPorS8iCSB4XP4
         60vw==
X-Forwarded-Encrypted: i=1; AJvYcCVBRBOc3inzAssPjkr7cMs5ENHk0RsS9reyiidcR8mkgoa0d8NZkDs0IfGGNput4EDHLuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLeqpOqt8Z1kax/ThzrwBWFhdo2ANKdyZw0P8rA1yMehYSV6qK
	9bv7iLPBaJKyNOngAY6CzH1XjGwarLJBcXx0AF/ys5xtrS1irj8MceG0
X-Gm-Gg: ATEYQzyZCKdPeK4TSYqP0REsEcdAmwu7kz9yPY+US7oi9RWkOJWogtzAm+FNcVyFwIN
	QxH3I4pggarbnOpC7fSVlsYnFECJzjT6DvgF1X79zHyTMbwxQQTbXPXgsWBs/cIjVhKPFV46EAq
	eaHB34YV0nbE2xbH0344F7wAd8Nv6c6xPxpP8sBYNwvOnI39IheQ/o3W5KZoDBa9Y2tbamRRhMS
	Wcc2UIHcoDxz5Q+2kspVsLWgt0yQ+BkL2KsdqRVNL98B1j7iomIzZOYyLDJYJkU3R4Hsab6p65v
	mw/3r9y4fRA1UInfR8lVrzmgo4rxu8yyxxHfOKzYNPSwR894CQL5xpHis9Cqqt3LxJvV0HYIKyK
	Dekl4mnjqSQR45y9JAWhszyXmhcRl26j0huXXiP0QQFBTcVw71ffZJkVBW0eLkY+CuVlEpG96KG
	w9wjzoyCefDVLZ6Mwzo3VAFwU/cgkxT8yKAaSHvm/MM8bDDjgUwRGHIUye9M+fan/6O5yn7ne7F
	buzLWl3CA7C
X-Received: by 2002:a17:90a:d888:b0:354:9b9b:54db with SMTP id 98e67ed59e1d1-35965c8c1c6mr8009219a91.3.1772477491006;
        Mon, 02 Mar 2026 10:51:31 -0800 (PST)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa5ef997sm11981113a12.2.2026.03.02.10.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 10:51:30 -0800 (PST)
Message-ID: <3983da40-bf2c-4665-a7d9-dfebaacb8bd3@gmail.com>
Date: Tue, 3 Mar 2026 02:51:26 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] repo: add support for path-related fields
To: Junio C Hamano <gitster@pobox.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org,
 kumarayushjha123@gmail.com, jayatheerthkulkarni2005@gmail.com,
 valusoutrik@gmail.com, pushkarkumarsingh1970@gmail.com
References: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
 <aaSusXil9nDHYGMR@fruit.crustytoothpaste.net> <xmqqbjh64262.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqqbjh64262.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/3/26 00:38, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
>> With `git rev-parse`, you can change `--path-format` on the command line
>> between options, so if you want both, you just request one thing, use
>> `--path-format`, and then request the other.  However, that can't be
>> done with `git repo` and `--path-format`.
> 
> Hmph, that is one advantage of that incremental option handling done
> by "rev-parse", which often is a source of confusion and complaints,
> though ;-)

Short question: Is using format modifier like (%path:relative), 
(%path:absolute) a good solution here? I think it can be implemented by 
simply adding a path parsing function in ref-filter.c (and some other 
work that aren't particularly challenging).

It should be user-friendly, readable and free of global flags, right? :-]

Regards,

Yuchen
