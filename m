Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08FE42049
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743416700; cv=none; b=FvgmG5WeXrSgxL+ro8uX8YVm0N6AdysAqUBIZebRX6/qi/PuF8ERXzD01acBDgdQ85slPhVZbCp+xBkLyEHAj1TMozuDVUSUxT+LLUfD6f4vYIBoAOavHFMEevYk/C0pdLbbvCaZuJy/qi+sK7SocM7qY3xZ2vjD8rRi2GgwQ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743416700; c=relaxed/simple;
	bh=cwyab80DCRBQTD2cPCVV08a+ILTQ2JjHsqabFy5XDIc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bBYRWdkcLx9gVDnTkpvlzcAZpZUL7QTpKvVg6J+/HFhZwCYDwTDK2P1Hv4iyl73hD0skpKg4MuhfwUGpv0lB7UOpDoP+2J/XmGeeHr6SQggcuYkFYAKun4GWLdsWrIvRPztTm0oV0o06qDSalLqPG/69CMdJja8j5WgvdynRREM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayiXl7aF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayiXl7aF"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso565470f8f.0
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 03:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743416697; x=1744021497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kEPDSsF3yCCHY6FQSz3g3p5+WFyGep4LU2P69zIyubQ=;
        b=ayiXl7aFYYPUy2gMKfAXwqytmKv5T0uoLnqju2cN+4bO47gbCKsd+o+s0diOE0QDrW
         y2poFvpgtNxAs7eA/7B/mPKfTjmaMMtvDABQqS25Us01LvZHfy0XGJwuwLIYDS2iRcJn
         fMpewauu+AyHmdnGzN4BuRB2GHLs/zBpefDbx8lvjGKbjTL2sYFPHFOmn6VvAaL3HDS0
         97UQJv34PNrClwtBrgILSFx7dkAcvFAELgQbQ1vhPV8d2kONmmUiyanij52rtsh7onqL
         NMxNYWXJhvhf4zJBXabzGNOUw2p5OKyCHTaFzTKi7Gl7SRccv+IV6mg8BVvqlEP6FXGN
         j8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743416697; x=1744021497;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kEPDSsF3yCCHY6FQSz3g3p5+WFyGep4LU2P69zIyubQ=;
        b=XcTQKCB75z1DkH5NHhbxZf2q4n9ZOBP+OycYvKAolf+l/IvdSW4pD1/ByIPFr0Pl+r
         kBDacICU3CzuE8rRz4b/rS6ho4iCuyle7+sCC0sQxbTgFsYGKJqNpxGUu7BLNLChy57D
         lWN4mE5F2/G0KwQcNc9F97MOPXB/TM9MsZg62fjBOhHhcS/rETpErTOEdAwdkMc6Isgr
         OP2HmQ6WTGC4EOq1O7iTXkIq44LjVeFDH8GXV9BTDv9aG+0TRpQbDybc4pWsHYNNZamH
         3R7ojMZcq7BdVCg05LBlOmPrBx17LOQrTq8EjYAAkgQ4oXOf1g6PoW7EiEOUrBEwsavR
         l/jg==
X-Forwarded-Encrypted: i=1; AJvYcCWOck18ZIuvUn8QWyU4isHQeBDERT9Z8a0eLbGq6TpLAc/ZynThirkNnJcHEzggXBZLxoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCp5Vxkw7OwgWFXRSUAC6TTZU6hoQrdD8ZvSLceFgIfBhIkrDe
	nnxq3MT84tN472W9nLGIx5iQAItrJlcurLPIBH4kKUjmxb3RQluy
X-Gm-Gg: ASbGnctXS9SqD/x0PNEdcyGfKti/pitGosA23sBqeYovrZn05xYesrQYiOqjhnzPSfT
	Ky0QDpumNw02z/TFBMnyyonEWVhjFkXGxTNlhc5JlJeiRrLtDMablHqa6yYJARyrYA1qbQvN9qq
	C6unFRECLvEgHooZ2VftVKCgaUN6+PXEKReuu5eVkvMY/0rCga52cp5OL69eNa1f0QIsTYBfLr+
	BfxvPBG9mi4FNzN6wjDsxJ8RNqc2cLFbS1xSWEbLFsh7/CGevS0Db1TxHSnc63lOXNuxYqDkjPY
	RrlRELLddNLK5jRFLqG/UUvRoP0Pc25K936c7ipJNlETiqY3sCr+tK/IILhxPpFbLW+5MVAGnHP
	yzF3REof4jTJb8ym0haQ9
X-Google-Smtp-Source: AGHT+IFc6lKhzWO5RihXoa4uc8airygE/qqgeF62VraqXfnl2GhMDQVWiKxcbmJovyMOhI3Y2aFlhQ==
X-Received: by 2002:a05:6000:2407:b0:39c:1404:312f with SMTP id ffacd0b85a97d-39c1404345dmr5240832f8f.1.1743416696579;
        Mon, 31 Mar 2025 03:24:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b66cb3dsm11092856f8f.57.2025.03.31.03.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 03:24:55 -0700 (PDT)
Message-ID: <72b19ccb-a6a8-4aca-b70e-b879ec15cff1@gmail.com>
Date: Mon, 31 Mar 2025 11:24:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4] blame: print unblamable and ignored commits in
 porcelain mode
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chriscool@tuxfamily.org, git@vger.kernel.org, jltobler@gmail.com,
 gitster@pobox.com, sunshine@sunshineco.com, Patrick Steinhardt <ps@pks.im>,
 Toon Claes <toon@iotcl.com>
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
 <20250330204339.191382-1-karthik.188@gmail.com>
Content-Language: en-US
In-Reply-To: <20250330204339.191382-1-karthik.188@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 30/03/2025 21:43, Karthik Nayak wrote:
>   
> +for opt in --porcelain --line-porcelain
> +do
> +	test_expect_success "mark_unblamable_lines with $opt" '
> +		sha=$(git rev-parse Y) &&
> +
> +		git -c blame.markUnblamableLines=false blame $opt --ignore-rev Y file >raw &&
> +		sed -e "s/^\ty3/unblamable\n&/" raw >expect &&
> +		cp expect raw &&
> +		sed -e "s/^\ty4/unblamable\n&/" raw >expect &&

Thanks for improving the test. Unfortunately using '\n' in the 
replacement text is not portable [1] (the normal backslash escapes are 
allowed in the pattern though so the '\t' is fine). One has to write a 
literal newline escaped with a backslash. However here we want to insert 
a whole new line of text into the output without changing the original 
so I would write it as

     sed -e "/^\ty3/a\\" -e unblamable -e "/^\ty4/a\\" -e unblamable \
	raw >expect

Best Wishes

Phillip

[1] <https://pubs.opengroup.org/onlinepubs/9799919799/>

     The relevant section of the text reads

     A line can be split by substituting a <newline> into it. The
     application shall escape the <newline> in the replacement by
     preceding it by a <backslash>.

     The meaning of an unescaped <backslash> immediately followed by any
     character other than '&', <backslash>, a digit, <newline>, or the
     delimiter character used for this command, is unspecified.


> +
> +		git -c blame.markUnblamableLines=true blame $opt --ignore-rev Y file >actual &&
> +		test_cmp expect actual
> +	'
> +done
> +
>   # Commit Z will touch the first two lines.  Y touched all four.
>   # 	A--B--X--Y--Z
>   # The blame output when ignoring Z should be:
> @@ -191,6 +206,21 @@ test_expect_success mark_ignored_lines '
>   	! test_cmp expect actual
>   '
>   
> +for opt in --porcelain --line-porcelain
> +do
> +	test_expect_success "mark_ignored_lines with $opt" '
> +		sha=$(git rev-parse Y) &&
> +
> +		git -c blame.markIgnoredLines=false blame $opt --ignore-rev Z file >raw &&
> +		sed -e "s/^\tline-one-Z/ignored\n&/" raw >expect &&
> +		cp expect raw &&
> +		sed -e "s/^\tline-two-Z/ignored\n&/" raw >expect &&
> +
> +		git -c blame.markIgnoredLines=true blame $opt --ignore-rev Z file >actual &&
> +		test_cmp expect actual
> +	'
> +done
> +
>   # For ignored revs that added 'unblamable' lines and more recent commits changed
>   # the blamable lines, mark the unblamable lines with a
>   # '*'

