Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3744BC432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 19:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095FC2068F
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 19:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLgNyEYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfKUT6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 14:58:14 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42744 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKUT6N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 14:58:13 -0500
Received: by mail-pg1-f196.google.com with SMTP id q17so2141282pgt.9
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 11:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D3P6xQFJ9gC66aIfkIlVTD4VYtlchiLgNgLsppu07vg=;
        b=GLgNyEYRFCq4raWbpwl8MpduWlUqAjU43A+V37haW6B8jCRRFUKLeOKo3w8/mt876Z
         R/NPu7nTd2cYwCQEIeK1ZGM7MMc0lWE3IIE1aTLvJBbDlH9uRyPsKapaeFl7f4EqNp8+
         6KZ3xr1DdQX6fx60RSAv7bacbpuV/eieUXpReYaoVuHtn28C7fMs0w8AfmlPjyrw239S
         hGXpQIiqFeJlTwJ2cjBXGjRab4003ubcbxVTlaR5DoBghJlNDLbrI2cXb24P7xfCCbTd
         U7gk9KBjN9gosJ3ykjRzGEwyQ4egylxJ5o35WrQLYatjQVyI9Xm642uFAryXiRTmqims
         DqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D3P6xQFJ9gC66aIfkIlVTD4VYtlchiLgNgLsppu07vg=;
        b=Ics7z7w8oWo+Oir7CCoBjb08vKzZea84wUlRjG+bIVnB7BYr7LOl9+rwUGLD2ns7Kl
         aSIbEp4OY2E26xzIwU55zx2rKJL2KxFd1/N0B6/5yCYZJMtOUqCznD76BybitMzo+OCV
         sYM7izGXdugQN5f1Q9QslrzC5svFluEEdRBkfiB6aa2PGLXJtpXtd7ObJVXaP0ydBfSm
         OcRCAnIBKkW1WpKfQD51qA8BEH47iRlY4n8GWt9odLzlTJh68VQwdvYxnWpeL/VbJFn5
         oYrcvaxvaYIrScdHS3ujciOPaS0idkyDELyTnWQYWTZs0XqdhYDvlk8s8YebVHDvXwwN
         fytw==
X-Gm-Message-State: APjAAAWq876JTbuJHPI8m/9WyjDv+WibMuuaZOTGIOdxy9mhPlZNL20u
        wV7NEych/f5Pz8MYa/hxP1u9qEYCo7fbVkCBf+MPqQ==
X-Google-Smtp-Source: APXvYqxNUXtjApvg7vbBx3tFNrdVazFPlShYPq6J7+Dl0DYf434ES30lZK/HfxFDbFvtKTnY94w0oVxxSzg6ZwIW6G4=
X-Received: by 2002:a62:b509:: with SMTP id y9mr12519037pfe.12.1574366293099;
 Thu, 21 Nov 2019 11:58:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573670565.git.martin.agren@gmail.com> <0f48ab4fc344b3cc226d0a45d13530022208ff3e.1573670565.git.martin.agren@gmail.com>
 <xmqqpnhl943d.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnhl943d.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 21 Nov 2019 20:58:01 +0100
Message-ID: <CAN0heSpGYi7WWT+o+qvyPEaJpbVahGxNhx_2z9d=OF+V2wmzBw@mail.gmail.com>
Subject: Re: [PATCH 7/8] builtin/config: warn if "value_regex" doesn't
 canonicalize as boolean
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 21 Nov 2019 at 06:43, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > With `--type=3Dbool`, we try to canonicalize the "value_regex". If it
> > doesn't canonicalize, we continue and handle the "value_regex" as an
> > ordinary regex. This is deliberate -- we do not want to cause existing
> > scripts to fail.
> >
> > This does mean that users might be at risk of missing out on config
> > values depending on which representation they use in their config file:
> >
> >       $ git config foo.bar on
> >       $ git config foo.baz true
> >       $ git config --type=3Dbool --get-regex "foo\.*" tru
> >       foo.baz true
> >       $ # oops! missing foo.bar
> >
> > Let's start warning when the "value_regex" doesn't look like a boolean.
> > Document our intention of eventually requiring the canonicalization to
> > pass.
>
> While I actually think this warning is counter-productive, if we
> were to do so, value-regex given for a bool-or-int type should also
> be warned if it does not name a boolean value and is not an integer.

Ok, noted.

> With the way you laid out the "use enum to tell what kind of token
> value_regex argument has" pattern, I think support for "--type=3Dint"
> to normalize human-readable numbers would also fall out naturally,
> which is nice.

Well, that's what I was hoping for at least... ;-)


Martin
