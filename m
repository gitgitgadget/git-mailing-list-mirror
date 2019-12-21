Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D16C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 18:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A49820665
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 18:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onWoNS7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfLUSwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 13:52:13 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40445 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfLUSwM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 13:52:12 -0500
Received: by mail-ot1-f65.google.com with SMTP id w21so8655689otj.7
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 10:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxo32adcQJgGZlMVaUfbTYo5HQY8E0MtMOAo8B/J0kc=;
        b=onWoNS7djLMXFfsXKleprjEWGCKy7b2NQvwAVURdxjkAw52rm8hkSe3xa4hWH6mRq9
         7Ad1jOZvKJ/AwjQoDc6EqpKq6w/EBTC98QPSLy72natPX0UE7G23ZTrjKa/gek6IZQ3I
         Karn3Rk027/eXUrq3SwS3VDCvu485fXL+FLIcfnl0207GwgO6zCx2ZZ/pHA/dF1j35IM
         4V+plzITGynZB5mTV8E2BRcrtXsbi14Dfznz6oZ1tEEnX5AN7JOn8zH32hQLf8Tip699
         FCWotjUy3AM0MUO6pudxrmTCuJIVFS19KfbEXJg8WYzCcNVQHPzrP4G7yc8e02hL+GWP
         lSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxo32adcQJgGZlMVaUfbTYo5HQY8E0MtMOAo8B/J0kc=;
        b=L2t+hI+SsY0Ffyg/0rv9ZUgCtIoC9KTDG3Y/oZc/C7f/loxcQanRw14rR+dFWl8SSU
         ztMl/QbrqZ40/J/ZrmglgqWUOImZq184kIH9ZOCHVZPlFr4dEvWKPmvq8oV7lx0ITGwh
         qAjrKyZsxBPzKzhfG5IPJmsOoCcg75JZrekdiDb+qsuYg5ikTt/CpVqEb+8JfcAet42a
         rsJmEB8Wm23+OgF+1eyA4izssOKn9/SBPrq8a3h0Z3h1VLnhcbWqfRLvDXpY7+UBDQf7
         OCCNHoTj9mixktkQ1cpoUqCoJSzNqWthvheMaHVufpDsD21c3mM1Me4DgCQF0w3CeZV9
         W1rg==
X-Gm-Message-State: APjAAAVi+n02Av6Oh0ybnHbs4vL0fw3W+M4VZhUwNZEoX3VbKD4+Cr4m
        I6Jh34f2pigXCqBWnl4kWfLmCtJPLVcqRfKfpw1Mii+N
X-Google-Smtp-Source: APXvYqzXr5q7hBFGgqf415BUaSBCIskJVXVTzyaK3826r1+dQYJ6NQsKGgc/+hhBVxibKkLx/KHFlWoe3QdkkbMJAjo=
X-Received: by 2002:a05:6830:158:: with SMTP id j24mr22804081otp.316.1576954331881;
 Sat, 21 Dec 2019 10:52:11 -0800 (PST)
MIME-Version: 1.0
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
 <13e2056e780b00baf86d4020c0974b6b05ce115b.1576861788.git.gitgitgadget@gmail.com>
 <xmqqimma8z3t.fsf@gitster-ct.c.googlers.com> <CABPp-BF5MaO60GAXbqYPfEePKyn_K-B_hQXNvTN_L4S6iA_93w@mail.gmail.com>
In-Reply-To: <CABPp-BF5MaO60GAXbqYPfEePKyn_K-B_hQXNvTN_L4S6iA_93w@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 21 Dec 2019 10:52:01 -0800
Message-ID: <CABPp-BHZ4nYaAN237w70cen=P0M3-TsWQz_+BeU_VtYEbRCbAQ@mail.gmail.com>
Subject: Re: [PATCH 01/15] rebase: extend the options for handling of empty commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>,
        Pavel Roskin <plroskin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 20, 2019 at 4:32 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Fri, Dec 20, 2019 at 1:29 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >

> > > +static long parse_empty_value(const char *value)
> > > +{
> > > +     if (!value)
> > > +             return EMPTY_UNSPECIFIED;
> > > +     else if (!strcasecmp(value, "drop"))
> > > +             return EMPTY_DROP;
> > > +     else if (!strcasecmp(value, "keep"))
> > > +             return EMPTY_KEEP;
> > > +     else if (!strcasecmp(value, "ask"))
> > > +             return EMPTY_ASK;
> >
> > Not an error but just silently ignored?
>
> Oops, I'll switch it to an error.

By the way, diff.c's parse_algorithm_value() and
diff_opt_diff_algorithm() behave the same way, where
parse_algorithm_value() will return a negative value if it's not one
of the valid known cases, and diff_opt_diff_algorithm() checks for
negative and throws an error.  Should I also modify those to put the
error in parse_algorithm_value()?  (Not part of this series, but as a
consistency cleanup since it clearly surprised you and even I forgot
that I had the calling function returning the error when I copied that
style?)
