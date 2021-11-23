Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB3BC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 23:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhKWX01 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 18:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbhKWX0X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 18:26:23 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511C7C061759
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 15:23:13 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id r25so1803157edq.7
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 15:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WS6hd3mXeqVJZXgbwHpTzscGNt9Ca3pS82IZn084cuA=;
        b=K7Xji3oKeAoQKPxYr+jZo7IFQe+GKytuWthXBmbgprN5xxjjlGd3HpLL5jvwG4AUkS
         b8c16A2HnFLkIDMYkqgA6MDolfby5eG5LZgc6n9iKfmIRNkQ64imyFby1qGHlcm2XHP6
         LnMnkGGt7ha9vfPwxID61QBFzZMNdP3+WGnluMBiOc03tev7hYTMGiqcs63p/AT1wM61
         3LX0wkPlk3gRFS7OxIIv9/zIVmHC+mH1C763EBl9W59GYnwq1sLh4VARQJOjwwt3ZvVb
         3OzD01nC7BD4hLkxMi42UzQBjNYiFldi91JwmLTTTPk8dTbIFwgvmlJIFvOfaeHFhw53
         pVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WS6hd3mXeqVJZXgbwHpTzscGNt9Ca3pS82IZn084cuA=;
        b=cMNZjzJqDjyPJI7K4d63nvzbPQmxgIn0ztgedD7vdGV6wRVu0FblumhmzVh/PE0mk9
         JTQc3AWJhbp70CFklLohIoPILi+ZGBxvJPx/BTCoPuvHlU0jt3iDxwSBY3JJJ1s21ovx
         q1qLNli648VKA8VSgC8X4rHuMhNAtRsS53JHlvqLn2UScLGJwiaTdm1NpCF7ESkaqIkl
         W6h6HbACO7NqH69cbJkEAuMt7+nDq14fDInMc9mJZ046tGAQ7ZCXTfDIMn7UFXGaz1EO
         4olrWkRUxfLOBXfVbe+t2qCn4reebmfu1FsPXoeOHGfIeiUkbhW/UR6R4GvIW1JHc0Z3
         +Xhg==
X-Gm-Message-State: AOAM532lWQ5C/kIRi+7SdFEJxSfDessOhJ/GuRWbOmG+eCBoBZ3fs861
        Y/c2ckhFVEAYW2XNQlth9jyCMwznm4pUxbiGnTk=
X-Google-Smtp-Source: ABdhPJzsgKViUiXR58OY3rDlm08artUq+9c1xWY4mqgrVh0Fmzp2DZedwTY5+kl9MkFgbDscvWcJcGUbXfGbiNRnpLs=
X-Received: by 2002:a17:906:a08c:: with SMTP id q12mr12961307ejy.443.1637709791872;
 Tue, 23 Nov 2021 15:23:11 -0800 (PST)
MIME-Version: 1.0
References: <a5528cbb14ddbbf26cde873e3f3e95744d59b950.1637455620.git.gitgitgadget@gmail.com>
 <20211123003958.3978-1-chooglen@google.com> <CABPp-BE0Bcimwr1wwcnnh+6apx7r114Oqnu=QDgKEn6VAHAtFg@mail.gmail.com>
 <kl6lmtluka55.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CABPp-BGr9PDTE0q5zev4Ffx19g+hG083zdNShoSdH47VqzT8mw@mail.gmail.com>
 <kl6lzgputxxw.fsf@chooglen-macbookpro.roam.corp.google.com> <xmqqv90i7cxd.fsf@gitster.g>
In-Reply-To: <xmqqv90i7cxd.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Nov 2021 15:23:00 -0800
Message-ID: <CABPp-BHUj=3b8xZhD3weBPYuWaVR5MrrM8+KCwhtcB8diZcJyg@mail.gmail.com>
Subject: Re: [PATCH 8/8] dir: avoid removing the current working directory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 23, 2021 at 1:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Glen Choo <chooglen@google.com> writes:
>
> > This doesn't sound like a typical definition of 'emptiness' to me, but I
> > can accept it if others also find it compelling. IOW if your definition
> > of 'emptiness' is compelling enough, then I'll be convinced that there
> > is no mixing of concerns and there would be no objection.
>
> FWIW, I do not find it compelling.  I can grant that it might be
> convenient, but I do not think it is a good idea to explain the
> reason why the directory is protected is because it is "not empty".

Is the objection to my hand-wavy explanation?  If so, point taken.
However, I'm curious if you're also objecting to my commit message
and/or the patch as well.

If your objection also includes my commit message, but not the patch,
would the following suit your taste better? :

"""
remove_path() was added in 4a92d1bfb784 (Add remove_path: a function to
remove as much as possible of a path, 2008-09-27) to, as it says, remove
as much of a path as possible.  Why remove as much as possible?  Well,
at the time we probably would have said something like:

  * removing leading directories makes things feel tidy
  * removing leading directories doesn't hurt anything so long as they
    had no files in them.

However, the second reason (and perhaps also the first) do not hold when
that empty directory was the current working directory we inherited from
our parent process.  Leaving the parent process in a deleted directory
can cause user confusion when subsequent processes fail: any git
command, for example, will immediately fail with

    fatal: Unable to read current working directory: No such file or directory

Modify remove_path() so that the empty leading directories it also
deletes does not include the current working directory we inherited from
our parent process.  Also do the same for remove_dir_recursively().
"""
