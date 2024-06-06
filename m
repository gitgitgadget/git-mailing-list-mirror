Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D401199389
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690649; cv=none; b=kOBIocEl5P+b4+nlBR+hF7qvDvRPI95GWUza3qz8ebPQpbgo9oXtqfGHaYShpfxeCuC4vbgxcuCDf+PzAEUVd3qX3VJc2UM1pg6TP3C/a8RaapnEuQw7KCR4m//4+szQkTQQznAIzZc4uviLsbQGsNcCAgSqCCnWYVyCN56hQyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690649; c=relaxed/simple;
	bh=54cUno60y3/twhSToWsflJ4MS+BcCbmx/4hfs2X8D1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fWrinszVoyPZOhziublj2pDzGGZzU8IA/UZCwQzg6wkiTMgYUoOC2MrcbBEkonujGYWo/q7AY/Izx+fRTQQb6deNOC6ohTpioDbNsRZLVjZo9YeQOF7b7kNmcbYPeEXXvwKnog239GYhX50jIUgKkn0RCFT/FDS20TNrx7drFGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3vrMufh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3vrMufh"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-421555a4454so11812785e9.3
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 09:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717690646; x=1718295446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2DMMweg/cD4Wq46uvVOv1LyXqh0qaHqS6Huaws3KHhY=;
        b=C3vrMufhedQ4vLr59xbpVQRwsOapA6TE4eQjM96zMwaxxKgOEfuEqg3EoX0JjuOweY
         TFXmGghNqiKwdn75jrC56v+RLzwIjkJWPKTrqWwHUP5zL9kcOM8FHINJIGh3uJFKiI6H
         Cs52rpgCfEgfhSEuc1wheLsF/mNY6kISrfv0Q8nWghAkTetuPUpYKK18d6OnCSd0J504
         SDEuyuNuWOjubGK3iynbA12PxQf1qJVdEjnkl/Lyv3tXS8d2eLuqNt1Y6g3iMTn5j7I4
         b4oskT0tAoBCJM+6ixJBggeCPom6NaItPG0IEtaAqla1d1lEaAiFDP5I2HgFKDG8bUK8
         JU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717690646; x=1718295446;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2DMMweg/cD4Wq46uvVOv1LyXqh0qaHqS6Huaws3KHhY=;
        b=bwEsOwEXujxx8lyYje0uR4O1khnv9fJUwG5x5b5vybQXNCwb9pk4QhZz3w9JJM04Xt
         iavhyciN2KVYTo9xVG1DKqjTFWwZ7q1txCK2XW7dbmmFpasWqcHZmtmXBQXLsUY/Rpt+
         D+cUCDmzoZ93FNYqKwv04DuCSiWSFEg3d9kPzKjD22TXSvnPR5b4GSq2Xr3k1X79jgg6
         dIPkjYudUFN8LYnaw0GkIzArPHt0ENZ6VYxkpKi5RZnKsuRoqMqBRmpU23b7PSdxds5Z
         Za+QLlIpAiqz4HYjq2PJbE22foCldXOMMUhZ7JjUnhBc3g+xpxgiND9+vRUXnrX4L3g8
         biZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMGh4l7ChFUVocu4MtvzpHFNqC+5VzO9zfjSEwIsoaXr43Lj+QrBj3grp1nzrO4VsPbP3tQfGOEKbyHpa1ESQZ1gc4
X-Gm-Message-State: AOJu0YxPGzyW7/vpoHiIhgN+GA84ueoiJxX4vZta3qsslb3nHLDcF9i3
	ZrsaA7QpRyQdJI2HvGMJBGj5i+rDgUW4xrDtQn1WpNrRkUlDOk3hgxtQvQ==
X-Google-Smtp-Source: AGHT+IHzUgg9+J+e7aNUhO9ucXiPrMpMUv7WT5Uuv32sJ4QLm573IvbPq56cAdhwhQerocuO7EStiw==
X-Received: by 2002:adf:f292:0:b0:35b:1d7a:4868 with SMTP id ffacd0b85a97d-35efed1d4c1mr81358f8f.6.1717690646178;
        Thu, 06 Jun 2024 09:17:26 -0700 (PDT)
Received: from gmail.com (200.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d49de3sm1915458f8f.37.2024.06.06.09.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 09:17:25 -0700 (PDT)
Message-ID: <c2045a59-fa36-4c42-b270-0b042ff6248d@gmail.com>
Date: Thu, 6 Jun 2024 18:17:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] dropping stdin support from test-terminal
Content-Language: en-US
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk
References: <20240606081724.GA1166769@coredump.intra.peff.net>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <20240606081724.GA1166769@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Jun 06, 2024 at 04:17:24AM -0400, Jeff King wrote:
> This is an alternative to Rubén's patch here:
> 
>   https://lore.kernel.org/git/d95180fc-8f8a-4e1d-987d-3aa0811be7de@gmail.com/
> 
> and instead just rips out the stdin feature of test-terminal completely.

I agree that this is a better approach.

I have no problem building my other series on this.

Thanks!

> There are two tests in t4153 that rely on it (and for which it was
> originally added), but I think the fact that we need to use
> test_terminal there indicates missing functionality in git-am.
> 
> So patch 1 fixes that, and then patch 2 simplifies test-terminal.
> 
>   [1/2]: am: add explicit "--retry" option
>   [2/2]: test-terminal: drop stdin handling
> 
>  Documentation/git-am.txt           |  8 +++++++-
>  builtin/am.c                       |  3 +++
>  t/t4153-am-resume-override-opts.sh | 14 +++++++++-----
>  t/test-terminal.perl               | 29 +++--------------------------
>  4 files changed, 22 insertions(+), 32 deletions(-)
> 
> -Peff

It has been far less than ten, laps ;-)
