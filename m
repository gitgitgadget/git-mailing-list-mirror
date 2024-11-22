Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE47524F
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732276772; cv=none; b=daM6FvWYKlrx+E6f/MlFO6vSyT8dg0MT+5zzJIsKet9OQAiZxgvzAVAIwylmnMh03zNA1wUyz8H8FxxbgAYF1CwwSr0ncfSk1pMTVHrcgk+McTbdYEa6oyLv9MLGBx/8jsRaJAO1XloG3Em+bdLD2npLrjTpAIIY9OrLE6kOFOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732276772; c=relaxed/simple;
	bh=qs8ovmzvuRpwuabZazkl/zbq7e8ie6yhm1gAT0vKp4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZmEfgqisGK8KQjKcbjvdbDG0BAP8NCYuFHamPI2VBUS3cyKZbbas0kdt0EI8UPIHVSHy1UDrJ2Uhd1ft0pFI/jynh6Ayq9d5zuc/jF6knrZyHdsDhxHxVarljqQVP5SLHXry+LLR49esxdRANh3GrRa9OVFi28zcl/Z0QGPYLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0dO7SeV; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0dO7SeV"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6eeb31b10ceso21145947b3.1
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 03:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732276769; x=1732881569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NuG9s6QhfEYvFSBC9VGVmi2gV2dNP6gtCUzf29OJUrg=;
        b=Y0dO7SeVNM+Yq5//a4ZgpIW9+U6jOj+vVj3S8ArlbJIo61vi1+3JVVAk7u7LcQAQa7
         IpFM8/4RJnqiklUYBVnqmKZ8f42QcdkNwIgDUpkoW9oAnpTCVGY9QY9XYaBNZwE74pTZ
         5HQK0nKECYzLt/PmruJ/fti3KYHupMmtGQEQOA7dXBLixWs5yW907b84xyzSaIpMEzBb
         2OqMeUcMtEK9GHwqXrptaFxWsexn5a6AngdXYjGQWrNb2ji2mTo4bGnH6yDfn320QfsC
         nugjRC/fn5HCf+ud2KeImEXiXYZWJxuZx4gWG7PniSVFxp0gXwZgd/DaKCI7WCxDYOMd
         Fo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732276769; x=1732881569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NuG9s6QhfEYvFSBC9VGVmi2gV2dNP6gtCUzf29OJUrg=;
        b=Hnpc8C2O7Yo1n7LYPTxlxgi0esWQVp/F13ErcAp5fpaxzrz+NCjV7ISXqltnBjCKwn
         0Psyq1DpAvVep1ikKDyGyl9HuQKJLZCoNMI0qg5VkrNr6v4AS/+SKP6/piEif0IzAeJu
         eMcQpD13xLYgBtu3IE1y/3H0CIQtImXx3YHB6xyj5lCe2zWXn1z0Kh22XA89CPoB/Le/
         XSqGLf+1/21cBJ8dHrRNd2kIiDV1gHL/DoPm/wIGUjis4H5zE/VJ5IWFytsaURpbD8j3
         N31mh6TWISHG80e/sOnMcjUc06UBs/9wf0QO/NziooVf5+U+zpyPz3vSNNSuZaCrovg8
         708w==
X-Gm-Message-State: AOJu0YxbaWvIg5SOksjd/rw/DPrE+RzsUskVS0E1hfGNLioUp6DhZoqp
	Q9K9IOKoNAyZr5IXucrTOIq4zjL8E3yrji+By3k6cE1b+61p54kd
X-Gm-Gg: ASbGncvFrK/ujRSTzYZfQexJp7aB0aDCgaccpm3100ztBlLZPRtukoidlZTomwU1JM3
	rKenKN1CzZCY0eVdC1CkSE3G8op9dbS8fxShIya1tll+kio15w3RG8eK7HM9hWI8KmW/SuL3ucb
	dFgQWZx1Ks8mrQ/RwTLSjrJeGC+oARvHvYIgm9Zj+YWqVDhne+ns7wFP3zpWF5h72eNAvVkSiCX
	gP6WW2L510vOaDcHPgQk00R/8RtssNr+l/Uqy4bt/dCnSbQB7ezZx6KliLqWDqw+wqQ40cx7ZGz
	ECPeHd1HD2HkVAIDPRLt4W1X9DL2huh9gMcSig==
X-Google-Smtp-Source: AGHT+IEOnxurJEKobSzp9a68jzPIA3mnu/D+8khAXYdu0HGckM4jtFAlKoRGG9yzw049QoH2QbnMdw==
X-Received: by 2002:a05:690c:630c:b0:6ee:a81e:6191 with SMTP id 00721157ae682-6eee09ea9c1mr32266387b3.22.1732276769532;
        Fri, 22 Nov 2024 03:59:29 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:79a7:3ea7:43e7:e05a? ([2600:1700:60ba:9810:79a7:3ea7:43e7:e05a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eedfe2a815sm4097567b3.43.2024.11.22.03.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 03:59:29 -0800 (PST)
Message-ID: <fbc0d959-48ea-4e24-aa8d-31f573f579e8@gmail.com>
Date: Fri, 22 Nov 2024 06:59:28 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] pack-objects: add --full-name-hash option
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
 <812257e197cfe30bd0d3c68ea6ec0d062631185f.1730775907.git.gitgitgadget@gmail.com>
 <Zz+TKS2O/ij6GZ1f@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Zz+TKS2O/ij6GZ1f@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/24 3:08 PM, Taylor Blau wrote:
> On Tue, Nov 05, 2024 at 03:05:01AM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>

>> It is clear that the existing name-hash algorithm is optimized for
>> repositories with short path names, but also is optimized for packing a
>> single snapshot of a repository, not a repository with many versions of
>> the same file. In my testing, this has proven out where the name-hash
>> algorithm does a good job of finding peer files as delta bases when
>> unable to use a historical version of that exact file.
> 
> I'm not sure I entirely agree with the suggestion that the existing hash
> function is only about packing repositories with short pathnames. I
> think an important part of the existing implementation is that tries to
> group similar files together, regardless of whether or not they appear
> in the same tree.

I'll be more explicit about the design for "hash locality" earlier in
the message, but also pointing out that the locality only makes sense as
a benefit when there are not enough versions of a file in history, since
it's nearly always better to choose a previous version of the same file
instead of a different path with a name-hash collision. Directory renames
are on place where this is a positive decision, but those are typically
rare compared to the full history of a large repo.

>> This is not meant to be cryptographic at all, but uniformly distributed
>> across the possible hash values. This creates a hash that appears
>> pseudorandom. There is no ability to consider similar file types as
>> being close to each other.
> 
> I think you hint at this in the series' cover letter, but I suspect that
> this pseduorandom behavior hurts in some small number of cases and that
> the full-name hash idea isn't a pure win, e.g., when we really do want
> to delta two paths that both end in CHAGNELOG.json despite being in
> different parts of the tree.

I mention that this doesn't work well in all cases when operating under
a 'git push' or in a shallow clone. Shallow clones are disabled in a later
commit and we don't have the necessary implementation to make this hash
function be selected within 'git push'.

> You have some tables here below that demonstrate a significant
> improvement with the full-name hash in use, which I think is good worth
> keeping in my own opinion. It may be worth updating those to include the
> new examples you highlighted in your revised cover letter as well.

I'll try to remember to move the newer examples to the cover letter.

>> In a later change, a test-tool will be added so the effectiveness of
>> this hash can be demonstrated directly.
>>
>> For now, let's consider how effective this mechanism is when repacking a
>> repository with and without the --full-name-hash option. Specifically,
> 
> Is this repository publicly available? If so, it may be worth mentioning
> here.

Here, by "when repacking a repository" I mean "we are going to test
repacking a number of example repositories, that will be listed in detail
in the coming tables".

>> Using a collection of repositories that use the beachball tool, I was
>> able to make similar comparisions with dramatic results. While the
>> fluentui repo is public, the others are private so cannot be shared for
>> reproduction. The results are so significant that I find it important to
>> share here:
>>
>> | Repo     | Standard Repack | With --full-name-hash |
>> |----------|-----------------|-----------------------|
>> | fluentui |         438 MB  |               168 MB  |
>> | Repo B   |       6,255 MB  |               829 MB  |
>> | Repo C   |      37,737 MB  |             7,125 MB  |
>> | Repo D   |     130,049 MB  |             6,190 MB  |

These repos B, C, and D are _not_ publicly available, though.

>> diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
>> index e32404c6aae..93861d9f85b 100644
>> --- a/Documentation/git-pack-objects.txt
>> +++ b/Documentation/git-pack-objects.txt
>> @@ -15,7 +15,8 @@ SYNOPSIS
>>   	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
>>   	[--cruft] [--cruft-expiration=<time>]
>>   	[--stdout [--filter=<filter-spec>] | <base-name>]
>> -	[--shallow] [--keep-true-parents] [--[no-]sparse] < <object-list>
>> +	[--shallow] [--keep-true-parents] [--[no-]sparse]
>> +	[--full-name-hash] < <object-list>
> 
> OK, I see that --full-name-hash is now listed in the synopsis, but I
> don't see a corresponding description of what the option does later on
> in this file. I took a look through the remaining patches in this series
> and couldn't find any further changes to git-pack-objects(1) either.

I'll fix that. Thanks. As well as moving the 'git repack' changes out
of this patch. I'll adjust the commit message to say "packing all objects'
instead of 'git repack' to be clear that this can be done with a direct
call to 'git pack-objects' instead of needing 'git repack'.

>> +	if (write_bitmap_index && use_full_name_hash) {
>> +		warning(_("currently, the --full-name-hash option is incompatible with --write-bitmap-index"));
>> +		use_full_name_hash = 0;
>> +	}
>> +
> 
> Good, we determine this early on in the command, so we don't risk
> computing different hash functions within the same process.
> 
> I wonder if it's worth guarding against mixing the hash functions within
> the pack_name_hash() and pack_full_name_hash() functions themselves. I'm
> thinking something like:
> 
>      static inline uint32_t pack_name_hash(const char *name)
>      {
>          if (use_full_name_hash)
>              BUG("called pack_name_hash() with --full-name-hash")
>          /* ... */
>      }
> 
> and the inverse in pack_full_name_hash(). I don't think it's strictly
> necessary, but it would be a nice guard against someone calling, e.g.,
> pack_full_name_hash() directly instead of pack_name_hash_fn().

I think this is interesting defensive programming for future contributions.

We essentially want the methods to only be called by pack_name_hash_fn()
and don't have method privacy. We could extract it to its own header file
but then would need to modify the prototype to include the signal for
which hash type to use, but that would cause us to lose our ability to
check for a bug like this.

It may be even better to store a static value for the value of
use_full_name_hash when it first executes, so it can exit if it notices
a different value. (This is becoming large enough for its own patch.)

> The other small thought I had here is that we should use the convenience
> function die_for_incompatible_opt3() here, since it uses an existing
> translation string for pairs of incompatible options.
> 
> (As an aside, though that function is actually implemented in the
> _opt4() variant, and it knows how to handle a pair, trio, and quartet of
> mutually incompatible options, there is no die_for_incompatible_opt2()
> function. It may be worth adding one here since I'm sure there are other
> spots which would benefit from such a function).

Interesting. I've not considered these functions before.

>> diff --git a/builtin/repack.c b/builtin/repack.c
>> index d6bb37e84ae..ab2a2e46b20 100644
>> --- a/builtin/repack.c
>> +++ b/builtin/repack.c
> 
> I'm surprised to see the new option plumbed into repack in this commit.
> I would have thought that it'd appear in the subsequent commit instead.
> The implementation below looks good, I just imagined it would be placed
> in the next commit instead of this one.

Yes, I should delay that to patch 2.

Thanks,
-Stole


