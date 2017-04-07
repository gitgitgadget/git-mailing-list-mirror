Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD1A420966
	for <e@80x24.org>; Fri,  7 Apr 2017 12:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933443AbdDGMlw (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 08:41:52 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:32874 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755546AbdDGMlt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 08:41:49 -0400
Received: by mail-oi0-f68.google.com with SMTP id f193so11838457oib.0
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 05:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5bTOsx42dBS+jGMFXWmP09r/a0XpI1CR1bRF1p/djHM=;
        b=t0aOx5pQMW6lKSXtGfHPdjOIGkbkCjg1QejI4GOZEJ7tdip6L+nP7su+NJg+kN8Phk
         YvMD2kTYwsnF9jjiDnp+/lHiVNf6wn1X+bjron2zSEi1NIL5Y4uHgHGmtbs+x2RRk/EJ
         1n9d680L96D/dmDif1sI86by7cyW2/XL3vr2UaVoTG/bCPb/wUiz0Eh+De1xBwpT/0YK
         VhGc4Nia8rEgGEKRpZFh0mQDPDUULerHoH5HPkArTJYAoIFoQ4tIC4nVyl3sGXQjn3xf
         PQ3AZEeAxFD6dWtT1Q2vq1pU1A+siWyzv2SLzgEtWQxs0JXPTVLyBPdGPhD91axBKk8C
         STNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5bTOsx42dBS+jGMFXWmP09r/a0XpI1CR1bRF1p/djHM=;
        b=dVC96QryxKoFl5VH9eENEcCM0mGWdE2i8YnC2pcG2+dzHasR233T1AteovBWBPUQQq
         2pXa8MNH2Z5Ryg47Mo6NooK0xaKSTSLCOSfYn/OvdCI1rDI1mxsdDCySLaYQqRnCw8Du
         n7ykd9FMjXOdlSEiKR4PGiRO4CnXpvFHa97NWHfcCS+h8Hf0z88z2dnj+UOHonCVycKG
         5iJg5JcTSBsSGv4M/AERyhU8qdYMeGIu5fmJEfpJ0xnLAmGkSGGGltBfzdg4L6a32XyR
         bqNfojkrvNltLN3BecCyPEqsZInmI/IQXmYG//Vai5RWag7vue/adHP1h3Z6A4SDuBYw
         GtQg==
X-Gm-Message-State: AN3rC/5XronTX9mP3yzAEkJxLn5ZUOFq/zhbV9Q8GSC5uz0V1WaycYMV/wdVxpJ9ZV0GhlvaZN0Ey4r9qjkzdQ==
X-Received: by 10.157.46.246 with SMTP id w109mr8791363ota.225.1491568908133;
 Fri, 07 Apr 2017 05:41:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Fri, 7 Apr 2017 05:41:17 -0700 (PDT)
In-Reply-To: <4e4fd98d-055d-6e2b-845d-51d3f1c2856f@alum.mit.edu>
References: <20170318020337.22767-1-pclouds@gmail.com> <20170326024241.31984-1-pclouds@gmail.com>
 <20170326024241.31984-20-pclouds@gmail.com> <4e4fd98d-055d-6e2b-845d-51d3f1c2856f@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 7 Apr 2017 19:41:17 +0700
Message-ID: <CACsJy8ByRdcXUS57pqSH4Gmr6FLSfK1yNnq7u5wVzh=7hj0vBA@mail.gmail.com>
Subject: Re: [PATCH v7 19/28] files-backend: replace submodule_allowed check
 in files_downcast()
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'll mark this mail and do a follow-up patch once this topic graduates
to master. It's less review burden and mail traffic.

On Sat, Apr 1, 2017 at 11:02 AM, Michael Haggerty <mhagger@alum.mit.edu> wr=
ote:
> On 03/26/2017 04:42 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> files-backend.c is unlearning submodules. Instead of having a specific
>> check for submodules to see what operation is allowed, files backend
>> now takes a set of flags at init. Each operation will check if the
>> required flags is present before performing.
>>
>> For now we have four flags: read, write and odb access. Main ref store
>> has all flags, obviously, while submodule stores are read-only and have
>> access to odb (*).
>>
>> The "main" flag stays because many functions in the backend calls
>> frontend ones without a ref store, so these functions always target the
>> main ref store. Ideally the flag should be gone after ref-store-aware
>> api is in place and used by backends.
>>
>> (*) Submodule code needs for_each_ref. Try take REF_STORE_ODB flag
>> out. At least t3404 would fail. The "have access to odb" in submodule is
>> a bit hacky since we don't know from he whether add_submodule_odb() has
>> been called.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  refs.c               | 15 +++++++---
>>  refs/files-backend.c | 81 +++++++++++++++++++++++++++++++++------------=
-------
>>  refs/refs-internal.h |  9 +++++-
>>  3 files changed, 71 insertions(+), 34 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index d72b48a430..241b4227b2 100644
>> --- a/refs.c
>> +++ b/refs.c
>> [...]
>> @@ -1481,7 +1486,9 @@ struct ref_store *get_ref_store(const char *submod=
ule)
>>               return NULL;
>>       }
>>
>> -     refs =3D ref_store_init(submodule_sb.buf);
>> +     /* pretend that add_submodule_odb() has been called */
>
> The word "pretend" implies that the thing that follows is not true,
> whereas we hope that it *is* true. It would be better to say "assume".
>
>> +     refs =3D ref_store_init(submodule_sb.buf,
>> +                           REF_STORE_READ | REF_STORE_ODB);
>>       register_submodule_ref_store(refs, submodule);
>>
>>       strbuf_release(&submodule_sb);
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 490f05a6f4..d97a924860 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> [...]
>> @@ -994,13 +997,17 @@ static struct ref_store *files_ref_store_create(co=
nst char *gitdir)
>>  }
>>
>>  /*
>> - * Die if refs is for a submodule (i.e., not for the main repository).
>> - * caller is used in any necessary error messages.
>> + * Die if refs is not the main ref store. caller is used in any
>> + * necessary error messages.
>>   */
>>  static void files_assert_main_repository(struct files_ref_store *refs,
>>                                        const char *caller)
>>  {
>> -     /* This function is to be fixed up in the next patch */
>> +     if (refs->store_flags & REF_STORE_MAIN)
>> +             return;
>> +
>> +     die("BUG: unallowed operation (%s), only works "
>> +         "on main ref store\n", caller);
>
> "Unallowed" isn't really a word; one would say "disallowed". But it
> might sound better to say
>
>     BUG: operation %s only allowed for main ref store
>
>>  }
>>
>>  /*
>> @@ -1009,9 +1016,9 @@ static void files_assert_main_repository(struct fi=
les_ref_store *refs,
>>   * files_ref_store is for a submodule (i.e., not for the main
>>   * repository). caller is used in any necessary error messages.
>>   */
>> -static struct files_ref_store *files_downcast(
>> -             struct ref_store *ref_store, int submodule_allowed,
>> -             const char *caller)
>> +static struct files_ref_store *files_downcast(struct ref_store *ref_sto=
re,
>> +                                           unsigned int required_flags,
>> +                                           const char *caller)
>
> The docstring for this function needs to be updated; it still talks
> about the old `submodule_allowed` parameter.
>
>>  {
>>       struct files_ref_store *refs;
>>
>> @@ -1021,8 +1028,9 @@ static struct files_ref_store *files_downcast(
>>
>>       refs =3D (struct files_ref_store *)ref_store;
>>
>> -     if (!submodule_allowed)
>> -             files_assert_main_repository(refs, caller);
>> +     if ((refs->store_flags & required_flags) !=3D required_flags)
>> +             die("BUG: unallowed operation (%s), requires %x, has %x\n"=
,
>> +                 caller, required_flags, refs->store_flags);
>
> Same comment about "unallowed". Maybe
>
>     BUG: operation %s requires abilities 0x%x but only have 0x%x
>
>>
>>       return refs;
>>  }
>> [...]
>
> Michael
>



--=20
Duy
