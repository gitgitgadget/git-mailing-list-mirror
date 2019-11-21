Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D66C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 19:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621E82068E
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 19:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYEr1scw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfKUTxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 14:53:13 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41534 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUTxN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 14:53:13 -0500
Received: by mail-pl1-f195.google.com with SMTP id t8so1976953plr.8
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 11:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s5le58fg6Ft+8ldYcbiRZtX8hxlctkKrPvDPTNyQcsE=;
        b=EYEr1scw+TQxPmLsigA4Gk5UEnYVCcZ/6UnEavmFFeQLIpLoHY01TSR4Q2KxvOVUDX
         /RvxlVb94xn8sqG1NqGybSNVDEH5JS+1skYfztphl4xT/z+FXrtSTqk3XEFvTkLI0T7A
         XagF3IP6hG4eQyMIYmsMnoFUVw0ROulZerkon0T5TTfGzVRtFZ6LiCpK88pVeSM5Lgdz
         cYI5CmOcc31OFz6g33GXnl907EBFFKR5sgVrgkJ7ECTnLTT/tgh3mT4c8+Av09Ny+DKT
         eE4AFnBpYX3+AlpmXFx+ldky51BmaMO6i0N8HgbCJYEmdYTIV/O2kTbDJKMgM+F70+w1
         mG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s5le58fg6Ft+8ldYcbiRZtX8hxlctkKrPvDPTNyQcsE=;
        b=JpjWCccRrw9FAz0ucEwRXntdoU0JTpzq0VikF3jpR7j1L/qdZ/alr+pGl7B6mWOjis
         aICsv+98ahWvGiYyJCNuVexWgYsNCJFruTIoVOyUn+9TFID1uKBtzpi+NytNBYFN33qw
         d/fGrevsY2o+56sLgTYiD1bGXX6amzTFH79XqA+DHrNhi54j3kFhIXIeTHEapkcHdSQm
         /QZZy/DaT9cjhc+FXW00oWK99i5j++X+l81nCOmZVWt3zBiIia4kMrKF+heq/byI/Z9W
         wNlhNauYpWaJFqy3Wa6B5yfnE4yts3x/0ETBAHkHMLm1xYlfAd2IXlQBxucns0Far04O
         wq0A==
X-Gm-Message-State: APjAAAX5C88QVofBs3t1GUY0VV1/cZoWHcyHa2wIZbvRQGZJrpj6JMJ+
        RKw7f+hEnuL8Bvw+x7HxVs2hn2wlFYydIx1eqZUw3g==
X-Google-Smtp-Source: APXvYqwhDpc0dM6ZbV+Sgv/eEqR8PiCNq3mRNPs2jRhkg6kM3AaN4t3ytmuziRCWmnEd2zeclfxguKakqJY6bw/Es7U=
X-Received: by 2002:a17:90b:3007:: with SMTP id hg7mr14163897pjb.73.1574365992578;
 Thu, 21 Nov 2019 11:53:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573670565.git.martin.agren@gmail.com> <c4bcb32299291549d82c0544937a647c5000ad64.1573670565.git.martin.agren@gmail.com>
 <xmqq4kyxakjs.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4kyxakjs.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 21 Nov 2019 20:53:01 +0100
Message-ID: <CAN0heSrn07_dSTFB3ru3UZ14rxZvRD0mEAh5AMBFEDMgLKFLtA@mail.gmail.com>
Subject: Re: [PATCH 3/8] builtin/config: extract `handle_value_regex()` from `get_value()`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 21 Nov 2019 at 06:02, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > This is a self-contained and fairly large chunk of code which will soon
> > gain a few more lines. Prepare by extracting it into a separate
> > function.
> >
> > This whole chunk is wrapped in "if (regex_)" -- rewrite it into an earl=
y
> > return path in the new helper function to reduce indentation.
>
> It is not clear if regexp were cleared to NULL when !regex_ in the
> original code, so if that were the case, this refactoring is a
> worthy clean-up from that point of view, too.

Hmmm, this is something I added which makes it not a true refactoring
as such. I don't even recall doing this, but it does make sure we always
set this pointer to something sane. If we've already initialized this,
we'll risk leaking, but that should be better than running amok due to
bailing out early here and leaving the pointer pointing "somewhere".

That said, this is the only function where we set this, and we're
calling this function at most once (directly from `cmd_config()`),
so right now this NULL assignment is a no-op.

> > Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> > ---
> >  I copy the "xmalloc(sizeof(regex_t))" anti-pattern verbatim. We will
> >  lose it in the next patch.
>
> It also spreads the use of file-scope global variables like
> do_not_match and regexp, which also is existing anti-pattern that we
> may want to fix by enclosing them in a struct and pass a pointer to
> it around the callchain.  We can clean it up later.

Right, in the next patch I collect them into a struct, but leave it
file-scope global. I didn't feel good adding another such global later
in the series, so decided to take a smallish step towards the end goal
you outline...


Martin
