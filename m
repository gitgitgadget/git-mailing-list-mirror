Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3EE18C34B
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719427130; cv=none; b=Y4OIsqwV8EoBUX9HRvhKb8EICTee/VRMg6P8vKyQdjicsBCxLCQqFIITZdktYUkqF8SNEo0DtnChflc0BDMnIB/uCUoObSZVSMDrZnRi9QbEzN69coBAUY/n9umCEyrHzu84Ki3cItRdN9hNi1mbaaOWlYWTDExzrsqWsV8bZec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719427130; c=relaxed/simple;
	bh=hPdOsnft/RStGmvfQDFwnJUzpZAPwq55Qe0nhiXupAM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CGzlfxZ3VoFT1g66zkDLlpPBYMjsU3duBbDTFyrQ7MixfrCCcAMjRpULShCyIDUcXDgnmws69cp/oiCUoZFQgToPWwqb1vXVt1iaQSAE49ezXEz1UtP4z+YOlTqm5KVYL8OppY9LmMcG8fde6pUezluQ2zyJ1iTnd0IO7/+jJVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiScjV9d; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiScjV9d"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-424adaa6ceeso8296665e9.1
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 11:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719427125; x=1720031925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e1Nn5NDXE9BONFHwhHIv5HDYsPYyCG6K38NM/rcAcRE=;
        b=PiScjV9dzRyG3o5rZTMK5TVXb+2gzrzINkGYFCVEWtbN78o6CP471gBRx3cgn2hPM7
         pSDGIwiIdwGaeUfQjQ6AZ2Q5Ln9S6aEwqc70Rp41Rcd+5TY/MioYtCSCBnYG84vyD7m4
         0GY8SC1LYmGySmmu7RXQDWnk9ue6utHrSGtQ/DjU4O8MhGRI1veq9mvrBx0lXe+PKbcB
         x8ksy2c6NH1hPHiDxp+de+UIynCpLGmSNS7MDLqknnIG3YhF27Px08bwPYLgLFI3igSc
         uNteBU1jqyQclqjCDj3bBq3y6ObXDE2YoPJzINivUnNbX5JGmiIIRjOpcFnDYPTW3nDq
         Ovkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719427125; x=1720031925;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e1Nn5NDXE9BONFHwhHIv5HDYsPYyCG6K38NM/rcAcRE=;
        b=dl/aToHDqJuQ38qGfL4RDlbNNF7CZVS9xd0bql1Pk0Dnsdx4kSYthZ+hnkTX//d/sY
         uJvUnkqodkMhMiY0Nvx1dQBVQG6LQ2kLeVkY6/yTyE1SRQTWX6h3/UfWNbiIe/+0h1Vd
         rX4+avocc/6iKmyEOyE5/ORBNh4luywRk2kdM1Lu/uy9rubD3palMSl8BatvczAN/BeH
         GQsLHI5EMXcD8aCoui+8zG+0xXffb3V/ZgfXRgDqtTCmsrN9XdQVrwFJejoSBCTmKCQ1
         u9QKsre20gYbKPnWM6pTVJ1kkzTPQcgwXNU9iwiweAQ/TtvWEtezL5Eg2VbboHWhxZTM
         rDDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfsUlEWX0YpuAGCjCT4L0C4YIGruhtZ0GjQ1O5YrdO5qmj42nH/otKxdmnjSwTlvQxdeV/u+6pZRV1tKCqHPtJQAS8
X-Gm-Message-State: AOJu0Yys0xJargUkL0BvNlMmxOUNOPKiPa7Zm8v4/J0uO7UJfdl/UozF
	hHL6puximNZf5102a+Zcc0e8y/QRtenTIdhFuHxu+KlCUDPu4nwU
X-Google-Smtp-Source: AGHT+IH7395cThyOPi7xROKOO+O4L3hjrVKiVJPbeQ0TPoiipFpI6vg8TBW8/B5Ff3UmwePHcRWKwg==
X-Received: by 2002:a05:600c:491d:b0:424:fb2f:9d4b with SMTP id 5b1f17b1804b1-424fb2f9f55mr16205635e9.21.1719427124424;
        Wed, 26 Jun 2024 11:38:44 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c838c5besm33889645e9.48.2024.06.26.11.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 11:38:44 -0700 (PDT)
Message-ID: <6094695a-6b23-412d-9b97-15a7aec6eaf8@gmail.com>
Date: Wed, 26 Jun 2024 19:38:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] setup: support GIT_IGNORE_INSECURE_OWNER environment
 variable
To: rsbecker@nexbridge.com, phillip.wood@dunelm.org.uk,
 'Florian Schmaus' <flo@geekplace.eu>, git@vger.kernel.org
Cc: 'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
 'Junio C Hamano' <gitster@pobox.com>
References: <20240626123358.420292-1-flo@geekplace.eu>
 <20240626123358.420292-2-flo@geekplace.eu>
 <9e5b0cc6-e28c-4c51-ab48-663c61c00ee3@gmail.com>
 <046501dac7dc$31d92d60$958b8820$@nexbridge.com>
Content-Language: en-US
In-Reply-To: <046501dac7dc$31d92d60$958b8820$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/06/2024 16:19, rsbecker@nexbridge.com wrote:
> On Wednesday, June 26, 2024 9:12 AM, Phillip Wood wrote:
>> On 26/06/2024 13:33, Florian Schmaus wrote:
>> An alternative would be to allow safe.directory to be specified on the command line
>> with "git -c safe.directory='*' daemon ..." rather than adding a dedicated
>> environment variable. Or you could set $HOME to a suitable directory when
>> running "git daemon" and put the user-global config file there. That directory and
>> config file only need to be readable by the user that "git daemon" is running under it
>> can be owned by root or whoever else you want.
> 
> I agree with this alternative. Our CI build environment already has so many environment variables (not just from git but all dependencies and the CI environment itself) that we are pushing the 56Kb platform limit (not kidding). Reducing dependence on environment variables is, in my opinion, a good and necessary thing.

"git -c" still ends up setting an environment variable internally to 
ensure that the config setting is passed down to any child processes. 
The advantage is that we're re-using an existing mechanism rather than 
introducing a new environment variable.

Best Wishes

Phillip

>>> If the environment variable GIT_IGNORE_INSECURE_OWNER is set to true,
>>> then ignore potentially insecure ownership of git-related path
>>> components.
>>>
>>> Signed-off-by: Florian Schmaus <flo@geekplace.eu>
>>> ---
>>>    setup.c | 8 ++++++++
>>>    1 file changed, 8 insertions(+)
>>>
>>> diff --git a/setup.c b/setup.c
>>> index 3afa6fb09b28..da3f504fb536 100644
>>> --- a/setup.c
>>> +++ b/setup.c
>>> @@ -1278,6 +1278,14 @@ static int ensure_valid_ownership(const char *gitfile,
>>>    	 */
>>>    	git_protected_config(safe_directory_cb, &data);
>>>
>>> +	if (data.is_safe)
>>> +		return data.is_safe;
>>> +
>>> +	if (git_env_bool("GIT_IGNORE_INSECURE_OWNER", 0)) {
>>> +		warning("ignoring dubious ownership in repository at '%s'
>> (GIT_IGNORE_INSECURE_OWNER set)", data.path);
>>> +		return 1;
>>> +	}
>>> +
>>>    	return data.is_safe;
>>>    }
>>>
> 
> Sincerely
> --Randall
> 
