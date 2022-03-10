Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC76FC433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 22:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243678AbiCJW0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 17:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiCJW0U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 17:26:20 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D952715720F
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:25:18 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id c4so5953531qtx.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=f2BuXQAlexrQmm4vMEj2e9qbxv4yFo19p0vXGwyoRxM=;
        b=TjRf/E1AIHbyCc5ILjNKk25OySw9QvG4y1xF64euJTlt1v1/GCJWov8ERB9RRZnZut
         rp4NkTP5WjsyIK4ZkCR99DPAeg1aK4k4/pRB8u5vZkG1hx5Y/W0Ws1ZjLcUb6TAwojkH
         AAVuhKdBvxhenIkJE4xuJkHFyTEOT6Bezd4yreJBvuQnvDMd7+HKvPEq430bb1vXIFFb
         QKVYAhs4jEUiqRgs98aITTv85TyPAf94SkHZXnfDDI2M8dV022ZTtEVcEzb3xwql6qSe
         GrVOIXtRam66Ras20artZ7mWBLir7Ss/fKpxxvPGbK0hKL1CRx9XpfAQZlL9+yhqVhss
         u35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=f2BuXQAlexrQmm4vMEj2e9qbxv4yFo19p0vXGwyoRxM=;
        b=y17X3wgRJ7PlnDLshC+/ZFEq7G1DTV3K9ySddvqBPnoRsLsTL5WWaEGwdo5HWt6r3t
         SYObDWCeL1gLIL4qA+Ly+KGSuB1yBTfcOcQOXwkS2anZPbs2u7yumuLrmfoSZhlOe1AQ
         kf2BvD/jPzFp+yOwciulvbIxcWF5P56JCHFbXctmF9xG5aYGAjFYMu/TioheE1iXfsEq
         tL7rTDX3O57LRWHUn2zEDaWxoGoZQ5BdMo+brRVZGUFWvsKhxZlFRGOB70/8SSyYfKeL
         bRfXeOh5oPFUmgj5zfPUvnVF0qvl/shngfo7KdH5gGeW+4afMv5PAlRv34/O2VZg+X7E
         FxyA==
X-Gm-Message-State: AOAM532sE4WifUVbKh9g4ImUPvrv3samtGRhEuyn/XKzbwxPDZ8qfBh6
        9i5HvW2IuWHkMpOsNxthtcEl76sn2ss=
X-Google-Smtp-Source: ABdhPJxL4kDluiiElGyQVdwXnqq1LJKGB7n//qZT06ZhejUEtpjYNdplsaQzdLAJNtP+3VxLL0QgVQ==
X-Received: by 2002:ac8:5808:0:b0:2de:1cef:65c8 with SMTP id g8-20020ac85808000000b002de1cef65c8mr5987497qtg.33.1646951117853;
        Thu, 10 Mar 2022 14:25:17 -0800 (PST)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id y11-20020ac85f4b000000b002de4b0a015asm4082502qta.5.2022.03.10.14.25.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Mar 2022 14:25:17 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Michael McClimon <michael@mcclimon.org>
Cc:     git@vger.kernel.org
Subject: Re: Bug with rebase and commit hashes
Date:   Thu, 10 Mar 2022 17:25:16 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <C92B297B-0634-40CC-B1C6-B2A7325BF7DA@gmail.com>
In-Reply-To: <YiokTm3GxIZQQUow@newk>
References: <YiokTm3GxIZQQUow@newk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

I looked into this a little bit. I may not have the full answer, so others may want to chime in.

On 10 Mar 2022, at 11:16, Michael McClimon wrote:

> I have run into a bug with rebase when operating with commit hashes directly
> (rather than branch names).
>
> Say that I have two branches, main and topic. Branch topic consists of a
> single commit whose parent is main. If I'm on main, and I run
> 'git rebase main topic', I end up on branch topic, as expected (my prompt here
> displays the current branch):
>
> [~/scratch on main] $ git rebase main topic
> Successfully rebased and updated refs/heads/topic.
> [~/scratch on topic] $
>
>
> If I do exactly the same thing, but substitute the commit shas for those
> branches, git _doesn't_ leave me on branch topic, but instead fast-forwards
> main to topic. This is very surprising to me!
>
> [~/scratch on main] $ git rev-parse main
> 464adc6a6f8aa0a943dbf886df1eb6497f70f6e6
> [~/scratch on main] $ git rev-parse topic
> c3c862105dfbb2f30137a0875e8e5d9dfec334f8
> [~/scratch on main] $ git rebase $(git rev-parse main) $(git rev-parse topic)
> Current branch c3c862105dfbb2f30137a0875e8e5d9dfec334f8 is up to date.
> [~/scratch on main] $ git rev-parse main
> c3c862105dfbb2f30137a0875e8e5d9dfec334f8

Taking a look at the code in bulitin/rebase.c, it will check whether or not
<branch> is resolveable as a valid ref. If not, then this code [1] sets the head
name that will get switched to, to NULL.

Then, when checkout_up_to_date() is called, it calls reset_head() which does not
switch to the branch since opts->branch is NULL. But (and I haven't looked into
detail how reset_head() works) it seems like it will still set the current HEAD
(main) to $(git rev-parse topic).

This diff seems to fix this behavior, but it's untested.

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b29ad2b65e72..bcbac75c705e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1634,7 +1634,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
                                die(_("no such branch/commit '%s'"),
                                    branch_name);
                        oidcpy(&options.orig_head, &commit->object.oid);
-                       options.head_name = NULL;
+                       options.head_name = xstrdup(buf.buf);
                }
        } else if (argc == 0) {
                /* Do not need to switch branches, we are already on it. */


1. https://github.com/git/git/blob/master/builtin/rebase.c#L1637

>
>
> Part of the reason this is surprising is that in the case when topic is not a
> fast-forward from main (i.e., does need to be rebased), git does what I'd
> expect, and leaves me detached on the newly rebased head.
>
> [~/scratch on main] $ git rev-parse main
> 464adc6a6f8aa0a943dbf886df1eb6497f70f6e6
> [~/scratch on main] $ git rev-parse topic
> 8d7d712bad0c32cd87aa814730317178b2e46b93
> [~/scratch on main] $ git rebase $(git rev-parse main) $(git rev-parse topic)
> Successfully rebased and updated detached HEAD.
> [~/scratch at 1477bc43] $ git rev-parse HEAD
> 1477bc43a3bc7868ba1da8a919a60432bedbd34a
>
>
> I ran into this because I was writing some software to enforce semilinear
> history (all commits on main are merge commits, and the topic branches are all
> rebased on main before merge). That workflow is: for every branch,
> rebase $main_sha $topic_sha, then checkout main and merge --no-ff $topic_sha.
> Because of this bug, when we got to the merge --no-ff, git didn't do anything
> at all, because it had already fast-forwarded main! I worked around this in
> my program by just passing --force-rebase to my rebase invocation, which fixes
> this particular problem by leaving me in a detached head (as in the last case
> above).
>
> I hit this in production on git 2.30.2 (debian bullseye), but reproduced
> locally using the latest git main, which is git version 2.35.1.415.gc2162907.
> In both cases I wiped my user gitconfig, so I'm using only the defaults. (If
> it helps: with my rebase.autosquash = true, the bad case above does not behave
> badly and leaves me in detached head as I'd expect.) It's totally possible
> this isn't _meant_ to work, in which case I think the docs could use an
> update.
>
> Thanks!
>
> -- 
> Michael McClimon
> michael@mcclimon.org
