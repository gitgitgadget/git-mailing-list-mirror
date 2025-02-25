Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D23719DF8B
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 23:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740526608; cv=none; b=ueTWVMFjv6bb7aQZ2nmF6EOo9cK/el5kv1zW2QEqspE39f5zchuosupsNDfK1Lxto/ERvxYO+VUT1K4ZeZzdFGEAVpLuog74lXXe5V/XPp/msmhnvv12J7JAbcpKgUvNMbzaiNxARK5tjZ/3UEhxWGcI5WKEKEH/fajPh44bq9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740526608; c=relaxed/simple;
	bh=aeRr2saUrXLwrParj/YY2/oCitdZAwS4Q81K4r9aCYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q41TPKMy0WkU4vOMs11IOFSWo5KsCSX1wQpAOg1uQOgN1Ff9h3kvQo36fgWnSJ4WCKJyJDcUG1RW4ZRtbC/Q78plQnzXv59hw+Je7DFop+MMe+c5VYI1w+JSWH1tFTg89FYYSjW7fYPrNXHatOFLcVihfT3LXtD9oyrSMbxUaKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCDsXXH+; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCDsXXH+"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6f768e9be1aso3908977b3.0
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 15:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740526606; x=1741131406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pxzej4Mso2BOGrk5FvZ6QwJ83HT28uJ7sttavOtyDjw=;
        b=kCDsXXH+AjAJmbnITG+LxFqOvjxuLxX4tuxoGzVpncoB6Pe2+EqOZbNLpP9MoFrbPv
         9pnz8mQKgHqsMiTAJfbeRwZT/um66ZczqIGskkxntCfmWCjO9oTF49GeRYjlmZBVCGhJ
         FRTU2RuK/tHmVWRkhgPIdyJyLqwF7SzvOgExxigs/d9CaR/PSwMZwJETVI6v1IrE9T5r
         GC5LujLlXTu19w0kudnSVoqNpILxMDuRqn9Ye79pZu7eBCoc72hNnNTYy0CPmTeVpiO1
         XvMQq6tAnv373PMYUHwOhuJXRbcbRHC9uIoFfBM1pDq085Da2ty/ovXGO1FQlAH7A7o9
         UW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740526606; x=1741131406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pxzej4Mso2BOGrk5FvZ6QwJ83HT28uJ7sttavOtyDjw=;
        b=rpDv8UKW20uH2Lc0eqTc+CukUpVh5mW4KRrnAF7HEIyb5yMLOUTUDs3W8cv26enIWs
         G8CgNn3imprIVVfzUfoIrEyp96CMS98IJ4aV2YHu/wwHMXfRB8WsmRZQJolaGQ/lun3l
         eLpPP9UIrpslOoDqBzXz5lj8xvRWf62M+otA4TfA7ehp0toscqzWhaBAxu9Tbz3YgetE
         xoGruqDgp9k1PKpOVOxYinsGVLN4qRG2An75qi0tTf8v1SXnBeeEqriIO1d3JM0JZxFo
         92ulqghznX/AbrYjwi9W37qo218oADgYiKj3h0oh6b0Vg8AMb8XrNZyxqSBRqAcvEUHB
         85lQ==
X-Gm-Message-State: AOJu0Yx56WuwezcDoqOOEWZOr0AcjJu7qHtB0hNJ9cvuj6aqxfDk+yyn
	k+nTDo07fWfEzpyfonhBIf5rfbO6O5Gtwpzumcu7jyuUDt0NDnjP
X-Gm-Gg: ASbGncvIdzTLEDxHSjLnjGvV7Bj5FZZM7yBzTdnEsW9pavt7oLgbDCsLHjkwCFjigGq
	xh+z5UEAsyAH/fbkOHYqXVP8NU6Vx4pt/uTNdVyfCr4OrtslmWfUVdqspmgmxx8DiEe0nhvKiBT
	o8eFRb3QPAVUg148JsW8PcGTg+AhDxgZQptUiUr+k0WHzZpZKCnxNnDzgPZ5NHGbxZnm4X7TqH6
	Q11vxMzNu8frOBVSowszPUVDlaf1YqLfUPiXwnbrGaLltz2PVh07kCN3+MpAjgsqJBlLR5fNlEQ
	qKRmPzQL2MSTcpObOqcmnI/qfIX3tXb6LM/NWKMkpItujdNaXklerG4Mq/lZk9A5/cwZ3yuge5/
	GbEr7TQ==
X-Google-Smtp-Source: AGHT+IEML8vBl2L86X+oHZsosikyCmwsg8B0q51uX2jzcpoupU74QUFwZZBtwLVxRcrKCMyaYxAysA==
X-Received: by 2002:a05:690c:7089:b0:6fb:949b:57b with SMTP id 00721157ae682-6fbb798bd06mr211584677b3.12.1740526605513;
        Tue, 25 Feb 2025 15:36:45 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:7124:6ef:e0:b8f2? ([2600:1700:60ba:9810:7124:6ef:e0:b8f2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd117dda1esm6896387b3.85.2025.02.25.15.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 15:36:44 -0800 (PST)
Message-ID: <3a180cca-0573-474a-8835-8015dbe09541@gmail.com>
Date: Tue, 25 Feb 2025 18:36:44 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bundle-uri: copy all bundle references ino the
 refs/bundle space
To: Junio C Hamano <gitster@pobox.com>,
 Scott Chacon via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
References: <pull.1897.git.git.1740489585344.gitgitgadget@gmail.com>
 <xmqqv7sxki36.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqv7sxki36.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/25/25 1:14 PM, Junio C Hamano wrote:
> "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>      Furthermore, when I bundled just a tag (thinking it would have most
>>      reachable objects) it completely failed to work because there were no
>>      refs/heads/ available for negotiation - so it downloaded a huge file and
>>      then still started from scratch on the fetch.
> 
> Nice finding.

This is an interesting case that I had not considered in the original
implementation.

The intention of the design is to avoid having the bundle URI fetch
changing tag refs, especially annotated tags. Those tag updates are
expected to be advertised in the "git fetch" output. It would probably
be best to peel the tag refs to a commit and then create a fake branch
for the bundle.

>>      Now I'm only getting an extra 43k objects, so 1% of the original total,
>>      and the entire operation is a bit faster as well.
> 
> That makes all sense.
> 
>>      I'm not sure if there is a downside here, it seems clearly how you would
>>      want the negotiation to go. It ends up with way more refs under
>>      refs/bundle (now there is refs/bundle/origin/master, etc) but that's
>>      being polluted by the head refs anyhow, right?
> 
> I am not sure what you mean by "being polluted by the head refs
> anyhow", but we should be equipped to deal with a repository with
> tons of local branches, so having the comparable number of
> remote-tracking branches instead of local branches now exposed in
> refs/bundle/remotes/* hierarchy should work equally as well, or we
> would have something we need to fix.  So in principle I do not see
> a problem with this approach.
> 
> The mapping used to be "refs/heads/foo" to "refs/bundles/foo", but
> now "refs/heads/foo" is mapped to "refs/bundles/heads/foo", so that
> you would presumably be mapping "refs/remotes/origin/master" to
> "refs/bundles/remotes/origin/master", right?  I hope existing users
> are *not* looking at their resulting refs/bundles/ hierarchy and
> somehow assuming the original mapping.
> 
> This is not something this "fix" changes, but unbundle_all_bundles()
> apparently is prepared to handle more than one bundles.  I wonder
> what happens when multiple bundles expose the same branch pointing
> at different objects?  The way I read unbundle_from_file() is that
> a new one overwrites the previous value, so even though we may have
> all unbundled many bundles, the objects from earlier bundles may
> lose their anchors, subject to be garbage-collected.
> 
> Imagine creating a bundle with two refs, refs/heads and
> refs/remotes, and append that bundle as the last bundle of a bunch
> of bundles full of local and remote-tracking branches, that have
> populated refs/bundles/ hierarchy with tons of refs.  Now the last
> bundle is unbundled, and these two phoney refs would nuke everything
> that used to be under refs/bundles/heads/* and refs/bundles/remotes/*
> left by unpacking previous bundles, right?
> 
>>      Is this a reasonable change?
> 
> This is mostly Stolee's design, IIRC, so I have CC'ed; the work is
> mostly from 53a50892 (bundle-uri: create basic file-copy logic,
> 2022-08-09) that is more than 2 years ago.

The biggest question I had (and tried to get ahead of on the PR) is
the use of a test to demonstrate what kind of bundle files cause this
issue. It would be important to demosntrate that the repo is still
usable if "refs/bundles/tags/v1.0" exists and points to a tag object.

>> -		if (!skip_prefix(refname->string, "refs/heads/", &branch_name))
>> +		if (!skip_prefix(refname->string, "refs/", &branch_name))
>>   			continue;

So I'm OK with relaxing this to be more flexible, but I'm not sure
why the bundles couldn't be created using "refs/heads/", possibly via
changing the ref names during bundle creation.

> By skipping only "refs/", "branch_name" is no longer a branch name,
> which may be something we may want to fix, but if we were to address
> the "names from later bundles seem to overwrite names used by
> previous boundles, and unanchor objects obtained from them" problem,
> I suspect we'd rather want to create new and unique names there,
> without assuming or relying on that the names used by these bundles
> are reasonably unique, so this part of the code may have to change
> anyway, so we may not care too deeply at this point.

Thanks,
-Stolee

