Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2390120248
	for <e@80x24.org>; Mon, 11 Mar 2019 19:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfCKTAl (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 15:00:41 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:38104 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfCKTAk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 15:00:40 -0400
Received: by mail-vk1-f196.google.com with SMTP id x140so46618vke.5
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 12:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PPkNBd662lPvJNwxf7U04hcqqjfC7EAh0V7/a6I/Pzs=;
        b=DBzf8mfqcRaM/EXdzhXyuDhUW5+VM6AIbZa7ZzXlUkQq1RRuUA52+DShBNfj4t1vFq
         1WRqb5EiCg55tgGsCIORW9sW8cFHnQwU73Eiw0D4c3iS08bFvHi1sG+ap2SuOPr677+x
         i1NuPMppf+HHOx+VR0mNLmb2TYAdTog5BoT1JLLhtvHsgNcilfBdCzXve0cJ0p7OBDgZ
         DCcrXux4JpyeA5q/LqoemgKXeYEE6hV6r3DgqgdJaRZw6aHOvGY16DV72LA3YoXbAC3r
         qxdJ8b5flNCnrde56RVGvOgAAeJUtQO08yKUKwRI27DwiDdhGjG3YuLkf8bG8rHiK8qv
         JIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PPkNBd662lPvJNwxf7U04hcqqjfC7EAh0V7/a6I/Pzs=;
        b=NofZDGQPRECzmtj6yiJYdR5cmP66y0fI3Ao4tQO0IFddEV5Upn1WHjKPN56gibv24s
         e2EYV8PfC3nS4RYY9oZJwLSDZHxCR9yMJ2YP7lSRcaH0kOj5fwzgUTjSj87jEzKdc7b4
         oo81yUwzut4u38I4laJZxmzfUzCBrBDBHH760QlspAPXk/IrBnH8Y9DfypAhLY+RCobv
         dWtRoNV9gHtWC0rJfaJDJeLWOpokrQ0i3tzB7xeyySNuQNHahFsVpQnaSzmjVSeN9YVV
         f7tol7IyHLcKv6naE1iMK4zPQpYd9/VAiMdn2pcLttR1qNUNYpBpreiFnsdOGSDuvhmS
         8nmw==
X-Gm-Message-State: APjAAAVMGJUNuvyskC6j3nSTjIgBhZ7uuyQ+EQsXlx0N77xmp7Z5hZ7I
        yj4hgY6bNnxTmtfiM7CmzBpciDCylB4ppz2emNs=
X-Google-Smtp-Source: APXvYqwEkDZV5IzREM2eyqLBdozfw929FKjKow8wGg9QcgSX4cxMwolENFK5m+gQ5TByRaccLMNSRfLb4cXxe4JPmC8=
X-Received: by 2002:a1f:2acb:: with SMTP id q194mr17056450vkq.92.1552330839856;
 Mon, 11 Mar 2019 12:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <3A57DE38-A5A7-468B-9509-4244C285896A@gmail.com>
In-Reply-To: <3A57DE38-A5A7-468B-9509-4244C285896A@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 11 Mar 2019 12:00:28 -0700
Message-ID: <CABPp-BH+RRaC1bw2_4e7C8PicnF=qT+c9TcRv+E1efbx6X=Akw@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 10, 2019 at 5:29 PM Jacob Keller <jacob.keller@gmail.com> wrote=
:
>
> On March 8, 2019 1:57:41 AM PST, "Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy" <pclouds@gmail.com> wrote:

> >+<new-branch>::
> >+      Name for the new branch.
> >+
> >+<start-point>::
> >+      The name of a commit at which to switch to before creating a
> >+      new branch or detach from.
>
> The wording here (and a few other places) feels awkward to me. I don't re=
ally have a better wording but maybe:
>
> ---
> The name of the commit to switch to when creating a new branch or detachi=
ng HEAD
> ---

I also struggle a bit to get better wording in this case.  But maybe
throwing another idea will inspire someone to synthesize (or rewrite)
these into something better, so...

--
The starting point for the new branch.  Specifying a <start-point>
allows you to create a branch based on some other point in history
than where HEAD currently points.  (Or, in the case of --detach,
allows you to inspect and detach from some other point.)
--

I know it's slightly on the longer side, but it's the best I could think of=
.
