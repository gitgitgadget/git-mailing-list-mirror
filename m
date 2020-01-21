Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1335EC2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 10:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F4E20882
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 10:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0yalald"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgAUKAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:00:41 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:40587 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbgAUKAk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 05:00:40 -0500
Received: by mail-il1-f193.google.com with SMTP id c4so1894691ilo.7
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 02:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Q14hg8Tfh5ESgRaNk1H3i7GYBKrpDZVQNAqVP91Pp4A=;
        b=I0yalaldtZ8cSSTfm8jfxTiPdqCXCyrQp/I7Pr/H7NxM3LkvfbnAgY/8mEweBh5PiX
         yT2mi/4NURRnjU6wFuz71ZrROeFazi9HGLh1fU/5sKNMztbVOQSb+Z3JoOmTMzIjUY0v
         +geZvebiRO2pD8Q+MRJ+SNPEBqP8ASWCqgGcPyrm26rBvDM38u6XAgttPSfnvdf+JkbB
         YhU1mg2jVz9eRn/bBgzYlPnowYjtUD8fu6lRyX/ZE8zAulq7bxQIzwzLQAt3RtebYHUb
         uEmi/5qSJ2laWUYrZOUOrXSgqa9amVKUO9t7InPmHgUSiWPxr8veESybwK6lSJmstf/B
         2jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Q14hg8Tfh5ESgRaNk1H3i7GYBKrpDZVQNAqVP91Pp4A=;
        b=DrjxpRNJ8+sOQiC9tIOXQSq1zQWWKOZGtjB7SGtB2ViUJwc3mOinXZwg/XwBFV+v0r
         0osBDypWN1Ve34wI1u7tfMIbHvhhut5yLu2zgNtMcShZN0g7LTpdnhcGqxKys29+uXFv
         TfhW3joEjHxhKSvAZNcnAYDwG5bg7gNgw0Y/OO9NpKbulIbZEy8JzzCsDDJHhE3fsVPY
         4SVKbNGN6fPV8Rydm8A7IScaSbc7Q66VuI//kR5P53VyydsONM8kjMGCMFK3oLtBlDHs
         jELiJ9EV+Ie2FxrxFmnAmo8a2cTmwmSHxRYQnZTj/pFIyxGKQ+iDUrWH2PHHyR7H98WS
         bJOw==
X-Gm-Message-State: APjAAAWMVv8YQTAnOmnRUNniaf5p0UJ7sJlX7b+LiCY9EAdOMEIKjk5l
        +wOuN863pqaoGxQpVZGjaXNEZQIVJCHO5wF7hG8=
X-Google-Smtp-Source: APXvYqwnnVqlnqjidaaC1q1dYjEPb59ZZOqCuNmghQIAYZ42vyYPY8I3BM8Oi6VpAYpbW5DCDVPhTaiFBJuBNna4WyQ=
X-Received: by 2002:a92:b06:: with SMTP id b6mr2787756ilf.127.1579600840285;
 Tue, 21 Jan 2020 02:00:40 -0800 (PST)
MIME-Version: 1.0
References: <20200120143800.900-1-mirucam@gmail.com> <20200120143800.900-11-mirucam@gmail.com>
 <nycvar.QRO.7.76.6.2001202321210.46@tvgsbejvaqbjf.bet> <CAP8UFD0TU9FQQfk6SgDtOi+_eDni0ZJf+Bw-uN_LzAdeVh3HvQ@mail.gmail.com>
In-Reply-To: <CAP8UFD0TU9FQQfk6SgDtOi+_eDni0ZJf+Bw-uN_LzAdeVh3HvQ@mail.gmail.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Tue, 21 Jan 2020 11:00:29 +0100
Message-ID: <CAN7CjDCXm9f9PV61uK_6aVrLSTGvxAiS_t607-JMLnDY5i9AxQ@mail.gmail.com>
Subject: Re: [PATCH 10/29] bisect: libify `handle_bad_merge_base` and its dependents
To:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

El mar., 21 ene. 2020 a las 8:05, Christian Couder
(<christian.couder@gmail.com>) escribi=C3=B3:
>
> On Mon, Jan 20, 2020 at 11:23 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Mon, 20 Jan 2020, Miriam Rubio wrote:
>
> > > @@ -777,14 +777,14 @@ static void handle_bad_merge_base(void)
> > >                               "between %s and [%s].\n"),
> > >                               bad_hex, term_bad, term_good, bad_hex, =
good_hex);
> > >               }
> > > -             exit(3);
> > > +             return -3;
> >
> > ... which is: what does `3` stand for?
>
> Maybe the question should have been answered by adding a comment to
> the previous patch that added the `exit(3)` statement.
>
> So yeah we could here add a separate patch that just adds such a comment.
>
> Or maybe we can add such a comment in this patch and say something
> like "while at it let's explain a bit the '3' error code" in the
> commit message.

I like most your first option because we explain the code in the patch
where it is added, but the second one is also ok for me :).
Thanks.
Best,
Miriam
