Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1835C433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 04:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE2F64FBB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 04:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhCKECW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 23:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhCKECL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 23:02:11 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C21C061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 20:02:10 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id f8so246935otp.8
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 20:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CDafgmlt31C01oAF0BYhbVAcuF5XSkS0E6IcC4N4L64=;
        b=eYYjazGXFLKmTNKJr3+Q59B3d+4iRij7hHTYHCbEnE8we3JP+qvhhzjjUJLD3m4KuS
         0c2ep39bOMyHa5619hXDfA9Omy6fGBMAMDgtW8tIf7ej20QseFJzEJHpvBUrf+TMvIs0
         xutZMxMhqsFnr3QU3ASgZHAcDf6pQPDT4/mr5ts6NVAO1eh125ouLNMmls07VcCn0NiD
         XpoqJKNCIkeK2cEtbF/uCKUrZIUSbSULmMusC6Y7ztnvPeon5PJO0V3a98npn6yKYnnl
         Dv9Aj4YENnLQz3OP/8QjF6eTMH52DJIZ1qVcVzgI7lqxcKI95h5tTQozNxYetQuPBEHi
         MZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CDafgmlt31C01oAF0BYhbVAcuF5XSkS0E6IcC4N4L64=;
        b=s/gh3/avZtYXy+zhhEz72H55xpSsNZmosg5HQTPcDaK/R9ViAp+2HL8yIb50WcegDT
         e5XMhnlzCEwlG6l50AIxpORjUpr5Q2wx89vg3SNoRE6MvRv4WNkkqE1ZPPSbIM1ydewC
         6A7ckwSzTFP0ggmI5GoCxM+eePhIf5cX2jw1KWH6aOf3uP4V+QSvedF52RvWVIbejko1
         nY2gyF3SwlKUxF7bcPJB8+3eAW/tIVLj7CZsiYS7gjBS+HMGVYREnu4Js1tuJDyfzVBi
         QhGz3bBHDVCYBoWvbTQijzW5+tyDUL9TkJmq14sFYvCNnj+OyfHEF82yii1FsM7s1fto
         QHHQ==
X-Gm-Message-State: AOAM530EYYUQyxwsmSR0pq7TP9XBl5xggkAE1CP47Bm8F2eACXOW0+83
        odVAZU/4/6cdBElFg1dB0NSwod9F7uvaN2lkxKY=
X-Google-Smtp-Source: ABdhPJz1VsFVnqv4HDTxVzPqthihQb0eEnWfK4azRdlEZPzrdthWZPRMDdqdCxnyMEXDPAKkns1mtfbFY4FmlhbREbk=
X-Received: by 2002:a9d:66:: with SMTP id 93mr5295647ota.147.1615435330333;
 Wed, 10 Mar 2021 20:02:10 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210310194306.32565-4-charvi077@gmail.com>
 <xmqqpn06h6os.fsf@gitster.g>
In-Reply-To: <xmqqpn06h6os.fsf@gitster.g>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 11 Mar 2021 09:31:59 +0530
Message-ID: <CAPSFM5dqRbuoCvEFcHQPSQt+EK1_pBVQ--f42jR+GNqCFd_SOg@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] commit: add a reword suboption to --fixup
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 11 Mar 2021 at 06:01, Junio C Hamano <gitster@pobox.com> wrote:
>
> Charvi Mendiratta <charvi077@gmail.com> writes:
>
> >                * reference for example: --fixup="HEAD^{/^area: string}" or
> >                * a suboption of `--fixup`.
> >                *
> > -              * As `amend` suboption contains only alpha character.
> > -              * So check if first non alpha character in fixup_message
> > -              * is ':'.
> > +              * As `amend`/`reword` suboptions contains only alpha
> > +              * characters. So check if first non alpha character
> > +              * in fixup_message is ':'.
>
> Sorry, but I cannot quite follow the logic.
>
>         We limit --fixup's suboptions to only alpha characters.  If
>         the first character after a len of alpha is colon, then the
>         part before the colon may be a known suboption name like
>         `amend` or `reword`, or a misspelt suboption name.
>
>         Otherwise, we are dealing with --fixup=<commit> that happens
>         to have a colon in <commit> object name.
>
> perhaps?

Yes, Agree. Here I just intend to mention the special case
"--fixup=HEAD^{/^area: string}" because of which we chose the method
to check if first non alpha char is ':' instead of directly checking
the suboption like (skip_prefix(msg, "amend:", &arg). So maybe we can
reword it like

- To check if fixup_message that contains ':' is a commit
- reference for example: --fixup="HEAD^{/^area: string}" or
- a suboption of `--fixup`.
+ fixup_message could be a commit reference for example:
+ --fixup="HEAD^{/^area:string}" or a suboption of `--fixup`.
+
+ As `amend` ...

Thanks and Regards,
Charvi
