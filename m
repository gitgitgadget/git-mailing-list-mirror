Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E739D1862F
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708880264; cv=none; b=XBqHYrdSYav2DB9dNbYSdPxVM2zBwvaFgVlknVlRQaFLa86GGXngA0yjJUb0E9QMHI4rfLqYreHMkM06lGR36e2C8kxE0jfV3RJ8MzXp+6arvQWXkJ9UPEsn8+54EbpnbgmvUvH7eJlz4bR5OcHGjsSKjojCy7/IIvDNpRG09lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708880264; c=relaxed/simple;
	bh=j/iQGk1VyePBjsW25PZM1QLYG0KGqORSPz9KYBYXqjQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LHM6bEo/I1PcYBMQKewPMUnkiRHUg/Q9L5oADaIky2mxefXy8xGUoER2iVMwhXaKt7MssUnT9n8FWmiJAySnl+YA8NlGkexPYVuJdSHzT8/edV1/XO5KhT1J9TlnWmXviZBzlLSz3L+dy33DVJ4406WjaF78bu1p+ap5GCe1eJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STft7VsI; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STft7VsI"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-563f675be29so2217634a12.0
        for <git@vger.kernel.org>; Sun, 25 Feb 2024 08:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708880261; x=1709485061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NjQTkUbJ0ZiHo+PRP2xQYHjDByrhBcW8QqgcWzTlY2U=;
        b=STft7VsIV8M8ck55cr0zFmf+Aj4zxAX3D06G3gjJhV2DcJmFRv2cFZTTOoArSR14ML
         6npsEKipOCwzYeGsQJEcMVfrN8TdZta+mrl9Ac92tGLW0OqaRgAQgJOmGCuX+gmRGooi
         T2LIGjYKXpWVSC7j5jbALXvJYJHfjh3w9Hx2HM+wG6ugpG06fa0nwzLEPeCutctKF/1w
         7egdNCY/bzWGlWcU6PflSnIpD/T3rvOcQWsGIzoNYkOt+7IXsOECKMxuCOhDfi4aeakr
         HPqyMqkF+UwUvULKWes99RVvLcxcOVjQnjqe5mXHXvtB09UxJMoikr6nQuQK+tOEB5to
         wIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708880261; x=1709485061;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NjQTkUbJ0ZiHo+PRP2xQYHjDByrhBcW8QqgcWzTlY2U=;
        b=KWnLQa8ymtF0CJMmL89Z8f2FlK82BswX57/Ua9UmZyudCzw6mOYBV+ehB+awYjqETn
         nl8c/MCAMQPo9IToyTVCIV2QBE7FphB4HvIzVkjkB8JNt/mEEY2zzbjHkVtRD/i1jhsG
         Arxofnlga+yVNfNnIW63E9/K2yrKRUj2dBhQlq7CLLxI7lBP8yMB2vhbd9TXauBj+O8A
         +4d2CJFx8cuiBzUBAr/4n6aNFU7Irwqusj1Jifgcs+XC/njm2O5uL5Fe9pQSEWVrfgnA
         fycKW5XHElRP5GQDqlLj+/WtRJ8d1wRRIMxvWdAwopaA/9EOQngCJqfsfhcWboYNnMom
         +dTg==
X-Gm-Message-State: AOJu0YzJoXsENx4kHCy37hPEAqK+OVzTZdLpKD2AflS+rcDo7DdHmzH5
	wcyLNgA3C9e43ft4JvApWgtn5tZjm2whDNZu6gs8Bjax+yWBzhJq/lMOnzpl
X-Google-Smtp-Source: AGHT+IFHaBawJKAHpEOr5oABNg84Io2cUZ4oYvyq8iRnyPRdqsF13pL3h6twgHtvhZaxdfT8nxbGVg==
X-Received: by 2002:a17:906:852:b0:a3e:3bc0:64f5 with SMTP id f18-20020a170906085200b00a3e3bc064f5mr3203423ejd.64.1708880261123;
        Sun, 25 Feb 2024 08:57:41 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:69d:3501:4b27:339f:196f:f7f9? ([2a0a:ef40:69d:3501:4b27:339f:196f:f7f9])
        by smtp.gmail.com with ESMTPSA id jw4-20020a17090776a400b00a434cae86ebsm179788ejc.219.2024.02.25.08.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 08:57:40 -0800 (PST)
Message-ID: <83070e02-8e6b-43d2-819d-2272fe895c75@gmail.com>
Date: Sun, 25 Feb 2024 16:57:37 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 8/8] cherry-pick: add `--empty` for more robust
 redundant commit handling
Content-Language: en-US
To: Brian Lyles <brianmlyles@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, newren@gmail.com, me@ttaylorr.com, gitster@pobox.com
References: <17b66baf4d8c4255.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
In-Reply-To: <17b66baf4d8c4255.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Brian

On 23/02/2024 06:58, Brian Lyles wrote:
> 
> On Thu, Feb 22, 2024 at 10:36 AM <phillip.wood123@gmail.com> wrote:
> 
>> I'm leaning towards leaving `--keep-redundant-commits` alone. That
>> introduces an inconsistency between `--keep-redundant-commits` and
>> `--empty=keep` as the latter does not imply `--allow-empty` but it does
>> avoid breaking existing users. We could document
>> `--keep-redundant-commits` as predating `--empty` and behaving like
>> `--empty=keep --allow-empty`. The documentation and implementation of
>> the new option look good modulo the typo that has already been pointed
>> out and a couple of small comments below.
> 
> I think I'm on board with leaving `--keep-redundant-commits` alone. I'm
> on the fence about having `--empty=keep` imply `--allow-empty` after
> seeing Junio's concerns. I laid out the options that I see in a reply to
> patch 6/8[1] and would appreciate input there. I'll adjust the details
> of this commit in v3 based on what we decide there.

I'll take a look at that in the next couple of days

> [1]: https://lore.kernel.org/git/17b666ca6c4b7561.70b1dd9aae081c6e.203dcd72f6563036@zivdesk/
>>
>>> +enum empty_action {
>>> +	EMPTY_COMMIT_UNSPECIFIED = 0,
>>
>> We tend to use -1 for unspecified options
> 
> Thanks, I'll update this in v3.
> 
>>> +test_expect_success 'cherry-pick persists --empty=stop correctly' '
>>> +	pristine_detach initial &&
>>> +	# to make sure that the session to cherry-pick a sequence
>>> +	# gets interrupted, use a high-enough number that is larger
>>> +	# than the number of parents of any commit we have created
>>> +	mainline=4 &&
>>> +	test_expect_code 128 git cherry-pick -s -m $mainline --empty=stop initial..anotherpick &&
>>> +	test_path_is_file .git/sequencer/opts &&
>>> +	test_must_fail git config --file=.git/sequencer/opts --get-all options.keep-redundant-commits &&
>>> +	test_must_fail git config --file=.git/sequencer/opts --get-all options.drop-redundant-commits
>>> +'
>>
>> Thanks for adding these tests to check that the --empty option persists.
>> Usually for tests like this we prefer to check the user visible behavior
>> rather than the implementation details (I suspect we have some older
>> tests that do the latter). To check the behavior we usually arrange for
>> a merge conflict but using -m is a creative alternative, then we'd run
>> "git cherry-pick --continue" and check that the commits that become
>> empty have been preserved or dropped or that the cherry-pick stops.
> 
> Indeed, I was modelling these new tests after other existing tests in
> this file. While I agree with you in theory, I am hesitant to make these
> new tests drastically different from the existing tests that are testing
> the same mechanisms (and appear to be very intentionally testing that
> the options are persisted in that config file). I'm also hesitant to
> update the existing tests as part of this series (primarily due to a
> lack of familiarity, and partially to avoid scope creep of the series).

I certainly don't think it should be up to you to update the existing 
tests. I'm not sure adding more tests in the same pattern is a good idea 
though. Apart from the fact that they are testing an implementation 
detail rather than the user facing behavior they don't actually check 
that the option is respected by "git cherry-pick --continue", only that 
we save it when stopping for a conflict resolution.

> How concerned are you about the current implementation? Does it make
> sense to you to defer this suggestion to a future series that cleans up
> the tests to do more user-oriented checks?

I think adding tests that follow a pattern we want to change is just 
storing up work for the future and makes it less likely we'll improve 
things because it will be more work to do so.

Best Wishes

Phillip

