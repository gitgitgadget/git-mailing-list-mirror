Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32FC301702
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 10:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300917; cv=none; b=OTQr8wc9qwPdOEMdjs+m0ihSVUVnaQtGHcsaKFaH2LS9Myw17N0BMkLY+vgEnDoONY4+G50LaHTBi9HkVtr6FzWB+21XbmLZRaHpcIICOBMhcOK58769wTVU1WGCoCL2bB2RWYg3d18zKibzwHE/TyZAaIaKMpVKPk8rJk+T4OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300917; c=relaxed/simple;
	bh=dE08tTURDAIXNE4izrZBBNcdqPEBJVj61EnjxQpO3qs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DkaD8l7qpk10bci6ZrWQ2+DXygMvdUjLHdwA7tFsFLE28X6k+TTEzDYySRbNdM7B8g55daLnIvyITe/SZ5gC3P6GgIGCabn46aZ7Zx1q11chcRwx3vBUdNo38bVyiupH7eI3GG5Su9P50APn4XUg4D2UOD5CDrPxzhemgur9yD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRa3Lu0s; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRa3Lu0s"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa4so5490570f8f.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 02:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768300914; x=1768905714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sh8tfO2qL3TkfwTYg0zZjT/JCYR84BnLdVnefZUEeYg=;
        b=jRa3Lu0s5ahW8zx9ItFmegaFQA63CB669+UVJ+ck9L6w0nkse4OmQ5pAvVr0larE6Z
         ExFRiTDT+dHnD9yO5O+TWjf1KGcsLopUGTcwx/gYGvvICFvOlIFDkmEWBL1LIX6jhrJG
         rW4OilUB0AVrZj5W1YkvjqTg0Uu+zounbfH/Vh5cNh2wVAKH/aCw+XzXwUS//6OKUC/o
         47+eGsD5Y6tSC+JdcWdQIzsjsYWSedprtLGiYqr/DSrtToiquTqSByTSaJ6fUks/xcpe
         yhgr9STJpIzTVAyZFDSoRBDYzy1in5SrfbdssWkvE9ufTUZmnksgLcN8W34CVj3sGx1l
         izfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768300914; x=1768905714;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sh8tfO2qL3TkfwTYg0zZjT/JCYR84BnLdVnefZUEeYg=;
        b=DcXZCNTJFyw/3+bY9dXGtTMTHuNvNNZ+XYRxnRd/Qx+jPQnSi6QgT1i5jRKk7oX+zY
         g+s2tnJcRJjWTWKpvSkztiaEW0oR3OUXDYe8gfBLiABuPKWTQi70yFt2Vm0rldmyxP+U
         MJXzkdzt+AHcJMkMQ+3ItYTGjp/mPUQtZruKfgAKAVoqgaXMsNxToND1VpUyIICjA6/8
         jwiENMggGSKoNqrtoRdBgt86cZULHR0LF1slJ31Svb/GDRMwgFhJ3O8b4rUYblbRp4fN
         fi2tGQoqauW5vbowfyzTrxpG6M92CSC0DN8q8sTmO2rjfY0N3MuzEARlGfp2cKhtFpZK
         wR9w==
X-Gm-Message-State: AOJu0Yy8E7AZkKm0EXQp2NxPJNbYtkgpDS7WcpAK3JFuqHyeaCkDTMMX
	9hDIzx+ICp4mhBzBuI6T7RRvsdYFbA0k6IsMtMcey4p410K2P3Q0OmED
X-Gm-Gg: AY/fxX6VcPDErgL8aJA2R4zoeuqSRpiYb8VR1qslFAUKAXwxEtJP+jrJ0ACEHkxiQ/w
	WlES2riimnLHapftcMN+WP1T5tH/QG3GRsAjS2lYl3ofQB+KK695rRJh6Y0vhxeqbtWOH3/WgZo
	ODnwdo4Y8BWBXjhaPLyLTraKYMf3qUqKdxPx8w3hCDANzevYMY5s/1WJp6YVveSyoCQ4j0hp1Vo
	MffE7Pd4kcZcH8jR2I0CpllnnnyCVMwn/8ZWOGdltcGcsChBtw7ouFw1Ulkta0Pp58Mg19coG3F
	R0aVIFHTGtomeL/2h3RG6WBD7zWvWxkrLBX5Dv8dH7+ZjUZjUo9PHYIyaHyhKYw3tdecdRWGn8A
	ibbgDTft9mW5SR9LiAs5mKJOXA8m77e75EDuG8sX8EMmj9czqu4Aq74ztH2wnEfDi8WtNcQoIMf
	JjmcE7nmjT2GMHcLJcdTQ0hP51VUnPfzy3sB1fyioFQJDQdRTrZvDuf5CXVm0gTXoTdw==
X-Google-Smtp-Source: AGHT+IFWUenrjYr5we+R62UjmsRQM1uIVLRZXDVpSw5BN02O3YsPoB/ppiwUX9ibVqF+Rgw/EzoM4g==
X-Received: by 2002:a05:600c:34cb:b0:47a:9560:5944 with SMTP id 5b1f17b1804b1-47d8f287ae3mr139338185e9.34.1768300913968;
        Tue, 13 Jan 2026 02:41:53 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47edee4cbc2sm7196025e9.4.2026.01.13.02.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 02:41:53 -0800 (PST)
Message-ID: <d8ecb19d-8a17-4979-b663-a6d928709e4b@gmail.com>
Date: Tue, 13 Jan 2026 10:41:52 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v17 1/2] refactor format_branch_comparison in preparation
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com,
 phillip.wood@dunelm.org.uk
References: <d2ea8560-1473-43c0-96c1-e1869e22c721@gmail.com>
 <20260112194733.23192-1-haraldnordgren@gmail.com>
Content-Language: en-US
In-Reply-To: <20260112194733.23192-1-haraldnordgren@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/01/2026 19:47, Harald Nordgren wrote:
>> It is hard to discuss this without knowing what actually breaks. Are you
>> talking about the tests added in this series? If so that means we're
>> expecting a different behavior to what "git push" actually does. As Ben
>> has pointed out elsewhere in this thread, if you're pushing back to a
>> different branch on the same remote as the upstream branch you need to
>> set `push.default=current`.
> 
> Yes, it's my new tests that are breaking. Maybe it's easiest if you check
> out the `seen` branch which now has this logic, play with the code and run
> the tests to see when it breaks.
> 
> I designed the feature around 'push.default=current' which I use.
> 
> If we would design the feature around 'push.default=upstream' then what is
> the point? 🤗 Why do we need to show status for both an upstream and a push
> branch if we are already pushing to our upstream branch?

I'm not suggesting we design the feature around 'push.default=upstream', 
I'm suggesting that we design it to respect 'push.default' so it gives 
sensible output (i.e. something that resembles what "git push" would do) 
whatever the setting.

>> The benefit is that you get a sane interface rather that returning two
>> different versions of the same string in two different ways (one from
>> the function's return value and the other from a function parameter). It
>> also matches what we do for the upstream branch.
> 
> That's a good point about matching what we do for upstream branch, I'll
> take a look.

Thanks, I think that would be cleaner

>> I can't seem to see that test. If we're printing the advice once for the
>> upstream branch and once for the default push remote I think that would
>> be ok.
> 
> This test is also part of my patch 🤗

Oh, I was looking in junio's "seen" branch from the 8th and it wasn't 
there. I've updated and I can see it now. I can see tests for

  - upstream differs from the local branch, no push branch shown
  - upstream and push branches differ from the local branch
  - upstream and push branches match the local branch

I can't see a test for the local branch differing from the upstream 
branch when the push branch matches the local branch. As far as I can 
see in that case we don't show the advice when we should do (and we 
currently do show it)

> I disagree about showing the same advice twice.

I think it is less bad than not showing it when the upstream branch does 
not match the local branch.

>> But we set show_divergance_advice to false for the push branch so there
>> is no need to check the flag.
> 
> Good point! I'll update it!

That's great

Thanks

Phillip

> 
> Harald

