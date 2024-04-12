Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FF951016
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 09:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914640; cv=none; b=HPGofUgnkdxWE9sSTXCj30PvQzhlUxM20pnl89PWE8teS7gd6ovv/qAzuIY8KcJk5XC1NW7NAVRi/C5UKrPC8xKdJ8QvukkFj7A7meGQHRA+FUwdndPAqnrK/IZEocWpmcLCLv2YnaB24W2FxAKJzqeAjOldmak6eCEACd6hbBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914640; c=relaxed/simple;
	bh=iE7pNP2NPTss5gnMfQhzwwVjiP4h8ma3q1K3yAfjGu8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=K3r+3zSuLkNaBTZXI0WGl2m8uUkkZzEZiOvYgD2x0aBbVWfnNh/QQiMqXoohG8/CFIUj8zq6Ex8hKw2K4UrEKvYCdH0mgIh+Ovpxektfc/+ple80pWE5f9uws621BUC378ZXEosfFl/yfDL76+wL1kZKF9rfM8fls/C2Zzjw4xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XA2RHrSh; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XA2RHrSh"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-417c3296643so5566895e9.0
        for <git@vger.kernel.org>; Fri, 12 Apr 2024 02:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712914637; x=1713519437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S3+X2TqjnS4uOoe5qshm3zNNzWnek3RM4eo8YAus+UE=;
        b=XA2RHrShU3W3WGjyGlklf7tGNhuSqwOzcAjixMpU/K5Cv7EQUjMpbSXSWKcorf6d7C
         l3Lx91ZnGHOTnalE2JfXmKvELr1TjaliiFjpLtKGG1kq5VBdOEBDb0ul3+TjS1y/wTGH
         20me6d+wVR5FTKuEBTvFQ17zWynVk40tm09moNzGGXdQuYJEWiNmh7g5dHMubZzYXHH+
         txxZwxXKog4zA5U1naLqoopbHCgsaGipzGecdNgq2oojZXw/G1EAvgO1tihlftqqUUBc
         NJ1RfcsmQxTU2nzK8EsVV9DJbmrCG1RP4T9H1R/r9D88IuDczmc9RE6ySf8k9ZG7F9ON
         ZylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712914637; x=1713519437;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S3+X2TqjnS4uOoe5qshm3zNNzWnek3RM4eo8YAus+UE=;
        b=kIl9clBvqpewtBSDF17NhLEoL8soadDrTle0itFlPQEsy9/2LEwg8R6FAM53XJsdzU
         6MPJ0QKG2Qa4Jn9nAxDD8O+5px4xBrX0bPOeP7qbiifbHNF/F3c4vXHx6eiDjLPcIMJx
         nUdrqWZmJzbU/2Fq2aJGUPyI2Jug2YsuHqw8Xh1b/ge4Pim0H7zAxZL6aD85UxSlsE+D
         DjjH0AV5F8HfU5kzE+iaJovfQZCnLbQTSd41eh+4ynzaPPyLHD3SN9n8rEQz8Gg1Bc7a
         qlZHYmu5yIpJSV2L7bhFW0TwcIK1v6VD8Fr+hpz6zHixhKQnPTofDpICs7pOvLwI+QQg
         MbJg==
X-Forwarded-Encrypted: i=1; AJvYcCUBsm4Dm/kT2sg/+c7D55ZkqCvnmcPAJVrjM58qkFynrDA+zsEZ+HIZ+IdIlcUnDCTcmKT10PQ9A9K/UQ5wg3cgj/vC
X-Gm-Message-State: AOJu0Yw06/ouzuKWNBS0dVyGkyUBJNcvY+58ypbFbHO+ACrrXFRYXKf+
	Td50APMlVf1eckl26Jk74iMijIvz1dV9coWkYFM/eJKS/G1MgGuM
X-Google-Smtp-Source: AGHT+IHWi4ShTUHrYhxBPuyHkkjoQLAC/Xi3O23iro1PT87J1i0Nbdrixpuy4gx227rID9M3nuWfZQ==
X-Received: by 2002:a05:600c:444a:b0:418:cae:5086 with SMTP id v10-20020a05600c444a00b004180cae5086mr242866wmn.10.1712914637052;
        Fri, 12 Apr 2024 02:37:17 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id f20-20020a05600c155400b0041665d968f1sm5032441wmg.47.2024.04.12.02.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 02:37:16 -0700 (PDT)
Message-ID: <4c0b6da2-56d3-4441-aaed-8d9a2d28d9c0@gmail.com>
Date: Fri, 12 Apr 2024 10:37:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/3] show-ref: add --symbolic-name option
To: John Cai <johncai86@gmail.com>, phillip.wood@dunelm.org.uk
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Kristoffer Haugsbakk <code@khaugsbakk.name>, Jeff King <peff@peff.net>,
 Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?Jean-No=C3=ABl_Avila?=
 <avila.jn@gmail.com>
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
 <pull.1684.v2.git.git.1712597893.gitgitgadget@gmail.com>
 <a9e6644327a04f1d309eca812ace9c4159781353.1712597893.git.gitgitgadget@gmail.com>
 <a9ccd0db-2e52-4521-9d72-49d2a85656f5@gmail.com>
 <F53A2B72-D089-4C0A-92D0-E96EDD410A74@gmail.com>
Content-Language: en-US
In-Reply-To: <F53A2B72-D089-4C0A-92D0-E96EDD410A74@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi John

On 11/04/2024 20:57, John Cai wrote:
> On 9 Apr 2024, at 11:25, Phillip Wood wrote:
>>> +When using `--symbolic-name`, the output is in the format:
>>> +
>>> +-----------
>>> +<oid> SP <ref> SP <symbolic-name>
>>> +-----------
>>> +
>>> +For example,
>>> +
>>> +-----------------------------------------------------------------------------
>>> +$ git show-ref --symbolic-name
>>> +b75428bae1d090f60bdd4b67185f814bc8f0819d refs/heads/SYMBOLIC_REF ref:refs/heads/main
>>
>> Do we really need the "ref:" prefix? It is not specified above and I think anyone calling this would have to remove the prefix before they could use the value.
> 
> I can see how it would be more ergonimic to just have the value without the
> "ref: " prefix. I kept it because that's how the refs are represented on disk
> and git-symbolic-ref prints them out with the "ref: " prefix.
> 
> I don't have a strong preference, but I lean a bit towards keeping it consistent
> with the output of other commands.

I agree it is a good idea to keep things consistent, and dropping the 
"ref:" prefix is consistent with other commands:

$ git symbolic-ref HEAD
refs/heads/rebase-fix-signoff

Best Wishes

Phillip

> 
>>
>>
>>> +test_expect_success '--symbolic-name with symbolic ref' '
>>> +	test_when_finished "git symbolic-ref -d refs/heads/SYMBOLIC_REF_A" &&
>>> +	commit_oid=$(git rev-parse refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME) &&
>>> +	cat >expect <<-EOF &&
>>> +	$commit_oid refs/heads/SYMBOLIC_REF_A ref:refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>>> +	EOF
>>> +	git symbolic-ref refs/heads/SYMBOLIC_REF_A refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME &&
>>> +	git show-ref --symbolic-name SYMBOLIC_REF_A >actual &&
>>> +	test_cmp expect actual
>>> +'
>>
>> I think it would be nice to see a test along the lines of
>>
>> 	git symbolic-ref refs/symref-c refs/heads/master
>> 	git symbolic-ref refs/symref-b refs/symref-c &&
>> 	git symbolic-ref refs/symref-a refs/symref-b &&
>> 	git show-ref --symbolic-name refs/symref-a >actual &&
>> 	cat >expect <<\EOF &&
>> 	$(git show-ref -s --verify refs/heads/master) refs/heads/symref-a refs/heads/symref-b
>> 	EOF
>> 	test_cmp expect actual
>>
>> to show what this command is expected to return when there is a chain of symbolic references.
> 
> good point, will add this in the next series.
> 
>>
>> Best Wishes
>>
>> Phillip
> 
> thanks for the review!
> John
