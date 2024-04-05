Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D82A15FCE2
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309442; cv=none; b=Y/doSWaPTn4u42oPzPScWakFcGsod6KMnOSTK1neAnbMnDWKUzFwWxkqHOdTZEEgpsD/aPugakVKDUPUaftnz4BpnoDyFRxYAkXToSo0qi0WhAQ2X/q4Q5vfIFoxA08k0PssWQkaoW0VLTwYNbSxp/fJWBonFeQha3oD4HQmYN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309442; c=relaxed/simple;
	bh=ns2TcTy+QrFZi8+enVV4MAfA/VEVCeSe+h9jaIK7KK0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tFBhUpeA2FfnvmxT1GIb9diLc4YFioT1qAoYw/2FPAQkSWoA6JUg6JDprQf7X9B5YE8gdxs/wjHF/YiwwVR6NPnM9VeR0wX49z5+ECql5HtUeGQk5P1OS/0VSOB5jd29aBOcXwOCeNNq8EUrRUs0Kvy3qduuZxqzGTzFY01ZGpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yj5+bL0H; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj5+bL0H"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d476d7972aso25282211fa.1
        for <git@vger.kernel.org>; Fri, 05 Apr 2024 02:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712309439; x=1712914239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VxvNjH98chKcrjmBQu7kEWYzo0Co8YO7oXvyZ2jQZ4M=;
        b=Yj5+bL0Hbhqmna9aMzp2hKlg2gtU0ww7nte0lnryVHm847NNLDHoyyGyZJvsWVuWpr
         6lCEbK32TrsgGxHVKWaSqaRjsS/UIkVeh2aC0QTsV9QA9RycKjAuIYMFVXYz/pDGM/+4
         k9oeAM26y8qp+AmkD3rkPLvI7ybEcHqHoaQeZPH/6UTPDpsqFHDMM+VXy7JEutiZRJ9u
         8Ev6GwZ0DLzMRezs0GhQ6aFic3Eb1YeLmsnaRx/dCENBkggHBLqqD24wRjLydmVmw4HL
         ahfF59/VCth+1JaFluggWxdf8WVWPO+wJRJ0AowKySrcHT9+ZnBWrAYoyWn1taGeo8Fa
         ZbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712309439; x=1712914239;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VxvNjH98chKcrjmBQu7kEWYzo0Co8YO7oXvyZ2jQZ4M=;
        b=e6AU0AZkc13CKlGSMYrBtpgVfn2pBqgSmouJdR6HT2plTapB2Px04yjx/hhzLMJc6m
         JLUnqygIBq7FwxWiXP6TyS4rHGtqmJ71OEu05f2leC9fQwwkAghS13bzLXDZ81EhJ5do
         mois8hkn2xTSvw6tWnDXB9+132VO2h+4u/hG055y+1e6gT7bWeNDz32HbgCgbiHN/LQp
         scntrh0b29mgyhBzu5lizIumTB1iuktbD8mZIb+OKIBpDsZ2aw+b/0n6adC7Wyp9oBoo
         a+aYhkzBTPUgpyAJFsmqBIkhEwQaZ7Gc9RvoNmoy2byjS5vZeE05Am63NmoVW1pL0f9X
         Rppg==
X-Forwarded-Encrypted: i=1; AJvYcCUI0SnYAXX+CuHhK6tUFQ2fBXzv3N0noGJX0zBbBmVdQ0/wNmKbYxq3EPpmTqAzbbA4ib0I3AZm4OdSRpvrzm4wNWPm
X-Gm-Message-State: AOJu0Yx2wovzNsE9wfykMmHh6HOGOISXQhNg4r3g5uiZxgHE1DmAd+1r
	M6tVO73urk7O1/fIUPz3iFMLV836UkVoCF3CnoyRF7ua/aAuyIng
X-Google-Smtp-Source: AGHT+IH4gB1Inrjl6ryL6p/jQ5kmOX/ho1CC+rs88tIJwbNKKSfPMOnVPGZm2Yjl5ikdA0bfcyAhvg==
X-Received: by 2002:a2e:87c6:0:b0:2d6:8ac7:455 with SMTP id v6-20020a2e87c6000000b002d68ac70455mr847852ljj.40.1712309438531;
        Fri, 05 Apr 2024 02:30:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id p40-20020a05600c1da800b004162ed1662dsm1816644wms.48.2024.04.05.02.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 02:30:38 -0700 (PDT)
Message-ID: <dbb4615c-443f-474f-a33c-cfb4486d436b@gmail.com>
Date: Fri, 5 Apr 2024 10:30:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: improve error message when picking merge
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Stefan Haller <lists@haller-berlin.de>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1672.git.1708945087691.gitgitgadget@gmail.com>
 <57462d2e-e255-4d35-b778-176f03675df0@gmail.com>
Content-Language: en-US
In-Reply-To: <57462d2e-e255-4d35-b778-176f03675df0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

Thanks for trying this out.

On 04/04/2024 20:44, Rubén Justo wrote:
> On Mon, Feb 26, 2024 at 10:58:07AM +0000, Phillip Wood via GitGitGadget wrote:
> The change makes sense, but this is confusing to me:
> 
> With this ...
> 
> 	$ GIT_EDITOR='echo pick 17381ab62a >' ./git rebase -i HEAD
> 	error: 'pick' does not accept merge commits, please use 'merge -C'
> 	error: invalid line 1: pick 17381ab62a
> 	You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
> 	Or you can abort the rebase with 'git rebase --abort'.
> 
> ... I find these repeated messages confusing:
> 
> 	$ GIT_EDITOR=: ./git rebase --edit-todo
> 	error: 'pick' does not accept merge commits, please use 'merge -C'
> 	error: invalid line 1: pick 17381ab62a

The two lines above are printed when "rebase --edit-todo" loads the todo 
list for the user to edit. With a real editor rather than ":" we would 
then print

     hint: Waiting for your editor to close the file ...

Then hopefully the user would fix the errors. If not then when the 
editor had finished we'd print the remaining errors  as below.

> 	error: 'pick' does not accept merge commits, please use 'merge -C'
> 	error: invalid line 1: pick 17381ab62a
> 	You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
> 	Or you can abort the rebase with 'git rebase --abort'.

I think that printing the error messages when the todo list is parsed 
before it is given to the user to edit is helpful as it reminds the user 
what the problem is. Your test looks confusing because it doesn't really 
simulate the user editing the todo list.

Best Wishes

Phillip
