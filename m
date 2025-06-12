Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1733596B
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749747798; cv=none; b=ax2jhV5rWOwfAC3vjP60o9H7QYuWS1JqrFhY5v5gGGy0uz8D5kECp8NX/OuSL3WMjqnRNEXMC02LRIeQfkfWvP7QSCvfc/CyUTfPPPYk/ENwdmZhIknSQnn3XnoxTRTB9Lp4/n41Z42YH+jSpJNx9rUyV0xVNreSp3B7AEvtVuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749747798; c=relaxed/simple;
	bh=duItMY1Z9UZCQ1EMzEpcrivWvY6mc4HHoMMoqRus+RE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ashF2iw5W0YDo6qLWXGVBCIIgMDdqct+j//Aubjp2UdOsoUPq5KHtPjbZoH+3mmtutZQlFqx8VNtzh9an1asUOyggn2rC2cKuw/mZlGzCgOr0PaIDCN2u6KGI2ZGeDgx3sjisEDIlPPr1M6dljCEHnL4Ndlr7uCsPbDMZrD8Gwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCcgvFy5; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCcgvFy5"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad89333d603so250009466b.2
        for <git@vger.kernel.org>; Thu, 12 Jun 2025 10:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749747793; x=1750352593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OV/JUX1EJ3Q8AQ7GkAPEHRJkftBTDgOn1Mfpn5AZn4s=;
        b=BCcgvFy5muCgPfCHiCEfXuYUtqdB6Nam7dl9IVl7bHRYdfaJ1Z78hHiY/sgE/Dfh3T
         JJ0s/cjzZmi7Fit1BtoAPGCogwp57M0bxrDSAdeohKqxGGa/WgSFWrbY64+E5oai9OY6
         ugRtGqZtc5RCJoNLpdiKepBTJw8OCQYUBLI4Bx4tv0MBLHbV+yEQy1BxUtCxiR+EIoPp
         aJhi5UJRcDpCeHNHZ/A8VbGBCT0ppoyjAgCzMCi7e3AVIQNWfzzwlz+VLZTppCRO2GY6
         0KkOHczy0C8w65p7kaWxXwIC6hisqap4eMWQW0rw7OJyFYDMxN0O7AVx8f8nTWJfNVup
         Lbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749747793; x=1750352593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OV/JUX1EJ3Q8AQ7GkAPEHRJkftBTDgOn1Mfpn5AZn4s=;
        b=ddyQOl385Xr3s3pEkLGNJoMnZ+++Ekmu7OA7th16dcE6NGl9vWdPBHl5ewsM5UmFdz
         X+WnWIilQtLq/XqYea+OjG9tZP83EZSocpkmeUqA0nDO5nQHS9mZqDf/Lt+ePyhfWvDx
         8pziVhozun/gr1srZdmb3SsPQKwmCYDL1fdXAZcelTG6uoIJyOaODgAWdZB8tzLvFr8y
         0A+bBCLMZTWRO9AzdC2xJTziyeV/FSTCWX3y/JA57jXDXy/uTWoWLPDLC2miPbUcSwI6
         dDjk5Aw78EvqW6F361/PfzqLh45UE76NbN/5roiGW2ZYxGOOY63jqJ98x/I9Zk3PLaNK
         bA8w==
X-Gm-Message-State: AOJu0Yx+GsLEjdRVEQgiI8aYDRnCy/yYsS8Rd0Lz6rssDy7KQXvDHlGh
	XnX5sCGtS5Ssss+eIMZUQrDuHyIczwWVaPRPhfjD37wfEQoBUn7YpKp1V037vKjyEpCI9Sd4mbw
	HTKIeSzY66G2tTSRueYD4R6RLP7xzhB4=
X-Gm-Gg: ASbGncvrkKVsUzNBA/7WXq5pek6kjDrxjhr9bBku0XdMHXWpi0j70MEpdAMlWgQH2EN
	6ORiQCcg/oGGJgXbSi58KBG/xCLDQhnooGj+VX6im7qgVraXrJSDTq/KWGSOtFNb9s59V85Tkw5
	A1rKkYlLM4i57+fPIps+c0pg8RAklz9nMZzD1KZ90vFRUeiw==
X-Google-Smtp-Source: AGHT+IFja5mOu/Qe/y3ky7Yxm5b1osQoUxHF2kzeSw3rL0W+QFbtQyarYJExI486vWer7x/FZIe8Q855OI3eyUkyzb4=
X-Received: by 2002:a17:907:6ea2:b0:ad5:2328:e39b with SMTP id
 a640c23a62f3a-adec562564amr5315466b.31.1749747792969; Thu, 12 Jun 2025
 10:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v3-0-e1c41693bd35@gmail.com>
 <20250606-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v3-2-e1c41693bd35@gmail.com>
In-Reply-To: <20250606-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v3-2-e1c41693bd35@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 12 Jun 2025 19:03:00 +0200
X-Gm-Features: AX0GCFtJecvJoT7rIH5mDIAloYDrKr8sbLqwqpJf0-PRpC8jedCBalSUell9AxA
Message-ID: <CAP8UFD0Az9YUd7tHbCWjrZ5bTv1V_0RZ2azasPmOrpf+ARMjug@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] receive-pack: handle reference deletions separately
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, ps@pks.im, gitster@pobox.com, 
	sunshine@sunshineco.com, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 10:41=E2=80=AFAM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> In 9d2962a7c4 (receive-pack: use batched reference updates, 2025-05-19)
> we updated the 'git-receive-pack(1)' command to use batched reference
> updates. One edge case which was missed during this implementation was
> when a user pushes multiple branches such as:
>
>   delete refs/heads/branch/conflict
>   create refs/heads/branch
>
> Before using batched updates, the references would be applied
> sequentially and hence no conflicts would arise. With batched updates,
> while the first update applies, the second fails due to F/D conflict.

Nit: it looks like "D/F conflict" is more often used than "F/D
conflict" in the Git code base:

$ git grep -i 'd/f conflict' | wc -l
119
$ git grep -i 'f/d conflict' | wc -l
7

> A
> similar issue was present in 'git-fetch(1)' and was fixed by using
> separating out reference pruning into a separate transaction. Apply a

Maybe: s/using separating out/separating out/

> similar mechanism for 'git-receive-pack(1)' and separate out reference
> deletions into its own batch.
>
> This means 'git-receive-pack(1)' will now use upto two transactions,
> whereas before using batched updates it would use _at least_ two
> transactions. So using batched updates is still the better option.
>
> Add a test to validate this behavior.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  builtin/receive-pack.c | 100 ++++++++++++++++++++++++++++++++-----------=
------
>  t/t5516-fetch-push.sh  |  17 +++++++--
>  2 files changed, 79 insertions(+), 38 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 9e3cfb85cf..8ee792d2f8 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1867,47 +1867,79 @@ static void execute_commands_non_atomic(struct co=
mmand *commands,
>         const char *reported_error =3D NULL;
>         struct strmap failed_refs =3D STRMAP_INIT;
>
> -       transaction =3D ref_store_transaction_begin(get_main_ref_store(th=
e_repository),
> -                                                 REF_TRANSACTION_ALLOW_F=
AILURE, &err);
> -       if (!transaction) {
> -               rp_error("%s", err.buf);
> -               strbuf_reset(&err);
> -               reported_error =3D "transaction failed to start";
> -               goto failure;
> -       }
> +       /*
> +        * Reference updates, where F/D conflicts shouldn't arise due to

Nit: here also maybe "D/F conflicts" is more standard.

> +        * one reference being deleted, while the other being created
> +        * are treated as conflicts in batched updates. This is because
> +        * we don't do conflict resolution inside a transaction. To
> +        * mitigate this, delete references in a separate batch.
> +        */
> +       enum processing_phase {
> +               PHASE_DELETIONS,
> +               PHASE_OTHERS
> +       };
>
> -       for (cmd =3D commands; cmd; cmd =3D cmd->next) {
> -               if (!should_process_cmd(cmd) || cmd->run_proc_receive)
> -                       continue;
> +       for (enum processing_phase phase =3D PHASE_DELETIONS; phase <=3D =
PHASE_OTHERS; phase++) {
> +               for (cmd =3D commands; cmd; cmd =3D cmd->next) {
> +                       if (!should_process_cmd(cmd) || cmd->run_proc_rec=
eive)
> +                               continue;
>
> -               cmd->error_string =3D update(cmd, si);
> -       }
> +                       if (phase =3D=3D PHASE_DELETIONS && !is_null_oid(=
&cmd->new_oid))
> +                               continue;
> +                       else if (phase =3D=3D PHASE_OTHERS && is_null_oid=
(&cmd->new_oid))
> +                               continue;
>
> -       if (ref_transaction_commit(transaction, &err)) {
> -               rp_error("%s", err.buf);
> -               reported_error =3D "failed to update refs";
> -               goto failure;
> -       }
> +                       /*
> +                        * Lazily create a transaction only when we know =
there are
> +                        * updates to be added.
> +                        */
> +                       if (!transaction) {
> +                               transaction =3D ref_store_transaction_beg=
in(get_main_ref_store(the_repository),
> +                                                                        =
 REF_TRANSACTION_ALLOW_FAILURE, &err);
> +                               if (!transaction) {
> +                                       rp_error("%s", err.buf);
> +                                       strbuf_reset(&err);
> +                                       reported_error =3D "transaction f=
ailed to s1tart";

s/s1tart/start/

> +                                       goto failure;
> +                               }
> +                       }
>
> -       ref_transaction_for_each_rejected_update(transaction,
> -                                                ref_transaction_rejectio=
n_handler,
> -                                                &failed_refs);
> +                       cmd->error_string =3D update(cmd, si);
> +               }
>
> -       if (strmap_empty(&failed_refs))
> -               goto cleanup;
> +               /*
> +                * If no transaction was created, there is nothing to com=
mit.
> +                */

Nit: the comment needs a single line, so maybe:

              /* No transaction, so nothing to commit */

> +               if (!transaction)
> +                       goto cleanup;
>
> -failure:
> -       for (cmd =3D commands; cmd; cmd =3D cmd->next) {
> -               if (reported_error)
> -                       cmd->error_string =3D reported_error;
> -               else if (strmap_contains(&failed_refs, cmd->ref_name))
> -                       cmd->error_string =3D strmap_get(&failed_refs, cm=
d->ref_name);
> -       }
> +               if (ref_transaction_commit(transaction, &err)) {
> +                       rp_error("%s", err.buf);
> +                       reported_error =3D "failed to update refs";
> +                       goto failure;
> +               }
>
> -cleanup:
> -       ref_transaction_free(transaction);
> -       strmap_clear(&failed_refs, 0);
> -       strbuf_release(&err);
> +               ref_transaction_for_each_rejected_update(transaction,
> +                                                        ref_transaction_=
rejection_handler,
> +                                                        &failed_refs);
> +
> +               if (strmap_empty(&failed_refs))
> +                       goto cleanup;
> +
> +       failure:

This label looks indented while previously it was right at the start
of the line. Not sure if we have a standard for that, but a few quick
greps seems to show that goto labels are most often at the start of
the line.

> +               for (cmd =3D commands; cmd; cmd =3D cmd->next) {
> +                       if (reported_error)
> +                               cmd->error_string =3D reported_error;
> +                       else if (strmap_contains(&failed_refs, cmd->ref_n=
ame))
> +                               cmd->error_string =3D strmap_get(&failed_=
refs, cmd->ref_name);
> +               }
> +
> +       cleanup:

Idem for how this label is indented.

> +               ref_transaction_free(transaction);
> +               transaction =3D NULL;
> +               strmap_clear(&failed_refs, 0);
> +               strbuf_release(&err);
> +       }
>  }
