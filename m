Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42FBC77B73
	for <git@archiver.kernel.org>; Sun, 30 Apr 2023 06:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjD3G7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Apr 2023 02:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjD3G7S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2023 02:59:18 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499671FC7
        for <git@vger.kernel.org>; Sat, 29 Apr 2023 23:59:17 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2a8bcfbf276so12737041fa.3
        for <git@vger.kernel.org>; Sat, 29 Apr 2023 23:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682837955; x=1685429955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ug5CtCvdWcpo9Tac/jUmLTHdTurouITjkT48zD7ryF4=;
        b=WiDfmwh6O3lZEAKzFJFz6MygiDfHPd39hDPZR33UcD/zV6B82GiYG5+eJipoK6Pz+w
         cVXLNbVWifuqfnQiuO7ghZb+tSXqpEc5DhlYrUHZWqYCBN9b23f7G2ARS/dr/L7wKiQT
         DHa5pM4Vtg5/1CLseJ8manfdkpqnAogXg/IJSMKTrK+/h317Uny/9mauLqksvmb6Mhfx
         rjFtfmO8cOEBtrCrzEhlQ8THQ+GpPuJvfPHSrDkj9UGFzF1FdTTkAZug6Ng13vcsVisX
         /Z1gCLV9PPHJTrIYytBMyQZhylejWSHoKtNZP4KVi11n+xSY5L84xLKGdCa/OIXd7I+k
         rRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682837955; x=1685429955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ug5CtCvdWcpo9Tac/jUmLTHdTurouITjkT48zD7ryF4=;
        b=PDQVffXAPzjprSMEF0kvXb1PIn8TuZ2sa+pJGN+7bviD8oiX1Elst5Wd2nGFc24COb
         FSaCQtjpHnDfkmkcyOBg9enfY9YQAtEFfbqMzQz/mkymCF209nv2h3X+w5p2iRNljfPX
         3roXhbYe/iSWo2CBV0iyPODsmxa4ZoRRECIzXAzIrL47Fc+AhNvhnLe46dzqS8hZwDrJ
         dcAAu4DHIlDinQ8zH/Rld8DvR6mevgRJb4RLBHmxsS8hoDKqeIPu/Mecjw4SJ7YFzEaU
         13tAzxpLnx/TfgUu6lF7IuiR/DfqAsIxZCtBvWjHo11f6VPnkP8o1GKBv8AbjOHuLZ8j
         78xw==
X-Gm-Message-State: AC+VfDxNVB4KAQXMXxkhy5/fOCzOYlsJiWoVoLYJXvdCmLR9NAP+a5Jj
        IBZ78OJYrv2iWyRTxAu8BzGZWDGmPNzbNMvx9+JrI66c
X-Google-Smtp-Source: ACHHUZ75enF8NlQU8/zcC7AOXJbeW0Wk76nOygWQCeRAZCbCeXcPvVvgZyfH24yNdCfL/TrOYKZVBknhovORlyK4vWY=
X-Received: by 2002:a2e:7012:0:b0:2a8:dcd4:6161 with SMTP id
 l18-20020a2e7012000000b002a8dcd46161mr2831129ljc.28.1682837955303; Sat, 29
 Apr 2023 23:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqzg6r9o14.fsf@gitster.g>
In-Reply-To: <xmqqzg6r9o14.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 29 Apr 2023 23:58:00 -0700
Message-ID: <CABPp-BG7K0L11YGYmo504GK4mexFnBZPuDHhqSwqaD2nGwWfWQ@mail.gmail.com>
Subject: en/header-split-cache-h-part-2 (Was: Re: What's cooking in git.git
 (Apr 2023, #09; Fri, 28))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 29, 2023 at 12:20=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> * en/header-split-cache-h-part-2 (2023-04-24) 22 commits
>  - reftable: ensure git-compat-util.h is the first (indirect) include
>  - diff.h: reduce unnecessary includes
>  - object-store.h: reduce unnecessary includes
>  - commit.h: reduce unnecessary includes
>  - fsmonitor: reduce includes of cache.h
>  - cache.h: remove unnecessary headers
>  - treewide: remove cache.h inclusion due to previous changes
>  - cache,tree: move basic name compare functions from read-cache to tree
>  - cache,tree: move cmp_cache_name_compare from tree.[ch] to read-cache.c
>  - hash-ll.h: split out of hash.h to remove dependency on repository.h
>  - tree-diff.c: move S_DIFFTREE_IFXMIN_NEQ define from cache.h
>  - dir.h: move DTYPE defines from cache.h
>  - versioncmp.h: move declarations for versioncmp.c functions from cache.=
h
>  - ws.h: move declarations for ws.c functions from cache.h
>  - match-trees.h: move declarations for match-trees.c functions from cach=
e.h
>  - pkt-line.h: move declarations for pkt-line.c functions from cache.h
>  - base85.h: move declarations for base85.c functions from cache.h
>  - copy.h: move declarations for copy.c functions from cache.h
>  - server-info.h: move declarations for server-info.c functions from cach=
e.h
>  - packfile.h: move pack_window and pack_entry from cache.h
>  - symlinks.h: move declarations for symlinks.c functions from cache.h
>  - treewide: be explicit about dependence on strbuf.h
>
>  More header clean-up.
>  source: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>

Both Stolee[1] and Glen[2] have acked and think it's good.

Also, when others at the weekly libification sync asked if it needed
more review, I told them that those two were probably sufficient and I
suspected you'd merge the series to next soon-ish, so they didn't need
to worry about it.  If I was wrong about that, and you'd like to see
more review, let me know.

[1] https://lore.kernel.org/git/1393c57f-9f3f-18da-8f02-badfdc62f02d@github=
.com/
[2] https://lore.kernel.org/git/kl6lbkjao7fe.fsf@chooglen-macbookpro.roam.c=
orp.google.com/
