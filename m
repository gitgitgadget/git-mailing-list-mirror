Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F8B823A6
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 13:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721395498; cv=none; b=TSSYzQlfppOQ4Ks32OKlqkTkGN+bz1YTqKT0kST6IEcQHZNFVByIO686iVnHtRw4qJNLCdtSnLvqIk2KxjsdiY9cYGXgykB4yix0bEu5Yf+NvMFli7N21SwaZ1jqcHC/MzNLSjBiW7AYSofesdDkREPsUBHtUremU3qCcI36oGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721395498; c=relaxed/simple;
	bh=ynlElgsbwwwxFMjN3na0cr8ZDg/kS0bDU7zDAzVYCbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qtfOdTMk5Wr0oK1KzQysl46kFBnHbdRbK5YY/WrwWTckqyybRSYNDrlOotbCswisz1pxiiqxe4+xwNdbsCQXqa5GqYmJBO/6ELUHvdvc+/chOLNHTDfkNtPSINyvsJmP0OX/tu2YpNqi1cv0HRU1cvMVex8NO9zOR83UgMKZd2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7/dJW9m; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7/dJW9m"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7037a208ff5so1092144a34.0
        for <git@vger.kernel.org>; Fri, 19 Jul 2024 06:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721395496; x=1722000296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1AXn9V5e23aZ9Txa9yw0F7cLOxQTnYJmgrzmaQLuXz4=;
        b=T7/dJW9mxZ+6EXJAYmqVq+TiTxcxSRRGrStP+spQn02pIfFfnlrvl8Q7q/W5AOrntl
         VwTcseIOzN9VuM2fGhKab5qRodKL2eX/GtYOjhnjiG4Y7+UyMRZ7bu+otcc41v9NvHYi
         KtvcKHKX0vecI/hTHzaaV4tQeMOv6xn3+3jUM7r9EuhrP2HpWY+gn4ZWv5YffrLqNeeZ
         ryMEJu9H3PU8qrkFTftKzgKvzvZewaqiPX8fIxYsotBrVs/XrTcj2EoMnrNqFq6TQnr0
         PyyCVbOGUZ0rvg8ADVX2n0kG34oa1buTGWISNX5HWRvfG8rTvSrfTe6MKcB0mY3NCtLu
         CE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721395496; x=1722000296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1AXn9V5e23aZ9Txa9yw0F7cLOxQTnYJmgrzmaQLuXz4=;
        b=QaGy57SiJivnSpkBsotKst991CO3zZu1NbBT2pkpIW5bTZ2ZaSo8TXDlL9izMUoc0z
         CP21OHvdVIrFp2rGTvySYm9htrCZkZRySlD/xdtY5AzXyG7pw0xQo+YAe/inTCPKObIG
         RFaOgaJ0tN5fbqLGXliQjMbQLzPicscER0seYd0ek9BdNDRNyoAu9A3CA9FhWjCpUhpE
         stUvFSeMF2VPnGJBlxuo+l91vsqp2D2Z3tSg1DPKAvWQeXz9FymI30QuwhDFqELSEh+K
         Lx6+RNBUv3xSrQLTdjhj49b996vgI7/QU3uSR4fhEpjXJ+ulExG5SzxQ+rljweuPBNJ7
         8eFA==
X-Gm-Message-State: AOJu0YyaPChqGu7fqdhMW3qP+wearT/AAa2o27fEj4WQ65SwfhaBluVq
	mvoFUMjqyvHMHpMMGmAf/I+VdTLvwMtePjx2gPrye6YcyyIHPYOZ
X-Google-Smtp-Source: AGHT+IELQPDH1MhDqtCWzNua3Rp4Fy3JsUvcjg4cRmqQgLjQwVULAGzNysI2BwdwEDZHK1ZROmNb9g==
X-Received: by 2002:a05:6870:2312:b0:25e:8509:160e with SMTP id 586e51a60fabf-260d9157604mr6273238fac.3.1721395496381;
        Fri, 19 Jul 2024 06:24:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:2173:6d19:3a2d:9c4d? ([2600:1700:60ba:9810:2173:6d19:3a2d:9c4d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2610c716a95sm310111fac.9.2024.07.19.06.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 06:24:55 -0700 (PDT)
Message-ID: <81c7bd02-0c2d-452f-800e-ca0d3853a941@gmail.com>
Date: Fri, 19 Jul 2024 09:24:55 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix background maintenance regression in Git 2.45.0
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
References: <pull.1764.git.1721332546.gitgitgadget@gmail.com>
 <xmqqle1ynz18.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqle1ynz18.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/24 5:57 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Here is an issue I noticed while exploring issues with my local copy of a
>> large monorepo. I was intending to show some engineers how nice the objects
>> were maintained by background maintenance, but saw hundreds of small
>> pack-files that were up to two months old. This time matched when I upgraded
>> to the microsoft/git fork that included the 2.45.0 release of Git.
> 
> I almost said "wow, perfect timing on the -rc1 day", but then
> realized that this is not a regression during _this_ cycle, but a
> cycle ago.

I almost waited until after the release, but I wanted to put the
information out there just in case you were interested in taking it
into 2.46.0 or were planning on a 2.45.3.

Thanks,
-Stolee
