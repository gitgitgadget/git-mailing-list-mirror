Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE6241CB6
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388798; cv=none; b=rib/6Y1jexkZA6Q9jkSELJmlq8oQnO2PWkZ7enFaMbLRcKbCYi2cNwpgnj/XUJaXnbI9IWDGan5dWNgLBMN5CtsgHMUxJ6YgRaiJvD8KhVqrIdflsssyRRGtJYhU5xrtCjMWI9B2lTtavrzS8Zol3ahgRTFBAtxf5yOLcPrFBfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388798; c=relaxed/simple;
	bh=nz46AzrDIA0u0aHJM/QVaHClKbElw7bxe0EBsyEk1OY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NEOYqNeR71e16MLvN/sX1ZVifNyqzf9Ti0OZaT6lFVHQ5L8o/YAhh/veiUnB7V75JlugNlmLWwgwm2AFmG990mrwrefigoihSjU8H6EZ1Z9I2BDUmG+WOWzZLQ97pBvLhNdLzN02GF2TWKDR9Evgo4DFpzaS5Ozy/G+MoxUQOYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHMF7KQ9; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHMF7KQ9"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-429c4c65485so3668300f8f.0
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 06:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763388794; x=1763993594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0dOk2BOzieHLannSFVk4oPQzTuhouavl78qD64mwsxk=;
        b=cHMF7KQ9Z/MRlkwuEfJH2dvVJ06qNlHw2hEcDOKkzj9Cucj6iebrgoMdO3XQTTmAvJ
         jjpMeG5bLFOCFsLryzbvYolCww/MNRrqgLBl3jzRd5ltoltoaqRMXAaNxVcu7dDmTI9c
         V7SO45CiUlaECDn0mHI1dLlWtOF4QluZRskm3ev7mA+VLGN5r3sCWQG55U9yMvIbasHB
         yHiJQgexG/MDOTdpA087dP9sSolLdh8C2OADBE+VXTNaVI0Ybo64x4xejZeRJ8FxqRtw
         FIRUFilxn4FYX7dQLpQAVPPkyXKxmpbVqMNPd9FrRRzfjXf14uoAZvb7Xo40hj3XN/Or
         lUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763388794; x=1763993594;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0dOk2BOzieHLannSFVk4oPQzTuhouavl78qD64mwsxk=;
        b=gZYEYDKEH0/Fp9/w+m1X1wQEFtDsGalzPKvyN4B7BOP5SfVqEg71euy0vfmldLhB2s
         hXW5RuefnxhECmPD8Py/U6ozfsWMkT57m00aVtL2VfD37Wqw4yXSn9JxCSsr8yQo+0Ls
         gHtB2OPtzxcvEP8zlOueKTxx0L1iohanLFvVAEC+Hb8MCmYQYx8VNlGSBA7ybLkse/P3
         1cVXfjztdEh4ZTLKlnQvKIMxY31YYw78kmKy8XPEgtIpNynkJ+hh5CxHfs8dQ0paBvCg
         dS1Ln0JtzQfnIpUDmBIE/pttFv4EMKBtqf7ZgpLtgM5bsOEjYR2CzICaG9mKFLUFYYd9
         Bi0g==
X-Forwarded-Encrypted: i=1; AJvYcCXwjmuGU1hXQQfFHVsYJStBbnrzCasegxPDGYW0fwmygjLUbxnMi7aI75Bg2Zq2nMgopcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YymotUXmkZURdt3Pv7dTOBFA6PGkMdXXlpdw/UPSRc2jLJriKEe
	o/GXhsIo//EOaH16aQBW0jPMdfcy8RutTF1iLfx/YpE4ogF3MLi5S1jV
X-Gm-Gg: ASbGnct4M84BHY9qTemDFEXnrkpvOMPP7OBLKsJWyrlcdnLpoaiLgckEhHjVWSev8H8
	J++rpYeEQArOy7YKJO96U+QWvYvMSgV0+4QHKWieZJhuOsfoweE1utfhinuEs4sU9gfRErHJbzw
	zKCTl6FnZQvPu5NduEaE1GxfBzgZkX6IqovKom7QfL6/kOFPGIWycwCb65/6KrktqeWPVX8mHhg
	o4UrllaMcRrkpCTUwdx2KmTnRttcdo6Jj1arM/c9YNLQZHp3bRD4VVmDEPsjb0jYuJMvsci9br7
	hb5+9P7oOZ4Kzg05344sx6DJwu3rhMVFc4OZQRQiaZr184W7AqIr3DcHfERmtSl9MkoPaMthnvZ
	AEM/4wqcv8eQ4IBFvC7En7rWNjHX3UfMsmMOdmhlAxYcSRbSUZ+6p3I9GueYyB3FEbQzNA5vNfK
	dHxYWfJGAn6I14bm9TJoaSww6eRhQLAA+0zIq+ClVTBs2jxPPUejU461OfSU8n0Cg=
X-Google-Smtp-Source: AGHT+IF+SDbF59f8X9QuRq0NoZy6Bhdyo6+Chs7p925l/MzLIqthluxsK/TKoMC2+a/LcOKXZfoVTQ==
X-Received: by 2002:a05:6000:1846:b0:42b:396e:27fd with SMTP id ffacd0b85a97d-42b59371fa3mr10877889f8f.38.1763388793591;
        Mon, 17 Nov 2025 06:13:13 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85cc0sm27233603f8f.17.2025.11.17.06.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 06:13:12 -0800 (PST)
Message-ID: <fd03f2a5-bf9e-453f-97d1-d5a66bc87470@gmail.com>
Date: Mon, 17 Nov 2025 14:13:12 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 0/2] blame: make diff algorithm configurable
To: Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Antonin Delpeuch <antonin@delpeuch.eu>
References: <pull.2075.v5.git.git.1762468914.gitgitgadget@gmail.com>
 <pull.2075.v6.git.git.1763366672.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2075.v6.git.git.1763366672.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Antonin

On 17/11/2025 08:04, Antonin Delpeuch via GitGitGadget wrote:
> Changes since v5:
> 
>   * add back /* clear out previous settings */ comments
>   * remove whitespace in bash output redirection

Thanks for re-rolling, the range-diff below looks good. Being able to 
configure the diff algorithm for "git blame" is a nice addition, thanks 
for working on it.

Phillip

> Antonin Delpeuch (2):
>    xdiff: add 'minimal' to XDF_DIFF_ALGORITHM_MASK
>    blame: make diff algorithm configurable
> 
>   Documentation/diff-algorithm-option.adoc |  20 +++
>   Documentation/diff-options.adoc          |  21 +--
>   Documentation/git-blame.adoc             |   2 +
>   builtin/blame.c                          |  52 +++++-
>   diff.c                                   |   1 -
>   merge-ort.c                              |   1 -
>   t/meson.build                            |   1 +
>   t/t8015-blame-diff-algorithm.sh          | 203 +++++++++++++++++++++++
>   xdiff/xdiff.h                            |   2 +-
>   9 files changed, 279 insertions(+), 24 deletions(-)
>   create mode 100644 Documentation/diff-algorithm-option.adoc
>   create mode 100755 t/t8015-blame-diff-algorithm.sh
> 
> 
> base-commit: 4253630c6f07a4bdcc9aa62a50e26a4d466219d1
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2075%2Fwetneb%2Fblame_respects_diff_algorithm-v6
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2075/wetneb/blame_respects_diff_algorithm-v6
> Pull-Request: https://github.com/git/git/pull/2075
> 
> Range-diff vs v5:
> 
>   1:  e81a5d2bd2 ! 1:  4846715436 xdiff: add 'minimal' to XDF_DIFF_ALGORITHM_MASK
>       @@ Commit message
>        
>         ## diff.c ##
>        @@ diff.c: static int set_diff_algorithm(struct diff_options *opts,
>       - 	if (value < 0)
>         		return -1;
>         
>       --	/* clear out previous settings */
>       + 	/* clear out previous settings */
>        -	DIFF_XDL_CLR(opts, NEED_MINIMAL);
>         	opts->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
>         	opts->xdl_opts |= value;
>       @@ diff.c: static int set_diff_algorithm(struct diff_options *opts,
>        
>         ## merge-ort.c ##
>        @@ merge-ort.c: int parse_merge_opt(struct merge_options *opt, const char *s)
>       - 		long value = parse_algorithm_value(arg);
>         		if (value < 0)
>         			return -1;
>       --		/* clear out previous settings */
>       + 		/* clear out previous settings */
>        -		DIFF_XDL_CLR(opt, NEED_MINIMAL);
>         		opt->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
>         		opt->xdl_opts |= value;
>   2:  60015bbada ! 2:  c477b87cc6 blame: make diff algorithm configurable
>       @@ t/t8015-blame-diff-algorithm.sh (new)
>        +	Commit_1 }
>        +	EOF
>        +
>       -+	git blame file.c > output &&
>       -+	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > without_varying_parts &&
>       -+	sed -e "s/ *$//g" without_varying_parts > actual &&
>       ++	git blame file.c >output &&
>       ++	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output >without_varying_parts &&
>       ++	sed -e "s/ *$//g" without_varying_parts >actual &&
>        +	test_cmp expected actual
>        +'
>        +
>       @@ t/t8015-blame-diff-algorithm.sh (new)
>        +	Commit_2 }
>        +	EOF
>        +
>       -+	git blame file.c --diff-algorithm histogram > output &&
>       -+	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > without_varying_parts &&
>       -+	sed -e "s/ *$//g" without_varying_parts > actual &&
>       ++	git blame file.c --diff-algorithm histogram >output &&
>       ++	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output >without_varying_parts &&
>       ++	sed -e "s/ *$//g" without_varying_parts >actual &&
>        +	test_cmp expected actual
>        +'
>        +
>       @@ t/t8015-blame-diff-algorithm.sh (new)
>        +	Commit_2 }
>        +	EOF
>        +
>       -+	git -c diff.algorithm=histogram blame file.c > output &&
>       ++	git -c diff.algorithm=histogram blame file.c >output &&
>        +	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" \
>       -+	    -e "s/ *$//g" output > actual &&
>       ++	    -e "s/ *$//g" output >actual &&
>        +	test_cmp expected actual
>        +'
>        +
>       @@ t/t8015-blame-diff-algorithm.sh (new)
>        +	Commit_2 }
>        +	EOF
>        +
>       -+	git -c diff.algorithm=myers blame file.c --diff-algorithm histogram > output &&
>       ++	git -c diff.algorithm=myers blame file.c --diff-algorithm histogram >output &&
>        +	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" \
>       -+	    -e "s/ *$//g" output > actual &&
>       ++	    -e "s/ *$//g" output >actual &&
>        +	test_cmp expected actual
>        +'
>        +
>       @@ t/t8015-blame-diff-algorithm.sh (new)
>        +	Commit_2 G
>        +	EOF
>        +
>       -+	git blame file.txt --minimal > output &&
>       -+	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > actual &&
>       ++	git blame file.txt --minimal >output &&
>       ++	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output >actual &&
>        +	test_cmp expected actual
>        +'
>        +
>       @@ t/t8015-blame-diff-algorithm.sh (new)
>        +	Commit_2 G
>        +	EOF
>        +
>       -+	git blame file.txt --minimal --diff-algorithm myers > output &&
>       -+	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > actual &&
>       ++	git blame file.txt --minimal --diff-algorithm myers >output &&
>       ++	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output >actual &&
>        +	test_cmp expected actual
>        +'
>        +
> 

