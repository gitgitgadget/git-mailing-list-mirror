Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE6A1F951
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 21:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726002568; cv=none; b=knwVdFjJiRvANFhpFFhLJPJwfobuxl6BjJlcDK10X8R47D4AdqdwS+g1aAX4AEm1BY1RSjKXZ12sZnIqRcyJBnp1+A0AZZecg9gPg17dllCJo3LtR05FSG3P5KIL47gtJwOI6WFPrFuIGOPqsmwGuAdBLxo+GdylohYLVxbzWPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726002568; c=relaxed/simple;
	bh=mNudotoFhYSol3YBaCj3uKLpJqjimrYHLEB8dc5IMI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f061KWybk4RGfQ4a9q+K3VbVi6IhI8KdPILETQe2DxflX6w+pRDKqbW05Sk+FIRAzIu62ssRrOZxx19L4ZuEGwqbcEul9Ir+sE4s/DLkrOZltb+FjYd/OWT313fUyh5hPOLSL4EE6KkKGFzapu5JGuH6JZPQREoK0ux/dYX6w9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMS7i6yj; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMS7i6yj"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e0465e6bd5so1279894b6e.2
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 14:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726002566; x=1726607366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9MJ4H889rH5TPmIttt6WZm7R2F/psu3EX3MVLJN+iis=;
        b=LMS7i6yjf5jI92exdohnE+w9VNy3SBqS18B8F7m9A4T2pX9VLWYcWkb4t8JJWk6F7i
         XCb4PVyAxwQw5ARpDaow/o/eDoBzVrU/EzA8Mz6BAkAnsa2A9DteNM+2O8KVDdZTzHDU
         4OGE5/BBQPIow8OpDzaPU0hRIRmDzlM3pnxWDudD1H5dloITh6ULH39CtpJ/e7GCSGn2
         xBam2PlKhaDjI3r7aKSPtDqnxhI8dQ/sMoAYke8fQkBa39ehdcSF27K0U7LXUlaQ872k
         cEaO+6uABQZ5KL1uQsRCiR4A7+UyyZ+4Re4K9TA0kg+NqSeb4zuhYPw+8NnoeegQJNQ0
         /UDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726002566; x=1726607366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9MJ4H889rH5TPmIttt6WZm7R2F/psu3EX3MVLJN+iis=;
        b=JZzMYTYL4q4mj7HrTTD0m5C+2d1cXwPeWP4oXfPaOYNoEriaus8l5vGnsQxjTQeunp
         WncCYOu59q0fW4m2Yttc5xENbWw45X6dUfCv4uZquNvOgi/C/6zsbRGQAQc3Syiw4D0y
         PROBIdeIt+AVXQxsEA2SK5P07j8OEcr76L5flIUk5aWgfNZL/33PZfOeKz2pfWdTeZOQ
         b6Qjj4Xv10DBSbBp8/3LDLDT7Ud7JBH/JKrgGTPf53zEwsb/alxMbFVF+0IpSILo4bcG
         dPYWzlYA+KcoSgt1AlIJ6cw1eKB8mvzOeTJdQGxc2rni/J+BdfHwCox0RR6Bwil2G8Xr
         el7A==
X-Forwarded-Encrypted: i=1; AJvYcCUd/U623syFuSgxiGbSmIB4y9MIKRse28maeCI77YuP5jQrRR9XBCXBjFMAduJqOhOPOtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgMnRWY7UEaH+6DmJ/Z4Jb6KzuMM3D0uWObDVflMBOPNwAGTVp
	nrVGSH3J62RvP2gR8pfGSg6UwANxCKAJP/zEPbwEZkJ+6+BOFz6g3pS7Cg==
X-Google-Smtp-Source: AGHT+IE1yA8H0VI/2/ZYuqTwA3eE8GpgGud2wmNkffxpdzin8t7piMT75Qo9F6fJYLJ/O8GgYn6ncw==
X-Received: by 2002:a05:6808:2dca:b0:3e0:3d6c:116d with SMTP id 5614622812f47-3e03d6cb37amr13972891b6e.26.1726002565798;
        Tue, 10 Sep 2024 14:09:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:947:8408:9218:50e0? ([2600:1700:60ba:9810:947:8408:9218:50e0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e039c052d5sm1751087b6e.46.2024.09.10.14.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 14:09:23 -0700 (PDT)
Message-ID: <1fe607db-04eb-4a6b-a523-9e18397f2d16@gmail.com>
Date: Tue, 10 Sep 2024 17:09:22 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] pack-objects: create new name-hash algorithm
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im,
 me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
 <xmqqjzfkr9b0.fsf@gitster.g> <0e6dde0f-63e2-4db3-9225-9a8ca5e78eb3@gmail.com>
 <xmqq4j6nlcfy.fsf@gitster.g> <xmqqikv3dz5l.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqikv3dz5l.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 4:36 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Derrick Stolee <stolee@gmail.com> writes:
>>
>>> The thing that surprised me is just how effective this is for the
>>> creation of large pack-files that include many versions of most
>>> files. The cross-path deltas have less of an effect here, and the
>>> benefits of avoiding name-hash collisions can be overwhelming in
>>> many cases.
>>
>> Yes, "make sure we notice a file F moving from directory A to B" is
>> inherently optimized for short span of history, i.e. a smallish push
>> rather than a whole history clone, where the definition of
>> "smallish" is that even if you create optimal delta chains, the
>> length of these delta chains will not exceed the "--depth" option.
>>
>> If the history you are pushing modified A/F twice, renamed it to B/F
>> (with or without modification at the same time), then modified B/F
>> twice more, you'd want to pack the 5-commit segment and having to
>> artificially cut the delta chain that can contain all of these 5
>> blobs into two at the renaming commit is a huge loss.
> 
> Which actually leads me to suspect that we probably do not even have
> to expose the --full-name-hash option to the end users in "git repack".
> 
> If we are doing incremental that would fit within the depth setting,
> it is likely that we would be better off without the full-name-hash
> optimization, and if we are doing "repack -a" for the whole
> repository, especially with "-f", it would make sense to do the
> full-name-hash optimization.

Depending on how much we learn from others testing the --full-name-hash
option, I could see the potential that -a could imply --full-name-hash.
I hesitate to introduce that in the first release with this option,
though.

> If we can tell how large a chunk of history we are packing before we
> actually start calling builtin/pack-objects.c:add_object_entry(), we
> probably should be able to even select between with and without
> full-name-hash automatically, but I do not think we know the object
> count before we finish calling add_object_entry(), so unless we are
> willing to compute and keep both while reading and pick between the
> two after we finish reading the list of objects, or something, it
> will require a major surgery to do so, I am afraid.

It's also possible that we could check the list of paths at HEAD to
see how many collisions the default name-hash gives. In cases like
the Git repository, there are very few collisions and thus we don't
need to use --full-name-hash. Restricting to just HEAD (or the
default ref) is not a complete analysis, but might be a good
heuristic.

Thanks,
-Stolee

