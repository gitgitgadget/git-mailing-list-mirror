Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14E9C1F404
	for <e@80x24.org>; Fri,  2 Mar 2018 00:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163662AbeCBAAs (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 19:00:48 -0500
Received: from mail-ot0-f178.google.com ([74.125.82.178]:45601 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163565AbeCBAAr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 19:00:47 -0500
Received: by mail-ot0-f178.google.com with SMTP id f11so7266408otj.12
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 16:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8zGfkjzXCV16BqxFR7diFZAERC8OlLXFccnyqKmb5LU=;
        b=a5uIjzS6IwvGavpYF/PylcJNn27W9CWadQErU5H/8ziQa6p85rjReBLywqjOzwp3Zx
         1VNl0cmllTJD/R9opFDKijhSI75TxJAUsEzQGZlOoBfQGad8yNymG2QQ5ZenhBKzvugv
         9rc9FGNBJAkIp3JVCA8rdCSBf+zFJGgMktT0MhrwALOy4uqpjLgLsvrheaT94Vt/MY2P
         zKF9FA5f5dx+hU5n/RtRvcuechr2u4RFQ5zQl5dSTrUkMQqIMBNvtJl+eVkRpBhXHfRE
         3m7S5u93BP6GpMdxqFDnfPCbMquaVp2k0mjNRiUq5y0IhTbth2B+hbeI5ZFMlFVr646f
         jM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8zGfkjzXCV16BqxFR7diFZAERC8OlLXFccnyqKmb5LU=;
        b=NwAQwj7v/M4nR8Cf/HgA74xKiom+YT8JeE2F9HdQ9yQ6o6J+u5sBmS5nMoI+xd8Cmp
         ZAvAvVxy9n42goppZDffPPok3npT5cVgaWhsQKtYqmKU/vSLz5ldKgwCx/1CF8REwlh/
         izoOl/XdxgQgVXn7OBXB7bKTLWp1Td430aOC8wmrMRqnD3eYEY/j17vkycVD6U7QHEr7
         VkwkrFQfDIlGhmzvIQNJpVCuXrPPPOXGQVtfiCp/J2HNe9pw5BGYHSTkl2mDiTNXLoY2
         m2otZG/ny4/1l8eS5bcCxtwMMb18HnRWKJyo0CASfOQgYpUB+Mi/cVoXzxwZ+wtCjBXo
         TzFw==
X-Gm-Message-State: AElRT7F3o/L6ee2hOvhdz0CqbOBm4dR61yWaSN/ZJhIAnxFqmg+asQL2
        xhFEb3CdEGxW3pfZ7+PK+2RtU8iMEZLeXrq05xs=
X-Google-Smtp-Source: AG47ELuzJYjopamdka4zICTx1jRHAf68OD303iTNRg/6370yYO772Una3honUGykGh0V8v6uT7eAfuPfvm4lcTpsGrc=
X-Received: by 10.157.54.204 with SMTP id s12mr2854702otd.304.1519948846481;
 Thu, 01 Mar 2018 16:00:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Thu, 1 Mar 2018 16:00:16 -0800 (PST)
In-Reply-To: <xmqqpo4nhddm.fsf@gitster-ct.c.googlers.com>
References: <20180228092722.GA25627@ash> <20180301092046.2769-1-pclouds@gmail.com>
 <20180301092046.2769-2-pclouds@gmail.com> <xmqqpo4nhddm.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 2 Mar 2018 07:00:16 +0700
Message-ID: <CACsJy8BSW_DaHRYDVeL=iHsR=4+My1GYRofBVsFALn0=D4zsGw@mail.gmail.com>
Subject: Re: [PATCH/RFC 1/1] gc --auto: exclude the largest giant pack in
 low-memory config
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 2, 2018 at 1:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> pack-objects could be a big memory hog especially on large repos,
>> everybody knows that. The suggestion to stick a .keep file on the
>> largest pack to avoid this problem is also known for a long time.
>
> Yup, but not that it is not "largest" per-se.  The thing being large
> is a mere consequence that it is the base pack that holds the bulk
> of older parts of the history (e.g. the one that you obtained via
> the initial clone).

Thanks, "base pack" sounds much better. I was having trouble with
wording because I didn't nail this one down.

>> Let's do the suggestion automatically instead of waiting for people to
>> come to Git mailing list and get the advice. When a certain condition
>> is met, gc --auto create a .keep file temporary before repack is run,
>> then remove it afterward.
>>
>> gc --auto does this based on an estimation of pack-objects memory
>> usage and whether that fits in one third of system memory (the
>> assumption here is for desktop environment where there are many other
>> applications running).
>>
>> Since the estimation may be inaccurate and that 1/3 threshold is
>> arbitrary, give the user a finer control over this mechanism as well:
>> if the largest pack is larger than gc.bigPackThreshold, it's kept.
>
> If this is a transient mechanism during a single gc session, it
> would be far more preferrable if we can find a way to do this
> without actually having a .keep file on the filesystem.

That was my first attempt, manipulating packed_git::pack_keep inside
pack-objects. Then my whole git.git was gone. I was scared off so I
did this instead.

I've learned my lesson though (never test dangerous operations on your
worktree!) and will do that pack_keep again _if_ this gc --auto still
sounds like a good direction to go.
--=20
Duy
