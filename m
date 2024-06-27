Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F18132492
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 09:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719481841; cv=none; b=WRqNvgLRw6/HcgWkaauyI55L6oGsLYLAr5GzVhhygWXyfirN+jv8DulNMRlhORjGdab1vz+B8kUxkEdacovLl0nAHgdcXSEpH2zad9R3z/yjsfCLDHPPv1hZ5LKZtPjAUiNOA1afY0jZrJKvHTQEVhqtT+FuKAxfRP9q2V9EcrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719481841; c=relaxed/simple;
	bh=4dbmx8X4zN9bgBgRBXBd7j8GhZ/Wfow+046mr4I8qVk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gCRwhu0XWdaGhPH+6ivu9AxTvsbtdrhqn93Kxu6n71YRYWn2YxUjOC82QQ4huAYYQdZ16ZmcAOTNI5XF9udgWhE+DQjIgMFnznwjj9bHokG2ekUbDKTt7dYe2+EDT0taTGd2pumWtBTl87psgO4FQFQf5t3zT0HODWSPDUv/7iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/7lp/rO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/7lp/rO"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-367339bd00aso828725f8f.3
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 02:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719481838; x=1720086638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vwOmP1uo3Bo47QA5K7NUDkQoxjP8zg4RwWh9s5Wa5tw=;
        b=R/7lp/rOE3fGr2WRfAhicDzMp963KDD4q5beLbRfVFrpwNfyLJZIXIqCT+eWID/lTD
         APwMXwBMiFE3JBA0Gq45Cp9Hq6KrwNa1LsgvWKmztD98ruoj/PlNTtCnB1pInrRkSVXw
         Ni64lVkhoboZDecwA7hyJCCzeqiQPqUMbXyImUHbryK0HTTitu1t8GtZ6rlLfxJ7f7oH
         rmuI+vgiTA0TBCaGEC0UTt+mPKT5TQBpx9+tQ9kDl0kkIwPMmnZGB7m2fvR9YDrj+daD
         6PUk2U4tTwTQgQclYBLldfU/EanXSt1LGVxn7qgZqIxpahGx6RjRnqJswEKth/c79vjQ
         cQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719481838; x=1720086638;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwOmP1uo3Bo47QA5K7NUDkQoxjP8zg4RwWh9s5Wa5tw=;
        b=hYn59COkZa1IRM3WrLYLmecnOzqefWpmzFqR+vJixhj3KWhnbp9DWYq6EDEo3VlUFo
         sPog+1HElsDIXX4zRBGm2P70TN6FSJ3EXPOXNToGAW3bASjCHMw4NkOBkdK8jB2TjHKu
         roXrOf2h7/IlafUJhIZllBIr/Mc7NZKW/TDsU2ofG9VFAT9FjhlYXypEJSIsiFisDXvI
         LCYRgFzAm88yc5MPBV8or9rnYBF+D4vHJ7OFDsyCEx9b6/iJ6E47rg3zftbhw8g2MgHb
         mfoMQLpef+tFFij50SanbRYhsZqscP3L26kZGsgeuY9TnBuawW3SX89rv4V8wl10S0wc
         s8BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfZa4tbypJ/39kgtuows1FoVLNpayMPhzwqm4Fo5QcJLsJbPcMmO0eByR36byIS4eg0tGTEQ4VbZLme/JamwQN2mxM
X-Gm-Message-State: AOJu0YxQCizdwCCzB57molYcfxhIvsRPGydfLXABvMVz1mQtjzrNPwyS
	EaTQNJEUyaqv6ZEZYoA7tWAyaGtU9YBiGdhtjcHqeePGm88npe+h
X-Google-Smtp-Source: AGHT+IHSBU0IhEAaWxY20QpdgDxdbKnwp5rOB0dNwBG8FOpHVuZTQigmgygvl1vtWrJg7GoK3P7Osg==
X-Received: by 2002:a5d:5384:0:b0:367:3fdd:632f with SMTP id ffacd0b85a97d-3673fdd6404mr1506639f8f.67.1719481837462;
        Thu, 27 Jun 2024 02:50:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3674357c221sm1288365f8f.24.2024.06.27.02.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 02:50:37 -0700 (PDT)
Message-ID: <5742e728-a012-4960-a32d-bf3b65c3a2e3@gmail.com>
Date: Thu, 27 Jun 2024 10:50:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] setup: support GIT_IGNORE_INSECURE_OWNER environment
 variable
To: Junio C Hamano <gitster@pobox.com>
Cc: Florian Schmaus <flo@geekplace.eu>, git@vger.kernel.org,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jeff King <peff@peff.net>
References: <20240626123358.420292-1-flo@geekplace.eu>
 <20240626123358.420292-2-flo@geekplace.eu>
 <9e5b0cc6-e28c-4c51-ab48-663c61c00ee3@gmail.com>
 <72e42e9f-5b85-4863-8506-c99d658d7596@gmail.com> <xmqqa5j71snb.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqa5j71snb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/06/2024 19:11, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> To expand an this a little - a couple of times I've wanted to checkout
>> a bare repository that is owned by a different user. It is a pain to
>> have to add a new config setting just for a one-off checkout. Being
>> able to adjust the config on the command line would be very useful in
>> that case.
> 
> True.  As long as it is deemed safe to honor the one-off "git -c
> safe.directory=..." from the command line, for the purpose of this
> "I who am running this 'git' process hereby declare that I trust
> this and that repository", I think it would be the best solution
> for the "git daemon" use case.

This actually works already, the behavior was changed in 6061601d9f 
(safe.directory: use git_protected_config(), 2022-07-14). The reason I 
thought it didn't work was that I remember it failing on Debian bullseye 
a few months ago but that used an older version of git. There is some 
more rationale for the change in 779ea9303a7 (Documentation: define 
protected configuration, 2022-07-14)

Best Wishes

Phillip

> And it is much better than adding a one-off environment variable.
> After all, if your "git daemon" user does not have a $HOME set in
> its /etc/passwd entry, you cannot set such an environment variable
> in $HOME/.profile so somewhere in your "git daemon" invocation would
> have to be tweaked to have code snippet that sets and exports it
> *anyway*.  You can tweak the "git" invocation to add the command
> line tweak "-c safe.directory=..." at the place you would have set
> and exported the variable, and using the well understood "git -c
> var=val" mechanism would be more appropriate.
> 
>>> Or you could set $HOME to a suitable directory when running "git
>> ...
>> The advantage of this approach is that there are no changes needed to
>> git, instead of setting GIT_IGNORE_INSECURE_OWNER one sets HOME to
>> point to a suitable config file. I found this useful when I was
>> debugging the issues with git-daemon earlier[1]
> 
> Yup, that sounds like a workable approach, if "git -c var=val"
> approach turns out to be inappropriate for security purposes
> for whatever reason.
> 
> Thanks.
