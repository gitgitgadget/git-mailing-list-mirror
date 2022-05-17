Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AA1C433EF
	for <git@archiver.kernel.org>; Tue, 17 May 2022 18:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344313AbiEQS4l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 May 2022 14:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352388AbiEQS4e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 14:56:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A487E1583A
        for <git@vger.kernel.org>; Tue, 17 May 2022 11:56:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v140-20020a252f92000000b0064d955c7b4eso4210906ybv.18
        for <git@vger.kernel.org>; Tue, 17 May 2022 11:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bt6RHZwbyq0s7LDDyrHRkXoWzCRQhBm+Hs5Lnsm1ZJo=;
        b=R5mUw5vOXgU65SmfxV6I3Sm4QOzjAulwJ4w4noS2yBo96Q9N2wS7XC95gX50xtjfVC
         qJXQDidvgWZ8KEbnMkE9rduANlekyz9hSKRNgkNq0UTDnIs8U1dzuGkcp17RDXHyo6RC
         wty7V8drgjXUz9vzNKVElXBDpskAelvtTCLEmPtI7K+aQIKPFh3jRdHHPPanBmnZP6FQ
         0u4Bem5XK9zoGHHzwDNVwbGrAhz1SZi0TlJIQau6BkZcGB3GdX4s3I6GzBcLQgNOr9LM
         18qvEjbuiOaEplK3hCH8JXvhKtfTTBjm75xsAJVKWOLq2gmDr4617ZlqUh7CfmdRieXJ
         HtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bt6RHZwbyq0s7LDDyrHRkXoWzCRQhBm+Hs5Lnsm1ZJo=;
        b=cegBVbHfLEPHHVj65JIy6wVTef0EIHsnh4nYq4pRqy6RtcNd4LYjyDRwUcLQLT5T+/
         aS2MA30riWB2PERan1jOfxilyoHkrBt3+S6fArR095FOkuRQbmq1+VHMNrITMZfAJlE1
         Ndh6t4/FCcZwni56jCKX9JI9VlnNAF/81Or04Mps+KcavVIXknT9mk3PSWvQ5FK017A8
         /la5yPbhFSr3MY7+1DL5kkt1U360WRZFEPMRnxuVFG+lLuB2+KNrvk6I9Mwlut4kk4P1
         T25naHIw4QF3l2FbC3IRQxrG1Q5qdDqk+XXP6k8z40iZZsckWQ+VpSr8XgoXYCr5ae9G
         7c1A==
X-Gm-Message-State: AOAM533/SIn1l6kVZgpd9noLnanFkoj1Yesel5caau+SBDfmmbaKoVo3
        9TbIIj9Ui7Lp2bs+OcVUJsLyw4uB5QIsJA==
X-Google-Smtp-Source: ABdhPJwFoKHA4gEFEA1yA82yojNZ6wvEs/0EBWecvBci/Njzv15xPq77OM4xpE8857lidsWxO5UzL1zi9mcLvQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6902:1007:b0:649:7745:d393 with SMTP
 id w7-20020a056902100700b006497745d393mr24520341ybt.407.1652813791656; Tue,
 17 May 2022 11:56:31 -0700 (PDT)
Date:   Tue, 17 May 2022 11:56:29 -0700
In-Reply-To: <5b969c5e-e802-c447-ad25-6acc0b784582@github.com>
Message-Id: <kl6llev0htsy.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
 <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com> <5b969c5e-e802-c447-ad25-6acc0b784582@github.com>
Subject: Re: [PATCH v2 0/2] setup.c: make bare repo discovery optional
From:   Glen Choo <chooglen@google.com>
To:     Derrick Stolee <derrickstolee@github.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thanks, I think this has advanced the conversation quite a bit.

Derrick Stolee <derrickstolee@github.com> writes:

> On 5/13/2022 7:37 PM, Glen Choo via GitGitGadget wrote:
>> Thanks all for the comments on v1, I've expanded this series somewhat to
>> address them,...
>
> Please include a full cover letter with each version, so reviewers
> can respond to the full series goals.
>
> Your series here intends to start protecting against malicious
> embedded bare repositories by allowing users to opt-in to a more
> protected state. When the 'discovery.bare' option is set, then
> Git may die() on a bare repository that is discovered based on
> the current working directory (these protections are ignored if
> the user specifies the directory directly through --git-dir or
> $GIT_DIR).
>
> The 'discovery.bare' option has these values at the end of your
> series:
>
> * 'always' (default) allows all bare repos, matching the current
>   behavior of Git.
>
> * 'never' avoids operating in bare repositories altogether.
>
> * 'cwd' operates in a bare repository only if the current directory
>   is exactly the root of the bare repository.

My mistake, I should have prepared this summary myself. Thanks again.

> It is important that we keep 'always' as the default at first,
> because we do not want to introduce a breaking change without
> warning (at least for an issue like this that has been around
> for a long time).

Yes.

> The 'never' option is a good one for very security-conscious
> users who really want to avoid problems. I don't anticipate that
> users who know about this option and set it themselves are the
> type that would fall for the social engineering required to
> attack using this vector, but I can imagine an IT department
> installing the value in system config across a fleet of machines.

Yes. Setting the 'never' option in a system config is the use case that
motivated this.

> I find the 'cwd' option to not be valuable. It unblocks most
> existing users, but also almost completely removes the protection
> that the option was supposed to provide.

Ok, I agree that it provides next-to-no protection. I'll drop it in this
series; it's easy enough to reimplement if users really want it anyway.

> This leads to what I think would be a valuable replacement for
> the 'cwd' option:
>
> * 'no-embedded' allows non-embedded bare repositories. An
>   _embedded bare repository_ is a bare repository whose parent
>   directory is contained in the worktree of a non-bare Git
>   repository. When in this mode, embedded bare repositories are
>   not allowed unless the parent non-bare Git repository has a
>   'safe.embedded' config value storing the path to the current
>   embedded bare repository.
>
> That was certainly difficult to write, but here it is as
> pseudo-code to hopefully remove some doubt as to how this might
> work:
>
>   if repo is bare:
>     if value == "always":
>        return ALLOWED
>     if value == "never":
>        return FORBIDDEN;
>
>     path = get_parent_repo()
>
>     if !path:
>        return ALLOWED
>     
>     if config_file_has_value("{path}/.git/config", "safe.embedded", repo):
>        return ALLOWED
>
>     return FORBIDDEN
>
> With this kind of option, we can protect users from these
> social engineering attacks while providing an opt-in protection
> for scenarios where embedded bare repos are currently being used
> (while also not breaking anyone using non-embedded bare repos).

[...]

> This 'no-embedded' option is something that I could see as a
> potential new default, after it has proven itself in a released
> version of Git.

I agree, this sounds like a good default that should work for most
users.

That said, I don't think I will implement it, and even if I do, it won't
be in this series. I have serious doubts that I'd be able to deliver it
in a reasonable amount of time (I tried preparing patches to this effect
and failed [1]), and 'never' is sufficient for $DAYJOB's current needs.

I would be very happy to see this come to fruition though. I have no
objections to anyone preparing patches for this, and I'll gladly review
those if that's helpful.

[1] The specific trouble I had was figuring out whether or not the
 'parent' repo was tracking the bare repo, since an untracked bare repo
 in the working tree isn't (in some sense) really "embedded" and it
 can't have come from a remote.

 But maybe the tracking check is unnecessary. We would break a few more
 users without it, but 'safe.embedded' is an easy enough way for a user
 to unbreak themselves.

> I mentioned some other concerns in your PATCH 1 about how we
> are now adding the third use of read_very_early_config() and that
> we should probably refactor that before adding the third option,
> in order to avoid additional performance costs as well as it
> being difficult to audit which config options are only checked
> from these "protected" config files.

Makes sense. I'll ask about specifics on that subthread.

>
> Thanks,
> -Stolee
