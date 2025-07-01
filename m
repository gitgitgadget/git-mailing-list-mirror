Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66310264625
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751358021; cv=none; b=C44PrTxnqyXiwIt30dRSA7UZGy8YocWoyShAA12STcUHZbZLX1a7h/4YDMzCBJqgsFBAQ9hetH/PwfMBast5g7lrIujKe6qYW/KGq+Sz3i2EqkU8Ir7NTiYD1zFjzrV3ZnsA4g4N2owoSNp3q4rAG5YkWSSWDFpE8OWrt+eXWJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751358021; c=relaxed/simple;
	bh=EPCSKTEuEkE9vPsAy01TJIupwgvuXHwhB9cL1Wd94Ec=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGR6orkjFufXSzeIiipjgy/2+Gd7K/AhcqlHjcaHjqpl4wSMnsf/SY5BURegMpPabbaCvwCSAlQLm08Mk+XC3iUw3XMpedBw1AJK+qEqwMyVcW1n8ETwFj4k9t1nWpZNaOkqJX4BdHA/+4lvBq91Vdq1+HF7jEFm3jemijECck4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGfLlD/u; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGfLlD/u"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-53159d11cecso3442937e0c.2
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 01:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751358018; x=1751962818; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Fkw7g50Z1BRodryoLfuw2ZqEJnpHj0wfqdkSHxMzsg=;
        b=nGfLlD/uqL1Eyr+NHkcgbfBJGa/bmOo8nPZ728Re6Idz2I/QRX+1TPqkgkEfvX9m76
         6KxpWkUTfAfiEpWmtVs9HEJBLna4gSDqozD8flF00gDLW5ZivaH2keNPqNq+SJMcXN7o
         +1JUJyYAp8wRpu3nakQ2ttA9ZfqRJ2BjOlV/Qaoxp1AdzLkM79jRqlbV8jqhigbSf09k
         2IY0RoCvl/nQ9Y5SafN2Ypq24LqutjFy5uDMl9Rp2xnnndnnzjXtVHyyU+0rqyjWryRn
         4HRGuf4KYvnRaOyFkWiRpLVFCxQ+7KkKxpNL65ngP7UVRHgfSTcJW2MEL0YkEaG9Fzy1
         dLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751358018; x=1751962818;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Fkw7g50Z1BRodryoLfuw2ZqEJnpHj0wfqdkSHxMzsg=;
        b=c1USMduRWZzj84R7XhcQXQ/rVDo81YhLLJfZMH2CvzhCRRgt6QZJJGV0vMs1olg+UU
         BljoXsC/zYCXb0RnhMBPQdO69WQ/itRRKLLw69UHoGxtJsW6fX/bqn1cRKGynsWCe2vI
         AnrwWuN9XH9px8IfeINVzad4zgLsDtSW15eCIJd+gFVV8c/L/vO/lI25ji1UYvWSHt3h
         PGjBRA043D0LldwW6CNf8V05lXroPFVIKZ82aWnTgT22Obqa75i/S/0UQGeJ0bU3bBBZ
         PdklJyR57UG4aDDQl8dmd7uOSMCxIwn/uiGfWGCqXhXrV4ibTLep5e4v7uRqIDPtl35R
         I1sg==
X-Forwarded-Encrypted: i=1; AJvYcCVtBSyE7AsMQfvxxUVtrPJmHnDAFWGXqyT/Tl4pDf1124lpIF2ZHmnGwNO5vRSDmhyEplM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztk8ZNkNL5nvhO6eY2r3LJ9Or1LHeXqArpeWiSJtXf5eynIXgH
	z31wvK9SKPJLNVi3R0Z9+4jVbOq8VFLrx/pOnCA/74ii8s325e5dDt6Dr3xVzSCmn9z+e2yv6nT
	8ZMMSknTXVisgJ6HtrmBtoskWK65IXww=
X-Gm-Gg: ASbGncunqr+C3vrpGHUe52YqThjGlm6Pbn/SI6w4i0fDasVwvvkJ4aZBv+XNMXxbmgM
	doX0qui+/YHc9RGRhWSYR6ijRHU6uOQdH7wcxq8tGztGWW7Q2XWbKfqQ2DfVLnkGY46kGWjgaL/
	SW6bzZXsKSTJevehuK41qEfYd5MIjuiNrE5viVwLorJ8VVvQ2F4ddkmIYMAbWY9/ZXgLPMqP9Pg
	nTTBnraC6evcg==
X-Google-Smtp-Source: AGHT+IGmnaeE5UMzapSVszL0Rz8xVxcRDDbBVahpJZDKEMUEQDD0Y2ejTDR6zrPwSkRZShCsz5AVfis/SRKS+BZ1Z1g=
X-Received: by 2002:a05:6122:2a41:b0:530:2c65:5bb9 with SMTP id
 71dfb90a1353d-5330c0553bbmr10059575e0c.8.1751358017936; Tue, 01 Jul 2025
 01:20:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Jul 2025 01:20:17 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aGKdICvmKlumU0ru@fruit.crustytoothpaste.net>
References: <CAKkAvaw0sZ0sW9o_0NZdnZknS8M34UST3PetaPBQj5wwvJyjBA@mail.gmail.com>
 <20250625141849.78834-1-jayatheerthkulkarni2005@gmail.com>
 <CAOLa=ZSA273KGPnwZ2aRBU_ybcCTYogBHvUwpa+5CfDOc2bEWg@mail.gmail.com> <aGKdICvmKlumU0ru@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 1 Jul 2025 01:20:17 -0700
X-Gm-Features: Ac12FXzDgon3YBvhP3eA7kUtOSOS9WQ2rL_LpuPD6sc6f187LMyzl7dFdfKkRW8
Message-ID: <CAOLa=ZSEtd2aHt-j9vOoXGR72g7qbndX3VYkaeD3hKF=pvKfkw@mail.gmail.com>
Subject: Re: Re [bug] pull --prune could not delete references due to lock
 file already exists error
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com, 
	git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000088c7730638d9d0cd"

--00000000000088c7730638d9d0cd
Content-Type: text/plain; charset="UTF-8"

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-06-30 at 13:46:35, Karthik Nayak wrote:
>> I can see few solutions overall (including the one you suggested).
>>
>> One solution is to drop duplicates in case insensitive systems, this is
>> the shortest and easiest fix for now.
>>
>> Perhaps something like (untested back of the hand code):
>>
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index cc0a3deb61..bc79d74b82 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -1352,10 +1352,16 @@ static int prune_refs(struct display_state
>> *display_state,
>>  					goto cleanup;
>>  			}
>>  		} else {
>> +			const char *prev;
>>  			struct string_list refnames = STRING_LIST_INIT_NODUP;
>>
>> -			for (ref = stale_refs; ref; ref = ref->next)
>> +			for (ref = stale_refs; ref; ref = ref->next) {
>> +				if (ignore_case && prev && !strcasecmp(ref->next, prev))
>> +					continue;
>> +
>>  				string_list_append(&refnames, ref->name);
>> +				prev = ref->name;
>> +			}
>
> This won't work in the general case, since the two refs that match case
> insensitively aren't guaranteed to be adjacent.  For instance:
>
>     refs/heads/AAAA
>     refs/heads/AAAB
>     refs/heads/aaaa
>     refs/heads/aaab
>
> They'll be in the above order for a bytewise comparison, but the
> matching entries won't be adjacent in the list.
>

Indeed. Good catch, this wouldn't work! I guess you'd have to use a
hashmap in that case, I think that is what Jayatheerth also mentioned in
his reply.

> Another option is for users on case-insensitive systems to use reftable,
> which won't have the same problems as the file-based backend and will
> preserve case properly.

Yes, that's always recommended! But until we start marking the files
backend as deprecated, we do have to plug this bug.

> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA

--00000000000088c7730638d9d0cd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4efa6aa74504f66e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oam1qOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meHljQy85amxoQ01IYXJzT2ZXQm1yWTZoMVhhU2JMdAphTUhheWN2Z2Zy
a1U4QVEwa1J0ZnlwRUZqQjg4cWdGNTNWbjE0Z2pCck9LOWRkZ281Vm5hNEE3Z1NtZ0x4ejVPCmo4
aHZ5aXpHU3MvSUcrWHloQVRGVUswY2lucG9VMmJ3ZUF5UHROdU5CbkR2aWtNeUFSQ09MazZOa2w5
ZUxKaDQKV0RmV1dva3Y2d1plcHBXaGNIOVBaRCtEQ3NIcHlFR1B2bVFqbFQ4N2FIbzZOOEVHQ25n
MVNONERNbjNRanE0SApRanYxSjZoMllxN2pvQU5sdm9rLzErRk0xS1ZzeEE3Z1B1ZkM0TnJFVEd2
QWl0TjhGWnJDdVUwQnBSN1dTak93CkN6RWNJZHhSTkZzc1dSUXNjd3ZmbDExYnBvbThhbkZXTXZB
eGV3QThONXI5UEFrWno2TG1SVG1MOFA0M1dPdm0KUmhEbFcvdGM5NW5qNnBQUVdnRXl5ZEdzd0ox
aVBSdzhFS1lEUmdkNENMUnF1Z2o1dS9OSTVVc1N6YWtXYU5ZTwo1dm40dTE1MS94MXJsU0MrRlhP
VjZqY09MNlgvQlo4R2RoMHVMZU9pY0ZnM0RER3l4L293R0VBck1Jek55TFBuCkxQSFJxdklWVGdK
UXo0WFJud1FMVjlFY0tva0V4MVRSdVQ1K0tCRT0KPTdFVkkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000088c7730638d9d0cd--
