Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B6810FD
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452148; cv=none; b=tFTyw1VkWVoiIGGqCm4YD3yVcKCYXPtzgAmF7GpL8y4RnVraQaDf2m7gd6O3AuYEpqC4NH7HbJ0cAb8CNMgGxT3B+NsxJKHnxa0YxfE5Cclcqude/o2A63YpxpclJ+W1RS6qRndG/DSH0vOy4AD4SVrD+gCVmTHzuCNuKejxrxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452148; c=relaxed/simple;
	bh=urFG3M9rUjsN4oBzONcSXmu/8OENRW8laEkxAwsCPWU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ed+9BpKunRNtauf/L/eyvATBkXIBXqSXxOn1DGH2RUV7EXxbzISgTX3GANfxa2GgPJATTp3HXwFCVtTlOJxHLUONNbcrLF7JS7sNNzadKIHTi8KDooIjGVtjGAbNeXuvfEm8gK/kv8Q1TgiDRcSV/CZncCYHtHT1c2Fo3zPBlIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlA2arar; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlA2arar"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so1974997f8f.1
        for <git@vger.kernel.org>; Fri, 25 Jul 2025 07:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753452145; x=1754056945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cc0kcslrfZYTVGTYvSsSmOChttgtoOw/UUKCfRTLZLs=;
        b=AlA2ararj4tb8Wvq8MI/Cm9bk0A7BzkjXPgdIB1s6uYqJRzHkyUeH2s/hAnHavXmws
         JyFCcJ6fCtna9OXPRSqxoJZN4/2WAdO+/2nr7J+xdb/FDptvhGHTTWXMQAaBgF6Z6h8X
         k/KeMSHMRdP7nDLttHS+O94pTWU4DQ/gXPfMIFNXVA4zdDpgmhv0gnFXrRg/L1VbRcWq
         oyj4/OHEz6B2JdtZLPLEaH1OfNzgFLolwgtjVMu79KwJSX4xO0kn1Wd+qcwiT3bge7QG
         wAVRwc3w1mO4FDdZosyTTWPjYBwVCv2bZE1s8SzIr9iCXJi2bWIvwfTvevQauJ/PC4TE
         GMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753452145; x=1754056945;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cc0kcslrfZYTVGTYvSsSmOChttgtoOw/UUKCfRTLZLs=;
        b=g0+PUf852NdEmLkqgBgxiY/7cmQsJWCpmIMVNdh6/mJdSpjw8DTedJRKCTEPXsUKeP
         olahNFW703PLYPf9iK659uO/hSombZyUQrVCr/h8UF6pRQ1oUhP9BoEEIOzWnTZ2AFTm
         WzFWPu2NshXunne2jVsVkIfCM5tcvSBR2upThl7qJN3V/QALmvlUqTA8HXujeRcJBmuO
         MzCbKYF0/fvWt5f2e7mx06N/BjAGd8NvHBHmVekI/Q8WTRC3/fhk+qairE8Q+m/4quUu
         VkiSOEEbQ1DWlNQzupHJUGSbAjHJcRG/o22IU/R4aR+AsRsdOI52b1W6U0/5rBsLpEx6
         pJ9w==
X-Gm-Message-State: AOJu0YyaCYt8+Lg0eqCGJAQkYou4XJoWJ7dRVNd6SXNLBCyESM+XiW9B
	NDKw7h7T+JhCrSA0/r78f1DryjuKsM4IhsRhKXPUHNI50p64UBsPcrRD
X-Gm-Gg: ASbGncvCRa4NQhMRhCQlS2YVlSQA6D+elNZ2b2xVt1rXREdLfMwBUmvtHjMVdSnUy2m
	tJCowO/KtwUwNANRX+5e8dz/8u8jihN+sZgvArgX8KuCKfa6MoqhrY3MT6ZvpdlZEVFw10QUV8X
	W7ZAD70jQUNoFYxDZPRj1uWv6cI2yIOXA4Kp4BsVa3pkdPfPVC4zR31nbu+AiiGZqA8Nh6xn50Q
	AmGGp/iIGYvYhphucwOD0y1+XT6c+yhuklJMcb3RgXTjM/Cix+hPr6nI3tIgwY8mm2hc1Dg2N53
	nUKsDRgaLJD7zZ3pfvYW9TBxJKbDulzcz3oJPS1AhdOJxyUVosQVDHRF0ok8MPMm8sXIlmKcNaQ
	69+Z0vROCZgN203Fmf8SJBhvA0CmwxyWmu8kHyZ8X5NZHO09vE7CTK3Xk/ByFCjmCGJePr2/f+h
	Jc
X-Google-Smtp-Source: AGHT+IHphnCJhksJyqWvyJsvrXmYbLfi9r/xzvlad3ELnJf0D3xDksqImqJOBLEE/BfyIb9JtN9rMw==
X-Received: by 2002:adf:f54c:0:b0:3a4:f7e7:3630 with SMTP id ffacd0b85a97d-3b77663994bmr1742099f8f.15.1753452144191;
        Fri, 25 Jul 2025 07:02:24 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcc3922sm5196707f8f.79.2025.07.25.07.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 07:02:23 -0700 (PDT)
Message-ID: <184ec60f-9431-43c1-bce3-405bb6b7f959@gmail.com>
Date: Fri, 25 Jul 2025 15:02:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Show skipped commit message after rebase conflict?
To: Junio C Hamano <gitster@pobox.com>,
 Cameron Steffen <cam.steffen94@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <CAAVFnNkdgXuUk6ziu5FkB=sAHzEOyiynQpQJFox_p_ZL9VGRfg@mail.gmail.com>
 <xmqqwm7xxn4a.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqwm7xxn4a.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/07/2025 23:03, Junio C Hamano wrote:
> Cameron Steffen <cam.steffen94@gmail.com> writes:
> 
>> Sometimes I run into a conflict in a rebase and I end up resolving the
>> conflict by removing all the changes. Then when I run `git rebase
>> --continue`, the current commit is skipped and the rebase continues
>> normally. Would it be possible to emit a message showing that the
>> commit was skipped in this case? It isn't very obvious to me in my
>> workflow that that is what occurred.
> 
> I do not know what level of verbosity is needed to grab attention by
> the end user, but something like this might be a good starting
> point?
> 
> Totally untested, and there may be implications (like, control
> passes this point in different situations where the messages is not
> warranted).

I haven't tested it but I suspect this prints the warning when 
continuing after a "break" command or a failed "exec" command. That is 
probably a good place to issue such a message but we'd want to check 
whether rebase_path_message() exists before printing the message. I 
think we could also read REBASE_HEAD to find out which commit we're 
skipping if we wanted to make the message a bit more informative.

It would mean that "rebase --skip" also prints this warning but I think 
that is sensible if we're doing it for "rebase --continue" after 
removing all the uncommitted changes from the worktree.

Thanks

Phillip

> I'll pick a few people from
> 
>      git shortlog --since=2.years --no-merges sequencer.c
> 
> based on their contribution to the file (not counting the internal
> implementation changes) and Cc them to see if they have ideas.
> 
> Thanks.
> 
>   sequencer.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git c/sequencer.c w/sequencer.c
> index 67e4310edc..677d6105dd 100644
> --- c/sequencer.c
> +++ w/sequencer.c
> @@ -5369,6 +5369,8 @@ static int commit_staged_changes(struct repository *r,
>   			goto out;
>   		}
>   
> +		warning(_("omitting a step that has become empty"));
> +
>   		if (!final_fixup) {
>   			ret = 0;
>   			goto out;
> 

