Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C942418A925
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415584; cv=none; b=IPZpb1/bjwoi2+APvpTMNE7YDOU5177Djv14nGt6VHXSfa/xA5OY3wXlkkTVZshajWmjYgaEwhNmw5S+hEDs5qeyU9TeXma/1JZ5gbak/1I/XAwmGzM6BtMyIv6iJ0sAlWSP9Z1ujZ4vVlczH/Y+PLOpCVnVg1Hsoi29FS74Ulw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415584; c=relaxed/simple;
	bh=E21abcYJ2XvbLmM1lvET+mnuQu9zYJMBKG54Pofy5ww=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Kdrk1o41B5Aclq6ne8Bxp+r43Qxfhe9bGBvIDZ93VUKsdoQo5oVOv0qkLZJn5yPxRMWk1p7HH50Ro7mwclSet93Onw21XOMIZWPMDEJCSuimUs74tB+kaogiJALOu2GKYrID4VBllwd/VgYUJeEkOfp7+uXjcVMt9rO+kMi/5i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amKltBAT; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amKltBAT"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-424f2b73629so8721085e9.2
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 08:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719415577; x=1720020377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=byPw6U97rJ6CpMi7qZ5O/EqevYl8dRywLlkyhnxadgU=;
        b=amKltBAT9VhOQZV30Xwj/TsabezYGORIE3/O6Vp4N5f1r5yfQ+JQMtqvAoSbrRP4aR
         BPbwbBZusG4ZHaZqLz9Fq7itbNw6tz8Qn/b4712yXaomf5ldhKww3FVziDi9Y0KWH+xw
         +zQTWmEfXhh6z9pDtVOpGCJPGO2607x97BQ7W5SNmNhN2X47I56mHF87WTIJJmTIOvav
         yaqUeZr4S2lV4aUcyx923F2LS86Ig1ck2d79T4yhugf8KTrRT8pCjwV/KllsbZ/DN0hv
         jg0EtmcxC/aKvo4JdywYceaTxxj8k7Hkl8DbxQZ9CXh3JpZajkhG5bkUt+T7B+GOdf3w
         hCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719415577; x=1720020377;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=byPw6U97rJ6CpMi7qZ5O/EqevYl8dRywLlkyhnxadgU=;
        b=uoMMNNwoZS/SFeSa+AQ26bQ3FLxgd7S+91fr2ZilFCC2w2tpb1yDbqM9hbBHezaw5w
         h3oTaefHfSV18CI+rGQeSGpPpF5Awn/YLRY6h9/lxOIvrf5p2B0C5FDSIJk2L6KXkHPF
         /Jhnwei8YdZZwv48PVNw6eJKayzWoLIlIhosV7LibvUxb+g5g0mCNhGwKzxHhWse+bTS
         ntaNlolh269Ov6lLPVY+tObaEiTe/Tb3zC3bVrUkUx/0kLg0hXOiBCbEUeo1LKjiFcZI
         VojuEhAfaBRWI0utV6u/rq0clCirA5KSFCxSvPVUj/1g5txasos2zkqhG53QSv9m8mdJ
         XhHA==
X-Forwarded-Encrypted: i=1; AJvYcCVilcZq3sXFSRXyFsELihoasyga5lJHCgd1uVSW/A5SqTBmkh7+QzKYrn2qj7z/+/nzEayJxLeGCQSSIdhI9MtNAp/6
X-Gm-Message-State: AOJu0YzpM7F4w0VUTWs0JmHLlOZ66mvfLGdVC8j5jJSnKYTRVTSzMgB1
	4qzRJemvPymD/BSMG6MmUYwQjQXV3ZYlQe/oAY6RCGCLdWTK5YqVrfqi6w==
X-Google-Smtp-Source: AGHT+IGaQct/Rnzn/MDo4lBbkwfQhPIsS67J1N4eKLWcPIYwcESSe5AmDpCv0WE8/MgMxSbZAdq0Qg==
X-Received: by 2002:a05:600c:ad0:b0:424:ad83:ffb3 with SMTP id 5b1f17b1804b1-424ad8401bcmr19776915e9.4.1719415576922;
        Wed, 26 Jun 2024 08:26:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f668asm16081313f8f.20.2024.06.26.08.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 08:26:16 -0700 (PDT)
Message-ID: <72e42e9f-5b85-4863-8506-c99d658d7596@gmail.com>
Date: Wed, 26 Jun 2024 16:26:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] setup: support GIT_IGNORE_INSECURE_OWNER environment
 variable
From: Phillip Wood <phillip.wood123@gmail.com>
To: Florian Schmaus <flo@geekplace.eu>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
References: <20240626123358.420292-1-flo@geekplace.eu>
 <20240626123358.420292-2-flo@geekplace.eu>
 <9e5b0cc6-e28c-4c51-ab48-663c61c00ee3@gmail.com>
Content-Language: en-US
In-Reply-To: <9e5b0cc6-e28c-4c51-ab48-663c61c00ee3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/06/2024 14:11, Phillip Wood wrote:
> Hi Florian
> 
> On 26/06/2024 13:33, Florian Schmaus wrote:
>> Sometimes more flexibility to disable/ignore the ownership check, besides
>> the safe.directory configuration option, is required.
>>
>> For example, git-daemon running as nobody user, which typically has no
>> home directory. Therefore, we can not add the path to a user-global
>> configuration and adding the path to the system-wide configuration could
>> have negative security implications.
>>
>> Therefore, make the check configurable via an environment variable.
> 
> An alternative would be to allow safe.directory to be specified on the 
> command line with "git -c safe.directory='*' daemon ..." rather than 
> adding a dedicated environment variable.

To expand an this a little - a couple of times I've wanted to checkout a 
bare repository that is owned by a different user. It is a pain to have 
to add a new config setting just for a one-off checkout. Being able to 
adjust the config on the command line would be very useful in that case.

> Or you could set $HOME to a 
> suitable directory when running "git daemon" and put the user-global 
> config file there. That directory and config file only need to be 
> readable by the user that "git daemon" is running under it can be owned 
> by root or whoever else you want.

The advantage of this approach is that there are no changes needed to 
git, instead of setting GIT_IGNORE_INSECURE_OWNER one sets HOME to point 
to a suitable config file. I found this useful when I was debugging the 
issues with git-daemon earlier[1]

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/834862fd-b579-438a-b9b3-5246bf27ce8a@gmail.com


> Best Wishes
> 
> Phillip
> 
> 
>> If the environment variable GIT_IGNORE_INSECURE_OWNER is set to true,
>> then ignore potentially insecure ownership of git-related path
>> components.
>>
>> Signed-off-by: Florian Schmaus <flo@geekplace.eu>
>> ---
>>   setup.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/setup.c b/setup.c
>> index 3afa6fb09b28..da3f504fb536 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -1278,6 +1278,14 @@ static int ensure_valid_ownership(const char 
>> *gitfile,
>>        */
>>       git_protected_config(safe_directory_cb, &data);
>> +    if (data.is_safe)
>> +        return data.is_safe;
>> +
>> +    if (git_env_bool("GIT_IGNORE_INSECURE_OWNER", 0)) {
>> +        warning("ignoring dubious ownership in repository at '%s' 
>> (GIT_IGNORE_INSECURE_OWNER set)", data.path);
>> +        return 1;
>> +    }
>> +
>>       return data.is_safe;
>>   }
> 
> 
