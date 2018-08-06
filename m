Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64CB9208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 17:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733034AbeHFT4y (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 15:56:54 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:42983 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbeHFT4x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 15:56:53 -0400
Received: by mail-io0-f181.google.com with SMTP id n18-v6so2207900ioa.9
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 10:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Df2a5uGI44ya248ElEb/5Ui9ip/3nq0/oIy5VqWxolI=;
        b=rk1evGwCNTBs1gnxGWssip/u+WEd4S/hSjykg8nIRDKTO77VcPFiQMiN1DD9UtcLtu
         33mmubUme7BUkqEYnTv9CKfAH+/3EJaf4F8xuqGfM0By+vyvXUxxC9Fuy60+LqpJi0B3
         utxCz5a9BVv886psfN0s5pDMqgZrsLXfi/M58SIF+XBtBCG0NAKcDEL6yaYFs6F0oCTF
         ZyZx5rxITedjwleL8PF2PMkZk96OudwQX+LvO4bCcPbzm7rZocUp/OpbGT2ebydOHFBw
         ddXkY5qh8HvZx+yjC2moK5T4dWceDJUbzq0ZAQW1pqPPpv5SO3zN0NFzQ1Uv+6gTtZha
         3y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Df2a5uGI44ya248ElEb/5Ui9ip/3nq0/oIy5VqWxolI=;
        b=gvYSuA3qUOp6ITW6xW350BZyXNrF3C7w7cDy6Ix7aaK1nhDlnu9DKB7P2eUChjlCw2
         Cc8Dgp+4rwHaJ6+j1uT2rKzovkZatwTJHdUiUorDrNEgpfW9FjxKBY7rZl6cS+pKUE5V
         NHr6Iz4XV/5/SQ0CemUuNRFRBSZ3rdV2Pkg7sUan2p7J8oBqfNC+BPyyMGMGL1jCWSCl
         IR6f2UXYBH64cz5GBnenGR6+JYFWpMA1MKAx9xEq2+mIHKLxKuDg/3UeFWa7qUJ1/zPE
         dOeiBxkt7wNI+2hX3W0yNn4BsIRjnnLxIdQf1iHtRfR7i/N7TcVkAm9+aJP+P1a0EfGa
         Z5uQ==
X-Gm-Message-State: AOUpUlEb9gScO8n2e0v0s/LEmqNK/7GmWHblEnfANVf4BtIBhhhAM5W6
        bJ3UJ09gbJkz0tmhKpFkfhXg2+vZJVdDCbTkrU2ykw==
X-Google-Smtp-Source: AA+uWPy/3ZKtX0Ghiw2SOUPWCBQmnO9khBT523YsLVapCSoGhYjyfs3782JFWouoVjO9YZxM1/cK++5kBjHgg6WID0o=
X-Received: by 2002:a6b:db01:: with SMTP id t1-v6mr15776102ioc.114.1533577604170;
 Mon, 06 Aug 2018 10:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180806143313.104495-1-hanwen@google.com> <20180806143313.104495-3-hanwen@google.com>
 <xmqqbmafpg14.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqbmafpg14.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 6 Aug 2018 19:46:32 +0200
Message-ID: <CAFQ2z_PX+H=Pa-0Uzuc7_YYze6D4_zqL0Bjuof2wev5h1=c-9Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] sideband: highlight keywords in remote sideband output
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrn@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 6, 2018 at 7:21 PM Junio C Hamano <gitster@pobox.com> wrote:
> > +     If set, keywords at the start of the line are highlighted. The
> > +     keywords are "error", "warning", "hint" and "success", and are
> > +     matched case-insensitively. Maybe set to `always`, `false` (or
> > +     `never`) or `auto` (or `true`). If unset, then the value of
> > +     `color.ui` is used (`auto` by default).
>
> Reads much better.
>
> I am still trying to find a concise way to help readers who saw a
> line that begins with "Warnings: foo bar bla" and accept that it is
> OK the early 7 chars are not painted.  "... case-insensitively and
> honoring word boundary" is the best I came up so far, but  I am
> afraid that is adding more words without hinting what I want to convey
> strongly enough, so I am not going to suggest that (at least not yet).
>

what do you think of the idea of requiring a colon explicitly? That
would avoid spurious highlighting in case a keyword happens to be
wrapped onto a line start.

--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
