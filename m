Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B4619D8A7
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 09:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751447413; cv=none; b=Cypx+Nu1kOA8Onq0+f3zSeGxvhaXhop2ZvTKyIbGahNh2C5vxEtWiKXKsAtLKJYhUH9GJEQdKKWafNJhNzn2J2to6x9vXlNe0Eju22kshHjWspr/nDLMYgeAc8CMeqhmJve7jBP9Mhv2OFmfTX2Ih/AjgYevlrVzLimj7DWL/FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751447413; c=relaxed/simple;
	bh=lQIx/aQHOEIKFGxqXhfRIVH269meBtPI1ahNSPZLzMk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QrccatBLKQXUd1z3YltGcsE7RgZpK/P0mna3RJxoyKNsR6R2F1inFxp/od/v9bwpC+d4uvov5FDWr7cvZ4PnW/lecbWELCFqqDwxzbPKaCiCakH8JEJ71ALRqfXTZCXOohpyUVd/Vs3OY0SDM5ZN8C7ihVtfEllOAbRSPijMsTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iESxFQkm; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iESxFQkm"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so5905665f8f.0
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 02:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751447410; x=1752052210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G471LOzOO5kuzDgiZTL5NqVkjHd78mb5d2BTlOFSCmg=;
        b=iESxFQkm97Q7oYzBEoT57L+ln5hR2tp3b0h0RfdoT4+jPT/HrH0dAM9tdBzwIp3GmN
         Sw4f5zXaJqOucpZ1PHnSCSZgkobce/CT8Xpcw2AnysvzJ62ecqBHIv18XwwU1gdPeErT
         vgwGWPnt8xu28P2KLM1jgmwfUbvn1cVacY2HWxkP3BmMjgxPVpe/yCV/m9nnOWfl9YSE
         JnqdSDdGLToILOBdUNaae9fK4209xkMEu2zIuIjULpFMtagiCFHxhRMNDDpnmEw7R5c+
         RaQVde53tO7sHHo9K0WFm/8blC3o9joFTQf7PDO0Pi/tJ645HUP8yYUwJkMrw5MbTXEo
         zKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751447410; x=1752052210;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G471LOzOO5kuzDgiZTL5NqVkjHd78mb5d2BTlOFSCmg=;
        b=VGVvCnsrN4jKStopVxIKyEhC5rtQ1P8cZMLMbnKCwDxbyCQQt3J1Eny7n1p1vF4RIw
         XnVtf0zN81ww8B7SesbElVSRkyaSz5ZypHHq9jpTyyTynQx5FXq9l6XxK735XH4ApLpP
         sebhYKaml8s7SAKKdjgUmdRK07ShKeUI5lp1FGnBthQI2j73Rd9Qd0hB+Wy5jPEPfsAA
         BO5XQXKkM9Cu3gwdP/EM3XgYrmEznzNL5LpRy56EPM2PDQL90PC+hSceJbJnXXQBYX+h
         WoC+VPzZknqZlFQ+Y2BzFXTUPKgLdPere3c0+VKpEfkmaTkks+L91eqCTFMI1F5vLWzg
         Pw8w==
X-Gm-Message-State: AOJu0Ywzuo2YonhDCVDdgi4Jj1M2LIy/8Y6KNIgzC511ebxtQp8SZvrw
	DeZVgB/+Lvm69LDlynOMBvI4LRuaK8FZStYyzmFZU2e5X9t51P7INKwV
X-Gm-Gg: ASbGncv4s6KwXjbCmV4Te3wiKn8MXVHZanyq49MZYYjnMLJnJogVB0Y1/RoiTo11NWM
	HXBPnhAAzScIslNjsllEWvoht9SgJLHXk5nEjvF7F5nXPZLPKUNSiN/NZl2nLHIYUdtqSxNWMwI
	AzQhWcsA4qvchVnFZPmKWrPUwlfdo9X0bGw5YZb3wGwxRisk0MfULtppV9i2RKnkOEWt3zv8te0
	TqPCvELr7n3oj+Cd3MVKZSf1bPGqtr4m1DirwenWJU/azvuEfbJ92ceSxLJtwhuH8y/2XUyTlNb
	rsJe5GkBM6bEnV+wLnV513vlesRLLHSqAJ1MierwpcwuH6qmrnC7ETdWQM+EboQHnUaoeZaFpFD
	7WpnP2Yh5nX9Y1TxZQ3O2lM3McaUTnwekJC9bwA==
X-Google-Smtp-Source: AGHT+IEjHW1CGHPzemW2GS+s4olltU0Vt82Z/lvtp3gpRIAPc7HWJUHeewbiNRTUQaIKVIS6s078zQ==
X-Received: by 2002:a5d:5f01:0:b0:3a6:ec41:b9df with SMTP id ffacd0b85a97d-3b200c3ea31mr1390930f8f.49.1751447410196;
        Wed, 02 Jul 2025 02:10:10 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823b6c21sm222079075e9.29.2025.07.02.02.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 02:10:09 -0700 (PDT)
Message-ID: <d61879e2-a93e-42ad-bd16-7a21b9819dbb@gmail.com>
Date: Wed, 2 Jul 2025 10:10:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC RFC PATCH v2 0/7] repo-info: add new command for retrieving
 repository info
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
 phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com,
 ben.knoble@gmail.com, gitster@pobox.com
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
 <af27af92-73d5-4f0a-84f4-9c91de6ab6e6@gmail.com>
 <652FDA35-C20D-4F27-A22A-025CA08EB013@gmail.com>
 <223c7cbd-610e-49e2-90e2-5914cbc0f1d7@gmail.com>
 <EB2B7A97-B9C4-4F7E-BD27-688C6303DA1C@gmail.com>
Content-Language: en-US
In-Reply-To: <EB2B7A97-B9C4-4F7E-BD27-688C6303DA1C@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lucas

On 01/07/2025 23:18, Lucas Seiki Oshiro wrote:
> 
>> The reason git uses NUL termination for other commands is to prevent breaking the output when values contain newlines. The output format I'm suggesting is
>>
>>     <key><LF><value><NUL>
>>
>> so the output for "path.git-dir" written as a C string would be
>>
>>     "path.git-dir\n/home/phil/src/git/.git\0"
>>
>> The value can safely contain newlines because it is terminated by '\0'. The reason that "git config --list -z" exists is to provide an unambiguous output format as config values can contain newlines.
> 
> I can't see any downsides in this format. I'll use it in v3!

That's great

> Hmmm... I never used `git rev-parse --git-path`, but after inspecting it,
> it seems to have special cases for:
> 
> - grafts file
> - index file
> - objects directory
> - hooks directory

and all the paths that are adjusted by update_common_dir() as well.

> What about adding them all to the `git repo-info` under the `path` category?

That means keeping a list of paths that are special cased in two 
separate places which means they'll almost certainly get out of sync at 
some point in the future. It also means that instead of querying a whole 
path of a hook the script author has to remember to look up the hooks 
path and then append the hook name to that which makes it more of a faff 
to use. Letting the user just query the path they are interested in is a 
much nicer interface and makes it much easier to deal with the paths 
that reside under $GIT_COMMON_DIR.

> Currently, these are the fields that I plan to add:
> 
> - git-dir
> - common-dir
> - toplevel-dir
> - superproject-working-tree

git-prefix would be useful as well I think.

Thanks

Phillip

