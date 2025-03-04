Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210DA1F5826
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117898; cv=none; b=gmPm3wG8epm2zY73LgGZdRHAQKPwDVCiNv0X0f4+jU+tkAzOlE+JdOssTIY08rS0HdVjjgirKZDUYNx7FXVh+v3vK2Bs3ZcG1ngnPC/XFd3qhk4vW0sHyoDC1lfK8K4sSxDa49GqatJJ0bb2o2jOwQt4k0BnJpPHqSnhL6B8b80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117898; c=relaxed/simple;
	bh=22M8dHWLgkJgby+I5rFHD9m19YFDsyjz5pFJgOcopXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkxkPbeseMjPBOAXIOvU3bBZGbwHLHBrUrbGElSfZZW1QbhX7fWoRgm0/J6SNz9h0tP2DecGb54msGKyL7saE2ZHCajysr6NMc7AI9uHk5YbGGJfAePgYpGwt/5wzgc6gVo4Wl05T0HcgK84uRo2rZU1jOSTki4qRDJux4k00zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYOflq7R; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYOflq7R"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2bcc0c6c149so5266114fac.1
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 11:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741117896; x=1741722696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=82b1Ddf54nrPpRjXj4amjzFeTsGZL5QI2EvFAvNtWSc=;
        b=ZYOflq7RQEYjFJ43A9d0Nl4wzKJcl1CRJVzqAvKwWrKyJb2vLlselDquN18eLgJkUu
         VIjMqm8/f3yl4vNHxLeg358X2nI7s8DE6JAqSGF87RFRCL0RCCFt2gcHXywy9dfrcGpL
         q3TaHDnIzHtsRWxDNaB5JRbBtg2C7FDbj54VkkxJzbnqwLQP+MXtTrsW8I3LIAgAOlYG
         8GtnPmVa6UA1v+YJzdOVDLTbce8tiwYqBNdzcLcaGZ+KESdoeqp4iipYSKXkOuI9Nt3K
         orUtP0xPUedcy9aC/79OKKVHY3hKFDGfoh/fqSy9pXc1fuqpSM5TI77YxB/Ylg0zYBr+
         FRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741117896; x=1741722696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82b1Ddf54nrPpRjXj4amjzFeTsGZL5QI2EvFAvNtWSc=;
        b=NU97QLp1OX56vZgeR2znjjY+6XqTIyiGdoh2pvlwQ5imxB/dC/E38OoNmiaVCQ9UJc
         B0CFu9GjA0xXPeFSNfOEbbwCcYTZkgCvdsS98lx1uDsbmd2iBaDKC3FRwsCpkxHAFNYo
         H7913SKBDYOqet5LV+t1PVU8rdYYzTV4uDPKTz/3DJ6XN28e9rbQ7dODoNah2XkEV200
         aPqUDbIhfoSDwy/Uj0tFkGMIuwmTtq08FzVkPnWokN9wK7p2KSDp+wkfYvlQXpE9A4MY
         Ue/Ka/w8pZhii0Hi47LR6WiYGfeBlw0mGRogaUlsLod3ZZBkXfjnbvZSlP6nhGiuDXRx
         /wMA==
X-Gm-Message-State: AOJu0YwPPGcV1Ne5MG5IBHFbqEQgGCZb/EiBn3j9auwWPnhzuP2ix1kz
	3EtQKBY5TozhJ5oGgCsqXceQ5ed4+DQHte8SObUDtDISoxIOHV1C1QkB7Q==
X-Gm-Gg: ASbGncslEq8PI6EImEec786eEzH0J5X33MIq0Ei20c7oYqeYA+FIgt1vQLn7DmVPAIq
	1DDYGosXeYTrR3GbJcvPmBmtV+s0RRdrTYb8vsN9fz/RZoxi7JWYK2BDG5KQVCYofe2G5ZmWg0U
	UD9i+91oX5/ZEhLqnXrAw0uVeEiW8x6sbaEFFM8CZjmOJWZob6aYgphUDEiREbx1AN+wYcNCcjm
	ORxhAvd4NE4i6gsi/TvEjCVzP0a1uLh1ZSVqWHlEYvVKlhy+LMMJU0JaLjHqvS1pxEiYrTmue7e
	3JMUPpzLqMPqO1zOnbEdH0bQgfWn2nhMrB0z8w==
X-Google-Smtp-Source: AGHT+IFldMIK+bnoy2qXimiVOxp0g6Xwj1X38bhoJAL0glFw1akH0cujpCl9VSdSblmHcpbRsJOA0A==
X-Received: by 2002:a05:6870:c69b:b0:29e:5c37:a1c0 with SMTP id 586e51a60fabf-2c21cb14cecmr269982fac.21.1741117896122;
        Tue, 04 Mar 2025 11:51:36 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2c161004e0fsm2351470fac.30.2025.03.04.11.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 11:51:35 -0800 (PST)
Date: Tue, 4 Mar 2025 13:48:14 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/12] delta-islands: stop depending on `the_repository`
Message-ID: <ubagfibqx7xfcj4okemp3q2w3bfwpqat6piunvs7yl3lqpq6xg@ytzo7ogwir2l>
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
 <20250303-b4-pks-objects-without-the-repository-v1-9-c5dd43f2476e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-b4-pks-objects-without-the-repository-v1-9-c5dd43f2476e@pks.im>

On 25/03/03 09:47AM, Patrick Steinhardt wrote:
> There are multiple sites in "delta-islands.c" where we use the
> global `the_repository` variable, either explicitly or implicitly by
> using `the_hash_algo`.
> 
> Refactor the code to stop using `the_repository`. In most cases this is
> trivial because we already had a repository availabe in the calling

s/availabe/available/

> context, with the only exception being `propagate_island_marks()`. Adapt
> it so that the repository gets passed in via a parameter.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
