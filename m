Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9FDC433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AEA622C7C
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgLDXhM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgLDXhM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 18:37:12 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97D9C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 15:36:40 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id x22so6743736wmc.5
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 15:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PKJT9EJg3ZSUR06G3f2R3wxfN6crl60TxaswRldJ0NI=;
        b=bu9rW+YTlbEph/RmDOWqxuEp44iKgBkkOTX96+PYAjurh+nMyKqqImdAcsSjyYgLBI
         JtWIQdmojev6x2X+WGooEGvhN5HE+lVpE2mNBfxBlKetPvqlqtB308ffGYK906FDQdOU
         l/jFQRQ3TxZ4QajQJ4MlAw5HSkbZSVf83Q3o077dyp/rYlY4A8jQzzPwa6luUWVP+iOy
         /aIBymofoaOVsAAI+WFVfZgGbPG2ntU0F1sg+YE/Iq8xlQllp5aIT/sKDyh0T5WaOxo/
         +vs0NA9NeQT02AqcRI8nX5kFdNlslnz1IZ3bhkQPm+8D6N3zLUtHcjwTJEUEgDp37m7n
         0ufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PKJT9EJg3ZSUR06G3f2R3wxfN6crl60TxaswRldJ0NI=;
        b=mHEZKDcbpUYiRCN6AxRxsoqhmE+IXqhpJ7+cICga4JsPHn43aE+qGQm/5FNkhUukjf
         hSewduACz01gQsCj2SsLxQQmt+gYJl8yrlTLJOPgL0RMO7BKzg/TEGqY68OIPCzqBZmA
         MQKUeilWplPI4B+4VTHQAq9U1OUZWpYQkBgf9mAnOKIB6fp4hIoqWNG5IRf6bSiRuXch
         /LDWX723esZLeAiJpY/esoqinV+SmraD92KcGNsmapi+SzkdmnA8Bq0LHjLIYPPHVf+M
         /vfK1EFVvxBfpLViEOJRcQD50d7i/uNUpIkvkM/l4FSJ04msiX8JHxSO3jTSehVCy5kY
         wlog==
X-Gm-Message-State: AOAM53224NzNo1pqz3X7OWQ06p4yGeffipoBg8xqZTLDGUShUcvKgc6K
        DBY+FgWgY+vImio94bsyPyopUwNH9tBQK08XDzn93YiD1kEC9A==
X-Google-Smtp-Source: ABdhPJxJgc0p/9QPGfDl1s8xsH6vN6z+TZgsHroqu4/TDMSZpzLUMUmNNaifM2kzHN/UgftkqCZuocPBP1Zb9esnHkk=
X-Received: by 2002:a1c:f619:: with SMTP id w25mr6547513wmc.55.1607124999469;
 Fri, 04 Dec 2020 15:36:39 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-7-felipe.contreras@gmail.com> <CABPp-BHH0baiECvtvVOoHR82upJ1C+0hy-ukS9Hi2ZFHh19nOg@mail.gmail.com>
In-Reply-To: <CABPp-BHH0baiECvtvVOoHR82upJ1C+0hy-ukS9Hi2ZFHh19nOg@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 4 Dec 2020 17:36:28 -0600
Message-ID: <CAMP44s2T4HSVAwx6D3sO5c8b_tSKT174eASTjmb61kKmm=JcwQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] pull: move default warning
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 5:18 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Dec 3, 2020 at 10:16 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Up to the point where can check if we can fast-forward or not.
>
> Seem to be missing some subjects in that sentence.  ;-)  Perhaps:
>
> Move the default warning to the point where we can check if we can
> fast-forward or not.

Yes, I missed a "we".

I usually continue what I said in the subject, but lately while
reviewing my own patches in lore.kernel.org I've found it hard to
understand the first paragraph since it's not easy to find the
subject.

Maybe I should stop doing that.

> > No functional changes.
>
> You didn't explain the reasoning for the change here, though I suspect
> it makes it easier to change the default to ff-only later.

Right, I noticed that after the nth time I reviewed the series.

It's not actually to change the default to ff-only, it's mainly to
display the annoying warning only when a non-fast-forward pull is
being attempted.

I'll add that to the commit message.

> However,
> looking over the patch and pulling up the code, I actually find it
> pretty odd that this warning was in a function named
> config_get_rebase().  The warning is not rebase-specific, and so
> clearly does not belong there.  And for such a function name, the only
> kinds of warnings I'd expect are ones where the user configured some
> option but set it to a value that cannot make sense.  So it all around
> seems like the wrong place to me, and I find your patch to be a good
> cleanup.  It would benefit from a slightly improved commit message
> though.  :-)

Indeed. The only reason it's there is that it's the only place we know
the user has not done either --rebase, or --merge (--no-rebase), or
the config equivalents.

I fixed that by introducing a default_mode flag, but in other patch
series I replace default_mode with a check for REBASE_DEFAULT (which
doesn't exist yet).

Cheers.

-- 
Felipe Contreras
