Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9A54334B9
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789381366; cv=pass; b=YlDZPJiX3KLnfWWvreEQCA3Upl8SImYMoCpYjKSa54FD1gUNS1um0HM6tEc7cjIWtn9GiKaeHpv7MFN0hbkeAdEEo0lnYPqXQg/IcyZq2kmdHrJvoKwZFWOwWPeLXS8lGUzxXUu9RibtsbBqv7zHerRVmOxoXf7NTSN/x6plCcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789381366; c=relaxed/simple;
	bh=J7M0HUIXuOIWK3ydNaAxyqJmT1QNx0XdF+a5+LSLKms=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBq/TY0UrXpGXLKQSjjLAPnmIsKkqNCXt+vLZw5auhxjMHvTcpeYA+HOXITR84jXhaFfwQcPmHyI3N1r6EbJD6nhgUDKA/uF1bnJPdP+z5U4+Vjd/TWRQk8EURxS7cT8BQOyE/SZboXV3YKuBMrIpz49mZg8bUBlMykyemkbT+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cO0MLQmj; arc=pass smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cO0MLQmj"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-78564421fdbso505958137.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 03:22:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789381362; cv=none;
        d=google.com; s=arc-20260327;
        b=T3yHfA/P4DhyRYX32Gnw9bjJS6M8rdfOfWjnbSpwC6rHKzKpWmWVqwja2zpFuICgj3
         nV3gF03EWxCk5HANt6JnM4NRJ+AmeKW661ARZ4uDF4R7UiIJlA4qItk+m69ZnnQRhkYw
         fbDMY2HnD6dx14FdhaoY92dOYdg/bkpFS1+3VF5U3QVuEZZegpIU9glfW5r9uLQlEOtH
         PNTd+fVI2Oej5IMGH9C8bGjWPQw0JWmqr5kI3JM8wGK3y8QVXuPOvGt2x3OVTw2oQyyI
         +fkHsh2bTP0qfEjdEJFKgLUyu07WfusSuzTV5Q8yGdBSRPTf9ozmlS7yMEj0bdHG51w8
         BXfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=mDyMwFjhScjE6kE9SaTP+aV1RSEGbeFFacbgIcxiHVA=;
        fh=LmYxIBxl0FwhuMoxoKINDHd8NB3fHmAKDSEyT4ikUsY=;
        b=O18y/gwVDsUAJYlyycDfJCDsdGgzeNGo+u+JKqeSGxcGegcZEfzTLO/rxDsopkWO39
         Kxv7MN3wGMdq3iZmOnZgZRLmW5ChVA98EeD6sPBBh34lFjtfcKaTOvE4giZR6Ld3WiQo
         YAsy7OT3RJRDpA4jzwCzUzdsvdYrp7D4aUWAvlPAN3p3BOv3Y+QB/7nn9vZGcPgiv/hT
         7S0MXPaa7S+Ego8BLWukZVlBO77WXYtqW0E86z5SrV9Y3z0QGxQOYNna/4949oAobm/q
         87CHNG152Kio61vfjs0Q/d/wpGj7y1jC8+NjNGAb/J+q7mGxT5tgjnic58XHmM8cntGJ
         r9Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789381362; x=1789986162; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mDyMwFjhScjE6kE9SaTP+aV1RSEGbeFFacbgIcxiHVA=;
        b=cO0MLQmjepESPzR6EVLZr8jXP7LfpM7LMxPkTIgvHTL7KCQBQ6tTkDT1dAgLo7YKdh
         /AAOzpJrtCwnV40RLE/LA/Ih/WREDuZK93XeyxnA6CV47eOHmt/n8KaS45e+e/nzIrp/
         lhEm3eHgbXZCIIWUNP8HTtT5Ac0Yv3RkjL3NqjVDSV46XPsmkopLL83FevKwJftzvwMo
         H6ASHE/472VS3FuL/jeoFu+lVK4I7lHyFibOgzPXDJWeNuorCa6i/Fm6wcYBssjXDobE
         HJZ0R7BJKU/L+vJqydPdmQYfdJ6jqCf8m3wCU29lr7RQmzR/FH7IRQ4IiNShBkC/p8md
         TElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789381362; x=1789986162;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mDyMwFjhScjE6kE9SaTP+aV1RSEGbeFFacbgIcxiHVA=;
        b=B3+AzozcYnsvnsKA7yp62omNBrUgtYYEdmzgKlYDW010EjbcHGh8bj5WdEjWKgS1Zb
         havpbVdI1W8yNTd3mE3cVxAj67+VxO+Ec/rG8EzoqJ3kM3VU/8s0BrZhBNO441j0ul//
         a3FR5X2Vb/zluTjfKkifIj+hudovxqFFuECoGIgBWJZHPOOnfLT1YRQApNiAeeLruoBP
         vfN1JlqTLuIBwn3Jrm0GWTrCDX/YPGV6IZFTgxEXSy5GnkK1GxjUPMNx+HMKFontQZft
         CAThafbnSTJiZWLOBwbdTQqyTfCVZQBGbB4JPLtrAjqovrZBWaxMu4uO5r+o744xJDFZ
         jyCw==
X-Gm-Message-State: AFuF++kxnOY2v3hCl6pHK2YA+7lSII3CpJTrzngp34i45MrPv6lHNVJ0
	Z5IbUd6nsPrZ4b3V/YoNEb4TaPnqSSVctGH8oiJunW+sbch98TzwGhfLrbXbW0yISzVQWY3T8LS
	cFFAcConijITV2eA/UFAzu4XZlGyze5M=
X-Gm-Gg: AYBFou3x40U3C+5Z3D+X4GSSuxlN04d1sb7KRzQUmN4vSHWI0IX74Mem37A4p9kK29+
	Zh6DEhyX2W2I2FuUaWOt08N/FTsSheqwatB6Ens0T7KPROR1+aNrswB/rujhW88VNfcch6na04Z
	DyF8kHENI2fQNPv0yGPax3v0SvuNAgrBHK502KO66Lkif1Kq0aZjvPRX6UZZtAbWUBXQrihtCaQ
	sw8fKSpizXS2L5XUFIywbThlceQgL/D2NZusk8Enu3leks2zMUsLtSsAtn7tOkgnaY4ELXIfuWb
	CEKh1z6Sv8vL1jQWXBaEcmfwV7INyvff0xYKVUz0bnJ/lyAKLVprhOPBnQJlOkMSUK7e8xCCuw1
	9v5+3dvhBb7XOmhx6ZMKA/ZtZ4hTYTOFVC+Oe0NXfQbp0dSg=
X-Received: by 2002:a05:6102:a4d:b0:79c:2e36:a4fb with SMTP id
 ada2fe7eead31-79c2e36ab48mr188526137.9.1789381357459; Mon, 14 Sep 2026
 03:22:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 14 Sep 2026 03:22:36 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 14 Sep 2026 03:22:36 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aqOOZB0wQ8FNGVE6@pks.im>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
 <20260910-pks-odb-write-alternates-at-creation-time-v5-0-8d10c4238edc@pks.im>
 <CAOLa=ZRYsJL_0sKnfHD0PJO+5c+BKSMiuN20PeQHKJin82TJDw@mail.gmail.com> <aqOOZB0wQ8FNGVE6@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Sep 2026 03:22:36 -0700
X-Gm-Features: AcwNN1U3h2CmM_s9vJ5zvdkQqfQFRqAm93eOeQ0640qdv_xJUqKSEfU_z--p9M8
Message-ID: <CAOLa=ZSH=Ozzk-870-wfQ7zYhgKcUnmLVOcHxCv1n7NVm8QTcA@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] odb: write alternates at creation time
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000002dfbc0065b6ed0c4"

--0000000000002dfbc0065b6ed0c4
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Sep 10, 2026 at 12:53:21PM -0700, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > Hi,
>> >
>> > writing alternates into the object database currently happens via
>> > `odb_source_write_alternate()`. But while that creates the ability to
>> > create alternates at arbitrary points of a source's lifetime, we don't
>> > use that functionality in the first place. Instead, we only ever write
>> > alternates when creating a new repository.
>> >
>> > This design is suboptimal due to a couple of reasons:
>> >
>> >   - It requires us to have a `write_alternates()` callback, which is
>> >     overblown as we never even write alternates to an object database
>> >     after it has been created.
>> >
>> >   - We're about to make alternates an implementation detail of the
>> >     object database's backend in a future patch series, so alternate
>> >     implementations may not even support them.
>> >
>> >   - The backend has more flexibility with how exactly alternates are
>> >     configured when it itself is in full control over their setup at the
>> >     time where it creates the object database itself.
>> >
>> > This patch series thus refactors how we handle alternates so that we
>> > don't write them ad-hoc anymore. Instead, the series introduces a new
>> > option for `odb_source_create_on_disk()` that makes it handle those
>> > alternates at creation time.
>> >
>> > This is part of the bigger goal of moving handling of alternates into
>> > the "files" backend.
>> >
>> > This series is built on top of 2c3adbb2c4 (The 18th batch, 2026-08-24)
>> > with ps/odb-eagerly-load-alternates at 0076dc9f81 (odb: drop
>> > `alternates_db` field, 2026-08-17) merged into it.
>> >
>> > Changes in v5:
>> >   - Rename `add_one_alternate` and `add_one_alternate_data` to
>> >     `collect_one_alternate` and `collect_alternates_data` to clarify
>> >     their intent a bit.
>> >   - Drop extra parameter in `collect_alternates()`.
>> >   - Clarify why we compute `commondir` even though it's unused.
>> >   - Link to v4: https://patch.msgid.link/20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im
>> >
>>
>> Looks like you missed my comment/question in
>> CAOLa=ZQaPstiQmXm9=TyWPUxL6X2=Lcqeg6y2XeXzSJDpq-GBA@mail.gmail.com, but
>> otherwise looks good :)
>
> Oh, indeed, I somehow overlooked that mail. Replied to it now, but I
> don't think it requires further changes. Thanks!
>
> Patrick

With your response, I have nothing more to add! Thanks

--0000000000002dfbc0065b6ed0c4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 291bfbf64465a8d8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xbnl1b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meDhnQy93SWNzRm4rMzhONWowTUNJL3NXU3dnYTR5NQpJSkR3V2t4MTVv
QVE1eGEvRVdTWlE4YzZHN2d2UHZaZ2hQc3pRYi9kKzQ4UUlMc2hQNDlBbjMwdWJYcmJqSU9CCndQ
c2h5RWZSUlM5QmlyVEhQcWlsZ2pvbDQ0aTlMSVpud0xvcGhrekFBRVhnaHBEUnJ0V2xDU0R4R0k1
clc5UHYKRW84Qzk4M2ZHNjl2c3EwMDhmUzVUTTVtazJHeE9Fekl2bkpKa3JzbGZiR3lMc2JWMkZq
Slk0TzFXKzNRNFlHRwpPcU16T2Z1b1BuaGdYNldJYVFQS3VnTFRxVmNKM09qRmtJang1NTZIVTl0
R0xDQ05mRk9LWnluNEYrTnlIUzVsCnBCVFQrRk5ydHNURTVmTGRJWE9rWVQ4MzN5emhWU2JxbXB4
UmFaM0hIeXVKSjZua1RtdFVJRlptb2hoRkx1WTQKSVdWeVptVFhLVklEOG8rUkNQZUl3bGxwNG1a
ajdyUlIrOWRlTUZMVmZSRU9wMUd2b05Fa25SdFJSaE00UWdnaApKNitDWDZtdTRVV082QWllNllM
NWZKRS9tY04xcE10b2VoN2x3Tk5QODVFNHkzTDBKVEpjRTFOcksxa0laa3p0Cll0SDlUVlJiai9S
S0tYR0wyRkx5eVo0N0pZUHMzTDhXcE1nQ3lpVT0KPTBuYzEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002dfbc0065b6ed0c4--
