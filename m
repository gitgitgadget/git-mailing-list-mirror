Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 063DC208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751684AbdHRWge (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:36:34 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:33020 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbdHRWge (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:36:34 -0400
Received: by mail-yw0-f169.google.com with SMTP id p68so66753569ywg.0
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FcB/c6EVWIPCnatUNKk0ztedzH6H1nFGWjeZ9kD5wsc=;
        b=omvaa1DHiwm4nhtNMNCH3kYDiU3IExLDwswrs2b4+6sg4Q+kWC7rTIy7eXxNK2zF6g
         wfA8LoTIPaglyW9fjSpK1yA7FrqZF7Arz+PWE0yA9paLPBseiR1ApdhzB3ngU9sdcINa
         x7HVxh4YMvI7F8e7r3EA6qtcXs9f/yn6dfBXQia+Q4Oyv2KVY81kT7QipLC+3UfX+Pfe
         Aoo9LwVgLnlz2rTmGHpHoiphbMh6XpMGW7HnuZA5sqr7Wgxo6bX4q0viVaNjLc/t0I8l
         0bQQ/Cim5R1WNVrVEsKhpp7GHIfYXHUq6HpN674YRhM8FtDftmZbY5iZz4uxjKdrTSlm
         wSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FcB/c6EVWIPCnatUNKk0ztedzH6H1nFGWjeZ9kD5wsc=;
        b=A+QHBFTe9xillUzLCRjgFlJSGtM5CVhRBah9KiLCy9fH5DI9aIgsNsom/wkdSVtlW7
         8Aqd6Ucy0x2mGSz4hfz+XSGWzFQaBC9Tkh+2suCqeBKlm/KXgmHTnprMRarjfrLyWGlr
         MKqWClsflb7jfLiH6JJkafTvRKh3Gud8OxbmHOAEdwRMmLwQByyLLTspX1mqP+8W/cSI
         rVnfrcoCzoluMzOgt9Zw+oyyauPjBi9OHeeHcyQnYMbO1GR8zuavUxBCkKP6q2L2Se0l
         zOmmPWy9I7lxb3dKIZHfo2cBMoNoFm+nQfcqkSMVEZKXf0wO/fcVPKQ3z3HzNIsldCyK
         +9zA==
X-Gm-Message-State: AHYfb5gGaO/PhKZgvDcW18AFFZCdg+9wd5NZvFuU/q789FBwEKgxss/8
        tceT6eREhz+08lyiXmm7ZDGtzyOhlPMBdyI=
X-Received: by 10.37.32.139 with SMTP id g133mr9036946ybg.181.1503095793271;
 Fri, 18 Aug 2017 15:36:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.40.4 with HTTP; Fri, 18 Aug 2017 15:35:52 -0700 (PDT)
From:   hIpPy <hippy2981@gmail.com>
Date:   Fri, 18 Aug 2017 15:35:52 -0700
Message-ID: <CAM_JFCzZWfyUiFVrYOztdJD8iSYvYUavbzKOX2bxDV0_hMz7Eg@mail.gmail.com>
Subject: Git makes a merge commit but as a normal (non-merge) commit
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While merging if I do certain actions then the merge commit is made
with the merge message but as a normal (non-merge) commit.

Repro steps:
- Set GIT_MERGE_AUTOEDIT=yes (set other than "no") in .bashrc
- Make a merge commit with no conflicts.
  (external text editor shows the generated merge message)
- Focus on Git Bash and Ctrl-C.
- Commit (git commit).

Actual behavior:
Git makes a normal (non-merge) commit (squash merge) but with the
merge commit message.

It looks like a bug to me. This is very confusing later on as the repo
topology would show that the branch is not merged in and there is not
an easy way to find out when the merge was made.

Expected behavior:
Git should stay in a MERGING state. The user can choose to either
abort the merge or continue the merge (git merge --continue OR git
commit).

This does not happen in case of conflicts (at least I'm not able to
repro). I get a (master|MERGING) prompt till I resolve the conflicts
and commit, which goes through correctly as a merge commit.

Environment:
$ git version
git version 2.14.0.windows.2
$ bash --version
GNU bash, version 4.4.12(1)-release (x86_64-pc-msys)

Thanks,
RM
