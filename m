Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B65846F
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098900; cv=none; b=mYMCr+rrcxpP37GJWYk8hb13Q9oECvhV9j3MZRs11xRYDbWTQxxY2WrvnwF6esdPqLkSKmCkAtVwLw0NaK5ulwmtfLqK0kzBZbTNNrJ9sO1yh4hyXX+vyoPl2gu308Q3Xu0ehuk5R89m2yKlr+lkYFzNrgrKb/nMv2oO74FgBIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098900; c=relaxed/simple;
	bh=oLPhw3EIy1WpKw/01kAChdgYXX3moRNFBMar+d1lq7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=bGEOqoO8x4A9nXKSh8iVErW0c4ilQrZhYM6rqEmjN0CoLulgzTArl4AaJE92MUvRNHq3JWxqwyT6gxTbaxYI/S9Sgp1KTfLdSGKHdqQVmbbSCL41jd2AL3OGYcHz+N1w31gbqT3Fjtz1oITxlVFAkVkH5MO5vqUTdRK6TJIXUzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTmcsaUh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTmcsaUh"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-424ad289949so4147855e9.2
        for <git@vger.kernel.org>; Thu, 04 Jul 2024 06:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720098897; x=1720703697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eoUeZ3s/mup1kK03nM2Vyf0PKGIwNq5rImHLq2Jqumk=;
        b=bTmcsaUhPE++1DFbRkNWMaZOnkZBcrSi4V+SNwYQVkM4fth56jYt94Gxp0QGazj+wC
         KMWi0ToNF7kBkY3cF0Y7iVRAWrWhUn7E8IP6m0kX4BtTpnXoon6oi/F/ccmulHgXGtlw
         Ttzvk9/tmJv2M26vgh8FnbqRzHLmygav8tfRAf8DIluYgW3X/L0UHmvYz8sv1DZQkRN9
         ZnMFo7vrcKkzklCzgXfINHcT7AKtXO3jrVusiNcEzgKqLTylIZ8jrnEJ2Qb9rHQ6B7eR
         E7V8TsCwawBPDfQnFDZG+hFOU0d/KlzzOFzipBHyq+0MfXpII0GY8AUUrGRqWSbSJf2P
         XnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720098897; x=1720703697;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eoUeZ3s/mup1kK03nM2Vyf0PKGIwNq5rImHLq2Jqumk=;
        b=X6ATW5Yq9Ww9ymr8qcl0ryvuqwxbdB2XN8+TAXI9IUsflSCLgHx9JngRtQ5CnvVOYQ
         wlB1q5V3JPSE82+2PhUfRCjj/ZSCqcoUF7OIQVhfvPCl13fCzBEfDXeTLEZEeYaz2w4a
         /zsIOT7qAT9ARowJLS/qPwSCfevtx/RwNyWDbTDOgmaWdUypUZPQteA7a2sI07zK4MWs
         kkRedSfeuqhtZBwJdd61TCoKYArjyCL4aWUWP2Q7jSU75d/ZMHeXEKUELgKIW+Yi2QsV
         pUBxtMd/eY0JThDPFsiZoLUNILvWfQ5avQsW2/OvtsMdhcPWCj30gPTidM52r0E1yREW
         /qUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2JloBFJQkKcNzoeLbUqFw3bzh6iBNGrJrGGqIe/Nk024U1c1xkMVE2XaA1Fvyr+fQUdKQkfhzfzRA3f8iHmrJHoIn
X-Gm-Message-State: AOJu0YzSMnY6Gvo0SJdqJiDG0ChZpfUn6GXcfqFnerB8u8NkbqMN8xLm
	MWUDQprVfGNGzhc2OXznKu/UNKjKRVClVbyK53fxu3eNOdV23YSO
X-Google-Smtp-Source: AGHT+IEWKGrva0AS3ZY0URhuS2L/izOWKZEWWeaTpC7keecQYl70RpSjWuELalTCqh9fB+1iwzwgkQ==
X-Received: by 2002:a05:600c:28a:b0:424:9f28:22ff with SMTP id 5b1f17b1804b1-4264a3cf814mr11136245e9.5.1720098897295;
        Thu, 04 Jul 2024 06:14:57 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d50c3sm24229585e9.2.2024.07.04.06.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 06:14:57 -0700 (PDT)
Message-ID: <ab974e62-098c-4200-bee3-7de8d9115516@gmail.com>
Date: Thu, 4 Jul 2024 14:14:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git crashes in `git commit --patch` with diff.suppressBlankEmpty
 = true
To: Ilya Tumaykin <itumaykin@gmail.com>, git@vger.kernel.org
References: <9b31e86f-c408-4625-8d13-f48a209b541b@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
In-Reply-To: <9b31e86f-c408-4625-8d13-f48a209b541b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ilya

Thanks for reporting this and for the example reproduction. The problem 
is that the code that splits hunks expects context lines to begin with ' 
'. We could fix that fairly simply but I wonder if we should change 
'diff-index' and 'diff-files' to ignore diff.suppressBlankEmpty instead. 
The plumbing diff commands already ignore most of the options that 
change diff output so I'm not quite sure why they respect this 
particular config setting. I've cc'd a few people to see what they think.

Best Wishes

Phillip

On 03/07/2024 15:41, Ilya Tumaykin wrote:
> Hello.
> 
> `git commit --patch` crashes with diff.suppressBlankEmpty option enabled 
> under certain conditions.
> 
> 
> Steps to reproduce:
> 1. Prepare .gitconfig:
> [user]
>      name = User
>      email = user@example.com
> [diff]
>      suppressBlankEmpty = true
> 
> 2. Initialize repo:
> $ mkdir git_bug && cd git_bug
> $ git init
> $ echo -e 'test\n\n test \n\ntest' > test.txt
> $ git add test.txt
> $ git commit test.txt -m 'initial'
> 
> 3. Make changes:
> $ echo -e 'test\n\n test\ntest\n \n' > test.txt
> 
> 4. Try to commit new changes
> $ git commit --patch test.txt
> 
> 5. Try to split the first hunk, press 's' in the git-commit interactive 
> interface.
> 
> 
> Actual results:
> diff --git a/test.txt b/test.txt
> index 366cd4b..611ca9d 100644
> --- a/test.txt
> +++ b/test.txt
> @@ -1,5 +1,6 @@
>   test
> 
> - test
> -
> + test
>   test
> +
> +
> (1/1) Stage this hunk [y,n,q,a,d,s,e,p,?]? s
> BUG: add-patch.c:994: unhandled diff marker: '
> '
> Aborted (core dumped)
> 
> 
> Expected results:
> git-commit splits the hunk and continues.
> 
> 
> Comment:
> If I set diff.suppressBlankEmpty = false, then I get the expected behavior.
> 
> git --version: 2.45.2
> OS: up-to-date Fedora 40
> 
