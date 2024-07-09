Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64721B86D4
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 21:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720561032; cv=none; b=BckHMDwzoA81z6pQNCVlD/Jbhno70C5VkTjoRl3guoOgrcowHjcvspB9XbrwhS93a6MGedyequjShnSmxU4JMjinvd1VmlroH4YUmy3uPbt/w1y74x2vKEnl6vZqk0MJiEiON8zpLORf4kC5UwQIsdRdmu9y4ymTAwdCRTYNL7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720561032; c=relaxed/simple;
	bh=6WwFGJcVZfYCXjx/xq/ps8nd+3m7SsHS2PFhhxKZ3K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=mB+Kv+HCE0U+zG6Zd6hVp8O6P1jFpKQ7m9dKot802A14hfqIJ7luAxEYnOTq9cjMduVHdSqYKImaEXnZxWA+opIda7JcXBIl2fRQW9xYMuodrffaDuPYoqJ4tdocOgOy5tZxXRKIq866hosEMo4gV1Vj33NA5QB1btyt6kRDuUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHYLksUf; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHYLksUf"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa6c4so6080752a12.2
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 14:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720561029; x=1721165829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:reply-to:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0i+ibsIGbPN9nHty8zq1L/s2SC8+qdDE/U26SDuByI4=;
        b=dHYLksUfNwRR65hUE5HKfXMGV+NDEYDhrLam9NrC7hQpwck6+uNteCj7zA/uBwhVFF
         CGEt2aXbT+L01L8it/63YyHSOk6E3OhRY++Wxu3JdhFVLRIQ5SmZV8JweKasCGGep+Sp
         mXdEUseNBmInMTeoghWU86vLzTpZJgl64kEzp6GUuV+idhenIHyCnE3TR41Uce8R5ZkA
         jLkiTQUTIo1ru3MGoga9ad2l9t6isSo4Hd62+fl/bK3Z3q/9nDyXxmPyZBhCAJR135jd
         cJv/GLe5PL8ay4J7tcYaJWJKHrx/M0gRRqp5SSUEbs9ME0ue51VMrIBXU1KI9114TI5g
         LoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720561029; x=1721165829;
        h=content-transfer-encoding:in-reply-to:from:reply-to:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0i+ibsIGbPN9nHty8zq1L/s2SC8+qdDE/U26SDuByI4=;
        b=lIg+ieDDRJaAPoKAMUaUAViCxh6xILyy/U3BVEoj8D92eH68IvAFbXCeoUj4XLXfpo
         4YJGCvvMD/ChizRbQOrI6WrmvsIfiUTsxMrjpw/5tJD0Ap5+OC6PeyOG7lFVEBgfz5VN
         VCESCxfULcaUeAx5W7I5SPpNDR+AK/snLJ7TZ2YCTE+wy4u3IM2ig1/fYLYwWY7NzlzT
         Ol4bOFmrFJvf1/HYfo2ipOIbmuS5af7AFUK6WhzLovnhL2e28v8kTzWqnQx9Q9TsWMJg
         Sc/99t4YLHnKEILIsqkQVoDB0E4xOF4gi9F1yx7XUWfosmHX3lgFnrd06+XMKtWyac9J
         MJbQ==
X-Gm-Message-State: AOJu0YyVTpu3LoPJoOSVFlXR6kN4CfNfZvbtxy/C3gvrSQzKsmVQGorA
	MVtzZCP1QbtfXvYnwjIOwB+oCNypd1fFlAFZtDqBRWXyK8xAvHbV1tmqRGbj+o0=
X-Google-Smtp-Source: AGHT+IEdNir8rJUyg+yiDS5F8PR7C9Ow+y8WEY8ZfIwXI6Mj5ryzvc9eDdRWcbMBmVSOBf7f/EG8DA==
X-Received: by 2002:a05:6402:50cc:b0:58d:d3f6:58d2 with SMTP id 4fb4d7f45d1cf-594ba98e65emr2918836a12.3.1720561028692;
        Tue, 09 Jul 2024 14:37:08 -0700 (PDT)
Received: from [192.168.1.216] (87-206-206-217.dynamic.chello.pl. [87.206.206.217])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd45a1absm1495491a12.77.2024.07.09.14.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 14:37:08 -0700 (PDT)
Message-ID: <9fa5db58-74ab-436c-b7ac-ff8762b29d03@gmail.com>
Date: Tue, 9 Jul 2024 23:37:06 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: update http.cookieFile with in-memory cookie
 processing
To: Piotr Szlazak via GitGitGadget <gitgitgadget@gmail.com>, gitster@pobox.com
References: <pull.1733.git.git.1719177846725.gitgitgadget@gmail.com>
Content-Language: en-US
Cc: git@vger.kernel.org, piotr.szlazak@gmail.com
Reply-To: pull.1733.git.git.1719177846725.gitgitgadget@gmail.com
From: Piotr Szlazak <piotr.szlazak@gmail.com>
In-Reply-To: <pull.1733.git.git.1719177846725.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 23.06.2024 23:24, Piotr Szlazak via GitGitGadget wrote:
> From: Piotr Szlazak <piotr.szlazak@gmail.com>
>
> Information added how to enable in-memory cookies
> processing. Cookies from server will be accepted and send
> back in successive requests within same connection.
>
> At the moment documentation only mentions how to read
> cookies from the given file and how to save them to the file
> using http.saveCookies.
>
> curl / libcurl will process cookies in memory if file name
> is blank. Check curl manpage:
> https://curl.se/docs/manpage.html#-b
> This is described here in more details:
> https://everything.curl.dev/http/cookies/engine.html
> And also explained here:
> https://www.youtube.com/watch?v=V5vZWHP-RqU&t=11459s
>
> Git documentation was updated to include suggestion how to
> enable this by setting empty value for http.cookieFile.
>
> Signed-off-by: Piotr Szlazak <piotr.szlazak@gmail.com>

Hello Junio!
Would you be able to take a look at my commit?
It's a small update in Documentation/config/http.txt, where I wanted to
share how to enable in-memory HTTP cookies processing. It's more
curl/libcurl related thing, but worth to be known by Git users.

Regards!
--
Piotr Szlazak

> ---
> Update http.cookieFile with in-memory cookie processing Published-As: 
> https://github.com/gitgitgadget/git/releases/tag/pr-git-1733%2Fpszlazak%2Fdocumentation-cookieFile-in-memory-v1Fetch-It-Via: 
> git fetch https://github.com/gitgitgadget/git 
> pr-git-1733/pszlazak/documentation-cookieFile-in-memory-v1 
> Pull-Request: https://github.com/git/git/pull/1733 
> Documentation/config/http.txt | 8 ++++---- 1 file changed, 4 
> insertions(+), 4 deletions(-) diff --git 
> a/Documentation/config/http.txt b/Documentation/config/http.txt index 
> 2d4e0c9b869..228bed32ec1 100644 --- a/Documentation/config/http.txt 
> +++ b/Documentation/config/http.txt @@ -78,10 +78,10 @@ 
> http.extraHeader:: http.cookieFile:: The pathname of a file containing 
> previously stored cookie lines, - which should be used - in the Git 
> http session, if they match the server. The file format - of the file 
> to read cookies from should be plain HTTP headers or - the 
> Netscape/Mozilla cookie file format (see `curl(1)`). + which should be 
> used in the Git http session, if they match the server. + The file 
> format of the file to read cookies from should be plain HTTP + headers 
> or the Netscape/Mozilla cookie file format (see `curl(1)`). + Set it 
> to empty value, to enable in-memory cookies processing. NOTE that the 
> file specified with http.cookieFile is used only as input unless 
> http.saveCookies is set. base-commit: 
> 66ac6e4bcd111be3fa9c2a6b3fafea718d00678d 
