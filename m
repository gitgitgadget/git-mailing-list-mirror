Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2791C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 13:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9846B60E90
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 13:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345974AbhIXNnY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 09:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345931AbhIXNnX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 09:43:23 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99198C061613
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 06:41:49 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 5-20020a9d0685000000b0054706d7b8e5so13217572otx.3
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 06:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8c91NVJ2j2IinA/hAmgrTcFgoQvZhXsCfvfI64BrAGc=;
        b=UCleQkUEamEkag6tnLMHbWTk8v3Mc+H1CNx+PUFmMuk525cvMI4mO/v9hyrns0EPru
         SOuaAYNovyp5GD8ERq+nBOdeRvSeJrQQ4CMxraPt5V5DW0t5Ec4k3itbY8Xz79grcSxV
         0o61BG031bq3aJ1EVBsehIeIlttR4jLONvoCJWzqXEWmj9qLfn21qh2t8K0O97zVDfS8
         W2hIp5+w9ik0w1MOswwNnS4jtA33/6ctFJRcwLJCXPvFAzHQSSgIf7iGW0dRGBhSns48
         oXYANIEwRvUV0YnlMfMGpsCXPcY0t/7jTJB1gr492+PzY/qblv4bO2Ft/byCZpkyjQYG
         qvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8c91NVJ2j2IinA/hAmgrTcFgoQvZhXsCfvfI64BrAGc=;
        b=YzZQ9Sb5AoMBrLGq1QmyvW9LFbyw6YVYJBDfeFqREZPxwmogD5tzDiygF/LwHmtZGj
         t4qyfgi/hI6km3rfVcC2vlxUo+kJk5/IrXEFdEJY+PMWUTvvWpwRJxtxgWiV5Bg0hehP
         hJaP1FdGxHTXy6E0hSPSTaD/m5TveYR1Ix1w9A73bcRrQCLslAx44tH1TC5aG97hDNn+
         ISEALhasI1J7wxQPOKWW8a2zkpTOWOsBr/qnxwIrcYzB5T3LPtk9gT5yZ9JXIzQzq3Qg
         XCmBek4TzBpdZmmg4MUbl4C6S1qc4LE/o9TJWZkT73eftSIqlWKB8EMrheSHHCFNhWRA
         SdZw==
X-Gm-Message-State: AOAM5310Gs2IuikKbnSQUCpNpIGlbAL6448B14Ajv3wOOwXC6649Cah0
        QWpuOOFdVGAFP/61ST/5c2gMAomB/+8HAPSFJ2s=
X-Google-Smtp-Source: ABdhPJzq6kuHRXSxr3+RQiw2FmWfx2sgiUUm3x10aTLOdubgLHXz/7ve8heJH2lOQ8OG7Ef+qRpMvZYO62ZRm4EH0Xo=
X-Received: by 2002:a05:6830:2b27:: with SMTP id l39mr4235930otv.25.1632490908917;
 Fri, 24 Sep 2021 06:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
 <60c5d6b4615a6ac4179ec6c10e17cca480bc147a.1632006924.git.gitgitgadget@gmail.com>
 <CAE5ih79bzExNrp__GAUaVZWvMucYDrvSHSJe_+dNyeVR3VXynw@mail.gmail.com>
In-Reply-To: <CAE5ih79bzExNrp__GAUaVZWvMucYDrvSHSJe_+dNyeVR3VXynw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 24 Sep 2021 06:41:37 -0700
Message-ID: <CABPp-BEYH5HzQrRvMYw3vKMPQQ9b7XXfz5so5Wag7cbyyt=q=w@mail.gmail.com>
Subject: Re: [PATCH 5/6] Comment important codepaths regarding nuking
 untracked files/dirs
To:     Luke Diamand <luke@diamand.org>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Users <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fedor Biryukov <fedor.birjukov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 24, 2021 at 4:47 AM Luke Diamand <luke@diamand.org> wrote:
>
> On Sun, 19 Sept 2021 at 00:15, Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Elijah Newren <newren@gmail.com>
> >
> > In the last few commits we focused on code in unpack-trees.c that
> > mistakenly removed untracked files or directories.  There may be more of
> > those, but in this commit we change our focus: callers of toplevel
> > commands that are expected to remove untracked files or directories.
> >
> > As noted previously, we have toplevel commands that are expected to
> > delete untracked files such as 'read-tree --reset', 'reset --hard', and
> > 'checkout --force'.  However, that does not mean that other highlevel
> > commands that happen to call these other commands thought about or
> > conveyed to users the possibility that untracked files could be removed.
> > Audit the code for such callsites, and add comments near existing
> > callsites to mention whether these are safe or not.
> >
> > My auditing is somewhat incomplete, though; it skipped several cases:
> >   * git-rebase--preserve-merges.sh: is in the process of being
> >     deprecated/removed, so I won't leave a note that there are
> >     likely more bugs in that script.
> >   * contrib/git-new-workdir: why is the -f flag being used in a new
> >     empty directory??  It shouldn't hurt, but it seems useless.
> >   * git-p4.py: Don't see why -f is needed for a new dir (maybe it's
> >     not and is just superfluous), but I'm not at all familiar with
> >     the p4 stuff
>
> Assuming you're talking about this code in git-p4.py:
>
>             print("Synchronizing p4 checkout...")
>             if new_client_dir:
>                 # old one was destroyed, and maybe nobody told p4
>                 p4_sync("...", "-f")
>             else:
>                 p4_sync("...")

No, I was talking about this code:

                system([ "git", "checkout", "-f" ])
