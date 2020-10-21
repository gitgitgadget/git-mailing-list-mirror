Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B11C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 18:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30C7822453
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 18:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8PHuDJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503885AbgJUSFE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 14:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503879AbgJUSFE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 14:05:04 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4244C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 11:05:03 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id q25so4143972ioh.4
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 11:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sgYAYSR1lBcW1wWXiGZCYnhsl4GF5Z+jrddWmTDc/kQ=;
        b=U8PHuDJKdXtiMmRJRJf/6yNKjZ4NVDXaMWkFNTNVEQZWSleuNmzS0rrmQEm//iiR+c
         2t6rqkriilTQ0qDnZJfS7BK0fh7emyLZTrNcSppnjJFBsgYSJ7t8AHfdZMk5M4456Q6i
         XypJofVmTgzv2bQlF7Ud+gl7QtCPkzw7E+sp9E9H1hzrppaopcElD7Gtkr66aWpH4ekT
         smyKM+7L0M6vYJvAvrjHpOYEPu5S6Y/YWix72Lx3rTTmEWiV+dY6I+zOeLXx/QF41KXc
         fsAUYH6bCTwAASm3qxbWEHHCTqgdTT+VAXWUNz+kaXloSI4oK3w99OC7XYQFhqRH/AzY
         Fd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sgYAYSR1lBcW1wWXiGZCYnhsl4GF5Z+jrddWmTDc/kQ=;
        b=Pujp9nLrJTzB2942X4lGD+lCe4iaXtWR9XSjEM8rCDpgdLmqShGa+EUmflOdgtdP+Q
         uiAYHvjkkzbjUaYo03aW4U2ljbDw+g7ocBqMcZdpNd0E7NMzXZVJa1f1aGyPUqnecbh4
         kebn4uAZcpVIWduRJfgs0tze39RqVmbFWMFIPF7wBSARsk3g7lUGz8cHkQxa+fW2Sp+A
         ccmZCYawRZjJ4PBABPJKnC8B/YFpKimxxXzm+7Ky1eUQuh6Y3Ud4lpaf5oVteiXYHcE/
         rIMtnxNAMPdSZK+NLoVBACoB+JJ8krNjLUbsfNjJ0jWzoLjjX+f/iwSABeK+eNmMWkwh
         tFNw==
X-Gm-Message-State: AOAM532yrUBtXjyWGaOlz7kYno9zAjm/vQ1NClGbwnPf18IS3Llyf4QW
        Q72UzitJUn+0jofV77TRBTcJWVRa2pIfj5B1ZD9GX8r/wdqv4jz5
X-Google-Smtp-Source: ABdhPJwnG2y52AeJh+MTAq2yKWk9p/PVOeihxwpydxZoppQ1VNKCA73ucOKBM4GgNJdCbcjT4L56bOslsqrNgSqZN6Q=
X-Received: by 2002:a5d:83cc:: with SMTP id u12mr3731991ior.171.1603303503280;
 Wed, 21 Oct 2020 11:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201021062430.2029566-1-eantoranz@gmail.com> <20201021161242.GA111581@nand.local>
In-Reply-To: <20201021161242.GA111581@nand.local>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Wed, 21 Oct 2020 12:04:52 -0600
Message-ID: <CAOc6etawWz526w-NPU00bvwRt5_dnZEq0Gk0L_2N3NPG3tAGYA@mail.gmail.com>
Subject: Re: [RFC] sequencer: allow metadata to be saved if using cherry-pick --no-commit
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think my previous reply was rejected so let me try again (I
apologize if you get a duplicate):

On Wed, Oct 21, 2020 at 10:12 AM Taylor Blau <me@ttaylorr.com> wrote:
> Hmm. I'm a little confused after reading your patch below. Why does (res
> == 0) change to (res == 0 && opts->no_commit)? Wouldn't we still want to
> update our CHERRY_PICK_HEAD even if "res == 0 && !opts->no_commit"?

My _guess_ (haven't sat down to study the code that much) is that if
"res == 0 && !opts->no_commit", then commit will wrap up in a normal
fashion and then there's actually no need for this file to be updated.
You can see that the same thing is done when reverting (preexisting
code), a few lines after where the patch is applied (if I remember
correctly).

>
> Even still, this patch as it is seems to fail a number of tests. You can
> run the tests yourself by running "make && make test", and there is more
> information about that in t/README.

Will actually look at that just so that I can have a better idea of
what the _current_ behavior is expected from using the flag. Looking
forward to more comments

>
> Thanks,
> Taylor

Thank you!
