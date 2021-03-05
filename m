Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C70C433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 01:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C06F65009
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 01:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhCEBiN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 20:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhCEBiN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 20:38:13 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D05C061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 17:38:13 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id z13so283514iox.8
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 17:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=graphe-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3qveDTac6kwZd0hvcOyc2nWz56K4w1EWOmsWj+BCiP8=;
        b=L4uwowgX4Uew/KAqpnd/o6HuxULy3NA4SDrm1QhrzEX2TaOoJReApi+YhlX8NQyoEn
         7/9QXACSScyJ4JVENaqxcquX63b51LRmBRmosrC1mq4bKV2tsG3X7W1KkW2dH9Kfn5Uc
         XaipxHVOgQTwuFrnpHkS05HdBbKQp4gPZC8YUHkgHx9/5NEy7rIh9GGTccrFd+Z/DT8B
         ugmd7ALKFO4LGLQXITxpF6ziuBrKSsK/6Ny+SDk4AmWCd/UR3VQxljqOzHbOVYPTuZ5/
         2sjLyw44fjj/LbEHwIRIHOiraPSRiGVkMzmtJmrZUVmQmf1FkxlKxDQq340RP+jMR2ur
         tF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3qveDTac6kwZd0hvcOyc2nWz56K4w1EWOmsWj+BCiP8=;
        b=G0HYjc+0pGtyJwKcKuRJrDkUxeJv404qOTV9W43XZ7Q3ONpkQo0XVmpfUwwQ/BBgsH
         4s0SMm7aq7mZnWsGdmfiWj0ATicPzRzUEmHXrcuIubfMR6muVmOSL+FUsFPVlMatSVgt
         t9WsjUPG2sosQOwLOcA5cMtFNvAW+3Vi8vZGyPqNRi62+i5b1JRoXVvAfgt6CgR5L2ih
         ZV7sqvDYf6f248ypM8JvZ9zgaIgbMkGw7yEkPjtmTsRNgEqHYKKCoF1XyGpVYPPRgCZ/
         FyT/F5mCYikH+feLpA4+G7S3uJZxzNjiwmvOCpOmM0RIA6pumkALIBYv7WGw+x/o3AHA
         VdiQ==
X-Gm-Message-State: AOAM531N/eJiUZKgVQR/E35CafnGXnKza4bKG8TN1Zg5ENxuC6B/Kt0S
        EIU+KEN1G9YtuLbzFqThGMTiyeUUv+ZbztGsGlXdJzAFM5l9dA==
X-Google-Smtp-Source: ABdhPJyzQgTxthTHgh8rs9k8TIVxugqctQb+Se0FxaP7pv/d8N6fq7PQ2vRp7hELs9zL/BCeD8oyKJ4Z0BKTmD/Mz+k=
X-Received: by 2002:a05:6638:1a6:: with SMTP id b6mr7203722jaq.116.1614908292009;
 Thu, 04 Mar 2021 17:38:12 -0800 (PST)
MIME-Version: 1.0
References: <CAPhpCMJ-u+W5+6ckazo7JkeaPhkpGP_6hOSJcggor0CcYgU95Q@mail.gmail.com>
 <YEF7z38st+4pEvdA@google.com>
In-Reply-To: <YEF7z38st+4pEvdA@google.com>
From:   Dominik Lameter <dominik@graphe.net>
Date:   Thu, 4 Mar 2021 19:38:01 -0600
Message-ID: <CAPhpCMLkxnNhHN+_3gwWqQ-XCA5P0UThTATG33MspmwqDW_XYA@mail.gmail.com>
Subject: Re: Found error in documentation, looking for advice on how to start contributing
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, git-mentoring@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Awesome, thanks! I'll go through that link.

On Thu, Mar 4, 2021, 6:31 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Thu, Mar 04, 2021 at 06:04:01PM -0600, Dominik Lameter wrote:
> >
> > Hi all,
>
> Hi and welcome!
>
> >
> > I don't know if this is the place for this question, let me know if I
> > should send it elsewhere.
> >
> > I was reading a portion of the documentation today and found a
> > paragraph out of place in my local documentation, as well as on
> > https://git-scm.com/docs/git-log and in the git/git GitHub repository.
> > I have never contributed to an open source project before and I think
> > this would be a simple place to start. I've read through the readme
> > and Documentation/SubmittingPatches document, however with the
> > https://github.com/git/git repository being publish only, what git
> > repository do I base my changes on for documentation patches?
>
> I think the My First Contribution guide can help you, especially if you
> start from here:
> https://git-scm.com/docs/MyFirstContribution#add-documentation
>
> (The rest of the guide before that anchor may also be useful to you, but
> not specifically for a documentation change.)
>
> This is definitely the right list, so do write back if you have
> questions that aren't answered by that guide.
>
>  - Emily
