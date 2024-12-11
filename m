Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C889236FBF
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733912801; cv=none; b=fjAG3k6vxk3yUc1jH71Nk6sDP/3msHJym0QFaw0jfHVOf3nywJpae1miNWbuvNyAztz7Dvcss+UUYUI4lskXDFxstA7WlTMhhiPecR9Yax5WXIObTq7gOcuX5h5dIOFpFTUVWIci8WWmi/dO6KrPzFHO+3/CHjoSlJxNzE8GAtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733912801; c=relaxed/simple;
	bh=x9z8YaAdCV6hHwlS6gvekCUv1JmRjKq/v6bfN9rUo3Q=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaTs7HrVw2zwmplY1cTKLXkLYJaEJ0+ggdKFIxKw0E9DSdokOuU18HyWnkA07zBssgL+8EoRXniGnKJzffwbjBLbDtKOUdpSlvA8Fv400p+YYv2/nzR9Z/lJVZIdofqR9YvBBPLBJbGty/i+sog1WWSFLgMARmRb8EQL3Hkdl48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewvxKa3y; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewvxKa3y"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4afdf300d07so2344560137.3
        for <git@vger.kernel.org>; Wed, 11 Dec 2024 02:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733912799; x=1734517599; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fMYH2P1zHbyeABDaPEBPdT4z4i7HtGhVUCyOAz662CM=;
        b=ewvxKa3yAO2GCTRT4ooa64R/ZqKq4fSXXvKreodgNyovw+BEZDtxYL6YAjOsYA5nHi
         K/+AQKcPRQ11F0swValXMSOELL1R0byjyZUSIgDIlv7XyBfSxHObsAPpUJpUfx2mAnM1
         3v9z833QC7wnur+7l4lA86bNVst0/PBVuFXJT2JBqTx0gcK6KJ3ooKCdnT9wRfdZVvMH
         1PiesxJAYgeFMftzcU5qXZIT/tgso17+S81Sm0k4e1INP+JHt+9GLK2RcjdYnuNtmAkl
         RQM82w3HAarXMeBed8RqlnwNMgVsJxXogYcVN51Eb9kL6cFoV032WE9pLbBKeRNQ+258
         odRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733912799; x=1734517599;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fMYH2P1zHbyeABDaPEBPdT4z4i7HtGhVUCyOAz662CM=;
        b=Eicd9mpRNhS9PuT5EUmnUM3YvLiq0J5Wu8ZH7IVZgLPsWF0fSB7Q/lnm+IEBwPInpF
         dmI09MXx7end2LFtWccJxG3zCXV0xJOsiXwnYeO/p/cHzHopYQjB1Vo/l1QHHUX8H8f/
         cyBIw5bVKPSXC9HcgsEtemqPpMl3sFvisMMycR3xNmbHQd/ljeP4dVgKZQ5yfGzbBt2T
         2N6HciuoHUyRk4DeugW7sYCWuyZIigon4CrahNVCSgfudZoAyPcGhCkbuFfVd2xCtzlP
         QCHzj+/0HFKwJ1/Pqrq4dSfKrvOvexgAPeYD8HRQonNA9ubBos/rMQ5FLBFXF0E5/bWi
         P73w==
X-Gm-Message-State: AOJu0YzZBIVLHC6blrK/x3X7MpzMpXOXftjxT1qjwMZFGiaJzITLFkZT
	FSSPy6DSQ4TxcJnrZ7K8/9s+vTFKShQm82qnUxDizAFbKWfmwGE4qrhbyqzQUydRLbKY0WAaqso
	0BQt7VmP45Ew/x076UYB3gXxOKgs=
X-Gm-Gg: ASbGncv9I8CZ7B2Kre3FGEqyR/YCzLLqG1LbPVq8EPSM+m1plg9vXG93MtK07hVZnTv
	n8pUiQWgqzdq8N5kvbH1KbII/ypYp02l6TlmlohSXudqIO2iHob66dEAbPHPajuQGnOTEnw==
X-Google-Smtp-Source: AGHT+IHRvyyXO2Y5mO9MCb7/z2lFkOyfDJtMbF8Wmge5pjHxr6OvDspJ6T4w/eTjJCimhh/msW+lg9rcxMMn7cUTC0s=
X-Received: by 2002:a05:6102:dd4:b0:4af:597b:ef with SMTP id
 ada2fe7eead31-4b128fa170amr1890333137.8.1733912799111; Wed, 11 Dec 2024
 02:26:39 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Dec 2024 02:26:38 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <CAP8UFD3StHePPGe+44c83qBYoZLZme+Gw-cP7Weg-neyJg8DOw@mail.gmail.com>
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
 <20241209-320-git-refs-migrate-reflogs-v1-3-d4bc37ee860f@gmail.com> <CAP8UFD3StHePPGe+44c83qBYoZLZme+Gw-cP7Weg-neyJg8DOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Dec 2024 02:26:38 -0800
Message-ID: <CAOLa=ZRmGtxRrWnYPW6i8VX1MjQxoY8srKESgyaoutQxR-aZ3A@mail.gmail.com>
Subject: Re: [PATCH 3/7] refs/files: add count field to ref_lock
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000769abf0628fc08ca"

--000000000000769abf0628fc08ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Dec 9, 2024 at 12:11=E2=80=AFPM Karthik Nayak <karthik.188@gmail.=
com> wrote:
>>
>> When refs are updated in the files-backend, a lock is obtained for the
>> corresponding file path. This is the case even for reflogs, i.e. a lock
>> is obtained on the reference path instead of the reflog path. This
>> works, since generally, reflogs are updated alongside the ref.
>>
>> The upcoming patches will add support for reflog updates in ref
>> transaction. This means, in a particular transaction we want to have ref
>> updates and reflog updates. For refs, in a given transaction there can
>> only be one update.
>
> Maybe something like: "For a given ref in a given transaction there
> can be at most one update."
>

Sure.

>> But, we can theoretically have multiple reflog
>> updates in a given transaction.
>
> And: "But we can theoretically have multiple reflog updates for a
> given ref in a given transaction."
>

Will add.

>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 13f8539e6caa923cd4834775fcb0cd7f90d82014..9c929c1ac33bc62a75620e68=
4a809d46b574f1c6 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -71,6 +71,8 @@ struct ref_lock {
>>         char *ref_name;
>>         struct lock_file lk;
>>         struct object_id old_oid;
>> +       /* count keeps track of users of the lock */
>> +       unsigned int count;
>
> Nit: maybe the following is a bit better:
>
>       unsigned int count; /* track users of the lock (ref update +
> reflog updates) */

This is better, will amend this in too!

--000000000000769abf0628fc08ca
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b0f42cdb1079e61c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kWmFOMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md29hREFDS3U5aVQ3ODM5Zk9PaUZZejBQMnZuZFJvZQpGY0ZTeU1GS1E3
Z0MvOUVWK3EyZUxPQXA5dnR2YVhJc1F2cmZBZ21hUFI3MlhEYllrazJEMkxWU2hVYUhHdDBYCkJJ
UXBMZzJscitaMURPL2pNSFFrZ3pYalJEQmx2NVJ0bURaZCtYQm9ZVjVSbGZDN0wwUGdmMFRzdU5X
akF5cGMKL083RS9yZ1JmYm5BbThZREtSN1JWRnZ2ZmhKdzk0Y0cxTnNOV2g3VGc4OUttZzZ2SXN4
Vjcxb3N3QzhEaDNnQQo5TEpWMjgxWXJYV3B1YzRQdDQzRFU3TXdVcExLTWVhTE9QSUhvZUgrUUpq
OEIyc1l5U0RRSExrUnpFbjJtbDNDCnlvdWR4WCs0TVJCeUVuY0NuZUV6cGxIN2lhZzFRM0dqVS9I
ZzFIenhvclJ0SG51V1hpRDVTMGVCcU1mOWUwenEKV29BVXdJYnRyZ3BWWmlUcGh1YVRMQ3ZTUU96
WTVBSGFrd20wejZtcFRPajlHTHVDUXJvVWliQmVjb1hwU3U0dwpRUGFqN25NeFhZRkx3Q3gxZldz
M09pMTFOK0RzUHJaaGtsVnVrbU5HVUltUGt0UU9DeUYrZ1c2VUw0U0MvdjlTCkhCbTB5RW5LeUJi
Qm92WUswRjZYVWJHa255VFRhQWM0eEhIdFRCUT0KPVBySE0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000769abf0628fc08ca--
