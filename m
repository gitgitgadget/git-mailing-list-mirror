Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A46485262
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071636; cv=none; b=sdnvybpfFgLZVPypba9MUuRRDGaHPiWw9xTIFeqGEbTsEo7bphUSUkVM0zki8puZNFyUO9ereCg5tiaMVIb+FIx/rrzCJ9zi5JxkBj0h/EMVHTYFej2c71svjWBkD9ryMLhKtwZHKSPhWvb7PyLCZAB63PtvFdWUuyHiDjy5AM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071636; c=relaxed/simple;
	bh=CU5uBwXOL7GqrQuJp9L0XrFAUUdqzDfhTcJzjUJW2MY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QBeeHquMnnLbr2o+SeZbOYHT1sGu4E3RuMYl2i2VdXfAyW52FlQJWw2VIvhs+PrkC/UH0YKIW/Ha8cOAt8QRPfv53MpTmOaGvbjpEWxf61Az05IfmSunOWysStXmC4/iICYMKwODp2bQpmzezVaJwLcxNsdWL/fT7T02OVGZyHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzukBGTw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzukBGTw"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4156201223bso12961865e9.0
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 08:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712071633; x=1712676433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ae9UsoGoE1Dd/+XlJxySa6qy7xuNMwny2BscC02aWms=;
        b=lzukBGTw8GHbDNpg4wX8mQdUuI8Y2PcDB8961HYdDyVrkPQwoDIDHS8ZH0hv2blb90
         zOmnXlA9mZfuhXKxKu/cirEcNYY/qiSEPrutmV7zzL/4MLSQyjObMbWurP6abjGohwb2
         2ynZqsUK3YFjk4TLx6BhBfyBNP9RxPdoOpXHkCBFRh3b3WAkG5h/9TECttjBZghBSwYD
         Kgp9IbO8DYdMQQh73iBOlxucYz8SPOgmG9S3pG1plKsQkNV0vcWrzvgZRFxXpgJzKD9w
         Qg6fj5xyqzP+8VbNyisGI0wvezZPWMox0yJ5/8ILQHaLbXA9Fte4WJFYvrbJD8jeRKnQ
         GfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712071633; x=1712676433;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ae9UsoGoE1Dd/+XlJxySa6qy7xuNMwny2BscC02aWms=;
        b=oGLly2VGXbdAGLFOgPkXrlG4ZE/99gfsqG+lLvediSkXAyQ4smbdwiKU5WFSy7cesq
         KJMCT4UKN+jyUnIgmX2EZbuFMEWcQnX0a1fX65X5rU/X/krE45KQPFODVavPmuQBrlsW
         FYIJ8FRi24SM2MCSBGo8op5G5AWTu887lOEgtqtIXZ2Yy390JjfsZKch4VXrG4USoZ1k
         Vn9YqzXELMQu/au13J1yAf1gIwUB1NvoTYJujq+ztnsOZSlTAzpAtCYrD8B8FtX37pxE
         sgl5yo5F5uNoXa6pQ0eN/Vs6K0a5Kdw8HZyPyggrzDXw8/etK41U7lOWR0E6lhEGmyVy
         MmgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLYEGDVE7iAAxXGrh4QtZjgSlr8HDlzt+CbW9Gcr0YCCuQvbZviWNqXOWa6l48d732UIumRJeg44OCMP5u8OcqKhsI
X-Gm-Message-State: AOJu0YxD1ai+LcKr5GBEvVSt2+SopGXbeY9wV2DDfdf1rCKLBwQvmGn7
	COpBPNZvow/VyhfNsVCmvgvLmLuOAf2l13IV4hywtpR8lPTNafjf
X-Google-Smtp-Source: AGHT+IGR+Kmps5SvUJnz99Y8to1l+4HEIx3cOtZlBArV+f13Wh06dP57aaaTyeSnYcMWgSFBjMeflQ==
X-Received: by 2002:a05:600c:4fd4:b0:415:66ac:615a with SMTP id o20-20020a05600c4fd400b0041566ac615amr4717887wmq.2.1712071633450;
        Tue, 02 Apr 2024 08:27:13 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id bk20-20020a0560001d9400b0033fc06f2d84sm14481064wrb.109.2024.04.02.08.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 08:27:13 -0700 (PDT)
Message-ID: <460e41d1-0680-4e23-93a7-5134b48eedd0@gmail.com>
Date: Tue, 2 Apr 2024 16:27:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: "git maintenance start" adds entry to the main config file, not
 to already existing maintenance section in included file
To: Jan Katins <jasc@gmx.net>, git@vger.kernel.org
References: <CAP+2wOWvb8Xy5Q_u26FhZrVHazBG0ZCoKnzR8LUKo51f-NXndA@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAP+2wOWvb8Xy5Q_u26FhZrVHazBG0ZCoKnzR8LUKo51f-NXndA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jan

Sorry for the slow response, unfortunately the main contributor to "git 
maintenance" changed jobs last year.

On 10/03/2024 13:12, Jan Katins wrote:
> Hello!
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> I've a git config (in ~/.config/git/config) which reads:
> 
> ```ini
> ...
> [include]
>      path = git_config_local_maintenance
> ....
> ```
> 
> In ~/.config/git/git_config_local_maintenance I have:
> 
> ```ini
> [maintenance]
>      repo =/User/jankatins/projects/whatever
> ```
> 
> ran `git maintenance start` in a new repo.
> 
> What did you expect to happen? (Expected behavior)
> 
> That the new repo gets appended in
> ~/.config/git/git_config_local_maintenance to the already existing
> maintenance section.
> 
> What happened instead? (Actual behavior)
> 
> An additional maintenance section was added in the main config file
> with the repo key added there.

"git maintenance start" always uses the user's global config file, "git 
maintenance register" has a "--config-file" option which would allow you 
to use a separate file which we should add to "git maintenance start". 
"git maintenance" is a bit of a special case as it must use the global 
config file so that "git maintenance run" can find the list of 
repositories no matter which directory it is started in. Having said 
that I'm not sure what guarantees the config system normally makes when 
adding a new key to a existing config section.

I can see this frustrating, I'd recommend using "git maintenance 
register --config-file" when adding new repositories - you only need to 
run "git maintenance start" once to enable maintenance, not for each new 
repository.

Best Wishes

Phillip

> What's different between what you expected and what actually happened?
> 
> The additional maintenance section in the main config file instead of
> appending the repo in the already existing section in the included
> file.
> 
> This is "undesired", as I have my main git config file in a dotfile
> manager, but don't want to have the (much more frequently changing and
> laptop specific) maintenance entries in the dotfile repo.
> 
> ```
> [System Info]
> git version: git version 2.44.0
> cpu: x86_64
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Darwin 23.4.0 Darwin Kernel Version 23.4.0: Wed Feb 21 21:44:31
> PST 2024; root:xnu-10063.101.15~2/RELEASE_X86_64 x86_64
> compiler info: clang: 15.0.0 (clang-1500.1.0.2.5)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /usr/local/bin/zsh
> ```
> 
> Kind regards
> 
> Jan
> --
> jasc@gmx.net
> 
