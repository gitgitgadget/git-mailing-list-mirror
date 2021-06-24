Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929D0C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 13:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C3B7613DC
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 13:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhFXNfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 09:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFXNfs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 09:35:48 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B76C061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 06:33:28 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id he7so9507585ejc.13
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 06:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:user-agent:message-id:mime-version;
        bh=uW3pfhRRjS2AouN/VKXVYhE1cxEuYm6bJ5bPLeBCQHo=;
        b=Ec7JePAC+aCx8gErzVD7pfQrN6Ph4cGhE4fkFKdbxdVotXLZWFpDBXTDtBjaU+prlS
         ZJGU3DY9yBv8bYfswQqsy1dOg5z5/fHg4+nEuZvrmHRGeZATMNTNfaFGxq95Ah1Wi5eH
         Qkd+LsFcdv+RLRQ55sDBj6DjUd1AC9hfTcElcbd4dI1ozwrtjKsagZdH5Ih4aAQtKcFA
         ri5ZB17PaBSCcaRbMziL69Vhv11FI4VYFUdlJYdyygSOKSoT4apnkHie6LvUV7caP8SF
         /d9lnBqZ020Q/Hv0ee22PoIRS9ek80hrZc13YsTxZ63qRtDes4pOkAcYQRndoGDgVFjY
         Kv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:user-agent:message-id
         :mime-version;
        bh=uW3pfhRRjS2AouN/VKXVYhE1cxEuYm6bJ5bPLeBCQHo=;
        b=gEEjvT8BtIM+yubEheniYcRJF5/i8wzM6b4/SOzxwDaPDc8iK43wPJRnlEV+YRoC4+
         O2gy8xfnS1nLfMyNKCKwDOLB2NHJJxdTC9IzVTSoCZWfaLKZF1IL3ouBsHMhNhZg/TVc
         AdiL7SFT7yi2z3PuJQwzBIpSnlJF+1FQOE4puRD2unwqc/OAYNz9dFXxhx8KPFOfHJ8H
         dZ8g685wu5wqGeQEPTM80aVLtzZ0LCC724Jm61VqQ9Rxz4nm7AH9RCB9t/kqifIaIE23
         AxBLlTBPFsVEw3avdAF/chNFLSS1+ZKYsU6k9vmZry1TeTZYZ+kRekv2V0w4uzCtSXQF
         8BrQ==
X-Gm-Message-State: AOAM530HRTJ9OYELkNexk+By0MfekwQoc1Mpzzi7fqtb+eBTMJSbTBWG
        HfeyCHEgONR/dF8q9NkLpdGC7KHMZSNIHg==
X-Google-Smtp-Source: ABdhPJzrqHWKG7gxyBd/F2/WpaL4Fc/xVfGIMq8oBqE066gkWo8v8Omot/DBu1Fp9GWSKf9a7tdOEA==
X-Received: by 2002:a17:906:7142:: with SMTP id z2mr5224433ejj.427.1624541606416;
        Thu, 24 Jun 2021 06:33:26 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id e12sm1217411ejk.99.2021.06.24.06.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 06:33:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Why the Makefile is so eager to re-build & re-link
Date:   Thu, 24 Jun 2021 15:16:48 +0200
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
Message-ID: <874kdn1j6i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is probably all stuff that's been on list-before / known by
some/all people in the CC list, but in case not: I looked a bit into why
we'e so frequently re-linking and re compiling things these days,
slowing down e.g. "git rebase --exec='make ...'".

These are all fixable issues, I haven't worked on them, just some notes
in case anyone has better ideas:

 * version.c: The biggest offender, every time you move to a new commit
   we have a FORCE on GIT-VERSION-FILE, if it changes (which it will, if
   you're in a git checkout), we in turn re-compile version.o, link
   libgit to contain it, and then need to re-link everything that uses
   libgit.

   Some of this can be micro-optimized by moving that out of libgit,
   e.g. we re-link git-shell, which doesn't ever report the version, we
   do the same for all the perl scripts, just because obscure codepaths
   of them that could shell out to "git version" want to report it, and
   we embed it in the generated code.

   But I think the best approach here is to piggy-back on
   SKIP_DASHED_BUILT_INS, if you have that enabled then only "git" (and
   git-upload-pack etc.) need to be aware of the version, which they can
   then set in the environment for the others.

   This also applies to e.g. the git-http* stuff, which has a user agent
   derived from the version.

 * {command,config}-list.h (and in-flight, my hook-list.h): Every time
   you touch a Documentation/git-*.txt we need to re-generate these, and
   since their mtime changes we re-compile and re-link all the way up to
   libgit and our other tools.

   I think the best solution here is to make the generate-*.sh
   shellscripts faster (just one takes ~300ms of nested shellscripting,
   just to grep out the first few lines of every git-*.txt, in e.g. Perl
   or a smarter awk script this would be <5ms).

   Then we make those FORCE, but most of the time the config or command
   summary (or list of hooks) doesn't change, so we don't need to
   replace the file.

Perhaps even better would be to piggy-back on the RUNTIME_PREFIX
support, and simply drop in generated plain-text files, so in your build
checkout the list of hooks, commands etc. would be parsed instead of
compiled in. Then we wouldn't need to re-build or re-link anything for
the version or this other data.

We could/should still have some facility to compile those in for
"install", see also [1] for some concerns / ideas for other similar
things that could use that.

1. https://lore.kernel.org/git/87czvoowg2.fsf@evledraar.gmail.com/

