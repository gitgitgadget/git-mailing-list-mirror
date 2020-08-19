Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A459CC433E4
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 13:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DE1F20882
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 13:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4/WkHM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgHSNhg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbgHSNhN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 09:37:13 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7ACC061757
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 06:37:13 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id p137so4884415oop.4
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 06:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aMKTvj74w5nceoQG5bz/zZ2XIeYp6hG+9AfNmVDkQVc=;
        b=b4/WkHM4DWfHYy/J8t02lcQL41Cd7/dNEOlmP79fteLsEo7/yXp9lhd6ZP5ceEF23C
         cq0Fr/xbBEwqohZlj4G2pCivHHMA8kWG6GTU/03TTt35MvDs51kbD2iMWeQklrNLdaIc
         yJe9pcgBgAf8eFnGj1ak39RCjHfble22uEvycWUH+74VQVnI36gxeO1nildZwCck51c6
         /j1fI65K9rUaaoTWzA3bkvX3kccau+wDBkrTylbi26jXxHuqJn5lFNJF2oVMCmiLnXAl
         Uzt3L+0+MNmXHAq0CXmWFCOatg5bTB7n1nuAMtVNS3E+QQnO00x1KqkYL10XRL3QVkAs
         HSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aMKTvj74w5nceoQG5bz/zZ2XIeYp6hG+9AfNmVDkQVc=;
        b=Cgzh4eA5tVLTgNUBUMP/C7TfKk2/YBbZPjRgojp5ZYeNJ6AIT/1gGcYlQOjKoa+P2i
         VtdmFx2VLiXbjsQe0GaggEYZ1ZBkz64eCAbRlndpf2rXOrFmSWY3+aeEQMwWrZvFosJs
         GJh1FYwFrj8kvsbb3o1PCI1A7eeFwHLJImGNisKZz9xyJXxFY54Jjrkmepqpli0OAb9K
         DpyFChNJKG7JttoVaJD2n36y9DhgNkOdzagN7ZD1YlIRyA0WVwXV5YVZ9swusFZGa9DY
         BCZqfXCcUEwsNoMMMWlMzCS9h37BN1wasziKM4FblC+Vu9DNJmGWB0iJQm5xjAWh8T+e
         g6IQ==
X-Gm-Message-State: AOAM5308Gm7on62xYSpsTxBLjU55qtp3q3SeCfR7Z6paMDu70/BteE3I
        OIDioJdkm0pX+dXT5zM3DTn2T6YqgpSI4NqJU5I=
X-Google-Smtp-Source: ABdhPJyP2pTcv+UAmLr40wFVEOERF5InkApHUPW4WW2ZdnFCincWSlB9Ule3pc+g6fITcEsMubBrU9KpmBtmdIe52iM=
X-Received: by 2002:a4a:1542:: with SMTP id 63mr18984683oon.73.1597844230440;
 Wed, 19 Aug 2020 06:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
 <pull.684.v3.git.1597687822.gitgitgadget@gmail.com> <0ad22c7cdd3c692aa5b46444e64a3b76f1e87b4c.1597687822.git.gitgitgadget@gmail.com>
 <xmqqpn7p1373.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqpn7p1373.fsf@gitster.c.googlers.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Wed, 19 Aug 2020 19:06:59 +0530
Message-ID: <CA+CkUQ9tkwXmrHq_ZV+RCgwoFHZ0M4dEhBkjUd97Xi+3shB-WQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] pretty: refactor `format_sanitized_subject()`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Heba Waly <heba.waly@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Aug 18, 2020 at 12:59 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > -static void format_sanitized_subject(struct strbuf *sb, const char *msg)
> > +static void format_sanitized_subject(struct strbuf *sb, const char *msg, size_t len)
> >  {
> > +     char *r = xmemdupz(msg, len);
> >       size_t trimlen;
> >       size_t start_len = sb->len;
> >       int space = 2;
> > +     int i;
> >
> > -     for (; *msg && *msg != '\n'; msg++) {
> > -             if (istitlechar(*msg)) {
> > +     for (i = 0; i < len; i++) {
> > +             if (r[i] == '\n')
> > +                     r[i] = ' ';
>
> Copying the whole string only for this one looks very wasteful.
> Can't you do
>
>         for (i = 0; i < len; i++) {
>                 char r = msg[i];
>                 if (isspace(r))
>                         r = ' ';
>                 if (istitlechar(r)) {
>                         ...
>         }
>
> or something like that instead?

Ok, that sounds better. Noted for the next version.

> > +             if (istitlechar(r[i])) {
> >                       if (space == 1)
> >                               strbuf_addch(sb, '-');
> >                       space = 0;
> > -                     strbuf_addch(sb, *msg);
> > -                     if (*msg == '.')
> > -                             while (*(msg+1) == '.')
> > -                                     msg++;
> > +                     strbuf_addch(sb, r[i]);
> > +                     if (r[i] == '.')
> > +                             while (r[i+1] == '.')
> > +                                     i++;
> >               } else
> >                       space |= 1;
> >       }
> > +     free(r);
>
> Also, because neither LF or SP is a titlechar(), wouldn't the "if
> r[i] is LF, replace it with SP" a no-op wrt what will be in sb at
> the end?

Maybe its better to directly replace LF with hyphen? [Instead of first
replacing LF with SP and then replacing SP with '-'.]

> >       case 'f':       /* sanitized subject */
> > -             format_sanitized_subject(sb, msg + c->subject_off);
> > +             eol = strchrnul(msg + c->subject_off, '\n');
> > +             format_sanitized_subject(sb, msg + c->subject_off, eol - (msg + c->subject_off));
>
> This original caller expected the helper to stop reading at the end
> of the first line, but the updated helper needs to be told where to
> stop, so we do so with some extra computation.  Makes sense.

Yeah.

Thanks,
Hariom
