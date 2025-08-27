Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6102701DC
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756323404; cv=none; b=OKD0M96JeiZHB/3lapk/xcUcUcl55nWoBW/aZLnjUNG3oa8uuU+F1MYZbOQbQlKJYqpjfkyQUwmhU/WvlVayIG11Orb+LHR3Ay8jZtnNto8enGq8M2SlzhHx3ok26hWt27u52az1gP5DimSvn7o1KfxrH/p/HsufR5rmgI5dKoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756323404; c=relaxed/simple;
	bh=r5mxheQ1IzHj6Z54M+0Mql+i1a5WSEEvRdhgvfuW2Ig=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=d9aWFddEGtEUh7UAwL3wZj411FoLa6eKfaselnh3/IK1oNrWr36T3FU43/1lCK8Low9MN1Wn4ouhKOjrlugLUz0IYyjPlxy2OvtEZzCDAVhwsS1jlm5KaxWiMbfLtHNq4CmYggamxiYYtTvJNM43UIBgvYejNvlSkvPZf0kc9/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBKqoNz+; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBKqoNz+"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-70dd6c93071so2579106d6.3
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 12:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756323402; x=1756928202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zIYi6NCBHe2PU8kfl3QHCWiCETdahG2ShRKF0+LEO+g=;
        b=CBKqoNz+VXbFSJrFw2RhOhhG6viDTheTW+oOUFpMaVP39MR2DJBEyluROnn7a4eE3l
         rbd2um4TO9eg6yulkoGNGRkT2q4x7aalfGogyUUaS+MJhYYYcqhmo7MojwVkOb7Bmdtq
         4E+vXBDbDwotNNCYXBARQJxkR32mezQAnHk8sfUP9RBA/1XUD4GcHs5FCjabUK0rzxcX
         YhEay0OyQWWG1E130M1tG59nbr/DmgB1BdgNW8rvm6Kk2PbnDJjdNn2ulQs24nRrIQtP
         57FkVdrDzbxqE/pzBCMqKogfnajE0LsPzAAq5CxlWEgbbylq41Ka4kaxSWBOy5qIMc9j
         Sg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756323402; x=1756928202;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zIYi6NCBHe2PU8kfl3QHCWiCETdahG2ShRKF0+LEO+g=;
        b=l+Y5X45Ri1K6vXlEX+9p0EN7mhBChrZ529b10K3/EPG0pT9CkeLLC7osyTKoebGHh3
         XTr6ZvBvaDNZNU/V0iKCwMEFeyk0cxhShb8W1WJQYww2PgiQZjP0c3atM2AoPWYdOhmm
         pN8BAU0vWn2fTvs1ihy45ZzsxkGcum/ZWJMITjTv47/dF8YVbNhqcvnjnDGtJ69ULOTw
         NrH0GaBB0+2Lx4MebZ+vXxDW89Qb6iZt+6zi0A1L0dXUo0t34I4IW3X5i00h+70EK/vs
         DSRfLcxJyaqR+ivOk1DLZ68sZRppqc4xkFhwqkzZKiCyAdRhV8OiFwapnnR7WI7jL3MR
         c+rw==
X-Forwarded-Encrypted: i=1; AJvYcCXF/7TqdewHaZPnYnRrhV9SjzokosQbb3/RG/TIwOxPgXl4sqbXSVws5D7b1TRvyt8pXWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFTOYbcKgxt2hkoXdJMiFTIq4pWHdVtZ4PGi8vWTafuH1KZAES
	XHPvqNhcZgGjeeNL1gPp3L4VU/ZxZILDvsvHHdFuwzT7dCMmrRMl9Wos
X-Gm-Gg: ASbGncuN2J+4cT+BykVYfPO7J3eFWMIS7d5OgdHFHRxi62EDM0Ymp36vEel80lHJtHW
	+lLaM0njf5ckUPwCLdAne1F6V8dZGrNYT6SB8nQrtZNaoJP408RhoJyo3tnJUTANoVirzw+Zc2n
	+H7u9fiZLWmOPdJyQ1KshG5MFOY1hliodUVmBvGLPXi3BjpGe2uwTsF4XGRe3rP4hRQELypgwN1
	OPGSyPFKZRvduYUALLZvRdU3/D43HHgTN2lQInOGgBV0vxTatXXXfFnQb+a5f+38mJCy3UIKY7z
	PMuJEN6i83qIeJPsd/rgS5wGp5aoVmx/ShGmRBdnxH2priEzn7ScLLFI6NBBYZjJp80xbSNutnt
	mAYfGxHN3Jyy8ZheG4Xt06E5yG6dBKN0J1eo=
X-Google-Smtp-Source: AGHT+IGJanNwXw0HLpUNICvMHQVPazLpXaVpBvVQBko3LuHjX47Ezt1jzwqGOUtAAqRucRzEx0aW5g==
X-Received: by 2002:a05:6214:4e04:b0:70d:ca4f:5121 with SMTP id 6a1803df08f44-70dca4f5a82mr130185006d6.25.1756323402057;
        Wed, 27 Aug 2025 12:36:42 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.70.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70dd1b3ca5asm34638146d6.60.2025.08.27.12.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 12:36:41 -0700 (PDT)
Message-ID: <5c19f2f4-1d04-424d-9720-6db4342aebdd@gmail.com>
Date: Wed, 27 Aug 2025 15:36:18 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ls-files: conditionally leave index sparse
From: Derrick Stolee <stolee@gmail.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
References: <pull.1955.git.1755274373717.gitgitgadget@gmail.com>
 <c1f2e7b1-7583-4e1e-8f20-584a7a768286@gmail.com>
Content-Language: en-US
In-Reply-To: <c1f2e7b1-7583-4e1e-8f20-584a7a768286@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/2025 12:40 PM, Derrick Stolee wrote:
> On 8/15/2025 12:12 PM, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>
> ...
>> Replace this global check to expand the index with a check inside the
>> loop for a matched sparse directory. If we see one, then expand the
>> index and continue from the current location. This is safe since the
>> previous entries in the index did not have any sparse directories and
>> thus would remain stable in this expansion.
> ...>     Here's a small sparse index performance update based on a user report.
> 
> I know this is small and somewhat niche, but it hasn't had any review
> or been picked up in What's Cooking. Could someone please take a look?

Thanks, Elijah and Junio for reviewing.

By coincidence, a user reported an issue where the sparse index was
expanded during "git mergetool" and it was due to a pathspec-focused
ls-files subcommand. So maybe it's less niche than I had thought.

Thanks,
-Stolee

