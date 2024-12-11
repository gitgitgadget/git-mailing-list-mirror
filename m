Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68797246344
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733940397; cv=none; b=kW51zVJtp80IyT80cSdxXY/Sz02WeEap4+cTuugpulL5NRl7tduk4E4rQ4s71SwKR5wJFtDgw8OkferJkRm1jEBquu7UH028JBDcMlvPjHZwLDmEOAjShkcUB8gRirYKQKFIbbZbQ0aUJKYEz+EOxjfpQqvDMI8CazBmg50ANfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733940397; c=relaxed/simple;
	bh=78X55q2so0BAdYtBDvPOslW08w65sM9FViRtoTkwHIs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJa4cBLgrbGwrV0pPLdUd7JILJY5NgpzcDiZUYsNLxRBUVALh1OUbXZGyuqbHBUScP3hLmqy4dfsl75oUeMfmMRo+7kS/TkkQrhV4RO5bxtXWfXFtDXi/Xz2CgdCzqwQMxl9MDh16VMXxGuR3kLEph+DVz9++4wzcS7uuDU/ZgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gex0kmPv; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gex0kmPv"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-85c4b057596so1071092241.3
        for <git@vger.kernel.org>; Wed, 11 Dec 2024 10:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733940394; x=1734545194; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=b2hEct6W+/jYxws6le8nVLK8LveCJS5KJeIG3z8O5v4=;
        b=Gex0kmPvMZ2I7baPapoyEf9vR8vgS/UCDWCyUYbfJIm9H552jXM6m1+gO4y14KoLHU
         r8tPjDZnj+fe2alvIO/rld9rpD3F9R8A7OP7SosaceE8up7/0c6Mpqh35MPlQ3tD1xJg
         crJWHFeb0z9USbcz5cxNDClIFlUul8yCXGWhJKRx6dqg//QRVdVYeR3PmYiB1UHmkCmt
         68TmeRHMyBeFxvQ1m/NRqajKbQeqf+4V/XtHdj48AYjcfidMKlDDZfnX/HY5d3a+ArTn
         Ly8qFwSZAu+RZAr5R4ptEe3/alKg6a/w9jQIHKXiTUP6C+c+UtxBmuqX6eqIgBKyfCwr
         O5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733940394; x=1734545194;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b2hEct6W+/jYxws6le8nVLK8LveCJS5KJeIG3z8O5v4=;
        b=qLJeU/1BdZPP4oxYSNoF3W4mChygd5QczOcNc3NX5fMbg8TQ0trDW9nfvsnjZVdyPz
         WmpxuBcQyuR/23XC7AxY+QVAkFpIiwGAIbAbkdQ0UmelEkHFRSUygpayZpNa6soFXf2t
         XwpkFjiSvMPaygtDxqWL1hi+OjSWCxRGJJi6jj9NCm52HcKp6mIRNXCrcTUlxXWUEway
         RuoJJ1bC4WIqnI/DHV9w/jfMNKMPk8j2gvmnKRc7d8xShKI8eiObU9SYU8Hh+GYMxfwK
         XQY3lfgeDk4HtALDt6D1OS+Fk4BG3u689UKMbTo+mvyC9JX+EeoI0UpVWkktml6Sn2Ws
         CbDw==
X-Gm-Message-State: AOJu0YzVjX20tzPQ+HKcUDAk5l9A3G9xWiRt/DwYmVnzXOz+Bi29G79m
	xge4JOq3QHq0wBHeT+fhcdGiX95KIombYbqzbbx0dwFjXjWHzdrOHMw6YVAdwethCrAKQ4mo+Jy
	ONB/PpOb7PW3QbmjfwbivAxboXOM=
X-Gm-Gg: ASbGnctlRyhdTS+c2+J450sW42BRrypShbLMc5Zw3kGly6cA73lDIoctIqjdOcxs54U
	S5ZgolB/S6Q9J6j1Tk39/3Ws+X6OSdWB//PWwmDFRPHFPRl0GG/ILMEBKCBCbH7aC2GA7bw==
X-Google-Smtp-Source: AGHT+IEd/BMQ6yaByrHv52+2QM9d9JsCpnQ8MVMXV/1v8k7ZW7UIFDmJmrTvDQSyScA1k8I8HHg9n1hjjUkDboyW+ps=
X-Received: by 2002:a05:6122:250a:b0:514:eeba:517 with SMTP id
 71dfb90a1353d-518b5df1d49mr130584e0c.10.1733940394172; Wed, 11 Dec 2024
 10:06:34 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Dec 2024 10:06:33 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <CAP8UFD1vTEH=7HBX1sudwkv7now9VUkFR3Y347EVNGfToZt8fA@mail.gmail.com>
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
 <20241209-320-git-refs-migrate-reflogs-v1-5-d4bc37ee860f@gmail.com> <CAP8UFD1vTEH=7HBX1sudwkv7now9VUkFR3Y347EVNGfToZt8fA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Dec 2024 10:06:33 -0800
Message-ID: <CAOLa=ZQFAMdW78QbPYSoCtqetwT1S6z8dmLS_XG6Ex0nUsp9Cg@mail.gmail.com>
Subject: Re: [PATCH 5/7] refs: introduce the `ref_transaction_update_reflog` function
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="00000000000041e0cb06290275da"

--00000000000041e0cb06290275da
Content-Type: text/plain; charset="UTF-8"

Christian Couder <christian.couder@gmail.com> writes:

[snip]

>> diff --git a/refs.c b/refs.c
>> index 732c236a3fd0cf324cc172b48d3d54f6dbadf4a4..602a65873181a90751def525608a7fa7bea59562 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1160,13 +1160,15 @@ void ref_transaction_free(struct ref_transaction *transaction)
>>         free(transaction);
>>  }
>>
>> -struct ref_update *ref_transaction_add_update(
>> -               struct ref_transaction *transaction,
>> -               const char *refname, unsigned int flags,
>> -               const struct object_id *new_oid,
>> -               const struct object_id *old_oid,
>> -               const char *new_target, const char *old_target,
>> -               const char *msg)
>> +struct ref_update *ref_transaction_add_update(struct ref_transaction *transaction,
>> +                                             const char *refname,
>> +                                             unsigned int flags,
>> +                                             const struct object_id *new_oid,
>> +                                             const struct object_id *old_oid,
>> +                                             const char *new_target,
>> +                                             const char *old_target,
>> +                                             const char *committer_info,
>
> This change (adding a 'const char *committer_info' argument to
> ref_transaction_add_update()) is not described in the commit message
> and it requires a number of changes to the callers of this function,
> so I think it might want to be in its own preparatory commit before
> this one.
>

I think this is a great suggestion, it would reduce the congnitive load
of the commit and make it easier to review. Will do.

>> +                                             const char *msg)
>>  {
>>         struct ref_update *update;
>>
>> @@ -1190,8 +1192,15 @@ struct ref_update *ref_transaction_add_update(
>>                 oidcpy(&update->new_oid, new_oid);
>>         if ((flags & REF_HAVE_OLD) && old_oid)
>>                 oidcpy(&update->old_oid, old_oid);
>> -       if (!(flags & REF_SKIP_CREATE_REFLOG))
>> +       if (!(flags & REF_SKIP_CREATE_REFLOG)) {
>> +               if (committer_info) {
>> +                       struct strbuf sb = STRBUF_INIT;
>> +                       strbuf_addstr(&sb, committer_info);
>> +                       update->committer_info = strbuf_detach(&sb, NULL);
>
> Maybe:
>                       update->committer_info = xstrdup(committer_info);
>

Indeed, I thought there was a better way. This is what I needed to have done.

>> +               }
>> +
>>                 update->msg = normalize_reflog_message(msg);
>> +       }
>>
>>         return update;
>>  }
>> @@ -1199,20 +1208,29 @@ struct ref_update *ref_transaction_add_update(
>>  static int transaction_refname_verification(const char *refname,
>>                                             const struct object_id *new_oid,
>>                                             unsigned int flags,
>> +                                           unsigned int reflog,
>>                                             struct strbuf *err)
>>  {
>>         if (flags & REF_SKIP_REFNAME_VERIFICATION)
>>                 return 0;
>>
>>         if (is_pseudo_ref(refname)) {
>> -               strbuf_addf(err, _("refusing to update pseudoref '%s'"),
>> -                           refname);
>> +               if (reflog)
>> +                       strbuf_addf(err, _("refusing to update reflog for pseudoref '%s'"),
>> +                                   refname);
>> +               else
>> +                       strbuf_addf(err, _("refusing to update pseudoref '%s'"),
>> +                                   refname);
>
> Maybe:
>
>               const char *what = reflog ? "reflog for pseudoref" : "pseudoref";
>               strbuf_addf(err, _("refusing to update %s '%s'"), what, refname);
>

Much nicer, will add.

>>                 return -1;
>>         } else if ((new_oid && !is_null_oid(new_oid)) ?
>>                  check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
>>                  !refname_is_safe(refname)) {
>> -               strbuf_addf(err, _("refusing to update ref with bad name '%s'"),
>> -                           refname);
>> +               if (reflog)
>> +                       strbuf_addf(err, _("refusing to update reflog with bad name '%s'"),
>> +                                   refname);
>> +               else
>> +                       strbuf_addf(err, _("refusing to update ref with bad name '%s'"),
>> +                                   refname);
>
> Maybe:
>
>               const char *what = reflog ? "reflog with bad name" :
> "ref with bad name";
>               strbuf_addf(err, _("refusing to update %s '%s'"), what, refname);
>

Similar, will do.

>>                 return -1;
>>         }
>
> [...]
>
>>  int ref_transaction_create(struct ref_transaction *transaction,
>> -                          const char *refname,
>> -                          const struct object_id *new_oid,
>> -                          const char *new_target,
>> -                          unsigned int flags, const char *msg,
>> -                          struct strbuf *err)
>> +                          const char *refname, const struct object_id *new_oid,
>> +                          const char *new_target, unsigned int flags,
>> +                          const char *msg, struct strbuf *err)
>
> This looks like a wrapping or indenting only change. If you really
> want to do it, it should probably be in its own preparatory commit.
>

I think it was the auto linter, will remove.

>> index a5bedf48cf6de91005a7e8d0bf58ca98350397a6..b86d2cd87be33f7bb1b31fce711d6c7c8d9491c9 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -727,6 +727,18 @@ int ref_transaction_update(struct ref_transaction *transaction,
>>                            unsigned int flags, const char *msg,
>>                            struct strbuf *err);
>>
>> +/*
>> + * Similar to `ref_transaction_update`, but this function is only for adding
>> + * a reflog updates.
>
> "a reflog update" or "reflog updates".

Makes sense. Thanks.

--00000000000041e0cb06290275da
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4a93a4829e7edd5f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kWjFLVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNDZaQy80K0c4T0wrSlNZdjRtRXYxaUpURDdyS0pmQgo1WnlZSXR5Y2d0
cjVRTzdvL0dCWmk0b0hzMHYwTktVRXBMY0tuRnE1UHlzdHdEVjRRL2dNZ2pTQ042T05XVzBPCkd4
RXhpWGxrZ1cwZXVlc2hBY1lad0pDaXZsOXQrcDZoMDFaUzVzcVp1cVByYjNvRmNMOFlNVzBaRmZG
cEg3T0oKWUFMd3Q0NDVwZGZMVW5MajVlajFxM25WODVXOWpsV0xBR3pHTTFvVzVETVJCeGY2Mzd6
NWIzNVVzVnc1V2NMcwpIYmYvTVVrOUtUNlJXWkkrb1B1WW9iMDArU0Ezbm81WktOQ1BQVnFxNXM2
bWIwdzhlaVA2dGFuRVphajlycmg2CkNoNjhReEs3bE9GcGtoeXlFWjBCTDNQS1RrNyt3a05namgv
Z2Jmb0xHOEVWZERhaTZjeVJ0TTF1V2puOEFmTmsKY3VSV3VQbE1ZOTkyOVlndEcrZElMcCtZSEti
UWJWQ1ppMllZZFlpeGdYNXlEejZ1OWxBK3JiSjJJL1RPQXlPcQppaGpTWnpEelhtRVNPUFNYc3Zy
aDN5WkxRbEZpRFUwa0xWRVlRTVhzRkJqTFErYkZwYXc1aFhuNGF3MW9qcC91CmppbDNjN21lVmZy
aHRqVHU5L0pmMEZUNjNIakh3bGZKUU5SeTUrST0KPWRqTDUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000041e0cb06290275da--
