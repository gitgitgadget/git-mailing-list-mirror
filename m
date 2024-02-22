Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8949B605DE
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606628; cv=none; b=vEg09kQ02P5p3xUSmY2Oi5WQCIMaDyWPhgqpENPEl0kB7TW4thMHa2laZYkJKhvelDhuaH3564a8KkK3BAR9R9Lr6vw7Zr3hxSDRCXluRQAyUriBfqgHyPJWob+yzwR5a/jFdonJUlBTMP2sOOIJFnT/lwGlVjkThfpkc4j9W+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606628; c=relaxed/simple;
	bh=7UUgxmr0sxTRUiM1MzCjsbHLf5Ihz4tkjjRuveGD288=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEG76Eu/FB2b9R4u6+mBEh/F8Tit4N8l3/XZJPElKh67CEbINAu8H3y8zigYM03cOph0Cq9ShBMaA28pQLzfyzI5MSCW+FTsCZmvTcGNUWZA6B7RrDCX7jxQrU8A1N2C3Y3glS5ouFO9d4CFgzee8fEhmHkpLZalykddhtpZsac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDNE0nCO; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDNE0nCO"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e432514155so3809951a34.1
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 04:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708606625; x=1709211425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=95WqS/XHi8KJ+rFqSIf8gy8WHccBvub2+NEhGzZ0VLs=;
        b=UDNE0nCOq73AuTLOYIjLqA8lWVGml4GfME1uFunJ9uSdEXcv/W0D9TGPFAPISirqW8
         6rrAFu0zibFM/E6CedkLD7lrThOhFvDHbuATG1KknnGPfHw5r/j8CwSD9nI3XqkyMDyj
         8KpbDc2Gv7cHixFggxJHEQZs8/77hyH7BPDyl9QT/pbJTvZGJ1wE8gKtAH7knql17Z2q
         VQ7BruXPyONVLCNRrBlyA0QpZu/lE1RFqJyTlSETz9b/b46XFGi3xz+jdaYZgG8k4mFm
         Qo23yejiRe+RWj92qxIQHe3mppBzcfOBt3kIJQRf3r1OdWglMYJxgV92kPFyzpxW5KkQ
         StmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708606625; x=1709211425;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95WqS/XHi8KJ+rFqSIf8gy8WHccBvub2+NEhGzZ0VLs=;
        b=a14Kjc/y4N45gPsvj2ICdZoXhDK+2elrxvphkgpdh3vR5NXDRcCFYWCKGTdu48mqE1
         Ym9KR6c2Yk5vBOXGUcOpLo2Swcu60XJ26pWFeT+4aolnIelPfw4bTl7uxPwUv9G9D4Ew
         EhSPKKDJCJ8Flg0li94mwHMDg+S8LwGTMZJqWr28c9CK7KmuA+cPfMzUMT3fRPtrdzRf
         DFLdvTjpMDw5jRhFb3Og5eIOcYzbrZQGNZkXfpZXnAF6Q7Nud+HRg5Mvaq/8c8XHawW/
         qEw8RE7T9QNw3l93HXJkCWGApCj7dseTcGyjRSq6SfqKL4ZDA3O2Cg9hqYdL8hC17BLb
         9qNQ==
X-Gm-Message-State: AOJu0YysqjlE4ubb1mFSSbObb33+x25OskWmHmj30ziO6HABl9kjoPhO
	u1y78ePv8kH/+IwIPSeXh4gwGp4sgHQ6r46aEfiQg0e3tI5L34FHFELrpN9YrvviovBKy3FULKx
	8oz4rfay/6PuXXR0IGWAOasSdaRQ=
X-Google-Smtp-Source: AGHT+IGX0hduf5f0cpp68lKLiLv7rxbUDANaUmMTCa/n9/S4Y4OILq5BQIIG6EC6RLXfa/Slm+m76Oiu++vQEjzoQjg=
X-Received: by 2002:a05:6870:3913:b0:21e:baba:9737 with SMTP id
 b19-20020a056870391300b0021ebaba9737mr13813481oap.38.1708606625366; Thu, 22
 Feb 2024 04:57:05 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Feb 2024 04:57:04 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZdcJzs2vNkHJsjyN@tanuki>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240211183923.131278-1-karthik.188@gmail.com> <20240211183923.131278-6-karthik.188@gmail.com>
 <ZdcJzs2vNkHJsjyN@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Feb 2024 04:57:04 -0800
Message-ID: <CAOLa=ZQkqC7ahWUn=9aZksQOietGEY9M9Chj=uLTPHoXm8MuiQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] for-each-ref: add new option to include root refs
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="000000000000f760b20611f7fa60"

--000000000000f760b20611f7fa60
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:
>> @@ -96,8 +97,12 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>>  		filter.name_patterns = argv;
>>  	}
>>
>> +	if (include_root_refs) {
>> +		flags |= FILTER_REFS_ROOT_REFS;
>> +	}
>
> Nit: we don't use braces for single-line blocks.
>

Right, thanks, I always trip on this.

>> diff --git a/ref-filter.c b/ref-filter.c
>> index acb960e35c..0e83e29390 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -2628,6 +2628,12 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
>>  				       each_ref_fn cb,
>>  				       void *cb_data)
>>  {
>> +	if (filter->kind == FILTER_REFS_KIND_MASK) {
>> +		/* in this case, we want to print all refs including root refs. */
>
> Nit: s/in/In, as this is a full sentence.
>

Will change


>> @@ -2781,6 +2790,16 @@ static struct ref_array_item *apply_ref_filter(const char *refname, const struct
>>
>>  	/* Obtain the current ref kind from filter_ref_kind() and ignore unwanted refs. */
>>  	kind = filter_ref_kind(filter, refname);
>> +
>> +	/*
>> +	 * When printing HEAD with all other refs, we want to apply the same formatting
>> +	 * rules as the other refs, so we simply ask it to be treated as a pseudoref.
>> +	 */
>> +	if (filter->kind == FILTER_REFS_KIND_MASK && kind == FILTER_REFS_DETACHED_HEAD)
>> +		kind = FILTER_REFS_PSEUDOREFS;
>
> I'm not sure why exactly we need to munge the kind here. Would be great
> if the comment explained what the actual difference would be.
>

So the difference is

$ git for-each-ref --include-root-refs
9eda75497d43f2f9c70c1e14afb865108f9b4b49 commit	FETCH_HEAD
ee99ac41aeb4129866710fc5771f11e1c1742dee commit	HEAD
96c8a0712e569dd2812bf4fb5e72113caf326500 commit	ORIG_HEAD

vs

$ git for-each-ref --include-root-refs | grep -v refs/
b4b94355057280749620c47999a4b45dc60f2681 commit	(HEAD detached at b4b9435505)
9eda75497d43f2f9c70c1e14afb865108f9b4b49 commit	FETCH_HEAD
ee99ac41aeb4129866710fc5771f11e1c1742dee commit	ORIG_HEAD

This is because in `get_refname` we provide head description. But in
git-for-each-ref we don't want this, we want the format to be consistent.

>> +	else if (!(kind & filter->kind))
>> +		return NULL;
>> +
>>  	if (!(kind & filter->kind))
>>  		return NULL;
>
> This condition here is duplicated now, isn't it?
>
> Patrick
>

Seems like a bad merge on my end. Will fix. Thanks for the review. Will
send a new version soon.

--000000000000f760b20611f7fa60
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7a475f61b66bbaf0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1YWFJKd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMkt0Qy85dEhhK1QzbTBjcTVraUUwajl4Q0tkazc2agpTLy8rY0FxTkx1
Y0t1WXJseFY5aDN6SWQ5SlFhMGxQamF0b2JtWGk0NW1hT2M5ckp3K2VvNW94RkN5VmEraXFWCnJq
d1dYSy96am5JSkpiVFdEWGQ2OGpuWFdnZHVYN05kRHNjenoxNmdsWXFKRDZsTHFyOTIrMzl6S2d5
dVVQWlkKeUtLU05TZmVmdHJkMmRlL2FVRUtWR2RGUXVQQUs0dFBpMm8reXY4U3RnWnVZQ3FXNUlk
Ymx4cVd2TVpmdlFPdQpRWERMZWhPL0xGQUZJc3lhcktnSkl5WFpiQ1d5aGxhQWdaYys4YklyTmo2
K2FvVEZ1SldlMWVwd1lKQnEwR09wCnY2RCtBQ05jcjFqZi9lQ2xGTVBtTWtUOUFuMjBCQUkxc0hB
dmFqL1FpdDRXeE02UU1RTXZlcGs2OTRveHFjNnUKcHc1T3NDTnVLYnBwS2RoWURrWlJWMGhRd09F
RTZyWTM0TkFkL05SYTlOWjBpaDJ6blFXZExWUzM3Vm56d2VYKwpWUitUZjhsV3ROaHR0MHZ5R3JL
aDN5R29YS3JmSldzZVJlbVUzeHpEMC8wN2ZRdlBob3ViMk5WRFcraEdBSXZ1ClFGN3lqMnNlWkkv
bU5Gbnh5cU1oMFhJV1hRTERTdy9kWk5RbmIyWT0KPVQvOGwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f760b20611f7fa60--
