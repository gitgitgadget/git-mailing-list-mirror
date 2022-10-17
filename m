Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A087C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 13:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJQNNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 09:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiJQNNI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 09:13:08 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933BBCFD
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:13:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w18so18397870wro.7
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xXXBK9UKBgd4snFzD3v53kOV2dd/M/4d/GA4hlXxDWg=;
        b=FfXfXqLB5MhsNQWEV21WCB/x1/XBJHzUfCNnZ0BYy97NnD3yo0rrqaqgqP/+PTB2X2
         rKI0aYxXnZtpU0/cTGILHKhh7/3QtysrZkNqHr7/4Ny74SXULKWmEv1SoLcU6lUQATuc
         9Il2RVV25pWdGxoPR4xK25QLjuyFk0eOD83jOpyYCLdoBihEUkKX8siPQQEffWBtjDIz
         HbQOiuoCd7q2cGbosYbEk+jEVctXmO1eBBlM1cRAUoxSd93A9Fo5hhWyRV9hFZPjM5xQ
         K+PrgFXktBsnsMSYZ9t+rmh37g49ZOT7s9waKQbM0p0//qy0izUwATGXJ5GWxh8R0F4k
         zRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXXBK9UKBgd4snFzD3v53kOV2dd/M/4d/GA4hlXxDWg=;
        b=2H7dG2GJahBa1d0/MuD3uiDhawkKWKywLapd1hI67TIlKm8w+wp+7kpr36xM1OsNpT
         XrGJg6AsgXhF7hm4IKA/Uy5HjWN0328h22VGVZv1Az2cIjRuuXOsBLXn8E6ebSCY+IAe
         oRTSX+GIWRjuzO1ASyRfA9tJ6aNypWNIWPgzwehJSCHhi8L8VQcvvsktZeCEa1TsXFQM
         1o41o2HFhzzkSzTMrYFB+2Wsm7cGZAfuGFl79G1E6/bAN3+2NzYVQGQ74KgH6xmHTog3
         2qE+Jvxaos0O73NESo0eDhw58LQAJDPl/rU4uPQrXPflEplABMd9Psv5Ca3v8DDhebPu
         b1GA==
X-Gm-Message-State: ACrzQf0anvkILfkDXVP05wEXV0NTKiCNASroOA7/ku6JfmOOtBlIap2B
        st9HfWjRJsnXaRKOAnufGBI=
X-Google-Smtp-Source: AMsMyM4V82MNPoaIc0nngbAt3k0nAX4908v3Uju1sA5gfP7uZImDvn09aiqlw6NiPmfA1MHuQY7LDg==
X-Received: by 2002:a5d:6da7:0:b0:22e:3edb:e372 with SMTP id u7-20020a5d6da7000000b0022e3edbe372mr6296500wrs.137.1666012381081;
        Mon, 17 Oct 2022 06:13:01 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c500a00b003c6f0ebf988sm6794447wmr.30.2022.10.17.06.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 06:13:00 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <63c1636e-401d-89d3-9af3-69469dd4a3b0@dunelm.org.uk>
Date:   Mon, 17 Oct 2022 14:13:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 5/8] rebase: rename merge_base to branch_base
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
 <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
 <00f70c9034452bd87c82fb3aea9658aec32f2ec1.1665650564.git.gitgitgadget@gmail.com>
 <221013.86bkqfleh5.gmgdl@evledraar.gmail.com>
 <7b9d2a05-de2e-d0e0-6554-a592fa2349d4@dunelm.org.uk>
 <221017.86pmeqk6yl.gmgdl@evledraar.gmail.com>
In-Reply-To: <221017.86pmeqk6yl.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/10/2022 12:27, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Oct 17 2022, Phillip Wood wrote:
> 
>> On 13/10/2022 20:16, Ævar Arnfjörð Bjarmason wrote:
>>> On Thu, Oct 13 2022, Phillip Wood via GitGitGadget wrote:
>>>
>>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>>
>>>> merge_base is not a very descriptive name, the variable always holds
>>>> the merge-base of 'branch' and 'onto' which is commit at the base of
>>>> the branch being rebased so rename it to branch_base.
>>> To me "branch" means or has heavier implications of "named branch"
>>> than
>>> just a merge base, and this command is perfectly happy to work on
>>> commits disconnected from any named branch.
>>>> But more to the point, the rebase docs for --onto discuss a "merge
>>> base", so you'd read those, and then encounter this code talking about a
>>> "branch base", and wonder what the difference was...
>>
>> Aren't the docs saying the merge base is the base of the commits
>> (i.e. branch) being rebased? I don't think merge_base is a
>> particularly helpful name as it doesn't tell us what it is the merge
>> base of and branch_base was the best I could come up with. I see what
>> you mean in the detached HEAD case, but as the command also works with
>> named branches I hope it is fairly obvious what "branch_base" is in
>> the detached HEAD case.
> 
> It *optionally* works with a <branch>, but doesn't require one. E.g. try
> this on git.git:

Maybe I wasn't clear, I was referring to the fact that if HEAD isn't 
detached then it rebases the current branch not about the optional 
<branch> argument. I also think that the docs are for users, they are 
not a guide to the code. With this change if you search for merge_base 
in builtin/rebase.c you still find the part where we calculate the merge 
base. This commit was added in response to a review comment from Junio 
on V1, as far as I know he is happy with it and at this stage I'm 
disinclined to change it.

Best Wishes

Phillip

> 	git checkout origin/next
> 	touch f && git add f && git commit -m"file"
> 	git rebase --onto origin/master^{} HEAD~
> 
> Here we transplant a commit on top of "next" to "master", without either
> of those *names* being involved, or their branches, just the
> corresponding OIDs/tips.
> 
> That will go through e.g. can_fast_forward() which you're modifying
> here, and now populate a "branch_base" variable, instead of a
> "merge_base".
> 
> I know that we conflate the meaning of "branch" somewhat, even in our
> own docs. E.g. we sometimes use "branch" and "named branch", but usually
> by "branch" we mean "named branch", and otherwise talk about a detached
> HEAD, <commit> or "tip".
> 
> But in this case it's especially confusing in the post-image, because
> "git rebase --onto" explicitly uses an optional "<branch>" to
> distinguish the "named branch" case from the case where we're operating
> on detached a HEAD, or otherwise don't care about the "<branch>" (except
> as generic "restore us to where we were" behavior).
> 
> So, if anything I'd think that we'd want something like this in various
> places in git-rebase.txt to make the distinction clearer:
> 	
> 	diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> 	index 9cb8931c7ac..e4700a6e777 100644
> 	--- a/Documentation/git-rebase.txt
> 	+++ b/Documentation/git-rebase.txt
> 	@@ -18,7 +18,7 @@ DESCRIPTION
> 	 -----------
> 	 If `<branch>` is specified, `git rebase` will perform an automatic
> 	 `git switch <branch>` before doing anything else.  Otherwise
> 	-it remains on the current branch.
> 	+it remains on the current tip or named branch.
> 	
> 	 If `<upstream>` is not specified, the upstream configured in
> 	 `branch.<name>.remote` and `branch.<name>.merge` options will be used (see
> 
> But your post-image seems to be to make this sort of thing explicitly
> more confusing, and e.g. these parts:
> 
> 	@@ -206,8 +206,8 @@ OPTIONS
> 	 --onto <newbase>::
> 	 	Starting point at which to create the new commits. If the
> 	 	`--onto` option is not specified, the starting point is
> 	-	`<upstream>`.  May be any valid commit, and not just an
> 	-	existing branch name.
> 	+	`<upstream>`.  May be any valid commit, and not just an <-- this
> 	+	existing branch name. <--- this
> 	 +
> 	 As a special case, you may use "A\...B" as a shortcut for the
> 	 merge base of A and B if there is exactly one merge base. You can
> 
> To sum up why I find this confusing: Reading this from the docs onwards
> I'd think (as is the case) that "<branch>" is optional. Then when I read
> the code I'd think a "branch_base" is something that *only* had to do
> with the "<branch>" case.
> 
> But that's not the case, it's just a generic "merge base" in the same
> sense that "git merge-base" accepts all of these
> 
> 	$ git merge-base origin/master origin/next
> 	d420dda0576340909c3faff364cfbd1485f70376
> 
> (These two are equivalent, just demo'ing that we don't need the peel
> syntax):
> 
> 	$ git merge-base $(git rev-parse origin/master) $(git rev-parse origin/next)
> 	d420dda0576340909c3faff364cfbd1485f70376
> 	$ git merge-base origin/master^{} origin/next^{}
> 	d420dda0576340909c3faff364cfbd1485f70376
> 
> What *would* make things much clearer is e.g. calling a variable
> "branch_merge_base" *if* there is a case where that's a merge base only
> for named branches, but I don't know (and didn't look carefully enough)
> if you've got such a case or cases here. It just seems like a generic
> "merge-base".
> 
> 
