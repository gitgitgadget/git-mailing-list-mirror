Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8CB1AB536
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917728; cv=none; b=nghVAFbhtWF951XAo6NMkLmDArVBW5By3imX58cnDDjrnwy83bZP55p3SepH9IoGinBMXN2z56F7jNgd6wHwjipxOlqozg3iiQKWZo1Qr+hfRb+zewB/iEl+coe+99+WN/se4ioUY50SCmRB1oiC8KnQP+zvaAzI+4qr83xIXLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917728; c=relaxed/simple;
	bh=2JcmhUYudcLWkhAkUs9PliRcBW8XyuU0+xSl3bPMIFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AS+bRt0FfBO5492wDSKmbm+CP1buGqJXH8dVOCq22zh2H78o5uwqgnQpWcCJWKikUWF3aPTrdUBLhls0aah5qT7c/W6Dw6MXsYho6rnj8Y9WmCvxE8yNJx9azlmEPLLAQ5REop6+c10dY7KMbtTKBo+xTu+f/Vesw3JD9FZvqO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfeRkuZ5; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfeRkuZ5"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d6ff1cbe1so1032984f8f.3
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 07:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728917725; x=1729522525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AEayYZLfY1l1UgjT29gc7eAeWQ9mmyr4zcXArWofq1Q=;
        b=GfeRkuZ5HG2uzz2nDFWRFzgrAoQlLl+PsE1O3Q91utu+RCjiqRGR93oZfKzjaw1qAH
         2W2nZU2es+SFhEyCoov5SlDl56FpCSVkmK1ngoOEBBGXW+ldEbvEvBGllDoyj8CCjZNB
         eBm+GhHbflPiorqxgVFZ+T39L5rR0g2zBOHkJXYh+ZJqfyMiRRiooklkdvqA7/RVRMS2
         dzASiWLHXZHjkYNxmODAvwjO3YVSZaj0a0uehwYigugMfwNbGw0rFXZKeSZ7Z9GIXROR
         xV86nevCN3jug4yRKuE48aUs0oJ2xIS5yRXZZyvHtyFoOs7H01Nx0IzFX24bWA2jUUlQ
         wCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728917725; x=1729522525;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AEayYZLfY1l1UgjT29gc7eAeWQ9mmyr4zcXArWofq1Q=;
        b=rVyqi6HUfOkxQGjzXCz9WMzXvvF7oZyO/XTI5HgQg6ZDZhkrMzwVx19LqE7YPFKOnW
         2tZfRuS9uxCM8i0uCpbKKMCUiG2YTM3lbCLxp+12iZ2SsVsRmkZT4X9oZe66/tzeBe2A
         4O8IjFXn303ooUnC0IRBMWg4aWNNW+4KfGC0+LA+hL0p/Scyt7ICvdqEAF8SrVQTqPxE
         QzuMt/mFd2MJ61Ko+nrrdbfV60xZ7jLjtWabD3XmmiJVrlmkowdfjKxTwgXF+hEpIk+Y
         dxkkK1obnQtvPRFVqWLSxz1PdHYcO60FFZn2bnl2A09uxo9IXP26kbIy32p+zlR7fbV4
         oXjw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ/QZSOLTWrUFkVcS2sy2Wt7bfqQ/3MdJqwnH6rh+if+pTBTVm7OfnweSjfUgVDtA0l6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGUU+6GfyFrORDpyCa8lLVDn54ON2lUwUnAjgsPzKBzHCxkVJ4
	EpnYhiewP8GI3fog0yULfLglRtou/+tK5XavbGEmZoq9908T0691PQUawg==
X-Google-Smtp-Source: AGHT+IFy9bFiNyMp9DF7sSSUHaYTvWN3p2NzEqeCxjucg/yPucYQOp9XJVXgnmxR9Eg4I/e82p+gng==
X-Received: by 2002:a05:6000:11cf:b0:37d:4e59:549a with SMTP id ffacd0b85a97d-37d551d397fmr8783166f8f.16.1728917725310;
        Mon, 14 Oct 2024 07:55:25 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a87c8sm11593147f8f.8.2024.10.14.07.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 07:55:24 -0700 (PDT)
Message-ID: <2160f8ea-5f00-49d9-8e02-d71d4d827d39@gmail.com>
Date: Mon, 14 Oct 2024 15:55:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and
 strtol_i()
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
 <CAPSxiM-V1qOB9QXUY3aDh+_nGdDHBWXJZ54U9p_XxKfHoODu7A@mail.gmail.com>
 <Zwz4B4osJnYJw6pd@pks.im> <2a937b6f-a3fb-4f2a-997b-5508f0e20e65@gmail.com>
 <Zw0kGLZ-mcYjb6Je@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <Zw0kGLZ-mcYjb6Je@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/10/2024 15:00, Patrick Steinhardt wrote:
> On Mon, Oct 14, 2024 at 02:57:13PM +0100, Phillip Wood wrote:
>> On 14/10/2024 11:53, Patrick Steinhardt wrote:
>>> On Sun, Oct 13, 2024 at 09:42:41AM +0000, Usman Akinyemi wrote:
>>>> On Sat, Oct 12, 2024 at 11:09 PM Usman Akinyemi via GitGitGadget
>>>> <gitgitgadget@gmail.com> wrote:
>>>>>
>>>>> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
>>>>>
>>>>> Replace unsafe uses of atoi() with strtoul_ui() for unsigned integers
>>>>> and strtol_i() for signed integers across multiple files. This change
>>>>> improves error handling and prevents potential integer overflow issues.
>>>>>
>>>>> The following files were updated:
>>>>> - daemon.c: Update parsing of --timeout, --init-timeout, and
>>>>>     --max-connections
>>>>> - imap-send.c: Improve parsing of UIDVALIDITY, UIDNEXT, APPENDUID, and
>>>>>     tags
>>>>> - merge-ll.c: Enhance parsing of marker size in ll_merge and
>>>>>     ll_merge_marker_size
>>>
>>> To me it's always an indicator that something should be split up across
>>> multiple commits once you have a bulleted list of changes in your commit
>>> message.
>>
>> Agreed, but I think in this case there is a common theme (converting atoi()
>> to a safer alternative) and the problem is with the commit message listing
>> which files have changed rather than unrelated code changes being grouped
>> together. This patch could be split up and if there were many more atoi()
>> conversions it would need to be split to prevent it being too long but I
>> don't think its essential to do so.
> 
> In theory I agree. In practice I think we should have better
> explanations why the respective conversions are fine and whether this is
> fixing a bug or not. And if it is fixing bugs I'd also like to see tests
> added to the tree.

I'm not sure if I would describe any of the changes as fixing bugs. The 
option and config parsing code becomes stricter so I guess you could say 
it was a bug to accept any old rubbish and treat it as zero before. The 
imap code that's changed all rejected zero anyway apart from the tag 
parsing so maybe accepting the changes to the tag parsing are fixing a bug.

> And by the time we got there it makes sense to split up commits.

Yes if we start adding tests then it is worth splitting them up, I'm not 
sure we have anyway of testing the imap changes but it would be worth 
testing the other changes though.

Phillip

> Patrick
> 

