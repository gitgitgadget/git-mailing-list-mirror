Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C87C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 19:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93461214AF
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 19:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+BVR63N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgBETrk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 14:47:40 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53631 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgBETrk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 14:47:40 -0500
Received: by mail-pj1-f67.google.com with SMTP id n96so1423281pjc.3
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 11:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L2chZHYueTGoYX5ZvoLup/1Sl/upo5wdfZicL0heVJg=;
        b=r+BVR63N2Pg1CO/Tw65riCXg22xY1F2J/EH7oL13LGz2GuVBBvg74sulpSyalSgsfm
         /U1FTygdRSGh2kADFCPbaVrvH/yZ2iwDTNIE396iiWo/0+1v4TItsWor/tFdrv5OluKn
         6mDA5SQQAxmWFfACVCoDFYXxXLs/deseCQxzPNJyWhhIT6VbPav1aQIChVISfB4hLx2+
         H5YxdWqiNbmi0YoqGMHzxYnQL0fz1rcEdSirc3opQpQbua5u04jHlZ006xqYu/tna0kC
         0xrBqmeN702FUsf3NUhv/VGt5lkPh9ydOu4/RW+hWXIhefpDRY+7aqrOiV86hHTxZ7aD
         B74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L2chZHYueTGoYX5ZvoLup/1Sl/upo5wdfZicL0heVJg=;
        b=G6aIZaWCCLZO08NqxkdVxerCGnlYlU/4PQbYIZJSN+Joq8z+g/Ly5Vg9VbkghXeXDs
         rV7j0JlYK2sPq5E0zWJ4KifiqFyb3AitD+qZYVCNgoyJEHd+zdwy7hmDxH4o6jz0elqE
         lcS9nMUL86j8Q7bB+mt0z+W9H9NCOT8ur1NS8X9PB3IT2Pb57Xrp0hrvxTsUMDHumyqn
         4BYy9HxnGb+w8cSLSBcdnar1HAs0nXyI869MMr+Dmd+6TZBiTUiAskc1ANYgb3hlSnL6
         zunBCtPqth0s9qLV9S79/jLJqV2guGvG3wZ0AHR1ZTvch/quOzWszaA0IukJCCemxEqo
         23ow==
X-Gm-Message-State: APjAAAUjVCAUweAE9qEOucFyZDLqJScKuuXxI/V6gmriSb5Lhh+ejGmX
        E/QB4py6vnTygMzbz6ddeiWrM00LQcSAdVKj164stA==
X-Google-Smtp-Source: APXvYqyU1XXsaNcAvwcHb/FL1I7upZySDxTGnqrDjZ8MY3rdqi4F0cFRWplLjytz1EoP+iNj6Z8Q/MijaJvVyuYicho=
X-Received: by 2002:a17:902:8341:: with SMTP id z1mr35686747pln.178.1580932059760;
 Wed, 05 Feb 2020 11:47:39 -0800 (PST)
MIME-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com>
 <20200124033436.81097-7-emilyshaffer@google.com> <CAN0heSoh87_16y+B5=UXAhbaVnejmRj3XXjy5viABheBz+D3fA@mail.gmail.com>
 <20200204225118.GE87163@google.com>
In-Reply-To: <20200204225118.GE87163@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 5 Feb 2020 20:47:28 +0100
Message-ID: <CAN0heSpe8L6v+z49PixRwyYrCncS6CjdJAJVKaS+L5NkOPNgTg@mail.gmail.com>
Subject: Re: [PATCH v5 06/15] bugreport: add compiler info
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 4 Feb 2020 at 23:51, Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Thu, Jan 30, 2020 at 11:21:39PM +0100, Martin =C3=85gren wrote:
> > On Fri, 24 Jan 2020 at 04:40, <emilyshaffer@google.com> wrote:
> > > +#else
> > > +
> > > +static inline void get_compiler_info(struct strbuf *info)
> > > +{
> > > +       strbuf_addstr(info, "get_compiler_info() not implemented");
> >
> > Maybe "no compiler info available" (or s/ available//, or
> > s/available/reported/), or something else more human-readable?
>
> Hm. I envisioned the target audience for this as "Git developers" (and
> that's why I didn't mark the unimplemented string for translation); Git
> developers know exactly what "get_compiler_info() not implemented"
> means. But I suppose it's just as easy to grep for one string as the
> other.
>
> I am hesitant to say "no info available" or "no info reported" when I'm
> certain there is some environment variable set at build time which
> contains the info we'd want to show here; it really is just a question
> of some Git developer having put in the time to implement this function.
>
> So, I think I will leave it. Thanks for your suggestions.

Ok, that makes sense.

Martin
