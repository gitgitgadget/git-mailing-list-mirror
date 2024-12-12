Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EF42135AC
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734015128; cv=none; b=RXA+BMzcPwRVooHf+d4t5QsdSm9fB/AZFPI15byNTGciCkSMdA6haIjMUyP8MBevsVLHIIjfrEZzEphGLoU9ldXSMJijNvVW49apXAuXzQakX8oNQSnpegYYpRoqNFrfVfwy0L8IWBpje+MhtefdHsrl4po8+eQk4RmZ/fvQoyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734015128; c=relaxed/simple;
	bh=kXx9ngpGhtE/UMP+a9noatYzdMXIgqsSW72ADu7zUjo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O9Sw2uK9kkI9oQexspF4MUpAe+8affS36lZw8Q7XqJ0X5tfumTemIBJNLqvVxZQ9WAK5/9Pcbw/EZNiQY8C3rDHZJiu8h44K7MSm0RQvXIxyUBK2xC2ZsHs96/vqiqS1qNmsrxxr2ZRFgvqAp9TWlCIvB5ym5GH55xLmuvBnYlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hP17Bjux; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hP17Bjux"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5160f80e652so174151e0c.2
        for <git@vger.kernel.org>; Thu, 12 Dec 2024 06:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734015125; x=1734619925; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IOR8HXEUgN8LRXwwEGODFXKWgONeZIKl6xvFkmUvtLg=;
        b=hP17Bjuxqn+/rI8Ma36ahR8A/VFa4HbvP5oDCXO78BK1KdPu29hzhI+NlWa++Fhkk5
         wodsGoAScB1hxr+/ygA7NUtkFRtOgEBUcapVdevuB1ITWfLeH7wbdPSfdqADTW4EuJz7
         MxLkxjEquJDEFGoo4NyWwjKVD8TjGOqHQ8kFOZyIZQaiIsBEec2CRCzj9O7dYPhc0p7p
         Nz3wkIcm8UbtowEhNKIuLPmbyNFjAyr5N3uTMwTRKSCYSLD9PeLQDFzJbY5kmsKABUce
         T7lpfcxvJ9cINQwUZdRjdEV9Cb5aWCrG1ky0FuicZmjxzl9R1KHx6Nn/nnGmwFEz6XNq
         OiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734015125; x=1734619925;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IOR8HXEUgN8LRXwwEGODFXKWgONeZIKl6xvFkmUvtLg=;
        b=tDEsitxbuJBRzkAlLkPZ43Ql+cBCvG9qX2XHv8bbXYeXZft0f43wWM6nfxPrH+JhYR
         GJxFI+6eiczvQApmkoJJCSheUMH4KDhTSB/30XKfL+xJeq4EIUAPl249tBh/Ke1PYenl
         AP2F9+Qs38PE91j+bt3V0j2l3ApYrgFkbKqVvTXY4vboRb897r6D+5eiBzKfnYfjLn1A
         wiP8rjQ1dbKaiuLtKxYAaNaJS+mbHJb0JNiY3sXcTHdm2ZuZ0AMOjMV10iYVqNddsr1m
         XGakA/hJs/wEBNztXtt1bxe4/87Xyjq/t8haJ3U3aiwqLjYqR524J/pCA8DEeZgi650f
         r/mA==
X-Gm-Message-State: AOJu0Yxibw7Y37/12isq1oMbctp5anZlC7mpDiEfq27HZ4eN9zxNYO1a
	n85u1OnNsg6kzQTfXSWA38kM6OWb8jAJ+fozT983ZHnl/7QGIY/rhD7Ktn1IaHJhOSXs1x7btUu
	+BM7cTm4LColxz4MQwosvydL+n/4=
X-Gm-Gg: ASbGncsWpAvF20vF1rPmrVmxtjhwvNuzTaQ60Utb1kQOt6vFLOalIm2LCetGDsgvF5i
	xrJbDFMdLhufqK6JuorSkuTehzo9ymHgLm72Y
X-Google-Smtp-Source: AGHT+IGW4R3TYpyqgKoDwvEgj1jK2Z8N5pEjdjRHBQrB+6ih5QIQXnB/YVQCAOywn2cUVutHLFe+kmGfuSHcIWwlgWw=
X-Received: by 2002:a05:6122:2526:b0:518:859e:87c3 with SMTP id
 71dfb90a1353d-518c585fademr1107635e0c.7.1734015125064; Thu, 12 Dec 2024
 06:52:05 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Dec 2024 09:52:04 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <CAP8UFD2zogHD_g5FOVNFvBswPJF749wd4f2s9Pzgef-pv=U0Gg@mail.gmail.com>
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
 <20241209-320-git-refs-migrate-reflogs-v1-6-d4bc37ee860f@gmail.com> <CAP8UFD2zogHD_g5FOVNFvBswPJF749wd4f2s9Pzgef-pv=U0Gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Dec 2024 09:52:04 -0500
Message-ID: <CAOLa=ZTFJ+U3RmDQs8hwTCnfNfTarpxE1otcYAAV-FSOogAq=Q@mail.gmail.com>
Subject: Re: [PATCH 6/7] refs: allow multiple reflog entries for the same refname
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="00000000000090a9ed062913dbcf"

--00000000000090a9ed062913dbcf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Dec 9, 2024 at 12:11=E2=80=AFPM Karthik Nayak <karthik.188@gmail.=
com> wrote:
>>
>> The reference transaction only allows a update for a given reference to
>
> s/a update/an update/
>
> or: s/a update/a single update/

'a single update' sounds the best here, will add.

>> avoid conflicts. This, however, isn't an issue for reflogs. There are no
>> conflicts to be resolved in reflogs and when migrating reflogs between
>> backends we'd have multiple reflog entries for the same refname.
>
>
>> @@ -1302,6 +1303,7 @@ static int write_transaction_table(struct reftable=
_writer *writer, void *cb_data
>>         struct ident_split committer_ident =3D {0};
>>         size_t logs_nr =3D 0, logs_alloc =3D 0, i;
>>         const char *committer_info;
>> +       struct strintmap logs_ts;
>
> Here a comment might help explain what logs_ts is used for.
>

I think with Patricks comment, this whole code will be removed for
something simpler.

>>         int ret =3D 0;
>>
>>         committer_info =3D git_committer_info(0);
>> @@ -1310,6 +1312,8 @@ static int write_transaction_table(struct reftable=
_writer *writer, void *cb_data
>>
>>         QSORT(arg->updates, arg->updates_nr, transaction_update_cmp);
>>
>> +       strintmap_init(&logs_ts, ts);
>
> I am not sure I understand what logs_ts is used for and why its
> default value is set to ts.
>

The reason I added this was because in the reftable backend, the writer
sorts logs before writing. So if the multiple reflogs contained the same
update_index, their order might be changed. But for migrating reflogs,
we need to ensure we maintain the order. Using a map here, allowed us to
increment the update_index for reflogs for a given refname.

> Also ts is an uint64_t while the second argument to strintmap_init()
> is an int. I wonder if it could be an issue especially on 32 bits
> platforms.
>

This is fair point, I decided to scrap this ultimately and simply append
`u->index` to the update_index. Which would provide the same desired
effect.

>>         reftable_writer_set_limits(writer, ts, ts);
>>
>>         for (i =3D 0; i < arg->updates_nr; i++) {
>> @@ -1391,6 +1395,7 @@ static int write_transaction_table(struct reftable=
_writer *writer, void *cb_data
>>
>>                         if (create_reflog) {
>>                                 struct ident_split c;
>> +                               uint64_t update_index;
>>
>>                                 ALLOC_GROW(logs, logs_nr + 1, logs_alloc=
);
>>                                 log =3D &logs[logs_nr++];
>> @@ -1405,7 +1410,11 @@ static int write_transaction_table(struct reftabl=
e_writer *writer, void *cb_data
>>                                 }
>>
>>                                 fill_reftable_log_record(log, &c);
>> -                               log->update_index =3D ts;
>> +
>> +                               update_index =3D strintmap_get(&logs_ts,=
 u->refname);
>> +                               log->update_index =3D update_index;
>> +                               strintmap_set(&logs_ts, u->refname, upda=
te_index+1);
>
> s/update_index+1/update_index + 1/
>
> Also is the 'update_index' var really needed or could we just do:
>
>                                log->update_index =3D
> strintmap_get(&logs_ts, u->refname);
>                                strintmap_set(&logs_ts, u->refname,
> log->update_index + 1);
>
> ?
>

The temp variable can be removed here indeed. But I'll remove all of
this in the next version. Thanks

>>                                 log->refname =3D xstrdup(u->refname);
>>                                 memcpy(log->value.update.new_hash,
>>                                        u->new_oid.hash, GIT_MAX_RAWSZ);

--00000000000090a9ed062913dbcf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8a90839304717699_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kYStKTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOUdEQy8wWXFYY1ZvK2ttY1lsekx0blB5OTcxZHpHOQo0eEptNUNsNlB2
SHNJaEU4bzdDSk1qanAza2tuVVlGL2tWa2crcWRFS1lRZTNZOGtFaFJZTFI3Y0hQNSttaURVCm5I
UC9TNkx1ZTlEemNxOVc1OUc3b1VUSDFLMVp5TUptSVNub002RVlZTWhOZE0rL3dSZTFETHhFMmlT
YkFxY3cKU3ZUR3FBYXNyWU02b3N1K0tiRGFybHRycVRRM1YxQ3ZGK013Z3UrbUx1QnFSUGNnMzh2
NGNwY0w1YXhJN05Qdwo2Z3JJS0xlNDE0TWlKelFyak1NTzE5TmxXd0dFbzVFTFVoYzR0V2ZyZVp3
ZG5taGZGckdNbld6TytKbFUyaFdPCmkxd2JBM0EwNGtxSHYwdWxwTTN5aUQ3SjVIaG9pMWlTT3Jj
SkZRV04vbGdJQi9hRE5DcXBKZ0t0b1lRbEZONnYKMTl5UmVJUEQvTUJLUXFlN2crSk91SUtaeTBP
SzA4WWdrcUo1U01YMWNXd0I4cUptYUxqUWRpeVgrYU9NMW9FagpWTm1hbG9Kd2ZlRUZkUkk4bHRw
NWxBcmZCV1phWFZQaG8vSW9kbWtaTnU3aHZwRFhPeStlQUxqelFhVXB2Mi9sCmJhangzbnkxbWV1
QldlK3pvMmRwdjF0RkkwajZmc2Q0VUhzank3Yz0KPSsrRnUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000090a9ed062913dbcf--
