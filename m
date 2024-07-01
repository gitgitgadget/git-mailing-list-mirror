Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85565522F
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847445; cv=none; b=aJk0JM0ukoba61C3+kZI6pjPizX7i9WkBTrUq1SKgiMP3y/D13Prie9lD4Mk+PNpH5Kgx3KPjcEq/PlJpTYVS95u2Nzgb1tBApiEbn9J4ur8iPJ8d9nXBLK1wLlblNNcmrcrZOPOYuAeH+vSk+xvh3L2qXyTUqFuPZLjNR1fxTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847445; c=relaxed/simple;
	bh=MP8Xhk28SgAtlnr62bpsGFCtXfG9XR/Et+MVpf6bFME=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jxiAeo+It8yI/yXBFL8n8r8x0aAVgWhEi2p6PplqwPEGIenHFebBZn43b6iDtXCdtcUcZAEPme2SAAKImOrrg0f8RnIv/myF2O7us//dOf7FuEfyNwMJz7NptjHD5rbfx1iWyFTD5M5GTBMfjD/IeVPd9+8rDU8LF8pRjme0U+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czlvfm79; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czlvfm79"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42138eadf64so23112775e9.3
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 08:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719847442; x=1720452242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yezdg1XlqV8Yo4K0h4GGfdcfBEBFo+YRjw2vEwlYTKk=;
        b=czlvfm79sqmEKzVWYZdvHY+OPgbJLhkFE3vW8YJfUrHwUwav08vnw6s1EUHeadiRci
         +g0nl7O2qKcIAqRvKBHEat9n+IKckgReL4PLSra5ILQhTGmirF0zn/P+dWKzrcjyPXnM
         fplC81ZIdQnDYgFfg8pG6Tdu7uQokbh6StofwPvjRz7+0snKrVJk9OaFUXqSkgZA9ZIt
         SrHJ2QdpuYSF5rPkrADL2ezJorKSQkuIVsVeNu1xVZlPC+0n7Sqagy5KJYMD7CfBWz5/
         B/YO+BCIo7Sn6pKAuCRetyan8A19yu6gDtLVFFtB1zjkD8cyhWtwaGW/bzlyTjTRkQut
         6zPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719847442; x=1720452242;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yezdg1XlqV8Yo4K0h4GGfdcfBEBFo+YRjw2vEwlYTKk=;
        b=XlQ8sZjA4uSKaeGGLmjQInfij4H4yQZ1YEvenRgVVC4j6sexAhaJnEC4LBIG5zIWGq
         LFB/m5MK8fJOZqBHAARusy7xgY8oRr/WsnnuiFx0nuTyyVaXhmR1egt0P59sT6gg/tLL
         lzBhA5ah0ea/Lr/EGKMK3FTg5j1SjuKqsULLYXh+tCMjRWV+268Qn8AcYcF0I7GEm4Yb
         hcqVOur676i26PtVFMuKl53aYEF4EGw4TOFfVGj+7LuybOywcWX4grRv8nSm09K914nZ
         rbt7S5HMoocvgaPMquaNNIufmKktRjC9vLsuTjxgqrc/8qmU5CsQHlLx+K+DlSYgD868
         QVDg==
X-Forwarded-Encrypted: i=1; AJvYcCUkhAg4zNEAKJryWQI1zSK7DbV5Pgz/+65d1XO9J5s7fteJXQYndfcsuCNKhsSt/ZhKZs1v4jGDL7QNJT8vs++352gA
X-Gm-Message-State: AOJu0YxGY85JYb975y/g5cmj0HSjJqKXZ3UXx5phZlrUXAzvo7yc1ZH1
	6ST3mQgVfNm+BNx5Y54cmnogJiwl15PcVFVpzp1IpTCyS9xll/1C
X-Google-Smtp-Source: AGHT+IGT/gO2OnhrdO/tCpnpnibnf3kBfo6U1uwHO6md70PV2CqXJM9XET/zQmYUtFFLHkHmYyCcpg==
X-Received: by 2002:a5d:64c4:0:b0:35f:24dc:ad97 with SMTP id ffacd0b85a97d-367756cec68mr4844058f8f.34.1719847441616;
        Mon, 01 Jul 2024 08:24:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd784sm10396343f8f.7.2024.07.01.08.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 08:24:01 -0700 (PDT)
Message-ID: <6d5b75a6-639d-429b-bd37-232fc6f475af@gmail.com>
Date: Mon, 1 Jul 2024 16:24:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] setup: support GIT_IGNORE_INSECURE_OWNER environment
 variable
To: Junio C Hamano <gitster@pobox.com>
Cc: Florian Schmaus <flo@geekplace.eu>, git@vger.kernel.org,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jeff King <peff@peff.net>
References: <20240626123358.420292-1-flo@geekplace.eu>
 <20240626123358.420292-2-flo@geekplace.eu>
 <9e5b0cc6-e28c-4c51-ab48-663c61c00ee3@gmail.com>
 <72e42e9f-5b85-4863-8506-c99d658d7596@gmail.com> <xmqqa5j71snb.fsf@gitster.g>
 <5742e728-a012-4960-a32d-bf3b65c3a2e3@gmail.com> <xmqqpls2v1zx.fsf@gitster.g>
 <27cadffb-ca3f-487d-86b7-3508c45c446d@gmail.com> <xmqq7ce96mix.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq7ce96mix.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 28/06/2024 17:48, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> I think doing this would be more helpful than updating the
>> documentation to recommend adding "safe.directory=.". If we do this we
>> would also want to convert "//" -> "/" in the config keys as we've
>> been forcing users to add paths like "/srv/git//my-repo" if the
>> --base-path argument to git-daemon ended with a "/"
> 
> OK, so the idea is to normalize both safe.directory and data->path
> (which might come from either worktree or gitdir) and then look for
> a match.  path needs to be normalized because it can say '.' and
> '/srv/git//my-repo', and values of safe.directory need to be
> normalized because the users may have written '.' --- oops, relative
> to what directory do we normalize safe.directory values?  That would
> not work.  Let me retry.
> 
>   - Compare entries of safe.directory with data->path literally
>     without normalization, as the user may have written in the
>     configuration "safe.directory=.", expecting that data->path to be
>     '.' (the git-daemon use case).

I'm not sure this is a good idea because it is not clear which directory 
the user wanted to mark as safe when they added a relative directory to 
safe.directory. In the case of git-daemon one needs both the absolute 
path to the repository and "." to be present in safe.directory so we can 
ignore "." and match the absolute path.

>   - Normalize entries of safe.directory and data->path and then
>     compare them, turning path="." (the git-daemon use case) into
>     "/srv/git/my-repo" and a safe.directory entry "/srv/git//my-repo"
>     user wrote into "/srv/git/my-repo", so that they match.

We have several of normalization functions available:

  - normalize_path_copy() does a textual normalization which cleans up
    "//", "/./" and "/../".

  - absolute_pathdup() which prepends the current directory to relative
    paths attempting to use $PWD for the current directory where possible
    but does not expand symbolic links and does not clean up the path
    passed to it.

  - real_pathdup() which expands symbolic links

One way forward would be to clean up the entries in safe.directory with 
normalize_path_copy() and compare them to the result of normalizing 
$git_dir with absolute_pathdup() followed by normalize_path_copy(). That 
will ensure that we're always comparing the safe.directory entries 
against an absolute path and both sides of the comparison are textually 
normalized. I'm not sure whether we'd be better to use 
absolute_pathdup() or real_pathdup() or if we'd be safer comparing the 
output of both against safe.directory if they give different results. If 
this sounds reasonable I'll try and put a patch together later this week.

> Or we could treat "." on safe.directory as a synonym for "*"
> (i.e. "anything goes"), and compare all other cases only after
> normalization (which would save the cost of "literal" comparison for
> safe.directory entries that are not ".")?

Having more than one way to spell "*" sounds confusing. Assuming "." has 
only been added as a workaround for the current limitations in our 
safe.directory comparisons I think we'd be better to ignore it.

Best Wishes

Phillip

> I may have missed some corner cases, but either of these would
> probably work.
> 
>>>    * For "http-backend" invocations, we should think about potential
>>>      additions that would help users, similar to what I listed above
>>>      for "git daemon".
>>
>> That sounds sensible.
> 
> OK.
> 
>>> Having said all that, I do not think I mind GIT_SAFE_DIRECTORIES
>>> that is a ":" separated list of paths that is honored just like the
>>> multi-valued configuration variable safe.directory.  Once an
>>> attacker can influence your environment variables, it already is
>>> game over, so trusting it does not make the attack surface any
>>> worse.
>>
>> Indeed in that case the attacker can influence the path that we read
>> the protected config from by setting $HOME (and do far worse by
>> setting $PATH)
>> ...
>> Yes having to set all the GIT_CONFIG_* variables can be rather confusing
> 
> OK.
> 
> So an independent effort may be to introduce the said environment
> variable, and have it split at ':' and feed into the same machinery
> used to check paths against safe.directory configuration.  It may
> need a minor refactoring to lift the current comparison logic that
> assumes it is _only_ driven by the git_config() callback, and we
> would probably want to define how these two sources of whitelist
> entries interact (who overrides what, is "an empty element clears
> all the previous entries" still true, etc.).
> 
> So, I think we have three actionable items here.
> 
> Thanks.
> 
> 
