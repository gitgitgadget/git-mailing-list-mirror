Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925C038DD2
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076209; cv=none; b=H5hMpp8LGd3VvulYuKrh/aR0nAQYFm4Zuo1weVyqkMmeigjK7trk9BXJmoMpujn8c3QsKPqZ3B0tkl8A5vqnP9cN0HO8l1VCVWIayGzGz4hK8Q7LzTpk+WorQMyl4oWZfH3ktFk30djt4r5G2tYXPjvLwkXhd0y3J/ifLbyf1Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076209; c=relaxed/simple;
	bh=iKYxYzIT/wgEEiRj9WS5EzGgXQAs4gjUK/fR91lKapQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSR2T4uumtNVs906Rv/8fYbumYRwy+72W2PlXBzEE/9etMcsGNRXX/B97ExIc1xmkWyjuOWL05LE/SEc7XcAuO4qdBf6zbVQgvcvag2MC7JSlpRfbBuiobF78xNfBmnfknK4um8PIGvIa9ubSuTnI4ffWMvCRnPXGUnrJWZPr8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ol4ftzPc; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ol4ftzPc"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c4de828f22so494448b6e.1
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 09:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712076206; x=1712681006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6S840LaUvMABApFR4zqz0Wyq2R4r2I6PDxM+gmTmdeo=;
        b=Ol4ftzPcueeQikaVPV4GKvt+pVvKUF7YsDx5VqMiNRMC30mr9nqDl0FO8kaLjXY+OL
         ucOw8RA5Y0kOAbwkwDGHH1xPyTk0ytQ1diUaVwQVykEdJDsUZkH51NySvlomqWgbMeyp
         zHZkNkyW4UNynqWPYYVcWL2DGcA4ycTHQP3Fa02znpxA0RJhwvh9ddsrKisqHI1nlf3d
         ZXp+K5DP2AxeNNML5Qxo7Ky7fbxuantAU1KyWeJjJaaDgnPWnSsi+qSPNqnKDUBCrbqp
         aRtNa/U3QVaHLW6UihDU3jq4rOafn3k+m1luyqvsPB99ipose3FrA2paXW00tGVOl0HU
         eATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076206; x=1712681006;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6S840LaUvMABApFR4zqz0Wyq2R4r2I6PDxM+gmTmdeo=;
        b=eORs2YxWRhiR1/m8Jjhiha4kNixSqmNOt6x7OB8SRJ6wuZ2vamJQKGUuV8kjToyyZR
         HLySUgyCFZMhwS8p+L8e/2ysZ4A0WymWpMT2BKgVugzfrCjqDUjZyJaZsKNR385Ee14V
         plddVmBDn9MLDNlETq6Vr7JCC2wYxiX2qsvSRcaprenl0/AIEL58/jHV2JzsDA2w1YlV
         xw5FVJ65aLfAKNDQpw+oHU3WyBSFHpEkV9X5DfopnB2e4BpQaWmcVFKMnd9zpRnkMUOX
         MPDsNDFsok2Jd+DDYU0CgOrfSWOIH6fL/UL5fOmzfrJnlz16NGpHj7Amlu0U090cYiHD
         Veow==
X-Gm-Message-State: AOJu0YyMIHdRJpnc4ofkmv7EVUAvIZEvyYGl7t/BOfnJQFbBLtdgCybj
	CddQsrq4dFmrO6UkToc8fyM/eUsJhSR7OtMIwCkTjaLcHNKt1iqaeNy7T9Is
X-Google-Smtp-Source: AGHT+IE+U8O/p80s1SVSlFIoIKFPb8zLlaBOhmkKicdGtGMNbkkRxn8VbdOMy6ZPycXexyv6HD1Ndg==
X-Received: by 2002:a05:6808:428a:b0:3c2:261b:468c with SMTP id dq10-20020a056808428a00b003c2261b468cmr12751645oib.23.1712076206512;
        Tue, 02 Apr 2024 09:43:26 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id 9-20020aca1209000000b003c37f801cd2sm2165415ois.40.2024.04.02.09.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:43:26 -0700 (PDT)
Date: Tue, 2 Apr 2024 11:42:29 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 4/7] reftable/block: refactor binary search over
 restart points
Message-ID: <45v2z6uszlkanwl5qhvio4ikrrytztohbmdpnmdwiefyznclum@xhbvlvnfmkmq>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1711109214.git.ps@pks.im>
 <cover.1711361340.git.ps@pks.im>
 <5e20d93ae000359f2231bf950a930cfc4898ced2.1711361340.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e20d93ae000359f2231bf950a930cfc4898ced2.1711361340.git.ps@pks.im>

On 24/03/25 11:10AM, Patrick Steinhardt wrote:
> When seeking a record in our block reader we perform a binary search
> over the block's restart points so that we don't have to do a linear
> scan over the whole block. The logic to do so is quite intricate though,
> which makes it hard to understand.
> 
> Improve documentation and rename some of the functions and variables so
> that the code becomes easier to understand overall. This refactoring
> should not result in any change in behaviour.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
...  
> -	i = binsearch(br->restart_count, &restart_key_less, &args);
> +	/*
> +	 * Perform a binary search over the block's restart points, which
> +	 * avoids doing a linear scan over the whole block. Like this, we
> +	 * identify the section of the block that should contain our key.
> +	 *
> +	 * Note that we explicitly search for the first restart point _greater_
> +	 * than the sought-after record, not _greater or equal_ to it. In case
> +	 * the sought-after record is located directly at the restart point we
> +	 * would otherwise start doing the linear search at the preceding
> +	 * restart point. While that works alright, we would end up scanning
> +	 * too many record.
> +	 */
> +	i = binsearch(br->restart_count, &restart_needle_less, &args);
> +
> +	/*
> +	 * Now there are multiple cases:
> +	 *
> +	 *   - `i == 0`: The wanted record must be contained before the first
> +	 *     restart point. We will thus start searching for the record in
> +	 *     that section after accounting for the header offset.

To clarify my understanding, does a restart_offset not exist at the
beginning of a block? I was originally under the impression that the
first reset point would be at the beginning of the block (or just after
the header). If this was the case, the first restart point being greater
would indicate that the wanted record is not contained within the block.

-Justin

> +	 *
> +	 *   - `i == restart_count`: The wanted record was not found at any of
> +	 *     the restart points. As there is no restart point at the end of
> +	 *     the section the record may thus be contained in the last block.
> +	 *
> +	 *   - `i > 0`: The wanted record must be contained in the section
> +	 *     before the found restart point. We thus do a linear search
> +	 *     starting from the preceding restart point.
> +	 */
>  	if (i > 0)
>  		it->next_off = block_reader_restart_offset(br, i - 1);
>  	else
> @@ -399,21 +429,34 @@ int block_reader_seek(struct block_reader *br, struct block_iter *it,
>  
>  	reftable_record_init(&rec, block_reader_type(br));
>  
> -	/* We're looking for the last entry less/equal than the wanted key, so
> -	   we have to go one entry too far and then back up.
> -	*/
> +	/*
> +	 * We're looking for the last entry less than the wanted key so that
> +	 * the next call to `block_reader_next()` would yield the wanted
> +	 * record. We thus don't want to position our reader at the sought
> +	 * after record, but one before. To do so, we have to go one entry too
> +	 * far and then back up.
> +	 */
>  	while (1) {
>  		block_iter_copy_from(&next, it);
>  		err = block_iter_next(&next, &rec);
>  		if (err < 0)
>  			goto done;
> -
> -		reftable_record_key(&rec, &it->last_key);
> -		if (err > 0 || strbuf_cmp(&it->last_key, want) >= 0) {
> +		if (err > 0) {
>  			err = 0;
>  			goto done;
>  		}
>  
> +		/*
> +		 * Check whether the current key is greater or equal to the
> +		 * sought-after key. In case it is greater we know that the
> +		 * record does not exist in the block and can thus abort early.
> +		 * In case it is equal to the sought-after key we have found
> +		 * the desired record.
> +		 */
> +		reftable_record_key(&rec, &it->last_key);
> +		if (strbuf_cmp(&it->last_key, want) >= 0)
> +			goto done;
> +
>  		block_iter_copy_from(it, &next);
>  	}
>  
> -- 
> 2.44.GIT
> 


