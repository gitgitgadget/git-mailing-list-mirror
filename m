Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB61275804
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718983533; cv=none; b=ZjxTWiZfHKDlEhOkJEj3FXnL4hIpAS/2iUE/O5BA6k1VVrLEVqDLA5KVoqXvw/qo16LZKK+orpe62PqA85LJE5vJgGmdhb/+9f7CvLnCsHuqALCJ8u5odtjfbTudoEBSN2GSCpGTIVB8TCy6aB6QIvOGmLZ3R4wloGLLtbkmIKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718983533; c=relaxed/simple;
	bh=6k2uh5OK1ANKFkGXVf10FDKR1Nwo5GQeYdm5r9e1FP8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IRY5oW5Gnf2gYdQMwerS6FbwO5YFb1tNmBf/ifqKyvVIZdluQ90wp15RIXWM7xunCPWqt8AeBIuustEH2Un4vpI/Ue6HvhHQVeZr7Wj4OR+dDyqMI6hT9ZatEzFmI/ywql6GdmFmg2fkGGe889oHugA3z2pxtKVF68k+a1dcyCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGUsReZq; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGUsReZq"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ec4a11a297so16816261fa.0
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 08:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718983530; x=1719588330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tu2xnEl7SXZIiYtmaqVREbX0vW2TAoO0p3R0MJD8sdE=;
        b=SGUsReZqBUrzI9pzoEhz8AFWSTNJXUe2lE/3btZB8EtSA6P9n4bIpVCPUJOaS/kdUZ
         bnv9CqvJRRn/m0Gkea5yzQjuYml4jPMDFXHPaBDi1PWwUjGv06ve4d0AKUv2h4xRZEe+
         QQPSXd0hBsEgE6Xa/zkR9tb73q9PYx3sf8wWFF2x6t0ofHTvMz1HbQsNtU2xXD1XOQ6b
         DyUSObT6rLwML41esZTMyaus9I+1oGezVeR7waQyeKuFNA99njZwPGJ1ZN9+zF5FeWsz
         xGJF0OUgaEmzHUaeGy+a6sE0VTJWzM9Cq0QjPOi016zpNTlD2L3hMN6eoO/ZW2/OFrEv
         bdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718983530; x=1719588330;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tu2xnEl7SXZIiYtmaqVREbX0vW2TAoO0p3R0MJD8sdE=;
        b=o7C5xgc3I5VGRSQeVb+X3bngAzGYiXdMMTnm75FkN35EfrvKH3pD6+DJkg1gw+SjQv
         d8cDyIzK2hW9Wn9n0ZfyQgHrQZP7YaknjM8FtS1Vv9HbqSI0Sn23Cf/VtGsRnMK67Qnr
         xPF2Hdpax4lccFlS4uFME/SzaNNRVGINOkBkKaavxuYpExOStiYFLNsmXpB6mDuyKaZu
         PWvDWNkDK93h+4TKac0iA2q7A7Md4P62XdomdWcqMQ2AozQNuXfm00JgJZUggcVVFJ3d
         XfFe3zKVDdqsVohr8rEYaTZ7kEOnMq9o4RXHBEf13Htj4jxr+T4ad6QjE1T4qDPfa24z
         wWXg==
X-Gm-Message-State: AOJu0YwFsD8MTBYLpvF6tErm8hQFBcOEWsBNI7XINpPByl69ez3lC6+k
	6MzclVcdURMNDkpODolFgr+20lg0GUjfJoSXKhzmLyJMQM38OzNjHUUlbA==
X-Google-Smtp-Source: AGHT+IHd60P4yurO0m/FZMAeI0VLpNlAvDtcbIC/2b+v++tYiLP8DdsV+RGwBIISlM4VNSJzwM0QVg==
X-Received: by 2002:a05:6512:5cc:b0:52c:d6d7:9dd0 with SMTP id 2adb3069b0e04-52cd6d7a833mr1140270e87.20.1718983529564;
        Fri, 21 Jun 2024 08:25:29 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b63d4sm69004375e9.3.2024.06.21.08.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 08:25:29 -0700 (PDT)
Message-ID: <3dff8e61-1474-425a-8454-4d729b62ef83@gmail.com>
Date: Fri, 21 Jun 2024 16:25:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] cat-file: reduce write calls for unfiltered blobs
From: Phillip Wood <phillip.wood123@gmail.com>
To: Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org
References: <20240621020457.1081233-1-e@80x24.org>
 <20240621062915.GA2105230@coredump.intra.peff.net>
 <3d43023c-ceb8-4e5c-9607-8448509fb599@gmail.com>
Content-Language: en-US
In-Reply-To: <3d43023c-ceb8-4e5c-9607-8448509fb599@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/06/2024 14:24, Phillip Wood wrote:
> Hi Eric and Peff
> 
> On 21/06/2024 07:29, Jeff King wrote:
>> On Fri, Jun 21, 2024 at 02:04:57AM +0000, Eric Wong wrote:
>>
>>> While the --buffer switch is useful for non-interactive batch use,
>>> buffering doesn't work with processes using request-response loops since
>>> idle times are unpredictable between requests.
>>>
>>> For unfiltered blobs, our streaming interface now appends the initial
>>> blob data directly into the scratch buffer used for object info.
>>> Furthermore, the final blob chunk can hold the output delimiter before
>>> making the final write(2).
>>
>> So we're basically saving one write() per object. I'm not that surprised
>> you didn't see a huge time improvement. I'd think most of the effort is
>> spend zlib decompressing the object contents.
> 
> If I'm reading the changes correctly

Looking at the patch again I had misread it - the buffer is the same 
size and so the rest of this paragraph is nonsense.

Sorry for the noise

Phillip

> then I think we may be saving more 
> than one write far large objects we now seem to allocate a buffer large 
> enough to hold the whole object rather than using a fixed 16KB buffer. 
> The streaming read functions seem to try to fill the whole buffer before 
> returning so I think we'll try and write the whole object at once. I'm 
> not sure that approach is sensible for large blobs due to the extra 
> memory consumption and it does not seem to fit the behavior of the other 
> streaming functions.
> 
> If the reason for this change is to reduce the number of read() calls 
> the consumer has to make isn't that going to be limited by the capacity 
> of the pipe? Does git to writing more than PIPE_BUF data at a time 
> really reduce the number of reads on the other side of the pipe?
> 
>>> +
>>> +/*
>>> + * stdio buffering requires extra data copies, using strbuf
>>> + * allows us to read_istream directly into a scratch buffer
>>> + */
>>> +int stream_blob_to_strbuf_fd(int fd, struct strbuf *sb,
>>> +                const struct object_id *oid)
>>> +{
>>
>> This is a pretty convoluted interface. Did you measure that avoiding
>> stdio actually provides a noticeable improvement?
> 
> Yes this looks nasty especially as the gotcha of the caller being 
> responsible for writing any data left in the buffer when the function 
> returns is undocumented.
> 
> Your suggestion below to avoid looking up the object twice sounds like a 
> nicer and hopefully more effective way of trying to improve the 
> performance of "git cat-file".
> 
> Best Wishes
> 
> Phillip
> 
> 
>> This function seems to mostly duplicate stream_blob_to_fd(). If we do
>> want to go this route, it feels like we should be able to implement the
>> existing function in terms of this one, just by passing in an empty
>> strbuf?
>>
>> All that said, I think there's another approach that will yield much
>> bigger rewards. The call to _get_ the object-info line is separate from
>> the streaming code. So we end up finding and accessing each object
>> twice, which is wasteful, especially since most objects aren't big
>> enough that streaming is useful.
>>
>> If we could instead tell oid_object_info_extended() to just pass back
>> the content when it's not huge, we could output it directly. I have a
>> patch that does this. You can fetch it from https://github.com/peff/git,
>> on the branch jk/object-info-round-trip. It drops the time to run
>> "cat-file --batch-all-objects --unordered --batch" on git.git from ~7.1s
>> to ~6.1s on my machine.
>>
>> I don't remember all the details of why I didn't polish up the patch. I
>> think there was some refactoring needed in packed_object_info(), and I
>> never got around to cleaning it up.
>>
>> But anyway, that's a much bigger improvement than what you've got here.
>> It does still require two write() calls, since you'll get the object
>> contents as a separate buffer. But it might be possible to teach
>> object_oid_info_extended() to write into a buffer of your choice (so you
>> could reserve some space at the front to format the metadata into, and
>> likewise you could reuse the buffer to avoid malloc/free for each).
>>
>> I don't know that I'll have time to revisit it in the near future, but
>> if you like the direction feel free to take a look at the patch and see
>> if you can clean it up. (It was written years ago, but I rebase my
>> topics forward regularly and merge them into a daily driver, so it
>> should be in good working order).
>>
>> -Peff
>>
> 
> 
