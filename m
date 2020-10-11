Return-Path: <SRS0=tPyM=DS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA332C433E7
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 11:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D56F2223C
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 11:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwckxtz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387489AbgJKLbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Oct 2020 07:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387467AbgJKLbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Oct 2020 07:31:09 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E93C0613CE
        for <git@vger.kernel.org>; Sun, 11 Oct 2020 04:31:08 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k6so14822873ior.2
        for <git@vger.kernel.org>; Sun, 11 Oct 2020 04:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ZE4dXw88P11QqzJ4oFMjwzOi10CaXxIcnUXaro8nO4=;
        b=cwckxtz4uVgRIoWuS9ptORh5io7lKndrvSb//H+c9hedHWMSwKIL4wYVxRj8StYjoD
         pbXLopdwZz2U18GmgvQXGm/Y+GWFl+TFplpoOp8HJAdpSzvPEM/7PdIkMg/QRpM6piFE
         CdEVxBk4gEH3b2Cva+9u5i+x78LgoHKL/D8gJ4JhzJ9QkoTjFg+nqmYimt1Nf1ZX0iH6
         rLD6uaiRIcJbkyO+YYyGSTGkRLQXzH7LqySYgP6H83yYMamu31kg5z2AXoTGRAXizPvM
         N/Be9X16UiF5Q0p6oRViSRTmtRLgF8QZL7BmuxIA2XtZRm9kY7GkHnecNJtNBQoCWUbF
         EdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ZE4dXw88P11QqzJ4oFMjwzOi10CaXxIcnUXaro8nO4=;
        b=NkvJuzrOd6LNG4EqZ6YXhA2S9kDUP8oSSPkHLEyF5Wtgete20jz/vH6BWRRhTttiUE
         olgqYRTT4HzW1zhqCMUbuw2VPEzDCjWqacS4uQtg8Ru/2fu7urQtYGxdF9+SrNYpe9Y0
         1ljepg44XJBdupJrjwSuPTIKwJHi7fZOn7HmjZotk6nJVlyi7Rv47QzAu/St/gv1OjxE
         xvCfEi89o4eUeNpfahwhhwX883GNJgLmb8hvqu9NwhC6VDVNEpiZXWDMIHDHr3sUx7wc
         eF2Yq4BRC5NKXI177ngIHJrnPLDfymzS04XHAJ+iddbDrUUWwbzk2CZiFaX94p4itgIR
         8Kjw==
X-Gm-Message-State: AOAM530rWF1/Db+V6q2XxOLKMkquo/gp8ZMSpFPFAic2QJvRgtnT1Ka6
        G9BR8o6ll51o+MPQPuev22cY6q1C42jUHMpM9PNEiXgo6JU=
X-Google-Smtp-Source: ABdhPJw8XESvdO/4KUTiM1qnDZKvVoFj5RKG7ULDccDg8jvaXkrKpcRGmiGopBhxBVE7phivCkqdRFU/iFPGCpQU0Q4=
X-Received: by 2002:a05:6602:2247:: with SMTP id o7mr12683110ioo.98.1602415867430;
 Sun, 11 Oct 2020 04:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAHjREB4gsyOrdnhp0_9rs0wv5q5H47-3RcB3fm5NY+L=3SYnMA@mail.gmail.com>
 <22e3d737-8621-9f20-307e-fc4c2a47ec0c@gmail.com> <CAHjREB59HjZAs98wMPtMANcHUaXGou7CYg9vAacc3m4uz1yUug@mail.gmail.com>
 <7d691f37-b8b7-510d-ba46-51a4a7587226@gmail.com>
In-Reply-To: <7d691f37-b8b7-510d-ba46-51a4a7587226@gmail.com>
From:   Sangeeta NB <sangunb09@gmail.com>
Date:   Sun, 11 Oct 2020 17:00:56 +0530
Message-ID: <CAHjREB6j6BqZ49wX5uqEOiysTAm8Oo7N=EFpcoovWKkBghBjxQ@mail.gmail.com>
Subject: Re: [Outreachy] Introduction
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the help, Philip.

On Fri, Oct 9, 2020 at 11:59 PM Phillip Wood <phillip.wood123@gmail.com> wrote:

> I struggled to find the mircoprojects page - I must have missed the link
> on the outreachy site.

In case anyone else is struggling to find the microprojects page,
here's the link [1]

[1] https://git.github.io/Outreachy-21-Microprojects/

> As I understand it if a submodule contains any untracked files (i.e. a
> file that has not been added with `git add` and is not ignored by any
> .gitignore or .git/info/exclude entries) then running `git diff` in the
> superproject will report that the submodule is dirty - there will be a
> line something like "+Subproject commit abcdef-dirty". However if we run
> `git describe --dirty` in the submodule directory then it will not
> append "-dirty" to it's output unless there are changes to tracked files.

On running `git diff HEAD --ignore-submodules=untracked` the submodule
wasn't reported as dirty.

I guess this is what we are expecting. So should I make it the default
behavior for diff?

A fix for making this as the default behaviour can be:

--- a/diff.c
+++ b/diff.c
@@ -422,6 +422,7 @@ int git_diff_ui_config(const char *var, const char
*value, void *cb)
        if (git_color_config(var, value, cb) < 0)
                return -1;

+       handle_ignore_submodules_arg(&default_diff_options, "untracked");
        return git_diff_basic_config(var, value, cb);
 }

But this would also involve a lot of changes in the way tests are
written as 12 out of 19 tests in t4027-diff-submodule.sh failed after
adding this patch. I am working on any other workaround for this. Let
me know whether I am on right path or not. Also any pointers on how to
proceed would be helpful. Thanks!
