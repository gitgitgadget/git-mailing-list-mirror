Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17BB2D7809
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751536927; cv=none; b=aUpNGjAx/K3ny9VCbXDNkaDR88V5eY5Jnl2EFUfPeLFE/4YHvahktu0lXqHc6QnqOrQspKw6rSzhO9l//AuhBixY58iKRKYmYManRU7u2lELn5JEc5eC/RehGmlc32P87LmeJdWDet93WaKUnFmAKZWd3C4aROSsK4MozDG5Jhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751536927; c=relaxed/simple;
	bh=pU25g9n0l0KiSAzmXQ0jfa4XOd2ZWIdkM7xvqqCcpQY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6gROrZJ7raLtTnIQjrALlecvNSI2TE4nHoSUJghyUVs3e36jfblNY9t0w9q6noDOfKW+/sreMOfAWbMLjdW0K8puGigllzfY+s7U92Jb+icUPzxPi9rCKc5t4S8frGz3d8ArfXyilkqWBBMxoFqK0q4AHS95xTWxqnFaGXBufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hN5brba9; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hN5brba9"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-87edd8f4e9fso1941726241.0
        for <git@vger.kernel.org>; Thu, 03 Jul 2025 03:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751536925; x=1752141725; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CeqHTP7JyNspqu7k6Y5ZAphN0SQKqhNbxb2FCW0Jcf8=;
        b=hN5brba9IQS8Mwp5WfKQ5IuNUAnFwt5U2C4Z61NvKrKsbQp24EgSEhs2f3jtfPzhlD
         XAugEtu/7dNe2mHrDOv2DwFtG0SxKuZJhQPLL5v9lSxf83kFdWTwqhnzrJQl+OSIAW7T
         iF4fi3bsix66qKaszOu6h7WmGnxyBpxL6hhiY4nN+J3QGMPEggKXimfYQlEbtCfgLN8B
         CKFnIZWhwRPPxeC5rD/FnefHF/azyeX6hGos3aDZC7v+6g+gGf0q7csJA81ERqNMzQAc
         rmaSq6kmWT+Cu9xqZEEq5DTQG0jKB4ljJU2acg3q0wl9JMuAII42nm5lgD8ITkIFBQoU
         paSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751536925; x=1752141725;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CeqHTP7JyNspqu7k6Y5ZAphN0SQKqhNbxb2FCW0Jcf8=;
        b=FJyUf/jPzM6mRkmAGo0ieNnmvF+Y8uDDI0G+Z3IOh3Jez10oYky4Wee+yc5vtblRr7
         Zffygxfc39P1jjrNlncp9Lc1IZqr3tN3o/Yxf+vnUCcAcmI0CQy7mhqtfHLcPCH7f/Rc
         MHnoWnu2KjeFkvrrSvF5BXeXPaP8BQV2JqFLVIbl0BglAFFTm9h6aHtVOq1NhNnf0l9V
         /dJubXx+FFbll+UC+L3slH1fE55L5bU5BhT5Nn/ABaXi3VWuqkcMx2a2csfxKgInBRj+
         kJpCeEUvPs3PDgi4avIWz45SBmgk8mrMwYSLMZmyi6VL+cVM5toEaBGYRDR2iK/KhtFo
         fnRQ==
X-Gm-Message-State: AOJu0YzOCr1eGphdINRyiaLlAuW037gdl/zO+V4c7ZSdvD3Ktv4WNs7H
	poXIc27FP9CGQjJOZr5+bgBDrueuoG3w6D5mUpNRy9JpQDg0HVIrYwfOdB0gVWqmfccHZt//D+n
	gUxeSMFVnM2Ymr+EbC3J71RBaXazc7fN5hA==
X-Gm-Gg: ASbGncuc7cAPD7wrWKfDlz7sefJP2HO4KlukhUmi9iiAM/H98dwizr852Xl05isVjeB
	30o15kuJ6Fcy1skX601Dq5PrIq8fbKj+jUzTmY+GZ09IlXYmaVZGe+CUicg6FTRuWWajvGFd/DM
	lhTn6Q5ybMANNVsTM9zWRDgd6wj+48RcMEhCJzJPq8SgmtwMbub2annyw=
X-Google-Smtp-Source: AGHT+IGSevEZcbFSKNVMesJeHdYwOoyzDAZr66cuvodtl4Y+TtdQdPtbCZBlcyd/MNx3LRNWAB+ZJi54Q8VIdWsCe/w=
X-Received: by 2002:a05:6122:80a7:b0:531:4041:c4c5 with SMTP id
 71dfb90a1353d-534583a9af0mr4470560e0c.7.1751536924776; Thu, 03 Jul 2025
 03:02:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Jul 2025 03:02:03 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aGYbZcXP2voT2IYE@pks.im>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250701-306-git-for-each-ref-pagination-v1-4-4f0ae7c0688f@gmail.com> <aGYbZcXP2voT2IYE@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 3 Jul 2025 03:02:03 -0700
X-Gm-Features: Ac12FXye-I2p-TSlxkpWbl6fbpwYWoIDGSfBjYj64AeGvODL90GzmhugBMQt5jo
Message-ID: <CAOLa=ZQvY6+fU-xDTH5jnrZxAsx2LxB2t-2QDu-8WpNrFpwjHQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] for-each-ref: introduce a '--skip-until' option
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000368b19063903781d"

--000000000000368b19063903781d
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jul 01, 2025 at 05:03:30PM +0200, Karthik Nayak wrote:
>> diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
>> index 5ef89fc0fe..4bf7c66b8c 100644
>> --- a/Documentation/git-for-each-ref.adoc
>> +++ b/Documentation/git-for-each-ref.adoc
>> @@ -14,7 +14,7 @@ SYNOPSIS
>>  		   [--points-at=<object>]
>>  		   [--merged[=<object>]] [--no-merged[=<object>]]
>>  		   [--contains[=<object>]] [--no-contains[=<object>]]
>> -		   [--exclude=<pattern> ...]
>> +		   [--exclude=<pattern> ...] [--skip-until=<pattern>]
>>
>>  DESCRIPTION
>>  -----------
>> @@ -108,6 +108,10 @@ TAB %(refname)`.
>>  --include-root-refs::
>>  	List root refs (HEAD and pseudorefs) apart from regular refs.
>>
>> +--skip-until::
>> +    Skip references up to the specified pattern. Cannot be used with
>> +    general pattern matching.
>> +
>>  FIELD NAMES
>>  -----------
>>
>
> Is it "up to and including the specified pattern" or "up to but
> excluding the specified pattern"? It would help to make it very explicit
> whether the pattern itself would be yielded or not.
>

It is "up to and including", will modify to make this more clearer.

>> diff --git a/ref-filter.c b/ref-filter.c
>> index 7a274633cf..9d0255d5db 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -2714,20 +2716,28 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
>>  		 * so just return everything and let the caller
>>  		 * sort it out.
>>  		 */
>> -		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
>> -						"", NULL, cb, cb_data);
>> +		goto non_prefix_iter;
>>  	}
>>
>>  	if (!filter->name_patterns[0]) {
>>  		/* no patterns; we have to look at everything */
>> -		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
>> -						 "", filter->exclude.v, cb, cb_data);
>> +		goto non_prefix_iter;
>>  	}
>>
>>  	return refs_for_each_fullref_in_prefixes(get_main_ref_store(the_repository),
>>  						 NULL, filter->name_patterns,
>>  						 filter->exclude.v,
>>  						 cb, cb_data);
>> +
>> +non_prefix_iter:
>> +	iter = refs_ref_iterator_begin(get_main_ref_store(the_repository), "",
>> +				       NULL, 0, flags);
>> +	if (filter->seek)
>> +		ret = ref_iterator_seek(iter, filter->seek, 0);
>
> Hm, this interface is somewhat weird now, as we have a split in what the
> prefix-string meeks when creating the iterator and seeking it. I think
> we should align those two functions.
>

The `refs_ref_iterator_begin()` takes in a `prefix` string, which sets
the prefix.

The `ref_iterator_seek()` takes in a `seek` string, but a flag allows it
also set the prefix.

I think this is okay since the naming matches what it does.

The alternate would be to `refs_ref_iterator_begin()` to also take in a
`seek` string with a flag to also set the prefix. What do you think? I'm
okay either ways.

>> +	if (ret)
>> +		return ret;
>> +
>> +	return do_for_each_ref_iterator(iter, cb, cb_data);
>>  }
>>
>>  /*
>> @@ -3200,6 +3210,8 @@ static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref
>>  	if (!filter->kind)
>>  		die("filter_refs: invalid type");
>>  	else {
>
> The `if` branch now needs to be updated to have curly braces, as well.
>
> Patrick

Yes, will add.

Thanks for the review!

--000000000000368b19063903781d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4ef74bfe0eec3734_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1obVZSb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1menMyQy85TG1RQ1FrSm9zVHo0cXhCbXgzM3RxZkNlaQpxRGZxTmc1VGt4
akFCeFR5bFdhM25DQ1VWTzl6OFlWSGpsNjArQWF1Ymx6bGVRTm4zWUdTTGR1L21iQk1YcHVYCmRJ
R2VaZzVqNkk4M1dFSkczczdpM05tNjVmRE5hVlN0YUhodWdTQ01rTE9LUjdCc090ak1hVGloeFhu
TEZZVm0KQzRPb29xN2t1dTA3T3FvOG9OS3JaZWhhUmxDUUI1OW5PR0Y4U1Q2QmlRSDV1TzMzSVhF
TmVJL2haUjRxcVZROQpSREZRclN3eGFTYUpGZVFLZzladDg1b0NJSjdTczA5amdJY3dVQUF2Q0xT
WVR3ZUVWVTBKUndoUTh6YkFtd0lKCjhGcGlvUE1QV1g1eFlZZkRJS2phQlJUWVVKajY5dzNDWjZF
RzRMODdXVzg0T3NUQVlCMVA0OWRsMm1iSkdkNTMKODcvT3h4OGtGNkx0MzdiOXVWWEJEa2Y3bTVm
ZEd0ZTd0dHdsbUhCMHE4K1VaSElpMmFSUUd2dUNMR042ZXVQZgphRWZNcjJBQ3B0VWRJVmhGYnVj
K0hzeWI4d2Q4T1JONWFGK3EyY0J0Mm04TjgvSTMreFVQV3YyUEhvSW84ak90CnJKWjZ4enpsUERJ
dzhUemJ1MlB0UFFoWWtvR3hmQ2daOUlWa2p5ST0KPW0rdE8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000368b19063903781d--
