Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD52C47254
	for <git@archiver.kernel.org>; Wed,  6 May 2020 00:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94ACE206A5
	for <git@archiver.kernel.org>; Wed,  6 May 2020 00:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnrKsS/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgEFAqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 20:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729505AbgEFAqR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 20:46:17 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B24EC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 17:46:17 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 145so122272pfw.13
        for <git@vger.kernel.org>; Tue, 05 May 2020 17:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xJMxbhTB3dqHfqh6vL7RMF2GTlQV8SpKNJJ8z+k7u00=;
        b=LnrKsS/yyfkgVvCllnVqHlfYl7ANQiuo1Bc+Q5MX3+pDEMfYX9c75pNekTXQxXfCcZ
         NVvvZAg5HYxe7NKLC+EUlhJrpTPYwBiJMdVNtbvvMygOTVv4BH5EhlralS2e2QFagD1h
         D6RGew31H2oImD9EomWNyox2b0laPL78z9Tuc4hp0XDUYmj9S9BSJLLSQOnpZGQ+4ANZ
         PB+MGp7Kgc8y23NN+dyR/fNfOS2Oiuoe7kKrixn+23Zfh17y9d3yLTHgsfV8i/qoVRky
         qDqh1ip4BT/ekVE63YN12GYkbYz4jK/R2F8VjL1KHTUtT9QVuzil5lxvWQEneKMrnpeq
         QrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xJMxbhTB3dqHfqh6vL7RMF2GTlQV8SpKNJJ8z+k7u00=;
        b=dYY9YWfeokWlfSRAvo6ewodzPEmwP+UTbXceuj/lVAHNaYZznXpOt9tm7f/ggj3Www
         PCTI9klNaXXkJi9faT8mlbEAvPwYvQ5CICGvzs4gYqFWfbWrbgnZBzAH/rRu43/uPN+3
         C96dC4GfLbwzkSrAV/fzYAmUUvt4r/9TkH6ww8W9wbbtED6xFnVw9ghSG24KWPhyXcVB
         tgeY/fINGZCsEYGPe6Fl4sORvsIJ7788AOCodszOskhvcAjJdZi0aDKisQTBrP9fx+2Y
         qy35AJNmoEnMUa6ISeaiPFkVqPheIU09G/tXXEXwWboq/WR8URrkDki6AJiKuF2T7gCl
         s0Gw==
X-Gm-Message-State: AGi0PuYVxOYNnIFdWOFcsrMrQ173IcmJWq4g+1UrvPfFx+pm0Zdti0l0
        SRD7ohlT1nGMKMFkD33TiHc=
X-Google-Smtp-Source: APiQypIwn8n60aiLXO2ARTAUPBzfJkK3uFXlOG2Cu4HIcmwlcucL78bILVw3X9818cAhJD1lm6XUbA==
X-Received: by 2002:a62:14a:: with SMTP id 71mr5378844pfb.33.1588725976453;
        Tue, 05 May 2020 17:46:16 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id x4sm44153pfj.76.2020.05.05.17.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 17:46:15 -0700 (PDT)
Date:   Wed, 6 May 2020 07:46:12 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
Message-ID: <20200506004612.GE927@danh.dev>
References: <cover.1588607262.git.congdanhqx@gmail.com>
 <73de97dfebfccabe9f1bf32ea41aea5008a949cd.1588607262.git.congdanhqx@gmail.com>
 <20200504162311.GE12842@coredump.intra.peff.net>
 <20200504215824.GC45250@syl.local>
 <20200504233634.GB39798@coredump.intra.peff.net>
 <20200505002055.GC64230@syl.local>
 <20200505164326.GA64077@coredump.intra.peff.net>
 <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
 <20200505182418.GA66702@coredump.intra.peff.net>
 <20200505210451.GA645290@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200505210451.GA645290@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-05 17:04:51-0400, Jeff King <peff@peff.net> wrote:
> We could likewise try to get some information from the branch name. But
> that leads to debates about whether the default should be "off" or "on",
> and overriding still ends up somewhat awkward. If we default to "on",
> you have to remember to name your branches appropriately to skip CI. And
> if "off", you end up having to contort your branch names or duplicate
> your pushes with an extra refspec.
> 
> By comparison, this commit's solution lets you specify your config once
> and forget about it, and all of the data is off in its own ref, where it
> can be changed by individual forks without touching the main tree.

How about supports the best of both worlds.

Let's say support wildcard 'wip/**' for opt-out.
And use "./allow-ref" to filter everything that passed the wildcard.

> I used refs/ci/config as the config ref, which should be a commit whose
> tree contains various config files (right now the only one is
> "ref-whitelist"). It was intentional to avoid refs/heads/ here so we
> don't conflict with any branch workflows. But it does make it a little
> awkward to edit, since you can't check it out directly.
> 
> Right now the logic is to run CI for all branches by default, unless a
> whitelist exists, in which case the branch must be mentioned there
> (using its fully qualified ref name). We could easily add in a
> blacklist, as well. Or since we're running a shell in a VM, we really
> could just run "./allow-ref $refname" and let individual forks specify
> whatever shell code they like.

Should we go with this route, here is a fix-up patch for your,
(after cherry-pick my [1/3])
--------------------8<-------------------
Subject: [PATCH] fixup! ci: allow per-branch config for GitHub Actions

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 .github/workflows/main.yml      |  3 +--
 Documentation/SubmittingPatches | 12 ++++++++++++
 contrib/ci-config-allow-ref     |  9 +++++++++
 3 files changed, 22 insertions(+), 2 deletions(-)
 create mode 100755 contrib/ci-config-allow-ref

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 51f4ff6e89..08217c5ed8 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -19,8 +19,7 @@ jobs:
           name: check whether CI is enabled for ref
           run: |
             enabled=yes
-            if test -e ref-whitelist &&
-               ! grep '^${{ github.ref }}$' ref-whitelist
+            if test -x allow-ref && ! ./allow-ref '${{ github.ref }}'
             then
               enabled=no
             fi
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 8686318550..8175424929 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -82,6 +82,18 @@ Alternately, you can use GitHub Actions (which supports testing your changes
 on Linux, macOS, and Windows) by pushing into a branch in your fork
 or opening a GitHub's Pull Request against
 https://github.com/git/git.git or a fork of that repository.
+In the event that you only want to trigger GitHub Actions for specific
+refname, you can create an executable file named `allow-ref` in
+`refs/ci/config`. Those below steps may help you:
+--------------
+$ git checkout --orphan ci-config
+$ cp contrib/ci-config-allow-ref allow-ref
+$ $EDITOR allow-ref
+$ git rm -rf .
+$ git commit allow-ref
+$ git push <your-fork> HEAD:refs/ci/config
+--------------
+
 
 Do not forget to update the documentation to describe the updated
 behavior and make sure that the resulting documentation set formats
diff --git a/contrib/ci-config-allow-ref b/contrib/ci-config-allow-ref
new file mode 100755
index 0000000000..b53e9ddbd0
--- /dev/null
+++ b/contrib/ci-config-allow-ref
@@ -0,0 +1,9 @@
+#!/bin/sh
+# Sample filter for GitHub Actions
+# GitHub Actions will run if and only if this script exit with zero status
+
+REFNAME="$1"
+
+case "$REFNAME" in
+refs/heads/no-ci*) exit 1 ;;
+esac
-- 
2.26.2.672.g232c24e857

