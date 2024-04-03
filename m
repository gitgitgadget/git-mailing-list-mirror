Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851F2B66E
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155928; cv=none; b=E29uLK7Ekasf+JQS1hQIPTY1PjjMl9k6GPZtqG/w5smiWPdQyzPhXof20Hi/f30GSUvTXa9RzhOcTvsdGeDStlORgrXL337LPfg7XRtOJ/yYJd+oL1UmWT7RodwogUmJ3vTHF59mXihkp2Jpy7h7WpS8W6rwYEG20uyjIHS1tvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155928; c=relaxed/simple;
	bh=bjSIZI48k/m04bjATIKtJOh7W1Bzas7bRVsu8QAhc2U=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPH/qrKh+I5IYN5e7UfNm2HhaI5Nr9RdcIlz34BNeG0hQSo0ESap6fqpFdenI9gnl6RKfmG4Lz6YfxHfvouF32mecda3UDDLwiRxxNtIR6KL4VyxUi6I6WUdqopFCGUpA+SlwVCugt4+c6JXnh+zE6vC5n55EeJT3JEbWflVZQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcnIJnY9; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcnIJnY9"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-22e7444c5a0so929321fac.2
        for <git@vger.kernel.org>; Wed, 03 Apr 2024 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712155925; x=1712760725; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bF+V3MQ1TC2qrfyUitQ/w1SJAoUK4OCSPVjZBK9ZY/0=;
        b=jcnIJnY9GfPoPNjfiKhbZnM3Auq3bESNuLHgiHI9kgGa1BN/X562Uo0YgiLW2QvRV6
         Fi3PUeAhjarSwXc3NhhoSll+t/pGOMQB2wGgFyl7aB1lFUfPppDwYVyjHyis0jhVvuAK
         r0YJCG8kUflSbzQvRseMI+eozPAWUMMRi7r7uG+YpOm7oL5jbwQNksGT5Li4vuFTk2EI
         vv6P9kTN4k//bZ2y50QJz79nGeNtU3swS0Z/H7U6D86jcgJ9a8YGO6dnM/HDNcNlV2Zb
         VtJew91iUHf0BJhi2ALI8SLlN4c7mfp2OaTqvMAE6bjJlKB/LDjXCpfOQ99UT0ShKT+9
         cilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712155925; x=1712760725;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bF+V3MQ1TC2qrfyUitQ/w1SJAoUK4OCSPVjZBK9ZY/0=;
        b=HsYw/UU71y8b+YPw4Ql16tc9xldP+L8k7eJ5JV978BCLKPjmbMXgbQkK5tNkrNTu4S
         xClcwyJWq+ZlF/FyZHx4rt31nqYjjLDGYEmc2F/8t9wPER0IXANILRFDX+N+OdKJKjL9
         r8K7ZWcAU+vq1KkCtOx0KYLDX2pZqjlga+RieJefW2Ov2aGnFcHBMifUShWUX/aXfiKY
         RbUIomYUVFyBEWnZ8v0PWRuZUb3YbYqYAMVDEfImuqv4ldSBZXm/SqnHJSn3KdUsUDaH
         Iw4Aa3LhaHmKvZqR+HxJHByo50g8dFCVGlkaNYeEhGcHz6z0u0tMyXz3QMQdCx+0P30m
         5fEg==
X-Gm-Message-State: AOJu0Yzw5VpQVYP93Jt4YmQ4sNSbv6e2N1H7DcLm6P19NE1z+D94/K0h
	386ctnb6dNTm9ScRiL2HUOrPbPYx0WskR3lO87acZgkc3mN3If+6sVQNB/dTgQQslgxCEyKUmq0
	eCJKfhXAPAuwVx1wUPEPbvScQNpLxARn9
X-Google-Smtp-Source: AGHT+IHVb8giSBhLGVNv4+/UB8yq88zyhgpI2ppyzHoRn82CI7PUwjuKsXZDXuh4CfnaRtMjittTdB0dGS6Do8//JLI=
X-Received: by 2002:a05:6870:702a:b0:229:e281:49c8 with SMTP id
 u42-20020a056870702a00b00229e28149c8mr3314546oae.15.1712155925580; Wed, 03
 Apr 2024 07:52:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Apr 2024 07:52:04 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Zgv3_K_gCkPyZvRQ@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com> <20240330224623.579457-2-knayak@gitlab.com>
 <Zgv3_K_gCkPyZvRQ@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 3 Apr 2024 07:52:04 -0700
Message-ID: <CAOLa=ZS5czBhvE88sK-mQTeYBsRTn9MWnFQeAD5Nxu-uDpe3qQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] files-backend: extract out `create_symref_lock`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000bea8630615325d0b"

--000000000000bea8630615325d0b
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:
>> +static int create_and_commit_symref(struct files_ref_store *refs,
>> +				    struct ref_lock *lock, const char *refname,
>> +				    const char *target, const char *logmsg)
>> +{
>> +	int ret;
>> +
>>  	if (prefer_symlink_refs && !create_ref_symlink(lock, target)) {
>>  		update_symref_reflog(refs, lock, refname, target, logmsg);
>>  		return 0;
>>  	}
>>
>> -	if (!fdopen_lock_file(&lock->lk, "w"))
>> -		return error("unable to fdopen %s: %s",
>> -			     get_lock_file_path(&lock->lk), strerror(errno));
>> +	ret = create_symref_lock(refs, lock, refname, target);
>> +	if (!ret) {
>> +		update_symref_reflog(refs, lock, refname, target, logmsg);
>
> I feel like the resulting code here is a bit hard to read because the
> successful path is now nested into the condition. This does not really
> conform to our typical coding style. Exiting early in case the function
> returns an error would be easier to read.

Agreed, will modify this to exit early.

>> -	update_symref_reflog(refs, lock, refname, target, logmsg);
>> +		if (commit_ref(lock) < 0)
>> +			return error("unable to write symref for %s: %s", refname,
>> +				     strerror(errno));
>> +	}
>>
>> -	/* no error check; commit_ref will check ferror */
>> -	fprintf(get_lock_file_fp(&lock->lk), "ref: %s\n", target);
>> -	if (commit_ref(lock) < 0)
>> -		return error("unable to write symref for %s: %s", refname,
>> -			     strerror(errno));
>>  	return 0;
>
> Also, is it correct to `return 0` here in case `create_symref_lock()`
> returns an error? If so it certainly requires an in-code comment to
> explain what is going on. If this is a bug I feel like we have
> identified a test gap that we might want to plug.
>

It's wrong, we should definitely be catching and returning that error.
Regarding fixing the test gap, it is kinda hard to do so, since this
is capturing a filesystem error. It would be easier to do so in the
upcoming commits where I could possibly do:

1. Start transaction
2. Add symref creation to transaction
3. Before preparing the transaction, manually create the lock file.
4. This should hit this error.

I'll add something in corresponding commit.

--000000000000bea8630615325d0b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ca1a29a49295351d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZTmJSSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMVcrQy85SmZyYmFyalBiR2ZNdEdRNWMyeUd2MVRNbwpUSjFFOUc0OFFT
ci9GN3J4czVXTlQ5S3BnMWs5K3J3UG9NNHRtMTVkVmptdkpsMnNyWkVYMU1hRnlMQzVNWHdOCmxZ
YXZUcEN1eXE5dFgvUVB5NnUxcmpxcE9MTytpdUtQUzVpVXlSTTlzN1VOREVkNHVuME5HeEtBWkNu
aEtiZ00KejZiN09iaUlWaDFuWUFGRDNmL21aNzJYdG4wbXJoSjJGeHBwa09ubndoWFRXUS9xNHRS
ckMyNkdPcXdsWXBxSgpiZmNiQWlnZGZpVzlDdVM2VTI0dTU0RUs2NElDS1pXS2RKOWxONlg4ayto
eHNnZWZEbmZhV0p2OWltUjBXVUZzCmJENjYxUDVwaUpqcGpTYjQrYzZwWFg4NjkrUGxzZnBYbW10
N1dDTllhM3B1cUhiSU5WNGQ4cDdjempPc2hoRWMKTmU0T3Q1Ullvc3BQSXh0TDdVN1FINGhhdWE2
ZSs5VEtJUEZsd2dYSzFtZjNXczRtSVRBYlF4VWhKMUM1eHFMRwo5RGV4bmh0ZmtUTnRqREtDSmE2
K0t0aGZydW9uREJ3RUJJVndyN3RUNEJjZmI1YTlpa2NMNitkd3VlMC9VallaCk5wK1Bxc3lVeWR0
dmlLNEcvWDJPZHJEeFZCUlpDWjFSNms0WlVXYz0KPXUxT24KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000bea8630615325d0b--
