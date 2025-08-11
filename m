Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784AFC148
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 13:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918150; cv=none; b=VE+GED7lwCDzI/GpDDJQvO/Mo5nx87Q3TLNY40djbzcnK9vaasdO2xEiH3UYCBSP6LPEJBkA+RRR5LavITeIGw3ojduOgu4q87eF2C7kx+QgKBzuG8ZC7zqwa7uNZvYTndc4tcLE7GHEwrNeF9dl1PmrlzEIOSNmPPpijDNhfUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918150; c=relaxed/simple;
	bh=rFvWnkmHhA5Zmhfckv6l5015VQGK24WfpDGV5/4YTcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HajODmKhcjOHajQFn9GGTax0FEAR4miw19hi8OgHyKlzKWRQFw9sJxHW7NJgiadp3NzuPnCOKeDgITBIxQMa6WJbh3eP85pQSVk7UKz1hBI0WlswHl5Z0AQX/vLeLQWMdqpggyvEo/GsEiQyuAD6BTYAc2nUu9pdfT0AIH8U1J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mx+ty5oh; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mx+ty5oh"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b8db5e9b35so2658445f8f.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 06:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754918147; x=1755522947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y4G/sG8Vg0xd3UbnMx5h25Hx+xJQdy7/ZtywzI4TqK8=;
        b=mx+ty5ohiDHAS5SUxGUlL+PkJOJ6IGgceYAk8oOol2AgW9OiQd0vjDN+ECaBGQQ3Tp
         mg/ywVXG+0SZgcrF+f4oL91QuV4BB8ok4M1ajhhjHlHQJlLP0HTRDR1tgvOBt0UJx8uI
         JXs0bPVQcAaCL5YlkgpnLXPCtNNT1anLjzNBIc3zUi8HRsW5EJ+h3FyODCXmuimQv/lv
         JlcwWj9rjyoOgnxzpv3jkkLGqNLgeqBqJhtBqc4Gm7JZC2SAKn0X0ZfM/xkvGI+tZLWB
         BMyy9htRtpCacjLZOw4qg2/JJoV6LXSaAhz8glR92tsxWZ3ZHfdYiu0tGvNeBwcubxBk
         Un8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754918147; x=1755522947;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4G/sG8Vg0xd3UbnMx5h25Hx+xJQdy7/ZtywzI4TqK8=;
        b=XFFJPBBgJkZqynMP2qF1AexIFQdMtEI88q5oLy2p/ktirHBbJJ8MaDiWwYACFotlne
         X99wDYccNXyM5ZnrpA6Xuha+BRyKzvxWGBYQ2lAcH96EWnwfQlVZfrV1PZsOydLRLYKa
         wLmVjNg5VObUsF7E6lO1/AySk1Wow57GsXfHw8FON5YycQkjXARitjEZ+U4GEpVS/4NJ
         FdG87Ee8izSlz67YXhB3OySAmeslu5BQtI301xs5w3G7ZErQ/zGRdNTUGO3yst48jdXi
         9GJfq1QUhN/8SLgPkMTID5jfeZYVzNtM8Fil9uX0jz0FJgM6qwHPpbuEFe+LbyvdIBzg
         TI2g==
X-Forwarded-Encrypted: i=1; AJvYcCWsvSXbo9xpHvGC+9NRoS/raQi0U/GtZxsw/djHF+HKRcX5vsfwb6/F7pDGyD4FWJQu7oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqwdCoendHQzIXGigy4b0/xScc9q5DVJVRGBYhFxjue0QTziAA
	gqH6CLLdcBisjxcmyts7XGEeWZ3JM6vYLfI71P/whhc5B+N6Vxck6UVy
X-Gm-Gg: ASbGncuCcGxmCHU/szv0C+D7ay8W2y7YoP5xg2lqcW1f7zUMB/Moo6gusY0+YgyMBC0
	2aLJg0YN5Fy7bRo1seKBcf8RKzcaevyMoOxZmeXOQMCqjDC1N0t4UmxaVmW1kjDQ0xRIxlWmz2z
	Gb5T4swY4nesI2/ZCZgeCk86NuBlvnj5cQph0Pvoq2JQab3JbE/ffHbg7J+NV8puGvkCJrS/yAZ
	MnWYICEmeaKwO2bi1BNzzFu82kFWJtDU2dRQ9Nyhn0K6BtrGPg3YnMi7OaSX2iKoYQyVSUkeURC
	IW2Y95QRqw/VfEIvAu9Yq/C276K6o5+odzCP0dWfhSbXqzRWClfahN5fhJ4ntAy48B2elW1PX71
	DUWCxpBQi+FK60MaeBQZwRwq1DOJsNT8pbRaKEnT80qH3Xnx5aR05Umbvtv18arIXfWSvIkr3vK
	88qDNmZp8=
X-Google-Smtp-Source: AGHT+IFZXRAaOSD5lJhsEYjPZ7QsifWxC9M1aHto8bDSIBk/yvFrJl+dwS6QAFzBtWG7LbevsC60YA==
X-Received: by 2002:a05:6000:2410:b0:3b8:ffd2:6745 with SMTP id ffacd0b85a97d-3b900b51264mr11145808f8f.44.1754918146509;
        Mon, 11 Aug 2025 06:15:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:9bd8:62f6:3085:6ee3? ([2a0a:ef40:7a5:4701:9bd8:62f6:3085:6ee3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e054036bsm30945717f8f.31.2025.08.11.06.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 06:15:46 -0700 (PDT)
Message-ID: <4e2e2bea-c8e5-4343-9e70-a2bd139eb242@gmail.com>
Date: Mon, 11 Aug 2025 14:16:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] git-jump: make `diff` work with filenames containing
 spaces
To: Greg Hurrell via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Greg Hurrell <greg.hurrell@datadoghq.com>
References: <pull.1950.git.1754674979929.gitgitgadget@gmail.com>
 <pull.1950.v2.git.1754913323810.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1950.v2.git.1754913323810.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg

On 11/08/2025 12:55, Greg Hurrell via GitGitGadget wrote:
> From: Greg Hurrell <greg.hurrell@datadoghq.com>
> [...]
> 1. For file "foo", Git will emit "foo".
> 2. For file "foo bar", Git will emit "foo bar\t".
> 3. For file "foo\t", Git will emit "\"foo\t\"".
> 4. For file "foo bar\t", Git will emit "\"foo bar\t\"".
> 
> Before this commit, `git-jump` correctly handled only case "1".
> 
> After this commit, `git-jump` correctly handles cases "1" and "2". In
> reality, these are the only cases people are going to run into with any
> regularity, and the other two are rare edge cases, which probably aren't
> worth the effort to support unless somebody actually complains about
> them.

Thanks for updating the commit message, I agree it's probably not worth 
worrying about cases 3 & 4 unless someone complains

Thanks

Phillip

> Signed-off-by: Greg Hurrell <greg.hurrell@datadoghq.com>
> ---
>      git-jump: make diff work with filenames containing spaces
>      
>      Changed since v1:
>      
>       * No code changes, but reworded commit message to include examples of
>         quoted paths.
>      
>      Turns out that quoted paths never worked, so this commit isn't "robbing
>      Peter to pay Paul", but rather, "giving something to Paul for free
>      (Peter, sadly, is still out of luck)".
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1950%2Fwincent%2Fstrip-trailing-tab-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1950/wincent/strip-trailing-tab-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1950
> 
> Range-diff vs v1:
> 
>   1:  afe01c156e5 ! 1:  03fa9ac1ab2 git-jump: make `diff` work with filenames containing spaces
>       @@ Commit message
>                                strchr(line, ' ') ? "\t" : "");
>                        break;
>        
>       -    That is, for a file "foo.txt" we'll emit:
>       +    That is, for a file "foo.txt", `git diff --no-prefix` will emit:
>        
>       -        +++ a/foo.txt
>       +        +++ foo.txt
>        
>       -    but for "foo bar.txt" we'll emit:
>       +    but for "foo bar.txt" it will emit:
>        
>       -        +++ a/foo bar.txt\t
>       +        +++ foo bar.txt\t
>        
>       -    This in turn leads us to produce a quickfix format like this:
>       +    This in turn leads `git-jump` to produce a quickfix format like this:
>        
>                foo bar.txt\t:1:1:contents
>        
>       @@ Commit message
>            This commit takes the simple approach of unconditionally stripping any
>            trailing tab. Consider the following three examples:
>        
>       -    1. For file "foo bar", Git will emit "foo bar\t".
>       -    2. For file "foo\t", Git will emit "foo\t".
>       -    3. For file "foo bar\t", Git will emit "foo bar\t\t".
>       +    1. For file "foo", Git will emit "foo".
>       +    2. For file "foo bar", Git will emit "foo bar\t".
>       +    3. For file "foo\t", Git will emit "\"foo\t\"".
>       +    4. For file "foo bar\t", Git will emit "\"foo bar\t\"".
>        
>       -    Before this commit, `git-jump` correctly handled only case "2".
>       +    Before this commit, `git-jump` correctly handled only case "1".
>        
>       -    After this commit, `git-jump` correctly handles cases "1" and "3". In
>       -    reality, "1" is the only case people are going to run into with any
>       -    regularity, and the other two are extreme edge cases.
>       -
>       -    The argument here is that stripping the "\t" unconditionally gives us a
>       -    minimal change, and it addresses the common case without bringing in
>       -    complexity for the uncommon ones. If anybody ever complains about case
>       -    "2" no longer working for them, we can do the more complicated thing and
>       -    only strip the "\t" if the filename contains a space.
>       +    After this commit, `git-jump` correctly handles cases "1" and "2". In
>       +    reality, these are the only cases people are going to run into with any
>       +    regularity, and the other two are rare edge cases, which probably aren't
>       +    worth the effort to support unless somebody actually complains about
>       +    them.
>        
>            Signed-off-by: Greg Hurrell <greg.hurrell@datadoghq.com>
>        
> 
> 
>   contrib/git-jump/git-jump | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
> index 3f696759617..8d1d5d79a69 100755
> --- a/contrib/git-jump/git-jump
> +++ b/contrib/git-jump/git-jump
> @@ -44,7 +44,7 @@ open_editor() {
>   mode_diff() {
>   	git diff --no-prefix --relative "$@" |
>   	perl -ne '
> -	if (m{^\+\+\+ (.*)}) { $file = $1 eq "/dev/null" ? undef : $1; next }
> +	if (m{^\+\+\+ (.*?)\t?$}) { $file = $1 eq "/dev/null" ? undef : $1; next }
>   	defined($file) or next;
>   	if (m/^@@ .*?\+(\d+)/) { $line = $1; next }
>   	defined($line) or next;
> 
> base-commit: 2c2ba49d55ff26c1082b8137b1ec5eeccb4337d1

