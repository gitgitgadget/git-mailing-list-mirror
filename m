Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505AA1B80F
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395396; cv=none; b=rm5i429kepzGeeHkBgzfvO/7QtLg1wqPJ1PvqDrYKHvRqkYSFJa7E1+xK+LVklvxTfyDRMfiQ0bjBqabwZKQOfFiazaKk+RlIShYId7at8dMcK78FqIf24G+KO2wRzqQGzV1X1Nt//UZc6Q7zGifYDTha897Ln1sLai+QHlWji4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395396; c=relaxed/simple;
	bh=bAIOOxRflrzCbW7kjbrhMVhRs4QoFZfSTimggs5Tf1c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pBnwFkQLS43vsufFgjh332EzrSmDEd5RliJdxw53T3TKGjhB5eckG6+GtB1QT74Jnj7UbGyWO8NCK37prrRYjYxjw0mixyDaP6J7WwwhmeRoq9kwPdWZKJ7agzxdbIuzFWtf07DAJ5Kws5eVT2X7XqPFae0TkA1cQQ0frkroV4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpQG+Tst; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpQG+Tst"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56c2787aff5so102505a12.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 12:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711395392; x=1712000192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jVsxhzNue3U6Hi+nPnKIZFTWvgCMGrVdacygdHdfZLM=;
        b=PpQG+TstU2RhfyRTuVDw9cAMoMynZlfAl2XtN8zIBIAAfkq4/K0oLzA3Fswu2cfL3z
         SInkVUF3MCNv0biOm+0wkuvJsbiScbl90WzDDiVfw3e54xkJIOFL+1/bgOX2nrEBcj+j
         8S3L/7gBvGCjFVUf5DvqKjUD4qB/QFwEzBYj2xrqTfuMD/x1+UCsSN5B4N1QtWKvlaIL
         Fk5VaAQRiISq/1SZj1ypafMFv/UVlezFeJzxNuv2fzyOjtDPkI+TIxZ78dpJww2wGSRD
         UNv0/ENB0TNEE//z7JT+u9VBm9QcKKvppt/Sh0B5D4/Ny988TAlvN7B9v3E8xcpQroJi
         2sgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711395392; x=1712000192;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVsxhzNue3U6Hi+nPnKIZFTWvgCMGrVdacygdHdfZLM=;
        b=mUgetG1WxhIFb/viKckcsgjdF0/8SeDH2/eu4/OMKwnsw2fS4lOH2Ad2Ei1++iXHy6
         62aCsbKrLwu9+IRNCkGTeOhsNpgzyFObTstAe2qRTm0KQwkjCe0QozXmydyRNzV9h3xI
         wEmhGnhWrqVKowrJl6l1oTJZESjkOxTF+0TPFfe4eTIZaiYjbanMVsjC/goY6gOJiQKG
         bqrw9MAvGufYGVL3xS2rGYhY7maeWIqeQhZFWuw7nJXVYH2WdRzAexyEyn5megoqHsn5
         oOOu/Y3kMmSdZS8HeDlxAfOLSglswDsfKsaRGRbSjaT/HBYLq1Rqg70rv09YcMZoB0he
         U0dw==
X-Gm-Message-State: AOJu0YzIvt9XAN5qmhCxxMbV4CuCONIhG9HE4j8ta1x0LEZ2LR5n4Ub2
	VINcJYZYgV9PoBV0Ez3hYgYvPzrwHbB9O/ePJ4GaWyyB09GsFyuB
X-Google-Smtp-Source: AGHT+IEI/hHQf7/eIXByq8F660TdKSPOMlLO1JvWrlpOFAq+g+M7TZk6lasQsxAQvEoEXOOLcnUmCg==
X-Received: by 2002:a17:907:a0a:b0:a47:52e7:1068 with SMTP id bb10-20020a1709070a0a00b00a4752e71068mr3551825ejc.52.1711395392471;
        Mon, 25 Mar 2024 12:36:32 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id ws9-20020a170907704900b00a46caa13e67sm3348787ejb.105.2024.03.25.12.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 12:36:32 -0700 (PDT)
Message-ID: <2ab7445f-08ee-4608-96ad-8171f9ce1b73@gmail.com>
Date: Mon, 25 Mar 2024 19:36:33 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/7] cherry-pick: add `--empty` for more robust
 redundant commit handling
Content-Language: en-US
To: Brian Lyles <brianmlyles@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, newren@gmail.com, me@ttaylorr.com, gitster@pobox.com
References: <17c00de527e3a0c4.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
In-Reply-To: <17c00de527e3a0c4.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian

On 25/03/2024 16:12, Brian Lyles wrote:
>>       ++		head_name = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE, &head_oid, NULL);
>>       ++		if (!head_name || !starts_with(head_name, "refs/heads/") || !is_null_oid(&head_oid))
>>
>> While we don't mind the occasional line that is a little over 80
>> characters these really are rather long.
>>
> 
> You're right, these got a little long. I wasn't able to identify a
> definitive wrapping style for these cases, so I'll include my proposed
> update here just to avoid another re-roll. Does the following diff from
> v4 to a proposed v5 work for you?
> 
> @@ -776,11 +776,13 @@ static int is_index_unchanged(struct repository *r)
>   	const char *head_name;
>   
>   	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL)) {
> -		/*
> -		 * Check to see if this is an unborn branch
> -		 */
> -		head_name = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE, &head_oid, NULL);
> -		if (!head_name || !starts_with(head_name, "refs/heads/") || !is_null_oid(&head_oid))
> +		/* Check to see if this is an unborn branch */
> +		head_name = resolve_ref_unsafe("HEAD",
> +			RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
> +			&head_oid, NULL);
> +		if (!head_name
> +			|| !starts_with(head_name, "refs/heads/")
> +			|| !is_null_oid(&head_oid))
>   			return error(_("could not resolve HEAD commit"));

Normally we'd write this as

	if (!head_name ||
	    starts_with(head_name, "refs/heads/") ||
	    !is_null_oid(&head_oid))
		return error(...)

breaking lines after an operator and indenting to the open bracket after 
the if. The rest looks good. Junio was talking about merging this to 
next in the latest "what's cooking" email so I'd double check he hasn't 
done that yet before re-rolling.

>   		head_tree_oid = the_hash_algo->empty_tree;
>   	} else {
> 
>> Apart from the minor style issues this all looks good to me, thanks
>> for working on it, it will be a useful addition to be able to drop
>> cherry-picks that become empty.
> 
> Thanks, I really appreciate your help with this series!

Thank you for working on it, I've enjoyed reading your patches

Best Wishes

Phillip
