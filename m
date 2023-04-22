Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE93C6FD18
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 15:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjDVPAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 11:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjDVPAO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 11:00:14 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FE51995
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 08:00:13 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2a8aea2a610so25734861fa.3
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682175611; x=1684767611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/IaC9NqqHPzzBKQ8Fi/wwGkvlr6MluQoCMT9A0cURo=;
        b=sWso/WRRY9/u/O7iehY+rfGvcArjEIZpWY189ZeeBm9Zzoo0WR9cdOW8RUZaFbNXiX
         GKoFYet2WTAT1eo6e7xQSUcraVOK3HcSZuKlDZiFBwz0dvGL44AvOo4aTTdbxj6N3vOr
         RDLFIEMCCtPTGCCM5csqZv1uveiWfHsmT+AYIFcPiSQizRIuVXfCDvJEIKDAqUksAwlp
         /Nx5ZTkXtqx6ZQPt7/rMgeWXCD8eTz7UtuTMhVAm8x0VJVgAI92NI8AChkHIz2z2UdNc
         QiMJtjm1npH/5/tzkByGMsrcdcg1jN9L3O212TSCvx4thXF280dgQuOfyp/azFgEJcWV
         U3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682175611; x=1684767611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/IaC9NqqHPzzBKQ8Fi/wwGkvlr6MluQoCMT9A0cURo=;
        b=VnuL2VhH4sjMDOJ0SnEqUrWcMuqAf60M6gTusOfvRmEu9cHMt6U93dMDMTg1h2gH+D
         TcZV8NBcWR8u1Gfs3CLXdTm+dL8JA0aWAqAiscu8csZObWTKw90Fz88qWZ/SyFeQFb3b
         6NamNrAOOYdu9bgXDILrP0nrxxxh3ikV5SwyzG46XqXWbhrzAVyZFL0uIZYoIIfu7ffW
         Rh01xeC7qXKEbzlGIWLsX2OWlmrYNmyNNvGK9N8IveTvb3jveG9o6Sa0JaCwnE1O/Wni
         esDngQiQ+tc/W3a3DWHZBjZZRdeQ22d2d7GseV+unveJo4fsXq0PK6zRv76JR2CXuOye
         kh4Q==
X-Gm-Message-State: AAQBX9d9lfCqxbouXmhQQcu0jKvbHHugqh2bDmeWdY/68UGn9Q4EeaIX
        1wFqdD/cczTovrBpDyh3+5NZEBlJ5E3jQ4R+iYDSHEAG
X-Google-Smtp-Source: AKy350Z9fLgqnhFjgNHAE/85rvU0N7xznSBR7LDBQdhCNq5ZD0q5tDi7SSqaagZLVYkg2hjhIEv+/goPYYr7xLwN2kY=
X-Received: by 2002:a2e:3004:0:b0:295:a930:6a59 with SMTP id
 w4-20020a2e3004000000b00295a9306a59mr1358195ljw.6.1682175610953; Sat, 22 Apr
 2023 08:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqwn26w5cd.fsf@gitster.g>
In-Reply-To: <xmqqwn26w5cd.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 22 Apr 2023 08:00:00 -0700
Message-ID: <CABPp-BHTYha8g1t5VPCkuMtgCopwx==iBGMOCxnyWpZbYMNtAQ@mail.gmail.com>
Subject: en/header-split-cache-h-part-2 (Was: Re: What's cooking in git.git
 (Apr 2023, #06; Thu, 20))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2023 at 3:57=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> * en/header-split-cache-h-part-2 (2023-04-18) 23 commits
>  - reftable: ensure git-compat-util.h is the first (indirect) include
>  - diff.h: reduce unnecessary includes
>  - object-store.h: reduce unnecessary includes
>  - commit.h: reduce unnecessary includes
>  - fsmonitor: reduce includes of cache.h
>  - cache.h: remove unnecessary headers
>  - treewide: remove cache.h inclusion due to previous changes
>  - cache,tree: move basic name compare functions from read-cache to tree
>  - cache,tree: move cmp_cache_name_compare from tree.[ch] to read-cache.c
>  - hash.h, repository.h: reverse the order of these dependencies
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
>  - Merge branch 'en/header-split-cache-h' into en/header-split-cache-h-pa=
rt-2
>  (this branch uses en/header-split-cache-h.)
>
>  More header clean-up.
>
>  Will merge to 'next'?
>  source: <pull.1517.git.1681614205.gitgitgadget@gmail.com>

Not yet; please mark as expecting a re-roll.  I need to fix up the
hash.h/repository.h patch
(https://lore.kernel.org/git/kl6lsfcu1g8w.fsf@chooglen-macbookpro.roam.corp=
.google.com/)
