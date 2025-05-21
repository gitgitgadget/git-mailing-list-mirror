Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F5A272E5E
	for <git@vger.kernel.org>; Wed, 21 May 2025 13:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747832850; cv=none; b=H7+qfOl1jxqtTeLyufEU2mJbGicOq3OtNcCSzoR5YHaxGCOZ6nlYYFi5kEGZCuglQvywqKQ7HJeB/w4eM/uTVfPJJc6oEWG3G8uCXt0gXltVU+zZNTpmtf2cXTGYVykahlj+ipFw+j1pF7QTGfz+EC+FyGtyG/9bOj7qFJ2AMf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747832850; c=relaxed/simple;
	bh=x/IkpqqqJPAH6bioSmFki4n1Q2ZDUwC3aO3pnUZQIJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AmmfFBDIRAci43IJJlEuy9Jg3lNJMxeBZn5n/Gzds7nVIJfYv3rq9oeCzCqrRV1OOQ724HlHTUVbVwj1dKavhV3q/m2w92hCTEDuPlI2dzDOdK91V/dMLtH9WzhrN6kDyeouaSoGo+6MLFe2mL/dauSIEO2Gbzc0OfJ/CXrpkZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJxjN4u8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJxjN4u8"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-441d1ed82dbso68450575e9.0
        for <git@vger.kernel.org>; Wed, 21 May 2025 06:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747832847; x=1748437647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e+sij93U/WIr7g960WCDgHO29kwTATUEkRySx3FQv8A=;
        b=BJxjN4u86B0zSEI+n3KRbd/jF1ZUOImBJtmNf02qXCC0RiiQpOhQddAigJciky8fpi
         9GBW7fI9mmYIyzELPLaLsTDIAFH0R8L/qHqOA23z2ZZ4cFOcciWPD9ZMKNDGPPEF+CRa
         AJUI3+yklRt5mFmZ62TAe5zML+g+P5f88tytcHEEQZJZhW5GHkapO/2S4IxDI1wsKGD9
         Vba+NPiH13iVUilqpqFfzRWXDGFAvXaU6t9iW7V4OjTUwgCy1CuNDVBXY9IzDdZ4TVUt
         VLU3EV2hCevHhnWIlP5bGnvX7M/wxGPWJX5bn2HQe6a1pSdxjmejMNcx1OYHrOiwvZsV
         56fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747832847; x=1748437647;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+sij93U/WIr7g960WCDgHO29kwTATUEkRySx3FQv8A=;
        b=IvE91GRNskyRX6Ix65M4hOpgamL9ZTlzgWsPrRvlTJEoymL+CUfLmP35EY8cnVun8/
         m4iKspZBCGRZT8uo9Qmnmyxkqnut+LPqCw99pE06mF9K2WHHdow6mpd+m5Q3sMLddS7j
         Weo5xjLx8GIWQau3e7CSmSjNUw3NfPtbdadmpb/gLZgu7Z1MZjStFGOovpm9gT36/M2B
         MfNII1tsq/E5ycbPbxsd+Ldrrn8qkJ9Q6ddonbT8AyKDqOAA4E44zaampAnJ34zktr1i
         s+p1LIu2VF65pb35a93etNoUD3+haTBiaPsZbttt3c/mV7+3MEHca/vM7jWgs14MgrvA
         p0KQ==
X-Gm-Message-State: AOJu0Ywf9PhgVAN2xvebSCpyZX6FN3wLadW4e52Mrf08kjQgeg7EdqPT
	6bCPbWuXGZEbKA5txoaNG4mopB0lkLYZLYF2ZTOONU8K2a5UA7PEEUhk
X-Gm-Gg: ASbGncsOLTLGZs4yFD/y5whLVdS8cfY+pWX5M0yJDl9AbjN/Pt/yLotp1ynnZez7y/2
	F6HHYbQ9oTBLQGOoClfId6oUDtmUv+EG2i8LwVeXrthXV37i8wtptdoC6ktUPIs9eVmQLdX78Mw
	wt8Hv207vCUd58ZRFLSqYm2ixHy6fBqxCEEi+trwG8PXmEjVQ2misnmNyrQjc4w5Ko/4AjKD+mK
	sDm1AR4rNPE+urbMneMhNg3H/9e251pQHG2gSk1ZzIKKOVXqUFX0HhHEW+QfeMDqf/oX4uFI9yE
	dDh/hKgQDXNh/vchEsJJWe0ZnGk5n6+ofvqKp06YarRAY9p/6ecKmdlfuINMy31XOL4hqRl29Yj
	kE4SXz9eSkES9MaGDBYy7ua1J7FQliyD7sw==
X-Google-Smtp-Source: AGHT+IHGD46pcioTWvZeFBh1QsY+ThzPzmsdfPoRVzkg/2+o0zeObtz3MoUiFEqRfcauSiMlFzFLng==
X-Received: by 2002:a05:600c:64cd:b0:43d:745a:5a50 with SMTP id 5b1f17b1804b1-442fd6313demr159586825e9.19.1747832846693;
        Wed, 21 May 2025 06:07:26 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:efb:6e00:24f3:2d85? ([2a0a:ef40:700:a501:efb:6e00:24f3:2d85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca8cfb8sm18953442f8f.85.2025.05.21.06.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 06:07:26 -0700 (PDT)
Message-ID: <01301fa6-eea7-427d-a61f-5cb8dac99afd@gmail.com>
Date: Wed, 21 May 2025 14:07:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drop git_exec_path() from non-Git commands' PATH
To: Patrick Steinhardt <ps@pks.im>,
 "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
 <20250520193506.95199-5-ben.knoble+github@gmail.com>
 <aC2OaeLYJQAOE_S1@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <aC2OaeLYJQAOE_S1@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/05/2025 09:27, Patrick Steinhardt wrote:
> On Tue, May 20, 2025 at 03:34:58PM -0400, D. Ben Knoble wrote:
>> We setup_path() with git_exec_path() unconditionally (8e3462837b (Modify
>> setup_path() to only add git_exec_path() to PATH, 2009-01-18)) when Git
>> starts; as a result, all child processes see Git's exec-path when run,
>> including editors and other programs that don't need it [1]. This can
>> cause confusion for such programs or shells, especially when they rely
>> on finding "git" in PATH to locate other nearby directories,

I'm skeptical that using the location of the git executable to find 
"git-jump" and "git-completion.zsh" is a good idea. The location of 
those (and whether they are packaged at all) is entirely at the 
discretion of whoever packages git - they are not installed by the 
Makefile and so there is no fixed relationship between their location in 
the filesystem and the git executable. For instance the example in Ben's 
blog post looks for "git-jump" at 
"$prefix/share/git-core/contrib/git-jump" but on my system it is located 
at "$prefix/share/git/contrib/git-jump"

> I agree with what Junio mentioned in a parallel thread, especially
> around Git hooks. The expectation there is that those may execute other
> Git commands, and that should typically be using the same execution
> environment as the original Git command that has been invoking the hook.
> So refining this patch so that the mechanism is opt-in probably makes
> sense.
> 
>      A slight tangent: I wonder whether it is even required nowadays to
>      adapt PATH at all anymore. As far as I understand this was a
>      requirement back when people still executed dashed binaries
>      directly. But nowadays scripts don't really do that anymore, but
>      instead use the git binary. And that one doesn't need PATH to be
>      adapted at all, as it knows to listen to GIT_EXEC_PATH and its
>      built-in path anyway.

But don't we still need to change PATH so that hooks, shell aliases, git 
rebase --exec, git bisect run, etc. still run the same git executable 
that started them? For example "/usr/bin/git -c alias.g=!git g 
--version" should report the version of /usr/bin/git, not 
~/.local/bin/git which comes first in my PATH if git doesn't change it.

Best Wishes

Phillip

