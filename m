Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A29701F42D
	for <e@80x24.org>; Sat, 12 May 2018 11:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750827AbeELL7c (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 07:59:32 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:46824 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeELL7b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 07:59:31 -0400
Received: by mail-ot0-f193.google.com with SMTP id t1-v6so9238882ott.13
        for <git@vger.kernel.org>; Sat, 12 May 2018 04:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QxXoWfpW0MQnWWVCuZkZbFoUXIAZQZ4AX8UnDR6ySKM=;
        b=OHvD9/W5y9JQOOhYACwuox/PvoCZGyFYH8VIkmoMsIN918XhzrsWhmKz4osyUNhHGm
         8CoaYxHHfI4pZbknYzv9VCwm5w9xaHYkI1p70FltHNZlKJGj0hOIH+51ZR43vOXCsbGC
         cqsyfsmnObGi7amPca1H7WsvUvdKIPajtILFDxjxaDvmrPZF5VBncS6a3HlrjvdbrpKG
         PJ4E7I2+1b4n5YkVhVU98cs9c3Mw0ZupyewglUQdEveGMkf6/FYztDRoZJ6WF5EuBlrH
         oOdhz2qs9reSX5p5jh2eHiDRM8ucJdUDCOilyUQg1iJYHRaW+q11dGSNRQiU+uTe0Wuk
         sO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QxXoWfpW0MQnWWVCuZkZbFoUXIAZQZ4AX8UnDR6ySKM=;
        b=KR7MGGLzP3d8EXkoJj6BdVCujpwcltciEX+4SXvwWl7BHB5LgCe8Hb+YlGgzdSp5iI
         QbIWmAw22tq0RwAypPXoolp+tB9qUyV9YmI/lno3k1ESBM2ZxiwOXDobAJPa0XThUKls
         u/+CJLMr4KO5DRQ1Rc4fVgc3Ec8pvLul7jujCiKsiOGcfac5/jUg2e7zBZ3To2pG8iDQ
         GHxc4lfwndtEBpLcU62bjtanJyFQiqaiwbFhgnHz4EJmKiBvsZS3E57HjPmacJ+F3wd8
         3oa382c0dcI7qsG2aZhv/iRVWYIZD+rujDXJ0VjE6/EmA1VUn9YYTICplHUYjetDbhlH
         BTIQ==
X-Gm-Message-State: ALKqPwcjgmqYga+/Nau1kJgjCS3OKsDzsm3YBmcv6RBzhDtgN6B5IxyF
        Qd087yY+99FW/CXSatreHD411Z+CpoQDcpLvahk=
X-Google-Smtp-Source: AB8JxZpsrfePsBc7EQ4BB7VziTebIZtMigD5dWm35Y5atIRSw5wAorDXZmv64LPwdPqS+gqlcgJwAE6z30Zm2TzL0Rs=
X-Received: by 2002:a9d:e8f:: with SMTP id 15-v6mr1472578otj.14.1526126371225;
 Sat, 12 May 2018 04:59:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Sat, 12 May 2018 04:59:00 -0700 (PDT)
In-Reply-To: <20180512090748.GB28279@sigill.intra.peff.net>
References: <20180512080028.29611-1-pclouds@gmail.com> <20180512080028.29611-4-pclouds@gmail.com>
 <20180512090748.GB28279@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 12 May 2018 13:59:00 +0200
Message-ID: <CACsJy8BKxKvu-M3xdp5RPt8YaXe_Q7dhdO22BQT-q0AiOaE7vQ@mail.gmail.com>
Subject: Re: [PATCH 03/12] shallow.c: use commit-slab for commit depth instead
 of commit->util
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 12, 2018 at 11:07 AM, Jeff King <peff@peff.net> wrote:
> On Sat, May 12, 2018 at 10:00:19AM +0200, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
>> @@ -82,25 +84,29 @@ struct commit_list *get_shallow_commits(struct objec=
t_array *heads, int depth,
>>       struct object_array stack =3D OBJECT_ARRAY_INIT;
>>       struct commit *commit =3D NULL;
>>       struct commit_graft *graft;
>> +     struct commit_depth depths;
>>
>> +     init_commit_depth(&depths);
>>       while (commit || i < heads->nr || stack.nr) {
>>               struct commit_list *p;
>>               if (!commit) {
>>                       if (i < heads->nr) {
>> +                             int **depth_slot;
>>                               commit =3D (struct commit *)
>>                                       deref_tag(heads->objects[i++].item=
, NULL, 0);
>>                               if (!commit || commit->object.type !=3D OB=
J_COMMIT) {
>>                                       commit =3D NULL;
>>                                       continue;
>>                               }
>> -                             if (!commit->util)
>> -                                     commit->util =3D xmalloc(sizeof(in=
t));
>> -                             *(int *)commit->util =3D 0;
>> +                             depth_slot =3D commit_depth_at(&depths, co=
mmit);
>> +                             if (!*depth_slot)
>> +                                     *depth_slot =3D xmalloc(sizeof(int=
));
>> +                             **depth_slot =3D 0;
>
> It looks like we could save ourselves an extra layer of indirection (and
> tiny heap allocations) by just storing an "int" directly in the slab.
> Do we ever use the NULL as a sentinel value?
>
> Here we just allocate it if not set. Let's see if we can find some
> others...
>
>> @@ -116,25 +122,32 @@ struct commit_list *get_shallow_commits(struct obj=
ect_array *heads, int depth,
>>               }
>>               commit->object.flags |=3D not_shallow_flag;
>>               for (p =3D commit->parents, commit =3D NULL; p; p =3D p->n=
ext) {
>> -                     if (!p->item->util) {
>> -                             int *pointer =3D xmalloc(sizeof(int));
>> -                             p->item->util =3D pointer;
>> -                             *pointer =3D  cur_depth;
>> +                     int **depth_slot =3D commit_depth_at(&depths, p->i=
tem);
>> +                     if (!*depth_slot) {
>> +                             *depth_slot =3D xmalloc(sizeof(int));
>> +                             **depth_slot =3D cur_depth;
>>                       } else {
>> -                             int *pointer =3D p->item->util;
>> -                             if (cur_depth >=3D *pointer)
>> +                             if (cur_depth >=3D **depth_slot)
>>                                       continue;
>> -                             *pointer =3D cur_depth;
>> +                             **depth_slot =3D cur_depth;
>>                       }
>
> Here we malloc again if it's not set. But we do behave slightly
> differently when we see NULL, in that we do not bother to even compare
> against cur_depth. So if we were to directly store ints, we'd see "0" as
> the sentinel depth here, which would not match our "cur_depth >=3D
> depth_slot" check.
>
> So no, it wouldn't work to directly store depths with the code as
> written.  I'm not sure if the depth can ever be 0. If not, then it would
> be a suitable sentinel as:
>
>   int *slot =3D commit_depth_at(&depths, p->item);
>   if (!*slot || cur_depth < *slot)
>         *slot =3D cur_depth;
>
> But somebody would have to dig into the possible values of cur_depth
> there (which would make sense to do as a separate patch anyway, since
> the point of this is to be a direct conversion).

I actually tried that first, going with storing int directly in the
slab instead of int*. And some shallow tests failed so I didn't bother
(the goal was to get rid of 'util' pointer, not to optimize more)
--=20
Duy
