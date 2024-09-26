Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF92374EA
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360174; cv=none; b=JBk+AV4emKYS7s+cgIMYsXoxC5AqmACIVMBuufSVnNwU14Ps1kmtD1oRKI1SVRbgjwDp61Z4m6R99RuZivfXMdaCWvgE5KdQNSEPlz+FfnPbFjck1HmajjQGIKqgro2YBk6+M2KmW/WmJAHAryM8lTXW1tTVsDIdWd+5APcD93A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360174; c=relaxed/simple;
	bh=zQ3UEGXZXo84iklqzti33txJITaTaOmB0JD39h+QXCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMLyeENBFFIs5rzCwiA8yBRfy02ZVSk0wnvq4HUfgCjhajjPpnpC6dTUxrY8B+Otr5KwBtE85XMOoh+5yY4Okou7XWXaqlCiKwUj5wY3jcUdftjdH9dTnl4a+uwWFKG7Co92eFE7MDIovmaPqDn0hkr6lXV6wymtBGouVDHOJJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkH18WHb; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkH18WHb"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53654e2ed93so1379384e87.0
        for <git@vger.kernel.org>; Thu, 26 Sep 2024 07:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727360171; x=1727964971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aDqrT6h//DbpztpMJcVD4amnMfbje0NlEpU9Yzw6Lj8=;
        b=jkH18WHbfOgX62DgWsx7xiBptW3W8d9yVVMiudT/kMnNE1iCxDtiVPpilsYkYeEiLe
         Vhp1nzLuV8u3phZJsafs1HKAeJ3DT4erI88eSElF36xNuMveubQnR+oAwo18rbF2F/7M
         DzNHFCkrUxp0/61LyfHlofr3mGUEwe3d9LGEIwCJjahbq2aRaLY6LHE/XUztgOd+TYza
         FkrnGDwwjLRIOQL4BcQ0EQzNGZYYKkH7xyl4zXO3qfOTylwDVozOXzpmOd8FqfkOXKdT
         ORplc6GVwcnK+q8HYvPzVY9mkIp+810XVkBj7NaysrEb8M7obaNwOHisNLNcGSK62/qR
         dL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727360171; x=1727964971;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDqrT6h//DbpztpMJcVD4amnMfbje0NlEpU9Yzw6Lj8=;
        b=WDKS601hdd961sFwizcKna4i0joKQeHGYHkX0aA2hl67hef+rrZs2EBgUukl8q1kXE
         0eOuO9XWlj1QexWVnMPI6hPfFKj4I0yWlCKt9ZeuN1JB32y9if8tdEsYstMHj/G28MXw
         oP8wQgAZvQevDeqw6lChnlNdxiAyUxtaG0tNqYJ5b2RHNwPKHdU7+QHVodxYFUCHfKrm
         4i7/biBKcQ+Qb5qvlkw2c68/5lokIgL6PGsRDcq7PhoK+xt7sC+fogGH0etW9Sv0CTr/
         OuhIbyV6Wq8OfI8FG8JaT/76Fes8iGqG4k9yMV1o68SRG5r2ciqJOPEbzktgKiV0JsYJ
         M/Yg==
X-Gm-Message-State: AOJu0YzF542MYI8dYeLYRnQgMRP82syySBgl9otM/dVFyuHbiEjj6zTK
	/JNX1R+hF4xDyUtM0+xqk4vBoQyDrqWfqD4JaLPun0ZCZc0Rp0rBl1MtnQ==
X-Google-Smtp-Source: AGHT+IHw/v2+0lp4IvMDYZVrJR7wCrqJIPIKEYFJCjM+5vrer2Wq2lULXSc+B++7z/ZT0U2GKh3TOw==
X-Received: by 2002:a05:6512:3e1b:b0:536:52c4:d7d3 with SMTP id 2adb3069b0e04-5387048abcemr3509743e87.9.1727360171066;
        Thu, 26 Sep 2024 07:16:11 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2997d41sm1902166b.194.2024.09.26.07.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 07:16:10 -0700 (PDT)
Message-ID: <02d7b805-f006-43ca-906e-fe9398b8ec35@gmail.com>
Date: Thu, 26 Sep 2024 15:16:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] BreakingChanges: early adopter option
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
 Jonathan Nieder <jrnieder@gmail.com>, Emily Shaffer <nasamuffin@google.com>
References: <xmqq7cb77810.fsf@gitster.g> <xmqqploydn7j.fsf@gitster.g>
 <xmqqtte77f0n.fsf@gitster.g> <ZvVMNMiyjd4xfHzY@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <ZvVMNMiyjd4xfHzY@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/09/2024 12:57, Patrick Steinhardt wrote:
> On Sun, Sep 22, 2024 at 10:51:52AM -0700, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>> Junio C Hamano <gitster@pobox.com> writes:
>> How much more costly to do at runtime is still subject to further
>> analysis, I think.  I know that it means we need to build and
>> install the docs twice to support "git -c feature.git3=on help", for
>> example, but I am not sure what the best way to use CI would be
>> (write tests that check features with different behaviour by
>> explicitly running them with "git -c feature.git3=on"?  Run the same
>> set of tests in a separate job that has "[feature] git3" in its
>> $HOME/.gitconfig?).
> 
> One problem with runtime toggles are commands that go away entirely. We
> can of course hide them away in various different places and make it
> impossible to call them. But one of the downsides is that it is not
> "true" to the actual removal, as for example the dashed builtins may
> still exist.

We should be able to make sure those dashed builtins fail though, while 
that isn't exactly the same as the command not existing it would signal 
that the command does not work in git3.

> That makes me personally lean into the direction fo making this a build
> time knob.

That's certainly easier to implement.

> The big downside of course is that we'll have less exposure
> as almost nobody ever would build their Git in such a way.

Yes, it's hard to see many people doing that, though if we're lucky some 
companies that build their own git will test the git3 build. It's also 
hard to judge how many people would turn on the config option - if we go 
with that route we could be doing (a lot?) of extra work for not much 
benefit.

I remember the 1.0 to 2.0 transition as a user. I recall seeing advice 
massages describing the upcoming changes to "git add -u" and 
push.default before the 2.0 release. We should check if any of the 
proposed changes for 3.0 would benefit from something similar.

> But the big
> upside is that we end up executing the code exactly as it would look
> like if it were removed, so the coverage we get e.g. both from Git devs
> and from our CI would be much more telling.

Indeed

Best Wishes

Phillip

