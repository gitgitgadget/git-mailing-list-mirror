Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB0370823
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753347687; cv=none; b=SsrZVx/VzDMAq51s2u51K37DllxZjemJ2AtB7UBoHH7J8QaS+BkGt97b3JD2tDQGQ+u9NkrO4Zkof6aKJNMgCl9poEqXN1Vzdim+73L0mvkrplnp0D047ly0TcXrZF9rGFOVFlQrI5Q2cT9w9X4IZrH2vFItbrT5KI85679zxDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753347687; c=relaxed/simple;
	bh=OMgJzQMfHo2MKvEvCym8kETS8rklVJUIlIuYN2NqFYU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=l/WBl86cbT0OsMr/M8rODmnDSfdGBuzHeGiOQ3iwlo7twOd20qsBfHCSA9Unbx/kk3mpY5VHRDVvHbJ186tMCAULdeId0e1btjxRTccFUsG9ce7MXvJ7WpFVQXfD5KpqdYkvDD+2OVJRNT6zGrn2Uhu6sg81E0SBmMx+hfgRBVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embecosm.com; spf=pass smtp.mailfrom=embecosm.com; dkim=pass (2048-bit key) header.d=embecosm.com header.i=@embecosm.com header.b=CzcBTlTb; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embecosm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embecosm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embecosm.com header.i=@embecosm.com header.b="CzcBTlTb"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a54700a46eso335873f8f.1
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 02:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embecosm.com; s=google; t=1753347684; x=1753952484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :reply-to:content-language:subject:references:cc:to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJifJrZ+DL4CKkCU/MwuZ6Dy7Z/mYlWHIWN1dMT8QLE=;
        b=CzcBTlTb6m53d7wCcist4xwMcEMdWZj+JZWrFJbAK3FBvqOfvw5wIDvmE4ydAR2MxN
         ePZvzN25ouAfC3/ReHugHwGahoaVUcLrPfbOraFoOW4H+00WXYYgD2Unarg7nCYLX1HV
         aFURry4p1kJJGy60IphUygsZFyybbWVF2EeYO4yHTnqt2E7iCHLiyV3tyHkTOodlFFU7
         ndsMXT/otrCt0slPhtL5ln0OLoVZ7ziDmZZBWLyjLu9wblxm/Nm9X3gFY7z80qKvscqy
         Ffgn9NQzsfpNJ52HJFBCdzSoFsuwryetN9Gybzcbt5qcpbxc0Va99tTXo1sY0vzW3fi8
         Usug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753347684; x=1753952484;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :reply-to:content-language:subject:references:cc:to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zJifJrZ+DL4CKkCU/MwuZ6Dy7Z/mYlWHIWN1dMT8QLE=;
        b=lSw6Ii+lnEDd7gCHdazBjkYOklWIaf8NmkebELdJLxjmNaPsuPOvjsFBxbS2TQZaU2
         ja+KnVCqtFOqa1ca4o+qMkNv9V2WPjiPA5WiWC2DB9FV99urEkTVQyu4WEVkwZiclmnI
         3rJ9YAhHtWjj8wxt1VvtxO9wFbUas+zqZqe6tByD8zfrPFrY5JxoqV77zE7JfCQITw4l
         IQCMVfutt9sYa9g0OCIy86PEBZa0+udPqw48P9/m4IpTv/Sa8lxLw4BshQLYta4my1H7
         nyNEpu/3v3O2KPFhv93FfP1WoDeec9lFLfZaueUCAJaKtoZExg8qzG/uELy9HJG/hfl1
         8lpA==
X-Forwarded-Encrypted: i=1; AJvYcCV5nknT22B/G/yXQsqigoBga0HdlhpsBPH8IsOLKe6jvHHPQwYgClA8UL3HS8ZBRHJgkjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt0/ZWSWvglT6b7YbuwiYt78gCPZaD1x4wKGD7dQpJRBAfTXs4
	vwuohsrjwLyIUsxwKvmMsA/50uqp9PRN9vq/iypBkYJozrk/57O8KbECVWoADUWMuTk=
X-Gm-Gg: ASbGncu6QgYMTXTReU8XevRfjV394qrznODBeH6Kt8Ddc/X8+RE/352KscDchGB7zTd
	9xWRMxk2DH+QS+AFG76p8idR6qMPqkqI378eTTeZ4+sliIKuMb+yQGJ6HKZ7lXZ/BzwYhj8FyV5
	v0r8qMtRfYe7H36EyJB5PzohdSSy4lXNdidD3Mo9CqNUu1ZvM8ygDreCsbS8h2KIn/G21YNVlU+
	oM1evlWCGgdiQLzBQxFQj5d32mjtNQkj+kk4WAxNsN9/ZI/J2tTXCd9NqHHCXa1Rqi52Qupmawk
	jK3Ko8ggVVyGUB+iIDHPs3CADZApHFdLgRBfa9cdONdru27VH0vbnPsQ0qzKlNsbjglULaWPVMH
	QCS7uh1nDgW1ihktkPbIRo9qvuyPUsPlUrVVmEXxRnJWPEZ8lLqe5L7i/p09PkUrmkW2iA+6Z6O
	0U7mSuH7aPg7JpvipLr0R0hw==
X-Google-Smtp-Source: AGHT+IGI0v9IMfQCbbjtTGc1zDTPOxjJ6Jw00dHQVXQ2DqlBB/GEGuGjThL6FOIIgZlIPKcARkw+Lg==
X-Received: by 2002:a05:6000:18aa:b0:3a4:d6ed:8df8 with SMTP id ffacd0b85a97d-3b768f1f0c4mr5692508f8f.39.1753347683633;
        Thu, 24 Jul 2025 02:01:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1f0:96b0:2863:44c4:9edc:7fe6? ([2a01:e0a:1f0:96b0:2863:44c4:9edc:7fe6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705378f4sm12846165e9.2.2025.07.24.02.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 02:01:23 -0700 (PDT)
Message-ID: <7bf054a1-0196-4ad8-aaa4-a432cd2c93a5@embecosm.com>
Date: Thu, 24 Jul 2025 11:01:22 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ps@pks.im
Cc: eschwartz@gentoo.org, ethomson@edwardthomson.com,
 ezekielnewren@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com,
 me@ttaylorr.com, newren@gmail.com, phillip.wood123@gmail.com,
 sam@gentoo.org, sandals@crustytoothpaste.net
References: <aIBlxnoOqwHhGzMd@pks.im>
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
Content-Language: en-US
Reply-To: aIBlxnoOqwHhGzMd@pks.im
From: Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>
Autocrypt: addr=pierre-emmanuel.patry@embecosm.com; keydata=
 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
Organization: Embecosm
In-Reply-To: <aIBlxnoOqwHhGzMd@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On Tue, Jul 23, 2025 at 06:32:06 +0200, Patrick Steinhardt wrote:
 > It would be great to know about the general timelines of these
 > alternative implementations.

We still think we'll be able to compile libcore before the end of the 
summer, we've made great progress and few items are left. But keep in 
mind we're targeting an older version of rust (1.49) and libcore is 
smaller than the standard library. We still have a lot of testing to do 
and we expect many bugs.

The next targeted version will probably be rust 1.78 as we want to keep 
up with rust for linux. This shouldn't be too long as most of the 
features are coming from either standard library modifications or 
nightly features we already had to support for 1.49.

We expect to be able to compile some 1.49 code correctly next year at 
best. I would like to bring to your attention rustc_codegen_gcc which 
adds a gcc backend to the rustc frontend, although not a full gcc 
compiler it could help supporting some architectures that are currently 
not supported by llvm.

Pierre-Emmanuel
