Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3EA823A6
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721395390; cv=none; b=qbGescw+OCgUDYjPByeomUKVygr0y7J6hvOeT3FaaO9DJj7IEkHjnrFT8j19PpYH9RHXKYhbAwMI+JfDc55iqDOfsLoFyhgvBnBR+IEWJRvlz7p6T8P64TakWRUleFferD9IhBajeT+mQXHJn72pBagDpEDt7NKIT+DVuiY9KCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721395390; c=relaxed/simple;
	bh=lzG+TUohF5HwWm41Q9LX1DnN4unQhcTT9m9waKiBS2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=joyvXmLXBd/ulz2fq4Rec2gi5432LzY6FT+MJMOr+pa3K6BDVfwGH2drxos0Kz+fsNrdY9+/K+tGAae261HJpu/1iIj3v9/UQ+Ip0LO+Bebl8anfcnZaI37mwUCrihK7zwN6fDPOGEGKp73TJ1h7J57gH9X7TMfLwhYvXBY3lQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwL2pMGc; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwL2pMGc"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5c691c6788eso949519eaf.2
        for <git@vger.kernel.org>; Fri, 19 Jul 2024 06:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721395388; x=1722000188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oyNYQK6clcDExiqi1LW+bGu/qW3+bXyJLgDvIeg6maA=;
        b=AwL2pMGcOpkten6PP8CzvyO+S8TLDBSyLqtSaLK324rnLGp9hhf4MfWPS5erMm3v2G
         e6bEv8Nyr0Pfe2/S5/X5Qeq1EPT/tuFEmlmBhxKsjhkcXAhK0A+Q85sDWZkYvz1tXHfb
         ZWYR9UkL967QOzduyH1EwPUwjtbFEid7Zx5vxFZuITtj70mp3L33jB7wwnWkQfn3mPgu
         E4UdiswTfI3XI16FmNKRUKBD47JR1CFsZkuOs9XCTGEAbHS0HJ/Mx6bsFjfPPX2MGkgn
         D2FfIqJTMHEuEUR1XKgDp6Ba6bq0j4aftaG/kt7TEINT3fhgdL4qhWjbYks0tiGlySND
         mDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721395388; x=1722000188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oyNYQK6clcDExiqi1LW+bGu/qW3+bXyJLgDvIeg6maA=;
        b=Wh7TD2EZiJAWoLYLm5Tmhfyeta4gYDHFpC5+D/at5eyII74KaYMM6Hm0rQqyb35vmL
         B+NikRZJLF93QsJAcfm+USz57Kd7t5+Hthyro+o8ZfK4hvMsY9Aj4SFELiX9tjMxFK0f
         ptnLSusVEkRVvfTBjQt97jmW7pZOlaxoYO5C9UdKGUovB0F+8zCNo/dGn4CEPdFK3iHp
         YpPd1rJACCCJGMRh91UkwQ4YxdnQiFkiQwg7U6IdNfmE1OsgX44mDsDAAjdopvsWIBXl
         SmdBH2mHi1INWVC4M8Czu/vXRd+KVeBLv7r98bw5G50Ywp548LHRKF2LE2O5GH5Gzy78
         JJXw==
X-Forwarded-Encrypted: i=1; AJvYcCXGSFIDnvPg3RZGRBkeE8tuYcphl+l+bgWAOEmYC6yIyXRyDIfoZiZ9Ko8Y3JAcrIvoC4OzjtZoJWA6q+5F4ea4hHKo
X-Gm-Message-State: AOJu0YwZmMSAPdHAybhb+kHQ8ThUmJ/igjtdXIBd0b3VvklXGS9Q8uvJ
	pD2yy0z8Y/wbbOqTDMT+pazh7JjAXCn04f6b6ngVk7fnqRX4brU6
X-Google-Smtp-Source: AGHT+IEpn75zlQl66z8WvjePIFGisw7n491JrnphVOVtTYdRzKTX7WWWxCmHTKTETG1sIAo0jItX3A==
X-Received: by 2002:a05:6820:4d0c:b0:5c7:b679:4503 with SMTP id 006d021491bc7-5d4165535c0mr11518515eaf.0.1721395387942;
        Fri, 19 Jul 2024 06:23:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:2173:6d19:3a2d:9c4d? ([2600:1700:60ba:9810:2173:6d19:3a2d:9c4d])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d55aad132csm230894eaf.34.2024.07.19.06.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 06:23:07 -0700 (PDT)
Message-ID: <4b154e61-a9ca-4c46-8548-b072d65a64b9@gmail.com>
Date: Fri, 19 Jul 2024 09:23:06 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix background maintenance regression in Git 2.45.0
To: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.1764.git.1721332546.gitgitgadget@gmail.com>
 <xmqqle1ynz18.fsf@gitster.g> <ZpmZVAL5MihrNVbN@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ZpmZVAL5MihrNVbN@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/24 6:38 PM, Taylor Blau wrote:
> On Thu, Jul 18, 2024 at 02:57:55PM -0700, Junio C Hamano wrote:
>> You already Cc'ed Taylor, whom I would have asked for help if I were
>> the one who found this issue, which is good.
> 
> It looks like there is a small typo in my email address as
> "me@ttayllorr.com" instead of "me@ttaylorr.com", but I saw the message
> anyway ;-).

Whoops! Sorry about that. Repeated too many letters. I've fixed the
GitGitGadget cover letter in case a v2 is required.

Thanks,
-Stolee
