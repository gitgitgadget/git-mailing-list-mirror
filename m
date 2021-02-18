Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2624C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BECC64E76
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhBRMYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 07:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhBRKQI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 05:16:08 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015E3C061786
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:14:08 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id r75so1376310oie.11
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xjD19c2TutB8fEZyQP3lBM4A/1ysLc1RFTjBK5Nszm0=;
        b=eA99FDceUOvQZhpSib6afNPKYb1xMYju4iSh7DJg9FIYDswx/yMQJpGkqGX/vckGLV
         7vXSZCOLqywsWyA7KOI/3BEqmDLVjK6f70Ny/3loaf6W1pNdk4tTVqiEJ3BHtpRP+xq5
         LQOROesSKtJ3ARkrL2f+BM8EKFDaBpA8dCNv1xHwYDb2cFGLwhQd+VoBDNS7NNO1mSDH
         Ll2+CXxTqfe4Ur2OlFmze+DQBDKIEaEs5eg600kWM8ENkP+DUc3lmzMfjMoRneilX7S7
         mBnicJz5Dpa+AXH5A5W/M0aFFaF097Exw13sF/wSWz7b+vBQzwRrrL+i9UvZ61l58QrF
         keAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xjD19c2TutB8fEZyQP3lBM4A/1ysLc1RFTjBK5Nszm0=;
        b=KGQw5C0AUPBMcwRXWPH3dLoyOhntNK7Df+Y+i/iRq9uOOYS90mWA6yGTwVd/YrmnGm
         z2f50QFu1Y8GTK3DVRVivaslPt4wRu5qXFuNZ8AEwErN7FdtLVAh4X0LvXSA2zFjLHxg
         qzwz1zU+Wg64oxGMxTkqxe/ihNk8x4EUNBEq+7Vi2gHg93WQ2+oKl9gdRSUZUPMFnurr
         ft7rMGRT7Bbk6QVKa2u4mJE1LT4Gs69ybvbvuIN04wbRRYnqjMtgpm3y2Dz3RSDoZxNl
         3ihqlavrXOQ4o6uUhPfQnqY3y1kWLit3veoWFr4yN0YdOrwJlBZrAJpDvSBPqxC1tk8t
         bd7Q==
X-Gm-Message-State: AOAM531Dv6LHpQJzmGMgz/4X20mkLp1okxW9kR7MmITuKaOElYPQ47Yr
        XkehFVqu6+KWg+eNGNXFoNF4jetIHXnWJ4Ksf90=
X-Google-Smtp-Source: ABdhPJxrGejTCzjCgaWuA5wyclo3WV3cIx2puGqObgBrua5dL4hw3Q7rJYGJhz+FcuVXV/l8aYJ/tcU8ZrFP8Wj/Kb0=
X-Received: by 2002:a05:6808:8cd:: with SMTP id k13mr2126018oij.98.1613643247453;
 Thu, 18 Feb 2021 02:14:07 -0800 (PST)
MIME-Version: 1.0
References: <20210217072904.16257-1-charvi077@gmail.com> <20210217073725.16656-1-charvi077@gmail.com>
 <20210217073725.16656-2-charvi077@gmail.com> <xmqq35xulbj0.fsf@gitster.g>
In-Reply-To: <xmqq35xulbj0.fsf@gitster.g>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 18 Feb 2021 15:43:56 +0530
Message-ID: <CAPSFM5ddkALLCU+k+Th=pvKHEaarr_45DSn=N5DCJu1o7_5-Eg@mail.gmail.com>
Subject: Re: [PATCH 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 18 Feb 2021 at 01:20, Junio C Hamano <gitster@pobox.com> wrote:
[...]
> The second one, even with s|HEAD|HEAD~3| is even less clear.
> Without the "-m", the resulting commit will have the subject that
> begins with !amend but the log message body is taken from the given
> commit, but with "-m", what happens?  Does a single-liner 'clever
> commit message' _replace_ the log message of the named commit,
> resulting in an !amend commit that has no message from the original?
> Or does 'clever commit message' get _appended_ the log message?
>

Yes, here it gets _appended_ the log message.  I agree this seems a bit
confusing.

> I think we can just remove the "example" from here and explain the
> feature well in the end-user facing documentation.
>

Okay, I will remove it from here and add it in the documentation.

> > +     if (fixup_message) {
> > +             /*
> > +              * check if ':' occurs before '^' or '@', otherwise
> > +              * fixup_message is a commit reference.
> > +              */
>
> Isn't it that you only intend to parse:
>
>     --fixup
>     --fixup=amend:<any string that names a commit>
>     --fixup=<any string that names a commit>
>
> and later extend it to allow keywords other than "amend"?
>

Agree.

> I can understand that you are trying to avoid getting fooled by
> things like
>
>         --fixup='HEAD^{/commit message with a colon : in it}'
>
> but why special case only ^ and @?  This feels brittle (note that I
> said "things like", exactly because I do not know if any string that
> can name a commit must have "@" or "^" appear before ":" if it is to
> have ":" in anywhere, which is what this code assumes).
>

Okay, I got this...

> Instead, you can find the first colon, check for known keywords (or
> a string that consists only of alnums to accomodate for future
> enhancement), and treat any garbage that happens to have a colon
> without the "keyword" as fixup_commit.  I.e.  something along this
> line...
>
>                 const char alphas[] = "abcde...xyz";
>                 size_t kwd_len;
>
>                 kwd_len = strspn(fixup_message, alphas);
>                 if (kwd_len && fixup_message[kwd_len] == ':') {
>                         /* found keyword? */
>                         fixup_message[kwd_len] = '\0';
>                         if (!strcmp("amend", fixup_message)) {
>                                 ... do the amend:<commit> thing ...
> #if in-next-step-when-you-add-support-for-reword
>                         } else if (!strcmp("reword", fixup_message)) {
>                                 ... do the reword:<commit> thing ...
> #endif
>                         } else {
>                                 die(_("unknown --fixup=%s:<commit>",
>                                         fixup_message));
>                         }
>                 } else {
>                         /* the entire fixup_message is the commit */
>                 }
>

...Thanks, for pointing this out. Also, in the above method for
alnum I think we can initialize an array of alnum[] instead of
alphas[]. Or otherwise I was thinking to instead check:
           if (!isalnum(*c) && *c == ':')
i.e to check that first non alnum char in fixup_message is ':' and
returning it's position to extract both fixup_prefix and fixup_commit.

Will look into it and update in the next revision.
