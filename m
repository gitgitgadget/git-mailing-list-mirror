Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF535BAF0
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743599261; cv=none; b=oVsufgWc1TTs/AXzTJeBYo21IemJ6nLZqWkZjmCQ0qlVRt/GC2x6TXp7SafpRZjJAyOohoSvX2SwhpsZuo6Pf3w4XH+fdjAP+7Ze0r2R4BxJ+Z1jFGa01kuSsVatWmwfDgXn3zCwk/wX6xcHhsmyh3uloLjH/Ncht5LvTVoCpn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743599261; c=relaxed/simple;
	bh=5tEpflyYVhHo7hNmlRkV6OfyGx7vvESxnolFB8Px7tk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:Cc:
	 In-Reply-To:Content-Type; b=R+AOLyXpQ1do9xrnjBgITBOJDEVKtmLM++MjUr1uYpV2KsDXCS+BOFYA9rdLVRR0f8K9MQpzapocNnTNOwWC2vnLJVL1x2GLj5a/4vbxniYtPyLzdX38L5IFv7GHZGeU5/SKxiJvXYrkYqGMeWXpKX0O6mTe7RW2xXmro8wC6gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hL0Z7ygd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hL0Z7ygd"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso32929445e9.0
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 06:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743599258; x=1744204058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dCQ2vfr/S+5aIkdoIFMH2bqbf/E9gDH0qT+rb+xdNhM=;
        b=hL0Z7ygdCh7N27ObTgTFtqlnkzgMSur+GdPIidZ3FaDgamCC8cLfKAcaGffT5bqKgb
         lJh2XVkLTffa2Wo6WpvyCLZPSqdW/aIgkzoZSQhh+gmxuJ1jGAWKHA0204RwfMWyc83s
         cJQpbol/3d5It06iJtxTpkfezktH/08ar4G61c56JAkhh+/1w05S4GJdl8KAUsLs8TDR
         gg5GsXGn4YJAKjA/+32/lP63Yz3hWvD2irG8LEYx2bCGJke9tu2t0mSEWMJ1tEtVSK7l
         PElQ74DgmEOGVJTtPL64IYlS6jtlr+Qk98JxzFQ4/9npqFAa68loIjjm4trNsRaF6hKx
         jtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743599258; x=1744204058;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCQ2vfr/S+5aIkdoIFMH2bqbf/E9gDH0qT+rb+xdNhM=;
        b=FT4nHatCyUmGhE7yeMsRFiBvHcXcC29BOZ1ssrO//k9+zL5jBNbA07ZUT1hWPVFW/M
         AreESS6pem4RjXtkmXZG3XIFtwKEDh1Yn444FQjSjObzYYLAatkXStmHb8cUMYb9/hd0
         6IzPO3E7japQbLSQh4uKlFK+gi20hbxtJW9lbH1Yf5L52SLfsMkUqjO8FT/1XJ13XOWS
         6AZux176iV+CaIhxCv8+izDvDzVeGKgr6j5efnGSXlgmra8L2lrycgjiHcLluwUYMaYJ
         OcztDs6p747ca+/2xCQQaCSfRgFh7+izoHaUmFFFLfAnt3FqBSt177U3AqL/8aLF3Y4G
         JnQg==
X-Gm-Message-State: AOJu0YzX1BaUgU5+LPASGkb8zNZskYdloaff/DuYudzClMzxCV7nQGdH
	lv0lSLArq723ajmVJW+nMTirz0Pb9twzeyPim92C183mv/m10gVV
X-Gm-Gg: ASbGncvOEeXo/fQqdCcV1KtczbRucaU6lwIHPs4qMnrHM6FG7Me1hZeUXmrqoxrXMvu
	aRBFQhMICy2wVkqNqLXQ0E0nV6B+wGIv9+0z7Y/EISm/dnZVpZaL/fia9XSG1Watry9x5h7ZY6M
	49WFTPhrNjg7+ce1qypnAYQUXmmdJ4oDOSyiCxXbX48xSbEodfsqBlxmZg3Bwdc4iLmdFd7qJE7
	IDYfA+4y/vdbukR27RlzCwcUAfJ+b6ccF63tHgAbVkyZTPR40btKlwSPwpaKw2FnN+7h4XCNffm
	TbtiDF5KHQqfJFdDm+kZoVOCY2h5mutjQkF1Ys6ig/u8sm8Rw+6vL4SvASLeSYN9owZt3/9C1HD
	dkwNy0kin3EPdWTAem2SF
X-Google-Smtp-Source: AGHT+IFQ8x2BbA1z7WGb38XIkDlGNRzTCdDzwPoBa6cWyN9mbGVlvUrlyaKXI7fxc9D8hido7ZvdFA==
X-Received: by 2002:a05:600c:1f18:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-43ea7cdf2dcmr53300595e9.28.1743599257627;
        Wed, 02 Apr 2025 06:07:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43eb5fd0a46sm20767015e9.9.2025.04.02.06.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 06:07:37 -0700 (PDT)
Message-ID: <494c9e59-b7b2-4a1c-ad41-3a7fc72503c9@gmail.com>
Date: Wed, 2 Apr 2025 14:07:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4] blame: print unblamable and ignored commits in
 porcelain mode
To: Karthik Nayak <karthik.188@gmail.com>
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
 <20250330204339.191382-1-karthik.188@gmail.com>
 <72b19ccb-a6a8-4aca-b70e-b879ec15cff1@gmail.com>
 <CAOLa=ZSQ7PiasRk23Hxp7Gk5vU-x83N4e4WTxG3eVsxK0zKnWA@mail.gmail.com>
 <f39c6468-aade-489a-bc7b-c3d342a22cb8@gmail.com>
 <CAOLa=ZQMYn2eYndX0saTKnuzAacjtNZeTb9PCrcNC50nneAq5g@mail.gmail.com>
Content-Language: en-US
Cc: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <CAOLa=ZQMYn2eYndX0saTKnuzAacjtNZeTb9PCrcNC50nneAq5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[Restoring cc to the mailing list that I accidentally dropped in my 
previous message]

On 01/04/2025 17:57, Karthik Nayak wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>> On 31/03/2025 16:25, Karthik Nayak wrote:
>>> phillip.wood123@gmail.com writes:
>>>> On 30/03/2025 21:43, Karthik Nayak wrote:
>>>>>
>>>>> +for opt in --porcelain --line-porcelain
>>>>> +do
>>>>> +	test_expect_success "mark_unblamable_lines with $opt" '
>>>>> +		sha=$(git rev-parse Y) &&
>>>>> +
>>>>> +		git -c blame.markUnblamableLines=false blame $opt --ignore-rev Y file >raw &&
>>>>> +		sed -e "s/^\ty3/unblamable\n&/" raw >expect &&
>>>>> +		cp expect raw &&
>>>>> +		sed -e "s/^\ty4/unblamable\n&/" raw >expect &&
>>>>
>>>> Thanks for improving the test. Unfortunately using '\n' in the
>>>> replacement text is not portable [1] (the normal backslash escapes are
>>>> allowed in the pattern though so the '\t' is fine). One has to write a
>>>> literal newline escaped with a backslash. However here we want to insert
>>>> a whole new line of text into the output without changing the original
>>>> so I would write it as
>>>
>>> Thanks for bringing this to my notice. I didn't know.
>>>
>>>>        sed -e "/^\ty3/a\\" -e unblamable -e "/^\ty4/a\\" -e unblamable \
>>>> 	raw >expect
>>>
>>> This appends 'unblamable' to the next line, but we want to prepend it.
>>
>> Sorry, I misread the original. If you use 'i' instead of 'a' that will
>> insert a new line before the current one.
> 
> Seems like this won't work either, since MacOS complains [1] about it:
> 
>    expecting success of 8013.16 'mark_ignored_lines with --line-porcelain':
>    		sha=$(git rev-parse Y) &&
>    		git -c blame.markIgnoredLines=false blame $opt --ignore-rev Z file >raw &&
>    		sed -e "/^	line-one-Z/i\\" -e ignored \
>    		    -e "/^	line-two-Z/i\\" -e ignored \
>    			raw >expect &&
>    		git -c blame.markIgnoredLines=true blame $opt --ignore-rev Z file >actual &&
>    		test_cmp expect actual
>    	
>    +++ git rev-parse Y
>    ++ sha=e0d35d6f2d5fab63267e58d684cea1ECG86f12b1
>    ++ git -c blame.markIgnoredLines=false blame --line-porcelain
> --ignore-rev Z file
>    ++ sed -e '/^	line-one-Z/i\' -e ignored -e '/^	line-two-Z/i\' -e ignored raw
>    sed: 1: "ignored
>    ": command i expects \ followed by text
>    error: last command exited with $?=1

Oh, that's a pain, I thought it was supposed to treat each '-e' as a 
separate line.

> I did have success [2] with using a heredoc instead:
> 
> 	cat > sedscript <<- 'EOF' &&
> 	/^	y3/i\\
> 	unblamable
> 	/^	y4/i\\
> 	unblamable
> 	EOF
> 	sed -f sedscript raw >expect &&
> 
> What do you think about this?

I think that's the best way then. We could pass a multiline string with 
'-e' but then we wouldn't be able to indent the "unblamable" lines.

Best Wishes

Phillip

> [1]: https://gitlab.com/gitlab-org/git/-/jobs/9581456879
> [2]: https://gitlab.com/gitlab-org/git/-/pipelines/1746265204

