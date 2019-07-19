Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B42F61F461
	for <e@80x24.org>; Fri, 19 Jul 2019 18:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfGSSNM (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 14:13:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38237 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbfGSSNL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 14:13:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id g17so33128320wrr.5
        for <git@vger.kernel.org>; Fri, 19 Jul 2019 11:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=55Q0RvMvo/wSdxvbqeFct2ST9k/Bv61kKDKCJk3jREY=;
        b=ctwu3Zmi3as33RwTr4O/QoTD3mXW4EwTCnT7W8BuPmTh6ZoagkxChZW7jpcI5LVudk
         e1qnBN+J2FJXve7r83k8xCxHbYJupA09I9DPukJVqX1D9olD/fUWGHyDb8TujAFe89eZ
         v3fmutiPYKhtKdd7ZlBfEzXiQVL8GsrbIEUgb+riSJJEVu5tflPbs6P90Vn0OZWq8B73
         aa18xNAlMrG4Le8+TnqSWF9XIx3Jcn4JeLMHPj21+LQDtz0bWmu+G5B6pvraJDd6yDgy
         u42c6/OVNJH/gaaFSDOdO9dAm8frkRkD2wA9YGWTVK44SAkdlArqYBLvOUoj9Q1VQ1LP
         NTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=55Q0RvMvo/wSdxvbqeFct2ST9k/Bv61kKDKCJk3jREY=;
        b=BF3nLhvg6TKJxihLpbxXK1BWK3n3IYWOCVNe+LKu2Wq0XF13OOkOdEEpDbGk57hrSM
         OujuRVhFjQCevwOPt+WZwW5Tis1Gzqg4ihacQY9XVmVXCBcYPD+oRMZ5bMqjSFv12IMK
         R+WYNyu/nC4Vr31YiqFHc7eLYMivYgxo2/7Q688udWwL1sIIXZDpDJtlM1popETVOS+z
         4F8xWPKClwwbZ5G5YulHY+F6oen/fEnKKa09DfC7raz09lYu+3XB6XNQafuL4WSLb6ES
         iW4TVCxyNqgXDZ1lBOsyvBNkveUyPnXtGz4qzt6CWNgGl51+WUyKc6WUaYvAQIfjj6UU
         9bzA==
X-Gm-Message-State: APjAAAWlTr5tq77I00Uj03LH1Ome5MV/yu0Lu9y/MqFLow+icRddB15W
        ha1Z4XE4yeHeywm6F/nRxIg=
X-Google-Smtp-Source: APXvYqxBgzFVkJjb6ltBh6DpFg9Ds6WQpTXcxRG9ta+v8cOmW81/gru26z3uPzZAkQfdy0vl5OTnWw==
X-Received: by 2002:adf:e708:: with SMTP id c8mr46940014wrm.25.1563559989615;
        Fri, 19 Jul 2019 11:13:09 -0700 (PDT)
Received: from andromeda.localnet ([80.214.30.27])
        by smtp.gmail.com with ESMTPSA id x83sm31878209wmb.42.2019.07.19.11.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jul 2019 11:13:09 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 3/9] sequencer: update `total_nr' when adding an item to a todo list
Date:   Fri, 19 Jul 2019 20:12:48 +0200
Message-ID: <7495472.JabEqZW8b6@andromeda>
In-Reply-To: <xmqqsgr3xgr6.fsf@gitster-ct.c.googlers.com>
References: <20190717143918.7406-1-alban.gruin@gmail.com> <20190717143918.7406-4-alban.gruin@gmail.com> <xmqqsgr3xgr6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Le 18/07/2019 =C3=A0 21:52, Junio C Hamano a =C3=A9crit :
> Alban Gruin <alban.gruin@gmail.com> writes:
> > `total_nr' is the total amount of items, done and toto, that are in a
>=20
> "amount" -> "number" perhaps.  Also s/toto/todo/ perhaps but I am
> not sure what you wanted to say here, so...
>=20

`total_nr' is the number of commands, whether they have been executed or no=
t. =20
It=E2=80=99s used to show the progression of the rebase.

> > todo list.  But unlike `nr', it was not updated when an item was
> > appended to the list.
>=20
> Good finding.
>=20
> > Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> > ---
> >=20
> >  sequencer.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/sequencer.c b/sequencer.c
> > index cf262701e8..e61ae75451 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -2070,6 +2070,7 @@ void todo_list_release(struct todo_list *todo_lis=
t)
> >=20
> >  static struct todo_item *append_new_todo(struct todo_list *todo_list)
> >  {
> > =20
> >  	ALLOC_GROW(todo_list->items, todo_list->nr + 1, todo_list->alloc);
> >=20
> > +	++todo_list->total_nr;
>=20
> When we do not use the value in an expression, we prefer post
> increment, not pre increment.
>=20
> >  	return todo_list->items + todo_list->nr++;
> > =20
> >  }




