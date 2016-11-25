Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83BAF1FBB0
	for <e@80x24.org>; Fri, 25 Nov 2016 12:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753881AbcKYMPs (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Nov 2016 07:15:48 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33438 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753553AbcKYMPq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2016 07:15:46 -0500
Received: by mail-yw0-f194.google.com with SMTP id s68so3305448ywg.0
        for <git@vger.kernel.org>; Fri, 25 Nov 2016 04:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BE/W2Fo2xK85xK6s2mn6l9tTZhJiSTHDrzLCI5yCcd8=;
        b=0Je99+84p1s5nWzzDazLuokG70K3N0hPJ059HJ5K4GZkYVrflQstNvJ4sibxpHp9nX
         9R0xIdi53Nc758O/XQuMv11euYLgXMxlskcuVTqctMB3aHAFWCvv37e895tgtlv7emdp
         GSmg9peEQLVjD1trnczefkGAhUigDZT5PU3HufhWvmgcUhkf9pRqr6OEi+LlSo3ITCBH
         yyoLeNfhoJlwwpdHQpBjx+XvXVkwXDr9Lyi+sk4Zztg+cOcni/MHIPF8mqBpmhqnH5Q3
         CmkYoF3dIKUrttjh2FigHWNWHtFIP5vHxSsMjhpc0RJXlI65HL93hfTbVlxGHvGcr/9w
         OGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BE/W2Fo2xK85xK6s2mn6l9tTZhJiSTHDrzLCI5yCcd8=;
        b=MKLxDVHJbnhBAFd/VmtJmF3UcoW9SZzgELqBxVtgcz+zuMZZg31dR9hVDJCtudh9JW
         9tGhqqjsd3zurb1ujJCUfTQpH2nAa+C5VySOLt2y0GELpHrm8q8c/Ewp0e0rjXc6Xuwc
         JPm5Aoq+4FCRpkQVrBCvY+nW0gZJPV4kGdBRIFoao9pwIoWuzFXEfCJiHyURtnotjz2F
         0y1Q36nY4FuhC11wbxsnbhvZbvndimHx5dvdNKIGO3BSRxPhp8m+7bj0xdlRrlzsgYKo
         HlUc8dpRJTuGmeKlCztvmHyHck1jZ64nHh9uxuH63bCnN4bxXZE5Eb1cjyeRO9cJVfQy
         Wojg==
X-Gm-Message-State: AKaTC03wzcZIS/1soFevTTL0f1P6tXAsrOgc6dwYfliqXfoRlvybBRLCq7fP/S1j+IjQtpPTufOKegvfVGPdOA==
X-Received: by 10.13.224.3 with SMTP id j3mr10373566ywe.46.1480076145963; Fri,
 25 Nov 2016 04:15:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.211.7 with HTTP; Fri, 25 Nov 2016 04:15:15 -0800 (PST)
In-Reply-To: <20161124205242.ts4qhvfz2hvxez36@sigill.intra.peff.net>
References: <20161122123019.7169-1-pclouds@gmail.com> <20161124114536.22249-1-pclouds@gmail.com>
 <20161124205242.ts4qhvfz2hvxez36@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 25 Nov 2016 19:15:15 +0700
Message-ID: <CACsJy8Atv9rkwmCcXgOqDb6pLP8RxQ7XnxMYt3=hN6KG4X79iA@mail.gmail.com>
Subject: Re: [PATCH v2] merge-recursive.c: use string_list_sort instead of qsort
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 25, 2016 at 3:52 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Nov 24, 2016 at 06:45:36PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
>> This started out to as a hunt for remaining qsort() calls after rs/qsort
>> series because qsort() API is a bit easy to get wrong (*). However,
>> since we have string_list_sort(), it's conceptually a better way to sort
>> here.
>>
>> (*) In this particular case, it's even more confusing when you sort one
>> variable but you use the number of items and item size from an unrelated
>> variable (from a first glance)
>
> Makes sense, though I think I probably would have explained it in
> reverse order:
>
>   Merge-recursive sorts a string list using a raw qsort(), where it
>   feeds the "items" from one struct but the "nr" and size fields from
>   another struct. This isn't a bug because one list is a copy of the
>   other, but it's unnecessarily confusing (and also caused our recent
>   QSORT() cleanups via coccinelle to miss this call site).
>
>   Let's use string_list_sort() instead, which is more concise and harder
>   to get wrong. Note that we need to adjust our comparison function,
>   which gets fed only the strings now, not the string_list_items. That's
>   OK because we don't use the "util" field as part of our sort.
>
> Feel free to use or ignore my description as you see fit. :)

I delegate the decision to Junio. He can amend the commit if he
decides so. I suspect it's a good idea to do so.

>> -static int string_list_df_name_compare(const void *a, const void *b)
>> +static int string_list_df_name_compare(const char *one, const char *two=
)
>>  {
>> -     const struct string_list_item *one =3D a;
>> -     const struct string_list_item *two =3D b;
>> -     int onelen =3D strlen(one->string);
>> -     int twolen =3D strlen(two->string);
>> +     int onelen =3D strlen(one);
>> +     int twolen =3D strlen(two);
>
> I guess I haven't used string_list_sort() in a while, but I was
> surprised to find that it just feeds the strings to the comparator. That
> makes sense for using a raw strcmp() as the comparator, but I wonder if
> any callers would ever want to take the util field into account (e.g.,
> to break ties).
>
> We don't seem to care here, though (which can be verified by reading the
> code, but also because any mention of one->util would be a compilation
> error after your patch). So I guess we can punt on it until the day that
> some caller does need it.

Some callers do need it, or at least fmt-merge-msg.c:add_people_info()
does, maybe builtin/remote.c:show() and shortlog.c:shortlog_output()
too. But I'll stop here and get back to my worktree stuff.
--=20
Duy
