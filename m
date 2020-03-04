Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3640C3F2D1
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 03:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9438B20836
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 03:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cg1lU1oI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387560AbgCDDWt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 22:22:49 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40142 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387400AbgCDDWt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 22:22:49 -0500
Received: by mail-ed1-f68.google.com with SMTP id a13so515433edu.7
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 19:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ud+jpEEjRbMJ7j4XkNYmMmg3JAFoNo9kZge0yaUEuPI=;
        b=cg1lU1oI+yYZkgY+b0e0VoYVwmZiS245VWBr31EwS8X8OUs2Pd0fyUOX+FMkA+uoLi
         f4MAZIhmBfCR55lAfvuB65aVnBeWpTA8w0i1/GUa2sfH8mw5CBibX3m7OKQvXwbXfEt7
         Zvd1v0XI5TZwGf4xXmRccgPVGEyAcnvw5Ufes9bfswBPV5DV+/zedXBOY5BMznr0qz+m
         FnahKA5c+HrlHHwTWz130kVSEL8n0oR0H3s700XZZw550Q3HzNo8W0Y1J+Ct5XLOV/7T
         pywu9d6fqosCW8bSvVMDuMV+ViHBxc4eM988TSMATEdC/6euARw1cWBZTP6KpjaxxbkX
         52lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ud+jpEEjRbMJ7j4XkNYmMmg3JAFoNo9kZge0yaUEuPI=;
        b=mOuEFEicLM2OFqtddtRRvZhdGjSIv7Po+SBKqPJVPCn1krcrWkP7OOKcteuehY4XLE
         zFigty6fXqEZcdlcSYU6EkaSWydVi3urEFYYK7ZYi7G5kZ2crYJpbI6rLpi/mzfNNNA1
         bWm2JL6S224LyNivhleEbrJJhNElLotI8p9jty2iyVM/ZoCAo3GRUqs1stHFayzDCAkx
         e1LEQY67m5U/9biCzVtl9UIOVOhmPrX7fR2Ib6xYgbDL+7OOoXIVQTg6CHZ20GEPq9s9
         ucXM+DJBin0Qxn7ckoqUpC0Hi5PjN4fcwqTALRyBqlvPg0ejzbHXIKSqU7R7Dl4vQJoo
         QhNg==
X-Gm-Message-State: ANhLgQ06PG1W39md3IiJ9gVsahctLef3XJAwnFboy/skUS3w/9nQYvzM
        u+dKUblY6Eav9+sdMR2BySbwlv7LzGHCaKIzY34=
X-Google-Smtp-Source: ADFU+vuGOlCv6nNQwD1PKOU2NOM9vurhMttVsmkSIX3mWthHbV9QXt7u1AoHgQ5J/mB1TCnsULGJSMay15LHqyUwMjc=
X-Received: by 2002:a17:906:7fc9:: with SMTP id r9mr718438ejs.77.1583292167628;
 Tue, 03 Mar 2020 19:22:47 -0800 (PST)
MIME-Version: 1.0
References: <pull.548.v6.git.1582778112.gitgitgadget@gmail.com>
 <pull.548.v7.git.1583179320.gitgitgadget@gmail.com> <a4673803eaf881f7caa25d97e432c0ff0d065060.1583179320.git.gitgitgadget@gmail.com>
 <xmqqblpebhae.fsf@gitster-ct.c.googlers.com> <xmqqlfoha5ia.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlfoha5ia.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Wed, 4 Mar 2020 16:22:36 +1300
Message-ID: <CACg5j26fiJQJZ1CZy2AHWEiPmzJ+XsiA+Zfsp4Mc6MgP9i=Crg@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] advice: revamp advise API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 4, 2020 at 3:16 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >> +static struct {
> >> +    const char *key;
> >> +    int enabled;
> >> +} advice_setting[] = {
> >> +    [ADVICE_ADD_EMBEDDED_REPO]                      = { "addEmbeddedRepo", 1 },
> >
> > It would be nicer to future developers to flip the polarity, as we
> > do not have to write 1 all over the place, especially if we plan to
> > extend the structure over time and to use designated initializers
> > for only certain fields...
>
> Just to avoid needless churn, I think this does not matter in the
> longer term, so .enabled is OK as-is.  The reason I say so is
> because, even though renaming to .disabled to allow initializers to
> default it to 0 is nicer for those who write the initializers
> manually, and it especially is true when we have more fields in the
> struct (we may add descriptive text so that we can issue an on-line
> help, for example), but I expect that would happen much later than
> we start generating these parts of the source code in two places
> (the initializer for advice_setting[] and the advice_type enum) from
> a single source by mechanical process.  And the auto-generation will
> eliminate the burden of writing 1 manually.

Agree.

> Turning this into "break;" would make it similar to the loop before
> this one, and will allow other people to add more code after this
> loop later.

The loop with break is redundant and will be removed in the next
patch, but the rest of the loops in this function end with return
which I think makes more sense assuming any new code/loop that will
need to be added in the future is expected to handle a different
configuration group.

> > +     /*
> > +       Any advice type can be used for testing, but NESTED_TAG was selected
> > +       here and in t0018 where this command is being executed.
> > +      */
>
> Style (will fix up locally).
>
> Thanks.  I think this is reasonable with or without the suggested
> fixes.

Great, thanks.

Heba
