Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3CC271452
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751386816; cv=none; b=X0KSWKLaR7LMYL9vPHglhA7RZgQtTRtXwKj34iTALc548BVaGj5qHoJEbcmyk+QJUmPcgRiwIvK0fQLJzgS9WPyn3mg3m+qO4iUO5I/hTiQg782kBePk/wo+OwOnwuwbyHODIc70+zK2Qfn5pW0juYq4HE9w83AA1JNb/BsXOTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751386816; c=relaxed/simple;
	bh=JeyOmgXk0SkI1VSyvHtkFhdL4A+Ghtwhlvj79h+S3zk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FYIvtpSi8YunoiDzFu2VdtdLaYR6FCKhjaRvn2rdv1BjcQOXuqXZZLpSq/rbGOuteQPFKV53X/Y8Q0/jEi25Uqose1kXpQxeUltmpS/R59JS5sartG3dv1wTDBlELVYkrkA3W/6rL2IThVbU/J1LZIjH8YdnQSNHuSDo9Sxr9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfaX9AIE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfaX9AIE"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23649faf69fso30941825ad.0
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 09:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751386814; x=1751991614; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5Q5wmVIYo1src+PZPENi4qSVd+WiLoF8erOaoc0ozQ=;
        b=HfaX9AIE/9e77ZPJhJ73xNwWTvD3obry80XIoFVldcbSvg83HdyqOcOBNMYmHnw2SW
         m+YzUBjjv+MwsLTx2PEossRmqLgrR7/jejN/26TUkX4R6YLy4I6N1RLDgWDfqZ7NZ1da
         L0t2qQwqDxWmGuyi8jLJYgR05yYMxn0yqWt2z85mo0t5NY3zu9MuctOBFKtRiADNaWBB
         zDlrbKTtS/xVZlho4oaSy4RK3kJSIRjHgWfqgtebWMsDGUIh5BNSh3+fUzVHPmEC9Tn8
         QOBGKgYfYUrpNpXi0okSzd1dFUpn7NX5gTaQQr61m1Q5oQ6Pghd/KaVIT3K4kU1aDDC0
         fz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751386814; x=1751991614;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K5Q5wmVIYo1src+PZPENi4qSVd+WiLoF8erOaoc0ozQ=;
        b=I/g+u24WUur6Du7uZxty578OHANisF1mb4Nz9npFLprtM7R6efwLYA4FOnvRPKB1FK
         xNGYiDOXMbsT9RUgcV+O4l9Cay2y6wYLcN5Xkauejdyi0s3Zf0sWEN9s/Gfat0PGY/bI
         KjQDzn6kiU9p9Rsq6phclD30byjwz+7K06KNB7oIizpS1m4tPsie0BpLYf0ikI/lbnGa
         zeppeZhl2FiEFogQxzriG+hV9/5ev0XfUq9HU2Jszx831kd0kumKGWqW0+tAN5UdRvOo
         9gKm8k3J/VjO4vXKhczdP2ZS/yV09csIJGsKJ7s7K2KfSbbRfhw+ySrQlAHFYB2fAkoR
         lPEA==
X-Gm-Message-State: AOJu0YzCvcNqoBV5R29LSJs/cVHWBKbmT7X5GjUzPrX6FarqZ1ACEeyB
	6EH7MiMIA+LePaUr9Ris1QErNs6jxpExTEoFv0+jxCYr8wHxBrobHg+MTXJZ4w==
X-Gm-Gg: ASbGncutZUUC+kKXbVR4/MeoddDGDJxnxAKdFzYZY7KlRqbnssLen0UAkPjPW1PpT/a
	VEvP/wAB4n83riZCZApDHS3m0A/88565u98W6tgipMPEUfhJcdeCZkc9u5eXivvV6JeJT1Tyd4D
	0/mvkuLHIZyUeOhroILoOToDZgeTBfDBSJDS4/EfL9UaG0hPkYHxP3ga4CD15bhdKqEsz96mYP+
	9Nj3kjtyrFQ/ethwMCfjvzJymDoztA+UDiFKWZo+6wHuDQFNTMpCVyotMipTyqzrpUwPZaDmy46
	fjnaWP3Hb6NB96BFxTZ7xZXV+9ibi+tlQ10iKXtm1hOkrESZNgBPg3cXAtRSIC65kV8Lmkpv0/+
	sSAEDvic5csHQqW3fpkb+8/JB2ZI=
X-Google-Smtp-Source: AGHT+IEsnIpKrYRXf5iX/u023JQE8liE2rIrxdatBi8NvG/7SnHmk1B2d/IAow50+4pT67pduQW8rg==
X-Received: by 2002:a17:903:1c8:b0:223:f9a4:3f99 with SMTP id d9443c01a7336-23ac463414amr281087475ad.29.1751386813423;
        Tue, 01 Jul 2025 09:20:13 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3b932csm107614445ad.182.2025.07.01.09.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 09:20:13 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Git PLC <git@sfconservancy.org>
Subject: Re: [RFC/PATCH] SubmittingPatches: forbid use of genAI to generate
 changes
In-Reply-To: <CAP8UFD0bd1PD03VPaenAd+76Q6CeCOmDOJsso1nMKk4tZ4vbMg@mail.gmail.com>
	(Christian Couder's message of "Tue, 1 Jul 2025 12:36:24 +0200")
References: <xmqqcyalm0mh.fsf@gitster.g>
	<CAP8UFD0bd1PD03VPaenAd+76Q6CeCOmDOJsso1nMKk4tZ4vbMg@mail.gmail.com>
Date: Tue, 01 Jul 2025 09:20:11 -0700
Message-ID: <xmqqms9nkhms.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>> +
>> +[[ai]]
>> +=== Use of AI content generators
>> +
>> +This project requires that contributors certify that their
>> +contributions are made under Developer's Certificate of Origin 1.1,
>> +which in turn means that contributors must understand the full
>> +provenance of what they are contributing.  With AI content generators,
>> +the copyright or license status of their output is ill-defined, without
>> +any generally accepted legal foundation.
>
> Here we would forbid licensing any "AI content generator" output, not
> just AI code generator output. So what we would forbid might be more
> general than what QEMU folks forbid. For example they might still
> accept a new logo, or even commit messages, made using an AI while we
> wouldn't.

I didn't think about the distinction you are trying to draw when I
wrote the patch, but after thinking about it, I think it is a good
thing to prevent us from adopting a new logo graphics somebody may
have ownership rights without us knowing.  I would consider the
commit log message as an integral part of any "contribution", and
read the word "contribution" used in the [[dco]] section as such, if
the rule covers the commit log message, that is very much
appreciated.

>> +Hence, the project asks that contributors refrain from using AI content
>> +generators on changes that are submitted to the project.
>
> Here it looks like using an AI capable of generating content to just
> check code that would be submitted could also be forbidden. I don't
> think this is what we want, so I think we might want to reword this.

Good point.  Asking agents to proofread and suggest improvements is
like asking your friends to do so.  Care to suggest replacement to
these two sentences (above and below)?

>> +Contributions in which use of AI is either known or suspected may not
>> +be accepted.
>
> Here also "use of AI" might forbid checking what we submit using any AI tool.

Thanks.

