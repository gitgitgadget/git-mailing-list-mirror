Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176162EC094
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530517; cv=none; b=po0O8E6Ahgd0U9SrHOpWxbRSF/pZJb5QpdI/g/geXhmKHghdBs4hORox9TSF9WnEih2qHpyn7fasI1xpk2SZD3AH191+Vs306vTsjqNlUIVaDw7JmRqqyVOsc8sUMvm6dPWGkxTajQwOBI2IV2GjOrQucods6toqvaSDMIzvuVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530517; c=relaxed/simple;
	bh=dOGWTxs4Ie7KYc9xmcqkvaRUyVdlZx8kXsEWya5bomM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYK4YeplZkFfwDVrgUUwnbzLC8OF11Ax1358VT16zXa8TCMLgcwc05O7GhZH31AG/o9nWi+ianBzfMNXog9HcHJr0+e/OtYdREEqDmINfK3PcTKeWPu0Xm1E7lcaX+IIwICoPi7IDGW14IDUFBcX/D/lhmKkzrVUD7zC0ohn+P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hphwlP0n; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hphwlP0n"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-429bf011e6cso898495f8f.1
        for <git@vger.kernel.org>; Fri, 07 Nov 2025 07:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762530514; x=1763135314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=siFfQWVFxkyQhVys+C7lzdokNJoixq32xz2YIJo89jQ=;
        b=hphwlP0n+vRmI3wyVJ1iHdGk5kSzZ0lTfLSqDIy9WhczFY6eLXV+X4DSa/sr4+8JRS
         RdvDkHKxB7zB7oYmIdAXGOAxvT3g29tLUW+RAXP5Lw36iN1yX7dy2ZO1JeSMGeSGjO8y
         +Xlaubz6eZsYmg+QgLx0OR7J8HvKV2z5IY8My/tGOUIEoxw2/CUI414Rwnpt6ss6XK6d
         ntRX9BMcK1hCseMZzbbbUX2JzOFtYXiyZWTeOaEeyEN6I657e5nx00rjZbtP45Jn6RFX
         YwKYTqMx5awn/aCCCpGaJvYBgffEqnBynu15YYQf3X5+jrXMkHs7bY1hpYRkN0NOwpgS
         dkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762530514; x=1763135314;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siFfQWVFxkyQhVys+C7lzdokNJoixq32xz2YIJo89jQ=;
        b=ZSakul6487rav4lHjyKIsyPeE5BtI78FLQdgpq3CVD9QBBh73AzTvR1MmrT/BEa1P2
         DvkBMe3+MOpZuxnoskX+MXtdmn+CyAGxfgMHmY00k0RvWKKJUurBg2T5Zml1bgu38Ela
         R16FLot/mC5qc/grrbWg2yK55GzqbDgPKaVHwfjhEOXoDTRfiO+BvoHKqiH1Ka0IZ9hi
         ckkf4p31/VKZhz6O0NxJNRiPbAqkn5togcGXnwkjdZABMBFT30NPlXTBBBtCYCRgkx+Q
         /0XHkzO3DQTpuYTojBiKbptrNaJms4321+Ya3U6e/Gy5R0124VjiTZYqYdQi5/d9OxZi
         iqBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9pkVOkV9RzGxevIeEbLi/BOkwZbC5/N3cjXDUVFAP5T7YKZH8djKhUkq2ZrlmnaIPp1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBI/f0ONuzB49M08fBBhvwDG0ArCGr+7wEYetIiNbvA1Nxpxuq
	awvcV1zbbgCwibmeyrTnwBX0Z8QFJRAAaP/Ea+qjT0uBWocweOq6jeer3qGBRA==
X-Gm-Gg: ASbGncsRIYdUGzhRZOCZEF5D/nSHVSi8UXQ+FHW6kLrvAlJ9tgH1jGaLMtw5InEY9/n
	ZHdbMznJyMjYC0Hka8k63F2bzpX7iOFcosb9MeC8iI2XsDL+9Rivx2sKJVRsgvyoF50+y+1DEPK
	f8clbbIitSpqwWvqp6OULcokmEa2FaEYQXDiIhbvzVKyrRuKQ0Dy3BH2lOAjRVn8dQJvvK+OZ3i
	B3EY8fZJlno4WQv3LNnFPxc8rDwEqmHjMMsG6SEE9cIeMhH/2+xxGeev0sEVnOdQLosZuZKt7Fb
	U+GOtmnYjpU4qt1gP1AhJnfGkCHyIBuR0DN7hK49UGyc3piS/RRndiH/zYazf5aF5ynnBioG+bG
	EMGEBc1XfbnScBTRn23GV2sWGtRYDoya2yDbwidbbcgFS63hD29QoddnbmyFBBpKSv/oKTk20p0
	YdZBbjOe9bNoIN6wJPZhd6Yj9SjT1AIvMYyf92FPdTz8GTYJt8PNnVN21fq2u9lLk=
X-Google-Smtp-Source: AGHT+IG1T5hFGFQK20iVF+n/41AgApPXvMJG9pVB6ZaEhwkkA9LIFHJGmCNeHiXZgWfaMG3PbBv8zg==
X-Received: by 2002:a05:6000:280b:b0:42b:2ac7:7934 with SMTP id ffacd0b85a97d-42b2ac786ffmr437577f8f.1.1762530514227;
        Fri, 07 Nov 2025 07:48:34 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b29e4b9bdsm1672207f8f.32.2025.11.07.07.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 07:48:33 -0800 (PST)
Message-ID: <906fba13-fc84-411c-a43f-baaa2b90ed95@gmail.com>
Date: Fri, 7 Nov 2025 15:48:30 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 0/3] replay: make atomic ref updates the default
To: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, phillip.wood@dunelm.org.uk, newren@gmail.com,
 gitster@pobox.com, ps@pks.im, karthik.188@gmail.com, code@khaugsbakk.name,
 rybak.a.v@gmail.com, jltobler@gmail.com, toon@iotcl.com,
 johncai86@gmail.com, johannes.schindelin@gmx.de
References: <20251030191931.30837-1-siddharthasthana31@gmail.com>
 <20251105191650.89975-1-siddharthasthana31@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20251105191650.89975-1-siddharthasthana31@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Siddharth

On 05/11/2025 19:15, Siddharth Asthana wrote:

>      @@ builtin/replay.c: int cmd_replay(int argc,
>        	determine_replay_mode(repo, &revs.cmdline, onto_name, &advance_name,
>        			      &onto, &update_refs);
>        
>      ++	/* Build reflog message */
>      ++	if (advance_name_opt)
>      ++		strbuf_addf(&reflog_msg, "replay --advance %s", advance_name_opt);

This appends the name of the branch being advanced, rather than what's 
being picked. As this message is written to the reflog of the branch 
that's being advanced adding the branch name to the message is kind of 
redundant but we can always change this later when we have more 
experience with "--ref-action"

>      ++	else
>      ++		strbuf_addf(&reflog_msg, "replay --onto %s",
>      ++			    oid_to_hex(&onto->object.oid));

This looks good.

Thanks for working on this, I think this is probably ready to me merged.

Phillip

