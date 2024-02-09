Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90CF2E834
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488130; cv=none; b=mGPUE1JToW13pNqqRXN+gqvtmU/tHwGFp/kqWwJ3LM2dvTTgm2mq4QxxQLuqfvCVMXVyTwmJgUPpN1U2uOWzqU/c+fJQSUzxz6tpF0yklg7nvzDfkVmKOowhNdV84J1XwvYzMDpn6zvwZS6q2lTLvjBsfOoHWxRbn2fxSv8q6kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488130; c=relaxed/simple;
	bh=2rlWVegTPygmsRa13XOlOO2mZiJboGoIe7nJ3sahol4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Szot6t8RMUUJ1JrsgC+IYkfFNg3qCDM6o0MNHTa7DkcmTtJvQOitABpWz/3waC2AEnk0yEkKzxOtl3w/hXJpl6pF4DUdgpXOZx/aF8suoxRQXxrhJpPKNvvxJD9eWhW9UBsbgmGakBZRL+bbspzbw/vp6dagjtXhysl5ElsEf0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amozH+uT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amozH+uT"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40fe03cd1caso9100885e9.0
        for <git@vger.kernel.org>; Fri, 09 Feb 2024 06:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707488127; x=1708092927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n/6fX/zyLaCSQs5Uhs/sZafpa8qiVVnpOqYUztEAxZ8=;
        b=amozH+uTij3M5JhYYgkcrp6V9PcBBWtVc8D33P4q7R5isqL9ntw1fGLWfrQJx2Yyyk
         1vAzU+pn9UKjfRjb6Dd+1DIHgZazBszRRWfYNW7/g2Y8vlTgsimYgkQJvKZkictp/2+L
         goZtb4Zp6oxfYAgvCXSzR1mZvxZzbAkcWW7xUPomeyFvfQdsVad9XQ8EJ5KHAfRXMzJ2
         37ccSyufA4xJgEPGuudhS0hjbniVnppKtYbAjvJ0Y8P0rRxXbNgW37keIevfsewpk2WV
         NLYKzZNayUYc++0B5IuxjoX4xLfzcTGmIvmAaB/McJLPjJQzm2KiWdbC9pv+NfsyPjJ8
         CfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707488127; x=1708092927;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/6fX/zyLaCSQs5Uhs/sZafpa8qiVVnpOqYUztEAxZ8=;
        b=cFuyT+QNwzBr/ltV70bbKpErdBqFqnYAodwrN5WvTyQzVRmWwCOBg2Y0klGKc1HqGZ
         PjSeSKCpTpb/GrooBNegdPBzg9X14AdOtIozFsCKdKzb1IozYrBSf2uzgSN/5WYVCeQ5
         hPLCtBXESJ8a9H8G0LCoCDva8Xx3XPj219o/EFEcc+/k4/AhT2+rDSaJvW4gazGtGi+V
         9OLUonKTlHpeQt/rtuYxE1REEWpWuxDfq40Wn3EeZCq8Zc/4OL7VGtFganHbnet/diOy
         Ya2w48vZzyEtJ/mD3tkygcDiCSrCz608B3dh0SvoKUAT4L3aLg+LwfG54zM99dKZTZJM
         tdGA==
X-Gm-Message-State: AOJu0Yy76HET9CCD7bfH3F0Vw8EnxrLrWf3HDJNKl8CZOmN7j8AQVeLi
	zJ+5c3boblwVm7bLT7ezT9MK5GjSCvLh95ImDSFCTSzgVZcnFFcy
X-Google-Smtp-Source: AGHT+IFnlNMyQMPkdCHAUHuygD6mbtfNFTO+mPBYcZGzq39djTPvAQuk+L+jMk1bea3tDwDQg/Shlg==
X-Received: by 2002:a05:600c:3596:b0:410:6506:68c2 with SMTP id p22-20020a05600c359600b00410650668c2mr1146056wmq.14.1707488126863;
        Fri, 09 Feb 2024 06:15:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUImfRHa0olXnI0F59sdSv6KO1GyQ/aBJkFJcZQv21oSUx6DJ3sldf6d5o9hxfV82jLN6cGVe5eIOKKBwE3zuEhpKkAKTz8oH6eeZYKX9xdvLPcFd6rFbHXBjde+9fLP5uI8stIhcTagOuUnrmGiFCIfLWWZw==
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id m3-20020adfa3c3000000b0033b512b2031sm1914623wrb.114.2024.02.09.06.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 06:15:26 -0800 (PST)
Message-ID: <6d2e3c87-4ab8-419a-8350-b95cf03b00c7@gmail.com>
Date: Fri, 9 Feb 2024 14:15:25 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] prune: mark rebase autostash and orig-head as reachable
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1656.git.1707411636382.gitgitgadget@gmail.com>
 <xmqqmssan841.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqmssan841.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 08/02/2024 18:06, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Rebase records the oid of HEAD before rebasing and the commit created by
>> "--autostash" in files in the rebase state directory. This means that
>> the autostash commit is never reachable from any ref or reflog and when
>> rebasing a detached HEAD the original HEAD can become unreachable if the
>> user expires HEAD's the reflog while the rebase is running. Fix this by
>> reading the relevant files when marking reachable commits.
> 
> I do not like this kind of special casing in general, but because
> these are our tools' droppings, I am OK to grandfather them in, as
> long as we promise ourselves that we will not add more of these
> ad-hoc "text files" that record object names, loss of which affects
> correctness.  They should, like "git bisect", be using proper
> references to protect these objects instead, of course.

We should definitely do that for future commands

> I agree with you that we might want to add pseudorefs as a starting
> points of reachability traversal, but I suspect it would add
> unnecessary complexity we would rather not want to deal with.
> 
> For example, not GC'ing what is pointed at by lines in FETCH_HEAD is
> OK.  Excluding those objects that are only reachable from an object
> mentioned by a pseudoref, when a new "git fetch" is negotiating with
> a remote what objects need to be sent here, might be disastrous, as
> the pseudoref that said "this object is here and you can safely
> consider everything reachable from it is" will be short-lived and
> can go away anytime, and an auto-gc kicking in at a wrong time ...

I can see that including pseudorefs when "git fetch" is negotiating 
could be problematic but does it use mark_reachable_objects()? Maybe I'm 
missing something as I've only done a quick grep but it only seems to be 
called from builtin/prune.c and builtin/repack.c and prior to 4421474e06 
(Move traversal of reachable objects into a separate library., 
2007-01-06) it seems to have been a static method in builtin-prune.c

Best Wishes

Phillip

