Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73D31209B1
	for <e@80x24.org>; Wed,  6 Sep 2017 20:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbdIFUcY (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 16:32:24 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36069 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752505AbdIFUcX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 16:32:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id p17so679wmd.3
        for <git@vger.kernel.org>; Wed, 06 Sep 2017 13:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EPOeDqkFDdX1z2zE9IFFbydsbl9fVWWGSyh9mzqmHfI=;
        b=KR9D0EZyPM1MEYeGt0H/eu7y7xYJE8jwitIT6FvUV80sSuJ8huy29irRuQ5iWfpmix
         AcO765BP7/UQsCDsRcRvQGnGgc+w7LG/fp3YzvY1pw+ov9O/Z5i+xjTxAcsuKbdDZxuN
         X3MUCkBqBdlj4ir+UyfN2T4aPhGx8EKJ/az2gcpSyNArR0+TU+yNMxUE/TnuWBB7xeur
         VSbaVMSxuDzPL5K+RkhV0H23Uce+5YjJvkwye7ht2p//FcmJrVt+B5ZEBaWzwiA0Gl9u
         WGgArWGA4hIYl1NZKiH4z3VYv/C49iE9yFMwiXayDgXpLwaS+/Xv2rQ/rjVyHKQi+2LG
         waug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EPOeDqkFDdX1z2zE9IFFbydsbl9fVWWGSyh9mzqmHfI=;
        b=WOdIogZmHb9NQ5II6tAHcj7XpApnkr+DviuT513/pOCBfOK+Pjlqy/AZPVvVLnnZwT
         YDHWqRduw2kooFqS+NA+ZQ0DWsYUuTbcg5MLLZmC7u/4ksvSZFFcBg7bU+g6P9obmDMn
         IHI0R4Lc7uXx7M4QlnAVwJThq97UEbEUUwSuGY/WEV7Pjm5wOnSZhhShfcGyI1yMyUtI
         ccA/VhcauttzaokwgpnecazC3gXlYH3YSObi8VgcEE+NCpK+Lncl/lItPqnyDKBQczOD
         7VB4KVdgB848/oC+YLGkS4guVtjvub9a67YPVb2Rx2HS6xniRY95PVQcfaK1KLdVXENJ
         oeZA==
X-Gm-Message-State: AHPjjUjZS9ZZlhAWFiQxER/2M0F1DRNHte9ih72nESdX+ro7L3GKaiiw
        ZUB6105V06eVqThQgY8umLC4gMEzgQ==
X-Google-Smtp-Source: ADKCNb4dCDND2xms/zBOyva9omlTWkz9/WuJGnHoGAj4R28/Pny4I/2PeHRDa5InF4S9459nUTZGNgxgeubz7WJ103A=
X-Received: by 10.80.201.10 with SMTP id o10mr683774edh.98.1504729941802; Wed,
 06 Sep 2017 13:32:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.135.130 with HTTP; Wed, 6 Sep 2017 13:32:21 -0700 (PDT)
In-Reply-To: <xmqqh8wgaa7s.fsf@gitster.mtv.corp.google.com>
References: <20170904200504.15249-1-t.gummerer@gmail.com> <xmqqh8wgaa7s.fsf@gitster.mtv.corp.google.com>
From:   Thomas Gummerer <t.gummerer@gmail.com>
Date:   Wed, 6 Sep 2017 21:32:21 +0100
Message-ID: <CALgYhfPYHu6giOgL4hF3kV9hMWOi_wDgecO0Yb60YVgYJsiaeg@mail.gmail.com>
Subject: Re: [PATCH] refs: make sure we never pass NULL to hashcpy
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "brian m. carlson" <sandals@crustytoothpaste.ath.cx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 6, 2017 at 2:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
>> gcc on arch linux (version 7.1.1) warns that a NULL argument is passed
>> as the second parameter of memcpy.
>>
>> In file included from refs.c:5:0:
>> refs.c: In function =E2=80=98ref_transaction_verify=E2=80=99:
>> cache.h:948:2: error: argument 2 null where non-null expected [-Werror=
=3Dnonnull]
>>   memcpy(sha_dst, sha_src, GIT_SHA1_RAWSZ);
>>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> In file included from git-compat-util.h:165:0,
>>                  from cache.h:4,
>>                  from refs.c:5:
>> /usr/include/string.h:43:14: note: in a call to function =E2=80=98memcpy=
=E2=80=99 declared here
>>  extern void *memcpy (void *__restrict __dest, const void *__restrict __=
src,
>>               ^~~~~~
>> ...
>> diff --git a/refs.c b/refs.c
>> index ba22f4acef..d8c12a9c44 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -896,10 +896,14 @@ struct ref_update *ref_transaction_add_update(
>>
>>       update->flags =3D flags;
>>
>> -     if (flags & REF_HAVE_NEW)
>> +     if (flags & REF_HAVE_NEW) {
>> +             assert(new_sha1);
>>               hashcpy(update->new_oid.hash, new_sha1);
>> -     if (flags & REF_HAVE_OLD)
>> +     }
>> +     if (flags & REF_HAVE_OLD) {
>> +             assert(old_sha1);
>>               hashcpy(update->old_oid.hash, old_sha1);
>> +     }
>
> It is hugely annoying to see a halfway-intelligent compiler forces
> you to add such pointless asserts.
>
> The only way the compiler could error on this is by inferring the
> fact that new_sha1/old_sha1 could be NULL by looking at the callsite
> in ref_transaction_update() where these are used as conditionals to
> set HAVE_NEW/HAVE_OLD that are passed.  Even if the compiler were
> doing the whole-program analysis, the other two callsites of the
> function pass the address of oid.hash[] in an oid structure so it
> should know these won't be NULL.
>
> Or is the compiler being really dumb and triggering an error for
> every use of
>
>         memcpy(dst, src, size);
>
> that must now be written as
>
>         assert(src);
>         memcpy(dst, src, size);
>
> ???  That would be doubly annoying

No, I think it can't quite deal with the flags that are passed in.
I'm on a different
machine today, so I can't actually check, but that's what I would
expect at least.

> I wonder if REF_HAVE_NEW/REF_HAVE_OLD are really needed in these
> codepaths, though.  Perhaps we can instead declare !!new_sha1 means
> we have the new side and rewrite the above part to
>
>         if (new_sha1)
>                 hashcpy(update->new_oid.hash, new_sha1);
>
> without an extra and totally pointless assert()?

Yeah, that seems much nicer.  I'll try that and send a new a patch
(though I won't
get to it before tomorrow).  Thanks for the review.

>>       update->msg =3D xstrdup_or_null(msg);
>>       return update;
>>  }
