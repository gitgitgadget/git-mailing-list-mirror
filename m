Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8282F7EF
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 00:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683486; cv=none; b=s1M45ATe6y6K8BhpeUQWOoQdCj5TOUhmMEQU1GyuvbpxHegp/q59yB0BTFFBNgyOboKSy+jEmm4tUGcB5foSaMBaWHiZUhjSSxnPi4hz0dgCvwYV7J3uj1YGcO9O6wyjWqicRcm9PtGWJV99ZAbAJAS64Z8tls80xBlpMruxwAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683486; c=relaxed/simple;
	bh=VyQfQ8D3KAyBNfm95/8suukmt6rJMti1pEOsPN1k7qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aweAvT1fNQUBd0k20W9v4koa5ETK5Lb1aCBlBkSzu1eluykJhW0cvejyf4jUCYYIb2VuuisQCYcvjWG7uaLFeFLi8Yhdl/g9MkIFjL9ewG32pzsOhun26v6cVadn1FKJAc2mScjP643ZNs4mjYzOaKbhFsrInApb8TYrRvmpnM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMKWx3Ff; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMKWx3Ff"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412f0655d81so5631055e9.2
        for <git@vger.kernel.org>; Tue, 05 Mar 2024 16:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709683483; x=1710288283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7eQxPXQXHq2v0PXYQlfWUbCiKQTJZxE9n+ji3BuAj8w=;
        b=NMKWx3FfVmV6fDzuvEBfTAAzbgufZrJ1CTmlbQLnKH2nI9qMcua1oRaaztfreO2xsr
         aFK0oA6ijYUijGz+YCFALX6AOgGYMNvBoeP3ztp8YkKnWFChZXsvmAZ9sJKcxQKmxBSa
         yNBGieRWc9pJGmqZmJ6PmpDUGl8+39DfvrensuEWUDCGPGs3dO2mq7VQn++NfGm1WPNO
         NZrwsx4QD94VCpuWOJCNT48mBzYJ0S0kLyrPY8HlX6CaJhZq9XwP87jPW1pc+sqFG30m
         eHOrT0NYQKESlFSq7A9l8+KMg1FnLeliZJmmLJHvzvD9hcIsGhef2huYTv4M41HkrSb6
         HTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709683483; x=1710288283;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eQxPXQXHq2v0PXYQlfWUbCiKQTJZxE9n+ji3BuAj8w=;
        b=wISh27iVHtXP1Id8B+Wyhs9TAR1y1vAA6mYMdYU8r1snQ+EBQjANqpVG+gd8LUhuXn
         rcMXRJGiKa5cXJd3v2oGGzZA0QIM766dDYCwPSAiRGPUUxmTYJSMS2Bhf3+KBIDIVY81
         akoWaloONdq2wM1dGnxEpxgKm2sFyIHzwThe1lX5l68/bUUhxW/9MyzonPsFX3XWxJcz
         4FWWzlcQONBNZV/3G4MqfNh3jcievovJpuAJ9S29Rl/lrwz4ei+kp5AOdFa0+AbVXL0d
         WH1VsLbeSzc3nkxaCREeo86nOxgXoEKTBcuPEnrZJQ8xr/h5dr9qcOe2S4tjhOLw73nW
         1Rtg==
X-Gm-Message-State: AOJu0YwpYoughW5TESvHzlomHPegr398lhPUk5mwe1CUIsgPU9TNKZcH
	58cN9dLKIM3zuxHA5Luus6QQfzq4W561IhBXxusLtGQzBnW9i0ZMoCE/G0uD
X-Google-Smtp-Source: AGHT+IEvlt5xyPyz3cxAdjbapNvYOiVJ7DWuSTaXXw7pS2oD1BwsFt8lQLUNplTEvY+w0LZuc6pHfg==
X-Received: by 2002:a05:600c:1da6:b0:412:e95f:51bb with SMTP id p38-20020a05600c1da600b00412e95f51bbmr3133069wms.32.1709683482658;
        Tue, 05 Mar 2024 16:04:42 -0800 (PST)
Received: from gmail.com (59.red-88-14-210.dynamicip.rima-tde.net. [88.14.210.59])
        by smtp.gmail.com with ESMTPSA id l21-20020a05600c4f1500b004101543e843sm22291142wmq.10.2024.03.05.16.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 16:04:42 -0800 (PST)
Message-ID: <bdae6d2d-af56-4bc0-a000-5cf2ef44cd44@gmail.com>
Date: Wed, 6 Mar 2024 01:04:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/22] t/annotate-tests.sh: avoid redundant use of cat
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>
References: <20240305212533.12947-1-dev+git@drbeat.li>
 <20240305212533.12947-5-dev+git@drbeat.li> <xmqqplw8xqio.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqplw8xqio.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, Mar 05, 2024 at 02:28:15PM -0800, Junio C Hamano wrote:
> "Beat Bolli" <bb@drbeat.li> writes:
> 
> > Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> > ---
> >  t/annotate-tests.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
> > index 5e21e84f3884..87572459e4b8 100644
> > --- a/t/annotate-tests.sh
> > +++ b/t/annotate-tests.sh
> > @@ -532,7 +532,7 @@ test_expect_success 'blame -L :funcname with userdiff driver' '
> >  		"$(cat file.template)" &&
> >  	test_commit --author "B <B@test.git>" \
> >  		"change" "$fortran_file" \
> > -		"$(cat file.template | sed -e s/ChangeMe/IWasChanged/)" &&
> > +		"$(sed -e s/ChangeMe/IWasChanged/ file.template)" &&
> 
> Obviously correct, but 
> 
> 		"$(sed -e s/ChangeMe/IWasChanged/ <file.template)" &&
> 
> might be a more faithful conversion (when "sed" looks at its ARGV[],
> it did not find anything before, and it would not find anything
> after this patch).

Good point.  Thank you for being careful.

> 
> Not worth a reroll, of course, though.
