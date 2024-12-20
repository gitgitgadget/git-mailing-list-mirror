Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ACE1C07DA
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734691458; cv=none; b=oymtHlsf9ryVgCmWmnwi16m5j7uEvI+c/G+XTpsEuVyJ9UEqELnPZV6wjmWbLh1emHlCFEYF4oiiiub7h9eS9Mo0iaRMnNsIjk6NtFOHr8r0AxXJv3QcEaChCyW+0zO86t0g5ua/7B+LGHuloGnGXC7TwwLzyYGPUsVCb8VapN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734691458; c=relaxed/simple;
	bh=eZbS5MEL0OhU6UO8qK5EBtKuEzWMOaxSzUQd15+dlIA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ig/VeNJJolEAo3kU3V9kUXbMdk7tY/FLOw1uDd+8R7NhcGf9smbe9XlYz8qbp4Znc0sBXD6J3EFNqPtPNZazFSCEchxsSLkFi0h9H6+QNXgY9WwPvKRHUQ0Ehp8iPeOZ+kV2Ub+AlLy7QtaNxAwkFjeHKv59VnzpAtfFYTUJXdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lv58yQ9U; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lv58yQ9U"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4aff04f17c7so1596093137.0
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 02:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734691456; x=1735296256; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=I3rtpiOMdcb9DIpjlzkhoL7s1V2bA22nMLMMeFPlBvE=;
        b=Lv58yQ9U4bC5AIhTyHoKK14MNEEz/NH02R5/uCcQ3RwAkhwZrHDrpMHvW38GXfrODL
         ETot8Neh6WLy/K7dE54bh684jbFzzFJqXRYaVtybRhKtl4UivdyWVW7UFs/SK0txCBkb
         tGvfMrSoLnCaV3IhplstFH9x/NL2tAcoS2MRBY7nMXSUiZqnWbSBxQpml5tv2s6oPEtd
         rOKX7oMw9EK+KgcHntT+ZCl0OkKXmWo4mDIs8W7Sqtq5Mr9ss3T9ysSU0/D6pxTyt4Xh
         6ZDXfvi2mhN2+iyuac7lxvcZkkbNqcxoTcWWPrdQPZIodxTL3XZk6o6ly5XPNuXtKI3o
         5fTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734691456; x=1735296256;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I3rtpiOMdcb9DIpjlzkhoL7s1V2bA22nMLMMeFPlBvE=;
        b=RUJqi211Ng9aVM8koCXNh4e4bkItOgVSD4B8JOdyO38FqiXr2qTWy6xj6dGP1CW8eo
         0HexzP1wSzh/tarMzll1kaUiR4WtAi+PP+3zeOZ7iqqmMwSzI/L9BDr6RqFnEP4JoRt9
         FqOfIYlEvItuoj8AIBPSkbWEBUzsen8Srvp/cusYFqMkjnpjHlpiQM7lhjS+o2dF7hON
         giOCAcGQumZB4mphuNA79imhnU9wmvtMWitM6nhlt8nzVPdnerMoGgsjbb23JQGWDgF3
         WCmQH1UGwOrF/Ahl5IiAf2SY1Sorqi+mnylpxIS2TfZuq/+HMEMt1syQ4kYAzo7hsG2r
         siLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMwWlKMpeonBCa2x6p3yAOtlkeH621ZeNfZMHk7nAQ8IHeXVJf8jHFZe1NPSZxlVzcMcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDrQURRIdAgJ5LsiFLNVrOQVLxNDxZ66nQM+JAE4mlX7Nq2adR
	FQ/jQZMyad77jp0gsbyYeADusUNAPNMjDTeaoZbiMfDRSAxqlg7tgfJOAX84zQ5SuqQBr+/xfS+
	sjxzGjlxLGnuqalFYimFhLyEBwQNv6+FN
X-Gm-Gg: ASbGncsirgrpd8sepZGvk8VbJWjPmsM/Hd3Dmb7iRnzB4xkLC1CEsnmvWtZpf/TyHrV
	O6ZLAxZHCV8G/eR4V+/k4ap/uNkJ5sWs36T4F
X-Google-Smtp-Source: AGHT+IGC/yU2j2yQtDWhvolvaXgE5NFD719psvHKWKzpR+ZCZto/H+Q48UqKDxfL/V54L3duTbXzGf4HrIUDvidmeQo=
X-Received: by 2002:a67:ebd5:0:b0:4b2:bc6b:c73c with SMTP id
 ada2fe7eead31-4b2bc6bc807mr5327377137.6.1734691455871; Fri, 20 Dec 2024
 02:44:15 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Dec 2024 05:44:15 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <878qsbh3nh.fsf@iotcl.com>
References: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
 <20241216-320-git-refs-migrate-reflogs-v4-5-d7cd3f197453@gmail.com> <878qsbh3nh.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Dec 2024 05:44:15 -0500
Message-ID: <CAOLa=ZRUQVwkyv+JgCPoqAkUar+0Yt4oYJ-c=tfgCL+W8v6vMw@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] refs: add `committer_info` to `ref_transaction_add_update()`
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: ps@pks.im, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="00000000000005d1760629b15425"

--00000000000005d1760629b15425
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:

[snip]

>>  {
>>  	struct ref_update *update;
>> @@ -1190,8 +1191,10 @@ struct ref_update *ref_transaction_add_update(
>>  		oidcpy(&update->new_oid, new_oid);
>>  	if ((flags & REF_HAVE_OLD) && old_oid)
>>  		oidcpy(&update->old_oid, old_oid);
>> -	if (!(flags & REF_SKIP_CREATE_REFLOG))
>> +	if (!(flags & REF_SKIP_CREATE_REFLOG)) {
>> +		update->committer_info = xstrdup_or_null(committer_info);
>
> Why only include the committer_info when we're not skipping reflog
> updates?
>
> --
> Toon

The `committer_info` contains information around
1. author of a ref update
2. date/time of the update

This is only relevant in the context of reflogs. Regular ref updates
don't store this information. Hence we only add it for reflogs here.

--00000000000005d1760629b15425
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d245461ece054b93_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kbFNuc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL1BsQy85T0FRdTZiSzdxWHJaNXA2Tzg1c25EN1F3Zwo2ZFVXSXh0Z2pU
VUN2MitnWERzN3FNcjZPMEJWZTROYkZzZnBBWFhqQUVlNUNLQ2pDZllGKzQwMnA3akE5Q1BtCjlt
d3dkQ3YyTUFqb0ZEK05pUWFYakNkMHprZFYxc1hoc3VzRkU5ZnJWNkg4bG5GTjhwaVBTK2c4cDJL
b0NsRDYKb0JrbWM4TUZoRS9IR3JZQWhrQzlkMHdoN2RGeEhhc09URW9Fa1VGY1BmQTJDNlo5bVMy
NnFNb2MwRUxVekQrWQpVRlJjTUNJeFhrVm9EMU5NRW5UalAvOWwreXhtbytoY0YxTU5EdExqTDFp
NXI2K3prZzdvZnVKRzB3bnNJZUkrClpOVjRaVG9MT2hCaUhkZGVqSDZPNUxmL1c5WGUyZVFleXRW
dEx6WHpjL0orTjlhNDFpREN3K2JsTEpxbkp1bFMKRnFDcHdITElYTm41WTV0VjN1dWEwYlQ1Q2la
aDQzMHYwam1xRXdvaFY0RW1JNWd1cnRaeElteXNJbzhJZ2FTRQpWTFRtNHFCUEc3d2F5bURDS0NE
NExoZlYzbWFMZjI0Z1Z6WVZoSS8wbktqQTNBdFd5MmlrWkVpNlVrREFRZGxpCnJjRUtPbU0rNjBX
dmxGQTF6Q1FCbmJsY3FzMGxUVGJYYzREUS8zRT0KPXVUUHcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000005d1760629b15425--
