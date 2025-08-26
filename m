Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA8E1F03EF
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 06:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756191028; cv=none; b=Fo5g7sHuGICGJGxcFYDdRdI83bL6ytr15FEwEL4Eb3DVjlUVSnCtqsWL8FZeC6JK5/wBhHGXiuyLBwi7u/ldieR91GEOR603a0HgW2+O4XUr0UK3sBOGlxv3S7QoWTwb1wrhJrpe19YIPZwZ+21+/xjR61qkydJFF+hWFu6YkMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756191028; c=relaxed/simple;
	bh=JxArYu77H43A9XXhE/k4Ien/dDiH7E6j5esNWdsHRy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFhvE5zUMn8LgyRXtqerzK3nVuQkORTbw70Tj5giZPVlgQFKxh/sFaSy5mDxVHniUPdP0oMoLgP7opCpql1FGJH584JQ4otgff0G4rXTULn7+SSkrbH+VEqaxOsLol9HjRu2Zlp8FB21aYWgkfyhpSYKTrTCBzYrCjpQuf+ozxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ptd5yu7y; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ptd5yu7y"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3c68ac7e2bdso2219452f8f.2
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 23:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756191025; x=1756795825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sFtn/GOES8uXlYnBMi8bj4kgXdaDu7HAB7CmuutMMyM=;
        b=Ptd5yu7yRSdJd9ZK7EnrwENNqRE1P5I9JU/exnFcSwrZtyyqxPndiBUCeXcFbKT2Z4
         h2a2ZIPtm/qJYMi79H2Zgksc6bXk1ByAcwrJcm/uI721SjiAnEnSHkK1UKN8Rzq73BCN
         /7pDQY246MttU+nSMe5oqw4Pm2hqI/b2FamDnSVh2clPa3XHlgyUcM7uwsZl/Vq3G3lC
         6XmRxZHJQuG48UfENyhc3FrjDcagqY/7rsJjvgRRsOLiMxDrRjHwGB8QD1s4oJ6tC33b
         RJWzlbhd8yFeD3IO7j0CaNlHoj/nNp/ofal/1XswRCGw7re9V++ounmer3ti9pCohwaA
         04Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756191025; x=1756795825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sFtn/GOES8uXlYnBMi8bj4kgXdaDu7HAB7CmuutMMyM=;
        b=gFXWZ0N6/kkZIBqM6+zmWfZzUAkWZJyJe+l0ch/1PboGK5mykgZCDohGnruH3xm8cI
         3WnSz6f5ReuZb+bz/vvs0jgyrrKtNTs13E4D5y6hsJEG7XqlROdE0MN+zqmUcxHlHeC5
         gGKPWqeBUxfB94qgiMauEHIhEQ8GWGCkUfb3GUZJEtLDAtPcExOBRtDnnLCLVajxUfQ/
         4OyaTtHRBH97wihCFrYUHcLK+XW/mx58mWlE/4YSY89Pk7d4NqR+FZVS2BnvF8nPmktl
         8Gf+johTwdzWJ5zmQiUPt2lh7wRDSBBc8pUoLpnqurYOS2RHIhjl7UxJs0OtJyELzxGp
         AIMA==
X-Forwarded-Encrypted: i=1; AJvYcCXBuqjAXDLEmpGsrcp/5YP7OsIVm8tHPb71Qdj6QEYw1aIMIbJg0MI4XLZlazhyVpQgv7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCr8zadkDFg+VNvlEedVxZYhZ5c7CxJNftiBcMd51/EA8T8HLn
	8Zri+M+rKpubQIsDyuS+UbnXmXywhY727dd6ydi+DIcEpx+VDSGrNioFMUa9yML3
X-Gm-Gg: ASbGncuNOZtnG4oaNZsUaydPitRPJEbib6CPJG1ffR/tfaM1Fjos699WGuxmD4Oigog
	TQkxrr3iD5Omemhbru6DdBIbpXulcPu/vC5lraRdnoG/yefj6OS/lkmtgmaq9WIiFuHXWBOMmIs
	vF4fw4dq95SDv8NZIPQ0ZNfYJNjgdZ344w4s3COGqeA9LDLBF5oRZBhdAJKdMNjAbZq3q8l09cH
	nwVdGdzO7Te4w/XRfS5yhe1xbPgVsUuWQYpXFgxKuvQRDLzdXzRQJ9YA80+hxzibRx65UPkZi9n
	33rvP3WRKjjmWTn6trLQ4BdHy5wm8wXoDM/Yb7fXIMTtP4KTgPpTBL7c6WayEOx2lrkC+dJIZn5
	8mVYmx4jjiM5c5quQlxJ4aXZvHUPDxJa2kJGJrEsYJ6j3ddKjhvtycI69QP67h3mxkzVR5Jc8ch
	Y1o2+Ag8M6tJTFTC0v7SCOhMeViiK36YM/g+MUsjw+qDuc/xgZV4zWvDk=
X-Google-Smtp-Source: AGHT+IGWY1w4iZzE3BaRXw/Etewa0kvKXwPF1SUGjA4563dkN2QnG508glJ50d4PDrx7RflIXaznGg==
X-Received: by 2002:adf:b317:0:b0:3c6:d122:6034 with SMTP id ffacd0b85a97d-3c6d122695emr6327072f8f.45.1756191025125;
        Mon, 25 Aug 2025 23:50:25 -0700 (PDT)
Received: from ?IPV6:2a02:c7c:ec1b:7400:3db7:1526:c8b0:1184? ([2a02:c7c:ec1b:7400:3db7:1526:c8b0:1184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70b634943sm14627287f8f.0.2025.08.25.23.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 23:50:24 -0700 (PDT)
Message-ID: <4cc62d0c-eff7-4d8b-8f30-28c7d9064ce4@gmail.com>
Date: Tue, 26 Aug 2025 07:50:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc:clarify which remotes can be used when
 contributing
To: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Cc: Daniele Sassoli via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2034.git.git.1755630882418.gitgitgadget@gmail.com>
 <pull.2034.v2.git.git.1755940331248.gitgitgadget@gmail.com>
 <CABPp-BHCQjFtpr8meUqhGEiTgsqZ9KTWcpLYA8yEPUsCAceAGg@mail.gmail.com>
 <xmqqtt1vs77x.fsf@gitster.g>
Content-Language: en-US
From: Daniele Sassoli <danielesassoli@gmail.com>
In-Reply-To: <xmqqtt1vs77x.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 25/08/2025 17:21, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> On Sat, Aug 23, 2025 at 2:12 AM Daniele Sassoli via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>>> From: Daniele Sassoli <danielesassoli@gmail.com>
>>>
>>> The docs mostly point to using git/git as one's remote, however, when it
>>> comes to Sending a PR to GitGitGadget section, the reader is told to use
>>> gitgitgadget/git, with no mention of git/git, potentially leading to
>>> some confusion.
>>> ...
>> This version looks good to me; thanks!
> Thanks both.  I'll queue it after reritling.
>
>> doc: clarify which remotes can be used with GitGitGadget
> The only reason why you need to even "use" remote is because you are
> using GGG; othrewise you would not even be using any when sending
> your contribution in, so "when contributing" somewhat misses the
> point.

Makes sense, thanks for your help.

>
>
