Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC47717C8
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710346707; cv=none; b=uSm3jn5mwDh4agANEZN8t+QY6a2mRMAU0c+1/obe4gYLrzw4bU1VYIenmJXoSjxxNZs4Ytb9JyYr2TLopZJ5sp908l+FDxl/oYrs3GmhjwIdndu3oxCBLs/CzG1XKz6QG9hjNcqJq/BcksJGJwRHITz/d83ODXt5dIGwMHWkF+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710346707; c=relaxed/simple;
	bh=PF40YXaiwQwZhn5aJbhFkr823ZfK7JaaEwD7Ik1hylE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gHNLugN8g5TGIl3i9kLoW+hIjV5YA3vYwB4H4Brlf2KiZgV/UH45/n3sXRu8enhiRr5lz2sl1h5kr5MbcaxnHN4DFrXWZ2fqA9uEmqKlFXVV42JnEJnzrcip8dIb8UA6azbXtXWlve+rf+37sbjmfJSqy637EwxNyC5UJJmrQzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5Gq0YYU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5Gq0YYU"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-413eee75912so193905e9.1
        for <git@vger.kernel.org>; Wed, 13 Mar 2024 09:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710346704; x=1710951504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3BUAqH9E+gvOZTmz4YKhvkWZuQog1H6GhOGTGnAaaKI=;
        b=D5Gq0YYUdHnHlgQ3yfrnOa16SjW9ka/x38etO5xoXtPZlWsS8kOBGeYjwsH/Ke2jrg
         LBvAaq+sN59PIHffzyToVoUeAbbxYc0d6RpmhXcVGzMXFH3ucvBzeHih2msm9La3gYyS
         LJdWwkz8qsnzuh3276fwpMK2mInYdQLYS6Y6ZkrWdrTnj10NSNTOUifxmCM8B5nB4zt6
         uyu5RYZ/AQ4HbiGsCLBqhHmv9Jd4JXc4b4RvZIrT/lHh6U6/OVdgtc6wXnWccWx/UCyL
         3h2RkdTdcRagmJIjyFJLzlZRx/CJoFf3Rap/qKMDeXS11HYhJuTVD1yd1V+dt4VNDzhM
         K8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710346704; x=1710951504;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BUAqH9E+gvOZTmz4YKhvkWZuQog1H6GhOGTGnAaaKI=;
        b=cbX/IQD8rPzm3vQheUNOL7HX09bznxXfgSx8bfTugdQT2tuT3RoUINppXqbC5PU2F5
         8r3NEHWyb1GnM6yC+SpXZ/R0ZUgxauVyy8jbHyjoszw1Q8rVPBm9DSv/RCQMar40pxyA
         PpOSxa9jez9iPrEe+hvCCMEEIqSXKNMetoO1BV43cOX5wawDahYKQUqxH6xfNyUPG0tA
         Wf3uDhdr7K8HwALy0pTCTHHtb7y16zWv4g54qqUshgaPLmgEPL/JOcGqQg1PiygZu8gQ
         lSO4SGm6XI2bSyWnGzMg42yuphzdnRlzSHabkjIM1DIgGUz09HnKzFtfUnzYDQSHhxfS
         vsOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEy6qIqbtwDXCrAgLUUSSNyP1wpfJWT7WZvtBkU6HfV1M7hQS3B8KsYVw8/Liu8RbNM7j0XBCbJJVXsDzdwrJ/2JC5
X-Gm-Message-State: AOJu0YzD2/OyImp02+haSeCAkZAhflzgmDqQZbiLeYxSpIJhG4FWuR5V
	e/NTRqXgJ2s6hVvbaDoa4RsXYbdfMdB/NfWw52Sn7538AqL46ROh
X-Google-Smtp-Source: AGHT+IH5jv3qFcJVWwrZlR98ZJoOdADooOk23htH6IMXI6Qp2h+JyNKUO0PRLeBaA9q7OGzox6Hqew==
X-Received: by 2002:a05:600c:4746:b0:413:2fee:b359 with SMTP id w6-20020a05600c474600b004132feeb359mr334499wmo.3.1710346703978;
        Wed, 13 Mar 2024 09:18:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443? ([2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443])
        by smtp.gmail.com with ESMTPSA id fl21-20020a05600c0b9500b00413320f795fsm2750082wmb.35.2024.03.13.09.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 09:18:23 -0700 (PDT)
Message-ID: <9449a421-c6ea-427c-a600-73c6f99ccf0d@gmail.com>
Date: Wed, 13 Mar 2024 16:18:23 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] diff: add diff.srcPrefix and diff.dstPrefix
 configuration variables
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, git@vger.kernel.org,
 David Heidelberg <david@ixit.cz>, Dragan Simic <dsimic@manjaro.org>
References: <20240312231559.GA116605@quokka>
 <f8565251-2af1-470b-9b2d-798e3504b0d1@gmail.com> <xmqqbk7if8vj.fsf@gitster.g>
In-Reply-To: <xmqqbk7if8vj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/03/2024 15:29, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>> With a custom prefix those scripts will break, having an option that
>>> forces the a/ and b/ prefix helps. Plus the man page explicitly says:
>>>     Use the default source and destination prefixes ("a/" and "b/").
>>> So let's stick with that behaviour then.
>>
>> As I understand it the purpose of --default-prefix is to override all
>> the prefix related config settings so this seems like a very sensible
>> choice.
> 
> It would be nice to update the description of '--default-prefix' so
> that nobody has to say "As I understand it" anymore ;-)

That's a good idea

> As we are selling .{src,dst}Prefix as a thing that sets the default
> prefix, we'd need to break the loop somehow, and "hardcoded" below
> is my attempt to do so, but I am not sure if I succeeded.
> 
>   Documentation/diff-options.txt | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git c/Documentation/diff-options.txt w/Documentation/diff-options.txt
> index aaaff0d46f..62eaa46d84 100644
> --- c/Documentation/diff-options.txt
> +++ w/Documentation/diff-options.txt
> @@ -864,9 +864,10 @@ endif::git-format-patch[]
>   	Do not show any source or destination prefix.
>   
>   --default-prefix::
> -	Use the default source and destination prefixes ("a/" and "b/").
> -	This is usually the default already, but may be used to override
> -	config such as `diff.noprefix`.
> +	Use the hardcoded default source and destination prefixes
> +	("a/" and "b/").  This is designed to be used to override
> +	configuration variables such as `diff.noprefix` and
> +	`diff.srcPrefix`.

That looks clear to me. I think the only other config variable that 
affects the prefix is "diff.mnemonicPrefix" so if we're going to update 
the description to mention "diff.srcPrefix" maybe we should mention that 
one as well or just say something like "This is designed to be used to 
override the configuration variables `diff.*Prefix`.".

Best Wishes

Phillip


>   --line-prefix=<prefix>::
>   	Prepend an additional prefix to every line of output.
