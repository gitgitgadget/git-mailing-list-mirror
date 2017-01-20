Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 574741F89C
	for <e@80x24.org>; Fri, 20 Jan 2017 11:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbdATLXa (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 06:23:30 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:38382 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751961AbdATLX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 06:23:28 -0500
Received: by mail-it0-f43.google.com with SMTP id c7so17445128itd.1
        for <git@vger.kernel.org>; Fri, 20 Jan 2017 03:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Kypo8OA12SmWIUZMUnWTv/x5nL/YTswWxCQSQea2Jkc=;
        b=skr4bpLeMuuAzzrf3kxhvyznhv2P4KTFEvRWMZSZGMk/apN8DqHnd6GNSysAtBmOgO
         Ybw3H9LVbVqoCUN8CL+PWO87Nnb1hka3cm5NyA71+EJ3lO2FuB7A0p0gG2vFSN8ePR7y
         MBYaBN/A7IDBmhp7Fo4WvX/NleEvYTxaq5Vg4EP1Eeqa7W24Iebu/UHocOhVG+GQfKDO
         cZ93Pi8evXX9ekT0tS/JI2jxt8AY7dEuHB13OxTv2OcQkb65iwrDYG8DceC1yHJ5AH8K
         Gd+2aaomKkKxAuPP4aTQ0BotjFBM60Devl4pqxU06poN982IqIioHxt1Tpn0IMkH8plW
         QmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Kypo8OA12SmWIUZMUnWTv/x5nL/YTswWxCQSQea2Jkc=;
        b=e7hfRGBdSRxtRbQC863ZapjFczOXjJimDbspdvavx2Ubb1g0S1imU1TSdMjcE8G9/K
         n+QABe6UxYivzc15e4OCb1OB4gNkqvzI8lbljNl3083VLeYzJ0FAov3dGhUpmiL+/Pet
         HPtdfylijuaAKtFkrbzNv5PmuvTcZKZWEa97verFFWZMKvcEhOk/q0P1ij4ZU+HA7sl5
         GH+mVHyCdn+RWbcy7V0VTE9gCDe4tQBgbHhw7kuOSXtdZwKwn2KYgGvBY4ge/PblhDlu
         989jMVk8rkKUO+Xni0Ladxul5GH0CgJ70Mwwv34EveYBBoj2XpcocA058OIwAFIBh9jK
         +H+w==
X-Gm-Message-State: AIkVDXLRCA0wrk/uQvANt2e40BNBr/AgGqHNMV2KrGKF5+Sxajo0dHKFzeKygvqYuPtMmAnZhGLOof9qbniiog==
X-Received: by 10.36.118.133 with SMTP id z127mr3079380itb.74.1484911407982;
 Fri, 20 Jan 2017 03:23:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Fri, 20 Jan 2017 03:22:57 -0800 (PST)
In-Reply-To: <341999fc-4496-b974-c117-c18a2fca1358@alum.mit.edu>
References: <CACsJy8CHoroX2k9GqOFmXkvvPCPN4SBeCg+6aC2WSWNSKVmWQw@mail.gmail.com>
 <341999fc-4496-b974-c117-c18a2fca1358@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 20 Jan 2017 18:22:57 +0700
Message-ID: <CACsJy8AkLMG6SSgu0KP6C4GSt1hUu0bjqavpVSsS-qQ90wbKcA@mail.gmail.com>
Subject: Re: The design of refs backends, linked worktrees and submodules
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 8:30 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> I kindof think that it would have been a better design to store the
> references for all linked worktrees in the main repository's ref-store.
> For example, the "bisect" refs for a worktree named "<name>" could have
> been stored under "refs/worktrees/<name>/bisect/*". Then either:
>
> * teach the associated tools to read/write references there directly
> (probably with DWIM rules to make command-line use easier), or
> * treat these references as if they were actually at a standard place
> like `refs/worktree/bisect/*`; i.e., users would need to know that they
> were per-worktree references, but wouldn't need to worry about the true
> locations, or
> * treat these references as if they were actually in their traditional
> locations (though it is not obvious how this scheme could be expanded to
> cover new per-worktree references).

Well. In one direction, we store everything at one place and construct
different slices of view of the unified store. On the other far end,
we have plenty of one-purpose stores, then combine them as we need.
It's probably personal taste, but I prefer the latter.

Making a single big store could bring us closer to the "big number"
problem. Yeah we will have to handle million of refs anyway, someday.
That does not mean we're free to increase the number of refs a few
more times. Then there are separate stores by nature like submodules
(caveat: I haven't checked out your submodule-hash branch), or the
problem with multiple repos sharing objects/info/alternates.

> This is a topic that I have thought a lot about. I definitely like this
> direction. In fact I've dabbled around with some first steps; see branch
> `submodule-hash` in my fork on GitHub [1]. That branch associates a
> `ref_store` more closely with the directory where the references are
> stored, as opposed to having a 1:1 relationship between `ref_store`s and
> submodules.

Thanks. Will check it out.

> Let me braindump some more information about this topic.
> ...

Juicy stuff :D It's hard to know these without staring really long and
hard at refs code. Thank you.

> I've taken some stabs at picking these apart into separate ref stores,
> but haven't had time to make very satisfying progress. By the time of
> GitMerge I might have a better feeling for whether I can devote some
> time to this project.

I think sending WIP patches to the list from time to time is also
helpful, even if it's not perfect. For one thing I would know you were
doing (or thinking at least, which also counts) and not stepping on
each other. On my part I'm not attempting to make any more changes (*)
until after I've read your branches.

(*) I took git_path() out of refs code and was surprised that multi
worktree broke. Silly me. Wrong first step.
-- 
Duy
