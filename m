Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F594D9EC
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706785039; cv=none; b=I1qPlWD4ojtBS8h/OIHN9Y+DyxALaWAZzkcwstcXXNmgu5eVOrXxtnAOweNKE+4DiDHdf1yJ1WdChhv5p/vH+ScHNRWMGAuzNISXU5rHlGDWItMc6XRHTSn5PuDU5r9RwBqCmr4HPYaSQ3KWBDdg+GED9iRVisi1SAr8lApMq0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706785039; c=relaxed/simple;
	bh=Pczn+cWE8GiN6BebY+wGIyN+fURC8vWJuDNJR1qmqRA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kuT2j/44za2lX+gxE15NW52i05h8BauvNnHgoFkytjJuDpSgzhtSJ3t1BtpKBEUGiTp8z90b0HbGIq4L/+9/r+DHha4cFMcd4HSxN7Sbv4pgiT2dx2WI/4ajzjtQ5ONhgPrXHE9Mn368CTb4+3/hi78RStvsDX5yH17AWD7i+0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfS8lI8E; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfS8lI8E"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33b17ff9a78so209917f8f.1
        for <git@vger.kernel.org>; Thu, 01 Feb 2024 02:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706785036; x=1707389836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w7/PitkPQp8D1fHfTlEBo9Xoh+xOeSx7C8WpDeHWmRw=;
        b=CfS8lI8EDPo1My5NfNzX7yXpjJ4UqNY0drkYAFbVIMTb/+2BAsFe0ywQXIMcUdtKHY
         MPH1860mGgHIdN3N4sI2ttzxHY+J90oVh9/e8uQUgBX59qowXiCNcGtfb4nujYlsUMb0
         xwMGRfvTqDBaPWmQ5TExh4J4I+2qSglTu/8rnS94vuNR/lHIHjEzqi9OHYYK9LX6sM7K
         HUnBRHHzdv2d5tuXkUklTESr6AJxe6EIuizwAzta+lF0KqZm/lR3ckXUs/TAF64H3VF9
         xv0cieN+ukzLn8gWgJnu7l4am/O1UsOlDYFPWlKgt/nyx9fBlWeq0dQ0sqfM7l/VEyXe
         4ZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706785036; x=1707389836;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w7/PitkPQp8D1fHfTlEBo9Xoh+xOeSx7C8WpDeHWmRw=;
        b=OXY3GX36qL6J+2KzCzN2qSsVOhjqsVbFNY8fOsvF0Zr9Ft1O6HhbP+ZeC7Bje84Szb
         MUvDiMul103rDaMoXqF7ZQIhcHLyJrQCV5E9lW88XqwsLuH+IJLgWDhzDZzv+V1U82LJ
         Km4+eFFU4oxbENv1S+bwswQnXZjxxYuxI6y2Tqo7xCsifU1/BWZxson2bFhfJqh7z/Ol
         V7WsMkgpKRmgbvjxgQGcU1PLsNCJdFFTZfRQUhiLs8MKmAy70Q+butxG/eMzPwlNFjTm
         IpU2hBhrycL5yLbUYGlF8g/73UfQ4tjlorwv3kmuhFGjaCBaa+1EZ1z5B68D7JhcAvxp
         OkPA==
X-Gm-Message-State: AOJu0Yzcoj1LjSAhuliutjaEE9NMq6fvQ18Cbqw5RbcTUetQBkXr9lX0
	qIdgRXgPNlpXUU8/yp4BVD/Dho/GeKWY9Z0iB2/dsEwxbvgL5gGx
X-Google-Smtp-Source: AGHT+IFznZffZzSC4Hu0OAdfGEBUTK+2dIEL6WgzBI251G1w4zl/HwNon//OgL+eQU7VnLkfz18z6g==
X-Received: by 2002:adf:f248:0:b0:33a:f27b:7fc1 with SMTP id b8-20020adff248000000b0033af27b7fc1mr1361008wrp.31.1706785035630;
        Thu, 01 Feb 2024 02:57:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUYsn4k6X/QVsbyCw0fp2CU82DPXdaio2l0QKxTz/GsNewRpzqWPDj8T1J5w5+ZPmaDZaUn2LvBNqJvFmK1BBosaVp0xpgDHb1/ji10BbQWRNjJOXoA0vt7SXfR9a1wZoWYhF0TSB/SJpm67O0Gp+d4qMvds3iy7CBMUQ2mBF6SBg==
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id z7-20020a5d4c87000000b0033af9b7db6esm6941658wrs.22.2024.02.01.02.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 02:57:15 -0800 (PST)
Message-ID: <8ff4650c-f84f-41bd-a46c-3b845ff29b70@gmail.com>
Date: Thu, 1 Feb 2024 10:57:15 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/4] sequencer: Do not require `allow_empty` for redundant
 commit options
Reply-To: phillip.wood@dunelm.org.uk
To: Brian Lyles <brianmlyles@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com, gitster@pobox.com
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <7229fe62-cf9b-4829-80ec-c6b44c52163e@gmail.com>
 <CAHPHrSeKY2Ou9VCq6rtADTOwycc0KCTPaCCwtqf94yLi0wj0OQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHPHrSeKY2Ou9VCq6rtADTOwycc0KCTPaCCwtqf94yLi0wj0OQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Brian

On 27/01/2024 23:30, Brian Lyles wrote:
> On Tue, Jan 23, 2024 at 8:23 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 19/01/2024 05:59, brianmlyles@gmail.com wrote:
>>> From: Brian Lyles <brianmlyles@gmail.com>
>>>
>>> Previously, a consumer of the sequencer that wishes to take advantage of
>>> either the `keep_redundant_commits` or `drop_redundant_commits` feature
>>> must also specify `allow_empty`.
>>>
>>> The only consumer of `drop_redundant_commits` is `git-rebase`, which
>>> already allows empty commits by default and simply always enables
>>> `allow_empty`. `keep_redundant_commits` was also consumed by
>>> `git-cherry-pick`, which had to specify `allow-empty` when
>>> `keep_redundant_commits` was specified in order for the sequencer's
>>> `allow_empty()` to actually respect `keep_redundant_commits`.
>>
>> I think it might be more persuasive to start the commit message by
>> explaining what user visible change you're trying to make and why rather
>> than concentrating on the implementation details.
> 
> I struggled a bit with this initially because the motivation behind the
> change in this particular commit was driven by a technical issue in my
> mind. The side-effect with git-cherry-pick(s) `--allow-empty` and
> `--keep-redundant-commits` was mildly problematic, but less concerning
> that the future problem that we'd have once git-cherry-pick(1) got the
> more robust `--empty` option in a later commit in this series.
> 
> I think my problem came down to this commit trying to solve two problems
> at once -- the underlying technical concern _and_ the git-cherry-pick(1)
> behavior.
> 
> In v2, I intend to break this commit into two:
> 
> - Update `allow_empty()` to not require `allow_empty`, but without
>    actually changing any consumers (and thus without making any
>    functional change)
> - Update git-cherry-pick(1) such that `--keep-redundant-commits` no
>    longer implies `--allow-empty`.
> 
> This allows me to better justify the technical change technically and
> the functional change functionally, while also making it easier to drop
> the functional change if we decide that a breaking change is not
> warranted to address this.

That sounds like a good strategy. I'm wondering if we should not change 
the behavior of `--keep-redundant-commits` to avoid breaking existing 
users but have `--empty=keep|drop` not imply `--allow-empty`. What ever 
we do we'll annoy someone. It is confusing to have subtly different 
behaviors for `--keep-redundant-commits` and `--empty=keep` but it 
avoids breaking existing users. If we change `--keep-redundant-commits` 
we potentially upset existing users but we don't confuse others with the 
subtle difference between the two.

>> Do you have a practical example of where you want to keep the commits
>> that become empty but not the ones that start empty? I agree there is a
>> distinction but I think the common case is that the user wants to keep
>> both types of empty commit or none. I'm not against giving the user the
>> option to keep one or the other if it is useful but I'm wary of changing
>> the default.
> 
> That practical example is documented in the initial discussion[1], which
> I should have ought to have linked in a cover letter for this series
> (and will do so in v2). I'll avoid copying the details here, but we'd
> very much like to be able to programmatically drop the commits that
> become empty when doing the automated cherry-pick described there.
> 
> [1]: https://lore.kernel.org/git/CAHPHrSevBdQF0BisR8VK=jM=wj1dTUYEVrv31gLerAzL9=Cd8Q@mail.gmail.com/

Maybe I've missed something but that seems to be an argument for 
implementing `--empty=drop` which is completely reasonable but doesn't 
explain why someone using `--keep-redundant-commits` would want to keep 
the commits that become empty while dropping the commits that start empty.

> [...]
>> Thank you for being clear about the change in behavior, as I said above
>> I'm wary of changing the default unless there is a compelling reason but
>> I'm happy to support
>>
>>       git cherry-pick --keep-redundant-commits --no-allow-empty
>>
>> if it is needed.
> 
> I totally understand being wary here.
> 
> I've certainly convinced myself that having the future `--empty=drop`
> behavior introduced later in this patch should not imply
> `--allow-empty`.

I agree with that

> I also _think_ that the existing behavior of `--keep-redundant-commits`
> is probably technically not ideal or correct, but could be convinced
> that changing it now is not worthwhile. I will defer to group consensus
> here.

There is definitely an argument that the existing behavior conflates the 
two flavors of empty commit. I think one can also argue that the 
conflation is beneficial as most of the time users don't care about the 
distinction when using `--keep-redundant-commits` and so it is not worth 
changing the behavior of the existing option.

I sounds like you've got a good plan for v2, I look forward to reading it.

Best Wishes

Phillip
