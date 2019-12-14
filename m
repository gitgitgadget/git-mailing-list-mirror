Return-Path: <SRS0=+pXB=2E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D65C43603
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 08:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDB424656
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 08:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B95n2gDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbfLNIJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Dec 2019 03:09:17 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41419 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfLNIJR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Dec 2019 03:09:17 -0500
Received: by mail-io1-f68.google.com with SMTP id c16so2018588ioo.8
        for <git@vger.kernel.org>; Sat, 14 Dec 2019 00:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8pLwwiB9JG2fd+0qLHQJl1B/7k+mbRsj26okeIRfoIk=;
        b=B95n2gDVOu3tn30Sjg+dgjN95NVzjvo4tn7KZkDUudN6upFAg3Yz5Z2jg/MECL5yN8
         pF+byeFgxqwTk0EcAlxq72WtEFW0YAltdZBCfoMHtGRWbKsX4Y3csADTJOjkVog7nKzh
         4cKyjVpZcjR2v3HWUV6MwoPZREfEvvYAEBEjUHo8K74TBjwjwzkP/Il0/3XZi56xixnv
         s6XcDdUVXgIZXHfeqBJ9cIHB9b+9oA1t73NL2G8RlDFuds4c++Nw+RUjBUO4fccDx211
         d2+wA+x8enZI9X+PEqKbvzxZaOM6E0aDMHzMq7uRPm85zc6b15/UlvspHOwp/O7u3Dc+
         fwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8pLwwiB9JG2fd+0qLHQJl1B/7k+mbRsj26okeIRfoIk=;
        b=qttzPhqM1HMOj7bI2jzt3zZVlv8Ul0QJ3Xt626BuaAA3/KvWjN/hIjG+VL3qseHs8O
         OSljxasIhQoPQvlhIU50LV9a7AH849wIMkyQGbvI3mAwQX4fIJrs1hkrm9L7VhBergIh
         bBwdluJSoCXqyXed55PD8y+nQjFsx3dJ9fcCUKFEa6hZvOCeTlVb5SOkC3LwsPjvkO4/
         7Q85jG03OZZWKYgA9vl2DL01Qa4MQU3HtRqfDEi8ybpkfYQiXyhscVIYBZ72zu0z6ZQL
         N+wWSVNsd6IK2rGxsB+P6KbW/pvRydAxQZbFZU4S0lShzNxgnC3+GgHSBCrIsNT5T9kC
         CNcQ==
X-Gm-Message-State: APjAAAW/OqEYxbeahf580g8ZD2ikvgAGqe1nSXvGyPQuCkAETxaMxALY
        dBMpTjNtJeW/rhoRMe7+Gbs9TBElJVZaxs3fz48=
X-Google-Smtp-Source: APXvYqxn7ksH6Z//kDrzNq0yCrGthYPRIm1/TwUMmdyJOuIL+/NTXJtaYyohCQgRBDcydUMzMfMeFgS0zLNhR2ZtqWo=
X-Received: by 2002:a6b:ed17:: with SMTP id n23mr9720810iog.99.1576310956907;
 Sat, 14 Dec 2019 00:09:16 -0800 (PST)
MIME-Version: 1.0
References: <20191213115225.13291-1-mirucam@gmail.com> <xmqqblscj8w9.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqblscj8w9.fsf@gitster-ct.c.googlers.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Sat, 14 Dec 2019 09:09:06 +0100
Message-ID: <CAN7CjDAvb0kL6tTO6UWahGDojGq_BYnTcxpBK1o7HKUi4m+JNQ@mail.gmail.com>
Subject: Re: [Outreachy] [PATCH] bisect--helper: convert `*_warning` char
 pointers to char arrays.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

El vie., 13 dic. 2019 a las 20:57, Junio C Hamano
(<gitster@pobox.com>) escribi=C3=B3:
>
> Miriam Rubio <mirucam@gmail.com> writes:
>
> > From: Tanushree Tumane <tanushreetumane@gmail.com>
> >
> > A char array creates a character array. Its size is the number
> > of elements plus one (compiler automatically adds '\0').
> > A char pointer creates a char array and a pointer to that char
> > array that means four extra for bytes for the pointer variable.
>
> This depends on the word size of your pointer and many people have
> 8-byte pointers these days.  Just say
>
>         Instead of using a pointer that points at a constant string,
>         just give name directly to the constant string; this way, we
>         do not have to allocate a pointer variable in addition to
>         the string we want to use.
>
> or something.

Ok, thank you, Junio. I'll send another version with the changes.

>
> > Let's convert `need_bad_and_good_revision_warning` and
> > `need_bisect_start_warning` char pointers to char arrays.
> >
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> > Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> > ---
> > This patch is a new version of:
> > https://public-inbox.org/git/cadc46442d5c960caa58227092289fa2f44fb96f.1=
551003074.git.gitgitgadget@gmail.com/
> > sent previously by Tanushree.
> >
> >  builtin/bisect--helper.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> > index 3055b2bb50..1718df7f09 100644
> > --- a/builtin/bisect--helper.c
> > +++ b/builtin/bisect--helper.c
> > @@ -282,11 +282,11 @@ static int mark_good(const char *refname, const s=
truct object_id *oid,
> >       return 1;
> >  }
> >
> > -static const char *need_bad_and_good_revision_warning =3D
> > +static const char need_bad_and_good_revision_warning[] =3D
> >       N_("You need to give me at least one %s and %s revision.\n"
> >          "You can use \"git bisect %s\" and \"git bisect %s\" for that.=
");
> >
> > -static const char *need_bisect_start_warning =3D
> > +static const char need_bisect_start_warning[] =3D
> >       N_("You need to start by \"git bisect start\".\n"
> >          "You then need to give me at least one %s and %s revision.\n"
> >          "You can use \"git bisect %s\" and \"git bisect %s\" for that.=
");
