Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB53535C9
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 03:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708399851; cv=none; b=A7rOkpOtRVL7CKqjggGvuAqER2Qpcw7YPyIT81RnAczDU2Mh8aR+3JNYxhfmSxIFN04XJ0pAyyFBOGEUmpVZa4rN6PhwFxrEmSz0FZ2Y00VmHHmOoUJN+X0EN6wHjDpYguHDdmO7+FmuMnVL4GkYUC4YTKGeeweD8a2q6MbdX24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708399851; c=relaxed/simple;
	bh=1o9y15Hf1m4aI9kf+bcUCTUG/PjvNmW/UN8dmM0B/vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9V2ezZz7SijkjR02GxEcwsuJU2UCmkCKNEufv6LUoLTDzi4GX80kwycaIEXm6BwC4U8pglwXYMMPCZ8fimV/RQgQxPeh+Ful+hh62+frbPvIm5YFAOv2aA5KmKNOEk9HT64Fu2/OCdzLE5bzd239DSxti+VvhPEpGrESEvaRE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EANw2Zg4; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EANw2Zg4"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so3904418a12.1
        for <git@vger.kernel.org>; Mon, 19 Feb 2024 19:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708399849; x=1709004649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rya2HgvW+Xi4tj3SP/SQz8BRtKWPoxSEUWYiMF+BFQ4=;
        b=EANw2Zg4aiTtg6AWe8lEZj1DaIdLrGZhvR2mFY2vdiBDZxqXyFdTZwMQlCBzp/zUPQ
         RmrC8U0XEKsZd/HxFXMLRlIq5Miz/ZHO5A5wJNLb2uZh6QSDQROe7Tzk4OZP1ypitMrk
         cWHmZHzG0/DZcXNmhd39sxZuojnrPLXZ53+Gwb4xEbimjFTA4hVtxoGIYMDKbbTxWX/4
         yrBhGnH3Hd2cCi+1nP4eUiIO5hdaWDccwiUWgUi4e0/1rETjxFqn8cqImsy4vfeJ4yEq
         00N1P2x6fLMb5dE0YhYi6DlQo8DYopDF7dj02ac91/WWREgE5yKCsXkRoexWb4AfwcxR
         9Caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708399849; x=1709004649;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rya2HgvW+Xi4tj3SP/SQz8BRtKWPoxSEUWYiMF+BFQ4=;
        b=q3yufuHUm0jLEGU9OqkHda2V+FCtWYNmkcJXHiC+OjWfnTg50lKmdv1Aps9EXeB76Y
         WM1DC+nXiZlJV9JKfnAXFJ0yCP8vrwfPGQvOrZxFI6DZvGzzncFM8sBcNls2JgwG6iG2
         eQw7oLtUaOVXutZ7OsW/NYdUZO9nEbIGAlnj0c+tQX7avkgJexgTPjuuQffTNbaZH8+q
         MgWVkHNU8BL4qfz1GIO7c4QEgv1QO6uyBs8UqBJUB2qo8smab3YwByV7cHoYIQu5STlz
         ErCFT0R6Q2gzS04ZvKk7WXvyrkT80juV+GdRR+KtOvEqdnkxRXnk2KGQ9adS3p28LUCO
         4CxA==
X-Gm-Message-State: AOJu0Yw96sLAD+MSfXXNnHALtdVauTyIfK9rtLAHuxLG2LHfTsDqXB+P
	yn0L9s+GApJ5/TRZLdy2no9I9gRBmhtLe/cmkEmaZrA4wdBwLrpzOvSs4lv3EeiSTw==
X-Google-Smtp-Source: AGHT+IE8PXpA8sAvg3kS/Ujuw5PCbCRGj58u1TcMLkDt7lzp7cXSL2MTDuR0tBhjBw8NKt8Yjh6dqQ==
X-Received: by 2002:a05:6a20:e68d:b0:19e:9a75:7851 with SMTP id mz13-20020a056a20e68d00b0019e9a757851mr17429460pzb.3.1708399849202;
        Mon, 19 Feb 2024 19:30:49 -0800 (PST)
Received: from [10.197.96.0] ([152.3.43.40])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902e55100b001d8f2438298sm5081402plf.269.2024.02.19.19.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 19:30:48 -0800 (PST)
Message-ID: <1d66eb0f-077a-4a63-8acf-f383538a41c7@gmail.com>
Date: Mon, 19 Feb 2024 22:30:44 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] builtin/stash: configs keepIndex, includeUntracked
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
References: <20240218033146.372727-2-rpc01234@gmail.com>
 <99346639-5a36-4c2e-a5d7-035c3c1fda8b@gmail.com> <xmqq34tnyhhf.fsf@gitster.g>
From: Ricardo C <rpc01234@gmail.com>
Autocrypt: addr=rpc01234@gmail.com; keydata=
 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
 jjbjCH/5+g==
In-Reply-To: <xmqq34tnyhhf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Junio,

On 2/19/24 21:52, Junio C Hamano wrote:
> You are however right that this will confuse the toolchain.  These
> two commands we provide may not be affected (or we can make them not
> affected by changing their implementation if needed, while we add
> such configuration variables at the same time), but third-party
> tools and end-user scripts that has trusted that when they write
> "git stash", the command will give them a clean index and working
> tree will be broken big time.
> 
> So, I am somewhat negative on the patch in the current form, until I
> see how the plan to help third-party tools and end-user scripts that
> rely on the promise we have given them looks like.

This is an issue I hadn't considered, and I'm not sure whether it can even be 
fixed. In some sense, the entire point of this patch is to allow the user to 
break that promise in their configuration. However, I'm not sure how big of a 
problem this is, as it is entirely opt-in (default behavior should be the same 
as current behavior), and tools can be altered to pass `--no-keep-index 
--no-include-untracked` if they wish to force the current behavior. Either 
way, I would like to address your concern if possible, and I'd appreciate any 
ideas on how to do so.

Thank you,

Ricardo
