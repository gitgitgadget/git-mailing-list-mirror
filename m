Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CFE71F453
	for <e@80x24.org>; Thu, 21 Feb 2019 11:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfBULwd (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:52:33 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:33842 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbfBULwc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:52:32 -0500
Received: by mail-io1-f68.google.com with SMTP id e1so1220070iok.1
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 03:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zq3ARzxfzM5etRn5W2VTvThOaUsCPG5pMVeBtX75nLo=;
        b=fP6/dI2DSONDRzWZQaTJhqx3IoxQ8QbHqihnSwR38uAlDOOKzKKW27f3l67wQmgbdF
         SgBq4tDbp5Ay4dRh7Eo5+lALmYZGD6LIGRNAZhpQdeJ0ryesSzbs0PioUdD3gA1JK7vb
         Cd5s79epWD5g02V1xVMVarXzZrJX7Wi3JxNb/5TDrzv187NBELI/REK7Gc/rBWF7kOf1
         FC2WTdjCJqt4cxzu1IT8ccIJEP/xh+Nphr2kFxqIW0If3ncKz25c/2rXUY9En804Tz5T
         ER595hAnuylOCLRpZF0G0pn+CWXhXsLo/GWmoHlK2mgkFFESOKctHXDS4kC3lCwLIr/c
         /YTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zq3ARzxfzM5etRn5W2VTvThOaUsCPG5pMVeBtX75nLo=;
        b=iwsljc1FH1Bz7p/hTAC8Ewqc2370qhopcHN3n3TQ/GT/DLT6+l5fi0tGuzIvYB+Qjc
         sVgH9FAP/UcpMll2zFL8pqQumRHe12V47AVKT46l47thJZ7eiTcCaeOK00OE1Q2ZIyGw
         tLjkCeGz595c4tQJAYlqlRK0W8X0/bvSzgjEUqxVqg1sMABXIz71CkIBWU6ISBOwG/ea
         09ngsxe7bQC1P9ys9GyWFd1KwX/0We28Q9RXENFj3gQoHGzbPDSIUryOBhxWf0nLU2RO
         RJsOuvgFTN6+garmVrmZjPM27Lf/DuoQ6Y+fiSZ9xJ0EOBvOdYXOz/PsHVKTJV9QkoS5
         A9lA==
X-Gm-Message-State: AHQUAuYFks7gESEte2C1cYyjA/C2+tcxF/ezNy8Fc6Ap/l0NzLdppGu/
        p7EWxTstw5WQ1sXLGc4ckeEIVeqHk3sY3JfNCg9s5jkh
X-Google-Smtp-Source: AHgI3IbfbcbEtREnSaBSWv5vjee0a0dK50B4xjuJS6zYwEICeJrPGAqotV7GlmFc/BjOW0U2FcBXcoFshkX39Bc5xWk=
X-Received: by 2002:a5d:9357:: with SMTP id i23mr10559644ioo.236.1550749951262;
 Thu, 21 Feb 2019 03:52:31 -0800 (PST)
MIME-Version: 1.0
References: <1550500586.2865.0@yandex.ru> <20190221110026.23135-1-pclouds@gmail.com>
 <1550748525.30307.1@yandex.ru> <CACsJy8AERM==LunYTszUf1Fb-uHPZLjkSE5x1T=0Ueqsvq3F_A@mail.gmail.com>
 <1550749488.30307.2@yandex.ru>
In-Reply-To: <1550749488.30307.2@yandex.ru>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 21 Feb 2019 18:52:05 +0700
Message-ID: <CACsJy8CWH-b18uaRvn-bXdsRbn+6QnJ6GNekqG2khGeJUa8S3w@mail.gmail.com>
Subject: Re: [PATCH] worktree add: sanitize worktree names
To:     Konstantin Kharlamov <hi-angel@yandex.ru>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 6:44 PM Konstantin Kharlamov <hi-angel@yandex.ru> wrote:
> >>  > +
> >>  > +     /* last resort, should never ever happen in practice */
> >>  > +     if (name->len == 0)
> >>  > +             strbuf_addstr(name, "worktree");
> >>
> >>  I assume this means a user have passed a zero-sized worktree name?
> >> But
> >>  zero-sized file/directory names are not possible anyway, would it
> >> make
> >>  sense to just return an error in this case?
> >
> > It could happen if you do "git worktree add .lock". The ".lock" part
> > will be stripped out, leaving us with an empty string.
>
> Ah, I see. Then, would it maybe make sense to just sanitize the ".lock"
> out the same way as you did with special symbols, i.e. with dashes?

Hmm.. I actually did not think of that. Then we could return the error
if "name" is empty.

> (I am not a git developer, so not sure if that's a good question, but I
> would also question why ".lock" needs to be deleted. I guess git uses

It's because "foo.lock" is usually a temporary file to prepare things
before we do an atomic update to "foo". And the "refs guys" were just
being careful when they designed reference names so they reject any
reference names that end with .lock. You can try to create a branch
named something.lock, it will not go through. This is actually
documented in "git help check-ref-format".

> the postfix internally, but why can't it be okay with "name.lock.lock")

Uh oh I miss this case. I only delete ".lock" once, "name.lock" would
still be rejected. Thanks for noticing.
-- 
Duy
