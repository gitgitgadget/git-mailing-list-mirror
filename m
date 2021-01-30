Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCC3C433E0
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 19:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB0E264E11
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 19:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhA3TBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 14:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbhA3TBt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 14:01:49 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D76C061573
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 11:01:08 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id x71so13957973oia.9
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 11:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m94d12gtyRsDTL9HN3B7eHDxSNzJelSmSscagN7fV+4=;
        b=Dt9qmJjsCfQvPLG/j8j79qOnvBYMJXrrPQmei+MclheTzay3Sv4p8mLEGz3tChoD3H
         10CMvBrMqnO3o4d3QHN0YSGxwttryqhgZo6O+5ktrUtWd3H2KhrgH+yi05BE0ohdm2HQ
         yEArvaDJqyAlKTqhsnrHu5SY8u6RIGzStKVXk532PEpL6TbI9K17XVPsQzB3J0Utksco
         wknwGi9oAIAsjXPz8J/zbzSZxYAjg8yzMzF7dBDvQTpe5fKFzQDEhQlgschXkvYmmDwL
         K2RGNwWMj9lZRTHauBvd7q5iEVm1ixs1D7TYPg/CwdRlXcrKDCHP7qxZMl7Bb+/Geals
         7zSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m94d12gtyRsDTL9HN3B7eHDxSNzJelSmSscagN7fV+4=;
        b=R+CNrmLmkRvsU7AcDBXtt5Jb4MP0phliOnRhn8VUK1Py3V9ZdrDIbK070muTb4dvEh
         BDuciL9suHuR3ozLRqao8ARQUZb7ghVbDuaC12Yw385C297B8B+ahy+Ya6Cq0aJN0vWv
         jkIzNLm7PC4jtVwCcfQpms9+5wBM8OOx6QKdkFOxqsCjfvFnSbWuqB6pPah+qyIb1XE4
         QbGUN0kwSE15MNK9iWMP6VyPJVEfhWGHFSw8YdGeP9+YPhf/5d42hB3FWCZMPSLKoXTP
         kzZnV+YFN/bg/lxCGTlqL2Y9CffYCg3sWpnQDg29HOnm4GSGJSU7oAiYY4MVzNYUlk3T
         jiIQ==
X-Gm-Message-State: AOAM533S57tyDA2vdPNLU32tD0zwoO6+9xSenKQK6tae6F+/ifuV6ARK
        1C0nEFhLT3rqaL9wNldEKUsWICzkvxrFLvY8qbw=
X-Google-Smtp-Source: ABdhPJxQYUW9Vlqfv/JUUU2XKpR5pzvCFfOM/eJFT0i/dvZrMh8R1ZYwbM7+usYeFZ0q20afGJvECqsow7KcatYY9Vk=
X-Received: by 2002:aca:ab08:: with SMTP id u8mr5986525oie.84.1612033267783;
 Sat, 30 Jan 2021 11:01:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.726.git.1599335291.gitgitgadget@gmail.com>
 <pull.726.v2.git.1611954543.gitgitgadget@gmail.com> <245e48eb6835cae4e61f65af780b766d990d4b5f.1611954543.git.gitgitgadget@gmail.com>
 <xmqqsg6jqomc.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsg6jqomc.fsf@gitster.c.googlers.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Sun, 31 Jan 2021 00:30:56 +0530
Message-ID: <CA+CkUQ-_HQG4UtdZGGc3mpXB3OnsZ0kzAPZfLLP2sV1HY9tw6A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] pretty.c: capture invalid trailer argument
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Jan 30, 2021 at 5:31 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +                     size_t invalid_arg_len = strcspn(*arg, ",)");
> > +                     *invalid_arg = xstrndup(*arg, invalid_arg_len);
> > +                     return 1;
>
> How about doing this only when invalid_arg is not NULL, i.e.
>
>         } else if (!match_placeholder_bool_arg(....) &&
>                    ...
>                    !match_placeholder_bool_arg(....)) {
>                 if (invalid_arg) {
>                         size_t len = strcspn(*arg, ",)");
>                         *invalid_arg = xstrndup(*arg, len);
>                 }
>                 return -1;
>         }

Sounds like an improvement to the current version. Will change.

> Note that I just used 'len'; when the scope of a variable is so
> short, it is clear the length of what thing it refers to from the
> context, and there is no point in using a variable name that long.
>
> In any case, by doing so, the callers that are not interested in the
> report can just pass NULL, which means ...
>
> > @@ -1464,12 +1472,13 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
> >               struct strbuf sepbuf = STRBUF_INIT;
> >               struct strbuf kvsepbuf = STRBUF_INIT;
> >               size_t ret = 0;
> > +             char *unused = NULL;
>
> ... this will become unneeded, and ...
>
> >               opts.no_divider = 1;
> >
> >               if (*arg == ':') {
> >                       arg++;
> > -                     if (format_set_trailers_options(&opts, &filter_list, &sepbuf, &kvsepbuf, &arg))
> > +                     if (format_set_trailers_options(&opts, &filter_list, &sepbuf, &kvsepbuf, &arg, &unused))
> >                               goto trailer_out;
>
> ... this will pass NULL, and ...
>
> >               }
> >               if (*arg == ')') {
> > @@ -1479,6 +1488,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
> >       trailer_out:
> >               string_list_clear(&filter_list, 0);
> >               strbuf_release(&sepbuf);
> > +             free((char *)unused);
>
> ... this will become unneeded.
>

Thanks,
Hariom Verma
