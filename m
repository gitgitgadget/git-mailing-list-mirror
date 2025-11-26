Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA38311975
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185972; cv=none; b=uch5PLqRVPsrVEooo1dgdyhRnYWdDs3HudatLW1z8ROiaT7sKpfful3DsEJtXealgFmOHiSz6CAZDwhhMm9rkk6I7X/Gq2Kv0yYjcN/nX20IXtm3WYVcq6fku/AoG8EKBb9mXlO6fe6h11LhB/FZhLZGZzJU4wILNATHjnSuzAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185972; c=relaxed/simple;
	bh=Y9fyVeH/2wuKhg98k21N9Z33pCQ7opExT8xpKg0HGI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptk1AGgKm16WSDKH+q6PJ5hkaIwxR7RhtwgCeJFUp4isMa+1P3G/Ow7T5sJlcpMDA6xEcE/NubPN0FFI5vt41DEiDkmcI619naam1PDmNQZiRV2hJMyNg2i0MfGEuEAxCQab9GMQEV3iSEVuqDgidLlSJCJGfgx81EZbmxGfPyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLOEDhNK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLOEDhNK"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29ba9249e9dso1495335ad.3
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 11:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764185970; x=1764790770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ogXcCVUzwbsWW1Pv3qglAaV8AI1OdptnZnXN/sGrhQA=;
        b=gLOEDhNKPJdgjbHoelVdY7MPMAlYG4voTFi4BtF08VLsTwnJ1vQPXWtNe4YbANecsP
         zVfBTq21pmH4qAPGuhPIDdz327Qs6Iq5E81w67VTzxpH+Jj9cyp91IGmzrmXx2XHrpLE
         4vP69NYz+cnLayXsIo9X6T8YIXmXkopZpELiqm/+p02VI91X/AkyFq6lNNLBByJ3JGJL
         sgn+WHcGflIrkdMQixMaXsqDV4fgRi8E3+cqn+zgDvLOZLMbFcXj5fBHwA72UoQPXSYv
         1Iku7w9te4aUdtMQivsSqo0yxDyYdpfFD/OL5ibJGqmneGBIkYwWZRqzMH/rBOb7pjBU
         lC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764185970; x=1764790770;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogXcCVUzwbsWW1Pv3qglAaV8AI1OdptnZnXN/sGrhQA=;
        b=NlVdS7cdcTmNR3bCjeozRpDNmCWDCSCWIXVEsXD4pcU3NsUzxGK6Z93mDVr1denTNA
         SHEazpE4B/GEAtRuG23pMkLvJXRbkEDlOYlKFihq2ey/2AnlaiViqOIFNub3eGdlmJ1Y
         gKE6cJrRdANJG1NOdT4PUWK/vrDJQXVoOAP0UM4T+8dgp40aicq/VFWmwjH7eKFBIYk+
         X83jk5mznMgfznJYK5PMvpzvNsQWPvoKcN/KFzUKTZ/GHlbwiQ6QCZAxg/wZXu1pmIkf
         ol48Ss+tsTw95n99nluXjOrAl2pU9ThezsSKgkI/p6gNG9FjwzxGcv0U5NUbcUwCFQ9k
         +Vcw==
X-Forwarded-Encrypted: i=1; AJvYcCXT/Tr5zFg3TWNvMJA+wvAG68VN186rZNZ3QIrqKd5mMGgXrDQmhiUAJwUb1r/NFdxQtoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTTAtctKjwF6vyIucwB74NoiO8kBdFYPGenlta/zIlXVhpftG0
	muP56X8NRzPNGdPEfGMIHFYM5V0fTTkBX7yOEWpCTEymzCGdV0dKdqpa8xE0v427
X-Gm-Gg: ASbGnctLO5UCSxxQCmjYcRfLm23AMIABqhV+U/S7NAmbVTMa32ynGkxjJheN7FOeYxK
	v+Vu9ZOwSLnLJaTScXe3bguTj53I0uAHbueE0wdIygHF61eKCGDCjD8DkITbWKp4Mhs6YwAb2bm
	+VATmpatItamVP3rc4Sgs96ohC+kJtTMTXPWt8t2AXgmwNUgghs74Xbl2U5N2DDn/pKCvwIMEPU
	snOyg8YWFqrUCI8XJLfpnIBTP8iaKVQmq33dpBotJAYNLOdJtsvboh+P/am8zCdBkntDy3gbDvH
	3r6x6t1Np52lo+Q36GdZOXC0AqTtsnrYQNhsCbS6wy1/1uXxHYknu/h6CIv7T3++gdax03fUmqw
	1lmk7ESh4+Jz8GKOewMZz19QbZ9YU2y+J03neBI2Xwc5Kz1sYxnkQjJH+8N5zgj6cW4oXl0Hr+K
	OMI9Y/T/4ILogBRHzfnuaw9K/f/jtc9VxMaU84Uo5nTgkrp1vJdNsMBV0nw0LMJal8FCjAVC+Q0
	+z/NA0FWR07hYsdnf3DFGc=
X-Google-Smtp-Source: AGHT+IG9+wX2aBTUe07vWxX+yItVQv/Swm3IYVe6j4czvS53eJf7DHptu6lx1bEcqGeI44XzmMAupw==
X-Received: by 2002:a17:903:94d:b0:295:fe17:83e with SMTP id d9443c01a7336-29b6c3e8dc0mr230736605ad.19.1764185969743;
        Wed, 26 Nov 2025 11:39:29 -0800 (PST)
Received: from ?IPV6:2409:40e3:30a4:b776:bc94:4b73:d55a:67b2? ([2409:40e3:30a4:b776:bc94:4b73:d55a:67b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b111aa8sm206484615ad.11.2025.11.26.11.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 11:39:29 -0800 (PST)
Message-ID: <38b51e19-7939-4a5e-8ad0-2d8168bc0fac@gmail.com>
Date: Thu, 27 Nov 2025 01:09:23 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] replay: add --revert option to reverse commit changes
Content-Language: en-GB
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 gitster@pobox.com, karthik.188@gmail.com, code@khaugsbakk.name,
 rybak.a.v@gmail.com, jltobler@gmail.com, toon@iotcl.com,
 johncai86@gmail.com, johannes.schindelin@gmx.de
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <20251125170056.34489-2-siddharthasthana31@gmail.com>
 <d563b68b-e01d-4b18-bd84-86f36e61a70d@gmail.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <d563b68b-e01d-4b18-bd84-86f36e61a70d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 26/11/25 16:40, Phillip Wood wrote:
> Hi Siddharth
>
> On 25/11/2025 17:00, Siddharth Asthana wrote:
>>
>> diff --git a/Documentation/git-replay.adoc 
>> b/Documentation/git-replay.adoc
>> index dcb26e8a8e..ad7dc08622 100644
>> --- a/Documentation/git-replay.adoc
>> +++ b/Documentation/git-replay.adoc
>> @@ -54,6 +54,18 @@ which uses the target only as a starting point 
>> without updating it.
>> [...]
>> +To revert a range of commits:
>> +
>> +------------
>> +$ git replay --revert --onto main feature~3..feature
>> +------------
>> +
>> +This creates new commits on top of 'main' that reverse the changes 
>> introduced
>> +by the last three commits on 'feature'. The 'feature' branch is 
>> updated to
>> +point at the last of these revert commits. The 'main' branch is not 
>> updated
>> +in this case.


Hi Phillip,

Thanks for the detailed analysis!


>
> I'm struggling to understand when I'd want to do this. Why would I 
> want to update 'feature' to point to the reverted version of its last 
> tree commits rebased onto 'main'?


You are absolutely right - the `--onto` example I provided doesn't make 
practical sense. Elijah's reply clarified the architecture: `--revert` 
should be its own mode, not a modifier that combines with `--onto` or 
`--advance`.


The realistic use case is reverting commits from a branch where those 
commits already exist. For example:

     git replay --revert main~3..main

This would revert the last 3 commits on main, creating revert commits on 
top of main.


>  In order to understand I ran the first tests case which does
>
>     git replay --onto topic1 --revert topic1..topic2
>
> after fixing it by adding --ref-action=print the resulting commit log 
> looks like
>
> commit d337fab78e90008835f74e890039b464a0308cbe
> Author: author@name <bogus@email@address>
> Date:   Thu Apr 7 15:30:13 2005 -0700
>
>     Revert "E
>     "
>
>     This reverts commit bceb3acd81ddd36ba0da391fffa48949a1337276.
>
> commit 47f0cc1c1f1911c0047a4d79d79f7c19c6c7151a
> Author: author@name <bogus@email@address>
> Date:   Thu Apr 7 15:30:13 2005 -0700
>
>     Revert "D
>     "
>
>     This reverts commit d953cf2dcc1da8b51934e43fd83dac72d0e267c7.
>
>
> The commits are empty because the original they are reverting each 
> create a new file which is then present in the base revision but not 
> in either of the merge heads when we revert.


This confirms the tests aren't realistic. In v2, I will create tests 
where the commits being reverted are ancestors of the replay target, so 
the reverts produce meaningful diffs.


>  This suggests to me that it is not a very realistic test and I'm 
> still scratching my head to see where "git replay --onto <commit> 
> --revert" is useful.
>
> If '--revert' does not make sense with '--onto' then perhaps it should 
> be a new mode that takes a ref and acts like '--advance' but reverts 
> the commits rather than cherry-picking them. When reverting a range of 
> commits it would reduce the likelihood of conflicts to revert then in 
> reverse order so we should either recommend passing '--reverse' or 
> make that the default when '--revert' is given.
>
> As you can see in the log output above the new function to format the 
> revert subject lines is buggy.


Good catch! The bug is in `generate_revert_message()` - I am passing 
`orig_message` (which points to the full message including body) to 
`sequencer_format_revert_header()`, but that function expects just the 
subject line.

Looking at how sequencer.c does it, they use `msg.subject` which is 
properly extracted. I need to use `commit_subject_length()` to get just 
the subject:

     int subject_len = find_commit_subject(message, &orig_message);
     char *subject = xmemdupz(orig_message, subject_len);
     generate_revert_message(&msg, subject, &based_on->object.oid);
     free(subject);


> If you had used test_commit_message() to check the commit message, 
> rather than just grepping for ^Revert the tests would have picked that 
> up.


You are right. I will use test_commit_message() for proper validation in v2.

Thanks,
Siddharth


>
> Thanks
>
> Phillip
>
