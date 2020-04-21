Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52549C54FC9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 18:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 254822068F
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 18:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxZofAT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgDUSog (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729144AbgDUSof (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 14:44:35 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE23C0610D5
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 11:44:35 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id c17so5455428uae.12
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 11:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AJU+Mm+yU5Dk5U/+rnLm9F3ReRPoBv6Pmy6JhxV/whg=;
        b=nxZofAT72+1RlAgvN79JYjRCsgj36YB62TRqz71cdKoDE8NZ603WiGyBkHx+/Vx064
         oaZOxskSm1g0IjUerVDeIAFL1bau9NUAPboCvNdz3DeBSaDpPcMTULKEjdIa+aY6YPSE
         J9qvhJ1xDT6tHRh5pY92jSbZrADR4v4zz//8N4DmYJVexW53wP5e7bD2oRyFdf5K/9KB
         kyxTxL2J/fuA5vXA+zzhoXNjF1KKIDzrHejEp7QFK5wTEXkEfMaySNwYOklvB0ie9xIo
         auFXBoB1IOaCbmBQlIazlOr2fqv8f28S6mkMn9k9XqQC138gkCcVew4VCXct/EG/yZIK
         42wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AJU+Mm+yU5Dk5U/+rnLm9F3ReRPoBv6Pmy6JhxV/whg=;
        b=qR48l8YZ7mjBbYANpzNaz9SIs73JXiUTxgEaxGielc20dV2VxMbPkM437lXCAk66Th
         sGRzFmltphblt3nnBiAa8pKVyyoX8L7g8AyKrxhXzBnE/9clz6HdUYOqs+l8LqvZ3kAN
         6uB3p1RXW9QH/EmMMHW9XCnWG3732UDitADUCmacGtF16a71k9sar384BjHbH4nv81RF
         3A0qv0zbM9rGIbjf/ZL8L0US52SLGXzM3yguFWGt7qAM9IuGFRb1P4Cc6Xxmio/mvjCS
         qzF3pPasCevzHylaLSF17LViDD8mdcg6z4mTjmHyOHp+Foa7bBVNugw738KnFJAcYVxS
         zqWA==
X-Gm-Message-State: AGi0PubTdwc7hMedbKNNAKCVMXgJRzfCdr4bk4ywu5TwcgQaIJTNAzbt
        k8tAz7v4R7nxQAu9T0jE3bUAdeIbrcEYLq+V7D8=
X-Google-Smtp-Source: APiQypJYvHOwUAGK33vYGOaSVkBkdNX/C9s30Dbu0VXl3r6K8idIRIMWB7wTF6qYRdC/PgjvR5ZYnC0KWkSuijcfk7c=
X-Received: by 2002:a9f:21eb:: with SMTP id 98mr13367111uac.62.1587494674468;
 Tue, 21 Apr 2020 11:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587240635.git.martin.agren@gmail.com> <cover.1587297254.git.martin.agren@gmail.com>
 <54e10bb06a39d23591ea4d02665083d705682468.1587297254.git.martin.agren@gmail.com>
 <xmqqd082rrns.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqd082rrns.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 21 Apr 2020 20:44:23 +0200
Message-ID: <CAN0heSrqDYrZnR8aGRksf4qLZE0YPgPYUbK4AFnnOX470M34Ow@mail.gmail.com>
Subject: Re: [PATCH 1/4] strbuf: fix doc for `strbuf_attach()`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 20 Apr 2020 at 19:30, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > The function handles reallocation and truncation, yet the docs say that
> > the "amount [of allocated memory] must be larger than the string length=
,
> > because the string you pass is supposed to be a NUL-terminated string".
>
> IOW, _attach() does not mind if the original lacks '\0' at the end.

Right, nor if it lacks the space for it.

> > diff --git a/strbuf.h b/strbuf.h
> > index ce8e49c0b2..2a462f70cc 100644
> > --- a/strbuf.h
> > +++ b/strbuf.h
> > @@ -112,10 +112,12 @@ char *strbuf_detach(struct strbuf *sb, size_t *sz=
);
> >  /**
> >   * Attach a string to a buffer. You should specify the string to attac=
h,
> >   * the current length of the string and the amount of allocated memory=
.
> > + * The amount must be at least as large as the string length. If the t=
wo
> > + * lengths are equal, reallocation will be handled as appropriate and =
in
> > + * any case, the string will be NUL-truncated as implied by `len`.
>
> NUL-truncated?  Ah, if mem and len are the same, the string is reallocate=
d
> to fit an extra byte to NUL-terminate, to make sure strlen(sb->buf)=3D=3D=
len
> holds.  Makes sense.

Exactly. NUL-terminated would be better. I think I'll split that last
sentence and replace it with something like the following:

  If the two lengths are equal, reallocation will be handled as
  needed. And regardless, the string will be NUL-terminated at `len`.

(One might still have strlen(sb->buf) < len though. This just guarantees
"<=3D")


Martin
