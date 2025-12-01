Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B192556E
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 12:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764592538; cv=none; b=hm26VIQpj/WF/Rvfhz8lQ/Tax/wKUhuJv7vqBzarPehDZ5yYqjZIRZNp9mXpdGwMn4eUIsYuv1f+B9K3PyGVuYADnkbM51xH9+YNrTk2LRuoU3JrFNj/n3IRopAyGF2IVFyirp08bAzD2/zTuJYqzZfTOVss4BTLq/cEwKb01P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764592538; c=relaxed/simple;
	bh=qrXoveCYjVYUf9LM844NfvQQEpGJSfRE6ECO3nHvf2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJtGwJM/DuhU6jrub5762wl6tzd/kTo1rX2X2qxeIISx+bUq2kbhXYwOMaMc3+wdDgaXeIfvplDEXYHu7YxGDudoJKud0Cg9vVKWXGy26KoKuQG2VTxRoxk3gcBNWfRIfjFoE3S+AHiM8jjY5sPJCXBcymFQkcY1xv01Cagn64I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/gfp9Gj; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/gfp9Gj"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8804650ca32so34986296d6.0
        for <git@vger.kernel.org>; Mon, 01 Dec 2025 04:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764592536; x=1765197336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ExLD59GYgC4SQnzEBrLRMFl0xqq8VJViwP8uoXxcKaA=;
        b=g/gfp9GjeZcHn2PcZUW8MFdYIr8ZNVvusQ3I9QptxKu4FLdt8hTJbMTHS4cOejboN/
         KdtY0R9Z0JejXF77ZqWK2NZqK7fi0uy4shxYVKIhPqSV7JKggpY+3eIdxhjDWkn3OKsW
         2uMBuwjy4aIGQrZ94UxA7ahZ3UVc07tO/FpZ0+9UdOr0W7ezSXnOHXqJ+HyG87R4mJQi
         jnEGegFXx+yyHqRta/OsORLWk+S50OG70fb5ubmwxGaQMNvRptRywWXfDOPkQZdA6YYB
         oVqCveibl5t/YdHuksKGT5WifcqKtkMgnToLGexpvnGktKI77JEf80M0uGYiXhTFVbAS
         Gqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764592536; x=1765197336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ExLD59GYgC4SQnzEBrLRMFl0xqq8VJViwP8uoXxcKaA=;
        b=XWOMdgz5UDQXgdawNobkaSaM+Zd934cwCj7nYuDMy3DDNlk0/juD3UG4TuZe/p9phJ
         Ip4mcnLAJWlDBiCb0VBigjsaZ6DjKGIvd0M9h+kUZjyerHFI5qAhU4xHbL0ntibZe5rP
         xkRd1i/BLEkHQd0gCMuaodMVIuDxgnfK/PZhozhPjHhgkdDPYqSXWxiIKWXMNK2nHFUT
         Zbwqb273l1kgGm9CKFKh5ot+HOWgHtpGZg259W72ijFc3mknV3tS+y2hxC1PzF1CCiCB
         CmH0G/Ym70dJr9PPMm1uq7woY7L8a1osBxY0eih2/yrkdpof1sQnoqGgeevDnIqh2xgc
         EswQ==
X-Gm-Message-State: AOJu0Ywpz4AdSCXsvf0sR32cy3XvNDcIorfCJJefHgafAVw/+mXNaH9d
	NFayHKRnlXW8t85TjQjBXRRdktufM5NwIo8NTF1zYYcKke7NlwsFYq2j
X-Gm-Gg: ASbGncukpI3+oh16YL32cMx7tzVwDs/2Uxc5kO0ee7Jt28nt3SU3tUC5Rh9JQUbNDc4
	viKlXwp8bMX7osAm0AYLWHlnPG1WjR7GjxeJryKkOE5PuZHbA46bKG9bb7wfyWKrQVypYjiIiHX
	N0UyogjQHckfzKZ4QLYLzadFJ1gl1Bfvni/6xUoCNSFDtZJfHUzwycu7nYFaUNiqO0ffakJ1vXA
	yw0m/pmC7FdE67EzDQeZacjRv8hY3J0kpDTR4CaixsjjBHDrEhYEhUGqsSspoWe4MiCeerDMgqB
	wmujTfHE7mGr3E+HvpfmQ2DxFrnDcIJ+xWIbqDSJEj6PT80opZIGBWbebPiU/tfTrAMsY0JD0Pg
	ZUuP4YVDu2FxAGk63TI2GZNbU2oaxGcLQTi3XpeJFnFC3BjRd0LRQk/NLI4V5LVrD0cUTwuUQZn
	mco703/aID8QnIkzOMD7HS7j+2BlnDbZjY3anL2R3g5IV29Ul7qPRIRg==
X-Google-Smtp-Source: AGHT+IG8a4OPUcvhGkAJ9765a4K3jV8/m+Mhh1u+sWkhv+hyiMlq/qZM/GcqPBdUNrB8X8OyEQ5eRg==
X-Received: by 2002:a05:6214:ace:b0:7c6:2778:2f8 with SMTP id 6a1803df08f44-8847c521d40mr561530466d6.47.1764592536112;
        Mon, 01 Dec 2025 04:35:36 -0800 (PST)
Received: from [192.168.1.253] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88652b90dafsm82061516d6.56.2025.12.01.04.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 04:35:35 -0800 (PST)
Message-ID: <c40853fa-03fd-42f5-aff0-663a3567e930@gmail.com>
Date: Mon, 1 Dec 2025 07:35:35 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] scalar: alphabetize and simplify config
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, atthewhughes934@gmail.com,
 johannes.schindelin@gmx.de
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
 <9b8ce6ba2bcc802ae38b2e1223d7d93b03fb2a1b.1764195516.git.gitgitgadget@gmail.com>
 <aS1YAugZpgtNkgkR@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aS1YAugZpgtNkgkR@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/25 3:55 AM, Patrick Steinhardt wrote:
> On Wed, Nov 26, 2025 at 10:18:35PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> The config values set by Scalar went through an audit in the previous
>> changes, so now reorganize the settings and simplify their purpose.
>>
>> First, alphabetize the config options, except put the platform-specific
>> options at the end. This groups two Windows-specific settings and only
>> one non-Windows setting.
>>
>> Also, this removes the 'overwrite_on_reconfigure' setting for many of
>> these options. That setting made nearly all of these options "required"
>> for scalar enlistments, restricting use for users. Instead, now nearly
>> all options have removed this setting.
> 
> As far as I understand, this setting causes us to overwrite any
> preexisting config values when reconfiguring Scalar? So with your
> changes the effect is that we now don't do that anymore, which allows
> the user to tune some of the configuration values to their liking after
> having run `scalar init` for the first time. I guess that makes sense,
> as it gives the user more flexibility.

Yes, that is correct.

> It does make me wonder though: is it really the most sensible thing to
> overwrite any keys that already exist in the configuration? We may end
> up overwriting configuration specified by the user both in the case of
> `scalar init` and `scalar reconfigure`. But arguably, we might want to
> only ever write configuration that does _not_ yet have an explicit value
> in the configuration file, regardless of whether or not we reconfigure.

I agree that this notion of forcing config is not optimal, and is a leftover
from VFS for Git where some of these config things were actually required
for the virtualization to work. Once that idea was in place, it was easy
to think "we'll make sure the repo is configured correctly" but that makes
much less sense in Scalar these days.

>> However, there is one setting that still has this, which is
>> index.skipHash, which was previously being set to _false_ when we
>> actually prefer the value of true. Keep the overwrite here to help
>> Scalar users upgrade to the new version. We may remove that overwrite in
>> the future once we belive that most of the users who have the false
>> value have upgraded to a version that overwrites that to 'true'.
> 
> Makes sense. This has likely been a bug, and we now want to rectify that
> bug.

And hopefully this is the only reason we'd need this "overwrite" feature
from this point on.

Thanks,
-Stolee

