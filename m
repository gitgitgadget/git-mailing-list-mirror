Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0923FEC
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 02:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727922997; cv=none; b=Y8IL85wOcLcoHU349wBgY9YYFMt+L1W86nDWLitMN8h0TJ32fpvB9K0dQ2aLasoP8v5d7h/dEBs06d7hfxlyBJD2NAdeW5zy567wVl4iBYrREpnnfNQTo46jSQ/ud+XYGIeQX9DETI8gDqg31SAjrAZfLHDkxctZAZLiukbYPHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727922997; c=relaxed/simple;
	bh=xDrgR0ppnh/gJ9ZbAq//GQPBFzU9+f68MbcHxyMtWIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rG6rPIr4Dwer3n1stGD75uOumHXuxifWq87a9awj18m5OUnu621RIVGpoHhdBTcrqPqQVp5dUFRUe/iXZzx+fhYvmJ1aDjWzDwK4PRpZ/taF5qYVr+9MVg+zueNt/FHdW+FfI0FXmX1yQr8jUua49wejwPGRVwJS8gHCxBmH4g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qjm/pJsM; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qjm/pJsM"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e18293a5efso342798a91.3
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 19:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727922995; x=1728527795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CtcB1fYuZzftom7qVfzH6I6yWjmmqqHdhODjO1ueu6w=;
        b=Qjm/pJsME92mq8G1XwpF6uD8s/OLngDkiifPcgTEOflVjAVz81DgnREiKd45HUWQVY
         86ER6ZDJYz328oqSiVZbMmSlebJ2RpVjrQww2nWvn/EtOLJ/1y+uwPSFW5dvtK/FZ9Ch
         oQKtRPvN5U7efhhTuW5HavXERVqgGf/Viw84lGVBlzjGEwOhVr9gHNbI9sJwyj+PDu2f
         MV19Mcra7xUQ9731BwDc2O31jpua9uY3w5dV0gOOlPK2H8vm60Osmrq9ApLHgue10EGO
         jtKpiX+BMkPD1ma/G8o0Qsv26Il4p3TU56sTkgTIL5zm2i/AsHijPiyM/cSGLAxUdij4
         i7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727922995; x=1728527795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CtcB1fYuZzftom7qVfzH6I6yWjmmqqHdhODjO1ueu6w=;
        b=NyrwYAdbU9vbnWejVzfRV5mZDzfyk7RusuOml3lxoImwqgc6QX19UQnqH+8cIjnNUb
         T0rHjrPPscwMD2pmy49OQoi4NJtT/D6MzeLxaEKIOZKHkV2kkReB8TW9+k9OugQSwHh3
         4w2QuNdWvAj3bT5M/9LqbdPVgrHyDN2GRqhfYR/L0JwyInUss99/J3M/v3h/WNFC0W7J
         guuMIZPaLwfZogrsUjGE0J/MHONYbUl0A5DScMnPA15deDDvBlmr+G7KZSgPsj3BFv4T
         mRwrZxG4yhycFcsCNCPl/1NIsQ441KQlnEwHGfAg3izNhpU/IAJWsizUlUuOXIavFrCQ
         uMCw==
X-Gm-Message-State: AOJu0YzEKNCEUn89iTRJQCK4iOIx1riTKn9xu5kdqpODuTpqPGvlh9Nt
	vqnUQAaCSVNcKz3rEatKPov09jaUF6kJ2PSzD5dEGMyv6+GpitbB
X-Google-Smtp-Source: AGHT+IEH6v9a5om7xx90Tl+web1XS2rfCU/CJ9wup5Zdc1N82EQ6CFZcta5CHZ3r8RWrruRjDIuDPA==
X-Received: by 2002:a17:90a:2f62:b0:2c2:5f25:5490 with SMTP id 98e67ed59e1d1-2e18493e7e4mr6203262a91.34.1727922994849;
        Wed, 02 Oct 2024 19:36:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:b038:cb50:a5ce:b021? ([2600:1700:60ba:9810:b038:cb50:a5ce:b021])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1bfad5e01sm279832a91.3.2024.10.02.19.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 19:36:34 -0700 (PDT)
Message-ID: <1fc0d162-9814-4d94-ac67-2ea8e40495f4@gmail.com>
Date: Wed, 2 Oct 2024 22:36:33 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] line-log: protect inner strbuf from free
To: Jeff King <peff@peff.net>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im
References: <pull.1806.git.1727885224966.gitgitgadget@gmail.com>
 <20241002235639.GB3455554@coredump.intra.peff.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20241002235639.GB3455554@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 7:56 PM, Jeff King wrote:
> On Wed, Oct 02, 2024 at 04:07:04PM +0000, Derrick Stolee via GitGitGadget wrote:
...
> Good catch. Your analysis looks correct, though I had two questions I
> managed to answer myself:
> 
>    1. This seems like an obvious use-after-free problem. Why didn't we
>       catch it sooner? I think the answer is that most uses of the
>       output_prefix callback happen via diff_line_prefix(), which was not
>       broken by 394affd46d. It's only line-log that was affected.
> 
>       Building with ASan and running:
> 
>         ./git log --graph -L :diff_line_prefix:diff.c
> 
>       shows the problem immediately (and that your patch fixes it).
>       Should we include a new test in this patch?

Thank you for sending a test in your second reply. I will include it in v2.

>    2. If the caller isn't freeing it, then who does? Should diffopt
>       cleanup do so? The answer is "no", the pointer is not owned by that
>       struct. In your cases (1) and (3), the caller does so after
>       finishing with the diffopt struct. In case (2) it is effectively
>       "leaked", but still reachable by the static strbuf. That's not
>       great, and is a problem for eventual libification. But for now, we
>       can ignore it as it won't trigger the leak-checker.

I agree with this, including the potential for cleaning up the static
strbuf and using the 'data' parameter like the other functions.

>       It does make me wonder what leak Patrick saw that caused him to
>       write 394affd46d, and whether we're now leaking in some case that
>       I'm missing.

Looking at the change, I can only guess that it was the previous use of

	char *prefix = "";

that signaled that an unfreeable string was being assigned to a non-const
pointer. This signals that _something_ is wrong with the function, but
the way that the buffer is returned by the function pointer is suspicious,
too.

> I do think this would have been a harder mistake to make if the callback
> simply returned a "const char *" pointer. We'd lose the ability to show
> prefixes with embedded NULs, but I'm not sure that's a big deal. It
> would also help for line-log to use the existing helper rather than
> inventing its own. So together on top something like this (which I'd
> probably turn into two patches if this seems to others like it's
> valuable and not just churn):

I do agree that changing the return type will make this easier to prevent
and the code should be easier to read as well.

Your diffed patch looks pretty good. I made an attempt at guessing where
you would have split them (first remove the duplicate method, then change
the method prototype and callers).

I even took some time to attempt to remove the static strbuf from
diff_output_prefix_callback() in favor of using the 'data' member of the
diff_options struct, but it was not incredibly obvious how to communicate
ownership of the struct which would need to store both the graph struct
and the strbuf. Perhaps this would be good for #leftoverbits.

Thanks,
-Stolee

