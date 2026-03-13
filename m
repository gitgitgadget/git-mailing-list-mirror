Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BEC3148D3
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398290; cv=none; b=ehqFTLz9lv5QPVqf/4MIstZWF0UuwZljtWKlVIRc2HFTyyxder1m8O4m2DMqKqeSApKhRbFcR44Qoy1aNdqgpWkJuXBF2IqXVY5OKw9XpT0tvo41Sp6Rf+z8mQcRufaPSJBlg8Bhu4wqN/N7mJa0QzQ05jBKOBQGoXgKV+7XUnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398290; c=relaxed/simple;
	bh=bYLexwTmT7QvRhSwWrQM4DaDgsGwnDUzjck8QILY1NI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YfEygg3DRe/cHfW2lAMozXP3nPM/8/m81KomGjwgncvCR+bNWYjJUIByayz376225GF72MjI/DpSTtixu7By4cYhNNu5eXm53919GSfEYCyGHWUXCQVZh6LmVcs5xc9Bzm3pVxXS+cF8ddfnqA8X0UyS8rkwgJy0Ou6xepxxAUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFFYLzDW; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFFYLzDW"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439c56e822eso2124026f8f.2
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 03:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773398287; x=1774003087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iC4SXOQ87Zjr1r2gCs8RDDh4ghDWWlzUOSvA18SgWc8=;
        b=ZFFYLzDWSfFU3ngCdM8gxYDrTGLAiUMQ+Fu8zefN6IGgZAwdsPYU8YNJHmGo6Rah9v
         ps1Pul8YBBxdXkyWEOi2uK/U3XDZAZxMgVbNNTDvSqR9bLfM34t7ax4/d3TlcJsTDEtf
         ujb1/i1eMnrQ1cl8H4dgr7KBf5r0dPRz4eCGmQdW808m/Oj0XhgdleoRwoY1WjFNoGZz
         a5PTCN7RGRbzQrZkERizrKfNTjN4o/dWCVqAVbAIsj/vL2pBGIvKhjcpGnDb/y9afKSN
         kX5d6/sj2nIfOpmSZ0ISCdupBuyQIDqdg5WOQw9myOC0R61MJ0Cc6qgnxXC1xxG4RgWR
         5klA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773398287; x=1774003087;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iC4SXOQ87Zjr1r2gCs8RDDh4ghDWWlzUOSvA18SgWc8=;
        b=LZNnldHcp3iUvdVLcBTRR9iVGQ43Y+YHMKh3Yzm0OsGmvuYG0/y1M0mGF8P9J1jXp0
         DVXqJQl4RihkLZLqlPXbg8jv5qSzd2f5kvmKCtddfgrOujU0WcajpLvEgGUXizIhRQdI
         pDZkYvHWXCZ3k+o5AwUk9FgwvXrM9UN+OEkb4PCGkDtzkBh9gsp6Izbr5Teq4MrbX/Ay
         TcuGsyAtW4uXXJ3Q67LbnMWHFUDAO5CWlI9sIwCZTeLV98ZTfz1BmddUKjUxQM7vTjpf
         W1dOGsvteUVY/CZxuDKtvyXT+mX5EgmJD/9v/POu5/MpZ5IXk5vrtlPGPhzGZeNvz7F8
         /hwg==
X-Gm-Message-State: AOJu0YzUPsuWENlZKywlZAJudRYToCcgHb4vmRBjfZ2aHCLzTw2/dbCY
	8EnUS8ih/f0NTcrwi359sWdPFLiQBSuKo7nEQYd8QHXqKEQjbsac7Lb3
X-Gm-Gg: ATEYQzzKqRJ+inewhGqBcWRCiS+2czNQSk2cwm5WuMrltKCStyKT/NNRSTbQ5pMviJc
	wYADp7ALLTYzGJVxiHsgiuHEL9deFTElf6DFwBYGBAj8oRjbbM8KovGxZhG08JeRUng3S2n1z7j
	aSVVx93SH5nlhR26bQf2Dnta/jTBwYRzroSWyewztpsb9nBJnkTHhsIoyeU219FcltADFdpvcn8
	nl8EQP3IdR28AVBXOcDnkST9XTKQaiPZrBgH5ZF6uIf5idi4BHmf6Ljr1HIakJcaF9pE+BVaAr/
	Dn53fS89nwiRj3wg6mbOT7Qq7aRgWiMY3Wj9dZE012NzH1Lnn6Eyafs2eOeic3s7WhSduKSfjnj
	MLv9KYfE7vx1loLee2TqKYiljUwymrLkBkz4MC/Qs3ONt0kL8SzrsdjABhyEBAkACQZuOfv7zAb
	zv5Kg4+SRgJfwC8t9IWDEk7aZ7pIxDbNKOlPDhQaOvb4wTLwqxiNj0YuaFntd6JTUII3Yj4HQ8c
	5ub+ug9xm3rfxw9
X-Received: by 2002:a05:6000:4013:b0:439:cba7:53a1 with SMTP id ffacd0b85a97d-43a04d7b47cmr5432123f8f.11.1773398286825;
        Fri, 13 Mar 2026 03:38:06 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19b936sm19032530f8f.5.2026.03.13.03.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 03:38:06 -0700 (PDT)
Message-ID: <1759c2fe-6e7a-41b6-9869-97544870ebef@gmail.com>
Date: Fri, 13 Mar 2026 10:38:05 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 2/4] format-patch: add ability to use alt cover format
To: Junio C Hamano <gitster@pobox.com>, Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
 Bert Wesarg <bert.wesarg@googlemail.com>
References: <cover.1772839973.git.mroik@delayed.space>
 <cover.1773331753.git.mroik@delayed.space>
 <225065cc0dd54d1a592939d41783a904a98fb2ad.1773331753.git.mroik@delayed.space>
 <xmqq5x71gfci.fsf@gitster.g> <abLw6vUUh36zFK4n@exploit2>
 <xmqqjyvhez96.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqjyvhez96.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/03/2026 17:25, Junio C Hamano wrote:
> Mirko Faina <mroik@delayed.space> writes:
> 
>>> future developers to introduce something other than "shortlog", no?
>>> If the version of Git in 'next' supports "longlog" and user gives
>>
>> Not really, anyone can introduce new formats, it's just an additional if
>> statement.
>>
>>> "--cover-letter-format=longlog" to their version that does not yet
>>> support it, it would be mistaken by the version of the code here as
>>> a "log:longlog" without any placeholder that shows a fixed string
>>> "longlog" for each commit in the series?  We'd rather want such an
>>> input to cause failure, no?
>>
>> Isn't that the same for any feature that is in next but not merged in
>> master yet? I wouldn't expect subcommands of history not yet merged in
>> master to work either if I'm using a version built from master. This is
>> an issue with the user and I don't think it's grounds for any issue.
> 
> Or misspelt "chrnological".  What are we gaining by removing it,
> which would rob safe extensibility (aka "future-proofing") and typo
> detection?
> 
> It is a bad idea to drop "log:", period.

It's a pain to have to prefix the format string with "log:" when we 
don't require it anywhere else. If we want to error out on unknown fixed 
strings then we could reject format strings that do not contain a '%' 
and do not match any of the other fixed format names such as "shortlog". 
It means you cannot specify a fixed string for the format but that would 
seem to be a rather strange thing to do in the first place.

Thanks

Phillip

