Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C091A145FF6
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 06:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719297658; cv=none; b=nYGX9otRqJIH/dqppLRDtuVfxhw3IErIWHtENTFMs9zwIOeNVKuza2Na+WGxzJhilhm+969P/yiIGARHfx0RxlgDJ/sm16ryOwofiqG9SGQjaVhASfepOqDAS6yimvXP9SflNdm6PWlgP6buI3hLicQAzFPN7LTjWSSbPGgskL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719297658; c=relaxed/simple;
	bh=RsJZwKGuDDoIqoRThZQAR4UpMoU9lIm7tGLnQiGccjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7CxbHjZD1ie/K4OkHZdCzohQ21vWb0MZ4qlLFiVTxGccOf8+6YjjKU2mhqIAAEerVTh3crUtv4dVY6iETQxwQnBVfToRb5f5ppuVY37a3KfH7t+SLFcRFrmkNRp2R1BO4LbsYezK2gHGkaz+xTIuziDrVZoyair1dyKQEIvzOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmhwbhOi; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmhwbhOi"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f9b0e8877eso405083a34.2
        for <git@vger.kernel.org>; Mon, 24 Jun 2024 23:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719297656; x=1719902456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ibCmiTBUUfiAzNkJOVjD0uBe1TfDDblKwZ741P1tRI=;
        b=AmhwbhOisZKhw0Cnukf0ilWSqoHzP/1LAabZ4qY3kFa1n4EeaCebmh01uSvLVdEuDO
         EcEKliWcQ8Ak1EpQVFIAc70t17xZ11kb9lsTN1CCiFBHKUScK2xEIipK7vzA5gLE2NMo
         xnMg3ugVpEwpUaAD+YG/B6S719bE8e9PRKItMBVzQZHbysEhmmzjHFWA1xqDnoWDqJ4Z
         oFUbTSLB8ghsQ3kW2FxwlIeZTLkigoP48CWc7OHMSSsYdqJAP17JfB00aTKJZ5Bo6pe0
         YezlANKHu008tZbalpLl7aqGK8rEruTPGHG4d/HHWI4m9/rXGKz1lr0HkJGTNKIe2/+u
         AfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719297656; x=1719902456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ibCmiTBUUfiAzNkJOVjD0uBe1TfDDblKwZ741P1tRI=;
        b=C55JT3eqmNgTVnKOtLUru/AeXddrqyTN3P3UKeHUTKVrDv0R/faqv0yxTSBWFOhI1M
         oAzozmG0pp8+ZkjdEIhf3C6+/aH0IIsvCdXoM6sDvlUZApeDLBKpSaE0WeOJHxB9ZUq2
         iDkesw6CaTZO5fbpZOLni95Y81OoAhPdn/hLQYKX9a4ACAqqRFV9fGc1kftj6dQfRuYJ
         ZlxN12oQU3vn21iL7byITYeLcBCj0n+nW04O2/Rr2TCSfq/nZn2iSkTJWQfgqllDADK3
         Z0xxURaheiXSpx6ZkLerST8qxGOqqUoHhz5fFRvSz8i9dZYASuSveWZy2BOnpmj2NQru
         G5lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnnfNBoSfVN5H6CD4l6eRVy7KW2hV9FjjqI1mJf7S+VFUIMBI/qgm0qBImClmpJIbIsAjTD532c4l21YFJPAoAr687
X-Gm-Message-State: AOJu0Ywa9VaIlQRD5qA6zPYkQZuJDdexB/JIxk3zrx3ZvgiGNDaDTVpW
	AuGyTgHdoLY8OHzg2zPO3Ji3zSNg0AR9V5NBFV5diW8h6FvshZli
X-Google-Smtp-Source: AGHT+IEC53vz8Ma9kz65p3QD8hYle7BMEYX/8HPEn2YRKL482I253wW6lN9T0Etmnmz4/2vI7NaxDw==
X-Received: by 2002:a05:6870:41d5:b0:254:a7df:721b with SMTP id 586e51a60fabf-25cf40ae173mr8431280fac.5.1719297655529;
        Mon, 24 Jun 2024 23:40:55 -0700 (PDT)
Received: from ?IPV6:2409:40c2:3e:f8f9:ded9:1f2e:64c4:580a? ([2409:40c2:3e:f8f9:ded9:1f2e:64c4:580a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7066f30caa6sm4935806b3a.119.2024.06.24.23.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 23:40:55 -0700 (PDT)
Message-ID: <89951829-80f3-482f-87d1-d88c12a2575d@gmail.com>
Date: Tue, 25 Jun 2024 12:10:49 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] describe: refresh the index when 'broken' flag is used
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, Karthik Nayak <karthik.188@gmail.com>,
 git@vger.kernel.org, Paul Millar <paul.millar@desy.de>,
 Jeff King <peff@peff.net>
References: <20240623214301.143796-1-abhijeet.nkt@gmail.com>
 <CAOLa=ZRGramQ3MdzzXzZ19yeUB_rQZPbZ3u=eA=T2SfV3nhYOA@mail.gmail.com>
 <054c6ac1-4714-4600-afa5-7e9b6e9b0e72@gmail.com>
 <69662b07-e216-421b-b947-afa52e56d7ec@gmail.com>
 <735b4a95-fe8e-4bff-9dd3-10ddd4bdb5b5@gmail.com> <xmqqcyo6cnbb.fsf@gitster.g>
 <4224c251-c6f7-4b2a-b182-b0a12ee300c8@gmail.com> <xmqqsex2b4ti.fsf@gitster.g>
Content-Language: en-US
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
In-Reply-To: <xmqqsex2b4ti.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

 > So I still do not understand why you > want a second user in this 
test. What I really wanted to do was closely mirror the environment in 
reproduction steps mentioned in original bug report. Which I figured 
could be done by changing the owner to a second user.


On 24/06/24 23:28, Junio C Hamano wrote:

>      $ git describe --dirty --broken
>      v2.45.2-862-g39ba10deb2
>      $ cat COPYING >RENAMING && mv RENAMING COPYING
>      $ git diff-index --abbrev=8 HEAD
>      :100644 100644 536e5552 00000000 M	COPYING
>      $ git describe --dirty --broken
>      v2.45.2-862-g39ba10deb2-dirty
>      $ git describe --dirty
>      v2.45.2-862-g39ba10deb2

Thanks, I will use this in the tests.

