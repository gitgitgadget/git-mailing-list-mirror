Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532AA29993D
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751888147; cv=none; b=Sj3ctHQivT6Cng9tdFR8Hy85KWN9GEAQZ9+faf2saDo8CSNcX/gP+9hpJGhc6bzuFINMGCgjXHMpWp/zAsM87HVFgCL0vrWq5o5ISWcqy1sLlBp7+FvBpvQ28jI9ihCw98Jji9YD3BGXGpStYEehe4XCYP67QDTe2/VhL4Og0oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751888147; c=relaxed/simple;
	bh=G50lk6qpg42B025RZnlwKbdeiOFn6y2y9zy8to5mD0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzXk8Vd1PV3fM2m/WPfrIrhJayZgdXBe3nBazrUM20ABoMeDYi2Fsu3GjFLK6atAIQEGKg3t9aCMz/S6v9SIxs1Iw+Lr4+Obag/iR4WDf0ywbjUttZwa5ub8T51o5hJp/pV83cRd9k5NoLtm6qtTkeL2FkJuUnZGRAxJl5WfBPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dn6H6skb; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dn6H6skb"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e8b3cc05665so1122528276.2
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 04:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751888144; x=1752492944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7LhKSNc9IXjFs0PBN2aynScRV2FTS+b8jVPkWYpQQ3o=;
        b=Dn6H6skb7w4YQ6J9ahPwYFBSEFGxcWk4t61zbPNRfseCpdQ5vFFdcH9NmgG29T8JBw
         nW4PqfH/bVAJCF+2USu3fUVxLz5N5mTgqyo752VLcDc+IsdTMwss05VjO7ssSFek741A
         s+42rXw1W/Vb8BAPZ8t1/EXUIPMxZg+G5W5OnlZd/M+IG/NlZXcIk8I24ULFUo+YTuMH
         iV6llHhPzW38aytco3wHcgpNN98aAuPcP/9cesPRQvrKP00StKdzjlFePhY9p8TpgyH2
         pAykRj207zuPUfDISxB7Uiv+CH24BqRo04CyDwRPu9nI0KTwFT/RefByQPYlCLXJP5l+
         Dt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751888144; x=1752492944;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7LhKSNc9IXjFs0PBN2aynScRV2FTS+b8jVPkWYpQQ3o=;
        b=bI03E4hQoCywem7ldktGYdeP593oK6ghlWRCpltPw/iyKBV996dhN2Swy2c4f5U07V
         EcQhyZ8DhgvMuCVOSfC4ttW23gA9j3sxivNqTpABGXpWoE/cBg4ppxPSH+E3TjBN8Tfy
         a/JDYr5P+CDRClMLnkvFHEbY6YQGy9Lqljq/xpi0HXXOPkXdx8z1Q5LVbrWE7ZQ8so0T
         VP6A2n3f9TjZO/93r6nm41CDHXeslOQGimH5Jjd4uMOUlZ0kVWAr/xbEWbKtLBNE0R4t
         unv9hWshEZ2drftsQYZ/0kU25+xlep+otql+WyOZppKsOHRSMNvUpvlNC0zncjFFNT5r
         gYKA==
X-Forwarded-Encrypted: i=1; AJvYcCUyypN06N7Mn6I57T/o/LvQbQRy9rLTF1U4C70EAxfcwZwWzMCFGR17IcROwGxHqzpSXaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDXOfx712gDa/gsrZxzWx5vgNgYXw1OujR78b70nLL45ZiRybQ
	hKmaGbxUYrtGTckxEozWUIpgy+H7siPh3kcuUpByY0+Wf4udLv3Hzjcsvigb5VcG
X-Gm-Gg: ASbGncu/xxxceEPhNc+u54jFpztiy4sOMxz/+tOhVOS6UHrt2TQw7+bdaTlst04SAzt
	6ldaRqRJFlfwMt/hnLZSXuEnhEWcFwKoU9kC8lJYmkZmaBfpoDMTuVyxGBGIS39sbPEf7xD6rkT
	CdVolpJ008KWKvgQ8w+j30vdl3wvCyxqm7t2nTVmVfVUGX8VLMMMlWANoChUQiWch2Lw87T94qm
	nF3ZQoAIi+QpvbgZRvIK6MSbLl8t19c6jrq+ULk58z/VlL1DogJ6c2w4JktfRu/RTFN7ZJK/W+i
	JJ0v333FggqlgSwKqm3GRW4nYTKztdaygYEjJ1lJmtB+lKnasSdKONFdoqFBf0H40E+xe+ZGQiV
	2b8Xxjgf+Pn5n/JE2lQejOCMxNNQWLDlJ3piE7cJABeVfaj9V
X-Google-Smtp-Source: AGHT+IG13V/mbSbV/oxrZSWOzOwR7+TqVl+M+HMs5ErcMx/Zcs7zPvaSmNIqtSMnbT64e2/9fOyf+Q==
X-Received: by 2002:a05:6902:98f:b0:e81:d976:ce25 with SMTP id 3f1490d57ef6-e899e129d84mr16401900276.3.1751888144138;
        Mon, 07 Jul 2025 04:35:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:cccd:72a3:daa2:c18a? ([2600:1700:60ba:9810:cccd:72a3:daa2:c18a])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c43eb83sm2614639276.32.2025.07.07.04.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 04:35:43 -0700 (PDT)
Message-ID: <65dc80f9-a91c-463b-9c6b-cb20d293432b@gmail.com>
Date: Mon, 7 Jul 2025 07:35:42 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] bloom: replace struct bloom_key * with struct
 bloom_keyvec
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: 502024330056@smail.nju.edu.cn, git@vger.kernel.org, gitster@pobox.com
References: <20250628042140.1097910-1-502024330056@smail.nju.edu.cn>
 <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
 <20250704111437.2660251-4-502024330056@smail.nju.edu.cn>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250704111437.2660251-4-502024330056@smail.nju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/2025 7:14 AM, Lidong Yan wrote:
> The revision traversal limited by pathspec has optimization when
> the pathspec has only one element. To support optimization for
> multiple pathspec items, we need to modify the data structures
> in struct rev_info.

You are correct that the revision-walking abandons bloom filters
when there are multiple pathspecs, and fixing this is a valuable
effort.

The need for this change is subtle and could use some extra context
to be sure reviewers understand:

This change is writing over some code that was created in
c525ce95b46 (commit-graph: check all leading directories in changed
path Bloom filters, 2020-07-01) to allow storing multiple bloom
keys during the revision walk. The multiple keys are focusing on
multiple path components of the literal pathspec. 
The point is that after the initialization, the bloom key array is
used directly as a filter for reporting TREESAME commits: a commit
is automatically reported as TREESAME to its first parent if any
bloom key results in a "No, definitely not changed" result with
that commit's bloom filter.

The reason we need a new data structure is that we need to adjust
the conditionals.

BEFORE: "NOT TREESAME if there EXISTS a bloom key that reports NO"

AFTER: "NOT TREESAME if FOR EVERY pathspec there EXISTS a bloom key
        that reports NO."

This "FOR EVERY" condition makes it impossible to use a flat array
of bloom keys for multiple pathspecs, justifying this change.

What is further confusing here is that we already have logic that
deals with arrays of bloom keys, so I expected that the vector was
the single structure storing a list of those arrays. Instead, the
vector is replacing the array itself. This is made clear by using
the vector immediately in the existing implementation.
> +struct bloom_keyvec *bloom_keyvec_new(size_t count)
> +{
> +	struct bloom_keyvec *vec;
> +	size_t sz = sizeof(struct bloom_keyvec);
> +	sz += count * sizeof(struct bloom_key);
> +	vec = (struct bloom_keyvec *)xcalloc(1, sz);
You could use CALLOC_ARRAY() to simplify this and drop
the 'sz' variable.

> +	vec->count = count;
> +	return vec;
> +}
> +
> +void bloom_keyvec_free(struct bloom_keyvec *vec)
> +{
> +	if (!vec)
> +		return;
> +	for (size_t nr = 0; nr < vec->count; nr++)
> +		bloom_key_clear(&vec->key[nr]);
> +	free(vec);
> +}
> +
>  static int pathmap_cmp(const void *hashmap_cmp_fn_data UNUSED,
>  		       const struct hashmap_entry *eptr,
>  		       const struct hashmap_entry *entry_or_key,
> @@ -541,6 +560,18 @@ int bloom_filter_contains(const struct bloom_filter *filter,
>  	return 1;
>  }
>  
> +int bloom_filter_contains_vec(const struct bloom_filter *filter,
> +			      const struct bloom_keyvec *vec,
> +			      const struct bloom_filter_settings *settings)
> +{
> +	int ret = 1;
> +
> +	for (size_t nr = 0; ret > 0 && nr < vec->count; nr++)
> +		ret = bloom_filter_contains(filter, &vec->key[nr], settings);
> +
> +	return ret;
> +}

This implementation is where the subtle detail comes in. Might be worth
a comment to say "if any key in this list is not contained in the filter,
then the filter doesn't match this vector."

