Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B778489
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733912019; cv=none; b=I7SAWPfR6QL2uYE9Qbw6pTmecTcORPe2lyGtAjGAgTtBpqQlE8jW/76gtFz8B2A9NtdJTTa5WwL+i4sgtEoRh9hI1En/fiUpfI5ezxw539e9UIy0nwKVgLoWOWK1Q4Fi2O3PCtkYrm3fCGiTjT/WngIJ9WlUZzucgLhfw8XIIC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733912019; c=relaxed/simple;
	bh=S7zldBY/0PLOd//BWNd3zyC0VBOiemXPWjEOcIt+UKA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uS0mRl4RQN4xuVMX0tcMprGTeMFJkGUqQjk2AqykNHSg+sCJ3mMWpyPr/wXqUZwmj98AfuLRYnpCgU5yvd+lEvCbKYBNwuJwPAWWLJoY9WPg3yBYJE4o/FOuGB2GB4hYwJXTvIZpJp3Ibzqs4FthuvdrKqYAnZ+ISTFK3hnFzPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Db9IpLcZ; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db9IpLcZ"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5174f9c0e63so970355e0c.1
        for <git@vger.kernel.org>; Wed, 11 Dec 2024 02:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733912016; x=1734516816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OPuT3PXAstQ2B13z+gK3zXIcZKRTO6pOcGFxWa+a+Kg=;
        b=Db9IpLcZDCQq4jnRI7yvD0mjx1GCYxfnJz0bqh5/GcLYB9PbJ3WYz1w4jRJ2pOm5y9
         3cWW07kCB8+3v+584zoS1wqfnXNFoi3omKJLJGyDF8WyKBm8SBvLYhRAus1C+StD/h5G
         hDeR4y2V1ECj6QH70MD+ZBcCxsAX8QWa5PpvFhkBgrnh2JREquqd3R3PYnnOqcftB93r
         uTm9Nb6R9x2666w1WHbqlb1TILQH/LYe63xmflwyw0cIOYaXh3SiVdGeL3OM+B0U3YB4
         bBzXJ3ROwUeolguTYabdf/t9jBxy5EcXww0dRISdh1MoZFaN7hl9m25fYP9+/CXT5yJb
         i/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733912016; x=1734516816;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPuT3PXAstQ2B13z+gK3zXIcZKRTO6pOcGFxWa+a+Kg=;
        b=QqNqwNO9pqChjrUgZ+dPSg297LZZx3RGMltcvFu7VWF0yUt2m5lstj0V3uELMftAP5
         24b2o1vkq76RwD8Ker6vA9u0h81ZLQjFWHoqKIxeC0kkqjBZwwpUqPsX/D8Yhrp2DzdO
         8FIxiDaDCxyWjTJ411psYE40oLN2oviYMUbZteQdNd+WvZxt/JijrYgDzh6YErOyy+oq
         FVaSLhaF2gLW8hiAOYZdhHnPtBGV2gpVOYFYYFsjuqsEP7N54kBU9wQL8FR666wbFs4T
         poAovd8oVetRA6DZ4g6qwu0azHJYPpKefGkevUhp1Du/JE+ANpfsziqgN1YZBMCb+25k
         vuxA==
X-Gm-Message-State: AOJu0YwTVRZxmrCbbol2TnWQqGgKP2ulhaOxmfH2o4q6dWAQdjZZ3S4A
	ogaz6NcFaLDgbPGH1epD9F5G3LSryW5aHst7mJzgKZCNLuZ3zOQAauu2cUcPm7Dr2hbDFaqas7j
	EIYJEexJbd8NMC7okKtx8CnzswVlCuXrD
X-Gm-Gg: ASbGncsfTJscyFE2KC8zRz3geEadmfD+46iKwfJmoAclH3a6tcpkMZ0r+q3cKhEyEHb
	cfimWqoOjumKfrqR3im4+5KNc+eB8aSrmobddKrCHsMRU/nbOXoD3Ncl9hrBuAfTmY4tUqg==
X-Google-Smtp-Source: AGHT+IGwDS/WAYBFozURtedIwfi7h5Nf+dVcHxOMeESQZh59mcEfhVhRjNJLXsyKneSW4HORlO0dF9ANlYReNsBAr9w=
X-Received: by 2002:a05:6102:e13:b0:4b1:1a11:16e0 with SMTP id
 ada2fe7eead31-4b1291b2319mr1851195137.27.1733912016297; Wed, 11 Dec 2024
 02:13:36 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Dec 2024 02:13:35 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <CAP8UFD3FXtbuHH1G==rR00_O7MBjqQiw_qzGHPVLK4P13RRtjQ@mail.gmail.com>
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
 <20241209-320-git-refs-migrate-reflogs-v1-1-d4bc37ee860f@gmail.com> <CAP8UFD3FXtbuHH1G==rR00_O7MBjqQiw_qzGHPVLK4P13RRtjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Dec 2024 02:13:35 -0800
Message-ID: <CAOLa=ZRL0P4V11Eq3RYN2gPurCwgDUez4muH3+2yZoBvNNm0Xg@mail.gmail.com>
Subject: Re: [PATCH 1/7] refs: include committer info in `ref_update` struct
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000cdc44f0628fbd9ed"

--000000000000cdc44f0628fbd9ed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Dec 9, 2024 at 12:10=E2=80=AFPM Karthik Nayak <karthik.188@gmail.=
com> wrote:
>
>
>> If there is no `committer_info`
>> provided, the reference backends default to using
>> `git_committer_info(0)`. The field itself cannot be set to
>> `git_committer_info(0)` since the values are dynamic and must be
>> obtained right when the reflog is being committed.
>
>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 64f51f0da905a9a8a1ac4109c6b0a9a85a355db7..13f8539e6caa923cd4834775=
fcb0cd7f90d82014 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -1858,6 +1858,9 @@ static int log_ref_write_fd(int fd, const struct o=
bject_id *old_oid,
>>         struct strbuf sb =3D STRBUF_INIT;
>>         int ret =3D 0;
>>
>> +       if (!committer)
>> +               committer =3D git_committer_info(0);
>
> It looks like this is where we obtain the value "right when the reflog
> is being committed".
>
>> +
>>         strbuf_addf(&sb, "%s %s %s", oid_to_hex(old_oid), oid_to_hex(new=
_oid), committer);
>>         if (msg && *msg) {
>>                 strbuf_addch(&sb, '\t');
>> @@ -1871,8 +1874,10 @@ static int log_ref_write_fd(int fd, const struct =
object_id *old_oid,
>>  }
>>
>>  static int files_log_ref_write(struct files_ref_store *refs,
>> -                              const char *refname, const struct object_=
id *old_oid,
>> -                              const struct object_id *new_oid, const ch=
ar *msg,
>> +                              const char *refname,
>> +                              const struct object_id *old_oid,
>> +                              const struct object_id *new_oid,
>> +                              const char *committer_info, const char *m=
sg,
>>                                int flags, struct strbuf *err)
>>  {
>>         int logfd, result;
>> @@ -1889,8 +1894,7 @@ static int files_log_ref_write(struct files_ref_st=
ore *refs,
>>
>>         if (logfd < 0)
>>                 return 0;
>> -       result =3D log_ref_write_fd(logfd, old_oid, new_oid,
>> -                                 git_committer_info(0), msg);
>> +       result =3D log_ref_write_fd(logfd, old_oid, new_oid, committer_i=
nfo, msg);
>
> Here we just pass the committer_info to the above function.
>
>>         if (result) {
>>                 struct strbuf sb =3D STRBUF_INIT;
>>                 int save_errno =3D errno;
>> @@ -1974,8 +1978,7 @@ static int commit_ref_update(struct files_ref_stor=
e *refs,
>>         files_assert_main_repository(refs, "commit_ref_update");
>>
>>         clear_loose_ref_cache(refs);
>> -       if (files_log_ref_write(refs, lock->ref_name,
>> -                               &lock->old_oid, oid,
>> +       if (files_log_ref_write(refs, lock->ref_name, &lock->old_oid, oi=
d, NULL,
>>                                 logmsg, flags, err)) {
>
> Here we don't have the info so we pass NULL.
>
>>                 char *old_msg =3D strbuf_detach(err, NULL);
>>                 strbuf_addf(err, "cannot update the ref '%s': %s",
>> @@ -2007,8 +2010,8 @@ static int commit_ref_update(struct files_ref_stor=
e *refs,
>>                 if (head_ref && (head_flag & REF_ISSYMREF) &&
>>                     !strcmp(head_ref, lock->ref_name)) {
>>                         struct strbuf log_err =3D STRBUF_INIT;
>> -                       if (files_log_ref_write(refs, "HEAD",
>> -                                               &lock->old_oid, oid,
>> +                       if (files_log_ref_write(refs, "HEAD", &lock->old=
_oid,
>> +                                               oid, git_committer_info(=
0),
>
> Here we don't have the info either, so I think we should also pass
> NULL. It would then be computed "right when the reflog is being
> committed" in the above function. No?
>

Indeed, passing NULL should be sufficient here, good catch.

>>                                                 logmsg, flags, &log_err)=
) {
>>                                 error("%s", log_err.buf);
>>                                 strbuf_release(&log_err);
>
>
>> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
>> index 647ef9b05b1dc9a376ed054330b487f7595c5caa..e882602487c66261d586a941=
01bb1b4e9a2ed60e 100644
>> --- a/refs/reftable-backend.c
>> +++ b/refs/reftable-backend.c
>> @@ -1379,11 +1379,21 @@ static int write_transaction_table(struct reftab=
le_writer *writer, void *cb_data
>
> It is not your fault but write_transaction_table() does the following
> right at the beginning of the function:
>
>        committer_info =3D git_committer_info(0);
>        if (split_ident_line(&committer_ident, committer_info,
> strlen(committer_info)))
>                BUG("failed splitting committer info");
>
> but then 'committer_ident' is only used in the hunk you are changing:
>
>>                         if (create_reflog) {
>> +                               struct ident_split c;
>> +
>>                                 ALLOC_GROW(logs, logs_nr + 1, logs_alloc=
);
>>                                 log =3D &logs[logs_nr++];
>>                                 memset(log, 0, sizeof(*log));
>>
>> -                               fill_reftable_log_record(log, &committer=
_ident);
>> +                               if (u->committer_info) {
>> +                                       if (split_ident_line(&c, u->comm=
itter_info,
>> +                                                            strlen(u->c=
ommitter_info)))
>> +                                               BUG("failed splitting co=
mmitter info");
>> +                               } else {
>
> I would think it would be more efficient to only compute
> 'committer_ident' here, right before we use it if needed. Or is there
> something I am missing?
>

It would if there wasn't a loop. Since we loop over multiple updates,
computing committer_ident for each would end up being expensive. So it
is done before the loop starts.

>> +                                       c =3D committer_ident;
>> +                               }
>> +
>> +                               fill_reftable_log_record(log, &c);
>>                                 log->update_index =3D ts;
>>                                 log->refname =3D xstrdup(u->refname);
>>                                 memcpy(log->value.update.new_hash,

--000000000000cdc44f0628fbd9ed
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9df77e7b8f4ea73_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kWlpjNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mem84REFDSGxFMzI0SFlPQnFnYjBtakJ3dlFkZEc0dAphVDVMQmRPTEEz
NEZvSHNUY2ozMlYzcDJCL3kxb1ZNQ3JiRUUxQTdCb093dmI2VmtjLzlIdWtKcTFQTVlVTnFKCjhF
OE5KRHJnTlduNjlLL1NNUU0vcDBseEt4Ui9jKzlrcU9UUllWNVB1eWxDN0czWmtWTEhURnRmWVdM
U1hnbTcKWGcyM2Y0K0hySVRMeGJnTXlMZjNwTE1UaElEWFY4YjNteFh0N3l4dzNTMVlXZDR2TVRB
RU12ZklrSUpOSXNrZgpxc1J4RXFPcG9WbTNkYUdXWGl5alJlQ2JSMnp0ak1EQWN2NUFlZnl1UDNJ
WUw4SXJOWVVmM1pyYXVDYUFHclNvCkV5TXlwbWFxcEhyNHJVRU9kSjN4VzMrdTNwZHZETmM1S2U3
OUtjM3dxekh2bTN0L1prM3NqNUxOY0pZR2MrYWIKMVJ2eGdUK2VQVmU1QTNaRWtTeE9IdVFjV21p
aGl2Zkd2dEhWOGF5bzlodGNsTG9HSGRPVXIrWjFRL0d1TkhMbAppa1N6ak5ncG9NVjlRZDZhUGMw
OVZIM3RGR2U2ZEpyUHNLcmVJdmRDV0dYbTRMeTBORkt3cHdkOWNjcHYvZTZGCjBaTE1HTUg5U0Ra
dHFIRWViT0JqRldFdDBPV3RnZ1hENXNBeEl5RT0KPUg3RTYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000cdc44f0628fbd9ed--
