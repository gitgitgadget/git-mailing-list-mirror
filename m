Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF2C3232
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743510688; cv=none; b=UPET9Galw8/Sfz9OHetfmFDWmMindDxXVwQzNOox3sZo/AgXdilE7zftv2j1sYdZCx+lN8AKstxlh0Yz/5C1Kht7R8bPwFZ8jcLAC6ren4YZ2taBKUavAkot9Fo9pRutNjNnrwxSzmSTky3DHnIJSvvFKuZlwd1E6PfLZQp6bsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743510688; c=relaxed/simple;
	bh=ME+7QRN7HGCzENUgtJaGGGQzJr++f+ZJOoAXiosf9H0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lExD61qjMcoQWCtiwNF7jjtv+Cvy0bJQWo8+SkQv130ZR/Li8/pTT5t2wMTQ0mhQodALhQiMTibNMdhneDDYk0NXMkdYLJans414MyJZymnbZ/H4CZciHH0R7lTmmFnC5TCARJgmxnfNFT9DMO0ilTBa5Ef/kaTSzs30QSABsmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBKbsB8F; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBKbsB8F"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5259331b31eso2640499e0c.0
        for <git@vger.kernel.org>; Tue, 01 Apr 2025 05:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743510685; x=1744115485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/m6dG/IK0WAQisy0ENmlnSi7rDWbpA5JztvbniwwH4M=;
        b=TBKbsB8Fz37kTZlUgzpPESc3KX+Y3BeS1JfQ7L8ZgNJT6sX/7YcOum+C0ckezCLZYy
         JYwDX0TpP3LpC9+YA7fPsQnCjJb3embfJLD9h4+0LYwh4zpbWGAxdxPjlK/Bx+VTKcX9
         2gawhJsSEMYY1P6b8ZaAGjWnZtJLvOkCLlUG9jMC2VeuhSh99lC9VVDM9amGFunzaNTh
         NCByhwRRpYh4kxOQ6KuCKX8r2cVD/4dqitrC4mkBbGUld8BEGvErX3i3rp78BmtjbdZI
         PfHV2sKFAHQU/X3It++7ahzrjTW7yMq6+5Z7pPxSMOHSW9RJecvPCCAEKrE2HC0zTtJQ
         6qLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743510685; x=1744115485;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/m6dG/IK0WAQisy0ENmlnSi7rDWbpA5JztvbniwwH4M=;
        b=EE82lWpluQ0aaYXrAZsgRtq7I9CkGBhXKFAhlQzJ33UDdcRSkKuDP2yeyD3W+RVPB6
         NS3EyTzdP8cMc9dlhbrvPLj/PquroqHOsd11lQz5WNKHJTWwHeJ3jOUwOnzwhf8D/JZM
         IDHvzrXamis1tbhtE+4oF1znCDV406UTeI2N8XwSLReVvMID2XoTu6YCRagTX4cXKadu
         umChNbi2me4dUyD8Xl0f5oQ4QTKg/XiIY9/LkT02s4MTph/9892cen5hKUFHvBblaFwp
         yUGGu3e1dSUIHayzhWjwV6IcXGyRi6jauw1hfY7o6i2XQ/fTimgJhABEZktXVxEumh9c
         m6Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVaVGS44n0zDspvidXEy0bMbY0YNahzUVDYAULLZrA13bSMOzxQ2ykYoSCygpPeQHFa108=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Wj7hM+/FldDifJtBhtyJAVEJ100r2LcOY5wx6Hr+xYW5mKQq
	AXJd2ugLwjbM5WFyW/TXPAe1qZkqJIZI0AyFscIqr+QyEl8SsAPpIeq0bCO3bDLMYXpaaMPka9J
	JKDpfs5Bx837tXwTqsIJyyhSFcFk=
X-Gm-Gg: ASbGncu/KV9oRtVL+i2s3nKkZ6vhQTAjULn4of2HgLUM88+7TyUGO5gj4m/ZFlgSTh4
	a//jljjQn8ihtN6Sv9re4xn05syL49nyYxwo8kIX66ll23UUvzU8K9BduznW676wDpMLAI34iov
	ckTX5T4cbzEiNTMiEGaq8jVJW5voIqx/SKjPa9BQgAxrThIhX/oQ9WUFueODtJ
X-Google-Smtp-Source: AGHT+IHyzNUIQvOcd9p4vyssBugwnX+GSwL6rO8Jig66FY4CXECXMqUD/8IAkXeTISocSI1orGIQlEwxCAQXswwKcHQ=
X-Received: by 2002:a05:6122:a07:b0:518:a261:adca with SMTP id
 71dfb90a1353d-5261d4759bcmr6237770e0c.8.1743510685295; Tue, 01 Apr 2025
 05:31:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Apr 2025 05:31:24 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAOLa=ZR4YmfHvQGvs1mzdtRu5z+8XW-xY+t_wBAoTs1m+rrO9A@mail.gmail.com>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
 <20250327-pks-cat-file-object-type-filter-v2-3-4bbc7085d7c5@pks.im> <CAOLa=ZR4YmfHvQGvs1mzdtRu5z+8XW-xY+t_wBAoTs1m+rrO9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 1 Apr 2025 05:31:24 -0700
X-Gm-Features: AQ5f1JpFiA4tlfMoWM5s8RvpH6Rcj7a8ZsToaPDeL8FsnWrfYsL_3e9cWkFWR7s
Message-ID: <CAOLa=ZRjhqsSxA7JCPPU4e1HFJBeK0PFgCZwPc07emp+2pawyA@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] builtin/cat-file: support "blob:none" objects filter
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000000f43ad0631b6b791"

--0000000000000f43ad0631b6b791
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> Implement support for the "blob:none" filter in git-cat-file(1), which
>> causes us to omit all blobs.
>>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>>  Documentation/git-cat-file.adoc |  2 ++
>>  builtin/cat-file.c              | 11 ++++++++++-
>>  t/t1006-cat-file.sh             | 33 +++++++++++++++++++++++++++++++--
>>  3 files changed, 43 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
>> index f7f57b7f538..bb32f715944 100644
>> --- a/Documentation/git-cat-file.adoc
>> +++ b/Documentation/git-cat-file.adoc
>> @@ -86,6 +86,8 @@ OPTIONS
>>  	Omit objects from the list of printed objects. This can only be used in
>>  	combination with one of the batched modes. The '<filter-spec>' may be
>>  	one of the following:
>> ++
>> +The form '--filter=blob:none' omits all blobs.
>>
>>  --path=<path>::
>>  	For use with `--textconv` or `--filters`, to allow specifying an object
>> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
>> index 940900d92ad..e783dbbad58 100644
>> --- a/builtin/cat-file.c
>> +++ b/builtin/cat-file.c
>> @@ -472,7 +472,8 @@ static void batch_object_write(const char *obj_name,
>>  	if (!data->skip_object_info) {
>>  		int ret;
>>
>> -		if (use_mailmap)
>> +		if (use_mailmap ||
>> +		    opt->objects_filter.choice == LOFC_BLOB_NONE)
>>  			data->info.typep = &data->type;
>>
>
> I didn't understand why we need to do this, below we only check for
> `data->type`. The only other place we use `data->info.typep` going
> forward seems to be `print_object_or_die()`, but that flow is only
> followed for `opt->batch_mode == BATCH_MODE_CONTENTS`. We already have
>
>     if (opt->batch_mode == BATCH_MODE_CONTENTS)
> 		data.info.typep = &data.type;
>
> in `batch_objects()` before this, shouldn't that cover this scenario
> too? Maybe we can add a comment with the reasoning
>
> [snip]

After playing around more, I understand now, we set the pointer
`data->info.typep` to point to `data->type`, so when the data is parsed
in `packed_object_info()` or `oid_object_info_extended()`, that
information would be set into `data->type`. So we can skip as needed.

All good here!

--0000000000000f43ad0631b6b791
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6b7289f873a70b39_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mcjNKc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM0dmREFDZDhiK3lya244VzNseTZHdk5kWGNib01NawpnOHhydlMzbGZR
MWErNXBuV3VubERCdnVTQ1lxbklLWGJDU1RrRDRRK2c2Z3ZIdEo4Rk1vWWd5Qm56Uy9nVGxNClU3
WmtEaitZWEJURUxwd2gwanptWGdHSUFhWDJZazA3TXRXOSsvRXRnWER3S2NVVForMnRqOUZPZ0Nl
ZEI4MUEKWkFudklMaGRZWVNPOXVMZDZYTFFVM0RISEpHOUo1bWwwRTVhU1ZZVVJyS3FxWThLQ25q
UTQ0RFo5S1B3Y0VHSwo2L0dJVG44RHluMU4rSnNONkE3QnNXQkxmZGYwMnRsSlUxampqSlRZeDdv
WHJGOHM2SjhVSCtndW81Z3dWN04zCk1PTVB4T2VCMEFnMmVEOXhtVk81bHNZOXdhQXU3UnE1R20r
NC9tbGVlY3VKVE5pbXYycGR3N2lLTmh5ZlZyRXcKMHRyL056RmoyWWxwMzNsY2lBbW1zNVNVVHNN
MldleFE1amgrTmNoMjJScmVyRWptazcrUkVUazNlUlJCbDVsOQowS0g5T0hGUTRpUm5BaVhmQ2E2
bTlLdERFZTFiMWFhNjFxb3FIczl5MjVPZC9Bb3BWUmNiL3lJLy9HSW8vZ1NKCnkvSGZKSnJUY3BO
OFJlbHFuWjY3dDF3QXVmUWRhd3o1VElzS3hPRT0KPUdkY2UKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000f43ad0631b6b791--
