Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9186C433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 23:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE702610F8
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 23:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240873AbhKHXTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 18:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbhKHXS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 18:18:59 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82436C061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 15:16:13 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id v20so17384043plo.7
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 15:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UUQWvslmF7aiWja155yKSwmOL41kZ7pmG0zPDXnD7ww=;
        b=hgp391LWvjY901uuYrSfqyRq3nZDsSXNrTMdrUu2NXjpLYQ8b02e0d1+AGr7FkfX5M
         +nN4dfSscGTeQglvQj/DfQPCM1hI9bNqJ5qYdsVvJFtzNH9GfodSk8ZrEBego/07fDd2
         rzOxmZheEmDZPOdD1Uq/fQNx+LWYrDVTYAWWYFl8EsDOewmSIvs2EXYSJ3dbRaTuMyIX
         y5j8tqszf8yOMrEZXmp59R6BB/fdALVC+HcmaWb/9YApPerwrCau6jQSmUThST1/qGH9
         Y1VjuBy6N60oYx6aSUEsNOFaeea6uBE1gkP2KeGd9hhzDOyWVPPZJHtq9A2hXMVLMEic
         6/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UUQWvslmF7aiWja155yKSwmOL41kZ7pmG0zPDXnD7ww=;
        b=1W5NX0GHLieSiBoOScQzHf/+Gc1ocAU7jo4BmLiyPwq3QY8Q9aijiVB1y68HgrsB0l
         mr6OhyuU6OyMUAK/M7XC8n3rcDBtSPrOy+eF5D7A/7dq8E1qDqcCEaYar5JlNMeYr/5u
         WfITv6YNc163OOJknhE+66Za9n0AnJpLn1/hunZdyPDcTpaqGDVrj7UwvWmNYp1RQNA/
         1C0n1vgbVmJQsCaE41zf0aiMPF0JeHKhTXm1jE+SajamgMfAZ0QjIX8DaPNzW1gxm5YM
         Eb5GWY1froAGEldM88pKSK1Oql869kPBUSSIC3gtYB6dAcZlqNLtrysKM3ExVOCbuzzK
         K+aQ==
X-Gm-Message-State: AOAM531Gp/DfgqqQL8Z8wUYpniAKec7DI6r0oBvCCYic4KSX2jV+ruua
        Lb7A1ZjPUQraz4j7ttszu8ekeb99pz5tMQ==
X-Google-Smtp-Source: ABdhPJydgAHpGjMOvECtrO4QxiMcWjaH5HBtjaNdmubhK0Eti0JRYxPrztjYs/mmYSgXGleHi/B4ow==
X-Received: by 2002:a17:90b:4b86:: with SMTP id lr6mr2128007pjb.98.1636413372710;
        Mon, 08 Nov 2021 15:16:12 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:f405:d461:2b86:9d34])
        by smtp.gmail.com with ESMTPSA id l1sm13464493pgt.39.2021.11.08.15.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 15:16:11 -0800 (PST)
Date:   Mon, 8 Nov 2021 15:16:07 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 2/4] introduce submodule.superprojectGitDir record
Message-ID: <YYmvt+wFQ97QLaO8@google.com>
References: <20211104234942.3473650-1-emilyshaffer@google.com>
 <20211104234942.3473650-3-emilyshaffer@google.com>
 <xmqqo86zxcqp.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo86zxcqp.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 05, 2021 at 12:50:22AM -0700, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > By using a relative path instead of an absolute path, we can move the
> > superproject directory around on the filesystem without breaking the
> > submodule's cache. And by using the path from gitdir to gitdir, we can
> > move the submodule within the superproject's tree structure without
> > breaking the submodule's cache, too.
> 
> All of the above explains what the design choice is, and what
> benefit the chosen design brings us.  But this last one ...
> 
> > Finally, by pointing at "get_git_common_dir()" instead of
> > "get_git_dir()", we ensure the link will refer to the parent repo,
> > not to a specific worktree.
> 
> ... only says that we choose to point at the common one, not a
> specific worktree (i.e. what behaviour was chosen by the design),
> but it is left unclear what benefit it is trying to bring us.
> 
> Thinking aloud, imagine that there are two worktrees for the
> superproject.  For simplicity, let's further imagine that these
> worktrees have a clean check-out of the same commit, hence, these
> two worktrees have the same commit from the same submodule checked
> out at the same location relative to the project root.
> 
> The subdirectory in each of these two superproject worktrees that
> checks out the submodule has .git file (as we "absorb" the gitdir in
> the modern submodule layout) pointing at somewhere.  It probably is
> OK if they point at the same place, but it might be more natural if
> these two submodule checkouts are two worktrees for a single
> submodule repository (this part I am not very clear, and that is why
> I labeled the discussion "thinking aloud").
> 
> It seems to me that both design choices would have equally valid
> arguments for them.  If both of these submodule worktrees point at
> the "common" dir of the superproject, because the "common" one is
> part of the primary worktree, which is harder to lose than secondary
> worktrees, of the superproject, it is presumably harder to go stale
> when "worktree rm" is done at superproject, which may be a plus.
> But then from the "cached" pointer, each of these submodule
> worktrees cannot tell which worktree of the superproject they are
> checked out as a part of.  Of course we can go to the root level of
> the submodule worktree and do the usual repository discovery to
> learn where the root level of the superproject worktree it belongs
> to, but it somehow feels that it defeats half the point of having
> this "cache" information.
> 
> If we instead point at the git-dir, from there, it is just one level
> of indirection to find out where the common dir of the superproject
> is.
> 
> > If the new config is present, we can do some optional value-added
> > behavior, like letting "git status" print additional info about the
> > submodule's status in relation to its superproject, or like letting the
> > superproject and submodule share an additional config file separate from
> > either one's local config.
> 
> And one value-add that I would think of off the top of my head is to
> show "we have commit X checked out, which is 4 commits on top of
> what the superproject's index records for this submodule" when "git
> status" is run in the submodule's worktree.  I do not know that is
> an operation to specifically optimize for, but by choosing to
> "cache" the common dir, not the one specific to the worktree of the
> superporject our submodule checkout is a part of, the chosen design
> seems to make it harder to implement?

Yeah, that is compelling. Sorry not to reply in depth, but I am
convinced.

 - Emily
