Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E339E1FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 15:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754892AbdBGPI0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 10:08:26 -0500
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33706 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753587AbdBGPIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 10:08:25 -0500
Received: by mail-oi0-f47.google.com with SMTP id w204so66146580oiw.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 07:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aj+bM6DMURBrmUMqNs0A39xg2++0h5/s/ARE5/lU9l8=;
        b=D5Xu9U0LhxzOfmDyfAjk+UEdYDkA+qh/u3jQwCY5KQ47+iXtD4hRzUtVTk06qZYa0d
         TD47VObfOL0En4CzxmSZK/c4vVlPMB6DDQW9M5VDfLlV7ZjlhueucpTx66tk7dNj87wQ
         pnKfBeGXPQNSkMJLsJq3b8BhBDWqQ/h1c0cMxMnC116Jq0lLmguV2618HgDXqaTG3vJF
         rTlf9eeiuUznG3t8uiGwBXtDKJIWhi4iKHeigMlxuHTN+u+b0QTgmqrxk88x/ml54/bp
         ybiA6kfSAW1jFvoTRvu2W5i2bsnUFQzpggRhS8g1zSXFtC/rmGAx7NOusOmCgP7uO6ZM
         LP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aj+bM6DMURBrmUMqNs0A39xg2++0h5/s/ARE5/lU9l8=;
        b=TeDm9yBXfi4cryvij0eBRqMBEUbK9Mld9Bxi2wbTUrR7Oj7Vfh2RA+rn7dd4AwP2b3
         oMhXkmkkWeCtNbJUZDcEaGUa7eWIiIsSd0q2VlDwH4ty5k7CNHwS8WqmkCmkNy8tsu07
         Q06NQTp6D9MkUYVmo+2P/i5y0d4sR+MDYXm3X6Hvj2pe9PALHMpYqD0cu0QN3Vu1zV69
         f26IMmRgKIes57YNa9KQwc6MIBb21X2rzMeyEvzj8WFgPYHLWhka1HpHOzTWRoRjU2aA
         /5goDN1TEA2BJDH4VvMaPTMAZtZ1rJK5dUqEAvzVjKjAJHl+Vh1BNElZGv1OyqwVHHJc
         bPeg==
X-Gm-Message-State: AMke39k4559xuCSnHabvZNDg4Xuk342TmJnseEXilpnW3UbcfKCnml7WU75dphYpVSVo3hkzt013gkFax0vEFg==
X-Received: by 10.202.237.139 with SMTP id l133mr8383173oih.55.1486480104389;
 Tue, 07 Feb 2017 07:08:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Tue, 7 Feb 2017 07:07:53 -0800 (PST)
In-Reply-To: <CACsJy8CHoroX2k9GqOFmXkvvPCPN4SBeCg+6aC2WSWNSKVmWQw@mail.gmail.com>
References: <CACsJy8CHoroX2k9GqOFmXkvvPCPN4SBeCg+6aC2WSWNSKVmWQw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 7 Feb 2017 22:07:53 +0700
Message-ID: <CACsJy8CYrbSJqbG7h+-wQPNBCNAVs94Hx7m8qXXb88L0o-rw0Q@mail.gmail.com>
Subject: Re: The design of refs backends, linked worktrees and submodules
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 6:55 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> I've started working on fixing the "git gc" issue with multiple
> worktrees, which brings me back to this. Just some thoughts. Comments
> are really appreciated.
>
> In the current code, files backend has special cases for both
> submodules (explicitly) and linked worktrees (hidden behind git_path).

It just occurs to me that, since the refs directory structure of a
linked worktree is exactly like one in a normal single-worktree setup,
minus the shared (or packed) refs. The "files" refs backend can just
see this "per-worktree only" refs directory as a remote refs storage,
which is just another name for "submodule".

So, we could just use the exact same submodule code path in refs to
create a per-worktree refs storage. Doing it this way, files backedn
do not need to learn about linked worktrees at all. To retrieve a
per-worktree refs storage, we do
"get_ref_store(".git/worktrees/foobar")". To get all per-worktree refs
do for_each_ref_submodule(".git/worktrees/foobar", ...).

Does it make sense? Should we go this way?
-- 
Duy
