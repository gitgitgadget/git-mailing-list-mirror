Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75076C433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 17:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4329264DFF
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 17:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbhBHRdW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 12:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbhBHRbH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 12:31:07 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD457C06178B
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 09:30:26 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s3so19376911edi.7
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 09:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arrikto-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=EClfM6LFleFbxquMFhjr7QnlQ3jjAnDkolp/mVCnJk0=;
        b=teiQN/QIOuN5WlD8cjN/CBNJFg5JueALvyGtcb5AcJbIGD1VtWZbf7Vbzdp/rRPsZR
         Xvy9qBOSCP+WneDYrsVTWXWOYrpZyNIfofkMfrj2kfJ92/1pBNW05BApn+XVEwv3U0zZ
         6BBURjMaRN2XXbDP3tTblqiv9lgCosDRlWaoY0st8NNhStSq23UV5KtD48nE0MnUyrv4
         Mf3DOj3JJ/o2qVbHI1040YaMTFlPvmI6S5kr5M96EV7/o8xX1j42xr3eKBp7+l1Sf9tc
         VUuEy6YyDeZsz5SSHOWLdCkABWX2qzz0AAnHsbo0G+mJDAk6Ja2/X86pYZL5ZeZiXoLj
         vmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=EClfM6LFleFbxquMFhjr7QnlQ3jjAnDkolp/mVCnJk0=;
        b=YiZcFD1RXugOeu6/brs5/5xLsBdiJnSj6xduYaPVObMAUq530rwa7QxT6pzJkgCF5a
         JJvt7k5GaW1zxbFPxHvLx5C9m+6gS7YaqUz2Rjat1gsY7EDRo2Z5e14ewAy1uXeQak6U
         rfOiL1mG8cescqoXpzUJvsJEXIteXrm6Pf+KeFvNoe5FahRDQ0LLL230w67Dvh7/x1Ka
         5kJ0l8j3ASWblghHstv46xEZZhQ91KmUtZ/SLUpuHxu6pmL25C245wK6UKs0iy+ioqrv
         yxKAi8MnbzvPiC07XDo5g0AWM/g1A+wgMWsoaonXIkkKqJgSk/j2YyqnIOSb/Sqxrg7C
         rBKQ==
X-Gm-Message-State: AOAM530bqBNVr+A5aGGnRejtdZ7WN6yBDwnM6ebBgUK3r6kO6j3AxArx
        2TJKPYrtcXNbOZ/1u1trSBZ42g4Jq69GHg==
X-Google-Smtp-Source: ABdhPJw/Cta8oqAVTbuHIbcIeANWVJZYak3w3HroaUTJ1WENRTwX95U0CL29WfBv8eDMHcE+6DjMeQ==
X-Received: by 2002:a05:6402:1014:: with SMTP id c20mr8656484edu.53.1612805425485;
        Mon, 08 Feb 2021 09:30:25 -0800 (PST)
Received: from [192.168.1.122] (adsl-226.176.58.195.tellas.gr. [176.58.195.226])
        by smtp.gmail.com with ESMTPSA id w26sm4344768edq.46.2021.02.08.09.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 09:30:24 -0800 (PST)
To:     git@vger.kernel.org
From:   Yannis Zarkadas <yanniszark@arrikto.com>
Subject: Directory rename detection breaks if repo has a lot of
 similar/identical files
Cc:     vkoukis@arrikto.com
Message-ID: <4ceea1ec-59fe-af8e-b91d-aced4e6a1b0f@arrikto.com>
Date:   Mon, 8 Feb 2021 19:30:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone! I believe I have found a use-case that breaks git's directory
rename detection algorithm. In short, when a repo has a lot of identical 
files,
directory rename detection breaks. I believe this happens because git feeds
misleading renames to the directory rename detection algorithm.

For example, suppose a changeset (COMMIT_A, COMMIT_B). If `x/a` and `y/b` in
COMMIT_A are the same as `new/x/a` and `new/y/b` in COMMIT_B, then git may
decide the renames are `x/a -> new/y/b` and `y/b -> new/x/a` instead of
`x/a -> new/x/a` and `y/b -> new/y/b`. Of course, this confuses the 
directory
rename detection algorithm.

To make a long story short (I am including all the individual steps to
investigate this below), it seems the following enhancement would work 
to solve
this particular problem:

If file `a/base/base.txt` in COMMIT_A is the same as 
`new/a/base/base.txt` AND
`new/z/base/base.txt` in COMMIT_B, then prefer the rename
`a/base/base.txt->new/a/base/base.txt` over the rename
`a/base/base.txt->new/z/base/base.txt`. I have included a more generic 
algorithm
below.


Problem
=======

The original repo was very large, so I tried to find a simpler example that
caused git to detect directory renames incorrectly. I managed to create such
an environment with the following script:
https://gist.github.com/yanniszark/4165bd8f92d9838e143495e5a8df2ce0

The script creates a repo (/tmp/demo) with 3 branches:
- *upstream*: Contains a lot of folders, with some files being identical 
across
   folders.
- *upstream-restructured*: Same as upstream, but with all folders moved 
under
   `new/`. For example, `a/`->`new/a`
- *downstream*: Based on upstream, adds some extra files under every 
folder of
   upstream.

Then, it tries to rebase downstream ontop of upstream-restructured. Git 
detects
the WRONG directory rename `z/->new/a/` and fails with a wrong conflict.

$ git -c merge.directoryRenames=true rebase -v -m --onto 
upstream-restructured upstream
Path updated: z/overlays/develop/overlay.txt added in 9bf94f0 (Add 
overlay for z) inside a directory that was renamed in HEAD; moving it to 
new/a/overlays/develop/overlay.txt.
CONFLICT (rename/rename): Rename 
a/overlays/develop/overlay.txt->new/a/overlays/develop/overlay.txt in 
HEAD. Rename 
z/overlays/develop/overlay.txt->new/a/overlays/develop/overlay.txt in 
9bf94f0 (Add overlay for z)


We are going to work with this example for the rest of this mail.


Analysis
========

After learning a bit about how git works internally, I found out:
- Rebasing with the merge backend (`-m`) uses cherry-pick underneath.
- Cherry-pick frames the problem as a merge, with the merge-base being the
   parent of the REMOTE commit.
- The merge algorithm accepts 3 inputs (BASE, LOCAL, REMOTE), computes the
   changesets of (BASE, LOCAL) and (BASE, REMOTE), and finally combines 
them.


With this background in mind, I run the demo script and got this message:

Path updated: z/overlays/develop/overlay.txt added in 9bf94f0 (Add 
overlay for z) inside a directory that was renamed in HEAD; moving it to 
new/a/overlays/develop/overlay.txt.
CONFLICT (rename/rename): Rename 
a/overlays/develop/overlay.txt->new/a/overlays/develop/overlay.txt in 
HEAD. Rename 
z/overlays/develop/overlay.txt->new/a/overlays/develop/overlay.txt in 
9bf94f0 (Add overlay for z)

Applying our knowledge of rebase, cherry-pick and merge from above, let's
calculate the BASE, LOCAL and REMOTE commits.

LOCAL=HEAD
REMOTE=9bf94f0  # same as the error message
BASE=REMOTE~    # based on how cherry-pick works

At this point, we can peek at what changesets git's merge algorithm is 
seeing:

git diff --find-renames --stat $BASE $LOCAL
git diff --find-renames --stat $BASE $REMOTE

The first command is the interesting one and returns suspicious entries 
like the
following:

{z => new/a}/base/base.txt                   | 0
{a => new/a}/overlays/develop/overlay.txt    | 0
{a => new/a}/overlays/upstream/file_1.txt    | 0
{z => new/a}/overlays/upstream/file_3.txt    | 0
{z => new/a}/overlays/upstream/file_5.txt    | 0
{a => new/a}/overlays/upstream/file_a.txt    | 0
{z => new/a}/overlays/upstream/overlay.txt   | 0
[...]
{a => new/z}/base/base.txt                   | 0
{z => new/z}/overlays/upstream/file_1.txt    | 0
{a => new/z}/overlays/upstream/file_3.txt    | 0
{a => new/z}/overlays/upstream/file_5.txt    | 0
{z => new/z}/overlays/upstream/file_z.txt    | 0
{a => new/z}/overlays/upstream/overlay.txt   | 0


Hypothesis
==========

At this point, I formed a hypothesis:
- git detects renames between (BASE, LOCAL) as they appear in the `git diff`
   command above.
- git feeds those renames in the directory rename detection algorithm, which
   gets confused about what directory renames actually happened.


Confirming the Hypothesis
=========================

I tried to confirm my hypothesis by diving in the source code. My C is a bit
rusty, but I managed to find out the function that handles the renames, 
called
`detect_and_process_renames` (inside `merge-recursive.c`). The following 
part
is particularly interesting:

head_pairs = get_diffpairs(opt, common, head);
merge_pairs = get_diffpairs(opt, common, merge);
[...]
     dir_re_head = get_directory_renames(head_pairs);
     dir_re_merge = get_directory_renames(merge_pairs);

The first part is computing the changeset for (BASE, LOCAL) and (BASE, 
REMOTE).
The second part is feeding the changeset to the get_directory_renames 
function
for calculating directory renames.

By inspecting the `head_pairs` variable with my debugger, I confirmed 
that the
changeset is the one I saw with `git diff`. Indeed, git is feeding the
`get_directory_renames` function confusing renames.


Proposed Enhancement
====================

Now that we know what is most likely going on, I can describe what I 
would like
git to do.

Intuition: If file `a/base/base.txt` in BASE is the same as
`new/a/base/base.txt` AND `new/z/base/base.txt` in LOCAL, then prefer 
the rename
`a/base/base.txt->new/a/base/base.txt` over the rename
`a/base/base.txt->new/z/base/base.txt`.

In other words, if multiple rename candidates are possible, prefer the 
ones that
look more like the user move the file/folder from one path to another.

Possible Algorithm:

More generally, if files `A1`, `A2`, ..., `An` in commit A are the same 
as `B1`,
`B2`, `Bm` in commit B, then:
- Calculate a sorted list of scores `S(Ai, Bj), i=1,...,n and 
j=1,...,m`, where
   `S(Ai, Bj)` is the length of the suffix match of `Ai` and `Bj`.
- Walk the sorted list and for each element:
     - If `Ai` and `Bj` is not used in a rename yet, apply the rename.
     - Stop when you have found `min(n, m)` renames.
- The remaining `max(n, m) - min(n, m)` files are either deletes (if 
they are on
   commit A) or copies (if they are on commit B).


Conclusion
==========

I want to attempt to implement something like what I described above, when I
have more time to get familiar with diff's internals. In the meantime, I 
would
love to hear the opinion of more seasoned git developers on this issue. 
Do you
agree with my findings and the direction I proposed? Is there something 
I have
overlooked? Perhaps someone is already having these problems.


Thanks in advance,
Yannis Zarkadas

