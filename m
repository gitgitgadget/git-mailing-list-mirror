Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D757C763E6
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463884; cv=none; b=AHlrYSpI3N1V6oJm1QBkn+/IxXa6N0VuVC3h2bd2uUjq3OeIsBuL9/9WZu46Zwy6gXKaR+I3juiB0LL+5R7f2qrcYsGbXbQbx0IQjmsdoqvtPUdhm0amZQb6VDPtBDroGs0/Uum797VZl2zhhJTSOMRSmXshZb2ELJzjFkbkg/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463884; c=relaxed/simple;
	bh=ky43tmnCuyM2GyN485El2Mvf66WW/Km/Z5Jded6fa9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4bddWKZsIj8EEAv6jKn2DUyuW99IVfGILCTECsWPFSOYzm9ZUG6uP1m47fORRv+9IpTdpiAx751rUeu0BrlbC3PfxKZ7om91dbaAzY8ChDwYwQM0JzR1oIeZubfOfhFww4cBo6y2neegedF8MMkc7vqnVw6hUdiV+Hu3nYI7eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHVS7OxC; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHVS7OxC"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a46f0da1b4fso715244366b.2
        for <git@vger.kernel.org>; Tue, 26 Mar 2024 07:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711463881; x=1712068681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fob6p2LQY5n4kmpl2a/9eZMqCE8syC80r0Zpnq48NYU=;
        b=DHVS7OxCWIgAXtFmd2BevbjJeBUKYM9lfxRB65UHDkjEcVXBujvWfUrTjNL6ttIGiF
         q7D4E4LXosE9RHZ/ibUeBGrOQ8GK/Lx4Mjxi7ErPZpf0kO23S2CA8da4Q6y6cMYFNMDF
         T9NGv9N35uPSQfiw+y+DYVwvM2OR/8ZbfC4WHDplFmc5Ye1wnDvF9dtWj9XvXtLzYNdN
         cTPl9pxavQyXboyESqyZYqt2fmYQRiz5Ihf/XcHtcdcucKydFoBncEFuhawkbJGxwByz
         oxGjKpkMON8GdqCqvw1i98Jg9NGKIsEySy9ltkQirvKDg7R2ZxMVRPDSYjCSFn2rILC9
         Ny5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711463881; x=1712068681;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fob6p2LQY5n4kmpl2a/9eZMqCE8syC80r0Zpnq48NYU=;
        b=UUYDH5YzJUvTpf5ipPUhY8KoPjrycatuEqJnLg/wqyB0lbjPaOXVNPvmEkl0ks7aG7
         HwyTdrt7zhNiBrLpZ80YwS5gcg3DEuPixY3gvYv9IcqwKOaah+dRBFGawFoq4ewcY3Ru
         i92qIcCAPs23akVgjXZhy2vpTz7aYRxN46vovw3nGl4hprkPO3UeovQYqQu1qa3aE2m4
         q7TR6dFYQS624T1qjxCdVBLdUDJEnIpOb4opnn+nGOohBDyjbNJhp56vjg1QB/9DKV/N
         Pb3bvdVwNJEKaVVnoGFIKutTzvf4gL4lrVUsdJcogVCFh5T+2zhB7JKe6bhC5Bdywp+b
         mK1A==
X-Forwarded-Encrypted: i=1; AJvYcCXTERULkkU6Ngh2gMTTtpjZsbZVIWtE+JEY4np3smQkk7bVbhFBEU5vKJHgMEltfYofZbIPyn+a+uEjwyFZxO6C8bqz
X-Gm-Message-State: AOJu0Yx236/hkVkAdY6SaPzUoXDHU7vbuF0EuXiG+p2j1iAK2npDD/uT
	Lby4zti0eIqomRLvag2vEeefliIeFInVqBLxW8ZY1Eu6mWmaYHHd
X-Google-Smtp-Source: AGHT+IGcdf7bO5uSGm+JVsFHlKq/AUo6UZ2rTWHsva3P9oJEjWgOvmtiTh8ZrXqC/2gMLxB/jbTTlg==
X-Received: by 2002:a17:906:84e:b0:a47:3503:cf43 with SMTP id f14-20020a170906084e00b00a473503cf43mr6681930ejd.35.1711463881210;
        Tue, 26 Mar 2024 07:38:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090663ca00b00a4a33cfe593sm2445834ejk.39.2024.03.26.07.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 07:38:00 -0700 (PDT)
Message-ID: <13a9164b-6ff8-43d1-bbdd-032cd2581034@gmail.com>
Date: Tue, 26 Mar 2024 14:38:02 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/2] add-patch: introduce 'p' in interactive-patch
Content-Language: en-US
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
 <34e027d3-c351-431b-97de-e15a2d5a9756@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <34e027d3-c351-431b-97de-e15a2d5a9756@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 26/03/2024 00:17, Rubén Justo wrote:
> Shortly we're going make interactive-patch stop printing automatically
> the hunk under certain circumstances.
> 
> Let's introduce a new option to allow the user to explicitly request
> the printing.

I wonder if we want to hide this option unless we've skipped rendering 
the hunk in the same way that we hide other options that are not 
relevant to the hunk being displayed. I also wonder if 'r' for 
"re-display" would better convey the intent of this keybinding.

> diff --git a/add-patch.c b/add-patch.c
> index 68f525b35c..444fd75b2a 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1388,6 +1388,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
>      "/ - search for a hunk matching the given regex\n"
>      "s - split the current hunk into smaller hunks\n"
>      "e - manually edit the current hunk\n"
> +   "p - print again the current hunk\n"

I think "print the hunk again" is clearer (or "re-display the hunk" if 
we go for 'r')

Best Wishes

Phillip
