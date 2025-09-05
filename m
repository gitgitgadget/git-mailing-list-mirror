Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866EE35E4D2
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757081038; cv=none; b=S2BpY+M5g4Wo/QGvF/tpYjQIGisHS7mXD77INlrftRzEyRX7NluWepGufRYW4iyq6IHvBR8ya9gyIYBHJtLnZP2snxQw6kiDLQhzOjzGp8OrsXbEWXJjQzR1fg6azRbHPba6rdmyYQO21nbjQJHZhWhp4jZDbZmL3GSti9BhMBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757081038; c=relaxed/simple;
	bh=lvtH522kj7aNRP4tgU3/5v22kvPmamDzP7UoxfIkhZw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WqVG1g64+rX10AbXUJH3vQTrYdd1LkEJK2VL5GKisFgVSGdKtaA5K6m9VOdQX/Leb098c3z4Koc5jGMXOLKzli9Q2ER8NcBcDYUoH+K7ddgTYWZf+DX9j9Z8hhxo5sc+zxxGRfEi9OJi0b70fo612WcfAlitT9dHWON9MDzwfK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJeNzvro; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJeNzvro"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dda7d87faso4847245e9.2
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 07:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757081035; x=1757685835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ql49rTbNRXFnVtnq/A6nHnUOvdZ55mXsw02TG4OnlJY=;
        b=UJeNzvrohy2egS+k/xoJfiBq04FKU96v0xpgLJx/4dGSPJ6ZSd57kGGdoUKGNM5qjk
         J1LLh/iVsAtdYgrChi6bAHNBP7WbRS4760aoIveCUP0P13FM1n5hL9d6A2B/BgJgNS/C
         jwSSwT0+pvwVDDPRnAxBDttNIs9snJIuA26MB6HsWNtlyGdyunPWGu0iFZqLPrlpLbdE
         y24fN8xx74FM3PS7u9brKid/FiETJlv+JLvarkc6U51ZN8e/eV+vq96pAWFaYasBzNic
         4TnA/jtKFoPEGbkkNIQ0HLbER/6WmTE8Y1+TgiZn2JBhZK2vBrgzjcl0t5aKC3sha++9
         uFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757081035; x=1757685835;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ql49rTbNRXFnVtnq/A6nHnUOvdZ55mXsw02TG4OnlJY=;
        b=lxJwQSKhjG+RS4xwOQ7x1MIUivUlHL90r+xSihfkK5h9n2FLXFufSnrm4uCGiBKoEk
         5qq923us10d2GQCN4jKhR9jykYtCR8AqXioaDTcX9lnwDC4C3xzjvBWOqW397ywvStwl
         eTMeYUo/7u/hXzFgw60WZPIFv60Eqn1T3uVfa27jinx8e/elsV2nrJqAt/750A3H3FIo
         Y1TvOgspjBA4r4kNLNlUPzUmNU5m6H8AuzNRgNZYmvSU7Ylf3x4hrrgj77ddvnEjGdVq
         1M+X1DLYMDzYvgEgOomf25X9XObFsFXO0UHqPcIbKgBv0X/vfE1raGDdJcNOJfeTEXn7
         J/Gg==
X-Gm-Message-State: AOJu0YzhNLOCy9S9gNhIyNNaEcRBhk0n75Br3fZn+leAiz+b81Kk1i/e
	XOP7jVqhBVhAgOXWYPcdtnk4/AoWca//y52LCYH8nUjOH6zMnGY5lo8PiXX0OQ==
X-Gm-Gg: ASbGncsRFbng0FhIgOMV1Qh+psUuLdnRNxFZ2C0FOLYgxXyCprHammSWtrNiEYmGER9
	oyfO5ixItUBLDMz1TAaETqQd/LzYVRkybtRtBr9w3W1y20mdeebyrD34s2+y5SrC8gsMOO+6AiQ
	TeX4r90jHurmRl7ygEmvUXmkKnPz+/gJVQzf5zbeXSunTfVBF3HH7oK+1xeuPc5z6OJMF0hvqnn
	8mF/bXYdEIv3QtHpklBmbMruvPl8Ys1hve9BzsNvKTzFYMK0O/rp7mUtusNwJx9wJwQei9bSS+t
	L16hRjZcSULWIT6iTEGJmJhZMIsXp+CCKmUE+4+hWnzZZvWLvMWK60Lc8g3QawBsZFwnOuhq91U
	Io5620IcKaC3hcQpTK9nNQJx1r0azSclf5Tdmge3CBcpRLYFYqRg+QeGXwqyV7ev33JVuvbq+r7
	TM3YnjQGk1jwT04fo=
X-Google-Smtp-Source: AGHT+IFLMtETajjJUawdwkLqs0JHkvm5pCr6y3wGNTM7/vVRsZweH9iN1q2SH9qxb7EAyWqcONzMFw==
X-Received: by 2002:a05:600c:1c14:b0:45d:dc07:d8f7 with SMTP id 5b1f17b1804b1-45ddcce21f3mr1087505e9.4.1757081034602;
        Fri, 05 Sep 2025 07:03:54 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc? ([2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45c6faad9cfsm147146925e9.0.2025.09.05.07.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 07:03:54 -0700 (PDT)
Message-ID: <7a206ee3-d68b-40fd-8133-79e4c2be7174@gmail.com>
Date: Fri, 5 Sep 2025 15:03:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Git Stash Synchronization - Best Workflow?
To: Brooke Kuhlmann <brooke@alchemists.io>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, "brian m . carlson" <sandals@crustytoothpaste.net>
References: <7B1CCA36-23F1-410D-84ED-6E965989EA8B@alchemists.io>
 <5dee5f49-eeb6-49e2-8bca-6ae6a1d6be5d@gmail.com>
 <CE34C4BA-1ED4-458C-A31F-3DDB61ECCAAF@alchemists.io>
Content-Language: en-US
In-Reply-To: <CE34C4BA-1ED4-458C-A31F-3DDB61ECCAAF@alchemists.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brooke

On 01/09/2025 21:48, Brooke Kuhlmann wrote:
> Hey Phillip, thanks!
> 
> I applied what you've suggested and still was only able to make push
 > and popping my stash with `git push --force` work. Actually, `git push
 > --force-with-lease` does work but I get this error still:
> 
> To https://github.com/bkuhlmann/test
>   ! [rejected]                  refs/stashes/bkuhlmann -> refs/stashes/bkuhlmann (remote ref updated since checkout)
> error: failed to push some refs to 'https://github.com/bkuhlmann/test'
> 
> Despite that error showing up -- and the fact that I've applied your
 > changes -- the stash DOES get updated properly both locally and via
 > the remote. That didn't happen before.
That sounds like a bug if you're getting the rejected message above but 
the ref on the remote is still being updated. I'll try and take a look 
at that next week.

 > [...]> With the above enabled, my reflog ended up showing this (using my
 > "test" repository):>
> 9305680c9afb (HEAD -> main, tag: 0.0.0, origin/main, origin/HEAD) HEAD@{6 minutes ago}: reset: moving to HEAD
> 9305680c9afb (HEAD -> main, tag: 0.0.0, origin/main, origin/HEAD) HEAD@{7 minutes ago}: reset: moving to HEAD
> 9305680c9afb (HEAD -> main, tag: 0.0.0, origin/main, origin/HEAD) HEAD@{8 minutes ago}: reset: moving to HEAD
> 
> I'm only seeing "reset: moving to HEAD" in my reflog when 
 > performing the push on my stash (in case that helps).
You need to pass the name of the ref whose reflog you want to look at, 
otherwise it defaults to showing the reflog for HEAD. You should be able 
to see the reflog for you exported stashes with

     git reflog refs/stashes/$USER

and the reflog for the remote tracking ref with

     git reflog refs/remote/origin/stashes/$USER

> Yeah, having the documentation reflect this would be nice in terms of
 > informing folks that you should enable what I've shown above. Ensuring
 > any change to the stash would also update the reflog would be helpful
 > too so folks can be implicit instead of explicit.
Let's try and find why the remote update say's it rejected when it isn't 
and then we can think about the best way to document pushing and pulling 
exported stashes.

Thanks

Phillip

