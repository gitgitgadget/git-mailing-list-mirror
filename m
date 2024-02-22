Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE19014C5AB
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619693; cv=none; b=pWr9H7fIVzeFZNjRvb3cz9YwS71P2TLFdgNU3gjLoUDbBTwf+Ozv/p6fDUtP5YO8nbWvehhtwX3cUKDB7eH+iY0g5GngcDWky9uBF0/s6pyobu6+4Nm3xb4K0X56oD3dMQiX0lUthSdt0YV1vaiIIpv0euVngFUxAcZ83Dq8GME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619693; c=relaxed/simple;
	bh=JtQq9OAjcS5PBMo28nw/9yQrQGY2BnrUTti6OfHsnTw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=d/I7ZvTFEl8MqajMRDbgm7eOlqNZ+Hro5QFk0RPG3kAlQeopc7E8jQOqU3UFvuDGseuWYkBjGwBuOR6oZ/OYbhDZSXyxtHujJXsVieEf2ChsK+x+gH39pEnRed452MzSMTxqkhGAI5+CpNT5bqP2pMEBWgvWJlfdg4IELMt3t3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZumMLdY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZumMLdY"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4128cfb6c1aso3999215e9.0
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 08:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708619689; x=1709224489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VLOp/bRuHVPAnBAzHAWrDyRi8cAJVx0hCTsvUzXEttU=;
        b=dZumMLdYLnj9DleMuNHQuuEmAzbOxwEf+hJ4c+mzGKKUHDlH2cdhq7Rtodg3FFJANZ
         7KTK/Fgu7P1AOm2h4YIKt4jr5RHEE6FBBVo0QY8hZu1I+6woQTFX8fy2BvjAre6+Koen
         2eK5u4VJ6EdVuzs5sddcdVJdo5/oi/L0Zv+HNupk+uR7yluyo7yDpS7tTxFETMls8ceg
         dNAjQBDe//MmslDc0KMRGLrb+62gBWiUv/nZF0NR0l3zm6uGFNTZFgMkvRtZ2bYUZcl3
         eSs5D/fSa8iB4N+mtUG0LhsKJmBC/5axp4Jd7GnJcYYD30WRyZ/ISzczHCv/zyyWryE5
         zzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708619689; x=1709224489;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLOp/bRuHVPAnBAzHAWrDyRi8cAJVx0hCTsvUzXEttU=;
        b=ogsfIFPoa99zc8euzPlRfLo8teSoLXEsyYBWIAVXQY5jEtEv3Sca3Xd4AoXCzkMeqv
         UGkqhvrJgoYFLWwNgmdrRcaQceijbuYoPvnRo7aTU171hVcuZHHG3fw30GbxlbFllGSG
         OYI8jm0RdJ05+0zJERAsrk02MTmjmdkIyVJjOyulLuMV/K4II+8HJedpo+OqavWt9FVZ
         jOiByrc/npl1OuAzi/+ZnAqFYho4I3Zf0FZ5SrmCmgMwkBIDN8H06qf7eY+JJpWKkKbc
         jPhXZIDI45yc64gnWAnPD/ftwEGKMTs6iudRwUkr22MnJzTOm5RhF2dWtLG1DulFBhME
         BFzw==
X-Forwarded-Encrypted: i=1; AJvYcCV7ofwRobxAD/l+/cFmtGP7OFxsRvWRv1x3Wg/R/XE+Uh4h729ctYgnDCDxxh3oxdEHawNpuc5qYm2uPgd3q1pdCZnP
X-Gm-Message-State: AOJu0YzCSWtVWKvGKyN8bdEHXibp3IB8MpZ1Rtsge0ljxndhYXDe2ugG
	BYB+9qpyFGYPrrc/Av3RQ4gIgLBTJxwd3buzIwEtQqs1T0NSID8TMjhlwqdx
X-Google-Smtp-Source: AGHT+IH9e3hfmWuW8v7uO4CBf2uIDME60YJn9qpzkyjm7WShZWcYCC5kaQ5YDVkN09NFe9sBYHbA8A==
X-Received: by 2002:a05:600c:1c9b:b0:412:9008:1f28 with SMTP id k27-20020a05600c1c9b00b0041290081f28mr169101wms.12.1708619689073;
        Thu, 22 Feb 2024 08:34:49 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:69d:3501:4b27:339f:196f:f7f9? ([2a0a:ef40:69d:3501:4b27:339f:196f:f7f9])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c281400b0041214ff06cesm21901857wmb.42.2024.02.22.08.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 08:34:48 -0800 (PST)
Message-ID: <08073d69-18f4-40c9-90a5-23db914c163e@gmail.com>
Date: Thu, 22 Feb 2024 16:34:48 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/8] sequencer: treat error reading HEAD as unborn
 branch
Content-Language: en-US
To: Brian Lyles <brianmlyles@gmail.com>, git@vger.kernel.org
Cc: newren@gmail.com, me@ttaylorr.com, gitster@pobox.com,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240210074859.552497-5-brianmlyles@gmail.com>
In-Reply-To: <20240210074859.552497-5-brianmlyles@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian

On 10/02/2024 07:43, Brian Lyles wrote:
> When using git-cherry-pick(1) with `--allow-empty` while on an unborn
> branch, an error is thrown. This is inconsistent with the same
> cherry-pick when `--allow-empty` is not specified.
> 
> Treat a failure reading HEAD as an unborn branch in
> `is_index_unchanged`. This is consistent with other sequencer logic such
> as `do_pick_commit`. When on an unborn branch, use the `empty_tree` as
> the tree to compare against.
> 
> Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> 
> This is another new commit that was not present in v1.
> 
> See this comment[1] from Phillip for context.
> 
> [1]: https://lore.kernel.org/git/b5213705-4cd6-40ef-8c5f-32b214534b8b@gmail.com/

Thanks for fixing this and adding a test, I've left a few small comments 
below.

>   static int is_index_unchanged(struct repository *r)
>   {
> -	struct object_id head_oid, *cache_tree_oid;
> +	struct object_id head_oid, *cache_tree_oid, head_tree_oid;

I think we can make `head_tree_oid` a pointer like cache_tree_oid and 
avoid de-referencing `the_hash_algo->empty_tree` and the return value of 
`get_commit_tree_oid()`. I think the only reason to copy it would be if 
the underlying object had a shorter lifetime than `head_tree_oid` but I 
don't think that's the case.

> +test_expect_success 'cherry-pick on unborn branch with --allow-empty' '
> +	git checkout main &&

I'm a bit confused by this - are we already on the branch "unborn" and 
so need to move away from it to delete it?

> +	git branch -D unborn &&
> +	git checkout --orphan unborn &&
> +	git rm --cached -r . &&
> +	rm -rf * &&

"git switch --orphan" leaves us with an empty index and working copy 
without having to remove the files ourselves.

> +	git cherry-pick initial --allow-empty &&
> +	git diff --quiet initial &&

I'd drop "--quiet" here as it makes debugging easier if we can see the 
diff if the test fails.

> +	test_cmp_rev ! initial HEAD
> +'

Best Wishes

Phillip
