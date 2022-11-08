Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F21C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 14:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbiKHOZZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 09:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbiKHOZE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 09:25:04 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CD06389
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 06:23:37 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id k2so9136828qkk.7
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 06:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzBVnGuAfjVoUdDPReJcHyOb2XEEXHB5HJYsG3wh4NI=;
        b=oPwTfyg44vsQ6ZXlcr6NTqwLMeR+9fCDSruZeGEhQgyxGYzCcs9t891158nD+5vePG
         yUUvI/ybJwUPRwQrtyoXX6mr1RJ9ABEiYSA1vPpd7k87rMHOmfklbgNdKgRISo6PoWNy
         3u8X5TRArLCyCTmWmWWvl7ayEncCl8Zt8oS8eb34j7hKTaoB3JLf+fXV34Z/dxmantek
         yk2GttKBFNna9SB+AMBaf1Cu21oxV1An2MCfrB/Ay4PZ25s/zdhL0ZuBIRnWS+z6wUin
         1Sqiot2wGhk3ABypYSnSnpwvPTypPNchom5azlMsdD6TdfamThxylrLWtWEkN83PI9nE
         mU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzBVnGuAfjVoUdDPReJcHyOb2XEEXHB5HJYsG3wh4NI=;
        b=tfLKf/+yYT+udq2N7SURM7CXxJ13JTKS8PH13qCDwUNUmweoeeizWCtmfDeBz3l6r7
         8llU/AP7atAvZzTuIFF/WyBnQWAQ/HBdUFX8zVgKNujRs1uqWTp3uawHlHsLpZ7LkZFC
         5sYVA7cgXE263kjAMVj1y88oBLVYEwZu8oiL8JzZoRlbEHPERHaCMruhYdaH+5n8KoPv
         DwaSMir2upWm2cDf/8Zz9Ts2ufmq/fdleZXVMpgw2SXNqXzzJmM0fUvdITX3xuqPl3+M
         beBfa5jNl/TIPf19y7o6TQz4OVSFWSrpE9CGpZVS27QcbVMdEk4STtcZ03jn0SwQLW7J
         ValQ==
X-Gm-Message-State: ACrzQf3P2aFEhvhQtiHcfP8BB0ucFh9qMm844xC9YT2V/o+hqT1kuIwS
        jmxCyOaJyCNQCaxizGmNIxE=
X-Google-Smtp-Source: AMsMyM56onv1qpvwFeyxzbSqjY23MMCb4LsvRV+OwCDN7Z9ntKfxhT4Em8WEloE9qMoC6pAIMjtRbQ==
X-Received: by 2002:a37:a44:0:b0:6fa:11f4:392 with SMTP id 65-20020a370a44000000b006fa11f40392mr38925197qkk.381.1667917416955;
        Tue, 08 Nov 2022 06:23:36 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id bi37-20020a05620a31a500b006f956766f76sm9392649qkb.1.2022.11.08.06.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 06:23:36 -0800 (PST)
Subject: Re: [PATCH v3 0/8] clone, submodule update: check out submodule
 branches
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>
References: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
 <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <b9e7e6b7-43f8-3b80-79ba-3ffc53bec7f8@gmail.com>
Date:   Tue, 8 Nov 2022 09:23:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen,

Le 2022-10-28 à 16:14, Glen Choo via GitGitGadget a écrit :
> This version has relatively few changes, and should address all of
> Jonathan's comments (thanks!).
> 

I was not able to take a look before now, but I think the suggestions by Jonathan
on v2 make a lot of sense, especially adding more tests in the last patch.
Thanks for these additional tests.

I have a few comments/questions on the overall design, which I'll write up 
at the end of this reply since they are more general.
> = Description
> 
> This series teaches "git clone --recurse-submodules" and "git submodule
> update" to understand "submodule.propagateBranches" (see Further Reading for
> context), i.e. if the superproject has a branch checked out and a submodule
> is cloned, the submodule will have the same branch checked out.
> 
> To do this, "git submodule update" checks if "submodule.propagateBranches"
> is true. If so, and if the superproject has the branch 'topic' checked out,
> then:
> 
>  * Submodules are cloned without their upstream branches
>  * The 'topic' branch is created in the submodule
>  * The submodule is updated via "git checkout topic" instead of checking out
>    the gitlink's OID.
> 

Currently, the description of submodule.propagateBranches is:

    [EXPERIMENTAL] A boolean that enables branching support when 
    using --recurse-submodules or submodule.recurse=true. Enabling this 
    will allow certain commands to accept --recurse-submodules and certain 
    commands that already accept --recurse-submodules will now consider branches. 
    Defaults to false.

I think with this series that description must be tweaked, because "git submodule update"
does not qualify as a command that "now accepts --recurse-submodules", neither does
it "already accept --recurse-submodules" but now changes behaviour to consider branches.

It does change behaviour to "now consider branches", but never had anything to do with
"--recurse-submodules".

--8<--

> 
> = Future work
> 
>  * Patch 5, which refactors resolve_gitlink_ref(), notes that a better
>    interface would be to return the refname instead of using an "out"
>    parameter, but we use an "out" parameter so that any new callers trying
>    to use the old function signature will get stopped by the compiler. The
>    refactor can be finished at a later time.
> 
>  * Patch 5 uses the name "target" when we are talking about what a symref
>    points to, instead of "referent" like the other functions. "target" is
>    the better choice, since "referent" could also apply to non-symbolic
>    refs, but that cleanup is quite big.
> 
>  * Patch 8 notes that for already cloned submodules, the branch may not
>    point to the same OID as the superproject gitlink, and it may not even
>    exist. This will be addressed in a more comprehensive manner when we add
>    support for checking out branches with "git checkout
>    --recurse-submodules".


A few points I thought about while reading this version:

1. There is always a possibility that the branch name in the superproject already exists
in the submodule remote, but is a completely different topic (think of a branch named "refactor"
for example). With this series (and propagateBranches=true), this would mean that 
the initial submodule clone would create a local branch "refactor" that points to the gitlink
in the superproject, and a remote-tracking branch "origin/refactor" that points to the unrelated
submodule topic branch from the submodule remote. This could be confusing... but I don't
really know what Git could do about it !

In patch 3/8 'git branch' is used to create the submodule branch from an oid, and so 
it does not track any branch, and is not affected by 'branch.autoSetupMerge' as far as I 
could test. But maybe this should be explicitely mentioned somewhere? 

2. The new "git submodule update" behaviour seems to only make sense with "--checkout", 
which is the default "git submodue update" mode. But what if one uses "git submodule
update --merge", or "--rebase", or has submodule.<name>.update set to a custom command
or "none" ? Is the idea that these modes are incompatible with submodule branching ?
I can understand that this gets really complex and might change when 'git merge' and 
'git rebase' themselves are taught to update submodule worktrees (and probably also submodule
branches from what you refer to as future work), but in any case I think we should at 
least test the new code when these options are used (if only to error out outright as
incompatible)...

Thanks and cheers,

Philippe.
