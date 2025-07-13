Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C389D3FD1
	for <git@vger.kernel.org>; Sun, 13 Jul 2025 04:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752381584; cv=none; b=RxZQrSnNRKnY1s0e05Ak3UAVtN3aCWmAb1LMXUG6s8MosB7/GUjPAqKxqkyp/zWGCCX8M5YFh9EWA3IKAKT3jcVstKgt8ru/gnf4OR9IQiBxyRzwXCzjxPdsdbep/nCcCvHV36VeTxR+troeogWOiNNnVOKrtqSsIZE2BY/PDiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752381584; c=relaxed/simple;
	bh=hoHmoFvZjTSEGa/aZbni7mASDQVKRhmnsnBiVDghE78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyAbTeSRIceV0kfeVM+5Bofta2giYTfI62+09VDQERsHwflQWjcrYQpOndMxq19sfqOT/Rq2NuZc98vNRJl7oHNJO66BFVZbjR6ejhi2ACIZ75tbbfitKn5BXVCawHlDyAaggrq64OGIruiQEAd3nTBkT3NsnAhGgJQ9BWgcEKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TN9XBvPY; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TN9XBvPY"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-73972a54919so2990726b3a.3
        for <git@vger.kernel.org>; Sat, 12 Jul 2025 21:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752381582; x=1752986382; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s0LyFHQb2wWjwuufzpG0UarnRMRumYzCt4E6jaXR2Jg=;
        b=TN9XBvPYBZHBayPn638NYiobfNZY8YfAN5NumXYK7h2onDi4Sm3cSOMoihYOl3nf5s
         TlEauNJ0+HcEYac4TYMjmpQ8qJBCtLlUXnkBENZx+LKzCeRcVXOxmqIzUy7b5ukdWWBq
         x97cZ28tBWhap4flj+Pfc3QpLZLB2I1sgmt17Ue1kmTYbBbKgWliP6lmq/8LqJiCFGRU
         pt3OUvRTdSR+0IIQ/eZKeV0enYU7B3pZELpNYNzAPQ+OJkgZ9hIti/NsEv8KYB5LfYlv
         fHqFh/gQCi8m5p5cluPJiXIp3X1jOf0X97IrPqOw6O6TQxYYg+BDK85M14WaQohf2PpA
         tEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752381582; x=1752986382;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0LyFHQb2wWjwuufzpG0UarnRMRumYzCt4E6jaXR2Jg=;
        b=gewx87T7ffgmd0mwfaLgKtIUkyFYulhuqDaI3qOFIqOBE7qhp1lLzdQx4+3TD/Y8xU
         mFj1ToXII5VLqQbdzDlWiPznuM4qeiZGzMgF63uNDwa3VG02HMO3rHM3dNo9IHIkGhEZ
         Owzv6fOpVG5NzMDLnaDYGDy44WMYsGKu7aVPI54S1JYBBCcWn5RKoEIcjZd42Mu1I2P9
         ef+JjSmj+oe3b5l/m3rb5bpxZewubZ0G7q20DG51x9NtHVTTJLmJPT0k3hxBpvXUCidU
         tagCRDkgIJa1ELsu/fGqigmPU7UV+isBVoXXimCQ2Uzap9C1w2Lr4e526NVdetFFl+YD
         LZrA==
X-Forwarded-Encrypted: i=1; AJvYcCXtb0YwWYhT/vWsCblN4PzVTWi85QOrsEWSLxKoYAfxeFQYcQnhwYGll/UigrQjDDVf6wE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5LqHQn5iQSvsjnLovfsbBNmmQX1SdW/pWcXC8EXSLp/kNo4dy
	fEfGs1adSp8gbgJWxpIeT1rs1WZVrcEI2igJnjOn8PcfTBGv1bV5RgPTZQS0XQ==
X-Gm-Gg: ASbGncvQQsz8oh2rUkt0ovLouCWAFxS2XgM2nsGj8RcGwt9SqSSG5TVilNHrKEhnD8p
	nCqxy+VNm7an/W94Zq0VaiI7olqnRuX/IkEGayFs6eYomIUL+kvEgaUTp1z7vQUwXFbGP43EljY
	KFWIehG5fReD3bVK1I6mrmF9BRVGafeteOLYz2kZ7Cbr6LXw4nOZEMcQGaSUUvlkphVdZEv+wtM
	NJhGplhLeMLkOcafwQtJMMC3bFGIAQNzr3q1GVd+PMbd8zoOG2nE2kK78tAc6TcpQXYE9b1wfEM
	RdQiwNbhq2a0SCGie8EVYk8g75oKJPXFH6qsXhb/Skf85xipCvozHVVfgJgVtdCg+9W2VR5pGYx
	rdCEBRQOmXQP/84OCmkKHC8gVYET+zEevzOG42ZJzIBb2JxPPMsSjPJtQE2Y=
X-Google-Smtp-Source: AGHT+IFYPnImbx2oN8MWE3I2vVZVqJxkdW39b2q8k6c3cUWxcmxT+BJz2cDGuMfhbFDxJSMBFEmnQw==
X-Received: by 2002:a05:6a00:3d12:b0:742:a91d:b2f6 with SMTP id d2e1a72fcca58-74ee25584f9mr11691673b3a.13.1752381581754;
        Sat, 12 Jul 2025 21:39:41 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:6492:afd8:9054:f41d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4c989sm8406995b3a.130.2025.07.12.21.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 21:39:41 -0700 (PDT)
Date: Sat, 12 Jul 2025 21:23:20 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: =?utf-8?B?0JDQt9Cw0YIg0KPRgdC80LDQvdC+0LI=?= <usmanov@ieml.ru>, 
	git@vger.kernel.org
Subject: Re: git 2.50 and 2.50.1 src fails to compile in rhel 6
Message-ID: <3ecxwlvjbamg7shdnmvps2y7rszsxeqvkkox5lt5zshk5qi5z6@exwlj2brax27>
References: <1615371752315594@mail-sendbernar-production-main-92.sas.yp-c.yandex.net>
 <f636840b-ec66-4059-9d0c-3cca07d42007@gmail.com>
 <8795721752334860@mail-sendbernar-production-main-77.vla.yp-c.yandex.net>
 <1737451752344703@znolar4klagewshm.sas.yp-c.yandex.net>
 <24c4c6f4-00bb-400f-b315-bbc5e81983cb@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24c4c6f4-00bb-400f-b315-bbc5e81983cb@ramsayjones.plus.com>

On Sun, Jul 13, 2025 at 12:30:59AM -0800, Ramsay Jones wrote:
> 
> On 12/07/2025 19:25, Азат Усманов wrote:
> > I was able to apply the patch  sane-ctype.h  make did proceed until it stumbled  again, this time probably related to that path to random.h file I substituted earlier. Any thoughts?
> [snip]
> 
> Wow, RHEL6! I think the oldest version we support is RHEL8.
> 
> [Moving header files from a newer glibc to RHEL6 is a definite no-no - don't
> do that!]
> 
> Here, your glibc version is too old for getrandom(), so you need to build
> with CSPRNG_METHOD= set either in your config.mak or on the make invocation,
> something like:
> 
>     make CSPRNG_METHOD=

this would probably not work, because of the overrides in config.mak.uname and
config.mak.autogen, so config.mak is better:

$ make clean
$ echo "CSPRNG_METHOD=" > config.make
$ make

Carlo
