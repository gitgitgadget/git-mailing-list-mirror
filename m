Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5981A149E17
	for <git@vger.kernel.org>; Sat, 17 May 2025 18:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747507701; cv=none; b=Tm1XPQKNXSplge0EuQO0j30IGlN6DZzP82VNm6e5ZJY/gnUOmaFzChk+V8dGROuiJbQ/ukGU/jV/gXkBBQw8wSr6qT44buR/z2tvA044dM0OvsLhEaNPr339pMr6ytctL4BReJxtdgrL91VdUpWIsFUd14qD3ir0MMdVfxYPrfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747507701; c=relaxed/simple;
	bh=Oap2kxUW/NlaP/S6b9S8XRA07aeIHbvR3CK9IhHtoaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gRvWZnRa1u6/AMmPj5eGmjuOOkk7I4cblmUuRi6lp/JkLKYPUDHIg+KA6mpnyc208nvtTO4JEU5wos/85d1QywZcN18Z0xTh7xIK5ssS4AO3VIZJGc+kOItlxPNfCmeSRf9hHyw0si65I/tHCsS+lXXpq8qYivHWjd+FwQksIHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKW8NxQB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKW8NxQB"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-742c3d06de3so242163b3a.0
        for <git@vger.kernel.org>; Sat, 17 May 2025 11:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747507698; x=1748112498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=23RhBXE3takeXyA017S/D8aYMhHfjpRHCUdXtclz1Bg=;
        b=hKW8NxQBoPeB8DxseQMiYBdSBvrwMu7LDWyuTYDqqUBD4Al5yZ0gA4dlgiCrCZa6QY
         raGHbejCIJRJq+DlCE1g7t1AgEeBm7Cr2L+jxU/AdPLLhlH4xF4Mo/6P2r5dqW/BUqFE
         ULPcCGr4IcKBMylTwQyl83jo9t16+k70MtZpTSK8eRVbuCL2YUK8kgxsN7PWwwS0g3HH
         2onxeBJ1IS3vMudx5t8yV9QoHKK/gtvBF1+CvCeLcirvdfoTfuCtyf6s2hpG86BAgaFq
         /DFxtNTwsDM6aVRD47G4HxXin/Xy1h+HUdu5l2LZ5JT2HWJbo8pkr8krF/fk7oMruT8M
         ml6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747507698; x=1748112498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23RhBXE3takeXyA017S/D8aYMhHfjpRHCUdXtclz1Bg=;
        b=INMZsoNOUiq7/ll3f5pw9GrjDae1TRkiC/HsVG455SMN564z9otGddviyTGMujrCxC
         f8BghibYmsL89ncoIhTqjX0+V3GQdE2+Q8k4iGR0Jb2Y/yg2JShZQtVX4euvUqDqKkHw
         63HGztSOJZmF9uXt6Z5hlIrPUXy0YLcZoxID5glUuhywCKGGxfhuN6fbDI/xgg3bM68E
         Vj1DKH6I7W2bnHiIByexG++4kPKPtBF8XC3jfgIZNCdC6sD0TciZzyweZe01H8/ihRRk
         rCN6D2+4A+dPmSfFCt3TbJO2skM5StBxBfbKat8+hInGYpwTZpOhAvfHlT8CV8V/0u1R
         8qzw==
X-Gm-Message-State: AOJu0YyjI03rDAjl+FCdBGbydNxGnTy1UAf2vm5lNwCYfmcw42c3u0a3
	DrMh9gAJcC/kpR0rH5cnxoWKQBSjjTUNpnzlRzr5qdg44dlyFlEWuQBps33c+A==
X-Gm-Gg: ASbGnctDatSmQdzhbMfRsQE6GQRBFT5QwrS6+STp6cbLdea0UayxQ5Q/0GnPYKVILy/
	FvXritHBdTUsSi4Wfhxj+O5eLb9FhN/4+5ldc6nwZjfCowiYrmwJ2OaoLICF9XWcJG2KQWKBbZQ
	ErshbYnWgXducMyiT8iA8plknYAl9qmdckracJH6TQQXyA3fe0HnWMAcnQKeWLUYcXGMmdFFQmD
	Djq3+8IcWAloVUYjce88+Sy0mYgtr3S60JkmGWwRX+vB6/PKdMU8DdIhrqAVixahQhnXam/GVBg
	N+NAj1VZlHVLE/yo2iYtdsloOM0/YzYwHYPmk0cWHcmss0b4XOqXloULnSvzs+nKn/zNaMwiaGQ
	2wFnWlKghTsM=
X-Google-Smtp-Source: AGHT+IGFd8XdymPEJ+al/KB3ejJ7wQl5pwGcIcjhceS9yF6hxUGZNtzO4LnLlgEr0cW6bNn0Nvtrig==
X-Received: by 2002:a05:6a21:1089:b0:1f5:6b36:f56c with SMTP id adf61e73a8af0-2170ce39a55mr9627051637.39.1747507698252;
        Sat, 17 May 2025 11:48:18 -0700 (PDT)
Received: from [192.168.1.105] (23-93-88-48.fiber.dynamic.sonic.net. [23.93.88.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9876e7asm3566840b3a.145.2025.05.17.11.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 May 2025 11:48:17 -0700 (PDT)
Message-ID: <e2a24cbb-1438-46b9-b546-82c9f6dc7ebf@gmail.com>
Date: Sat, 17 May 2025 11:48:17 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question About Sorting the Index
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <1008ijb$6j0$1@ciao.gmane.io> <xmqqfrh3qe2w.fsf@gitster.g>
Content-Language: en-US
From: Jon Forrest <nobozo@gmail.com>
In-Reply-To: <xmqqfrh3qe2w.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/17/25 11:36 AM, Junio C Hamano wrote:
> Jon Forrest <nobozo@gmail.com> writes:
> 
>> P.S. I'm trying to read the Git source code to get a better handle
>> on what actually goes on in the index but this is taking some time.
> 
> Depending on the style of the learner, I often recommend reading the
> very initial revision of Git, i.e.  e83c5163 (Initial revision of
> "git", the information manager from hell, 2005-04-07), to quickly
> get a feel of what various pieces there are and how they fit
> together, by doing
> 
>      $ git checkout -b initial e83c5163316f89bfb

Thanks for the suggestion. I'll do that.

Meanwhile, do you see any merit to my idea?

Cordially,
Jon Forrest

