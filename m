Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0427FC2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 22:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2C920747
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 22:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RH6aSGHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgDGWLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:11:48 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:38093 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgDGWLr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 18:11:47 -0400
Received: by mail-pg1-f201.google.com with SMTP id s2so3752371pge.5
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 15:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zJz0j+X6V2edqY9eGK1IH3NlM0tq2woB44gph9lWlKc=;
        b=RH6aSGHrHhcjTg7qYbFLwVSwkYAS2//MVpgxzduU9Ug7jqSOlAiJiZ7ByIVur4UIK7
         QGkH0NJChuYO01yeH2GrJf/zV7NYupNgeJpZ0JXo3HtEg92HBTDqjZUQzMoVUeVmvnNI
         diULNBuzap4yQaMH9wtQMu2yrjBUeRVtmK6r1ZK9Zlop9UGOXAOoUayq+1WP2Tz1nAPf
         7EMVXTlHVkgFGdY3BX5sMGYBEo2+NmmxewkD29dGh614wR17+FLINFYkrGRyGV9RUQW9
         FhKP5dkndGZHM63OZs0fv2nSoxsPtGP/O6ArkxPBI3uJZCLHnDEBUzpdMTuZqRPhZhEC
         us5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zJz0j+X6V2edqY9eGK1IH3NlM0tq2woB44gph9lWlKc=;
        b=QCFV7FlWTp1wfgTApqIWvl2H4a1y4Czyz1+Yu+QZwazjTLM7WpD7ZRB71TPpja8y2Y
         ho3nB04QvGtjAxPX/RNjcAH0lPhBe/0rYsrtUrQqBN4LE3k2mXgPilt9roa7d0SLfI/C
         SqBr0n99kCRzooJyjAxSc5whgr2ArdGIbJztGgvwu/sITJWaKHXIKpB+1Mw9bNtiifuf
         XU+EBFyEo7Ng/O0VwN6P9QcGdtNp6JX9mOTcGelJRQyOmYPIYzkFFIGmLq0/8Gdlyqp8
         4h6sRlhburskrzzxM3S+sUipdrm3y0SW4/FUEoSS7K4+awoFre2pNlVdx9plunk+1qfi
         vDOA==
X-Gm-Message-State: AGi0PuZodomBCSsbpAElmldb0GNd5Hqfsy7zXAt128yvPFQJq7py+Lp/
        NMy3YY0wUsm02DqR2y0L0iiS4mChl6DoIpm+C251LCJiAK1dZ1FTENP/GFJ4xuljVXVqSMtW6QV
        orwJfu/VjzbU84NFkaiK1yzxiywEKfNd4YDHgWlsaqs+jYUQcoTbZL3pp/25ezZpgU7cB4fIuUO
        Gs
X-Google-Smtp-Source: APiQypLTa1wKRCUrTK25VPIujtii+jEeGeL/kTvDKveVfajftxu99DG8dX+mswTtGDTEERKaVfgqyTudeN+2IGRi357A
X-Received: by 2002:a63:ce54:: with SMTP id r20mr4057269pgi.338.1586297506752;
 Tue, 07 Apr 2020 15:11:46 -0700 (PDT)
Date:   Tue,  7 Apr 2020 15:11:39 -0700
In-Reply-To: <20200331020418.55640-1-jonathantanmy@google.com>
Message-Id: <cover.1586296510.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200331020418.55640-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v3 0/4] Restrict when prefetcing occurs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, garimasigit@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio wrote in [1]:

> s/rebase/rename/ I presume, but the above reasoning, while it may
> happen to hold true right now, feels brittle.  In other words
> 
>  - how do we know it would stay to be "a superset"?
> 
>  - would it change the picture if we later added a prefetch in
>    diffcore_break(), just like you are doing so to diffcore_rename()
>    in this patch?

and suggested that each function be capable of prefetching. I've done
that for most functions in this new version.

To avoid the potential slowdown of each function doing its own object
existence checks (that is, looping through all the relevant OIDs and
then prefetching based on whether it found one missing), what I did is
to teach diff_populate_filespec() to retry whenever it attempts to read
a missing object, calling a callback before its 2nd (and final) try. I
then taught the functions called by diffcore_std() to pass a prefetching
function as this callback.

The functions I've taught include diffcore_skip_stat_unmatch(). I
couldn't figure out how to trigger this behavior in a test (I can see
that the function is being run, but not how to make it read an object),
but I included the prefetching mechanism in this function anyway for
completeness.

The previous version of my patch [2] made the assumption that the
fetching done at the start of diffcore_std() is a superset of the
fetching done by diffcore_rebase() - hence Junio's comment above about
how we would know that it would stay a superset. With this series, if
ever that no longer holds (and we miss fixing it), rebase would only do
one additional bulk fetch (instead of fetching once for every missing
object).

[1] https://lore.kernel.org/git/xmqqsghl1m0p.fsf@gitster.c.googlers.com/
[2] https://lore.kernel.org/git/a3322cdedf019126305fcead5918d523a1b2dfbc.1585854639.git.jonathantanmy@google.com/

Jonathan Tan (4):
  promisor-remote: accept 0 as oid_nr in function
  diff: make diff_populate_filespec_options struct
  diff: refactor object read
  diff: restrict when prefetching occurs

 builtin/index-pack.c          |   5 +-
 diff.c                        | 157 +++++++++++++++++++++++-----------
 diffcore-break.c              |  12 ++-
 diffcore-rename.c             |  64 ++++++++++++--
 diffcore.h                    |  30 ++++++-
 line-log.c                    |   6 +-
 promisor-remote.c             |   3 +
 promisor-remote.h             |   8 ++
 t/t4067-diff-partial-clone.sh |  48 +++++++++++
 unpack-trees.c                |   5 +-
 10 files changed, 267 insertions(+), 71 deletions(-)

-- 
2.26.0.292.g33ef6b2f38-goog

