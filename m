Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6E99207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 18:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S975651AbdDXSM0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 14:12:26 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35977 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S975389AbdDXSMY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 14:12:24 -0400
Received: by mail-pf0-f178.google.com with SMTP id 194so15959034pfv.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 11:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pSyOnYnTPr/P+sXfdvJZDQNe4uPv6AdxsuC52lGLhiM=;
        b=n4KqnckxgVHhQ2cvTJ7P1eRUhINRB7thKhdpjpJiy9w1a3DeO/5BXhzTkMFeUFIts/
         yxlkBu6US0uwcLRiLyREwxmnLi0ugzjMmEZm6Lw3KGMMx3OyDMzp+KQIfBApc/LmKIPh
         vJagif0HazhLbP7wYf70Ovb8uoM3kC4xSGCdmFLvA9ij/QGeFzvg13wBpZ3PwJjS2jGw
         9euECrWlheRTYjuxhVLi1TKqLV7jbZLNbAW80arLplb5zZech7HaGF/7GG7Spb7s30qh
         NnytvJXqxgk+XarcTP4KvgWqchwlJK6SbpnJ0XFo0PvR0qMRzbU+70KMmwjk4/kz15+x
         B16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pSyOnYnTPr/P+sXfdvJZDQNe4uPv6AdxsuC52lGLhiM=;
        b=J5cT0mApojq4pfATs88FVvkzCFVze4GAm6CBCyhUx7Hh7k5ibZ5kFoQTXNPyqlRLbh
         tCil9ZStgTDRm+TR408tS7IJXX3VF36u7WEa29Z4zFQNxNk9BYEvGp+fixDHXmb5Ijdx
         oFzGxKdGX+ddwdrzknT6Mue3I/G0zE91qSoqHPhicaWIzDcS5YPodBAN8troGJEYasLh
         wH1dNa7mLbi9szeLihu7rDkxjMVG1Mhopt364V5TLWYmeFHchrdeP4uD33osAvN7kssN
         XEIypRrQcyrn68b+qLaRpaywBvUPZC+cadq5fHM0blagR4oc5Pib/DQd47vhhKUKIPW6
         crJA==
X-Gm-Message-State: AN3rC/71vmulqQP3kKcMFlAU2teGkEPMEbTMYvWKqLYza/1JYur2iz88
        HjhCjsBY4xVoqYhVparJtnlp13JJZAn9
X-Received: by 10.98.72.88 with SMTP id v85mr26312418pfa.8.1493057543262; Mon,
 24 Apr 2017 11:12:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Mon, 24 Apr 2017 11:12:22 -0700 (PDT)
In-Reply-To: <378b8e50-562a-a311-2e0f-505de036aaf1@alum.mit.edu>
References: <20170419110145.5086-1-pclouds@gmail.com> <20170419110145.5086-6-pclouds@gmail.com>
 <378b8e50-562a-a311-2e0f-505de036aaf1@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Apr 2017 11:12:22 -0700
Message-ID: <CAGZ79kb-8zUibxCMNxkg2jbGLuXPGm0ZjqZ_KtLKV4YTrn0TsQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/12] refs: move submodule slash stripping code to get_submodule_ref_store
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 10:27 PM, Michael Haggerty <mhagger@alum.mit.edu> w=
rote:
> On 04/19/2017 01:01 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> This is a better place that will benefit all submodule callers instead
>> of just resolve_gitlink_ref()
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  refs.c | 33 +++++++++++++++++----------------
>>  1 file changed, 17 insertions(+), 16 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index 5902a3d9e5..26474cb62a 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1422,25 +1422,10 @@ const char *resolve_ref_unsafe(const char *refna=
me, int resolve_flags,
>>  int resolve_gitlink_ref(const char *submodule, const char *refname,
>>                       unsigned char *sha1)
>>  {
>> -     size_t len =3D strlen(submodule);
>>       struct ref_store *refs;
>>       int flags;
>>
>> -     while (len && submodule[len - 1] =3D=3D '/')
>> -             len--;
>> -
>> -     if (!len)
>> -             return -1;
>> -
>> -     if (submodule[len]) {
>> -             /* We need to strip off one or more trailing slashes */
>> -             char *stripped =3D xmemdupz(submodule, len);
>> -
>> -             refs =3D get_submodule_ref_store(stripped);
>> -             free(stripped);
>> -     } else {
>> -             refs =3D get_submodule_ref_store(submodule);
>> -     }
>> +     refs =3D get_submodule_ref_store(submodule);
>>
>>       if (!refs)
>>               return -1;
>> @@ -1558,7 +1543,17 @@ struct ref_store *get_submodule_ref_store(const c=
har *submodule)
>>  {
>>       struct strbuf submodule_sb =3D STRBUF_INIT;
>>       struct ref_store *refs;
>> +     char *to_free =3D NULL;
>>       int ret;
>> +     size_t len;
>> +
>> +     if (submodule) {
>> +             len =3D strlen(submodule);
>> +             while (len && submodule[len - 1] =3D=3D '/')
>> +                     len--;
>> +             if (!len)
>> +                     submodule =3D NULL;
>> +     }
>
> Ugh. Should a submodule named "///" *really* be considered to refer to
> the main ref_store? I understand that's what the code did before this
> patch, but it seems to me more like an accident of the old design rather
> than something worth supporting. In other words, if a caller would
> really pass us such a string, it seems like we could declare the caller
> buggy, no?

In a nearby thread we discussed whether we want to tighten the
submodule names and paths as some of the code path do funny
things on funny input. As 'submodule' here refers to a path (and not
a name), I would think '///' is not possible/buggy, rather we'd want to
discuss if we want to extend the check to is_dir_sep, which would
include '\' on Windows.

Thanks,
Stefan
