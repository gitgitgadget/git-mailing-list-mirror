Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE071D9A41
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 10:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578777; cv=none; b=WJLzv+ijXYn8yPKSLi4nc9L3+JWTcDtrp2FhnW9NuWBLjRerc2yhmrO1XJjqZhfCkDAS1IFN7GNS6+8EP6Y98q7vsCnCjIwCVpfZdXp7snlxSarcnNxCfgHxOOUJo4NbFBl6q7cFDSTq5ziyzMlPY9vg+oIA3C/Vna8P9GZNZLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578777; c=relaxed/simple;
	bh=HY+bkxrUKwDo38TlFWTr9MU18Ihm/t1P09nRRlErLC4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fz8CKMQlJq9DCGKog7mvGVXtU1BuzoxxNUZyJlMTvWRwtmL0MOkXJxzSEJVGn+bUHnjiXjJTLt91ihZLJa//ZAOKlrBxn2yU6kC2AFuXtrm8nn7gThlNSmhF69szyQNMNXi09EtKcAYexszx36M3Pp+mhLYiBhEdoS3ceh/EiLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0zTgMme; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0zTgMme"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4314f38d274so5398365e9.1
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 02:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731578774; x=1732183574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pTEg2kk7RVBRrVCa0VLgs7dDflVTzZzceH9CPKvwc+Q=;
        b=j0zTgMmeAehq2nYHxDZn8s0wqCrAOCmvtutirEHX90qQICCCXo4bniALbhQhf1rZaD
         eroYIWFDBevWWW4Q5m4JkxbUaaJiSJjqz8TgMX9F4RFLFE5CJD/TRkAT+ampK40A5KO8
         Vij4xwFWJa2ud9RwRqP+FzFK0kaSV5ik7rw5PmI7iCfzbVVb7Xx4wPbT/Zbd/WESq2vp
         fE9KKpOhDy8VdKb2MvZGRFacfcBXZkhxtAp9qJPqF4e8+moiMrjx07iu5WpKz+3oOZz/
         yOTIVWOnL/YP3FdUnLBNTtR27fAN4gOiUBdiIns/nnH6zvCaSxkbMPnKJ9xe1Ws6+L3w
         q60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731578774; x=1732183574;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pTEg2kk7RVBRrVCa0VLgs7dDflVTzZzceH9CPKvwc+Q=;
        b=Fw84d7x6tQQ9dHHi1xPdWz8Trss2LndqDHaCaqsJz1CW80FuWQ6l9JMjTXtYT25s6z
         I2uwWw5O55a4BBHWJYAEidBQkuEFwSY6InQFEQaIqM7EXL2qNia/CdMoF4ugCF1vbpug
         S/++wDwPS3WxgXcfriYbkNwJJhzlqebwl3DqVodRXsBCBMnyIeOLSomCbJ1yK2CpAmhr
         6E7PtuWp+Vv9UnLkdZgX8O3GQUB/ot2xcLqZ5PRPfOHLUDgd1dVR26kRhnkDX9+a1hGZ
         AQeGYpicBUVlbKDEmDTL6P4AIwg9STeAS6Xwqp1Q8n3rzVXTrP5GeuPIJMT47O9l5y1F
         FA0g==
X-Forwarded-Encrypted: i=1; AJvYcCWtDzXitlY2skD/Xtl15XZcNWW4TPOvTF7WO5UERIPoEwFtc3LgxKZZ3xT1fCRzmU5MODE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMXkshuwJWnsn7J1lFrf9ksxvflb+aHCmoTvufLSNgjbffIsPw
	p/Cz1+oBgAMpzGuXSOmlTp/ADU/trLb0Em086wg3vdn33MzfekL4
X-Google-Smtp-Source: AGHT+IEqdaKKAf/zzWWO8ei2We0Tm3EJhQ9C67kSgYeilhzzMJ1D/+wl/IZvAXZLGlPfbfuuqrvmvA==
X-Received: by 2002:a5d:648b:0:b0:381:f5c2:9045 with SMTP id ffacd0b85a97d-38218542f7amr1530790f8f.51.1731578773920;
        Thu, 14 Nov 2024 02:06:13 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6a8:b801:610:d596:f87c:e591? ([2a0a:ef40:6a8:b801:610:d596:f87c:e591])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae154cesm1021519f8f.68.2024.11.14.02.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 02:06:13 -0800 (PST)
Message-ID: <29c81cbc-3678-4b70-9e0e-c500186d159f@gmail.com>
Date: Thu, 14 Nov 2024 10:06:12 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] diff: update conflict handling for whitespace to issue
 a warning
To: Junio C Hamano <gitster@pobox.com>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.1828.git.git.1731347396097.gitgitgadget@gmail.com>
 <pull.1828.v2.git.git.1731524467045.gitgitgadget@gmail.com>
 <xmqq4j4a8srw.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq4j4a8srw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/11/2024 02:15, Junio C Hamano wrote:
> "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> [jc: As Phillip is blamed for suggesting this addition, I added him
> to the recipient of this message.]

Thanks

>> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
>>
>> Modify the conflict resolution between tab-in-indent and
>> indent-with-non-tab to issue a warning instead of terminating
>> the operation with `die()`. Update the `git diff --check` test to
>> capture and verify the warning message output.

Usman - when you're writing a commit message it is important to explain 
the reason for making the changes contained in the patch so others can 
understand why it is a good idea. In this case the idea is to avoid 
breaking "git diff" for everyone who clones a repository containing a 
.gitattributes file with bad whitespace attributes [1]. As I mentioned 
in [2] I think we only want to change the behavior when parsing 
whitespace attributes - we still want the other callers of 
parse_whitespace_rule() to die() so the user can fix their config or 
commandline. We can do that by adding a boolean parameter called 
"gentle" that determines whether we call warning() or die().

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/e4a70501-af2d-450a-a232-4c7952196a74@gmail.com
[2] 
https://lore.kernel.org/git/3c081d3c-3f6f-45ff-b254-09f1cd6b7de5@gmail.com

>> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
>> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
>> ---
> 
> If the settings requires an impossible way to use whitespaces, the
> settings is buggy, and it generally would be better to correct the
> setting before moving on.
> 
> I am curious to know in what situations this new behaviour can be
> seen as an improvement.  It may allow you to go on _without_ fixing
> such a broken setting, but how would it help the end user?  If the
> user set both of these mutually-incompatible options A and B by
> mistake, but what the user really wanted to check for was A, picking
> just one of A or B arbitrarily and disabling it would not help, and
> disabling both would not help, either.  But wouldn't the real source
> of the problem be that we are trying to demote die() to force the
> user to correct contradictiong setting into warning()?
> 
> Thanks.

