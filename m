Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C3E1DF253
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135599; cv=none; b=NlRg4EZGRQ8wiZPKedr2kfjDAmgm5i4JRz1GgqISHJKuS7MXHjbRFuc9EKgEMscXOCmjWZzV05I92NmcRtvpL7ZPDkGYFPrQI9v6pq+cDeOugNoTffWPgCjhoVmFhIgRZLwpqO/ZkDnwnJii4y3UC1Ks3/sXZHrrVITnNap7Go0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135599; c=relaxed/simple;
	bh=oxl9nf5ejKT1kpYfzs2/i/IzJ36NPVOrzsyF21h1dD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFd7ulN2tSeeCERM6mBLWaIR1ZJebr1y5AvsL4t7abndpowjOcYdXpnRWEOrdzjywCQoocGy0CIUTKSwzL9uwycho/VVFgSrS1PlB7wlijr5B22aYamwjy9h31IbHXJmBk3cecL3uH/lMnIE/kPN1Ge0AefHLRTClnqXWUfYNUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDjrOaBw; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDjrOaBw"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e290e857d56so4203242276.1
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 10:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730135596; x=1730740396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H5FdR1YGJHsUtnWW1DcrMpXBYb79t8tN+AoAYwGeyvk=;
        b=TDjrOaBw4sAMThq3kHp2b98wgniUcw2dSNqFfoXtWgFWEiTzxowVhohzdPFmRqncje
         uG1BMScEAnH18+Ffok6GzOQcxldbQLB2oMdBvvDn/AXKUMvohIo/yYT4wxhH/riX3orH
         SnRuG2ZENMwNwK9MwC9H/ILzde8xLkQyJXsVBeFFUcdrKj26s1An9ehA7YxeLcfQAXd/
         k5I5NMWlv4LAO0yeaTzZa4QsZM+7fW3EpwzWwlCxH9ax2rZQXbAZMpKjjcUCMlRaZ20x
         x+PWy+pq2MMhZbsscclhqpQThx/BMj2IBe/CUGeRrDBKFICB9KMlKVRJmMeF4kTpmnFL
         z66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730135596; x=1730740396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H5FdR1YGJHsUtnWW1DcrMpXBYb79t8tN+AoAYwGeyvk=;
        b=nf7VB9QFJS/MQnoq3+JhlSMXpjKcpfDr8thtEIvz6m56X57yJ8M4eQSJMh8WB0F/qf
         Dcw3rBlo6mz32CAyab7EZp/EHBnugIA+50HVpttS1bEn/GS4GBIy47D4gsK6hzutSA51
         OhUO9JrYfl73B/fMF3mE5vq/txZdKqjTSbR0GQ1tmDe7u5yuzI9uUAX+qdm4za+fvk2t
         u1enU+qXYvzXfka1l0lE5VuxyFX07i20kbSZQ0rD7N3yXhKpolWJ/ZTkCakOHybkUeeK
         UfeYJdggcheaEtsH5OPYNd9HeFObYdH2q6I7uAVl7NTdSZrOZHtOqEvuCKckW4ksXCIz
         cOmg==
X-Forwarded-Encrypted: i=1; AJvYcCUM9I3/KEuOPDGjt46ZMrm8BnPhSR5phh10Ih551SxqgIcCtrBEzyq1XXtJPuHsMjJ/2GM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyirv4HDwjyZvwl64OFdHCuL/rOzTQJsfZppyrwFKfr1GQuPbHA
	JqRz0DDFVlUN6pbZcFrD+8Z0HEulxB44OSx247Gfl8bcdIPH/xc/XdKu1SRy
X-Google-Smtp-Source: AGHT+IHHGyydSVKvsImQD/B6ZzFuy9MgxDBgYc0ZkB9Gj49ZDOKJ79LJ8mbGksefE0rzzmFGpQmR0g==
X-Received: by 2002:a05:690c:dd3:b0:6e2:3f8c:8fe2 with SMTP id 00721157ae682-6e9d88ea5ffmr77769307b3.4.1730135596209;
        Mon, 28 Oct 2024 10:13:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:2591:fac3:7e68:7ca2? ([2600:1700:60ba:9810:2591:fac3:7e68:7ca2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c7aadfsm15209137b3.86.2024.10.28.10.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 10:13:15 -0700 (PDT)
Message-ID: <00d80855-0530-4384-8d2f-5370ace9c0d5@gmail.com>
Date: Mon, 28 Oct 2024 13:13:15 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] pack-objects: add --path-walk option for better
 deltas
To: Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, johncai86@gmail.com, newren@gmail.com,
 christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
 <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
 <ZxbLFLDgCm6wLmB9@nand.local> <Zx8lHzDyqyBpzrAE@pks.im>
 <Zx/AGrGTN2mQZqGs@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Zx/AGrGTN2mQZqGs@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/24 12:47 PM, Taylor Blau wrote:
> On Mon, Oct 28, 2024 at 06:46:07AM +0100, Patrick Steinhardt wrote:
>> I've flagged this internally now at GitLab so that we can provide some
>> more data with some of the repos that are on the bigger side to check
>> whether we can confirm the findings and to prioritize its review.
> 
> I suspect that you'll end up measuring no change assuming that you
> (AFAIK) use bitmaps and (I imagine) delta islands in your production
> configuration? This series is not compatible with either of those
> features to my knowledge.
You are correct that this is not compatible with those features as-is.
_Maybe_ there is potential to integrate them in the future, but that
would require better understanding of whether the new compression
mechanism valuable in enough cases (final storage size or maybe even
in repacking time).

At the very least, it would be helpful if some other large repos were
tested to see how commonly this could help client-side users. Are
there other aspects to a repo's structure that could be important to
how effective this approach is?

Thanks,
-Stolee
