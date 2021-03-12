Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5FFC433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 07:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2F6164F80
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 07:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhCLHDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 02:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbhCLHCj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 02:02:39 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19941C061762
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 23:02:38 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id c10so51249291ejx.9
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 23:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E+A8T+cuqcNjLqHAOdPi7S99U9uWDqyT08IuE9XSv/4=;
        b=NccqtEEmn+OiZbRY+NdS78SOWOCNje8d2bQKMB4Q4ebA14GWx2UjYgq+hQ8/Eqqpot
         KsxvAn1P1vbhFgiDACiZYlXVugHsWc8mJDmgu3S35/yVInjs6/0s2VFaYEl3urTQXPuD
         aUhu0JGXFEneeJUX3FaPXSjzK6YR0EXsgcbIMwOn/Ci5MxPm0EddepGBoNNVTpk1kEcV
         SgT4i5GZHqgrLRqjxDNHt0rZhbtcsKP2CPAG3RjJJC5A8GY0FbpVpmukc+/ii4S+7SUF
         vBYLcFKmHLOj7e0QbxveMCyB4lLh9gOHX6jeasYBhRv8owxapAOxnL7wvB3s7c5Ucfc0
         sI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E+A8T+cuqcNjLqHAOdPi7S99U9uWDqyT08IuE9XSv/4=;
        b=OKqCR8XaKMPn/9mXhcfJASzXR04DlCFaxUTsZx1/yeZddSB+4M54KXTRFKDuGei2DD
         S2Cijbqc/0tbcWrErEgog1/+V9GUyfOyvY4JaMJcCWaWCqqwDnGSuImMSP2iQa2CQAfC
         lN/viQxhx8hO/7ZLCE7RjMK8TgZu4x4fNqKxC66gGst5Dux4kpZx+iBrHJVcxs5S5nhW
         OEZV+ptxUZqMVUfx7bln7tYtvImivYWsDKXCuj2jeQcORyOhZAIW9Znxv0BFQHQCNbkZ
         1kmyq4EWryAelHvz9b96JVMaRSxV+h8vgTOZRK/0YlsYdl/4qDY/CXs0YVvZ9BDeOGDU
         gvFQ==
X-Gm-Message-State: AOAM530X0t97Vn521GufGQAGLyC1Bg2UpCJpHmTeiuBJsPFenXeUJqDH
        rmm9m4QcEB1a2vKjPwAafuSrurzNo0cvOTK6CoRW1SNc
X-Google-Smtp-Source: ABdhPJxMkZAshvropDNGi0d8ITB+7dnHfoeHcxWAV0SZUr1vlJ3vF7ghw9JeVUpmtlR7/8iVQY8+aGEj9OqYKNcT+vw=
X-Received: by 2002:a19:4cc5:: with SMTP id z188mr4711793lfa.242.1615532548047;
 Thu, 11 Mar 2021 23:02:28 -0800 (PST)
MIME-Version: 1.0
References: <875z1xwznd.fsf@gnu.org> <YEpusE7ZIE5RgOws@coredump.intra.peff.net>
 <87a6r9o1yo.fsf@gnu.org> <CABURp0pFdHAx_+-e+O35Qxtbe3_+cZy9SZcOSeR2R7v_neRwKg@mail.gmail.com>
In-Reply-To: <CABURp0pFdHAx_+-e+O35Qxtbe3_+cZy9SZcOSeR2R7v_neRwKg@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Thu, 11 Mar 2021 23:02:16 -0800
Message-ID: <CAPx1GvfguSyXznaaeQYB8JY96vmZmzOJyTnXX1yP3omeXptqXw@mail.gmail.com>
Subject: Re: [Bug] Stashing during merge loses MERGING state
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Tassilo Horn <tsdh@gnu.org>, Jeff King <peff@peff.net>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 9:19 PM Phil Hord <phil.hord@gmail.com> wrote:
> I wonder if a fix could be as simple as recording the MERGE_HEAD as
> the third parent commit of the stash ref.

There is already a third parent, but only when using -u / -a: this
third-parent commit holds the untracked files (which are then removed
a la `git clean`).

A better trick would, I think, be able to save a partial merge state
in general, including the unmerged statuses of various files, the
ongoing action (merge or one of the other things that use it), and
so on, in a form that could be restored later.  A plain `git stash` in
any partially-merged state should tell you: no, use the fancier
merge-state-saver instead.

> I think being able to stash during a merge conflict could be very
> useful.  I do sometimes need to get back to a working state
> momentarily and a merge conflict represents a long pole to doing so.
> Similarly, it could be useful to stash a conflicted `git rebase` so I
> could return to it later and pick up where I left off.  Now we really
> would need to store some extra metadata, though, like the todo-list
> and ORIG_HEAD.  And we would definitely need some extra command line
> switch to tell stash (or rebase) that I want to include all the rebase
> state and also "pause" the rebase by restoring to my starting point.

This is the sort of thing I'm thinking of, for the "superstash" (terrible
name for it). Note that whatever this becomes, it should be send-able
(via push and/or email) so that you can have multiple people work
on resolving a particularly hairy merge.

Chris
