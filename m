Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D883AC2BA2B
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 00:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D6120732
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 00:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XVYefcGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390674AbgDNAzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 20:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbgDNAzH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 20:55:07 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1435FC0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 17:55:05 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id y12so8514850plk.23
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 17:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dwFywkNhtR6W0Y71A59UTJvE4Armc4sjFY6hajQw0e4=;
        b=XVYefcGABB4tfXNBKeRnGOZkGbC/x6PSqVDR9qVDWqDnAs0BKmQ3qmGVefwuE1yw/3
         fYBKEonnOVBGyQEb8AuoPfu2xcXDB7LyiwRKnSFNN1aOPPSvTLJWdyiT6raFUNLd3qF4
         6KLcC3eqoFILDtnGL3ScZ5o37u7KAABRZRenSIOawwF0Ek/CL9q5DmKLL0hy1vCUYK9N
         LBtEDOE2LEtfB2LNj+b7DV8Qbuf+xNCjWGBkUQYdkqTN6mwrr6CDeDtxF6HThl0L35zV
         iM9lAz9S8CnxNsDRI9xFQURhqES4KXOSJSbX6GFWvdtXSSx1i1woH6WenxHR5osQ5Us4
         42Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dwFywkNhtR6W0Y71A59UTJvE4Armc4sjFY6hajQw0e4=;
        b=BOZb8zIzSmwqgCFeP8clUkXdMcGaewTUQMD5E0IDek0C9DwDvegIN5dshVC6HFcwrV
         Zkr6kghSKn8fUn4sIPVV/bcyW+eWHQBudea3GulbTnLy5YDdMkd2Cw+43qdNASCsDx2w
         mYj42BQzNfnJBxYsVnc1pMx3wGTPL9VtFczgoed93HYjjKVc2AqTQCgHVqyS4+bPouYs
         KWuXKZSeU2WljcJ9vR7QyMzWUXjVKruYwbS95fukBaN8drOKzuz1NJbq9TMgZ3mOXCGX
         s180OVt1k71vKVj8eo3atzeNLs2uZsZIkHYNVZxTZGCXu/ow3YtdkK8dP/HFecPGbOw9
         IkzQ==
X-Gm-Message-State: AGi0PubT0cLce1qq++to4KTTjqxveySxDPalz4NdUuQJmUFLGCYaiwko
        FLtSuYZJFO8i9B3VfNawRpWN7OhhIJGttbzsYBmWT6REVjGEdDforQhVS0CGJs+gaPmSCYGFede
        qHoBEhCFAp7af6lxEm2GZuTmZ81W78JLVuvAY/pwE7EY5v2dJ3bE0TwGkLutm2wRMEaaM2kDdRg
        ==
X-Google-Smtp-Source: APiQypIXVhGrTlz19NiNwN40qHRpN9/cFWQmU+P/rL3o4m+gBN/WYmou4hlg2tPbx66qghVNRuSmCH4i1yCbmOIrGvc=
X-Received: by 2002:a17:90a:be18:: with SMTP id a24mr23461361pjs.92.1586825704272;
 Mon, 13 Apr 2020 17:55:04 -0700 (PDT)
Date:   Mon, 13 Apr 2020 17:54:55 -0700
In-Reply-To: <20200413215256.GA18990@coredump.intra.peff.net>
Message-Id: <20200414005457.3505-1-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191210023335.49987-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [RFC PATCH v2 0/2] configuration-based hook management (was: [TOPIC
 2/17] Hooks in the future)
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not much to look at compared to the original RFC I sent some months ago.
This implements Peff's suggestion of using the "hookcmd" section as a
layer of indirection. The scope is a little smaller than the original
RFC as it doesn't have a way to remove hooks from downstream (yet), and
ordering numbers are dropped (for now).

One thing that's missing, as evidenced by the TODO, is a way to handle
arbitrary options given within a "hookcmd" unit. I think this can be
achieved with a callback, since it seems plausible that "pre-receive"
might want a different set of options than "post-commit" or so on. To
me, it sounds achievable with a callback; I imagine a follow-on teaching
git-hook how to remove a hook with something like "hookcmd.foo.skip =
true" will give an OK indication of how that might look.

Overall though, I think this is simpler than the first version of the
RFC because I was reminded by wiser folks than I to "keep it simple,
stupid." ;)

I think it's feasible that with these couple patches applied, someone
who wanted to jump in early could replace their
.git/hook/whatever-hookname with some boilerplate like

  xargs -n 1 'sh -c' <<<"$(git hook --list whatever-hookname)"

and give it a shot. Untested snippet. :)

CI run: https://github.com/gitgitgadget/git/pull/611/checks

 - Emily

Emily Shaffer (2):
  hook: scaffolding for git-hook subcommand
  hook: add --list mode

 .gitignore                    |  1 +
 Documentation/git-hook.txt    | 53 ++++++++++++++++++++
 Makefile                      |  2 +
 builtin.h                     |  1 +
 builtin/hook.c                | 77 +++++++++++++++++++++++++++++
 git.c                         |  1 +
 hook.c                        | 92 +++++++++++++++++++++++++++++++++++
 hook.h                        | 13 +++++
 t/t1360-config-based-hooks.sh | 58 ++++++++++++++++++++++
 9 files changed, 298 insertions(+)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 builtin/hook.c
 create mode 100644 hook.c
 create mode 100644 hook.h
 create mode 100755 t/t1360-config-based-hooks.sh

-- 
2.26.0.110.g2183baf09c-goog

