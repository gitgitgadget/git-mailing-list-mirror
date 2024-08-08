Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13D71891BD
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723111678; cv=none; b=pdARPMjNj/P73wNMEFx6/5GPGFvE375mVb4nnSVCjn7rcNULNj7oSFzAdg/hhvBupH8FdqmcB3rZ2pbisKjeWsIOHV9hSx9gqX0rIyVhtgxFhBDMcVY0hblwCoEW1dodd9CxK0gilswlS9UaFH5zSvW5on8D+Xo1y16jsp5xlhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723111678; c=relaxed/simple;
	bh=RrFyLy27aheowEUNAi3VbIANLEuowf/0DaJKIdN8mqQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iTBrHOfuybS1UQ/H0vIG/mNZhqE/h5/k2ksspbsPR9M5QOgy5DDlRt7/Q5dXlE9RFDMBQuBd4u5ucLtFpmpoO5tA2I1k9stlzbOacFGn6NQXMRG3CspLoQwtX5XUi7F5w7Cl7dxU0OrulAKdv7cQkTbPBp8ySgmgOxDg32IPNOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OR3Mmo1C; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OR3Mmo1C"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42817bee9e8so5460595e9.3
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 03:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723111675; x=1723716475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=97I9NzYM7Tiou4pMuNc9Pw/n7ekS/XRhUklpAld5exI=;
        b=OR3Mmo1CTlj6tXR80btryQMtVijZ6PVrf9/VW5kxmU0QGB2frLYGjYCTyEoH36YS3W
         M5rb4gJeMXQjGauZqGsowZ05bewKvmB6oilESTSKrLV+Z3QIz30mPZ8MjLubTMwsw1U6
         UxBITUf00op5/boDbeba2QifryOecqidl2NITHD1DgT0OC2TSe8QlAA0meI4UOVk/tRM
         zXzgnSIKd/bBVfq+c4Iy9NPuQVuPL6lIi9M7obfyym+su00EAgXsKdTvXAbVVsNNZJ1b
         IvF7iTht5BCjxrEa9eT4Zb2kak7JvySsJJzDrhLP29Dh4Q6eef8DF1bbt+elBKGsRS3T
         fjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723111675; x=1723716475;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=97I9NzYM7Tiou4pMuNc9Pw/n7ekS/XRhUklpAld5exI=;
        b=wqzXY8ejEY35MkR2lDcWtbJXhekuReevipgki34Zcza2ZpKCcqTGMzfjH325JVmIOx
         KGXvsLsLoeT79mHsLcz0i0diHo2+jMb+Kq1bPl26OLmEA+OhdYNapMpQarC7BQCaUyR9
         wD67A+a8CdtQTdrFGCdeDoNkPsiXgQQkPI5dJWS2Trl46BR72biRP7ymjcpgpvFEYhxQ
         x+hje1lzZes90gz2Tkp4RIW8ZJHdzk9uhhBAx/Fj5Ehpr4DkB5W/+JC+qmLsulc9kQUI
         nlREoQ0Bj+3LqGrZ1Z6ZmLHfM4uWLrWwvrJG1cz4JqGfniD0Kud2lKftTdPHnkxGo3Ll
         CXUw==
X-Forwarded-Encrypted: i=1; AJvYcCV6S7w/eUFLtdO4mg4G9iVT84eeHVcT6X8vOeTmek2KBHwCmfxxDG9ZNq6hlfXuKPq32rCH2uODVeFz2zNdkBgJ/nSj
X-Gm-Message-State: AOJu0YwGFYYSORa5z4LgDpZq9FR0fcNwXN1Wni433gCigUq2YoWZragm
	w6mJFPOCva+kizhof9aHoN/kpV7voHu07g2nXkjeWmUYY3yDr1iTZ/CEhg==
X-Google-Smtp-Source: AGHT+IFE7A6JJeIUfuoqeP5rTBilvJ3EizhhzMTi91/gZOFS2U6PSg20/ZTvckNZ0/Izd56YLUpikw==
X-Received: by 2002:a05:600c:4fc8:b0:426:616e:db8d with SMTP id 5b1f17b1804b1-4290aef24e0mr11042895e9.15.1723111674605;
        Thu, 08 Aug 2024 03:07:54 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d7:1301:c687:6ca8:8709:4b85? ([2a0a:ef40:6d7:1301:c687:6ca8:8709:4b85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429059719ebsm67312645e9.18.2024.08.08.03.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 03:07:54 -0700 (PDT)
Message-ID: <b5abb3f5-c74c-444d-8006-22bdde2e9cd8@gmail.com>
Date: Thu, 8 Aug 2024 11:07:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 09/22] builtin/rebase: fix leaking `commit.gpgsign` value
Reply-To: phillip.wood@dunelm.org.uk
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>
References: <cover.1722933642.git.ps@pks.im>
 <05290fc1f14cae8229c42f2d0aafe6619c069e3a.1722933642.git.ps@pks.im>
Content-Language: en-US
In-Reply-To: <05290fc1f14cae8229c42f2d0aafe6619c069e3a.1722933642.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 06/08/2024 10:00, Patrick Steinhardt wrote:
> @@ -186,7 +186,15 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>   	replay.committer_date_is_author_date =
>   					opts->committer_date_is_author_date;
>   	replay.ignore_date = opts->ignore_date;
> +
> +	/*
> +	 * TODO: Is it really intentional that we unconditionally override
> +	 * `replay.gpg_sign` even if it has already been initialized via the
> +	 * configuration?
> +	 */
> +	free(replay.gpg_sign);
>   	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
> +

The code that handles "-S" could certainly be clearer. The value 
returned from the config is either "" or NULL, not a key name. In 
cmd_main() options.gpg_sign_opt is initialized by rebase_config(), we 
set gpg_sign to "" if options.gpg_sign_opt is non-NULL, free 
options.gpg_sign_opt and then copy gpg_sign back into 
options.gpg_sign_opt after parsing the command line so we're not losing 
anything by unconditionally copying it here. The code changes look good, 
though I'm not sure we need to add the blank lines. It's always nice to 
see more tests marked as leak-free especially a big file like t3404.

Best Wishes

Phillip
