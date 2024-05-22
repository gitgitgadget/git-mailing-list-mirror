Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DFA13D60A
	for <git@vger.kernel.org>; Wed, 22 May 2024 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399098; cv=none; b=Ppcab/PSQ6sFkFIXr2guYqDVQw4fmnfW93ylgO7k0IHF1a2Dw+ghhE2HPiu0narqMqvijbOGDvy7lG64yppl+Iu1NlejtcJ35I3f++eO1jHg71wSX3s75Pd4qdKSFfkTGYP6mhaIPFMGmCVpeKWPUbSXsydOF5PCOOTAXi3PQ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399098; c=relaxed/simple;
	bh=6Bm2ORhyvZ6OWiLKro/Xz6w58K+ar+309IIs6HMjAhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WTzUbYs5El9550EAiQ60NaBfLL1xbxEzEehhYxSnLvX/DVp6H+1Xv5CPcGvKx0OTPvLxZjSibylMa9lw3cy2iGxBiux1Ji9CC/NuBfpbsS9AGmoGSWMPmRSGdZC/6+PukyCN/Y0KBHiFxTiCqe9BOfOurHUqmxe/KL8Au45ROhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Exhlr6Tj; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Exhlr6Tj"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e538a264f7so73408571fa.0
        for <git@vger.kernel.org>; Wed, 22 May 2024 10:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716399095; x=1717003895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Ia99/sRf97Lnm2Jxgjozj3H/NFMP6ixM1l100Owt1c=;
        b=Exhlr6TjMXqip9k4uajzbJtihRyfru1BElY4787URWd7Hf5hu8tufrjTGiK5lUvVr9
         6+N9YLJ4KpYl5Wwd1Ont1BG6nS/g2yTsc+HZ6Xm0AsoYk52LGuLJVdh73NeV9ocVnI7P
         2UWq1XHxyUMEgZzlc7mWixTFGgachK3yoORQdzZavZHZN5CUFnQZyH/cmQmyskqv523I
         nNSSvni0xJz5apT5kxrEKEhEhcSl0UpweGHKmzNDHVD3JyawT1YIpcWlOVWPhO6CAB7S
         JxF9nHv1fRWosaYd2o6Sxa33yusK+5w+RwACPB8OC1KTJf1VKG118ZGD/MeGvzpwe6Zl
         Pu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716399095; x=1717003895;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ia99/sRf97Lnm2Jxgjozj3H/NFMP6ixM1l100Owt1c=;
        b=MLDvsGetSSjpxWRuD3VMJiFKdD3N+hkWezBfYTyMwjxPgRy91IcHZ7ZnPGSdpM+v4E
         cAXPZ2Xdnc+VBrBlLfZC8ZybFWt7GmWKOSek0qm2UfGr6oUebU3CRBcqZScv3jqmsXD7
         Jepx32LnhsKEO8qetmIQSj7We9vDp7V7dlDfmMkpdemzoOmjxpzKpYNKkEiKbeaPJVpj
         M50aUqxS4P25WMaWKx3Gi7KOzOXzIQ1R/UA055xxJ/M22HcBqQlWyITXz5dQsvEVUn40
         fPD9vYzUd90xzl5cVQsNJi4IKeqaLldTecvhLw2Ad7k+4Ov9HRbxY8q8QCj3jvbLqGDg
         3wvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1Y1SFZE2K9FfoSsuKBekTtI+Abqd34wWBmpB6N/h5sHzZQkFcV35Rkkl8gpLnqHyYOQ9bRCIC+AjHraDwJt3C5yvT
X-Gm-Message-State: AOJu0Yww3XNsz7BGbXtcchzDy7Et9/3KmIGO9TW5HmVyG23zAkaK4Vd7
	GhFallS5vrRWA6y6PThoQh7+YUrjMYRYWBhiDWd/2Ac/FoWIWgppeBfwKQ==
X-Google-Smtp-Source: AGHT+IHDJ+xltdPIKEvkTcH0sPMYHcnJpj+iE0Lw3uVkJfs5Ndol+j80qTQwYGU0SznWLlt0ZSTcFA==
X-Received: by 2002:a2e:6a12:0:b0:2e3:8fa:6438 with SMTP id 38308e7fff4ca-2e94969e187mr16614281fa.33.1716399094764;
        Wed, 22 May 2024 10:31:34 -0700 (PDT)
Received: from gmail.com (133.red-88-14-54.dynamicip.rima-tde.net. [88.14.54.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100fad970sm516875e9.37.2024.05.22.10.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 10:31:34 -0700 (PDT)
Message-ID: <f7cf64cc-1458-49db-979f-eb4c70223620@gmail.com>
Date: Wed, 22 May 2024 19:31:19 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: note that interactive.singleKey is disabled by
 default
To: Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org
References: <3141fe9f7328a97bf3818748421f6ae929120626.1716363167.git.dsimic@manjaro.org>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <3141fe9f7328a97bf3818748421f6ae929120626.1716363167.git.dsimic@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, May 22, 2024 at 09:34:16AM +0200, Dragan Simic wrote:
> Make it clear that the interactive.singleKey configuration option is disabled
> by default.  This should eliminate any associated doubts.
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  Documentation/config/interactive.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/config/interactive.txt b/Documentation/config/interactive.txt
> index 5cc26555f19a..067496d77cea 100644
> --- a/Documentation/config/interactive.txt
> +++ b/Documentation/config/interactive.txt
> @@ -5,6 +5,7 @@ interactive.singleKey::
>  	linkgit:git-add[1], linkgit:git-checkout[1],
>  	linkgit:git-restore[1], linkgit:git-commit[1],
>  	linkgit:git-reset[1], and linkgit:git-stash[1].
> +	This is disabled by default.

I'm on the fence if it needs to be said explicitly.  But, I'll add
that it has been so since it was introduced in ca6ac7f135 (add -p:
prompt for single characters, 2009-02-05).

Thank you for your attention to detail.

>  
>  interactive.diffFilter::
>  	When an interactive command (such as `git add --patch`) shows


