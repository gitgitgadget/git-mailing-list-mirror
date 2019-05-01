Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BFB91F453
	for <e@80x24.org>; Wed,  1 May 2019 10:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfEAKdF (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 06:33:05 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:32994 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfEAKdE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 06:33:04 -0400
Received: by mail-it1-f196.google.com with SMTP id v8so4970259itf.0
        for <git@vger.kernel.org>; Wed, 01 May 2019 03:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bLYxQdb81QrZXV4v3YYIuPlXHkslMnmTSv4sojhBGqg=;
        b=TlT/AKbKp/ZaJa7fZYDKEneSv2sWMnzdBac0Lp9yrYhzj9FiuOZ2NTjvlQeDd8BYni
         aDX5SEt2kHC8zZ0Lglyq2I3TnHmlCM0vCzd27GTFaac0tqSFPcmn3IB9uokFqA3BZf17
         o+q5pm93HsS+2UQ5OnnoIkWDdNcCC6m/uER2HPl308MqOGwyR4x2s9YehWaJqE87tF5C
         ZRwdpZXCK6u2BWBCPgvev5rRhbMTafmXsBxNYWoNpjytDOmH42fEDqaM60nCOojj+FdG
         EJ8zwO8458hOIlJ7HoEh4AIFuI91ATFEXVB1cXL2l/Frgg2LK7XEsa0WPOx6OJwOMv6o
         CgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bLYxQdb81QrZXV4v3YYIuPlXHkslMnmTSv4sojhBGqg=;
        b=eebtQQmIZsHEjxPdzfoCCLBRPg+OpMwqnW/37mfCo8w4o8mgWsEh4JTsC149ba/JPn
         Bg717AFXBlbG8emYIH3YavdwNddhoDuD/zWNLMjt89tLR4o6MBpYJiobsw24PXev/OH+
         YEHIk3onmsCrlQ9cQfx2I5+NsYtJQiLBCqC6AARkz444OOO67K80B8xio1jvOIz8F5gh
         Ki24NdFuXHjtB7JkHBCeqoAu4U+yOrRd22AxEHctIrpWwqzaAucrnugMYOdXafX3p6Qq
         PkbUUpxtBrUi8rcKo9YwSG3WPX31mz/u9oZxknb+4XWsIedEIGLorT7+8DfAzS7gIyVv
         2CJQ==
X-Gm-Message-State: APjAAAU+nW3WEfIJ9FjPU/DlGXqNrJ+VbpDBrpxld4K45d9c6nVbsxwZ
        BGMqI4p7O5nkde3K3s5JGzz0NZJmRIsJO8OGqTk=
X-Google-Smtp-Source: APXvYqySZOWvUranuaHfD0TMYDJlQTdfPRHPAcQs0BrPvvwsYvQ9IlGU9qlvgYXFNoI2bWx7ObdOFGgbhCYa3Kex3hA=
X-Received: by 2002:a24:1104:: with SMTP id 4mr1189592itf.10.1556706783585;
 Wed, 01 May 2019 03:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190501101403.20294-1-phillip.wood123@gmail.com>
 <20190501101403.20294-2-phillip.wood123@gmail.com> <CACsJy8AeOWEMVcDiJky1SbSitkyBxSWu9CeDf8aspyLA1VDe8g@mail.gmail.com>
In-Reply-To: <CACsJy8AeOWEMVcDiJky1SbSitkyBxSWu9CeDf8aspyLA1VDe8g@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 1 May 2019 17:32:37 +0700
Message-ID: <CACsJy8DD-Ubb9VyZCWdkpS1OgPpToMmrdMceXPUp3AWbfhvgdQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] read-tree --reset: add --protect-untracked
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 1, 2019 at 5:18 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Wed, May 1, 2019 at 5:14 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> > diff --git a/unpack-trees.h b/unpack-trees.h
> > index d344d7d296..732b262c4d 100644
> > --- a/unpack-trees.h
> > +++ b/unpack-trees.h
> > @@ -41,9 +41,15 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
> >   */
> >  void clear_unpack_trees_porcelain(struct unpack_trees_options *opts);
> >
> > +enum unpack_trees_reset_type {
> > +       UNPACK_NO_RESET = 0,
> > +       UNPACK_RESET_OVERWRITE_UNTRACKED,
> > +       UNPACK_RESET_PROTECT_UNTRACKED
> > +};
> > +
> >  struct unpack_trees_options {
> > -       unsigned int reset,
> > -                    merge,
> > +       enum unpack_trees_reset_type reset;
>
> Can we add protected_untracked that can be used in combination with
> the current "reset"?
>
> This opens up (or raises the question about) the opportunity to
> protect untracked changes on non-reset updates.

Bahh. "protect_untracked" is already on for non-reset updates. Sorry
for the noise.
-- 
Duy
