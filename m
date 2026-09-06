Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CD123B63E
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714425; cv=none; b=ZvJ9ZxbgpyG8jEtWSuq3H8h+wk2xTqiptyos26B7fib1S1dstbTLuT8PgXGLPHT97j0yDIkpVd7Vsn923wibnJUTcXbS/zPZlQMsBC87WDChzxRvkBXf3wH0nMITrvSPHvgFqAANHwgbZSr888KlIitnYzHfy4CJffJeMT95c2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714425; c=relaxed/simple;
	bh=TonV78jPXBc9vIp2d1VA09s1rfAl8MhzhHLZq5q0NEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJ74RGWJGgLnuc6X/EY8XBO2OZv7cNi6MEzOxP8NoKo4xiiq8KTSSEB64fRSzmJDTDBiX0M9T74aU5vwuyefvoet44ioi7MnLBYlfLLv31Wk+XTZjJXhksK7VQP66grKtJvALXZlld/TanC+IHeu5eGRZVRjiZpsqWo1SEVeUiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tawq16td; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tawq16td"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7f5a781972fso1946888a34.3
        for <git@vger.kernel.org>; Sun, 06 Sep 2026 10:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788714423; x=1789319223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UbIsEKGxyUiSefAe2US/I6Yr09VJ8NO19QO7OC6eOdQ=;
        b=Tawq16tdBh7TkV69c7oxhZSZA0I/Ol+BuKTZFoqhSxLJP+08RhrSALS522i9b/FgDm
         M7kMC+KsE7yiskGPKCMJJWsGGy0P+wzOhE8JbUrvGk52sOdW04ALdwNFm3IJSCUY1tw8
         dijwlyRZBzdRgRSrRQqTVhyjGGnvO+JjQ6YLCS94N/oobqJneTXj4TJa6T7rOZbiRDNF
         9GBAY7a04sPPyVbY3VMH75LrnMkrOzdMNbUEdh0xNYB3mGrfouUX5hRd35S6tNPZeu/7
         0esOsx3Cp7xZkjQJTQCyTCzSR5RvD1T7qkNL8kO4tKygsPkMGZEzehmfNVfcB+ZnsU95
         3CKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788714423; x=1789319223;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UbIsEKGxyUiSefAe2US/I6Yr09VJ8NO19QO7OC6eOdQ=;
        b=li5Lh2pfCquGi2+sUw2qXUbyj6iiJQz+KArQnINKjgauFyaadus+zg6un5PD9cK4kB
         SzQcREloTYTiT55a0IBgDtYSLCcCjOEfBZB8L8tXBD+/1jdTUv7iFJF7DK9dy9jpfdHM
         NF4EolUbGFDROvN9h9qoSDPJYNm8z7EJtkyQwxloxQtsub+Io63SG+y41CJSpjtPovTw
         ts5rpyQJtLHQv1xDuD2hJufI/W052mhxZWIqcyAEs/XR/zv1t1jge2tWxoFe6GaSKR0E
         Nb/t6TGQELZPgBf7yOF4xHClKfzCFWMJaZ0s3ewb0tZ0vgQLe63l1JvvPi7NTkuO3m8x
         UdQQ==
X-Gm-Message-State: AFuF++l9QG9AyAfFCNvowhgGYxvgV60JSREzh/pXPFDZGKY5KxkWKd+S
	oTjqhv1xFholZ/C4Z/ImuKsdMe3KBvv15g7MVrFnT3YiXFBRHyWL8CXeStQBSQ==
X-Gm-Gg: AYBFou2IWsRdvwb7UhE5VrgAHGEQebyYhpCNQfuIom+uI5KoMJnHAVt/0obJ4to3q8A
	b4rIZZ7AYCfHEPqjHItBwwjBbHg2KFmtbOG2yGfNhkzJmY8IP6MHjUONa9MmdFtWNIEKgXKPHKA
	ucD4wO5Dh1qAlF64LEPu1ltUKM/3YfhoX+75s2+RcyhqcJP6Z1i4ELKXnuCdCOs/OsOZC6qAXPJ
	mySOqW87jZbcmYSvgO3xH+PPM8AD0vVZHbEqR14Q9d7gY94KOu81sgGst23RPYmu8r1Vukhqj6C
	qx/0zHaoxJdACYSIOW+9tDauBNxFtbvOJCQEbkQdLEc2QNraPBIbjrgNjwOU7vfULG0saHMegeX
	ygteVrKEeN+/2cAvhPxTks4d2A28167TwKD8LE7hr43JujiFDzcNIgVE2sjscOj+MMR0Hf8zEVP
	dj6OievBgMZgtXP/9PQJJnavIq3weMqUuRQfFg38vLBp3YK6u4b/EU6UY5VT0fLXEwAT/JHmgMX
	vNlmBFHHRGFKw==
X-Received: by 2002:a05:6830:82fc:b0:7f8:4ebe:2854 with SMTP id 46e09a7af769-7fa1e6c19e7mr20692052a34.4.1788714422760;
        Sun, 06 Sep 2026 10:07:02 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f72d3c8asm9413449a34.21.2026.09.06.10.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 10:07:02 -0700 (PDT)
Date: Sun, 6 Sep 2026 12:07:01 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/8] builtin/clone: write alternates via
 `odb_create_on_disk()`
Message-ID: <ap2c8QObeMWlGSd2@denethor>
References: <20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im>
 <20260831-pks-odb-write-alternates-at-creation-time-v2-7-aecd2382ba1c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831-pks-odb-write-alternates-at-creation-time-v2-7-aecd2382ba1c@pks.im>

On 26/08/31 12:02PM, Patrick Steinhardt wrote:
> When creating a repository with alternates we first initialize the
> object database and then write alternates to it in a separate step. This
> is unfortunate due to a couple of reasons:
> 
>   - It requires us to have a `write_alternates()` callback, which is
>     unfortunate as we never even write alternates to an object database
>     after it has been created.

Happy to see the list of callbacks shrink. :)

>   - We're about to make alternates an implementation detail of the
>     object database's backend in a future patch series, so having this
>     callback is suboptimal there.
> 
>   - The backend has more flexibility with how exactly alternates are
>     configured when it itself is in full control over their setup at the
>     time where it creates the object database itself.
> 
> We have thus introduced the ability to write alternates right at
> creation time in the preceding commits, and we have unified setup of
> alternates into a single location. All that's left to do for us now is
> to wire up alternates as an option for the database creation.

Makes sense.

> Do so.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/clone.c | 5 +----
>  setup.c         | 9 ++++++---
>  setup.h         | 2 +-
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 2e3473fddf..48ac379b1d 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1368,11 +1368,8 @@ int cmd_clone(int argc,
>  	if (option_local > 0 && !is_local)
>  		warning(_("--local is ignored"));
>  
> -	create_object_database(the_repository);
>  	collect_alternates(&alternates, path, is_local);
> -
> -	for (size_t i = 0; i < alternates.nr; i++)
> -		odb_add_to_alternates_file(the_repository->objects, alternates.v[i]);
> +	create_object_database(the_repository, &alternates);

Alternates are no longer explicitly set up here and instead wired and
handled via `create_object_database()`. This patch looks good.

-Justin
