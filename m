Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8FDC433E1
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 02:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32DB2070A
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 02:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kae7HCHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgGRCAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 22:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgGRCAe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 22:00:34 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8647FC0619D2
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 19:00:34 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id t4so9573615oij.9
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 19:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i5h1eGhFZ9SIeMBgdpdVIli+FeJePUHKntosYpWENiE=;
        b=kae7HCHK86V3Ne8/KhbAKVfsfn8sGO34rZWRvVpdpOrSdtF8bJ0eLmeYGFFcoLZCd0
         fnutB5b7mz+eFwB+HpB0ZUMmf3q1NAeRmRgJlAWoGvEush7dMEtGI8pYqt8on50xVKFU
         EcE8M1R0dYAUI0R7gggdXRieFuq4cp+lHk5Q0MjmNhZmA0Iun6x1+Me2N499KFukQlpA
         PIdoi/SHcEFxeXLL/DeKNL5Bhy6lWYRY9CTVSjGmI2ZeojUyYNp5l+6m9Qr6HbRhLVbL
         JEdD7Bj6BAACYYrHTWV6hcnFgynColUr4N/UCrsjM8EiwWWDZKASBApjexrLqfiBuMy2
         BlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i5h1eGhFZ9SIeMBgdpdVIli+FeJePUHKntosYpWENiE=;
        b=PukWQNvlMs4hRkQvaYKsEKbgqE508AYZIcppzJUWdmxccdBVo6xwArMHRmfxhkBxp9
         o4dYk2ln2yTuW9X1XH8cSqEdo/gvcRw6ZhOEChhHk96oKDiWNOyIAIMB7PBc2+8TSw5b
         2zdxVIbLz4zJox3FepITryoF/UynQKygtv+TkyNzZc730DOgAC/KO9qNyUijzYviLp+5
         F4fFtOiH7ehK55og1hxzZaE8a4hOdXO73kuKbMqWsekbuzv9Tl+UJeSyq7yE8dQOyOxA
         VF/h+MPq6xqvRS5e+ZtAb3CQxaFEcz2OqBCycIozNxQPzGW5pmGxYGBwKE+Tnwpv5vO/
         2LXg==
X-Gm-Message-State: AOAM533bw4cMkaL+pPgKx/6YbvRnLc57X8eknP8S2rdLIoYB5NN8+tso
        FxjlO0wXKWR5K7qbF295d7wQmsqpkVtJEy0WKRw=
X-Google-Smtp-Source: ABdhPJxpV33RImXfCflDc3EYorkQ7anE9GJNnNMF8uJ6V5GTNoO2rhc5zn3vGQjW8VwSr3VO7amzMnuOtxCJAvBmQrU=
X-Received: by 2002:aca:ea08:: with SMTP id i8mr10205347oih.167.1595037633703;
 Fri, 17 Jul 2020 19:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.678.git.1595028293855.gitgitgadget@gmail.com> <xmqqeep9d6tm.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqeep9d6tm.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 17 Jul 2020 19:00:22 -0700
Message-ID: <CABPp-BGDp_SjJKvi+XVd6KvRLA5PVsK4xBLPvBxAimDft+0M9g@mail.gmail.com>
Subject: Re: [PATCH] git-mv: improve error message for conflicted file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Chris Torek via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Chris Torek <chris.torek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 17, 2020 at 5:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Chris Torek via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > -             } else if (cache_name_pos(src, length) < 0)
> > -                     bad = _("not under version control");
> > -             else if (lstat(dst, &st) == 0 &&
> > +             } else if (cache_name_pos(src, length) < 0) {
> > +                     /*
> > +                      * This occurs for both untracked files *and*
> > +                      * files that are in merge-conflict state, so
> > +                      * let's distinguish between those two.
> > +                      */
> > +                     struct cache_entry *ce = cache_file_exists(src, length, ignore_case);
> > +                     if (ce == NULL)
> > +                             bad = _("not under version control");
> > +                     else
> > +                             bad = _("must resolve merge conflict first");
>
>
> The original did not care about the cache entry itself, and that is
> why cache_name_pos() was used.  Now you care what cache entry is at
> that position, running both calls is quite wasteful.
>
> Would it work better to declare "struct cache_entry *ce" in the
> scope that surrounds this if/elseif cascade and then rewrite this
> part more like so:
>
>         } else if (!(ce = cache_file_exists(...)) {
>                 bad = _("not tracked");
>         } else if (ce_stage(ce)) {
>                 bad = _("conflicted");
>         } else if (lstat(...)) { ...

Or, even better, make ce_stage(ce) not be an error; see
https://lore.kernel.org/git/xmqqk1ozb6qy.fsf@gitster-ct.c.googlers.com/.

I hadn't gotten around to it yet, but it's still on my radar.

(That said, I've obviously taken a really long time to get to it, so
improving the error message as an interim step is perfectly fine.)
