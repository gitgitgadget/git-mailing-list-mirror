Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FE73ED5A8
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776867165; cv=none; b=sjooCuJ74Jnq+9qwRiZbfYKNi4Oh1PVVOAkwJ0kXJpoxM9dTEJui8DIVDh6wiMbqgcQJfLGLkVcrRAYw65N3SzYi18CTK6BMAm4PhrNZrG0pbWwCY2ihunywtXVuykZsVf9MWMaGGeqftA9cvlEmc1bcn9cUUrWE+k0lZTZiSfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776867165; c=relaxed/simple;
	bh=JpAsnZre1um2EpXeTgrXFcAz0iM9ho++Ee2suxf7d88=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EbCOdbOHTIvce9U/2A5RgZT8p92OvXgRCG/d3MU5JC/4YY4+nuLqaggtL9dVimy6eRXQM2NBMp9H2MfvtHzmvWsLHIxdm8QG7RJLVPAyJGH2/Yl/5WjS5gFIGqNTk9XL+oHVWkPXiZukSoptDEd8Fj1Y6GcyRIXcsLN7QeYwfgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sIu9h/LF; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIu9h/LF"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d7650202fso4329761f8f.2
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 07:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776867161; x=1777471961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9hjZrGgpS1RNqroKn8/CQEk2AUtOnTfGZT5lf2op6rk=;
        b=sIu9h/LFJlgFc6Hp/FoAqj6E05pBo6+dN3LgtZuP5MJesIlGI64dCcMcz/O1BRrCRL
         QHr/80462/5KCpy9HLgzPQeWYCYIxZAYanyMXa5kbVtkU2ysXbz52OmxP33OYaOsbCTn
         32KmND2LP3NGRUxdiWUUw4IOeRpe2XhnUcXcAGIoC8xzvvUrL1kUCO+K721dCf3rfhRD
         ll0Qk9n+BP4YZGhg1Cy3idmf9F/RAnNmteZp1FtMqXMJmTO0vAzevcTOzHxAlFdHoyg6
         0f7jL2ry9cdrK5AMAYmhu1+yToiebse/lD5zxUqHeLhrTXlOC4Uj8bYPBGyGvk4wwHTG
         8J1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776867161; x=1777471961;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hjZrGgpS1RNqroKn8/CQEk2AUtOnTfGZT5lf2op6rk=;
        b=j8e4aNr4T6j52h1BYD5BAJADMzdgowHlwzgSQFGyDP0zSoF/T+jsO69G4weQ3AFDzF
         iLKIgpCXtBYwHbSlqGWMaiO7KNwBpgBah7NVOA0HaWukRUQuyl/6R9yvqVQXeCS1z1OE
         +1T91vGZ05KLU0mHjjroUGtVUBkIm8TFMCdr1G8e4aRtaGZvV166Acw2rFgo43i8kOO9
         Dr6GcZZR29+EuK38+vd1yWFtkXhqT62wyJmLenHTnMuGXCPujBjXdCPn03rhi7Knn/xv
         XdgCxja1PWPDAOLuPUBmupXwwfbHvC0RQmbMm+XNQqWzbjtLMpQNzLTLp5DYNE7tkaDH
         imqA==
X-Forwarded-Encrypted: i=1; AFNElJ+qwDfuyqwWMjVLCsySksBKxbZc8LeX60x3U7ZRIaIGijZmc0XLkVW7PeHD7CA7sPL3+Js=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq9zRN+G9YKh3lal2n8p4WPLkCmd5E35O0/hCGd3Xxq7iqLfMb
	tYGImgP2UZ5Wj9cAiO/Z3n//YR7c4kFhg2qbeZuEYE8clG5iHW58VetbCB2d0Q==
X-Gm-Gg: AeBDietyL1eqABEg6SYQKeuOsn/kYWpaXeIEC2LRp3LIXCSr0cSGslUYZaW0EGABIpv
	y/gk4pNZWXIrmrzEDD1VkwqrL67xcJOPqd4Tapm6zBJZrht3nxS+HHHmqSRs7xiVjzMTg7yLP+K
	LzkLdntrR0x0DrzdD6A85LmPP1g1B5ncPoSLv4eL/FEaGTHogaoOUFnH6Px5A0RLcO7md3MYvXF
	3ytpUd96+n9Hr0gK0yoOluu9KPyCXyNEQUb02UUxagOI7j0QmuF29xbw8TJWkUHNQScC0HBglRi
	AnleS5b5PgJ3xowzn8hz/CQFLHUHA1ihKg8FcaymUm+guk+J3aNWDnN4gYPgky++FHscya4+BGd
	SKNIMtYfsj4n0oDyHA9wLi8akcgY1qk7lYX63nE+z8YH++tc4lcufmJff1QhLuZEDtFsardCX1a
	tFy3BYLPcTSbZsITnny70k+syxu4Foavx0tEp2gdjU1ar1ZNd4VE+T2eVmqtruA88zOoljZZnJJ
	2kXTKtTujQwmg==
X-Received: by 2002:a5d:5f93:0:b0:43d:7854:32e7 with SMTP id ffacd0b85a97d-43fe3dd3ac1mr35998737f8f.15.1776867160992;
        Wed, 22 Apr 2026 07:12:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc0d51sm45970577f8f.10.2026.04.22.07.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 07:12:40 -0700 (PDT)
Message-ID: <de2b6af2-b1ba-4262-a171-22c9cdbc7bee@gmail.com>
Date: Wed, 22 Apr 2026 15:12:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] generate-configlist: collapse depfile for older Ninja
From: Phillip Wood <phillip.wood123@gmail.com>
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
References: <20260421-toon-fix-almalinux8-v1-1-aec1d54addde@iotcl.com>
 <20260422-toon-fix-almalinux8-v2-1-45d8471ed0e9@iotcl.com>
 <0557838b-214d-4e8f-9cbd-bc342563e9ba@gmail.com>
Content-Language: en-US
In-Reply-To: <0557838b-214d-4e8f-9cbd-bc342563e9ba@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/04/2026 14:45, Phillip Wood wrote:
> 
>      sed -e "s/second/second \\\n foo/" patch1 >patchnl &&

Of course the extra backslashes would supress any special meaning of 
'\n' so that's not a good example. However the freebsd man page [1] says

    The	escape sequence	\n matches a newline character embedded	in the
    pattern space. You cannot, however, use a literal newline character
    in an address or in the substitute command.

Thanks

Phillip

[1] 
https://man.freebsd.org/cgi/man.cgi?query=sed&apropos=0&sektion=0&manpath=FreeBSD+16.0-CURRENT&format=html

> 
> However if I add "cat patchnl" it shows the subject line is
> 
>      Subject: [PATCH] second \n foo
> 
> so sed has inserted "\n" rather than a newline. Indeed looking at the 
> commit message for that test it is testing a fix that c escapes are 
> printed verbatim introduced by 4b7cc26a74 (git-am: use printf instead of 
> echo on user-supplied strings, 2007-05-25).
> 
> I've not tested it but I think
> 
>      sed 's/ $/\
> /'
> 
> will insert a newline. Alternatively we could do
> 
>      printf '%s' "$QUOTED_OUTPUT: "
>      printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
>               "$SOURCE_DIR"/Documentation/config/*.adoc |
>          sed -e 's/[# ]/\\&/g' |
>          tr '\n' ' '
>      printf '\n'
> 
> That leaves a trailing space at the end of the line but I don't think 
> that should matter.
> 
> As I recall, the depfiles created by gcc have all the dependencies on a 
> single line so this should be widely supported and I agree with Patrick 
> that we should do this unconditionally.
> 
> Thanks
> 
> Phillip
> 
> [1] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html
> 
>>           printf '%s:\n' "$SOURCE_DIR"/Documentation/*config.adoc \
>>               "$SOURCE_DIR"/Documentation/config/*.adoc |
>>               sed -e 's/[# ]/\\&/g'
>>
>> ---
>> base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
>> change-id: 20260421-toon-fix-almalinux8-102de9138294
>>
>>
> 

