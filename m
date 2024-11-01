Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03775168DA
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468657; cv=none; b=Z5kDjP6JCQPnG8slgr+VF+I/iPNPyId42DdAVYXqfo5P5VrlIokO5pARQyjUJzdFFbKNCEj3jOoISKS0TWjDuv/kD/pXxfnskyWPwwIaVw2NUkHvaOZzXNgnfmWuqofDvAtT/cFayqoyDR3X5DJQRlX80Yz5V4UOchz1FEmwiuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468657; c=relaxed/simple;
	bh=MkAXlkDzcPBOLiiFqfo4m9wHt+zWNLFjpVeewugu4Rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uoCCOm1d0yOmkGslUlUkunAjjHTvteraW4Qmp0bGeIgIl3b4fkYkkjohdtyEVHPuDYEpOOTanEs4D//84/Et3pLK7092JIbQCXpc9Xoqle7SpW//LgNmAZIU3XhCpd+akh/yR71AkfYgq4338gOaXD+HvT2PHhY//fgGHsm+puI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhjYaw46; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhjYaw46"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e3a97a6010so22160337b3.1
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 06:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730468654; x=1731073454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJdfu2R/iD80F8pcqd5pjwGUjV5IpVG2cjUVZHrk2Go=;
        b=KhjYaw46lYDNDdJnwgmUzEm2mbZ/lyQL9OA34Pl+1yltY4fTFN2N3ghGmMmw2JlvLh
         kjSpGQttuWCMyfQuFj5xiReQKvkFZU+0g6k82RAGWcUVpm0RKhLaNyoyzKWkYYTliFzB
         cWDCJrR8rgdcVhVFyfwJska+v4Lo8/XqQ95hA+0Aw/HH/iI+Ghe15bheKsp4NTZWreWi
         LeIbeouzMffz6eTSH1PCKMcrJGZD3mB8wTOiHVUKlp4IEaeP0M7afWXjl1xfdVMG4o6U
         jeGzbhqxnGPbXr6/tv5ntDX5PpZlffA7qqMoyQTDWu+vheVX6dVKlj+YT23AT/8RYEgV
         CMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730468654; x=1731073454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJdfu2R/iD80F8pcqd5pjwGUjV5IpVG2cjUVZHrk2Go=;
        b=VuhRVyrDhzp9r23KpXgd0ATQ/aXzQzXksMKrgLHdAm+yWO4CzuOYkMtE/jBvJcd8JD
         gybd9zeKlS1VSoTuNerZw9rr1plH8UNf6skLmTqKPoa7fcTWwwYF483FHSIq+8XAuGMZ
         OCXhj+tKmMmxbgxCckXeplMm7EerZLT1U+bxShpfoj23ULen3ly0qbzbTQWfmf0fNPcg
         ykYkZAj17SILP39DHJu1fbwIPhWTnMjsreshzfAymD5MmmyWl3oqAzZi+U1iY7mgrKH3
         B75ft2wNtruRfWkUXZAN+uSRI2D4fk+Als+gB+ai3Ctmv5qlMXf2HQ/4kE+w4zYqjEVI
         avIg==
X-Forwarded-Encrypted: i=1; AJvYcCVu9xYn90Jicmw0u1suwNypxDPCWOMwAUGrSP86NyJAcYQJRXyok9jhC5oCLCImfqoJpic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnUTMgAeoCihA/TujcdyojNvXnNQmmhBb3vgGhIQnd/q2slrm4
	QPqByNT5JsI4d5iH7UkD9cbTI0e2u6codDWmqWzUUKFIDfmV8dbh
X-Google-Smtp-Source: AGHT+IGhXZ09fKRXZ8kh48pcX6NuigYil305M7Rlxq0NvKasWiSaV7Y09m/++qyRC8AvNDLxgFY9Qg==
X-Received: by 2002:a05:690c:f10:b0:6e3:8562:fc0 with SMTP id 00721157ae682-6e9d871679bmr246338517b3.0.1730468653835;
        Fri, 01 Nov 2024 06:44:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:c963:384a:338d:bad6? ([2600:1700:60ba:9810:c963:384a:338d:bad6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55b242c4sm6789187b3.41.2024.11.01.06.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 06:44:13 -0700 (PDT)
Message-ID: <541b89c7-5e4b-4251-a8e7-3a9cde381064@gmail.com>
Date: Fri, 1 Nov 2024 09:44:12 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] path-walk: introduce an object walk by path
To: karthik nayak <karthik.188@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im,
 me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com,
 christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com,
 jonathantanmy@google.com
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
 <c71f0a0e3613555de83668473ce97db86aad659f.1730356023.git.gitgitgadget@gmail.com>
 <CAOLa=ZQnEL7i=QbqjHYjpjWv_uhG=u+1w1FUKTMgkfNYd3fefg@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAOLa=ZQnEL7i=QbqjHYjpjWv_uhG=u+1w1FUKTMgkfNYd3fefg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/1/24 9:12 AM, karthik nayak wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> The walk_objects_by_path() method initializes these structures and
>> starts walking commits from the given rev_info struct. The commits are
>> used to find the list of root trees which populate the start of our
>> depth-first search.
> 
> Isn't this more of breadth-first search? Reading through the code, the
> algorithm seems something like:
> 
> - For each commit in list of commits (from rev_info)
>    - Tackle each root tree, add root path to the stack.
> - For each path in stack left
>    - Call the callback provided by client.
>    - Find all its first level children, add each to the stack.
> 
> So wouldn't this go through the tree in level by level basis? Making it
> a BFS?

While we are adding all children to the stack, we only pop off the top
of the stack, making it a DFS. (We do visit the paths in reverse-
lexicographic order, though.)

To make it a BFS, we would need to visit the paths in the order they
are added to the list. Instead, we visit them in Last-In First-Out
order.

I initially had built it as a BFS, but ran into memory issues when
running it on very large repos.

Thanks,
-Stolee

