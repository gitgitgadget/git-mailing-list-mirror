Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41E3C433E6
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 05:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93E4964EC3
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 05:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbhBXFzg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 00:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbhBXFzf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 00:55:35 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B08C061574
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 21:54:55 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id a13so1346254oid.0
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 21:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pyYni3UVJRnIkC8VZThfYQs95rd7VVzZ6zWsMet2cJg=;
        b=J6sP5r0etpWAewwicBGaZDFL8CCGowKxzW1fWouCE+Ljm7CPbXN20v69FKbGf2J/WG
         ARrYInLHz19DXH50I9XW+W8zCSJdHssWtwEI9SpVRQ7AIxgKU2lm/skbriETI3hZqgN0
         qQpxG40qmmC70dUuNDtZnMLjW8Es84SCJLrLWmfP4htATq1K6hk7U+9nmEhV9A7TF6xS
         IHQSDCPYbLiOrSBhzn/agfvuBL5rhwCOvroHRzkRtXevlVPoxw5Z+T5h1rXldUzJr6L2
         0i4w5Z7TsMMxhK0upHHb4681r5JDZHDHrdIJlSAsI0QTvPdy6K+S64eVNKd0EyQwcOGX
         vhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pyYni3UVJRnIkC8VZThfYQs95rd7VVzZ6zWsMet2cJg=;
        b=iK1EsIOWtlceo3F7RhIdCXajjHR2ymFVZeDoSvDud9dBXgnPjf7Vc0oBUQD8DfpXed
         I4ayGcHnLOR7qzC3sbgLy22ga8HBdBXV6DZ/gsSU/5TLbnV28Ycvxw7oIRve1gYtxbxV
         gLuL6I7lMlq1xJm19iR88nSZmZdbgH8ufEeBLuTt+EwNMUc+yZNwbwhnT2wdB8cL+S04
         wyVnWTgF5eFRT3k6fz/Rx6wx6ECjz3DFGCbgu6kzrGvVvPTmbH6vq0EZrBMPTlakwSHv
         l022B8o5Od66WHfwHvDzW6qCtd4DGtqsM1UgCmVGCuhDj7/BdVTShgQBQF+ad6buRx1U
         j2/A==
X-Gm-Message-State: AOAM530+DX3I5sMn+NZvZYnAaEBwCSiyfNL+FJappryfRwrbF4F6v1Jh
        fqGgwde+pGY1DjBKQSy8NhhbM50qiLuObaa22cyLqaJxC74=
X-Google-Smtp-Source: ABdhPJwP3iCjnvgVgJXDFCuUkKzEXRrgsZT66gb1F6Wps9znf7tyjY1NF5977QGf69h2gY2YiS5gzbU0eg5CaO2cuSc=
X-Received: by 2002:a05:6808:8c1:: with SMTP id k1mr1717992oij.48.1614146094467;
 Tue, 23 Feb 2021 21:54:54 -0800 (PST)
MIME-Version: 1.0
References: <20210217072904.16257-1-charvi077@gmail.com> <xmqqeeh61rv9.fsf@gitster.g>
In-Reply-To: <xmqqeeh61rv9.fsf@gitster.g>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Wed, 24 Feb 2021 11:24:43 +0530
Message-ID: <CAPSFM5fL3_pkMNBYSXiRHzbqOwzA0SBH3NjU+zVq3Mxv7UgL4w@mail.gmail.com>
Subject: Re: [PATCH 0/6][Outreachy] commit: Implementation of "amend!" commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 24 Feb 2021 at 01:25, Junio C Hamano <gitster@pobox.com> wrote:
>
[...]
> We used to have only --fixup that was meant to squeeze in minor
> corrections to the contents recorded, and it kept the log message
> of the original commit intact.
>
> Now we have two other ways, --fixup=reword that is meant to correct
> only the log message while keeping the contents intact from the
> original, and --fixup=amend that is meant to allow users to do both.
> They are nice additions to our toolbox.
>
> While trying to use the --fixup=amend myself to "touch up" somebody
> else's work today, another thing that we did not discuss so far came
> to my mind (sorry, if this was discussed and resolved in your
> previous discussions with other reviewers).  What should we do to
> the authorship?
>

Yes, for the authorship similar to `--fixup`, when used with suboptions
`amend` or `reword`, it keeps the original authorship.

> For the original --fixup, it is reasonably obvious that the original
> authorship should be kept, as the intended use case is to make a
> small tweak that does not change the intention of the commit in any
> way (and that is why the log message from the original is kept), and
> with --fixup=reword, it would probably be the same (the contents
> were written by the original author alone, and the person fixing-up
> is not changing only the log message).  So these two have a
> reasonably good default model for the authorship information for the
> final outcome: the original authorship should be kept (of course,
> the user can easily take over the authorship later with "git commit
> --amend --reset-author" perhaps run as part of "rebase -i", if the
> contribution is significant enough to deserve the transfer of the
> authorship).
>
> But I am not sure what the default behaviour for the authorship when
> --fixup=amend:<commit> is used to update somebody else's commit.  I
> think it is OK to leave it to whatever the code happens to do right
> now (simply because I have no strong reason to vote for either way
> between keeping the original and letting the amending user take it
> over), but I think it should be documented what happens in each
> case.
>

Okay, I agree. We have included in the tests where we check both the
resulting commit message and the author details  but yes I will document
it as well.

Thanks and Regards,
Charvi
