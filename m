Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B6101F453
	for <e@80x24.org>; Tue, 23 Oct 2018 23:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbeJXH05 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 03:26:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46938 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeJXH05 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 03:26:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id v22-v6so3197877edq.13
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 16:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3xvvJ77Ylww3ndZ81ocfdMBtb+tASz2QmuLLVqBqsyc=;
        b=lHVNd1rwLuoW+GjIBkhzMWyvOWr2WqxgDzHgDSXJ8UUjZXFWFveT/EITLRVt5+hb26
         L0XvluS/2T3mFKuyJXSzD06Vyjr6yGYICqHDEUTCZnrAYi2HhQgRqyXnZ6FvFbcU5GvZ
         bxR5YKuQKm6HqMPCjo5M0GF/YP9KAVIavd8P0XBADVxREcRmnYcx8WPhpmQknJdWKJ+F
         6/ribtkRaS/h32Ux7ZxMkdETMkJfEhV/G1oZ/9lfRtZmYSnMw2yskoMtNcPaEYkwhF19
         RlYGufrPbS/xq4VEg9nJcWdWiovjtYpZQBOYKHyBbm8R4HMmT1LEWstHZcbKiivgVrIY
         +99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3xvvJ77Ylww3ndZ81ocfdMBtb+tASz2QmuLLVqBqsyc=;
        b=Fnl6bqwaBgZ+Z0s27BZasezFU+V14eOGtK6/one0X1dnT5rzKSqrL9NZprVMDW9IZ6
         Lekl8zMKj+eX3s9T/SmTDCgvXt7mpH+QyB6dDIkWBM0siBJqk3XvF7F2ll4V5ooqHu1O
         br0hfyStChvKmkDWUFY+ExUBabd7htawEYShFxkEKQdCtNgI8neFhVafgbljSULZKaom
         f5lDAqyg2n4gG1TWezd9gyvLJFkK7Qe2WFePa9h+wPbxNqlwgsWlQa8RG11iFvfnrWEu
         eIaFHH6xevjvGAJ6gNHejL6H2WYumya6Cwh+p0CxTMX7QjiFdFqxaEY0W6Ol6aHU5Sab
         7UOA==
X-Gm-Message-State: ABuFfojfcsXZjCRb5zwhUnuuxwdAeawhCwI/CttWz/t33Ol2eJhetaKz
        bABc+T18OSHCkmMkpbEP/VJ9Z6mvrAMAxuL3Fv+n9g==
X-Google-Smtp-Source: ACcGV6045H8/2tE+c/XtCLuiCP5ToyQzNODKQi0caiPYtGoAv8OR80uMbBuFTdJrfVCCFglMB/B8Puid+iHC5SvF5e8=
X-Received: by 2002:a50:bc12:: with SMTP id j18-v6mr17702176edh.154.1540335685972;
 Tue, 23 Oct 2018 16:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAGZ79kbunyc02802+4sjGwthBnj_=eS=+z5B_WQSRdbUAHw1tQ@mail.gmail.com>
 <20181023225536.61508-1-jonathantanmy@google.com>
In-Reply-To: <20181023225536.61508-1-jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 23 Oct 2018 16:01:14 -0700
Message-ID: <CAGZ79kbNXD35ZwevjLZcrGsT=2hNcUPmVUWvP1RjsKSH0Gd3ww@mail.gmail.com>
Subject: Re: [PATCH 7/9] submodule: fetch in submodules git directory instead
 of in worktree
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 23, 2018 at 3:55 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> > When adding the comment here, we'd also want to have
> > the comment in prepare_submodule_repo_env, which
> > could be its own preparation commit.
>
> I agree with the protection. As for the preparation commit, I don't
> think it's always the code author's responsibility to tidy up the
> surrounding code, but since you're adding an identical comment here,
> it's probably worth it to add the comment there too.

Am I the only one who dislikes inconsistent files? ;-)
(ie. clean in one place, not cleaned up in another)
I can see your point. Will add a comment

> > Thinking of that, maybe we need to announce that in get_next_submodule
>
> The consequence of getting caught changes, though. Currently,
> spf->result is set to 1 whenever a child process fails. But in this
> patch, some of these repositories would be entirely skipped, meaning
> that no child process is run, and spf->result is never modified.

Right.

> > If the working tree directory is empty for that submodule, it means
> > it is likely not initialized. But why would we use that as a signal to
> > skip the submodule?
>
> What I meant was: if empty, skip it completely. Otherwise, do the
> repo_submodule_init() and repo_init() thing, and if they both fail, set
> spf->result to 1, preserving existing behavior.

I did it the other way round:

If repo_[submodule_]init fails, see if we have a gitlink in tree and
an empty dir in the FS, to decide if we need to signal failure.

I can switch it around again, but it seemed easier to write as
that puts corner cases away into one else {} case.
