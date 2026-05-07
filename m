Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D103A8758
	for <git@vger.kernel.org>; Thu,  7 May 2026 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778148173; cv=none; b=OBo0hk3+JYurB5k4kjXMqnS/RFBHQd57sx5u68Xhg3rmDoWOtobMuXaW8GK6v7mLoNRNxv2Efmg/AkRP+0DZ+/VoIUeZwGnT9G0LGFCQ91eorGQ1ajaTeyHyyYCQoKxBukIpB6NgpYzCSzEx4We/Hnr4OMOoNpAlgeLhDwqJGDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778148173; c=relaxed/simple;
	bh=C+TtHxHTLgogogTjort6CruiMBudY+A4RWlgGQeOchM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oT4zD4l7576l9pGeeEXU1HjVC+tmA2NGt5gc4i+z4as1/7kYYRfQo8EOtzcRBGmUKQfrMf5uXiTJZ2Z6w6tIiCQY+4uYEfRRpRnEgmPUrqlmYlb229tU0x2uYq/bZCdfTLkPH/KMj3NMT4vTsEF+3BqtOFJ7OhkxQg3OQJ3W+5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsxLm5e4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsxLm5e4"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso6098155e9.2
        for <git@vger.kernel.org>; Thu, 07 May 2026 03:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778148169; x=1778752969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9BdVP1g+9xc0YRUX+K16Z3+VkhrcfLlofvUlwkvGl5c=;
        b=CsxLm5e4l5KeNTFMCX9VH4ShiFpD5n3Ua9/9ycasat7DLf+JsLK5nqB/W0gDyW9W3M
         HOUoMnaOLxBWyxt+UqzY11DFvVx6ajSSRuO7rJoh9VaWepAqQPs9Y/AbnpOqGhZUs8wI
         i5hIiCYBbv0qXhCmJm317yDSh6yEGNrWSyf3SpOXTQNPKWz9kQFfG3UKJwkNZq2kLzm+
         Oy58PBLSgIfrktcSKqgOa4OsrR0EziR0wtiYmugLa55ItvdtlKivtq8zbDFnwANRzn7K
         s//NipIoHI+iNegr9aA7CdYwOi1jdBWQ6XldBKdnGzS08HxAt2AIXy+AqmJMxo2a+/aE
         ta/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778148169; x=1778752969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BdVP1g+9xc0YRUX+K16Z3+VkhrcfLlofvUlwkvGl5c=;
        b=FKDLgtKPE39DVqFaVYYlHRKtrELYWRXSCq8HR20Nn+COrJFaOnD+MWhBFlH3CReVHx
         mn1srMFWWOmEir8fgfhptJx4XPSuL7p+FL+jVRzbzsboB6JjK0AS7r8QAD/BK1tAcsRv
         jq5nAXg/psUJ1FJOV/PCOGrD9rS2108eHYEdAF759DQABbvF5Wi3OLWbzO1NHiFJ5D+G
         2nqqgXpJtvPbG+xEYbEmizWhK2uoj3BgW7zqP3ij6bJ6qV8row8INR2XISlWamzSlXsl
         fTlHerE4pNRb9eyFYmhinJsccbhzaEV6h19Sl9yeN0cA64ShiX+jh+RmRWi5dQfsDRKK
         /M0w==
X-Gm-Message-State: AOJu0YzwZ0cpM2ergB5lDOIAfdOnFgN/9DO+ZCamQ80XW9bZljN2qnZi
	SKvjxd/Ia3ie9iTzUv2qBYBUbV9AW8d0PKTcdv9yVd9bT5rWqic3yyW2
X-Gm-Gg: AeBDietabrYirULQgXCRwxyV2P3+3udDgRsv3b1Qv+OWKnFZ7Ur5N9+lHLox4lBDleq
	XNxSp/kQf+hHlNdIArDRv0ruGijJOgOq69SE1vNGkzPVjsxRLsrx3OljiFIW4oTpjKno9rVZ8n3
	Lce0DrBsra6Y5kkcvbdSkjPlThZXVcTUMhxhOMF8v4614SXbdViyaYfAOsBWRUZtBemZBdVJYYz
	zpGtEXM8GE+svZ0HqgR/UnDgAu8//3LNLOSF/R2XA9tD9nG1+yOh4osWeqer8kQPj+sWN0yMkE5
	qc+AopW5yNoytEhZkOZfOPBDOCD8g7ltZ2eCiACLB6JhAkUOD2hZKUNsU1MDGVXw81AmE5xuutJ
	DgtByJbnQzUxeFkUOt8I96ROZhkgP+kgIJ6zuqA6s0vUzCoPFftKareGpU0ZagbnJ2gUagtZWbm
	a6vbCE0dFJlW1tzyJYKwpwDDpleROCyV2/Gl4TJLx6cgYm3OSFVGYT77CiEGQhA96hb/nH5ruZl
	1edz+dHEk8oFJTX
X-Received: by 2002:a05:600c:a30a:b0:48a:58ae:9938 with SMTP id 5b1f17b1804b1-48e51f37f28mr83240865e9.19.1778148168089;
        Thu, 07 May 2026 03:02:48 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:76d:4c01:131c:ee41:99c0:e0a6? ([2a0a:ef40:76d:4c01:131c:ee41:99c0:e0a6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538b26a3sm208325785e9.9.2026.05.07.03.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 03:02:47 -0700 (PDT)
Message-ID: <d2dd6e44-d852-48f7-9dc4-1dd1c71b98fb@gmail.com>
Date: Thu, 7 May 2026 11:02:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git 2.54 fails to build for rhel 6 (2.53 builds fine)
To: =?UTF-8?B?0JDQt9Cw0YIg0KPRgdC80LDQvdC+0LI=?= <usmanov@ieml.ru>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
References: <9692091777837852@4991cc90-7cef-4f92-9de9-e195e7f2c04c>
 <affprsBwpM7L47j6@fruit.crustytoothpaste.net>
 <14616621778106505@de6a8060-5532-44d2-bc08-24865b6e9c4d>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <14616621778106505@de6a8060-5532-44d2-bc08-24865b6e9c4d>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/05/2026 23:28, Азат Усманов wrote:
> any chance someone could show what commit causing the issue, since 2.53 builds ok. Ive looked through the changelog for 2.54 didn't see anythihg specific that migh cause this.

The compiler errors you are seeing are complaining that it cannot find a 
function that was added in openssl 3.0 and as brain has already said it 
looks like git is linking to an older version of openssl. So if you have 
openssl version 3.5.6 installed the configure script is not finding it. 
You need to tell the build process where to find the libraries you want 
it to use, either by passing that information to configure, or by using 
the makefile directly and setting the appropiate compiler flags.

Thanks

Phillip


