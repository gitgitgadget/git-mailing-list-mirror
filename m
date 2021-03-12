Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2836C433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 20:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9239F64F80
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 20:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhCLUdc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 15:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbhCLUdI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 15:33:08 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0462EC061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 12:33:08 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id e2so7211691pld.9
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 12:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LKWkYLPKBRzIF4vKl5/chnKgRDXUxDeAb33jc8gi6nE=;
        b=It8ha1tLwMTRFK7xTepQ7FbOzsPjAo5rESJrohVunAR3Byx5Nb4WEIstzWux34hf3p
         kuRo6PlYNwkS+GCIkMpp5iXoEE4nIiI8YnJRbtJKa322PhpYp00FCx9rRMxfbdkOj40x
         nnAdn9l4IC8+9h3/gKjZXzzZW6bDaUSXAeHIcF8wck1RJPcMYxRZTKkOVzURcns82+FR
         VEJeVRCjGixg46EK4HqaEkr4xyS4XwJlEfj6hQ1eVE01/XDxiLHSWK7QBpnLUAAfqbf5
         iYML7w4Hgv9k1g1Cwv/S1xSvd9gTNWnMp+eYkLviUbVJ+V9Or2z/OqzdWXCEzuOD37US
         Psjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LKWkYLPKBRzIF4vKl5/chnKgRDXUxDeAb33jc8gi6nE=;
        b=P99Jps9SC6Ma5uV3sY8zF+jH7IKeYJnzi2odPyli5xTWZsnv0ENzK0CG272fJ8WQcJ
         yv7SXiXBhGvZkHLOBQOKji1+MO12VJkaphMYNvrcpPfgVqucSH5lh4pEhUQSymDhHlNC
         5qEkEnWm2JVe1zoynoj4uzBtoiDjh2fPMeyp2dkYYWnQqF9IsEGFMWBsnv5/9gi7Ot9u
         zZPW/8NJd+eKCqUthc+1BEF6HWhrCZO9xoueLJtrtP37mBV/ezdX1Ij4CPwdwXWH55XV
         jCwIT1lcjt0iVgenpf6O4HclBo+wrghaStE9yVJ4u+dBmArcPk0ETJNuYhSniEPXE+Qs
         ABlw==
X-Gm-Message-State: AOAM531ZVYyElerGEU5bdPeGK+2e9WoqNKqwftt6ITTL0MB7HSAtRFm2
        CiiJZ5FOYn/P5kP6pqjGF2xwMg==
X-Google-Smtp-Source: ABdhPJygOd6OG01ZF0kzPotfVXiDRofh+z1t+kAhIr8xFzPxmCVj3zlbb0xpdRhgN4oFUIdPukwPnw==
X-Received: by 2002:a17:90a:8409:: with SMTP id j9mr105048pjn.86.1615581187357;
        Fri, 12 Mar 2021 12:33:07 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:b463:c495:6445:6cb3])
        by smtp.gmail.com with ESMTPSA id g18sm6357899pfb.178.2021.03.12.12.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:33:06 -0800 (PST)
Date:   Fri, 12 Mar 2021 12:33:00 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff King <peff@peff.net>
Subject: Re: What to do with fsmonitor-watchman hook and config-based hooks?
Message-ID: <YEvP/ObHqhaLaSG1@google.com>
References: <CAJoAoZk0fSyPSJZ51wNv4XujPA_-hPfh8eMRQPbyeTXFvKJ9+Q@mail.gmail.com>
 <33a12a7a-d19c-63b8-f21e-db7e517b0f53@gmail.com>
 <YEpxVELGCxtnNxQK@google.com>
 <e019cc71-ac39-44a4-0a23-b3b7decec754@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e019cc71-ac39-44a4-0a23-b3b7decec754@jeffhostetler.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 12, 2021 at 11:51:38AM -0500, Jeff Hostetler wrote:
> I don't think it makes sense to have multiple fsmonitors for a given
> working directory.  They are fairly expensive to operate (listening
> to the kernel for events and building an in-memory database of changed
> files) and I'm not sure how two running concurrently (and listening to
> the same kernel event stream) would come up with different answers.
> 
> The thing about the fsmonitor-watchman or query-watchman hook is that
> it is a bash/perl script that talks to a long-running service daemon.
> The hook script itself is just a proxy to decode the JSON response from
> Watchman and emit it on stdout in a way that the foreground Git command
> expects.  Git cannot directly talk to Watchman because it doesn't
> currently have the plumbing to talk to it on anything other than a fd
> pair that it sets up to give to the hook child.
> 
> So your example of a watcher for NTFS and a separate watcher for ext4
> means you could maybe have two services running, but the foreground
> Git command would only need to spawn a single hook and maybe it would
> decide which service to talk to based upon the filesystem type of the
> working directory.  Or you set the repo-local config for each repo to
> point to a hook script that knew which service to talk to.  Either way
> you only need to invoke one hook.

Thanks, that makes a lot of sense!

> Setting it globally is an option, but fsmonitor is beneficial for large
> repos and working directories.  There is an overhead to having it
> running and talking to it.  (Spawning a hook written in PERL, having
> the hook talk to Watchman via some form of IPC, the hook parsing the mess of
> JSON returned, pumping that data back over stdout to Git, and
> having Git apply the results to the ce_flags.)  All of that has to
> happen *before* Git actually starts to do anything useful.  For small
> repos, all of that overhead costs more than the cost of letting the
> foreground `git status` just lstat() everything.  Of course all of this
> depends on the speed of your filesystem and the size of your working
> directory (and whether you have a sparse-checkout and etc), but there
> are lots of repos that just don't need fsmonitor.
> 
> So yes, I would leave the existing fsmonitor code as is and not try
> to combine it with your current efforts (even if I wasn't working on
> a replacement for the fsmonitor-watchman setup).
> 
> As Stolee mentioned I'm currently working on a builtin fsmonitor
> feature.  It will have a native coded-in-Git-C-code daemon to watch
> the filesystem.  Clients, such as `git status`, will directly talk
> to it via my "Simple IPC" patch series and completely bypass all of
> the hook stuff.
> 
> Long term both fsmonitor solutions can co-exist.  Or we can eventually
> deprecate the hook version.  Given that, I don't see a need to change
> the existing fsmonitor hook code.

Yeah, that seems like the direction everyone agrees with. Thanks very
much for the detailed explanation, that helped me feel sure that doing
nothing is the right approach (how convenient...) :)

I think, then, all that's needed is a patch to the githooks.txt doc 1)
removing the incorrect info about core.fsmonitor's contents needing to
point to a specific name in .git/hooks/ and 2) explaining that because
it uses this special config, it doesn't use the usual hook.*.command
approach.

 - Emily
