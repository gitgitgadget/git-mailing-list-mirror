Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A75FC433FE
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 11:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351957AbiBHLcL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 06:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357056AbiBHLV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 06:21:59 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A33C03FEC0
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 03:21:57 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso1357733wms.4
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 03:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UCpGw2msGkOXbDv7VR55Yik2HOEzcqr7XCIp2JY9dBI=;
        b=AObEeBhfT4y5Ys1SwWTK6oOD3TQZna1fA+R7F9SMjHFAB17uBAb/muIIpdiGb5WuvX
         KigcpA61huC5RZfPoipTpwZvY7tfwJ738fGpIXxFC9iiW+UtlrGwXD1/pZYFMOO3p3Ba
         qyEPrFYXd8FFj50xLVgbzmnh4y3tNStMM7Csl5391gB/drirrHpR/HZwAWmfwI20wLBh
         HoOBoQsBALuygIjDiZGh9ie8lokdP0NFs5zBW6fpMHgbpCUnCz3tOoGvcYDZeaTIqUr7
         N7Vkc7c4APcToEggDHauxtRjlP2R9CzcpDfzokLdY7kNCz0Tk5RWeXw/m5vBkVFLhF7t
         PLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UCpGw2msGkOXbDv7VR55Yik2HOEzcqr7XCIp2JY9dBI=;
        b=63fGuHHH1A9RVuPEeypM6hqVmtSOTTgyDxMjW/Vs02CJ6z0UPfBieuz8tR7uheLXH1
         Ez8nJzF3s8jPsfB1QztOkPl14LJbDAr89/6hM43W0BeKNXcsTc+LI54MEhRe5qxU0Gjj
         XrrcHCkVAPYK1mJyB7kl/FcIueSS5ht5wdBY58dOyGs1wpM483HSQ4bgfzOA9MnipL8L
         ojikMvzFIE+du/SzxMlBVkcrT3KZs7MHfEtXNFr/4nNqnpNkd53CznqW0RMZeIYd3mcg
         vozOmYqVIZOj/1o2Tr/mVg7iD5Sa4n+sIwWvDoucwTDYvq+UCh1XMRSRTYMhoak1igb8
         hGtw==
X-Gm-Message-State: AOAM532HuchGyxwrzbdxeBp4+98yQxDGVpYeA6AvRdko/NUVyTqQGNM1
        FLubJJj7lBxH4aWydKN/0ao6nqCHVBA=
X-Google-Smtp-Source: ABdhPJyYzA1XZAkPBWtQNkoFcVluwNhIhNN57IfeBPHi4ikY1/x+UQpB3jzssCRxdftm6dZKc01wqw==
X-Received: by 2002:a05:600c:4ed3:: with SMTP id g19mr726680wmq.186.1644319315318;
        Tue, 08 Feb 2022 03:21:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q13sm12758887wrd.78.2022.02.08.03.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 03:21:54 -0800 (PST)
Message-Id: <pull.1139.v2.git.1644319314.gitgitgadget@gmail.com>
In-Reply-To: <pull.1139.git.1644277797.gitgitgadget@gmail.com>
References: <pull.1139.git.1644277797.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Feb 2022 11:21:52 +0000
Subject: [PATCH v2 0/2] checkout/fetch/pull/pack-objects: allow -h outside a repository again
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As reported in https://github.com/git-for-windows/git/issues/3688, calling
git fetch -h outside a repository now results in a very ugly

 BUG: repo-settings.c:23: Cannot add settings for uninitialized repository


The reason is that the prepare_repo_settings() calls (that we introduced to
support sparse index) assume that there is a gitdir, but the hack to allow
parse_options() to handle -h even outside a repository invalidates that
assumption.

One strategy I considered was to move the prepare_repo_settings() calls
after parse_options(). This would work because when parse_options() handles
-h, it exits without returning.

However, this strategy failed in my tests because e.g. cmd_unpack_objects()
does need the pack_use_sparse to be populated correctly before even parsing
the options so that it can be overridden via --sparse/--no-sparse.

Hence the current strategy where the code that prepares the repo settings
and then accesses them is guarded behind the condition that we must have a
gitdir to do so.

Note: There are other instances where prepare_repo_settings() is called
before parse_options(), e.g. in cmd_status(), in seen there are even more
instances (e.g. cmd_checkout_index()). All of those instances that are not
touched by this here patch do have special code to handle -h early, though,
before calling prepare_repo_settings() let alone parse_options().

Johannes Schindelin (2):
  checkout/fetch/pull/pack-objects: allow `-h` outside a repository
  t0012: verify that built-ins handle `-h` even without gitdir

 builtin/checkout.c     | 7 ++++---
 builtin/fetch.c        | 6 ++++--
 builtin/pack-objects.c | 8 +++++---
 builtin/pull.c         | 6 ++++--
 t/t0012-help.sh        | 7 ++++++-
 5 files changed, 23 insertions(+), 11 deletions(-)


base-commit: 4c53a8c20f8984adb226293a3ffd7b88c3f4ac1a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1139%2Fdscho%2Fprepare_repo_settings-after-parse_options-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1139/dscho/prepare_repo_settings-after-parse_options-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1139

Range-diff vs v1:

 1:  25d1a2963f2 ! 1:  6e9cdd10a70 checkout/fetch/pull/pack-objects: allow `-h` outside a repository
     @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
       
       	argc = parse_options(argc, argv, prefix,
       			     builtin_fetch_options, builtin_fetch_usage, 0);
     -+
     - 	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
     - 		int *sfjc = submodule_fetch_jobs_config == -1
     - 			    ? &submodule_fetch_jobs_config : NULL;
      
       ## builtin/pack-objects.c ##
      @@ builtin/pack-objects.c: int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 2:  49977ff9f4e = 2:  93df4a73dab t0012: verify that built-ins handle `-h` even without gitdir

-- 
gitgitgadget
