Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3263B36A026
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770807435; cv=none; b=okMXJal+roJleHItkUleDnBD2B1CgHC4KFp7P8Or/hCXdF1aSSYp2fkTLydeulcwRF/tX4vCdCm3NEgD+hMk2VS8+RGs0CJPjA2uo52odxTGGTl7YzAWHOP9w8q2MS1nz9M9ZIV4OxAKRZdsPORivoi3GAOTbaOgyWLp/3i0Tus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770807435; c=relaxed/simple;
	bh=RwG8JVOGsGx4hJzBrTIrHZE9GtjyuEbLezPkz1F+qds=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=njmK0LotliMAEN70tLMrOmAagCxUzQ6G+JqfkgWxwIvXInqd6GgvCqqlLTeV82+xBuEEKOcKtpA3FesnCPdKL02DZAxSjq5js2x4cxPQtRKSRE/mbqWJGvqq4vZe4ApoQk/w9fC/Iog27RjEHfSUhHNd9qeyCtt+J76QWKRJpxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+ojHSKb; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+ojHSKb"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4806bf39419so5130845e9.1
        for <git@vger.kernel.org>; Wed, 11 Feb 2026 02:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770807432; x=1771412232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KRY1UMiRgoPo02Ka4lhsOrAYka1HF7XtfvkRBa6Ipb4=;
        b=X+ojHSKbvVjryVKR+1JEuCazW+cEra+rEyEAshU9KwrUq0f6thbEr7mCYm91j9nCUz
         OQS4y9Gdkx4nvlREBmy+flF6cWmmUojnU+/FMIbKIYoHLSxyNSUrRRNBEu5q1DGhKO++
         nCJaPDCUH39gQIz9oRvUCb6vVqsX6dcvxjLQ0LhxWmbiHDyDeyNLMDdmOiv3fF3t6AFX
         Q+c/t2vd6dSUD3STMfZ81H/+ZHhcYcDZkjziXbPBSlNS06rxrHCekxM/qR2KofAqj1dz
         /O1D9OFFy5j+u/HSZbHrggE7Asznwjv2wfaaQKaMDTaBwp28eSihCdZHJJJZKrCoggN2
         Uy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770807433; x=1771412233;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRY1UMiRgoPo02Ka4lhsOrAYka1HF7XtfvkRBa6Ipb4=;
        b=S0YJp2vyrtyiXV+2Vywi90V744m+5lXj+PELSBnmg8GKsR9OMeLGQMDi3vfP/f49XK
         KRUUB7IJ5WFC1Rc60kAzN4m25fYr08P6Nsj22Y05hiPZd+xp40AcLySFECpAFD1j1Vw1
         p5iwl8tIeWLZH7jBXWp3o/HJRWZ/o2PonkHmHJXqY9gLooikr3PrpK6cdMkCopaAZ3aK
         f0IhEV/f5UjdoPDwlug2VXPmuW0CtqTnYBb+lKO8LSo2BrE1WKzCPJmS/JgYWqSH/r5S
         ymQq9A1cMIOznuWfsPzMNxWswbNn6j2sa1jnqN0keLJUM1KU2r4ibAN82HbZfU01sm97
         HLRw==
X-Gm-Message-State: AOJu0Yzxbyz4IDM+eIxE+O9VsBNzk2lamuztaL9odbPOsri5U4KxXPE2
	UgQea/XMjQW1WB8ScLQeK2XrwI6u3yTUOzSs3Z679Cpg1rZ44Pob7EiO
X-Gm-Gg: AZuq6aIQK1T1vWAeRlRgBib2tNGlijOvud+EDY2bd67Dfr0SuP9Au0JKyPMvs34BHpz
	58ROCP8JB9URmrFvjCl726hQvSDo2zjbKjHU/zm3NZqPs3HyGn87D1ClipQTRXNg0toitSqCPuP
	rkl1YUhYUpWHlO7HP692GlQGxQtPrQzxA/vLsEoiCzypIagTqgpFty46/mjIRLBiKCstaRJTkLR
	mAEsjfUYaZjim69yfj10B/j4md15PNqpjtMoJmi/C6eqVgtbwqKywRohy5ZDqb1rd0fgNFtxdwy
	W40wwiT725CC66UwO0EEMRq+wEpRmJ1ms3XaFZsnqX/e7fjEszgVRk323jwIIjQMxaN0gbYN3R6
	mopOXAKr8J0eDtMS2SC13yw6J2Svu4iJR9Sy4E6XT+KV80zy9V2irPn+giWBy6Xjpc7P5oF6aCW
	wNNfE3Mxw0lPfGYQHH0eZwvVAFBFxOoi9XRN1NhO1/6TPVTd6O+mvSe2rTEYck5io0mHvT8rrPH
	8aJIN8OvuODi7/p
X-Received: by 2002:a05:600c:4253:b0:480:63c1:3ac7 with SMTP id 5b1f17b1804b1-4834f6c1567mr52357465e9.2.1770807432165;
        Wed, 11 Feb 2026 02:57:12 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d835f6bsm106082675e9.14.2026.02.11.02.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 02:57:11 -0800 (PST)
Message-ID: <81ff4cc8-676e-43fe-8193-609887b887d6@gmail.com>
Date: Wed, 11 Feb 2026 10:57:10 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] meson: regenerate config-list.h when Documentation
 changes
From: Phillip Wood <phillip.wood123@gmail.com>
To: Patrick Steinhardt <ps@pks.im>,
 "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Evan Martin <evan.martin@gmail.com>
References: <aYn8XKv2hH2HX2xO@pks.im>
 <20260209215015.25867-1-ben.knoble+github@gmail.com>
 <aYwzAt-dugh_acj9@pks.im> <4a566010-821b-4078-9563-9ca00ada55a0@gmail.com>
Content-Language: en-US
In-Reply-To: <4a566010-821b-4078-9563-9ca00ada55a0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/02/2026 09:44, Phillip Wood wrote:
> On 11/02/2026 07:42, Patrick Steinhardt wrote:
>> On Mon, Feb 09, 2026 at 04:50:06PM -0500, D. Ben Knoble wrote:
>>>> On Sat, Feb 07, 2026 at 04:59:17PM -0500, D. Ben Knoble wrote:
>> [snip]
>>> Only, things are behaving oddly. For example:
>>>
>>>      λ meson setup build2
>>>      λ ninja -C build2
>>>
>>> works fine, but
>>>
>>>      λ ls -l build2/config*
>>>      -rw-r--r-- 1 benknoble benknoble 17169  9 févr. 16:39 build2/ 
>>> config-list.h
>>>
>>> I don't see the dependency file.

I've just had a play with this and I don't see the dependency file 
either - I wonder if ninja deletes it after it has read it.

If I delete Documentation/config/add.adoc then config-list.h is rebuilt. 
However if I edit generate-configlist.sh it is not rebuilt - I guess we 
need to add the script to the dependency file.

Thanks

Phillip

>>> Further, re-building seems to get stuck (I get
>>> similar symptoms if I add or remove a relevant config.adoc file, but 
>>> let's keep
>>> it simple for now):
>>>
>>>      λ ninja -C build2
>>>      ninja: Entering directory `build2'
>>>      [1/28] Generating GIT-VERSION-FILE with a custom command 
>>> (wrapped by meson to set env)
>>
>> With "stuck" you mean that it doesn't do anything, or that it doesn't
>> actually rebuild?
>>
>> I guess it kind of makes sense that a new file wouldn't trigger a
>> rebuild, even though I would have expected a removed one to trigger one.
>> After all, the dependency file only tracks the set of _existing_ files
>> so that we know when to rebuild, and of course the dependency file only
>> gets regenerated in case any of those files changes.
> 
> If anyone adds a new file under Documentation/config/ they will need to 
> update Documentation/config.adoc which should then trigger the rebuild. 
> That rebuld will then add the new file to the list of dependencies. If 
> they remove a file we should pick that up with the dependencies that are 
> already listed.
> 
> Do we need to create the depfile when meson is setup? What does meson do 
> when the depfile is missing?
> 
>> The thing is that build systems like Meson really want to know the list
>> of files ahead of time so that they can have an optimal build graph. So
>> we could of course list all the files that we actually depend on. But I
>> guess that's something we want to avoid?
>>
>> There's another, alternative approach: you can have a separate build
>> step that's marked as `build_always_stale: true` that lists all the
>> config files. This step would then always run, and it would only update
>> its target file in case any of the files has changed.
> 
> It would be really nice if we can avoid regenerating the depfile with 
> every build.
> 
> Thanks
> 
> Phillip
> 
>> Combined with the depfile we'd then rebuild in all cases:
>>
>>    - When a file gets added or removed, as that would cause the
>>      `build_always_stale` target to be rewritten.
>>
>>    - When any of the files changes, because that would cause the
>>      dependencies in the depfile to change.
>>
>> Something like the attached patch (note that I don't perform the
>> necessary changes for the Makefile). I confirmed that it works for all
>> of the above cases.
>>
>> Thanks!
>>
>> Patrick
>>
>> --- >8 ---
>>
>> diff --git a/generate-configlist.sh b/generate-configlist.sh
>> index 75c39ade20..17605e6f77 100755
>> --- a/generate-configlist.sh
>> +++ b/generate-configlist.sh
>> @@ -1,13 +1,6 @@
>>   #!/bin/sh
>> -SOURCE_DIR="$1"
>> -OUTPUT="$2"
>> -
>> -if test -z "$SOURCE_DIR" || ! test -d "$SOURCE_DIR" || test -z "$OUTPUT"
>> -then
>> -    echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT>"
>> -    exit 1
>> -fi
>> +set -e
>>   print_config_list () {
>>       cat <<EOF
>> @@ -30,9 +23,50 @@ EOF
>>   EOF
>>   }
>> -{
>> -    echo "/* Automatically generated by generate-configlist.sh */"
>> -    echo
>> -    echo
>> -    print_config_list
>> -} >"$OUTPUT"
>> +case "$1" in
>> +generate)
>> +    SOURCE_DIR="$2"
>> +    OUTPUT="$3"
>> +    DEPFILE="$4"
>> +
>> +    if test -z "$SOURCE_DIR" || ! test -d "$SOURCE_DIR" || test -z 
>> "$OUTPUT"
>> +    then
>> +        echo >&2 "USAGE: $0 generate <SOURCE_DIR> <OUTPUT>"
>> +        exit 1
>> +    fi
>> +
>> +    if test -n "$DEPFILE"
>> +    then
>> +        printf "$OUTPUT: %s\n" "$SOURCE_DIR"/Documentation/ 
>> *config.adoc \
>> +            "$SOURCE_DIR"/Documentation/config/*.adoc >"$DEPFILE"
>> +    fi
>> +
>> +    {
>> +        echo "/* Automatically generated by generate-configlist.sh */"
>> +        echo
>> +        echo
>> +        print_config_list
>> +    } >"$OUTPUT"
>> +    ;;
>> +deps)
>> +    SOURCE_DIR="$2"
>> +    OUTPUT="$3"
>> +
>> +    if test -z "$SOURCE_DIR" || ! test -d "$SOURCE_DIR" || test -z 
>> "$OUTPUT"
>> +    then
>> +        echo >&2 "USAGE: $0 deps <SOURCE_DIR> <OUTPUT>"
>> +        exit 1
>> +    fi
>> +
>> +    TMPFILE=$(mktemp "$OUTPUT".XXXXXX)
>> +    printf "%s\n" "$SOURCE_DIR"/Documentation/*config.adoc \
>> +        "$SOURCE_DIR"/Documentation/config/*.adoc | sort >"$TMPFILE"
>> +
>> +    if ! test -f "$OUTPUT" || ! cmp "$TMPFILE" "$OUTPUT" >/dev/null
>> +    then
>> +        mv "$TMPFILE" "$OUTPUT"
>> +    else
>> +        rm "$TMPFILE"
>> +    fi
>> +    ;;
>> +esac
>> diff --git a/meson.build b/meson.build
>> index dd52efd1c8..6b9147a39a 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -716,14 +716,29 @@ if not get_option('breaking_changes')
>>     builtin_sources += 'builtin/pack-redundant.c'
>>   endif
>> +configlist_deps = custom_target(
>> +  output: 'config-list.h.deps',
>> +  command: [
>> +    meson.current_source_dir() + '/generate-configlist.sh',
>> +    'deps',
>> +    meson.current_source_dir(),
>> +    '@OUTPUT@',
>> +  ],
>> +  build_always_stale: true,
>> +)
>> +
>>   builtin_sources += custom_target(
>>     output: 'config-list.h',
>>     command: [
>>       shell,
>>       meson.current_source_dir() + '/generate-configlist.sh',
>> +    'generate',
>>       meson.current_source_dir(),
>>       '@OUTPUT@',
>> +    '@OUTPUT@.d',
>>     ],
>> +  depends: [ configlist_deps, ],
>> +  depfile: 'config-list.h.d',
>>     env: script_environment,
>>   )
>>
> 

