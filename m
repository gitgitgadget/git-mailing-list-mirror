Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22A61EF0BC
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118987; cv=none; b=jNcE9k8sR4sbl2UuC0xaLPwbTnO+ZM5SPcGxwjTlQ+V+C1IUws0uaWYA4kmie5f2x7WN9cyisODewQqysGARo4yWOjHEcIrtAO++Ga9kA8Qn+K5zv18KYk8iAg3sJaQUrkONG674H47YPlEJF35LDWjbNTnyOteZZKMh3jrIu0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118987; c=relaxed/simple;
	bh=rQtuSOdtD+FBHsQWR5zfXyeDrDaOHwbIYXNLapJ68tU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQhVwDL6MAqimOfqlREzYtKR09wi4Zm1/p1MrWaoL8uUUbTsQ5bTfc/Zyxd2+q4bd3zv6cWyljS6jH12E2Yi+z5CbLzi+NYTd/+HxsvkMAZCL/+5LC+Ux7FxSmZGqO8XnlrB1XreIq5+e1MzSBUrAAWF+u/HIB/UeAL+zmFLJkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/WBJUxZ; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/WBJUxZ"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4afe7429d37so566740137.2
        for <git@vger.kernel.org>; Fri, 13 Dec 2024 11:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734118984; x=1734723784; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RnUYslqFx2LNqIgOGGIZscrSSYWQCo1kZIkLmkNvkJE=;
        b=e/WBJUxZnqjbQG8qePDfMcNATb+3VlILkyh2L963TSr5Sg6bWtCzHAeALdJcY+ITvy
         x+qu+dOjpthep5LK6/49eM/L+RUqXNuaRDWOfKZ5P0nHaCk0IY82VivIl7h2RjMiPSlN
         bjzT41G7n4mMmxiqnPhfksw8ial0p2I316s5jnQ+xAKF58/6U04ocDD9E9DDiXuatB+c
         6yAE33LMgskm836hHA0VXOSM7rDq5lyFK/K3V67mHZYk87HtqPkZhjNeB+XvBeKK/Q7v
         YPItV4CHSrsew5cHDAIl48JjMda/GyQBKabfybaPiM/9Zz/QYndcC3uILccn/OE8GYGC
         BmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734118984; x=1734723784;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RnUYslqFx2LNqIgOGGIZscrSSYWQCo1kZIkLmkNvkJE=;
        b=pSX/Iziz4P7BT3IyfZOq6wYdx1tE8LkhIaD9Tmu//dycn+rc88FfBIlMpro6VXSHBE
         1mULY+uJn9Z+JJchfo6QMJECw4nyUE8X/sGz/DPlQxtBc5M7aGRIyT+LyMcOY6rz2qDv
         2E9QlKN+Sq1KFzlA8IlIxU7RMQb0OY3DZF/HWbjEkuJFfYeFD+MFgClHJBnnq/mr/lpS
         7b1Bj+/nUL0/n+ckG0QjRebRx8OpU2RlKSEJEzdMu8D8LqxwRNRYmxvQLGP/xFAqkd4C
         MnHHDa5cPHDiQSEbFXYnXzJQrqEd05YH93Fp4q4TLQ5/ciyJqmQb3bX3O1rcSRwJCJWj
         xLwA==
X-Gm-Message-State: AOJu0YxA3oKE61ZsDgg6c/xEQnPSfffIcVJsIKdZHgjhVbq6X7mmBZpR
	i4YGI9nN6PvQZmpUsWhYZ0qpt8WDgOkgGQliBTCEk704rxQ+Iw9HeILLoSDXnvl8AGqo5PVPIFP
	wzy69XxhXf4ibo23m+Utt0A+45Z0U4grG
X-Gm-Gg: ASbGnct9HHirt6rUwqnztPSj4htEgbjbRuoacdauHylxlUhyf5tbwzvtLUVk4T1ug+E
	Uce3iAGZgqGyNgdCJ1ChT+5lvt3/qrnLN4IxrsbDpOjJ4lbQLolIiOPqekkLQWKrnbZpGK6+1
X-Google-Smtp-Source: AGHT+IGpO7r0GwBZjDo4qSjY23maoUDYapX5rydxq03JU3Na3x7GnZqKyvsgB0i+oSxnTo6EHj2i1uFJJ2WVbj636fo=
X-Received: by 2002:a05:6102:4b05:b0:4b2:5c0a:9afa with SMTP id
 ada2fe7eead31-4b25d95dca0mr4991781137.4.1734118984455; Fri, 13 Dec 2024
 11:43:04 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Dec 2024 14:43:03 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Z1wnbCoidG-lC7ui@pks.im>
References: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
 <20241213-320-git-refs-migrate-reflogs-v2-5-f28312cdb6c0@gmail.com> <Z1wnbCoidG-lC7ui@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 13 Dec 2024 14:43:03 -0500
Message-ID: <CAOLa=ZT9KDNaz84DLoRBzY_yaZ3kZ2FUWADohZhM4EcrJgmS+A@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] refs: add `committer_info` to `ref_transaction_add_update()`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000001136e106292c0a7d"

--0000000000001136e106292c0a7d
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Dec 13, 2024 at 11:36:50AM +0100, Karthik Nayak wrote:
>> The `ref_transaction_add_update()` creates the `ref_update` struct. To
>> facilitate addition of reflogs in the next commit, the function needs to
>> accommodate setting the `committer_info` field in the struct. So modify
>> the function to also take `committer_info` as an argument and set it
>> accordingly.
>
> I was wondering a bit whether we could instead pull out a
> `add_update_internal()` function so that we don't need to modify all
> callers of `ref_transaction_add_update()`. Because ultimately, we don't
> use the field anywhere except from `ref_transaction_add_reflog_update()`
> as far as I can see.
>
> This is more of a thought than a strong opinion, so feel free to ignore.
>

Yes, that is a possible change, but the number of code changes are
relatively low and I didn't think it made so much difference. Also
because we'd now have one more function. But I don't mind doing it
either, if anyone feels strongly about it, I'll happily make that
change.

>> @@ -1190,8 +1191,12 @@ struct ref_update *ref_transaction_add_update(
>>  		oidcpy(&update->new_oid, new_oid);
>>  	if ((flags & REF_HAVE_OLD) && old_oid)
>>  		oidcpy(&update->old_oid, old_oid);
>> -	if (!(flags & REF_SKIP_CREATE_REFLOG))
>> +	if (!(flags & REF_SKIP_CREATE_REFLOG)) {
>> +		if (committer_info)
>> +			update->committer_info = xstrdup(committer_info);
>> +
>>  		update->msg = normalize_reflog_message(msg);
>> +	}
>>
>>  	return update;
>>  }
>
> This can use `xstrdup_or_null()` and then drop the condition.
>
> Patrick

That is good improvement, will add.

Thanks!

--0000000000001136e106292c0a7d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d5815e757608ddc0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kY2prTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMVhhREFDQU45SlF4MjJLd0hwSEJPK0tzdlhoQ0Z6dApMQ0VnTVZERDNX
MHlydUZ2TTJSeUVrZGxtcUpoY29SWkZmV2ZmWndRZ3FnbWgxMjhqUVdFOXRjQkVldDdNc0ZYCnhF
dURyYStEbCsyMzdUM0loL3c1L2l6VVE1Y1hlQ2ZIRFptR1o2YTV5aFI2dmRwWXlwSjV1N3NJdHNs
cVlVS0gKaTJJdEFNOUdCOXBacDlUVms0VEYrUC9ra0xaVG5Hc3d6UFhPTlVOVHJnRk1OKzI3bk9y
aUNwbTNuYW5icWh1WQpjNWZNQ0o3Kzg3UDljRktxWkZuNEo1Qm1CTURHdUp0aE9NamhBRFBoUGt1
NnRnbHJ0b1VGVmU5Vm0xcy9TcHh2ClEvQitIdTFGVXhhMG9qZ29nN3BPSWswS1pOREFzcXVEL21o
dmhKbTRsM2xGL3FlUXBuQ1RkZGlpNW85MDh6aVMKdjh5TlJ4QVdIY1pYbDBnVmdpNHpyUU92MDRv
Rjl5SEZzU0t0Sjh5dlduSHZ0YTl6bGFDbW5KeTA2SDZMZUZGMwpMS1cvTGtFeTJrRFdlSmRvRy9r
TWU4RzFzTzFYZGJyYVdKYzR4K3RCekJWaDUzU2QwTTIwOUk5UWl6dHQ0ZUdBCmMwNk1xdDZodUlj
a1BkRU5uQWh4TE1QNm9TcGFWVU9Ucnk4dEs4TT0KPXoyb1EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001136e106292c0a7d--
