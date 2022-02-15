Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B172BC433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 22:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244045AbiBOWZ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 17:25:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiBOWZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 17:25:27 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BE97C7A3
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:25:15 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id hw13so264487ejc.9
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=/8RQJWMVc7z2RxFKIb3HB6H1gRtr1rmZt87SzhUjOfw=;
        b=AyxxZ11Pc8Pj5OCHKfmWJPzuJf3Cgs1x7rvCbSD57AXeLUwU25BEkOdbMLiSvZyD7W
         EqbaZFihHE1rhIgoFSLkm1zfrJJ+sc2NB0tl7Ejg3Netk7jp49vxnCZOmB73Uao4xnas
         ZHgA78IBENdMO1J0v2IMYLhpCx9PSlQ4Hkn4lHqZmYOlspr9O6k4FuoFrL0a6Q1ySR2s
         8ErWGXQSPxpumlY7vMLw0fokSoQWosgYOwDHRcsnOOQOmcC45gydUG4DetLZtHwW5NQc
         ByY7aO23U3u0mCKt+kgf1a5Gpb4XlYzXiGZWZtOSQnRoOy+8h47xJ5J/9zEHMrg9ppiw
         josQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=/8RQJWMVc7z2RxFKIb3HB6H1gRtr1rmZt87SzhUjOfw=;
        b=aEipsWqj/wB+4LPwsdyQpSlc1jlx4kXUQVFRqdmvQjbKOi2S2jJskxdFxYQFT1Q0mJ
         jhBm4nZwiLozetAGX+5A0j2c6lL4lJEfAoadFWy6a1q6nGkUsBXRghp1Skaev/UuifFP
         v9zA+MZ+/GwKdFLFkxdsl1YI7e3utOQp0Nb9A5fWbMXXMFtOlg4gZCUU659Vrwg8KN+S
         WSeGUMw25DhKrf/aDHVdxMkr3X4zHHz3uTM9wVvemN/QzyzqG3eXJSxv3rVJXaX3yUOc
         jKmSC9CJStCIcSxK0EXUXibL2BpAy7/YvAx2TZKGWnfTE8GSuhSM5KxuIQwS3zgW6+e4
         bJAw==
X-Gm-Message-State: AOAM532jxH+UY6U/Tkdv7CopnePP76y2JQ38YRR62OzeRg78R7S7DPAg
        zim58pyTjHcGzhpfKRjeE9UyZwzqbBE=
X-Google-Smtp-Source: ABdhPJwKMPDCWy9/jJSpUgj7bZgCL5Z9PKzwkyNMHaGmMdPSVOOSLoysNiGnrNLamnqiGkSQdztzAA==
X-Received: by 2002:a17:906:70c2:b0:6cf:e1cc:4d8c with SMTP id g2-20020a17090670c200b006cfe1cc4d8cmr99175ejk.696.1644963914002;
        Tue, 15 Feb 2022 14:25:14 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b7sm557223edv.58.2022.02.15.14.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 14:25:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nK6G1-002uZv-41;
        Tue, 15 Feb 2022 23:25:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/ambiguous-object-name & ab/only-single-progress-at-once (was:
 What's cooking in git.git (Feb 2022, #04; Tue, 15))
Date:   Tue, 15 Feb 2022 23:22:27 +0100
References: <xmqqk0dwyrcv.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqk0dwyrcv.fsf@gitster.g>
Message-ID: <220215.861r03wywm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 15 2022, Junio C Hamano wrote:

> * ab/ambiguous-object-name (2022-01-27) 7 commits
>  - object-name: re-use "struct strbuf" in show_ambiguous_object()
>  - object-name: iterate ambiguous objects before showing header
>  - object-name: show date for ambiguous tag objects
>  - object-name: make ambiguous object output translatable
>  - object-name: explicitly handle bad tags in show_ambiguous_object()
>  - object-name: explicitly handle OBJ_BAD in show_ambiguous_object()
>  - object-name tests: add tests for ambiguous object blind spots
>
>  Error output given in response to an ambiguous object name has been
>  improved.
>
>  Will merge to 'next'?
>  source: <cover-v8-0.7-00000000000-20220127T052116Z-avarab@gmail.com>
> [...]
> * ab/only-single-progress-at-once (2022-02-03) 9 commits
>  - pack-bitmap-write.c: don't return without stop_progress()
>  - progress API: unify stop_progress{,_msg}(), fix trace2 bug
>  - progress.c: refactor stop_progress{,_msg}() to use helpers
>  - progress.c: use dereferenced "progress" variable, not "(*p_progress)"
>  - progress.h: format and be consistent with progress.c naming
>  - progress.c tests: test some invalid usage
>  - progress.c tests: make start/stop commands on stdin
>  - progress.c test helper: add missing braces
>  - leak tests: fix a memory leak in "test-progress" helper
>
>  Further tweaks on progress API.
>
>  Will merge to 'next'?
>  source: <cover-v9-0.9-00000000000-20220203T213350Z-avarab@gmail.com>

Both of these are, I think, good to merge to "next" in their current
state.
