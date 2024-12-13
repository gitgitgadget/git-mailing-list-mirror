Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716DF17AE1C
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 19:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119368; cv=none; b=YHeYF8ZNWnyRAFJQj0Ih5gTwgrHs67OeNaQ1oGNXDJ0FHyfr8oq6fWNl8BTjmPOLTaJbS+DTyQDuCCyW2UrdJkAoRvqXUVJWNPbnt2DF1YtGZCfJE0SiYecCKdR4lGpegFMDZBIOx0+1WeZvHWZ5uAukrw9VmHhlOMnpveIDd7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119368; c=relaxed/simple;
	bh=CDx9rIHeLK2Qad7Vh6zczUdU36mFUF3dKAtzTkPJ7Bw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQHH5jlOU1u9QZzOa9zJ2R4QkRTcq8DtnICtHj3kJV16Kgnvo5LWwtjc1I0VbtMWc+i5dZabX4q5I3wa8BPj33J4AVPCW8n+xEEA0RkdkXv230WoQ7hgEPFskRC+JUoIlzdtUGSj1An09O6GFPwFsRoJaJhii5LrUkS9Wq+51Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SP4g5N1x; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SP4g5N1x"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4aff78a39e1so519664137.1
        for <git@vger.kernel.org>; Fri, 13 Dec 2024 11:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734119365; x=1734724165; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6BS5CZAkWvULk1Q4sOU9g86r/k0CoNRfAymEZhLi+Zg=;
        b=SP4g5N1x/B0mdsl+140grA/CJX5XEOFB91q56o9M2rzkLVGoX4BLgAd4vmeeNzrfVU
         UQCp3KufJIRahIdWKFDRwg0buDuUiGm98HQDUO2xnY9DXBopgpdi4sDVmVhSdhVNcpNl
         Cqrs02L21VsWzQzXIDZLSdtckshMRavVN20iUEN8krRWj34wqi1xwciWIGcBh2h5jLNX
         KFN5RY/m0FEhsh/z0RNuyzJuEgmJEGp10kn72yV1PLP0ZDNG55HeKyoSX1SLS+J2TAlw
         MKwSWjRydxYiSdS9PmPFePzmBl9TmLOh8pjNn1gdBfHcPyspPs3RoEZ4syZi5zhWqez4
         b+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734119365; x=1734724165;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BS5CZAkWvULk1Q4sOU9g86r/k0CoNRfAymEZhLi+Zg=;
        b=ZlN+0QC1tLbpXpPVE9uMcMOeIvPGaOMSvsQeDUnsg+AnWxcg3RlSOIrAGm3HsLzr6H
         vt0VtF0w+DmQtEPqhotsIEIYaHIr0Qgk9j+Nuh7aefHN7vRGhrEa561yP5/nyWOfBLA1
         I4mqM5P65j/f11bMxc6AFWF+48NT7o7SWlMEp+RdTGCd77xuLtt2Z7K5lUkSLslv7Qo/
         ++tscBixqLppHYHvq7Fs4CEg5ZfZwwWtNPUsdnAuKk/PC59tSP0TE4FYHJLlN3huIOjD
         8baOeLk7IZqQ0i4MP7JpyyVNLXXPdPVy9qEi+3HGMGb1a315UTXPQunNbUMudWadmHEn
         Uo/A==
X-Gm-Message-State: AOJu0YzNZ7f65onBdy14SjGVwIVw5BuUyujwK8oIrct7FKfzkLKzEiez
	+h62IP97mthYy7tLM6kjMGTbS0cnvybVtWBvXkI1fIQjKbsmb/tUjHFtB0cZpTpY+8/RsuB6OkM
	t29oxTt82iVXWg6+N5HkT2VyYw+4=
X-Gm-Gg: ASbGncvlIysUHIUIuB/NuNgvq1wmHtiuOPTydaltpJoHXWJEDXoopWzykRhhiBnNGF1
	l7D6nLZ90LulQdgiZ/xshtT68jbCLWFeeVuie0bZtcF8Gnl08HDF5e/9WsNIRNoPXz2njv3oE
X-Google-Smtp-Source: AGHT+IFcLXiwaLue+2b6k7ivGQrWbDeQAS6ayrqvIbMt80//78h8Sl7/f2wozB6XGRJnYmvFACGYc8B60iPV2mePRzk=
X-Received: by 2002:a05:6102:c54:b0:4b2:5c0a:92c0 with SMTP id
 ada2fe7eead31-4b25d9df27dmr5725973137.13.1734119365363; Fri, 13 Dec 2024
 11:49:25 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Dec 2024 14:49:23 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <CAP8UFD1MOChEhJhW1i4E3D62k_to5_r3P05LCbFRXMrEunvAfw@mail.gmail.com>
References: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
 <20241213-320-git-refs-migrate-reflogs-v2-6-f28312cdb6c0@gmail.com> <CAP8UFD1MOChEhJhW1i4E3D62k_to5_r3P05LCbFRXMrEunvAfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 13 Dec 2024 14:49:23 -0500
Message-ID: <CAOLa=ZRyr6yG6=UDQ6Lr2K6mSPiMzg+iopPHPwWdjFgyjxgfVQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] refs: introduce the `ref_transaction_update_reflog`
 function
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000c56c9a06292c2010"

--000000000000c56c9a06292c2010
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Dec 13, 2024 at 11:36=E2=80=AFAM Karthik Nayak <karthik.188@gmail=
.com> wrote:
>
>> +int ref_transaction_update_reflog(struct ref_transaction *transaction,
>> +                                 const char *refname,
>> +                                 const struct object_id *new_oid,
>> +                                 const struct object_id *old_oid,
>> +                                 const char *committer_info, unsigned i=
nt flags,
>> +                                 const char *msg, unsigned int index,
>> +                                 struct strbuf *err)
>> +{
>> +       struct ref_update *update;
>> +
>> +       assert(err);
>> +
>> +       if (!transaction_refname_valid(refname, new_oid, flags, 1, err))
>> +               return -1;
>> +
>> +       flags |=3D REF_LOG_ONLY | REF_NO_DEREF;
>
> If we could switch the above lines like this:
>
>       flags |=3D REF_LOG_ONLY | REF_NO_DEREF;
>
>       if (!transaction_refname_valid(refname, new_oid, flags, 1, err))
>                return -1;
>
> maybe we wouldn't need transaction_refname_valid() to take an
> 'unsigned int reflog' argument and we could instead use 'flags &
> REF_LOG_ONLY' inside that function?
>

The issue is the that this changes existing behavior, since
`ref_transaction_update()` can also be called with the `REF_LOG_ONLY`
flag set.

But, I think it is a worthwhile change, because earlier even for reflog
updates we would show 'refusing to update ref ...' as the message. I'll
add this in and also make a note in the commit message.

Thanks

>> +       update =3D ref_transaction_add_update(transaction, refname, flag=
s,
>> +                                           new_oid, old_oid, NULL, NULL=
,
>> +                                           committer_info, msg);
>> +       /*
>> +        * While we do set the old_oid value, we unset the flag to skip
>> +        * old_oid verification which only makes sense for refs.
>> +        */
>> +       update->flags &=3D ~REF_HAVE_OLD;
>> +       update->index =3D index;
>> +
>>         return 0;
>>  }

--000000000000c56c9a06292c2010
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 80e1f8499d5395d1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kY2o4RVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mKzE1Qy85SEY5TzFMYWtHMkRqZnQyVTBpZGVxMHdlMwo1UFJhZVdkRXUr
SVVkMmtibHl6WU9ud2w0Q1FkWVFxbnYwYlV5QWVScFVQODlpYlZzbzFvU3duTzlzT08zTmJsCk80
ZE1DanRpREVXT1FCNmx1bGJ3T2IvUTRsMGVMRUM4Tytkci9mWEhRbCtEVzRuUXRXZTcyV1lKMG1h
UHROOTQKMGVDMzZWMERBb3k2NXF2Qi8rNDVveGlWWGZJK2oyMjVmbERsTkJGWnUyQ1RldUVkeWxn
S2g2Yll1Tm9nSjVyTApxK3ZlT1lqY1ZwVHM0cXZXcDhXcXA3Q2h4S0Ftc2lVeTVISGJMQ1JTUlFr
OVBMUFNZTytRVDlSZHpWdExxUEpSClZpT05ERVFCNWdaRUx6aVFWemxKSDJFb2lFM2NIT29qajBK
V1BDM0M0bzN2RUdQWWp2SkpmZ29id3dSR0pSWHAKdDcwQ0crSlhibE90NVFraVl0djZCMjErSnRY
Zk5XMUlSSW9GR2w1MWwxejd0N1c0aUhxeWo2RUJXR3FQOHZYVAo4V2E5TmkxbDZWOElOUmxOdm1m
UFFEK1lxbGJkWTZDMEtYNEJtN0RhOXYrMENXbHFqZWNQMEljb2ZUZGpqQWRKCjRkZXdRN1dCd29h
MHYzQ0d4S1NPWC82RC9manZCaXBseS9RRDlZTT0KPWN5VWcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c56c9a06292c2010--
