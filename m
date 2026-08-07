Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4263DEAF6
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 06:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786085490; cv=none; b=PYU8VJia8VIKT7t7lHoTngjuXw3L4aL50DGcYzTx3ZPpD/OfnjDVyw8AcVOYfDxMpovI5gdqTEOYyprnKhUSoEgBPYd28xgRbkNHTqH5heHVTbP48MSJ0BBlOcMQAb/hiXs4XWg7tbZKqFD22t2Mqa+6AcfJla8EwSvLLodAgsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786085490; c=relaxed/simple;
	bh=OqVJGxRJ4ePx7XL7NbNacQpwVtXgZRUvqTJadhSxFq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejnqbx5+xlqv3VkTDMbghXOuGHs23CugabPGfyVO2lDI9ojFqjYcJK3S6B31YiWaEd3NArKB/zI1erDwy9qXSzvLyzieVevwybEY7f1t+OTZ/GxR1ypuP2UEq2yx6TKiVO6fpZB7JwK1n13piDBVjybh3ZV40+zs53DEla20Kz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=odoo.com; spf=pass smtp.mailfrom=odoo.com; dkim=pass (2048-bit key) header.d=odoo.com header.i=@odoo.com header.b=Id72P17B; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=odoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=odoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=odoo.com header.i=@odoo.com header.b="Id72P17B"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso1866580f8f.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 23:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=odoo.com; s=google; t=1786085484; x=1786690284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nd9O2vm6uFG9h2fUFyLlD9yfVs07HBBFJ0jT8Vf/l4Q=;
        b=Id72P17BF4ilXYHkDYcjPZAS55rtsjtbI376depEl57dxJ9NMQQ57jy4ZGLHEVgsXA
         MjnzrADd74Lm4BuI2vxMozs2xlR23lkS8om99CXLA9ES4DZ3jsnDRYRldr4EO65p5+ur
         WzpMxxQMH1Np1FF5xRkc8pjMAF5ZCfbXcSs8lI4t5rLK3uopVLksAQE2vCI1jTLHgP6x
         vgePYqTS75miJQ+WrEspLeJ08H+8Li9NeFR96sCsQr71WuH5JY0QtsQODmLJl/3marJU
         M8Ae77me5tSWnYYE/1H/LUE7Q9aFZ1+s6BDuylN8j+Q4lj+wW//p7WSEJSuuWjw5ki5s
         UqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786085484; x=1786690284;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nd9O2vm6uFG9h2fUFyLlD9yfVs07HBBFJ0jT8Vf/l4Q=;
        b=VDF9gu2RBNjaDO6X8mYYe8NxOi0wbiTvQZpoWRFM8eg2ch45Ew0ZA/OUtxEWjJKKaf
         bqf+mSgmNgIDnnXCSRJjmcqCXytfzDt5P87fzuPUk1NzS3CPhu9bJnr17PpzWO+7b/tW
         B7hjxLA6HWUgB+JKVp5rJSVDZc1Y/2flS6D8fLfTFkYoz7P8swXHqsonQdXMAxV4/F6u
         +Xk/if/Z8Ss6m3eTDLLv9CLaP0H3XWNdHh1SH77uHdoNXeGYkQfvXLD7LkHL5S41J6yd
         vQF34FR6uyKGq3roZr5SdX2OVYwmncWT1AOm3eMG58JbtWDsspMWBoZkOjE+AIJad6Sn
         Aq6Q==
X-Gm-Message-State: AOJu0YwSuDFBfza9Sti3Dp5rjWPsENsrU2C4r7YTVV7b0oDDRsOvx/Dt
	f/bAqAYRh5VlwPI/9GxnKU3ewvouEJQyzLcL0swDSLFFUrSAYaPn1BC17vSdTHby5Bd1w73DNgH
	qZFHO
X-Gm-Gg: AR+sD11a/xkfb0mkHUq6Glrf2/65gUObQADaNNkjMjobU+hyGCVGpRay2EUSvJom9Wa
	VdEjRbgQyEBrbf9u3jhVHK7kf0RyMsuheHzMGL9bMiLNx8W6ZABE4EAP53ige3c7tEbXOh1tB/H
	qfjZgKwAcyd9itYpdrlcZvqOERBBc+nVHLiuec2ErraDV+pbm/K7uKj7Xl4efjo1OoN/m3HBBBD
	K4o4T4DO+yrLXwZTHmaA1DYs6KekxK+qCgYm0vigxckleg1PNg9AUekyNlsclpJI91loMq6O3wZ
	pmKhWoBvdHcSB8K+wTc56elhey2WiGASttfFUmvSRgwhCbKrhTs1pTg1mrQAsiJ8pBxNVRW3Hae
	TItA6sinpz7azYN+E1891FUwxix0sXS+EuXitubmanR9wQPzxgfsWJysPexDYd+c27N7XXCwhff
	yHVw4pT78LpapYHJNyczzD7nopIRreHuf1lqZOEqibA0b42DqB0fsEXxV6WlCca+oR7zDPAVc3M
	Uk8TrOIr+1iJBZM
X-Received: by 2002:a05:6000:29ce:b0:47f:7c4c:8144 with SMTP id ffacd0b85a97d-47fec523d1fmr23992418f8f.10.1786085484499;
        Thu, 06 Aug 2026 23:51:24 -0700 (PDT)
Received: from [192.168.0.2] (ptr-178-51-130-126.dyn.orange.be. [178.51.130.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e8c5asm3258120f8f.18.2026.08.06.23.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 23:51:24 -0700 (PDT)
Message-ID: <6ea78e82-0b35-4e73-99ff-ad6b653bc103@odoo.com>
Date: Fri, 7 Aug 2026 08:51:23 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: `git push --porcelain` has no effect when deleting a ref which
 does not exist
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <27d95520-409e-4d1b-b8b1-37a910bff604@odoo.com>
 <xmqq33wssf6x.fsf@gitster.g>
Content-Language: en-US
From: Xavier Morel <xmo@odoo.com>
In-Reply-To: <xmqq33wssf6x.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/08/2026 18:30, Junio C Hamano wrote:
> Xavier Morel <xmo@odoo.com> writes:
> 
>> Using `push --delete --porcelain` with refs which are extant correctly
>> outputs the relevant information in the documented format:
>>
>> -	:refs/heads/<branch1>	[deleted]
>> -	:refs/heads/<branch2>	[deleted]
>>
>> However doing the same with refs which don't exist on the remote (e.g.
>> because of a concurrent deletion) has the error written out in
>> human-targeted text:
>>
>> error: unable to delete '<branch1>': remote ref does not exist
>> error: unable to delete '<branch2>': remote ref does not exist
>>
>> I would have expected something along the lines of:
>>
>> !	:refs/heads/<branch>	[remote failure]
>>
>> which would be machine-readable as documented for the `--porcelain`
>> flag. Was that intended or is it just something that fell through the
>> cracks of code convolution?
> 
> If I have to guess, I would say it is because nobody thought of
> covering this usage pattern, which allows you to randomly throw a
> deletion request to probe what does and what does not exist on the
> other side.
> 
> Patches welcome.

Looking at the current code, the abort when requesting the deletion of a 
ref which is not on the remote is pretty early in the process, during 
ref matching, which then causes `push` to bail.

Reading some of the followup the following call 
`set_ref_status_for_push` can already set statuses on remote refs before 
the push, in which case such refs with statuses set will be ignored for 
the actual network operation (and the entire thing would be skipped if 
atomic), and then we get to the reporting and teardown.

So it looks like

- `match_explicit` could create a dummy dest ref and set its status to 
some sort of failure value (either an existing one or a new one) instead 
of aborting
- then `set_ref_status_for_push` should skip over refs which already 
have a status set (so it doesn't overwrite a previous error)
- push_refs_with_push all refs with a rejection status already set
- and then the formatting needs to get adapted for the new mode / case

And then trying to delete a non-existent ref would appear in the report 
normally, and valid pushes would be performed instead of ignored, unless 
`atomic` was set in which case they'd all be aborted, similar to other 
abortions from "pre-push" checks by set_ref_status_for_push.

Does that seem to make sense or did I miss something critical? Do you 
foresee significant issues?

Would you rather a new status code for this case or extending an 
existing case? e.g. I could see REF_STATUS_REJECT_NODELETE on an 
otherwise zeroed deletion ref for missing on remote, and a non-zeroed 
deletion ref would be the existing "remote rejecting the deletion" case 
so less code (and notably not push_refs_with_push) would have to be 
adapted, but it would make the new case a bit more implicit.
