Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27888C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 07:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0274160EBB
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 07:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhHJH0h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 03:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbhHJH0g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 03:26:36 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F80C06179C
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 00:26:14 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id d4so10661086lfk.9
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 00:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=69HitJyT5o4qLmemjpHGg9uwwh+xnjIPYLTGw3KsTCA=;
        b=lDk7amgIL0ifpZPAPR+nH2PPagKaVQWTVRnsz+nPJu4m4NoiVeoCSB+vrzhA0YsvNT
         uPQhVRyT/Do37IWQZsc8gavQ530arYxJbowF0UrkGUmJAwQLkJo7cF8bAJDg6iqIMvRu
         dII3W+4N3dEC6lgb21waFVBNeC/n619B11qbVyiQEQlEMiUyiDxHnM11231OfFxbcgVw
         fNMYYtgzpYmfC7dsMOHw80LqMR6xFTGFOcq83EsvHPUuQR/HymhvYB7N0Ru+CUKx2Ymt
         7u0EEoT1tpTSfoC9LssNRY8z+GSN8vQG2zF4Y0aqzTPwOvVcBcTIBeApJ0ZGa8tbJJIJ
         zmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=69HitJyT5o4qLmemjpHGg9uwwh+xnjIPYLTGw3KsTCA=;
        b=iIJUYkRXOZnbYGgKjyt9Y6vNO8HhWhvxjW4tM6bWApUI9/O8I7V5ADlu80XkhaQhRT
         iqwpIqJbmDMZ30h+VNinjU7JIandvOhHJ7e5NDDmd/noW29cLJPKrEUCjxe9VHdminxV
         n7gAvVi1XWh0Q32EqLgUp7r95pOtiLgHMClZK4jcQIE8EYC6cGUCwC/cI5kGHVd9sN4X
         9sSluh7rtIiOQqm79a56vJigieTGrPFTc9HYzqR/dW8MDSm+9V4jYQ1OP91l+yjOsCg1
         Qluoafi5O/Esa3PYyDPS6zit8fkj3I+I5aSRLdrZAZHx8jUp4s/qaMkc87hJsT3XKGD7
         MKQA==
X-Gm-Message-State: AOAM532YnK0EHqgYZcY+oMlMTvblXoUpGFjPSwMKWYkh0uvLdam09fh2
        DrF+0MDX+GjNtC8hFbDL5FAPLodfmCaq45mM/y1wHg==
X-Google-Smtp-Source: ABdhPJxu6FicToMYyzIbbcn+sNox7Fe1fdoBAdKG5LgpXgyO5aKW7pf9oFXyZz0uoXHU5JcKHXzvpTXcbtEg0AG4khc=
X-Received: by 2002:a05:6512:556:: with SMTP id h22mr20408494lfl.461.1628580372678;
 Tue, 10 Aug 2021 00:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1006.v3.git.1627946590.gitgitgadget@gmail.com>
 <pull.1006.v4.git.1628536305810.gitgitgadget@gmail.com> <xmqqzgtqe2w6.fsf@gitster.g>
In-Reply-To: <xmqqzgtqe2w6.fsf@gitster.g>
From:   Mahi Kolla <mahikolla@google.com>
Date:   Tue, 10 Aug 2021 00:26:01 -0700
Message-ID: <CAN3QUFYPjsvBRGegO-kC7+gcFDczOqQSw-UYphnLHx=6-6kkwA@mail.gmail.com>
Subject: Re: [PATCH v4] clone: update submodule.recurse in config when using --recurse-submodule
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Thank you for your feedback!

On Mon, Aug 9, 2021 at 2:15 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Mahi Kolla <mahikolla@google.com>
> >
> > When running 'git clone --recurse-submodules', developers might expect various other commands such as 'pull' and 'checkout' to also run recursively into submodules. Set 'submodule.recurse' to true when 'git clone' is run with '--recurse-submodules'.
>
> Please wrap overlong lines in your proposed log message to say 70 or
> so columns.
>

Ah, my bad, will do so going forward.

> Some developers might expect, but wouldn't some others want to see
> this not set to true, but want to recurse only into some but not all
> submodules?
>

I definitely agree with this. Currently, the `--recurse-submodules`
option takes in 1 parameter, a pathspec to the submodule they would
like to initialize. `submodule.active` stores this path or `.` if no
path is specified. Accordingly, `submodule.recurse=true` will only
apply to the submodules specified by the user in `submodule.active`.
This way users can ensure commands are run recursively only in
submodules they have listed as active.


> Is it possible to avoid changing the behaviour unconditionally and
> potentially breaking existing users by making it an opt-in feature,
> e.g. "git clone --recurse-submodules" would work as the current
> users would expect, while "git clone --recurse-submodules=sticky"
> would set submodule.recurse to true, or something?

As mentioned, the `submodule.recurse=true` will only apply to active
submodules specified by the user. Setting this config value when the
user runs their initial `git clone` minimizes the number of times a
developer must use the `--recurse-submodule` option on other commands.

However, this is a behavior change that may be surprising for
developers. To ensure a smooth rollout and easy adoption, I think
adding a message using an `advice.*` config setting would be useful.
When a user runs `git clone --recurse-submodules` an advice message
will pop up alerting them `submodule.recurse=true`, what this means
for other commands' functionality, and how to change it back (`git -C
dst-dir config submodule.recurse false`). This also gives the user the
option to turn off the advice message if they don't need it.

I'll also update the appropriate documentation to better explain how
setting submodule.recurse=true effects workflow.

Let me know what you think!

Best,
Mahi Kolla
