Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105341E7C3A
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 20:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320264; cv=none; b=Q9XU3llEeqeNpAz7POV7ONQs7m7vMjfGS2cvHfEwzQxbpR+F5JN9eTEt0vJ4hmqJzxGXC18owCI7Oc0tsYUGx6BpKArImPrj11EEzQ9AIEs1kKW09aMahDWLkuUYWM915qf+DTJe5ZhJ16/nVabGIhGZ5RjY910KU/6bceeT2WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320264; c=relaxed/simple;
	bh=9lLd8g9GL1g8amigV63EFP146UGlZL0AHhI1Zt1c3r0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=l+Qqmax8HkxVGikAmn2sZavynLxgy/uI5OYFiWipnDCT20T+ynGcSJJavivWjh2haXl/A1UzvDd002bqhImmtmATIwadcUd9nm7gvKyVm78MXI1A/Uf5YyVWoQ2P5vBSl5OGUYVkfKFusvl8ow3MxKw+T2i4YHooOCooZjxyD1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFJhhc8U; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFJhhc8U"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d47b38336so216106f8f.3
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 13:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730320260; x=1730925060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wI3zH3VkzONrazZ5Xqggad3uTaJEo+45f2OzImfkh0s=;
        b=mFJhhc8U0lglTuLhPpQTT96/luxb0GZfx4e8XizaIHYm8cdBPdNxJ1EFJvRC4eFBO7
         USG7eeN2MxJHfokn7s4q/W5QVpcEk1t3W5pHQUW2R0jlzosnWWWbmyV8vrl+ghYzgvLd
         w4CiASi7VJrTaUULJoOiVquvvYbXtR+sNBIcAVruBKiYJB0bYUzuDabY9qRoK+KC3mPh
         PFw8vpp+Lr5ub0bVt/tmF5YpHbA4ROm5nuSsLk0LXmoFL4AABEIZ7xvnp6ou5c2S2p9S
         hdF3LKO26y1BTV9EbkzT9+mPeelHPz7aT9e4sMP4Z0ngWqC6DycU/iYln8i3fg7fnT3s
         uujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730320260; x=1730925060;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wI3zH3VkzONrazZ5Xqggad3uTaJEo+45f2OzImfkh0s=;
        b=pfEIE2thWL1zhkBC6jX5dNoCCmx0UeBIhzDnXTuFOsziPIni+iHYga0Feqj+rw4Kxd
         ivbHF8LQgyWa/KcDCEEwA8vzL8o4YCOhKPGglj5YksppL7gkj3ThnfL6rMEAuLYUMHX+
         ighCpFkY42lKvUkCVXnufEzNXBTmRXHxzuJYL63628a+GVcU231RRp8c+2EaAZ3bk8Pn
         DFtDqMihmO7B0ONoHsoW2PZEqCTehqxRD8H45l/Fi+v/Bl1dq36V8XLlHA3Ez5qGuNb1
         gr8GR/IVpGIy+ZULq5O/21pe7Y8K+nNFSzxoiBdHlpCrH5JVc0Tzlh9VwIfOtF+Fkrc7
         rT/g==
X-Forwarded-Encrypted: i=1; AJvYcCVIg01BUlMKcFWk9nGHuCOkKJ0Xb+UHqJbCakcXo0xbtT/f73FOYsiF/xXiK5Vehb+YIs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4e4kh7/AYJVlbwiLWnDaetbel6kaFha9kSUIUvB5+PuGC+mO2
	uqloUULAtYvcRUcAwHWTqnSeHCHJ7/BtrtCpvLLN30vmi+F2G8y4iEhv7w==
X-Google-Smtp-Source: AGHT+IGHTE1iU3TOjU1p+DWgrdboy4223C8fFzsvRlQr5vyPPLworQ6m4w4cVGi80WrM0knbGhFyXQ==
X-Received: by 2002:a5d:5705:0:b0:37d:2e59:68ca with SMTP id ffacd0b85a97d-380611633f3mr11722826f8f.28.1730320260180;
        Wed, 30 Oct 2024 13:31:00 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d4a46sm40730f8f.41.2024.10.30.13.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 13:30:58 -0700 (PDT)
Message-ID: <0f91514a-f1cb-40da-a398-56d0fe37600e@gmail.com>
Date: Wed, 30 Oct 2024 20:30:57 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/5] worktree: add CLI/config options for relative path
 linking
To: Caleb White <cdwhite3@pm.me>, Taylor Blau <me@ttaylorr.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
References: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me>
 <20241028-wt_relative_options-v2-1-33a5021bd7bb@pm.me>
 <0bea06b8-11d0-497f-88e1-153cb61eb06d@gmail.com>
 <D58W4HPIF8VX.2TWFTU2A2VSYY@pm.me> <ZyKUEbXedFuzY9Oz@nand.local>
 <D59F4X1I5COT.1QECM7J128ZIG@pm.me>
Content-Language: en-US
In-Reply-To: <D59F4X1I5COT.1QECM7J128ZIG@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Caleb

On 30/10/2024 20:21, Caleb White wrote:
> On Wed Oct 30, 2024 at 3:16 PM CDT, Taylor Blau wrote:
>> On Wed, Oct 30, 2024 at 05:27:33AM +0000, Caleb White wrote:
>>>>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>>>>> index dae63dedf4cac2621f51f95a39aa456b33acd894..c1130be5890c905c0b648782a834eb8dfcd79ba5 100644
>>>>> --- a/builtin/worktree.c
>>>>> +++ b/builtin/worktree.c
>>>>> @@ -134,6 +134,9 @@ static int git_worktree_config(const char *var, const char *value,
>>>>>    	if (!strcmp(var, "worktree.guessremote")) {
>>>>>    		guess_remote = git_config_bool(var, value);
>>>>>    		return 0;
>>>>> +	} else if (!strcmp(var, "worktree.userelativepaths")) {
>>>>> +		use_relative_paths = git_config_bool(var, value);
>>>>
>>>> As we're trying to remove global variables from libgit.a as part of the
>>>> libification effort I'd be much happier if "use_relative_paths" was
>>>> declared as a "static int" in this file and then passed down to the
>>>> functions that need it rather than declaring it as a global in "worktree.c".
>>>
>>> I can create a getter/setter in the worktree API to handle this, but
>>> I'd rather not pass it as an argument to every function that needs it as
>>> that would be a lot of changes. All of these functions would need their
>>> signatures updated to include the new parameter:
>>>
>>> - `add_worktree()`
>>> - `update_worktree_location()`
>>> - `repair_worktree_at_path()`
>>> - `repair_worktrees()`
>>> - `repair_worktree()`
>>> - `write_worktree_linking_files()`
>>
>> There is no reason to have a "getter" and "setter" for a extern'd
>> variable.
>>
>> I agree that it would be preferable to have use_relative_paths be a
>> static int within this compilation unit and to pass it to the above
>> functions.
> 
> If I created a getter/setter then the variable would no longer be
> extern'd.
> 
> To be clear, you're advocating that I change the function signature
> for all of the functions listed above to include the new parameter? That
> seems like a lot of parameter bloat

It's a bit of a pain to have to change the function signatures and pass 
the parameter down but it's not difficult to do.

> when I could just set the variable
> in this compilation unit and access it directly in the
> `write_worktree_linking_files()` function.

The problem with that is that the variable is still effectively global. 
The aim of the libification work is to be able to work on more than one 
repository from a single process while respecting each repository's 
config settings.

Best Wishes

Phillip

> Best,
> Caleb
> 

