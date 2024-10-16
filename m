Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEF0206E96
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 13:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729086181; cv=none; b=m/FhEZq+jJnC+mfGT59lx3ZwYRjOyDQKNdiJ4qBWJmvRtEAJi12+cksTCP9FTZAgzM4UKCB20PmVScjFnH2aNYxgHMu7Z7bkZrpfivrMnesWVz9769aXFwh27jrOMU1oz9AZuuTY9xCB8KHJbvBZxjrUjxNSeDO5EXZ3IOHft5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729086181; c=relaxed/simple;
	bh=gt33lD9bwGVxsVBMm3qcVvVXoXRzn6Zct0+08XisQaw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=HUlbfVoE6DuQZPWxCzg5C7ht9YkkmEgHPPASUJsyCuWyVKv6W42puVLBa4k+e2BJr/FrylliUQPK2/hQTjzd/G5CDbr6oD5w83CkwnsKk6oCLUymNLtWi1G3jZLM/NGGiFpkrHzEzIm3C/GrOiJ9tTAGxxb5+Ubj2Duso88N80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cy4AsbS9; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cy4AsbS9"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4b0943c7so4416763f8f.1
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 06:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729086178; x=1729690978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qUvdhcvmFFiUE8WX+oDRiKvxTMHvOyHfRmN+bdYh3bc=;
        b=cy4AsbS92S0L7I+ChV5vn8Gnmd6Zu5vy9HqSNR8Tz/5X6NKMFYKS+cVRCAmgsLiHTk
         v91j1+aIMLc5wZzatIkKy6QTOLXoWM5MzP3hTj0odOMG7snOEhiY8N9xOv6vZCgmDWo2
         NIkl8u7qThDZdfB2IMosWH7NKcd08poHj2b8cq5hKYWrpwqLT8m9Uf4/7Jgtquh++ApN
         ULknuro7UoDopcCX8zzfEmUNZVFL12g4Ttz7ic13RQoCMK4LXpHFN29O8gHWZ2QPoz7l
         qE6oYN51BWA22iqRlIL09T1ZDZhszUapZJzjhxRVVzPoDrPw4eukvUYN+oiMOWGbJnME
         ighQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729086178; x=1729690978;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qUvdhcvmFFiUE8WX+oDRiKvxTMHvOyHfRmN+bdYh3bc=;
        b=nE6g078I/uE7Ulgl1YHlcb3oawNEiXAIAv+6UcPeWjDpbddaKPPmCUpLVjSEHkw0sW
         eLjmkS85025s0TEHud2JqrqwOIByMvtke++5AKXExOW55G+94oGWFm0jYcGMQnDoZl+W
         +X2ki6xP/Pp3hdQiO3LeJlUs/XDN971nYVwQht4yPq6wk0kq6ZZrNByxfHqtQovTJlQD
         iltiWUhYaFxaF2Be4jPRJkwOMuhZpYhednLpuL6na1UlGqS84z8xZ/rDl00AXAvaWzv3
         ot/jkDaXHvcRIy38HgpVUEkWnp8eRYXC8+b/i77gWQA8M/bjFkksNcCyn86KP3lFOPKX
         +jpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX51M5lLuroctZzbv+efgSw2tNNYo0Shabfep3FE2O0XAEcc6o6HXJdgILfloP6MBAeMzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC9cJHCS8DvMMzYpaRrMHO+0Nlv73Oh2/y3xuQKmOxVPnw7joJ
	moUz5d9AoyiH0+S0s9wGYgj3pVKrOWdPxdwk3ZvdX/56XgSG09Su/utvoA==
X-Google-Smtp-Source: AGHT+IGL8CH0Z+YHDxDK/mkZRnRIZ/zqe69CX+z1rCL7uCZ5muUxX5WmA7U/Y+aHKMOSoFnoHQFiaA==
X-Received: by 2002:adf:f986:0:b0:37d:446a:4142 with SMTP id ffacd0b85a97d-37d86c040aamr2514084f8f.32.1729086178059;
        Wed, 16 Oct 2024 06:42:58 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa87c35sm4382126f8f.36.2024.10.16.06.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 06:42:57 -0700 (PDT)
Message-ID: <932d1aab-26e8-4c27-a3dd-a7191e8e71dd@gmail.com>
Date: Wed, 16 Oct 2024 14:42:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: core.hooksPath cannot revert to the default locally
From: Phillip Wood <phillip.wood123@gmail.com>
To: Sam Newbold <sam@rwsh.org>, git@vger.kernel.org
References: <20241016022613.37813826@scaldcrow>
 <dea863c3-7b54-4f8d-b6b0-6087b4cb1abe@gmail.com>
Content-Language: en-US
In-Reply-To: <dea863c3-7b54-4f8d-b6b0-6087b4cb1abe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/10/2024 10:03, Phillip Wood wrote:
> I'm pretty sure I've used "git -c core.hookspath=/dev/null ..."

Looking at the code that will unfortunately disable all hooks including
the ones in .git/hooks. It would make sense to allow an empty
core.hooksPath mean "use .git/hooks". If you're interested in working
on this then I think doing something like

diff --git a/config.c b/config.c
index a11bb85da30..91f190a1ce1 100644
--- a/config.c
+++ b/config.c
@@ -1437,7 +1437,10 @@ static int git_default_core_config(const char *var, const char *value,
  
          if (!strcmp(var, "core.hookspath")) {
                  FREE_AND_NULL(git_hooks_path);
-                return git_config_pathname(&git_hooks_path, var, value);
+                if (value)
+                        return git_config_pathname(&git_hooks_path, var, value);
+                else
+                        return 0;
          }
  
          if (!strcmp(var, "core.bare")) {

would be a good starting point

Best Wishes

Phillip

> in the 
> past when I've wanted to temporarily disable my hooks path, I can't find 
> anything in the documentation though. If
> 
>      git config core.hookspath /dev/null
> 
> does work for you it would be really helpful to update the documentation.
> 
> Best Wishes
> 
> Phillip
> 
>> I would be happy to code a patch for this if I knew how it should be
>> configured. Obviously, no local setting for a config variable is meant
>> to inherit the global or system value. We can go all "set of the null
>> set" by making the empty string mean "revert to default". We could go
>> fancy "I know what you really mean" by interpreting ".git/hooks" (or
>> perhaps any path beginning with ".git") not literally in the case of
>> worktrees, but as relative to GIT_DIR. Or there could be another
>> setting set on a local repository to ignore global and system values of
>> core.hooksPath.
>>
>> Thank you,
>> Sam Newbold
>>
> 

