Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399E6137930
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721073856; cv=none; b=rL+De8POLrzMB56jXnveKnlxr6zvWpINFIvbKXSh4wDObSDiHb1KR0jp2UrV7ndiTUCIorrdr42I4EwfmLlHfft+G2o9hNoNfkb34lxI1J7WW5ZvdYQ0mxXT1rLmcubCiL2AlxIgLBnXzDi7LCYvySX016hHywMM+OKIlSRlHqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721073856; c=relaxed/simple;
	bh=FvGUTyUapCmkfdP9uaVeL05XiT0sK8A+1v2mlxNlHs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fi+Td9880LM6JVoFUnN4ohiAHxYBigRMyKuw+u0J0ZaBS+Z+ySuGVHHysS6fC+XlbfpNOEXcp3Q2Ff6Odq4Two987f+9F8ShxbnOFsUpOrCgk3kIrUhEJDhULd+C4Vv7BeZN1lEV2HGJlqnMwjmp3bB7T5/3hb0iW1yb/HBeQEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5WWXYzB; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5WWXYzB"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5c651c521f2so2489875eaf.1
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 13:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721073854; x=1721678654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=COBiojbjTsjZTQABt+ZpXfh26v3ayTjCVK5gsTMOzlA=;
        b=M5WWXYzBrkuhUXHjrLjAcpj67O5B8y+xvw/OLPZ1i2jac0G1bJdROnfoZ+MOYPBYZf
         MCBtnaS3WRX92Un8hb0b0Kuc6gSAH/gbj6dIiwwlZonri1ANGCBFw3hPs5DH+EukAYIz
         hygIBI4hQLEuQkOI62NqQ8gvouffeuqdYe6WaWOb7j31nxGDq20RZqPqDHiFe5Hhq8kE
         po6HdbVd5CSw+f6trKcICGA0CuzCxeYhkJGhdUc69SYTrxBj8Hs0eoX+Pra48AMVKE7m
         i9n5dXtLmibu1L9ViEutQoZTkHxr/IIVCfsxoOwdcKjGokc9YmgdeYVXGXy7MNXOVEyt
         6Haw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721073854; x=1721678654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=COBiojbjTsjZTQABt+ZpXfh26v3ayTjCVK5gsTMOzlA=;
        b=YaHadngvFmKZkGLApRxzT1J2dmGZiOSmYnbPmSVL7mEq5GnVG5ncGWeuHEFPrmNrcI
         srRDNyzNbP0CAWuHOydqGUCgx873p3Oxi4rkKtPGREn13rd1Qv5zouqCky6dS5A5of0l
         M4+2NWp4nVkTcLEABuk7popq+KapVhbFLiy2uvMxTEhcLlNiil1AC1fxdt4SUs9zPE/R
         cn5sRU2twQaIQXxwQy1rq2eaIJoZobqH9v4GXs5ShJ9BD+k/Y7fPnfeFKQ7t30YKOOfA
         8qSEzVPBFySo5oX4q6YiJVrdstx2bqHRx6BkOVOpyAs6LfFAa1qJdIGnQ2Eg7COj6Ke2
         PaLw==
X-Forwarded-Encrypted: i=1; AJvYcCXVwpA44mNkCf6w1CCVfXqivBWjBSgs/ogZVWou4HSdOdftLFxCNqWbav3YAF1Vj8kpvNNbh6htJkhutzim0lfY1Ih/
X-Gm-Message-State: AOJu0YysOIrnPi9EbsnYR2TkjsM0ml5ukQde+gWFsGfg9TTAMGpuIZcQ
	CZqLZEhIlMokzmiEJLQ5Bqe0IjO+qgr9eopvBKrYqJptFkvqE/UO
X-Google-Smtp-Source: AGHT+IGoJrxPGEBtAnQvmE86bQqodL8eaoTMLuYqeNudOw24JXJlqjLWQ6gvDFpIdhSmZ/hZiOYHbA==
X-Received: by 2002:a05:6358:42aa:b0:1aa:bde7:5731 with SMTP id e5c5f4694b2df-1ac9050c28bmr10346055d.24.1721073854060;
        Mon, 15 Jul 2024 13:04:14 -0700 (PDT)
Received: from gmail.com (p4453252-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.169.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e34289397sm3699370a12.38.2024.07.15.13.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 13:04:13 -0700 (PDT)
Message-ID: <1e38a2f0-623c-46cf-b5c5-9e3a4b153cac@gmail.com>
Date: Tue, 16 Jul 2024 05:04:09 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] pager: introduce wait_for_pager
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <f48ac176-9938-4677-a956-350fb50dbc0f@gmail.com>
 <384f0147-d611-493b-a3d4-d83c65bd1114@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <384f0147-d611-493b-a3d4-d83c65bd1114@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Jul 15, 2024 at 03:13:09PM +0100, Phillip Wood wrote:
> Hi Rubén
> 
> On 14/07/2024 17:04, Rubén Justo wrote:
> > Since f67b45f862 (Introduce trivial new pager.c helper infrastructure,
> > 2006-02-28) we have the machinery to send our output to a pager.
> > 
> > That machinery, once set up, does not allow us to regain the original
> > stdio streams.
> > 
> > In the interactive commands (i.e.: add -p) we want to use the pager for
> > some output, while maintaining the interaction with the user.
> > 
> > Modify the pager machinery so that we can use setup_pager and, once
> > we've finished sending the desired output for the pager, wait for the
> > pager termination using a new function wait_for_pager.   Make this
> > function reset the pager machinery before returning.
> 
> Do you have any comments on my thoughts in
> <8434fafe-f545-49bc-8cc1-d4e8fb634bec@gmail.com> ?

Oops! I thought I had responded, but somehow I must not have. 

For reference, these are the points you indicated: 

>  - We ignore any errors when duplicating fds,
>    "git grep '[^a-z_]dup2\{0,1\}(' shows that's not unusual in our
>    code base, though if we cannot redirect the output to the pager or
>    restore stdout when the pager exits that's a problem for "git add -p"
> 
>  - We should perhaps be marking old_fd[12] with O_CLOEXEC to stop them
>    being passed to the pager.

Both points are interesting and improve resilience to unexpected
situations.  I remember that the first point was already suggested in
the previous thread.

IMHO both points should be considered with a more global perspective
than the scope of this series.

As I said in the first message of this thread, I have left out
interesting points that may deserve to be addressed in future series,
with the intention of not prolonging the discussion of the current
changes too much.

Sorry for not responding sooner.
