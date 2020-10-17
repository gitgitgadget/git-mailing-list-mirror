Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4DAC43457
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 23:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F2C208B6
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 23:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6WnBFdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439913AbgJQXfT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 19:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439872AbgJQXfT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 19:35:19 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB232C061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 16:35:33 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m11so6639778otk.13
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 16:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bWV+72AFF/oal47B1wXDjqoIMdi8lLGXclzge5h26dI=;
        b=h6WnBFdSFLeTVBfXS79NsPWfnscUje6DC8wEVDztNo60k7ZVcVctR3RpivqVTYuRyh
         EZAy7vX6rAi6uR5ie6nOrCqtNMA7ehdBHgeexiimQTL7gZtv6NYETc22qcXD3XV9JM0m
         zAxo7LsxwGSZyIcMDv6SbnwtoBpGyYXno67GYSIhYKDoAWDPwgnLP2NJGblSNA6KLKjX
         e+wIoaTay0r8bm0eBLIELZd7pAiJ3rHug83VEyGt9ZDnCPdEe7lnWHUOFFbXqf0WRrx7
         u/Nourv1Zl/IjYyTEf+4V7CgIq301Bc77VLu6H+QYeib3uZb+5R4QCwR8d04TLaPT4bo
         ZEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWV+72AFF/oal47B1wXDjqoIMdi8lLGXclzge5h26dI=;
        b=VGDAY+doWpOWeq5RcYfcCgO/QlqFhvxrBYvk2wtwpbGs264ND1ib1V0szj/U/zHsKc
         cgvn6FYmSvYwlqAL/EcKSvoKnMbuSUO/rGsa3kGPtlPRPsFNsoGSNRYZDwX6scNKrTkq
         b8Trokp30ClZt6c2PCERw9pT1e9VvUnZ8XgJtcAqc+KDqii4G1dGHxuMC4SAEi96XqP4
         AzqkuyemzNqyGm6iJzU1pFof2DkrPDvV9n5PxoTboP53B+AMlDr4/9WM84/YGMvCFQYP
         fwlGo22GxUC7ccnSHRpzj6TKQ4w/+hI+aX9BMkW61QjIBw/efugJ2C5wT6iAeB2NmrO8
         JAJg==
X-Gm-Message-State: AOAM533RSO57vV0Hp2rbIaY8Wc8UvPIrG7kqGWOCluFOApzDFQH7DabH
        LveEQMq63fVg6qgznbMuSXlxZDVWAW0O0QDOOcihM6ZtNCqKug==
X-Google-Smtp-Source: ABdhPJxz4nyHTVQmt9Omj71mNepaqRjLk0EBooJskPn0sYEvdpzSZhfCYRKoOrNFK2eYi9jnEwCIRNsxGoyI5ddUPag=
X-Received: by 2002:a9d:6e96:: with SMTP id a22mr7852263otr.345.1602977730591;
 Sat, 17 Oct 2020 16:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.884.git.git.1602891594738.gitgitgadget@gmail.com> <xmqqr1px90u8.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1px90u8.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 17 Oct 2020 16:35:19 -0700
Message-ID: <CABPp-BHeoAHjmgxY6N1M57qH6Xx4P+8aaxn20y4ZRWSd7hj5DQ@mail.gmail.com>
Subject: Re: [PATCH] t7518: fix flaky grep invocation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 16, 2020 at 5:02 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > output, but on one automatic CI run I observed the following output:
> >
> > fatal: empty ident name (for <runner@fv-az128-670.gcliasfzo2nullsdbrimjtbyhg.cx.internal.cloudapp.net>) not allowed
> >
> > Note that 'null' appears as a substring of the domain name, found
> > within 'gcliasfzo2nullsdbrimjtbyhg'.  Tighten the test by searching for
> > "(null)" rather than "null".
>
> Why do we even need grep again?  If we were to segfault, wouldn't
> test_must_fail catch it for us?
>
> ... ahh, OK, your libc may allow NULL left in email and that is what
> we are trying to catch?

Yes, as mentioned in the commit message:

    ...was trying to make sure that
    the test with an empty ident did not segfault and did not result in
    glibc quiety translating a NULL pointer into a name of "(null)".

This was also taken from the comment in the file just above the code
in question (though it was just barely outside the context region).

> Honestly, I am not sure if it even makes sense to test it like this.
> The code that the test tries to protect against future breakages
> roughly look like this these days.
>
>         if (!email) {
>                 ... one way to assign non-NULL to email ...
>         }
>         if (!email) {
>                 ... do other things to assign non-NULL to email or die ...
>         }
>
>         if (want_name) {
>                 ... here we require email to be set because we show
>                 ... it in an error message
>         }
>
> The original problem was that the code had "if (want_name)" part
> first before email==NULL condition has been dealt with, and used
> email==NULL in one of the error messages.  The fix was to move the
> part that deals with email==NULL up, as it does not need any of the
> effects that happen in "if (want_name)" block.
>
> Now, what is this particular test protecting against?  We may again
> move the "if (want_name)" block up and trigger the error message in
> it that uses e-mail while having NULL in email again?  If so, would
> it make more sense to do something along this line, lose the "grep"
> and keep "test_must_fail"?  We expect and require at this point in
> the code (the patch is inside that "if (want_name)" block) email
> must have been set up already, so it would be a BUG() otherwise.
>
> Hmm?

It may come down to the angle you view it from; "the current code
doesn't have such a problem and can't within its newer design, so why
test it?" vs. "when you add a regression test at the time you make a
bugfix, the regression test should demonstrate the failure with the
old version of the code".  Without the grep, the test would not have
failed on the original old version of the code, at least not on some
platforms.
I'm guessing that's why Peff put it there, and still had a preference
to leave the grep in (see his comments on this issue at
https://lore.kernel.org/git/20201016200031.GA3355643@coredump.intra.peff.net/;
this is a case where it'd be nice if gitgitgadget accepted an
in-reply-to flag of some sort).

However, although I have a slight preference to fixing what grep is
searching for, my primary concern was with avoiding flakiness in the
test.  I'm happy if someone wants to make additional code changes or
tweak the testcase here so long as we avoid the flakiness.

>  ident.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git i/ident.c w/ident.c
> index 6aba4b5cb6..9b71563d95 100644
> --- i/ident.c
> +++ w/ident.c
> @@ -430,6 +430,8 @@ const char *fmt_ident(const char *name, const char *email,
>                         if (strict) {
>                                 if (using_default)
>                                         ident_env_hint(whose_ident);
> +                               if (!email)
> +                                       BUG("NULL email when we need to complain???");
>                                 die(_("empty ident name (for <%s>) not allowed"), email);
>                         }
>                         pw = xgetpwuid_self(NULL);
