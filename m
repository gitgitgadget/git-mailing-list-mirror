Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A565C286D66
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752053885; cv=none; b=NrMSLFyYeQ6kJYE8W4Kb5Q/yLMw3fgF2qQTb7GAgPbDvNzzCFWYoE1vJY7yx+DsC/OTgYvXXzoXxSqRVj/s1y5Ho3EXgWB4dLcc9SrUIuTVE1nX/WofcmKqYqrFgsvZQIxnQYxJ2RjOU3TUSZhE7Euibh7xyhM55mgwmusRl4Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752053885; c=relaxed/simple;
	bh=EvZBEuxFH/aKLgL4TF/Y5eqROzMjcgESCk53W9QQMRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LhSX9ZSe57hhTztoX/RrP5NPiEeVDqHwC082nfay0xDZQintFOKBtCS9CKViYLZC122qWOE999JCTvk87JhJMD6VnQcebKwt8O2qexpF8+hbcD6neNidY8OWFwhabbDOlXfTmAfmjM9L0SjHk27xYZCX5K2jZP7xnBC+ZOhVeKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThbubNL6; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThbubNL6"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a6f2c6715fso4769880f8f.1
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 02:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752053882; x=1752658682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T1cuV2fkBwMr2gF+3/wGXtc4XUWI7BnRb/KycLZHo3M=;
        b=ThbubNL6u7weu0FU9kK7+WW5RIf0Qnk1us43ey5xoK8WX79hX5m7VDbE7dcY4wQdHh
         TULst2u8UNq6nXnWa912uF27y31B8okX0Scw2vTZeCaf6P1JTvDi3T7tiOpa3Mk/q2oO
         axwzINO/XW+Rb6l+jTYYxrSFaNzZZCO6fNqVvr6O5LOkoi6UEieT2B8v1CATeohxCLTP
         DyOsw6Yi/9ixJcf1arqdyzeE5G0VVnk/B3/TJvNKNapWsVIpJ7Tso2Cw0Xv+/8waUYNh
         ITmqO/wsiVzbEHC34uf4+X5VmZWmxuN8RqiOzAEvm0HV7kPkvUsIzZ2zju5+wkdSc+cH
         7LTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752053882; x=1752658682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T1cuV2fkBwMr2gF+3/wGXtc4XUWI7BnRb/KycLZHo3M=;
        b=Bus1eISE8esXFdR7+9T753PAQ9hRtDvZOadiSWFcXSLhqPIayL7LecvgnWo4dweZAG
         tma8cV0RTpSAbJzEOzVBskyZ2y7t2F5xCcXDf5cQhcFRsnramHqNIPLJNBjS3rMsm+Qp
         dXS8dTdPbPMbD7d5zatHbip3gIuko0rktPJsnnyF2DvCj94mkjuY+h477qhR7XChKT+q
         4UfPCNF9VyaDOoE4gFeEFcLfpjxtRDzlHCabHL+cDOqyqDReK2IO0dpFs2fUvWyQ1l+H
         SxUsSvqyUcjJ57OIZL2cpFSSbZLYqfwjWhWIlWE78OmGnE7sDO8t6csKhjDhHjfMRrC+
         VqOw==
X-Gm-Message-State: AOJu0Yx5ovaLIwEqbJbmCqUecdIneUDDYaTBLkiLNQBmsdrKz8E3iRcA
	p4shtZxT/kHoGMv9s+BivysAULo/EMYNk0U95ZFgSL8bB6QoUaGSYryPzdRW1Q==
X-Gm-Gg: ASbGncvUkAwtF57FB2mlxVTRcvtXHk7jW3lENHNC6/gq9+bOHG2UhlPdrXZmYg/j5K2
	nmDDSDyeXzDf0PqY4urL5Pf9I12XqHX1pE+6wczVgte5w65SJQT2TAJ5n1MOqN+d97mJE6WrGqo
	kFnIIokEvqAkgfkvjl3o5ijhieFFH5ftVUAJ7Kr2nbCseeVq9bufCMKoZ/0PWD01GFg2R1JVrNO
	1x8RrUq+9DcLbw14MW9QGro4j/2VEIk2x3bndZjKZH9FlRX9JJVyS1JRE/pjzGizn+/VK/hTz52
	VymkPFNW0KiPW9UXWCp8IWlrmC6myNYLGPCxYSoXFpSXrrv4LKLFrWmbmlqpJEXoDTtaK9B0CAv
	Kfub+V6RzgaSvuPJbVlSkOs8H43PlJF95An7psw==
X-Google-Smtp-Source: AGHT+IE8v5+PvLw3UYMbX0LHMEyrTJL4HjmZTnqczIWBdZn/pnirwOSXWtZHfnRKYdfXftftlCxiqA==
X-Received: by 2002:a05:6000:25c2:b0:3a5:783f:528a with SMTP id ffacd0b85a97d-3b5e453ed0dmr1446194f8f.59.1752053881620;
        Wed, 09 Jul 2025 02:38:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d085asm15163479f8f.25.2025.07.09.02.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 02:38:01 -0700 (PDT)
Message-ID: <f1fad7f4-209f-47a9-8ad2-5e236c0b0006@gmail.com>
Date: Wed, 9 Jul 2025 10:38:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] breaking-changes: deprecate support for
 core.commentChar=auto
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Ayush Chandekar <ayu.chandekar@gmail.com>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, Taylor Blau
 <me@ttaylorr.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
 <xmqqy0syp30y.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqy0syp30y.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/07/2025 02:27, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> This series implements the plan to deprecate and remove support for
>> core.commentChar=auto outlined in [1]. This feature has been the
>> source of a couple of bug reports recently [2,3] and as explained in
>> the first patch the design is tricky to fix.
> 
> FWIW, this fails some tests that expect "# commented lines" by
> treating "auto" too literally.
> 
> https://github.com/git/git/actions/runs/16157263228/job/45602188411#step:10:2970

That's a semantic conflict between this series and seen - the test 
should be marked !WITH_BREAKING_CHANGES as it is testing 
core.commentChar=auto
> I wonder if our braincycles are better spent to actually perform the
> "tricky"[*] fix than deprecating the feature and then perfecting the
> deprecation process (which does not seem to be without cost either).
> 
>   - We can and should keep the "auto" magic and use '#' when it gets
>     specified, if we really wanted to do this deprecation.  I am not
>     a huge fan of it, though.
> 
>   - Or leave it as a known-broken feature in certain corner cases,
>     which may motivate some future developers to tackle these
>     "tricky" code paths.  If we were to go this route, the first step
>     would be to document what works and what does not as "known
>     limitations".  I am slightly more in favor of this than "we punt,
>     because we cannot fix it", but not by a large margin.

I've thought about fixing it but I don't see a good way for templates 
and hooks to say "lines that begin with this character are comments" - 
for a hook the choice of comment char needs to be based on the message 
so we cannot use a fixed config setting. Unless we have a way of doing 
that it is never going to work. The cherry-pick/rebase issues could be 
addressed by writing some state that is then read by "git commit" though 
goodness knows how we'd make that work with the prepare-commit-msg hook 
that wants to introduce its own comments. I don't really see the point 
of just fixing the rebase case if templates and hooks are still broken.

Now that the commentChar can be an arbitrary string rather than just a 
single byte I think is much easier for users to pick something unique 
that isn't going to be at the start of a line in their commit messages.

Best Wishes

Phillip

