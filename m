Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50F43D0AD
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711739052; cv=none; b=J9KT+Tk47VaQveuQi7PbTuOWMaT0SpaKLIJVAXg0pFlEEQ1jQhA/UQgjk5q/rBN8t6YFByb44Pzn7Wqs0CbCKtTno1qlTe58M8YGRIanZjnq4lff31D4p1JKUKcF+1d+TyhXICP/BgvLb3L+yfyIny8W0Hr8+TVsCV/HKdtwhow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711739052; c=relaxed/simple;
	bh=aVFFkslF/Gc3FGX5bHIpjhmMZ5y7jGu8Tjh7OObFeo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F3HK6nsyYUUFm/dRJomRIp9tDr3PMH9y9Kus1llgS3YIwxvldddoJgnbIF+/mY/lEcGMCq18xI7s1VuTeIHJW7z3d/OW5Xtuxro8/yzM/GjCsH18KRFlrtsv2UDrobqqMzGTdqKGaQlbF4fK0WAUI/2MzQNKrqbnfHSm6WRz+PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+8h1arI; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+8h1arI"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d23114b19dso30410221fa.3
        for <git@vger.kernel.org>; Fri, 29 Mar 2024 12:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711739049; x=1712343849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3cLTRRvXWlABM+vnVC43KwuCWA1499VXU/3gGoEpQKQ=;
        b=N+8h1arIVP2d3KREBxOUu/gFK8NcQfHlyC2T+ssHZl+nzpk9T2cAQwwrCbFArPPOSw
         ps/fJj1sOYkjm33VLMW4m5CeYsfR9TDUy6w6ZvG6vH0BLuTTivlWv5A7EIutQVQU06We
         uqmp7QnGXYL6tHGcR161qJ1kKVvHerLEHg0zEAWGRrRYeRbXWEq3b27poRjohXYxvrCj
         W2T2JQgJz8ts/rSVCGPJZR+XmBNFA4MNu2y72QIPCXisuQGd5ul6iwTd/8X+cJAq72C9
         pWGyzGRjyXyTX0AVgdraQ2KZOH/uowFWwp94Al7/bORx1jBAyL4SpusVTzHornjC7Qvx
         +E/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711739049; x=1712343849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3cLTRRvXWlABM+vnVC43KwuCWA1499VXU/3gGoEpQKQ=;
        b=QJSOQ+58iOhoOgDV3TdvYr6qab54H1u2iSIMzqsyMcr6gpXBJLMiSqLQ0YGZ2Njomf
         EdKxq5rwhtWRv1KCx3+uwnmKMf+0n9e8MfE6XRq+nH5D/o1mrl/kt/vRch3El0fmmwo5
         PEpldpDj87QC78Ir/wH6zpX1dLXEGZfURO4hJizOwKOX6MlfsSit656ZOCWCf+WxTs2W
         GvXGYQ8wh/WMpHUgqRM2PaakGffwaPu0R1YuW0mSl9YXtRBkpjzcoikpXUiiiN3BETX8
         gCcUCDvQUnO/6tNcdRp8ijmoafsDqDEf/EMQFllsPT/vK8NtkgiyKv70IxJcr8pNi9La
         Z1Zg==
X-Gm-Message-State: AOJu0YxaiC/BTLk+1ENCb+RS3k0nltBnsKg71cRz2+waVES46OvrBIuB
	65pr4PBS4ehzqAVDnN1VAKiMK7hMdPXfa9ByoOvdIGmJ8L9zJikS
X-Google-Smtp-Source: AGHT+IGZ+XqZBjaUpUQKrA3Ac545EI2KbCZBAR2SUu7dTGpIF1tFjgJ2K2tdCOaJZjCdDRB78vJkEA==
X-Received: by 2002:a05:651c:a08:b0:2d7:1ee7:d78 with SMTP id k8-20020a05651c0a0800b002d71ee70d78mr685958ljq.10.1711739048767;
        Fri, 29 Mar 2024 12:04:08 -0700 (PDT)
Received: from gmail.com (118.red-88-14-46.dynamicip.rima-tde.net. [88.14.46.118])
        by smtp.gmail.com with ESMTPSA id fc11-20020a05600c524b00b0041408e16e6bsm6235600wmb.25.2024.03.29.12.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 12:04:08 -0700 (PDT)
Message-ID: <de916779-3c0c-4cf0-b78e-d0536c65af0e@gmail.com>
Date: Fri, 29 Mar 2024 20:04:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] add: use advise_if_enabled for
 ADVICE_ADD_EMBEDDED_REPO
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <06c9b422-b22e-4310-ad5b-1686616ab860@gmail.com>
 <0e38da05-efd6-451e-bd8a-b2b3457c0c75@gmail.com> <xmqqcyrczzv7.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqcyrczzv7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Mar 29, 2024 at 10:55:56AM -0700, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > Use the newer advise_if_enabled() machinery to show the advice.
> 
> Common to the other two patches, but "Newer" is not a good enough
> excuse if the existing code is working well for us and not being
> maintenance burden.  The previous two patches were helped by use of
> advise_if_enabled() in a concrete way (or perhaps two ways), and
> that should be explained when selling them.
> 
> This one also needs a similar justification, but with a twist.

May I ask what you would find a good justification?

Perhaps "newer" -> "now preferred"?

> > +test_expect_success '"git add" a nested repository' '
> 
> "nested" -> "embedded", as the warning, advice_type and the message
> contents all use "embedded" consistently.

Makes sense.

> > +	rm -fr empty &&
> > +	git init empty &&
> > +	(
> > +		cd empty &&
> > +		git init empty &&
> > +		(
> > +			cd empty &&
> > +			git commit --allow-empty -m "foo"
> > +		) &&
> > +		git add empty 2>actual &&
> 
> It is very good to add a test for a feature that we failed to cover
> so far.  But the feature, as we seen above, is twofold.  We see an
> advice, and we it see only once even when we have multiple.
> 
> So we should add two such embedded repositories for the test, no?
> Also, the shell repository is not meant to stay empty as the user
> will make a mistaken attempt to "add" something to it.
> 
> Perhaps the above part would become more like:
> 
> 	rm -rf outer && git init outer &&
> 	(
> 		cd outer &&
> 		for i in 1 2
> 		do
> 			name=inner$i &&
> 			git init $name &&
>                         git -C $name --allow-empty -m $name ||
> 				return 1
> 		done &&
>                 git add . 2>actual &&
> 
> to use a more descriptive name that shows the point of the test (it
> is not interesting that they are empty---they are in "outer contains
> innner repositories" relationship and that is what the test wants to
> make), and ensure "only once" part of the feature we are testing.

Good point about the naming.  I'm not so sure about the "only once"
part, but I do not have any strong objection.

Thanks.
