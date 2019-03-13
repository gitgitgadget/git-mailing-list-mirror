Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4002020248
	for <e@80x24.org>; Wed, 13 Mar 2019 11:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfCMLFu (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 07:05:50 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35523 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCMLFt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 07:05:49 -0400
Received: by mail-io1-f68.google.com with SMTP id x4so1278868ion.2
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 04:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eGh/l+osiX/dGtaLY0MEh/RXvWpaZUVXuwL2dyR3Y6c=;
        b=tgWDEALxFHaFi0rCyJeXnhiX+DHwci54TDQ2nDs5CpQlFManZYChWtGyun9WEC0sEq
         jABihp6u+c63z/tu070tuL4+LhM4mOiWzpdhcrjXJ2IS29p39pel5gfZRR/BtZR1cJ4K
         1ZPDdlTTsMLOgXc3KX802HI7vOenX4CnDq/0NUkPVrxOl+smQBOxF9tnK2STRrJu9YcV
         8lgs4TrsdOCc1PiaQL4DMqCWv3tslJDe8tamJXbYw+JLl6bcUvbTKr9dHIhiVD5mDeIS
         sCRbpI3vZx800zGLjgjdOry0CYbJM/Cod5TqSy6Qj4dNZYIQ8hSouZALSoRLT+VyAFJa
         Rw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eGh/l+osiX/dGtaLY0MEh/RXvWpaZUVXuwL2dyR3Y6c=;
        b=OA4xELRlqzDtXwLyd3CTAeV5jjVTcBO+NE4G4L8iXpm+wQ/vsl+oec5ce/svOzIm0k
         aRdOQBxNFCW7d3+jyaTZ1iq3yaCcYYXnMNPceHWDlUa0nFrG2SX4JqouzZCudiL/sh4c
         CI/vjbmAwVu+kimQFAGG1rIVJ8KPYVWqQ6TWoVNgKR6wx5k7rErQjdx+jL8q/Ekx82ys
         ZEZ0F/S+qGO1eZYv7slb284QUNxZXDC6/w7Q/My7X6WhPbb0WZX0bVLnvfmp9XVBxVxw
         2dXmYkDUmv41HOndsJVweQMNW9zr7lvoWeoaO1p+5Wq9xClquAwkinUk6gGkEJImnGLu
         yTnA==
X-Gm-Message-State: APjAAAUQriod+er89L9MTLGA8bsgOpa0llt/P7JzjBAHj3QtKo6QXxLz
        olHUYD1ByKX7u1BLl7QqycZmc70Bwl95YpXTSsZuzA==
X-Google-Smtp-Source: APXvYqwK1uiPDB5B4o8rkwhey3jflJCi+t9Vyp7FA2W+ELEPE/23wTN/Nkg91g8NGKycCzguN5b8vFz955zoYwt8X6E=
X-Received: by 2002:a5e:d616:: with SMTP id w22mr7826941iom.118.1552475148833;
 Wed, 13 Mar 2019 04:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <CABPp-BEBudobnduipQrSvyQWQ7Hb4WmmoptCQ+FyY8BRPp7_ZA@mail.gmail.com>
In-Reply-To: <CABPp-BEBudobnduipQrSvyQWQ7Hb4WmmoptCQ+FyY8BRPp7_ZA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 13 Mar 2019 18:05:22 +0700
Message-ID: <CACsJy8BkdUN=KNGxRi-4jGcw3EQTAuu_2eKcNRDv0uwP5L4=Nw@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 12:54 AM Elijah Newren <newren@gmail.com> wrote:
> > +--progress::
> > +--no-progress::
> > +       Progress status is reported on the standard error stream
> > +       by default when it is attached to a terminal, unless `--quiet`
> > +       is specified. This flag enables progress reporting even if not
> > +       attached to a terminal, regardless of `--quiet`.
>
> This again makes me curious what --quiet actually supresses; in the
> case of branch switching, are there any non-warning informational
> messages other than progress reports that are printed?

One big thing git-checkout and git-switch will print when not --quiet
is "git diff --name-status" to highlight local changes since we allow
switching branches when the worktree is not clean. Should it be
mentioned in --quiet description?

We could also occasionally print advice, branch tracking info, and
one-liner summary like "Switched to (new) branch 'master'".
-- 
Duy
