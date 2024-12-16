Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE8026AD0
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364800; cv=none; b=ImOK7SYddJuaMKCcIrzIb7Qh47y0LFkwgyl+7Qx0xRVegsqP/GD7CZESkzRQp/H5AU4A4AtconcACEA5MPB2iQ8ibguSHR78WGUPdTJRLY49P2kGegY4A8wDh+mOR4Fyn0v5V+lUvUSrRPLUx0+FX/jBGDtzxkCQlK9GGjbjYMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364800; c=relaxed/simple;
	bh=sHPohuZxFm0R6tE9lnic1Uw4NOGAbRXeaDcSXqkVcKQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdPVry+3LUoMoYxJD8qzlkHrnlbfJV63QLznnNRIEoloEUJcpuJCUiylpqPeOstow2E2rKlRsJ4l89VWkkSHFea4RiZaCo/w3WbNV0Hs3L8d4ebqxmCyHSxV/ZrmvVKq7zJ8avC3wWMmVlVMxu/f/1dBbLkTrAY+ZHA8nTs/Y18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8ZHS//x; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8ZHS//x"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-85b92397fe2so787471241.3
        for <git@vger.kernel.org>; Mon, 16 Dec 2024 07:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734364798; x=1734969598; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2+dXC02+Fa6VjrTGhdNyE6ieln2caBuNhkV05YvIy0k=;
        b=f8ZHS//xlaYYnn3kRcokzwU//dpeX4l4rZDb6RJ0YIzejYayXyq8zHgXf37zEkw/vM
         gN++2Qh5mDwRAtMo1x+C8fSniSfdFen1A7Hht2GDOyWilO1vifwZ/PtiGq37PkBQcPdK
         0iGTO/PFPX4FrpTsu8+qnXWaRNjFuRSj3WSErrxmgzunmp9iAnfhbK9EV83FHjSLhFUY
         f7ibISpK8ox64GKtn0YLtRTzD9IlClzkHEiVt+TU1HkafKLG+9WFOho/he5kT7xFX2S7
         VduwdclqIBQsnKfePoVxQuyOjxrAPIZt9QEC3d5fqYMtY1Yp4vu/AhEdGQ+M11XKstWL
         2ZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734364798; x=1734969598;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+dXC02+Fa6VjrTGhdNyE6ieln2caBuNhkV05YvIy0k=;
        b=odHC7ur1YBLjDvo5tGNBCc99uI8/ZGruEdh81SGwRZxL74mzYY9b1WLfd8PMuA+nN8
         ma3NkJ90UjIFT1f2TlFcxdMLFDrq5pYoRRbR3T/ipRhkUXbvKw3ygBa1PUs4gvgw7Ywt
         o82w6MtkwCvzPp7Q7tB0phnldyH6QV1H/j8fAua4C7aC6Js+4k1p709+ielBj7nQkZP9
         qCm46YWR2u4/1Xc4IlmaX4fVwopC4NakZS5fMTE3ufGa8vQ4A428mGe0WwvBxMJCzBaP
         IuKYaIHslFdYi7zUBYmj5bEJZUcqMX8vrMz9eJEWo2QSEPLlA71Z/VpZHDSG3dNr/IGc
         MXnw==
X-Gm-Message-State: AOJu0Yzx7BtKO7plDb5sMI9RZiTWf945lQXNF0qn/G0cv2vXEkMwk+4V
	PKLGi8x31Op9WYvdvdAJWDyNTkj9jeKcLgfnkeW1wcBu5dlMuW0QMsSIo7B5t9mce7oA83ajotU
	m9wv+ejTzC25a2jmO/V039E+bg32JvMc8
X-Gm-Gg: ASbGncu2+BGrX4LWLUAzJYt0VtGZ8ZdJmJsETpsUqvwUZ50dk3QF2m+t04grul/EXA/
	ALs1mLcI6/UN2N9lXs2biJ3TZMFCgq2ViV867
X-Google-Smtp-Source: AGHT+IHnBhpxJigY+9hkL3sDn4j+rcvKqs88j+UD7Vh8I6BS6gSWssz1xmGE1H12b4gdKFiSxfH71Wa67sjJGNlzvHk=
X-Received: by 2002:a05:6102:3f07:b0:4b1:1f9e:193f with SMTP id
 ada2fe7eead31-4b29ca86550mr565148137.16.1734364798174; Mon, 16 Dec 2024
 07:59:58 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Dec 2024 09:59:57 -0600
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqo71b7hkn.fsf@gitster.g>
References: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
 <20241215-320-git-refs-migrate-reflogs-v3-8-4127fe707b98@gmail.com>
 <Z1_KzlKc7RBfas4L@pks.im> <xmqqo71b7hkn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Dec 2024 09:59:57 -0600
Message-ID: <CAOLa=ZQniLNyxmvypm8BwMHyBRNb6E+SM8AXZiJpprpda5A4bg@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] refs: add support for migrating reflogs
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000b4e6020629654518"

--000000000000b4e6020629654518
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>>> +static int migrate_one_reflog(const char *refname, void *cb_data)
>>> +{
>>> +	struct migration_data *migration_data = cb_data;
>>> +	struct reflog_migration_data data;
>>> +
>>> +	data.refname = refname;
>>> +	data.old_refs = migration_data->old_refs;
>>> +	data.transaction = migration_data->transaction;
>>> +	data.errbuf = migration_data->errbuf;
>>> +	data.sb = &migration_data->sb;
>>
>> The `index` variable isn't getting initialized here anymore, so its
>> value is essenitally random. I'd propose to use designated initializers
>> for `data` to fix this:
>>
>>     struct reflog_migration_data data = {
>>         .refname = refname,
>>         .old_refs = migration_data->old_refs,
>>         .transaction = migration_data->transaction,
>>         .errbuf = migration_data->errbuf,
>>         .sb = &migration_data->sb,
>>     };
>
> GOod.  As long as it is sensible to null-initialize the relevant
> field and all the other fields not mentioned above, that certainly
> would give us more predicitable behaviour ;-).  I do not offhand
> know if 0 is the right value to initialize the .index member with,
> though; didn't you two recently had an exchange about starting with
> 0 or 1 or something?
>

We did [1] indeed, context is that I set it to '1' to distinguish
between indexed and non-indexed updates. But it wasn't logically needed
and was confusing so I decided to remove that change (which caused the
issue here!).

[1]: https://lore.kernel.org/r/CAOLa=ZQ9SHD3gzTVaznGhkCBjrrJbHm1fDyi1F-h6VZvtdpxgw@mail.gmail.com

> Thanks.

--000000000000b4e6020629654518
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 19ca1d13fcc69ce5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kZ1Rub1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meEJKQy85bk55K1J3MFpQRzJQeHlBbkt6NW92Z3pNRwpMVHRZOHFzVEtR
TmNDUUdQM3VLY3hzeGp6bjl3cGFIZlNzSWZVankzYkRsMHlSb2NTblBEZm9HVmdZbCtma1A0CjJR
ZEM2UktObFVoekhDT3RpZVcyeVRaWUVCSUNmdFhOUEFkR3BLSXpxZEJ1YjVvZTZFcWFrbTdZRmEy
cWZhSmYKaUF1UDhxOWMxbVpHOW4rR0RhWmZEdndjdEg2d1cwVkhBRURNMWpPbzNJeW5rZC95Zk5W
TmhkM0R6eGhQU1V2NwptTnZONnpYMTNLVGNWWDhCT0RqcUt1ZzVVRzc3d3dWNEJBL3Rra3FodS9G
RXpwM0xYdUlqWW4wdVVUUmpxM2VCCnUrMjQwNnlrd1Q0SmdmMC8wcStXMXZTS016NnFHTEdvQ1Qy
cklFRWppT3N0bnZrbysyNlBtYjRvMnRRclI0Q2cKTDlKSlhUUFBOUGhJMG9SYjJVRStMOHN6UzZw
NGFHV0Z1aTEzWG51Wlc4RFhsaVhlNXg1TVNDNFpodHRnWGR4Swo1WG1DdjYyQXdtL2pqNHBzWlhC
c2ZHR2Fad0V4c0xoVUVObEFjUDNvY1ZOWkJXa01zZUNLdzc4VDhSVHFGODJTCk5vYy9FaWJ2Z1Yw
U1ZhYzFyNzIzeHJzWkw0azJ1UHVqUGlGakhXTT0KPWdXWlIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b4e6020629654518--
