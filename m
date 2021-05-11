Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082D3C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 17:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD35F611BD
	for <git@archiver.kernel.org>; Tue, 11 May 2021 17:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhEKRmF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 13:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhEKRmF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 13:42:05 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EC2C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 10:40:57 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id w6-20020a4a9d060000b02901f9175244e7so4363887ooj.9
        for <git@vger.kernel.org>; Tue, 11 May 2021 10:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LzeuTBESJluVyhKaC0zJWfKJy742G5E1WzqmxD9NVfA=;
        b=f80oT4U+RvDxM0fJDL/CORN9Gp080bCVVw7WUiD/V+Z1WLhQTtCGSOhRyMnbRAfRa4
         x6FlMCopxptvpRKOUFj3frxspFI7mGBxQNX3LJLnhmfADxN0vffdcaVMfDOCgvBnGCZO
         0G2oKATZ/yRzEpno+KcGUKMyEsvL4JKgUiVji436j8gfHcag3/vhZ53t2k78OHVwlBmT
         jvSZSie71+aPLNXvSJywtmGWEjy7U5Av4WUYdp0wAFv2emxKZo84G4qEmsqNrNCig6Gr
         segdExRr/pTeoXy6uzJCH/mwhi5m38lkQvdu0NFWgYrji3BtPFepHHCvqeffuah0rHWM
         dK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LzeuTBESJluVyhKaC0zJWfKJy742G5E1WzqmxD9NVfA=;
        b=pWA4cmgvbKvRBnFVlxYnITO3DH9FPH8vZSZe+l54r5uUtlkD9i1aZZ8fQA5DHkMrmg
         PkpTx8eDfbTAO8cartmwWtxpnhYVUvsDCzWd7mdce6EWnN/btSTAU1fwJO+e6UpC1hEt
         Pp7MFjSQ9KRr4XGZPbT0A4NkdLawDJIggRAdTDsUXtJMgP2ZLb9hckkbBXBJKQmb9z6r
         ug4eC2u0P4LVpt1YK9yEon36HjcGrHJSqgKKNxGmDBQbuem55fMzzOZiuJillPKoooD6
         QED9E8tohHzSZgHvRY7bunhESTS6VfjBL6YhnbzZh/BWixY75uw0VD/FyLL14oDkQ4d7
         5w8g==
X-Gm-Message-State: AOAM532SI67i5ToXdCmUiDUKDVHqHWfVsoN9A8tZ4s/Cezu6Cg2XvgvX
        P6vmQkTLt0QCCn4ommUbzdRPu5I6tBuCNEKxcuM=
X-Google-Smtp-Source: ABdhPJwP+zbSQhFuZWQK0gnSpi4o/72jtd4YvzYFp5BFuacA/NmTplcLvMBk7eSgR7YKkOAFwpeBtowmeoveGFa8rAw=
X-Received: by 2002:a4a:625c:: with SMTP id y28mr24152030oog.45.1620754857010;
 Tue, 11 May 2021 10:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
 <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com> <44a1322c44026e675ea254a00f3b50d4955ac56e.1620503945.git.gitgitgadget@gmail.com>
 <xmqqbl9jrx8f.fsf@gitster.g>
In-Reply-To: <xmqqbl9jrx8f.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 11 May 2021 10:40:45 -0700
Message-ID: <CABPp-BE7V233NYJARGXaTUZdt+L=N55B27UrV6pOuKaKOUWRWA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] [RFC] ls-files: error out on -i unless -o or -c
 are specified
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 9, 2021 at 10:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > @@ -748,6 +748,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
> >       if (pathspec.nr && error_unmatch)
> >               ps_matched = xcalloc(pathspec.nr, 1);
> >
> > +     if ((dir.flags & DIR_SHOW_IGNORED) && !show_others && !show_cached)
> > +             die("ls-files --ignored is usually used with --others, but --cached is the default.  Please specify which you want.");
> > +
>
> So "git ls-files -i" would suddenly start erroring out and users are
> to scramble and patch their scripts?

Thus the reason I marked this as "RFC" and called it out in the cover
letter for folks to comment on.

I figured that if I was having difficulty using it correctly and even
our own testsuite showed that 50% of such invocations were wrong
(despite being reviewed[1]), then it seems likely to me that erroring
out to inform folks of this problem might be warranted.  But, if folks
disagree, I can switch it to a warning instead.

[1] https://lore.kernel.org/git/20120724133227.GA14422@sigill.intra.peff.net/#t

> More importantly, the message does not make much sense.  "I is
> usually used with O" is very true, but the mention of "usually" here
> means it is not an error for "I" to be used without "O".  That part
> is very understandable and correct.
>
> But I do not know what "but --cached is the default" part wants to
> say.  If it is the _default_, and (assuming that what I read in the
> proposed log message is correct) the combination of "-i -c" is valid,
> then I would understand the message if the code were more like this:
>
>         if ((dir.flags & DIR_SHOW_IGNORED) &&
>             !show_others && !show_cached) {
>                 show_cached = 1; /* default */
>                 warning("ls-files -i given without -o/-c; defaulting to -i -c");
>         }
>
> If we are not defaulting to cached, then
>
>         die("ls-files -i must be used with either -o or -c");
>
> would also make sense.

Ooh, that wording is much nicer.  I'll adopt the latter suggestion,
but let me know if you'd rather I went the warning route.
