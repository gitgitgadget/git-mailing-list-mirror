Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DEC266EEB
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 10:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107363; cv=none; b=VI9HtjP0wBKseuoMLkCzeALe0/EqBz1wnKugbcbrukSF/qVNsDzhvSw2HPuVdfImO3YLEmogRBAJSCR5QBzoYwcCzO+TQi288g8WyQPcyDAA/1kTd3bw3YUM9OLKQ7KSOKqr4XbbL3xVir5X4ylZe8VrxWVIXPXqUqCtOnS9NkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107363; c=relaxed/simple;
	bh=j3yQgTU6jsanZ86LxqxgLqHFLGS+yIOO6e1GFrH8o6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T7ZM/6L3iGRjozZKWkKvDzWtiGoDTEiRb+7TjQMdvdS7+Fqy5Xo3GS1I9qZCNKkj5rWOIcsnqPBerc/LgDKyVK6vZF5dzE5hcJM5MNmjWCrnJYLuixJQ5xwiV7XxAQ49nBc1H9j2DaFAspTsxXOMoQg4Gcu3sYXncWfno9x8St0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aInmiLjb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aInmiLjb"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so36955265e9.1
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 03:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744107360; x=1744712160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xwZBv9z9paT+l3pf111Vj1AZ6tZGapLDRrPS6kxhJXk=;
        b=aInmiLjbLwhyT5Ul+n0Vkwe1lX5zorDnnLhvEjWbr10o27/riCM6dYwLDOu6XVbciN
         Znw3o0j+L8Dd9r4oIARx1Y31m8Zi0EbLYnbBfI2V5X0kW0K4f6qMrlkKp/6LYWvt9gEE
         xhAFBQCA77KR9vnhmPXWnNVwvfw+NXtVn1t0xJ8Gf4ANelhIjxFV1ERg8PheT+xpdS2y
         ZVwnKdUFeYOi8O3IohWjBu1DV3C6O8zcp8ga656gIQ1bBcqRUub5l29LnX6Zbp2KgEP2
         bl5I4IrTAfMgZ0EXx9yBv3c3Lq+MZN5Hu7Doo9pTGsMS23V6eWCqTjZCKHWS/ci2Sb+l
         cbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744107360; x=1744712160;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwZBv9z9paT+l3pf111Vj1AZ6tZGapLDRrPS6kxhJXk=;
        b=ZIolfFzmw+6VNRq0glVCb1LXQvQ30dGuIg5uOCDw1u5djKT/00Y/4gEvonQX6goPYO
         T+IJ5aXacAVkfP0w2UPSb3rb3tCfS53KJkItA7xxXJewJwJGqvbtpfZgUFqdaw1M4Y4c
         L0T2fd5S5NNzhkEBWjGgPrUb9LTO9Pl2XT6CGGYiwOUyb5FXyrry406OF+QO2mUirjLC
         6yn+aMypWeI/6G1yVLdDGZQhcK3V9shUEwj+yLKPsnEpcZF2kNur6GXO0RL/hSraEdHm
         hs8JiReOAdlxFvHFpfn3ad+c8Ov0R8ac5rTCzf+PEWhHMpkvfVBqVbQkQ7SZaavAK9gK
         uiMA==
X-Forwarded-Encrypted: i=1; AJvYcCWsI5hfXwxy3YDk+c7UM194COQwqwTm/JrFN+p9MKeg4hhmaHN3WvCjx3ivNUHkJysOWxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6h9sA6zFXh6UO77Z1lCZItAQRpoN87I52wtfK5lw5Dkr82QeC
	O1sNdMDdDiEc3qp0r5fHJnweb3qBYMjxS5p7PPss2Hmkmrb+tqv07gEahg==
X-Gm-Gg: ASbGncso0ZsxPDnrHzABmsiXZ1QG8iRbaTHJDQkMNiuU2/mwans38/sa7qF+769/ikY
	iTHkWbF2kf5E4zOP5rx8/a5szZbFnwl4Z9IgHAYRmy9f1JdJlA5XNOozzRpPDHDX5RWYYvd6HN5
	z05H4B40pHXBVNBK0adoIFLaQCUqgy7aSHlpGRa3jiu1oBI888VN/sJ8K7PmdB/Bei1fW4YFyJF
	xPD8dOLDlJcRy232PyhWHsNToO3QttXdcsUes8lyEMbiaaU/2zlCnw0Z7+Zlk6YdLVvXd9LyOHt
	5b9ccUjq18z0I8YW5afyIQDWCSobsyaEPpTmSqDIvvsjnvqKuFCeHgkSVLTzZ/hEfoAdcEZ1nPi
	62K72mLoXEsDHir2HhbcajYmq0nw=
X-Google-Smtp-Source: AGHT+IF/TzqTVbZLdhtTepeC5IipUoMwnwNsmlIyvsXBbTLBUvlsKoK/Yzalt2ouIHzxzhJQEnOVhw==
X-Received: by 2002:a05:600c:1e0a:b0:43c:f70a:2af0 with SMTP id 5b1f17b1804b1-43ed0c50ab7mr166870785e9.16.1744107359880;
        Tue, 08 Apr 2025 03:15:59 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:efb:6e00:24f3:2d85? ([2a0a:ef40:700:a501:efb:6e00:24f3:2d85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c300969e1sm14594746f8f.10.2025.04.08.03.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 03:15:59 -0700 (PDT)
Message-ID: <240d1cab-b564-45ae-945e-cba621aa7562@gmail.com>
Date: Tue, 8 Apr 2025 11:15:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] rebase -m: partial support for copying extra commit
 headers
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1902.git.1744041163929.gitgitgadget@gmail.com>
 <Z_R6W_yjJEYuWo0A@tapette.crustytoothpaste.net>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <Z_R6W_yjJEYuWo0A@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi brian

On 08/04/2025 02:22, brian m. carlson wrote:
> On 2025-04-07 at 15:52:43, Phillip Wood via GitGitGadget wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>>      [RFC] rebase -m: partial support for copying extra commit headers
>>      
>>      This patch is largely a response to
>>      https://lore.kernel.org/git/Z-5rpWKAVPmz32jC@pks.im/ . I'm in two minds
>>      about whether we should consider merging such partial support but if it
>>      helps forges preserve extra commit headers then it may well be worth it.
> 
> I'd like to see command-line options to control this and ideally a
> configuration option.  Right now, we know nothing about these extra
> headers, including an expected format.  If a future version of Git (say,
> 3.0) adds a new header and the user includes invalid data in this extra
> header (which happens all the time with author and committer
> information), then 2.50 will propagate it on rebase and it won't be
> fixed until the user uses a version of Git that understands the header
> and can fsck it correctly.  That's not really great, since it means we
> can unknowingly spread corruption.

We could certainly add some way to make this opt-in if there is a desire 
for it and you make a good point about compatibility if we add a new 
commit header. I'm not sure I'd describe preserving these headers when 
rebasing as spreading corruption though as we're simply rewriting 
existing commits. If the user chose to merge rather than rebase we'd 
still have the same issues without creating any new commits.

> I am pretty sure that at $DAYJOB we'll need to have a discussion about
> whether we want to propagate these headers during rebase and I'm
> personally leaning against it.

My understanding is that GitHub has been using "git replay" for rebases 
and therefore copying extra commit headers since the middle of 2023 
[1,2]. The message I linked to in my original mail suggests that the 
"change-id" header is preserved when rebasing on GitHub.

> Why, you ask?  I've seen at least the following types of corruption:
> 
> * Missing timezones
> * Timezones with less than four digits
> * Valid timezones padded to more than four digits with zeros
> * Timezones which don't exist and never have (e.g., +1700)
> * Timezones which are so absurdly large that they push the date to a
>    year when nobody alive now will still be living
> * Date stamps that are larger than 2^64
> * Date stamps which are smaller than 2^64 but beyond the expected life
>    of the Sun
> * Extra angle brackets in the email field
> * Nothing in between the email brackets
> * Nothing before the email brackets (no name at all)
> * Names which are not UTF-8 but without an encoding header
> * Names which are not valid in the specified encoding
> * Emails which are not valid UTF-8[0]
> * Emails which don't meet the (ludicrously generous to the point of
>    being nearly unparseable) RFC production
> * Encodings which are not valid IANA charsets
> * Messages with no body and no blank line (just the newline at the end
>    of the final header)
> * gpgsig headers that include random non-ASCII bytes and control
>    characters[1]

Thanks for sharing that, it is an interesting list. On the subject of 
encoding I do think our documentation could be clearer that the encoding 
applies to all the headers as well as the commit message. As far as I 
can see it only mentions the commit message, not the author or committer 
identities but repo_logmsg_reencode() re-encodes the whole commit 
buffer. Out of interest do you think we could be doing a better job with 
fsck to pick up some of these problems earlier?

I think "git rebase" only cares that the author identity can be parsed 
by split_ident() which is fairly lenient.

> I see Patrick is CC'd here and I'm interested in his thoughts, as well
> as, of course, those of anyone else as well.

Yes me too

Thanks for your thoughtful and intereting reply

Phillip

[1] 
https://github.blog/changelog/2023-06-28-rebase-commits-now-created-using-the-merge-ort-strategy/
[2] 
https://github.blog/engineering/infrastructure/scaling-merge-ort-across-github/

