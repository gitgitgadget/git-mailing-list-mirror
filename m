Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C3B32D445
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273296; cv=none; b=r3gS6QRmMyikpD1hiN/bUHeQ4fHP+IaCOnO7Kt6dQEd5DifclKatLBqyB8e3gajI9sZigsu1zR2wx0ckO5DJykhFnli+qKJFSBXuNNw/DPNIs4EldTXzmQBsaIsHo+/bsZAbWS9l9oWcPE878RqTvmmw2c6fIhqefo+0cZVOda8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273296; c=relaxed/simple;
	bh=G3Egk2nvqe/w4oCVPAnAyoBAVxbnoqT1xDqLTaUTCJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2CQmtISXL+cR+Pkup5J6dEbRmLzl2cA/+QEhm8M535ulw5Wz658OSrE2lwRKMHR96rWV2OPwhjy2/C7DyDdDjffoSbWDjH2SUtSQCxETO+cX21TQqN2Gfas8C/kXjcCHKuD2vtCTkv65r3Wz3OYmmrnBDnYggthpD2CRekN9qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXTR/8T9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXTR/8T9"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47755de027eso6521465e9.0
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 08:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762273293; x=1762878093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0p293wzZXCG5khdKNLkrWMsuAx7EHiAmn89lKMt0mkI=;
        b=jXTR/8T98xC4UovUr4k/4b2YeNwZl3a8nzJliIE2uhmVxDfiZlwbPzUCzuNlwORhut
         77S6Wji31823AeZeL/IB3ltzNvVj+mK7JQPMc3hJNBci1FCqi1BpNMSwHFKV65lypBJ2
         WgL2Nze4K85UYcbaf4DU6eKapVSzyi/5Rl6uyR4hmbq3Zi0QXNsAwWl8iYc9dgb4WUgV
         HsdNUe0PTp/O2SThk8lKHA3aqizDJWwgwAXbSV78ew/o0dKN19Q9nV4Px3yOrq3R4kQ0
         YBSRIp+CROgOdOa4s4EqMejfX6GP8hTqhIhIbM1qgRC5TYSHZZ4CPfFUUkbjx4HxkAB6
         vJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762273293; x=1762878093;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0p293wzZXCG5khdKNLkrWMsuAx7EHiAmn89lKMt0mkI=;
        b=EIXayKUzO2SmzYWTCTV2Y1phxm8g3G1X81ch72GoPr6Cpy3NCAZQQHA9H8X9H1uV4+
         J0PCOquwTdAJc0a2pq0PxpAlYjRy/08IOZYlN7lv+/T7ZXWzHK5O6PoyBOaZCOWEBl4h
         6OnWGkYOg4SufnwD67ykcSoHWHXJOjg9c0U11uBmSeKl/NkQgv2zm3j8OLXE/2GIZrVV
         0DwiUv3BPpnpvCMsZgj3znsdCff/ELkspbsdoIC4XJUQeKUYiBM0sz4ocAptwHO9LXGv
         muLbbjgPOv0IiNfQHZnItn2pqsuSpBqTPC5yLpl2PQ98QppxcTS74FfEuFRJ3ENLFaol
         88Zg==
X-Gm-Message-State: AOJu0Yw0yMxXpCYVhkjJ/3BwoR5E3dNhBHV0DSFn62JZZ3lnoHs5UGHs
	ohXA5KHV3UjB3MNofMnABQcaOCwVIjhzCmRVBIPgQhE/K5lCxKZOnIfR
X-Gm-Gg: ASbGncvTlezRJNaHjDVoWA3ufSTg9ia/E79Uyt+0WGwXB6IVUlGlz0wGaH2cb5bo5uV
	w09j4+At5U7zrISB/uT+YMml1Lyq7hllJOIBxzwQE3MJHDx6XVdWPVPVBJOUGtvEIZ5l7eorV79
	XUvrdu1gSaJ7/Gkww7ufa/1+z1uQzlK/6gt1/pZMqQDe8s//oE7/Eu3I67iXQXoiOloUwvk2OMm
	Ouk98sFm596agcKdib812EpG+oSYqLqpYydU/kgR3OrxX3E0+xlcmcDOo8DYQxhDS+6PZbJG4sj
	48gOS61O1IXt/jSCwHfwUv/jNLCxdswNbe9gvmOma0qI7gYPwv3yXewogfVot5KU6Aopdg3jBaA
	KorZP8Wnb3vcusn5eStWhKfos7IPmTELeWvwtMPYpf26U7M1WBk7dMTQRXK9QCvYrbIpjFRqLnN
	UNC2bcxAF0kspJ0IJioVy7vaba+oOWZvnI/rCQNHAnlG2auHIxv/+x
X-Google-Smtp-Source: AGHT+IH6BrHdC95N3kkOhXsk9DucEAHf1fHU5A6Unc0vDoI4EI+me1UoPTF6q+VemoMyMaGBQiTpSg==
X-Received: by 2002:a05:600c:3b03:b0:477:54cd:2030 with SMTP id 5b1f17b1804b1-47754cd21d3mr33433095e9.21.1762273292935;
        Tue, 04 Nov 2025 08:21:32 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c2ff790sm225154925e9.7.2025.11.04.08.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 08:21:32 -0800 (PST)
Message-ID: <962654fc-02ea-47a9-a2ae-913101281240@gmail.com>
Date: Tue, 4 Nov 2025 16:21:31 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/5] parseopt: use boolean type for a simple flag
To: Junio C Hamano <gitster@pobox.com>,
 "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
References: <cover.1762100242.git.ben.knoble+github@gmail.com>
 <10d531daf2c90d1bb53c07f1d72b087ebc1dd9c8.1762100242.git.ben.knoble+github@gmail.com>
 <xmqq5xbrwv4t.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq5xbrwv4t.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/11/2025 05:19, Junio C Hamano wrote:
> "D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
> 
>>   		is_optional = skip_prefix(value, ":(optional)", &value);
>>   		if (!value)
>> -			is_optional = 0;
>> +			is_optional = false;
> 
> Whether it is spelled 0 or false, I do not think this makes any
> sense.  skip_prefix() either touches &value to point at the
> substring in value that comes after ":(optional)", or it does not
> touch it at all, so there is no way value can be NULL here (and we
> know value is not NULL before we call skip_prefix()).
> 
> Shouldn't you be removing the entire "if value is NULL, it is not
> optional" thing instead?  That is exactly what Phillip pointed out
> in his review.

Looking at this again I wonder if the intention was to error out if 
there wasn't a filename after the ":(optional)" prefix which I think 
would be a reasonable thing to do but that's not what this code actually 
does.

Thanks

Phillip

