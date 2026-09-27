Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BF424C06A
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 13:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790516916; cv=none; b=jO57NDlWTTb2MTEd92z+eRTpIvQiCFxhS9F5QnnT6C7YBjXqJUy6UnJLTwuw6qKtT/N2e4b8vXxxTDeK10sH/r7KVe3OeXzCbgN7KpTr48X/xRobDi924BO1IHbi8yKCdDPbaJ9N0GX1fX6QO2iGml94kcyn67Z04JOxZpcjAds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790516916; c=relaxed/simple;
	bh=AswCw57gHN29jjUehD+IwzP/9Pej7/AGvxkb/p1thqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bKiANt4jiM2jLb0gqyjbVBmSn4SCtYW2syEMWEYThfSeNJ6EJkA8lO+0NyH0soo13WrIbSJrlpQk84cbPhJ4eYofA6X/2HkHmDySx+O64+HC8TtuO2UAGtjnSL3YhkVqHMurDnKqlw0XgbNPxiEFtHaEQeiAi9/ZsrOC/Ig6MsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOU7TPKD; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOU7TPKD"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c3ea1f6so1177720f8f.0
        for <git@vger.kernel.org>; Sun, 27 Sep 2026 06:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790516913; x=1791121713; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SS6vuTrFYpsL3J3NUXtIIYaqW2SMn42oLgAZBXJoxVg=;
        b=UOU7TPKDy1Qb6szxdI0dyNNu+K6kqR0vtRzEFdHUx0sfMt/w/0/5XsRuJC3lQloJ4/
         5Jclg6WLNSc3t1hPqMBxOXqkUlzPAnGCouIsgP60yR3uC/r6h6g1tu0x6Zwy1J+vXCBf
         4zNR1MtQyjGYVI40o6TZ0Ch8G992wHAlNIts62W/4pitrS9/swH3ffoiNL0fNAhXOX0w
         Gap4g3Etmz99vA5C1R65lSsGCpj8DeDBg60Sf0DSaCUSCsv7gWB4dW4wFO+jxsnyUJFz
         KHX98DRwuW81nuQUqt4QKbAik8IPvXsARP4OyNKRbb23F75q4V/Czy7H2h9tiR1mkW0m
         +snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790516913; x=1791121713;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SS6vuTrFYpsL3J3NUXtIIYaqW2SMn42oLgAZBXJoxVg=;
        b=cE/IDxuSMP5DgM7o4qyGhCyk2ORcYxJq/ZzpRk0UpHyRnBFGQYqdZF81wvivt07CRM
         H5mP7Ct48XbivQrKczHMucbVUA3w+aNK3e1ofSEBW84y/1lSIrUFb5exsE7hcSQLVLx6
         XLKfOgT8MwZ69Xh74TVJeUWnY5hGH6xV8M6ZWJeYhXgQqu3FrhlLmp10aOHcZPzKzHP4
         Yw/lVAzob476ZIip6z7FWN1L/Ui7h4QnCLjIa9qitNLXmrpyRn1/oEFnWK++4OkXagDM
         eBHE6Lf+WIX8XAvP48uWur/RtbgogcDIKLBqfVfqG0tUOXI3Z1TvMXQOZ1xLPYmiqyCe
         N1rg==
X-Forwarded-Encrypted: i=1; AKwUvBxx6EcXOQIMY8efn9tfs1NCjSryNmMdys6JFKR3yqzxoLgsIC9vb9NNfqTuucVPab+7RYk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpbzGG0UBpUbA8EtwwAsmIU11b90a6dTRlvlp5I1jcopIzM7Ym
	sLaZ3HDHS1z9zp/i8BwJoRzTKeTXckwv6h3VeVIm2HbcAN7aCT/se8a6p5HcsAHV
X-Gm-Gg: AYBFou3uF3G9J0qtJbD9JyEyQdWd5VqZsVpkSLfCBm9DIVtvotOf6mhsemmDZDoCahb
	fTXfCvDj7nZp5OqiH9S6Cl6dKBp3nr+KtgH2QM8mfd0RA9sUpJ3Xq8S7aXxAvrnV+tt1s55im6+
	osx2hpV+GWKEo0A6SgRMfFno8dypSMfSbaUp9JuvT3+I1ry6VXD6IdY8ZOV6Es/SKkdO1JLR8fb
	Fo3tsrK38PxX5+JuYkxf15gh0EHNA0Wc/eZ0huAr2dBkdV9RQx2WfslJa0nI92qgj3IIZx0BG3G
	51Ra0w93XZZezc2g8CYdfExqRFQ8E16mSrgiQb020xXhpr3QvfABPxfFQUrGPTqB4tqRBgbzMRO
	e0iIds832jzr86EwMHU975b1UOBzcmIUVUXS3azAh5UTyyD1+SYhdFDPkWZVDpCBWTMrPjVzYzQ
	ead3ujhE+n8Ryu9J/DljViGGEst8Oax2+Dm+4SvWLiU1/RQDXSKZdnUMgy12dhCZPhaxO1fY4nI
	5h7N7kUvAIu9PjMIORC9IrjDvyosvRqetE6LbRTzCcFY7BKjtNz71w=
X-Received: by 2002:a5d:6f03:0:b0:486:f767:8be0 with SMTP id ffacd0b85a97d-4887165e9edmr19106950f8f.12.1790516913292;
        Sun, 27 Sep 2026 06:48:33 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30c43asm21654786f8f.3.2026.09.27.06.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 06:48:32 -0700 (PDT)
Message-ID: <7ccc822a-6bd0-44e2-8d6b-ca525d729207@gmail.com>
Date: Sun, 27 Sep 2026 14:48:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Changing default config values (was Re: What will come after Git
 2.56?)
To: Junio C Hamano <gitster@pobox.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
Cc: ps@pks.im, git@vger.kernel.org, sandals@crustytoothpaste.net,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>
References: <ap50kgyenpRrsqln@pks.im>
 <20260924183523.53201-1-haraldnordgren@gmail.com>
 <xmqqpky21mh6.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqpky21mh6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/09/2026 20:24, Junio C Hamano wrote:
> Harald Nordgren <haraldnordgren@gmail.com> writes:
> 
>> I have a list of breaking changes that I would like to introduce, I was hoping
>> they could be considered before 3.0 is out -- otherwise I fear I have to wait
>> another 10 years for 4.0, I would like to change the default values of these
>> config values:
> 
> I do not know how long it will be before 4.0, but if you do not have
> any draft code on the list or even design presented before this
> message, it is way too late for 3.0.  No, these won't be part of it.
> 
> But some may not even qualify as "breaking changes", so after 3.0,
> some of them may not have to wait until 4.0 happens.

A couple of thoughts about changing the default values for config variables:

For ui related config values such as diff.algorithm, diff.colorWords, 
commit.verbose, merge.conflictStyle etc. where their effect is largely 
cosmetic and the potential negative impact of the value changing is 
limited, I wonder if we should be more willing to take a 
consequentialist approach and allow changes where the net benefit 
outweighs any potential downside. Currently we tend to have a 
deontological approach that views any negative effect on even a small 
number of current users as inherently bad. A consequentialist approach 
would allow us more flexibility to change defaults, though we'd need 
some way to try and gauge the relative costs and benefits.

One way we could change the default values of a set of config variables 
is to have a config variable, say "core.defaults", that determines the 
default values of the config variables we'd like to change. That would 
allow us to have a set of "modern defaults" that can evolve over time 
and can be easily enabled or disabled (a bit like 
"feature.experimental"). We may want to extend the concept slightly so 
that different values for "core.defaults" tune the defaults for 
different workflows; for example having a setting that implies 
"push.default=current" and "status.compareBranches=@{upstream} @{push}" 
for triangular workflows. If we take the approach suggested above, the 
modern defaults could be enabled by default and it would be easy for 
users to opt-out by setting a single config variable.

Thanks

Phillip

