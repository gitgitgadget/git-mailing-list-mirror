Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE34CC433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 20:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiKHUoZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 15:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiKHUn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 15:43:59 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375062673
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 12:43:35 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 204-20020a2510d5000000b006be7970889cso15109540ybq.21
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 12:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R6fDYpFMDuEmEBNP6U4LHRIE9msDX/ZtfL0oYtmn3dM=;
        b=Qi35CbdVnt5ng4LMT71vzwhbv2Xo+E/oW2HB74r/0LfRKitZQ94hhxSwXgcPiCDhQy
         6sB3RoiKMBHjS0piFjsGz3ybTFTibGjnvHNHfrXXzuALE0uNoHJCxrLbp5HaJ5r3xnr8
         RVPu0oHBBaUXaRCvF42tcSyRb8Sl/oqGdm0ZNV7NT6+pElWjonixv9OzHpPgk8AMIUl7
         Y3Pyz5NF1FTJDj3Ga5CeuzAaGIpaHpG2x3GwK9oelVDwBcJSH5UAOnSw1frsUpg4dk21
         vBpN19/u6D/DlbABo9O8jWOx8IIjQH/KQTPcC7fn6V+Vihxp+9Qe1ufmvq2Wo5YlSTBG
         K8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R6fDYpFMDuEmEBNP6U4LHRIE9msDX/ZtfL0oYtmn3dM=;
        b=CDefKsjjFknaOXgZkVORETBVOT4ZR2lO/uE/iSEsuxsX3XvGaBoLDu4bFoNKagt5lc
         kUYYZs42LnKbDN4bir/uTred6urniM9YjAnr58AqshptZfBvAuw11S+hkdzx/ZT/67E1
         Q6TdLcbY4+JtfDqJyNiITzls4GQPaHDI/bnq1hGxBaN+ahUrjeXv/tOMej57bIMZgZUO
         tlRfECqChnmsqvWyXG++KskbCYB5oAtqKjJMsnZbi2xDowyYL/xgr40mLvsZrCzRWusL
         Io1MXUQiGJn1Y861Zl7sqHvq53H7QFM3tVDanhwqlYfu3AskrbDh/5iTroR7XcEF9dfU
         I1NQ==
X-Gm-Message-State: ACrzQf0IL+7eJOrWQ2Um7ZPGn40exPBdPcCSP963xsz45KcA6dbokLWZ
        0MIUSZA6ksRu0GDJD6O/ej0fWjJ16iWJBw==
X-Google-Smtp-Source: AMsMyM70bPEoFjqnBA7hW9eopyxU56ujWG3zuAn+f0nb0idLgYPihAhriqyursIKP3kAuqO1OLxiD0JHKbIAbA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a0d:de83:0:b0:337:c0bf:12ee with SMTP id
 h125-20020a0dde83000000b00337c0bf12eemr52748126ywe.289.1667940214542; Tue, 08
 Nov 2022 12:43:34 -0800 (PST)
Date:   Tue, 08 Nov 2022 12:43:19 -0800
In-Reply-To: <b9e7e6b7-43f8-3b80-79ba-3ffc53bec7f8@gmail.com>
Mime-Version: 1.0
References: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
 <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com> <b9e7e6b7-43f8-3b80-79ba-3ffc53bec7f8@gmail.com>
Message-ID: <kl6lbkph41p4.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 0/8] clone, submodule update: check out submodule branches
From:   Glen Choo <chooglen@google.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe.

Thanks for spending time on the high level ideas (and not just the
code); it really helps to keep this logical and consistent.

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>> = Description
>> 
>> This series teaches "git clone --recurse-submodules" and "git submodule
>> update" to understand "submodule.propagateBranches" (see Further Reading for
>> context), i.e. if the superproject has a branch checked out and a submodule
>> is cloned, the submodule will have the same branch checked out.
>> 
>> To do this, "git submodule update" checks if "submodule.propagateBranches"
>> is true. If so, and if the superproject has the branch 'topic' checked out,
>> then:
>> 
>>  * Submodules are cloned without their upstream branches
>>  * The 'topic' branch is created in the submodule
>>  * The submodule is updated via "git checkout topic" instead of checking out
>>    the gitlink's OID.
>> 
>
> Currently, the description of submodule.propagateBranches is:
>
>     [EXPERIMENTAL] A boolean that enables branching support when 
>     using --recurse-submodules or submodule.recurse=true. Enabling this 
>     will allow certain commands to accept --recurse-submodules and certain 
>     commands that already accept --recurse-submodules will now consider branches. 
>     Defaults to false.
>
> I think with this series that description must be tweaked, because "git submodule update"
> does not qualify as a command that "now accepts --recurse-submodules", neither does
> it "already accept --recurse-submodules" but now changes behaviour to consider branches.
>
> It does change behaviour to "now consider branches", but never had anything to do with
> "--recurse-submodules".

Yes that's a good point, thanks.

>
> --8<--
>
>> 
>> = Future work
>> 
>>  * Patch 5, which refactors resolve_gitlink_ref(), notes that a better
>>    interface would be to return the refname instead of using an "out"
>>    parameter, but we use an "out" parameter so that any new callers trying
>>    to use the old function signature will get stopped by the compiler. The
>>    refactor can be finished at a later time.
>> 
>>  * Patch 5 uses the name "target" when we are talking about what a symref
>>    points to, instead of "referent" like the other functions. "target" is
>>    the better choice, since "referent" could also apply to non-symbolic
>>    refs, but that cleanup is quite big.
>> 
>>  * Patch 8 notes that for already cloned submodules, the branch may not
>>    point to the same OID as the superproject gitlink, and it may not even
>>    exist. This will be addressed in a more comprehensive manner when we add
>>    support for checking out branches with "git checkout
>>    --recurse-submodules".
>
>
> A few points I thought about while reading this version:

This is a good reminder for me to check in that doc I promised that
describes how branches in submodules would work. This is great feedback
for that work, though :)

>
> 1. There is always a possibility that the branch name in the superproject already exists
> in the submodule remote, but is a completely different topic (think of a branch named "refactor"
> for example). With this series (and propagateBranches=true), this would mean that 
> the initial submodule clone would create a local branch "refactor" that points to the gitlink
> in the superproject, and a remote-tracking branch "origin/refactor" that points to the unrelated
> submodule topic branch from the submodule remote. This could be confusing... but I don't
> really know what Git could do about it !

Yes.. I think submodule.propagateBranches requires a change in mental
model where submodule branch names have nothing to do with the
submodule's remote's branch names. It _might_ not be so confusing once
users have a grasp on that, but I recognize that that's quite optimistic
of me.

The biggest sources of confusion I see comes from remote-tracking,
either implicitly (e.g. "git checkout topic" when "topic" doesn't exist,
but "origin/topic" does) or manually (e.g. "git branch
--set-upstream-to"), because they'll see similarly-named remote and
local branches that have nothing to do with each other.

I can see some ways to address this, though they're not perfect:

- Remove the need for users to set up manual remote-tracking and disable
  implicit remote-tracking (possibly by using .gitmodules). 
- Block or warn on possibly confusing operations (e.g. don't allow users
  to create branches in the submodule directly)

> In patch 3/8 'git branch' is used to create the submodule branch from an oid, and so 
> it does not track any branch, and is not affected by 'branch.autoSetupMerge' as far as I 
> could test. But maybe this should be explicitely mentioned somewhere? 

I could mention it. For now, I don't see any reasonable way to respect
branch.autoSetupMerge, since there's no good way to map from 'submodule
remote branch' -> 'local submodule branch that's part of a superproject
branch'.

Between this and the previous section, perhaps we should think of
submodule branches as being fundamentally different from "regular"
branches..

> 2. The new "git submodule update" behaviour seems to only make sense with "--checkout", 
> which is the default "git submodue update" mode. But what if one uses "git submodule
> update --merge", or "--rebase", or has submodule.<name>.update set to a custom command
> or "none" ? Is the idea that these modes are incompatible with submodule branching ?
> I can understand that this gets really complex and might change when 'git merge' and 
> 'git rebase' themselves are taught to update submodule worktrees (and probably also submodule
> branches from what you refer to as future work), but in any case I think we should at 
> least test the new code when these options are used (if only to error out outright as
> incompatible)...

Ah, I should have been more explicit. Yes, I intend for the other modes
to be incompatible, so this should error out outright.

"git submodule update" is overdue for some refactoring IMO (at least for
internal use cases). It is quite badly overloaded - it peforms 3
different actions (clone missing submodules, fetch missing commits,
"update" worktree) and supports 4 different update strategies. In this
series, I was concerned mainly with "git clone --recurse-submodules",
and teaching "git submodule update --checkout" turned out to be a nice
side-effect, but because the "submodule update" API surface is so large,
we end up with this extra noise of how this new setting will interact
with the rest of API.

One goal of the Submodule UX (branches aside) is to remove the need for
manual submodule lifecycle management via "git submodule". For "git
submodule update", this would be:

- Teach fetch to clone missing submodules
- Teach fetch to fetch missing commits (I've done this already with my
  work on fetching in out-of-tree submodules)
- Teach checkout/reset to update working trees as we expect

I'm still not sure what to think of the merge/rebase/custom command
update strategies since they aren't simply "updating" the working tree.
My suspicion is that merge/rebase are more like partial implementations
of merge/rebase --recurse-submodules. The custom command is perhaps more
ofa way for users to orchestrate nonnative Git workflows on top of
submodules, so I don't feel bad about not supporting that at least.

> Thanks and cheers,
>
> Philippe.
