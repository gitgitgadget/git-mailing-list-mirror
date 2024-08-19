Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A471BDCF
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724075849; cv=none; b=gydXs9I6uib8mNoUIR9bsnBvbC5O3tFQl9vHo17H0+l3NgfNCFdOahQ72IHUc+6DgJLjFQbGmG1F1O8Ew/cU5jFG+frFIYwI7F0xzzSl2vwuXBZf7RtwdF3BVauSnohGr7j/p8lxRJNg2gGhf20HmP/7WXoaqahBnvgmRsvfvD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724075849; c=relaxed/simple;
	bh=YEnQw5LvhwtHOBrcwyDYddqCIYRB7iG+9FW0/7BtmPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WcRuw39Ho1pa2NJ1tBGiJLEqBlAJXiM5xQ0Xnbl3kkYTKxIM5SJ2eCOJwk44XJWrahgJuYPDxzxz5CNRRRXa7SoSV/V94jwtw89wEYHXawgLDP6lG3JuD6+SWF3vCvPfl2I1DJ3tuDYgF36A60+6TJwnGRzr6HfSbPjJC3oDCZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAxFyvWN; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAxFyvWN"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3718cd91185so2242041f8f.2
        for <git@vger.kernel.org>; Mon, 19 Aug 2024 06:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724075846; x=1724680646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xCbNHZBImN6CGJFP6Wzl6+M7fQSDpEZ+Bi9pM0Z1mM8=;
        b=CAxFyvWNvMzwpUSP3vn+Y9+0WuFA8lBpX2pMUtHn7R5/f/DUtuEnhiiXDakPg4iJcP
         pov94qWNU0WxlcZYDk9BiHpAk7UeZF9EruZEPMcDcVi8kRY8j74SSS2y7vQVQbU+mpma
         zvkJ0XnANp8qMO4GTqv8oCoAYACWiP4sdCnIuUHOP8iqRBaDxnA7y7oMPTjY4RPT2xf/
         3K8aVQ8FQYvPYgOrDb5YWa7H/konFpmnIZdCaLUC7pigcNZHkLcGXONjt3QLlHP7kc5y
         LsirBVqreuXe1XVnymJk3j4GjkzupwzN5ZtGQzwu24IErVO5qAjF/eJysctM1Xh0onF4
         ZAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724075846; x=1724680646;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xCbNHZBImN6CGJFP6Wzl6+M7fQSDpEZ+Bi9pM0Z1mM8=;
        b=br+Pd2k9u28l/cVtWbVnCAJorR4U0K//g0oQI+km60aIO9BVFKO9HTclj27HBBgnaE
         0tWuXIL5xwKT1Kf04gxZxjix05KM6mTnHkEdfHwjCIavyKV2C+dgv5Ss30IPTTrxk75x
         Ys9oK/IgOhNHXMAtlC6KA3mQC5fXPat7K7EAd0eM1WS4PHcaj7TAqC/nd5Z6vwgnYr6J
         eWK5ULJJa17Bm181EZ3ZBq30+XC2IB4jg1FKCCWvxM2oi7APlv/VuVoODRNudcNVCovN
         eubLMNL1cP3bOJJ+wAmelIFW8ZSVMN++coqzxCcA8GRiQ6bngeQBunNnsKPeFaUmGxOO
         iUGA==
X-Gm-Message-State: AOJu0YyW7U2bBkJj9JqgSzhHbpcKVW2cbqF+Uh21RJjTfgyLY0uQN0qd
	grefnjUtGevOznlEpksYVCHU+NSpAohQEJHWXt5vZrdMQqs3Z1BW
X-Google-Smtp-Source: AGHT+IECSKgm8nJvtUDCm8YVQ0GpXslrmQQbkl4vma9WltPIciLk2wSkXnOvrrmFdhy9qKcYlXD9Bg==
X-Received: by 2002:adf:c089:0:b0:371:8ebc:a2 with SMTP id ffacd0b85a97d-37194328d7emr6411830f8f.21.1724075845470;
        Mon, 19 Aug 2024 06:57:25 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded19839sm169697955e9.6.2024.08.19.06.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 06:57:25 -0700 (PDT)
Message-ID: <08dc334a-e1d9-4aa1-945e-c543de549163@gmail.com>
Date: Mon, 19 Aug 2024 14:57:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] rebase -x: don't print "Executing:" msgs with --quiet
To: Matheus Tavares Bernardino <matheus.tavb@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, newren@gmail.com,
 ps@pks.im, Lincoln Yuji <lincolnyuji@hotmail.com>,
 Rodrigo Siqueira <siqueirajordao@riseup.net>
References: <767ea219e3365303535c8b5f0d8eadb28b5e872e.1723778779.git.matheus.tavb@gmail.com>
 <be3c968b0d9085843cd9ce67e85aadfaaafa69c8.1723848510.git.matheus.tavb@gmail.com>
 <xmqq34n3jswh.fsf@gitster.g>
 <CAGdrTFhZ6KeDPDUoCsV3h5myPuoYf7RR8eFdbFFXGrUGCdEkEw@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAGdrTFhZ6KeDPDUoCsV3h5myPuoYf7RR8eFdbFFXGrUGCdEkEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Matheus

On 18/08/2024 14:03, Matheus Tavares Bernardino wrote:
> On Sat, Aug 17, 2024 at 8:22 AM Junio C Hamano <gitster@pobox.com> wrote:
> The idea is that, when running in --quiet mode, we don't want to print
> anything, not even a line-cleaning char sequence.
> 
> Nonetheless, since these are invisible chars (assuming we haven't
> printed anything to be "cleaned" before them), printing them doesn't
> actually make a difference to the user running rebase in the terminal,
> as they won't see the chars anyways.
> 
> The actual issue is when piping/redirecting the rebase output, which
> will include these invisible chars... So perhaps, instead of modifying
> the sequencer.c to use "if (!opts->quiet && !opts->verbose)
> term_clean_line()", the correct approach would be to modify
> "term_clean_line()" to return earlier "if (!isatty(1))". What do you
> think?

On the face of it that sounds like a good idea but I haven't thought too 
much about it. These messages are all going to stderr rather than 
stdout. If we do go that way we'll need to adjust 
launch_specified_editor() in editor.c to either suppress the hint or 
terminate it with '\n' if stderr is not a terminal.

>> I actually would have expected that this message ...
>>
>>>                        fprintf(stderr, _("Stopped at %s...  %.*s\n"),
>>>                                short_commit_name(r, commit), item->arg_len, arg);
>>
>> ... goes away when opts->quiet is in effect ;-).
> 
> Sure, I can add that :) I was mostly focused on the "Executing ..."
> lines, so that's why I haven't seen/touched this one.

If we're going to suppress this we should probably suppress the message 
about amending the commit that gets printed after this by 
error_with_patch(). There are a number of other places that we ignore 
"--quiet". stopped_at_head() prints a similar message to the one above 
when we stop for a "break" command and currently ignores "--quiet". 
Should the messages from "--autostash" be suppressed by "--quiet"? What 
about when a commit is dropped because it is has become empty in 
do_pick_commit()?

Thanks for working on this, it would be nice to have the sequencer 
respect "--quiet" better.

Phillip
