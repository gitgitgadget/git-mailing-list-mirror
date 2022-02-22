Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2850AC433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 02:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbiBVCR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 21:17:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiBVCR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 21:17:58 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002C024BE7
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 18:17:33 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id bg10so38100187ejb.4
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 18:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gMAjYCvW7bRMVpZT9a/mgMHLHxQxEuA9Koww3ysewfc=;
        b=CURStf6YSDw/5MFrZHp4286mLwE7H0uZXX4yrvLeOwTxouGT9kYMldYeh4N90c81Zj
         qpGpxeXnigTK7bIxIr6KyuVm2JX37CXUreoY9hLAr2eeJubKUc5+xWTHgoKjVnnlY5N6
         e0sf1K8jQzPlcz1ombrCvCHC01uB6N59j+lMXLuXWl9E7U4/DQONDR06V3iqfj1X2KzR
         p04gY8kzqzS6Rzp9R/ixDhJ632agaf/8xb8Sr7PBU3SqKkHP75wbihLgQ2JFLZD5KiGd
         24C3GhSnaFuEE8Q56eFORo84x9J1uPiuYTCDUQ+Bs1YuiqAH+5IqUWNLlZxO5QYJIXVa
         BIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gMAjYCvW7bRMVpZT9a/mgMHLHxQxEuA9Koww3ysewfc=;
        b=IoeWvtnCGB5lktWpeNd/1DtwtHKqMaHQP02SQ2z5pKYT4GXAF8nMUhMuL7BDek4fG9
         7t/tdfh2EzDJl+MzrylipkK+NNmUHWtrP0ytw3odVrPBIN8yvEz97ZnxVAMnZb9PTiT1
         qJNrlVCMqfYCkDjva6PLDRXyIyBxs9CDw/7VyQeS577K3cFd9i+TxWQcK9rbXqPr9HWF
         Np70KMyzre8UVXrJybSL6icqQEPj2BG7/iEWDp5GxQCEJN5yadFwscPplvbElBTcZGOM
         Z2I5O58l/nRvyJ+lByNjCJ8wjHL8skjmxKdFyB2dmfAyI69EQOyD4+0dvtqM6WAcXllo
         trLw==
X-Gm-Message-State: AOAM531hvUPWetZOHZ14YkbnBoDgxHfvQHhU/IspU1xNLb77f0McUydh
        FTtixggOP9qRB/xjjd4imf/fYwvSCCj9YXfftTM=
X-Google-Smtp-Source: ABdhPJxla14Set67zpkwyWWUXMIqUxG5bD6nuOxpu+QsE/e49IyqjYnxJODSMeBR60CPethEOGGweNu08hF+X7WdhnI=
X-Received: by 2002:a17:906:64e:b0:6ce:36ae:7ab5 with SMTP id
 t14-20020a170906064e00b006ce36ae7ab5mr17889326ejb.192.1645496252525; Mon, 21
 Feb 2022 18:17:32 -0800 (PST)
MIME-Version: 1.0
References: <pull.1153.git.1645333542011.gitgitgadget@gmail.com> <54a0aa74-57c2-ee65-ae07-cb1b0daf947f@github.com>
In-Reply-To: <54a0aa74-57c2-ee65-ae07-cb1b0daf947f@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Feb 2022 18:17:21 -0800
Message-ID: <CABPp-BGz0Y+Gk0uLy7K-pqBY955=rN-E2SJFofDaje60b-XZuw@mail.gmail.com>
Subject: Re: [PATCH] Provide config option to expect files outside sparse patterns
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Jeff Hostetler <jeffhostetler@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 20, 2022 at 11:41 AM Derrick Stolee
<derrickstolee@github.com> wrote:
>
> On 2/20/2022 12:05 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Typically with sparse checkouts, we expect files outside the sparsity
> > patterns to be marked as SKIP_WORKTREE and be missing from the working
> > tree.  VFS for Git can be used to turn this expectation on its head:
> > all files are considered present in the working copy, though they are
> > not vivified until first access access.  With VFS for Git, most of the
> > files do not match the sparsity patterns at first, and the VFS layer
> > automatically updates the sparsity patterns to add more files whenever
> > files are written.
> >
> > With this background, this special usecase does not play well with the
> > safety check we added in commit 11d46a399d ("repo_read_index: clear
> > SKIP_WORKTREE bit from files present in worktree", 2022-01-06).
> > Checking SKIP_WORKTREE files to see if they are present in the working
> > tree causes them all to be immediately vivified.  Further, the special
> > VFS layer, by virtue of automatically updating the sparsity patterns and
> > catching all accesses, isn't in need of that safety check either.
> > Provide a configuration option, core.expectFilesOutsideSparsePatterns
> > so that those with this special usecase can turn off the safety check.
>
> This patch looks like a good solution to the concerns brought up by
> Jonathan N. around vfsd. VFS for Git uses the microsoft/git fork with
> its own custom config to protect things like this. I imagine that we
> will start setting your core_expect_files_outside_sparse_patterns
> variable when reading the virtual filesystem info. We might even modify
> some of our custom checks to use this variable instead. That would make
> them appropriate to send upstream.
>
> Should we update Documentation/config/core.txt describing this config
> key? Or is this intended to be an internal detail only for something
> like vfsd?

I think it's probably only for vfsd, but vfsd users probably deserve
to be able to look it up in the documentation, so it's probably worth
documenting.   Once we figure out it's name and section, that is (as
per Dscho's email -- comments from you on that would be appreciated).

> The only concern here really is if we want to be picky about the "VFS
> for Git" references instead of "vfsd" references in the commit message.

I'm not sure I'm understanding the distinction.  Was "VFS for Git"
renamed to "vfsd"?  Is "vfsd" Google's modified version?  Something
else?

Also, vfsd doesn't seem to be Google-able whereas "VFS for Git" is,
and since it's not an internal git project, it might be nice to use a
name that users can find.

But anyway, I have no idea what the "correct" text here is (as
probably evidenced by my questions), so if anyone wants to provide
suggestions or corrections to the commit message, I'm happy to take
them.
