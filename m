Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087B213B58C
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 07:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749799431; cv=none; b=PxDE5qe8FSEjr9xuwdMDGzlr/L3QNNT2eUO/UkpaMv+co4ichkkmijBotgYOoHtnmLKTn7Dr8fbKDJfH5uG4MH1raVtj/OxwbAvYG2PQQNVFQMVPje4ZLTTefUKG+edaxghFRXZN+vIfCBfZ2S6Iola1jYXWT9kt4lZhNXYkpks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749799431; c=relaxed/simple;
	bh=057Xf1dU8Sb6OFW9QYF3elCkJjg0QsGB+NA8yqBv5Ek=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKdFhO66tPf5qgHlTVtnMnEP5LyVuJ3SfVwhycA5GuPXu0JmO5b9R9f7JJv03XwXzYdJF/pYEg/inJSPvuY97dPyfr41S8D3tDM2cpj27z3oOD3RzMJmmpkrpVi+jd2jxFpu4g6IGON3BFvFTdwBwWkaldcu/9mf/QmDS8lXJDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFeOQu7R; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFeOQu7R"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-87ecac3e17cso495602241.3
        for <git@vger.kernel.org>; Fri, 13 Jun 2025 00:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749799429; x=1750404229; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YJRCuqnyaR7zDk9cS+gPblqxawYE0umVyYx49HdRW0I=;
        b=jFeOQu7RN8wTdaoIM2ASBVqsL/hZpJbq3lIcGpa3vgy6rS2xUXdVaJdrZou0Dsy9HE
         V8uIv+ihJWRdKMLfNp484ffMOdvVlbP7DPEbFbq1pjIUTQ3voPo86BD+z2aXkQKDHLY9
         1mX5RZOn9Zn++XZeMpTjOjtghFNNMkwsuSW4S9U6erd6u2cyygnnqZMY8eZTdpqZT5qq
         B2oek+g7ZNEKohDTrIESvGy9MG5fbx5ccLaqvRYfje5jUTEnMxFkA+gYO/N3MKBo1/72
         GrCa//o1OVS3alERTqy903K/Dc+qhVcMR8sgSIp4OyzvBKg5tAMtt2KcZxWyPvb2TJtd
         AFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749799429; x=1750404229;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJRCuqnyaR7zDk9cS+gPblqxawYE0umVyYx49HdRW0I=;
        b=dypzTCcTCfUgdCjuKq76ELDgy90iOpIJnSvi5MhCAoBnaNkiQk3zYP4WcJ53jClJVu
         VcJzVwqdx6sxTd1ZKpIO8aEd2rM12Bxn8CPIAmFKIc3R27wWN6AnzU2N44l41ANEkzfz
         dwMbquc2urYp3uKCdRRphDJz4qFkWbHrmUEF8k/ltAxQmJ/qVzWwgfLwvjcgpifA5eov
         2veAAEhOKSwoM0QAYDLnu/OiaFZGZVC6vZgewujyQ1TSg/+xVLl/Py24JGz9sHwhoNEi
         Chws6zJmy+uqSGl45gO7OHxXxO8ERAl1hcFlKpvbT/slyyqzEaYVdnpmWVAuPCyhZZ9w
         S9tg==
X-Gm-Message-State: AOJu0YxI/HclQdXsyMvb/hnZok99u/6eHgiiCG6VSHh2a2v72mC8xodN
	Tmty7RmyKIg6RmKuHPmWLN1vAtfC3Io3fDHzpnkAKnWxuz5nMruRCNS3izFoKkXG4R6t9r9HIx1
	J5OSxGunusIGci4vFyN/aOEKyn+pNCpc=
X-Gm-Gg: ASbGncss69KAIFGyfwnJ2K45U4gIrjpZ9o+b1IwIZDkNfAn0tEPGNJp+BE8jRJTFpqz
	Q0dfL+Xu8w7a4HlFE7YyFLG5kLH0jRXec983WJuUt6rdbr0hICSaDAKgGeD6ea36qqmSekXKMYE
	/1ggVq3anX30OeU6EP/YuA50VOja93A28IFThSQPCc1d3oxQ9oTcAhQIuIU2Y0hGMpoktt6UGYT
	GGHAA==
X-Google-Smtp-Source: AGHT+IFXpk5tXkg6j2CUQa7vx0VsZNq/3hjMpSESsj/XyeDPxnmOrbofB+8ImXenwe873OzE5ZVvTXciNBnh8PdtP+s=
X-Received: by 2002:a05:6102:2d03:b0:4e1:48ee:6f36 with SMTP id
 ada2fe7eead31-4e7e39a750bmr1317373137.19.1749799428662; Fri, 13 Jun 2025
 00:23:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Jun 2025 02:23:47 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAP8UFD0Az9YUd7tHbCWjrZ5bTv1V_0RZ2azasPmOrpf+ARMjug@mail.gmail.com>
References: <20250606-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v3-0-e1c41693bd35@gmail.com>
 <20250606-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v3-2-e1c41693bd35@gmail.com>
 <CAP8UFD0Az9YUd7tHbCWjrZ5bTv1V_0RZ2azasPmOrpf+ARMjug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 13 Jun 2025 02:23:47 -0500
X-Gm-Features: AX0GCFv8r5Btqdq5WyU4aT-p2hcvezRNEXQW-vHnM9zz27MH3yuomBwAVQlSRO8
Message-ID: <CAOLa=ZSU-r44oTiOiaqPrShj6p=4VUQTU-pXk5FJ4fenxB_FaA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] receive-pack: handle reference deletions separately
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, ps@pks.im, gitster@pobox.com, 
	sunshine@sunshineco.com, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000005fbe3f06376eed81"

--0000000000005fbe3f06376eed81
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Jun 6, 2025 at 10:41=E2=80=AFAM Karthik Nayak <karthik.188@gmail.=
com> wrote:
>>
>> In 9d2962a7c4 (receive-pack: use batched reference updates, 2025-05-19)
>> we updated the 'git-receive-pack(1)' command to use batched reference
>> updates. One edge case which was missed during this implementation was
>> when a user pushes multiple branches such as:
>>
>>   delete refs/heads/branch/conflict
>>   create refs/heads/branch
>>
>> Before using batched updates, the references would be applied
>> sequentially and hence no conflicts would arise. With batched updates,
>> while the first update applies, the second fails due to F/D conflict.
>
> Nit: it looks like "D/F conflict" is more often used than "F/D
> conflict" in the Git code base:
>
> $ git grep -i 'd/f conflict' | wc -l
> 119
> $ git grep -i 'f/d conflict' | wc -l
> 7
>
>> A
>> similar issue was present in 'git-fetch(1)' and was fixed by using
>> separating out reference pruning into a separate transaction. Apply a
>
> Maybe: s/using separating out/separating out/
>

That's better, will change.

>> similar mechanism for 'git-receive-pack(1)' and separate out reference
>> deletions into its own batch.
>>
>> This means 'git-receive-pack(1)' will now use upto two transactions,
>> whereas before using batched updates it would use _at least_ two
>> transactions. So using batched updates is still the better option.
>>
>> Add a test to validate this behavior.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  builtin/receive-pack.c | 100 ++++++++++++++++++++++++++++++++----------=
-------
>>  t/t5516-fetch-push.sh  |  17 +++++++--
>>  2 files changed, 79 insertions(+), 38 deletions(-)
>>
>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index 9e3cfb85cf..8ee792d2f8 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -1867,47 +1867,79 @@ static void execute_commands_non_atomic(struct c=
ommand *commands,
>>         const char *reported_error =3D NULL;
>>         struct strmap failed_refs =3D STRMAP_INIT;
>>
>> -       transaction =3D ref_store_transaction_begin(get_main_ref_store(t=
he_repository),
>> -                                                 REF_TRANSACTION_ALLOW_=
FAILURE, &err);
>> -       if (!transaction) {
>> -               rp_error("%s", err.buf);
>> -               strbuf_reset(&err);
>> -               reported_error =3D "transaction failed to start";
>> -               goto failure;
>> -       }
>> +       /*
>> +        * Reference updates, where F/D conflicts shouldn't arise due to
>
> Nit: here also maybe "D/F conflicts" is more standard.
>

Will change.

>> +        * one reference being deleted, while the other being created
>> +        * are treated as conflicts in batched updates. This is because
>> +        * we don't do conflict resolution inside a transaction. To
>> +        * mitigate this, delete references in a separate batch.
>> +        */
>> +       enum processing_phase {
>> +               PHASE_DELETIONS,
>> +               PHASE_OTHERS
>> +       };
>>
>> -       for (cmd =3D commands; cmd; cmd =3D cmd->next) {
>> -               if (!should_process_cmd(cmd) || cmd->run_proc_receive)
>> -                       continue;
>> +       for (enum processing_phase phase =3D PHASE_DELETIONS; phase <=3D=
 PHASE_OTHERS; phase++) {
>> +               for (cmd =3D commands; cmd; cmd =3D cmd->next) {
>> +                       if (!should_process_cmd(cmd) || cmd->run_proc_re=
ceive)
>> +                               continue;
>>
>> -               cmd->error_string =3D update(cmd, si);
>> -       }
>> +                       if (phase =3D=3D PHASE_DELETIONS && !is_null_oid=
(&cmd->new_oid))
>> +                               continue;
>> +                       else if (phase =3D=3D PHASE_OTHERS && is_null_oi=
d(&cmd->new_oid))
>> +                               continue;
>>
>> -       if (ref_transaction_commit(transaction, &err)) {
>> -               rp_error("%s", err.buf);
>> -               reported_error =3D "failed to update refs";
>> -               goto failure;
>> -       }
>> +                       /*
>> +                        * Lazily create a transaction only when we know=
 there are
>> +                        * updates to be added.
>> +                        */
>> +                       if (!transaction) {
>> +                               transaction =3D ref_store_transaction_be=
gin(get_main_ref_store(the_repository),
>> +                                                                       =
  REF_TRANSACTION_ALLOW_FAILURE, &err);
>> +                               if (!transaction) {
>> +                                       rp_error("%s", err.buf);
>> +                                       strbuf_reset(&err);
>> +                                       reported_error =3D "transaction =
failed to s1tart";
>
> s/s1tart/start/
>

Oops! Good catch.

>> +                                       goto failure;
>> +                               }
>> +                       }
>>
>> -       ref_transaction_for_each_rejected_update(transaction,
>> -                                                ref_transaction_rejecti=
on_handler,
>> -                                                &failed_refs);
>> +                       cmd->error_string =3D update(cmd, si);
>> +               }
>>
>> -       if (strmap_empty(&failed_refs))
>> -               goto cleanup;
>> +               /*
>> +                * If no transaction was created, there is nothing to co=
mmit.
>> +                */
>
> Nit: the comment needs a single line, so maybe:
>
>               /* No transaction, so nothing to commit */
>

Looks better.

>> +               if (!transaction)
>> +                       goto cleanup;
>>
>> -failure:
>> -       for (cmd =3D commands; cmd; cmd =3D cmd->next) {
>> -               if (reported_error)
>> -                       cmd->error_string =3D reported_error;
>> -               else if (strmap_contains(&failed_refs, cmd->ref_name))
>> -                       cmd->error_string =3D strmap_get(&failed_refs, c=
md->ref_name);
>> -       }
>> +               if (ref_transaction_commit(transaction, &err)) {
>> +                       rp_error("%s", err.buf);
>> +                       reported_error =3D "failed to update refs";
>> +                       goto failure;
>> +               }
>>
>> -cleanup:
>> -       ref_transaction_free(transaction);
>> -       strmap_clear(&failed_refs, 0);
>> -       strbuf_release(&err);
>> +               ref_transaction_for_each_rejected_update(transaction,
>> +                                                        ref_transaction=
_rejection_handler,
>> +                                                        &failed_refs);
>> +
>> +               if (strmap_empty(&failed_refs))
>> +                       goto cleanup;
>> +
>> +       failure:
>
> This label looks indented while previously it was right at the start
> of the line. Not sure if we have a standard for that, but a few quick
> greps seems to show that goto labels are most often at the start of
> the line.
>

Yup, but now this label lies within a for loop, so the indentation is
aligned to the loop. So I think it is correct as is.

>> +               for (cmd =3D commands; cmd; cmd =3D cmd->next) {
>> +                       if (reported_error)
>> +                               cmd->error_string =3D reported_error;
>> +                       else if (strmap_contains(&failed_refs, cmd->ref_=
name))
>> +                               cmd->error_string =3D strmap_get(&failed=
_refs, cmd->ref_name);
>> +               }
>> +
>> +       cleanup:
>
> Idem for how this label is indented.
>

Same here, this too is within a loop.

>> +               ref_transaction_free(transaction);
>> +               transaction =3D NULL;
>> +               strmap_clear(&failed_refs, 0);
>> +               strbuf_release(&err);
>> +       }
>>  }

Thanks for the review!

- Karthik

--0000000000005fbe3f06376eed81
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5464bc2b9688a12a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oTDBnSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN1lBQy85eFFzMmE4V1dzM0RDNGExZzZmMDdieHcxdworS0RhRVlJd25L
b3ZGMzJXV0VYNk51QWgxTUNqMlJuajZiSHM1amU2R1VxOVV3L2VlajlFZnFQLzZBa2xqNjNNCnF2
MVRYS29XdUM4aGZ2djVSRjk4cWt6eGN3eDB2b2c4Q01Tc1gyd1Y1K21JYXp3clF1KzJsdGR2TExz
UWNpa3EKMEY2WE5ESnBNcmhqSXh3bXdXd0hMcFU4WnZvSlIvdHRtNmVWWHd3L2xtUkVmN1IxOFNv
Ni9ldktLM3ZvdnBaTQpJQStvNTlxYzhvdEgrTUd6ZG1CZ3BBYjJ4Z1Vpcm1BSmhyS0dLRGtGd2ds
TC9sUVUrNk8wQnpnOXVVSWxUbmpQCmxyQXcrTWoxNGluZ3Evbi9mVjFQNFJJbGJUa2d4eThEK3Vl
NW1oc2IwdnIwRjRXT1J5dnZZYzc0OGtUbCthZUsKTmh4b0g4N0tEeWxLSnB6dUZBZWhwd3d5cHJz
b29IZXpmZVhJV0tENkxVNk5ac282cm9GbTc5QVdZdjMxTW1vawptZlZXYzFrTXVEclVtQ0pKc0sr
em9aUmJyN3NPTXBMVFVaWWx6aVNIUXBtY081WUFZaUlhNW1xUHZOQ1hmTldTCkdGNGcxSC82WlNa
NyszOWV0bXY2MS85R2p6QzBEY1lYU0ttZkJIUT0KPVgvZkIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005fbe3f06376eed81--
