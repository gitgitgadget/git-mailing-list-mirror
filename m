Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191E2C433E1
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 09:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D765A619FC
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 09:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhC0JIn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 05:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhC0JIT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 05:08:19 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061ABC0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 02:08:19 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so6059796wmd.4
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 02:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N24qMB61IMIChz9K0ObioVXXmugFQd5V8mm7c6gI/9s=;
        b=QdPcx5U7f56qZe4bLJ9vQyIof4S4GqQ/oZuiAO4ImwQIhu4wki22JbfF2ISoT9UpMz
         L85YuNFWHs2ytOlcVBkA98ZQcKRXOPYoFiwozNgWNVekhQuRgF1b7i+5Wqn0FVud3QuC
         q7+uvOhGgBe5h0n+H08q6alcEi4oVHRcPPBDh7bobpiMZJjC9LmhkoGjTrEcsR1f7GC4
         ontawEM7jBLhoZlsQB92EawMqQ6MohMxTn7ZZYoX7sOU1A/wAWvkTesG2A3PXPrCLPeJ
         lzOdZRewlMX1kwGyM6TYxr8P+vsgUlfK0lc7j/yyGS6LGAHa52E3jzL7HblquYoDKLWF
         Ao+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N24qMB61IMIChz9K0ObioVXXmugFQd5V8mm7c6gI/9s=;
        b=TjfcdzJzw5SUOgcbvz1P8QYb10OoNB8pGFy6qSjnbfga5JVYjIj6ZWCCgLz9q730nf
         tVTIZsWp2fbFG05OaaVJnXvmSK5xAMEqN+7eeup1njVuGMnMAuP63vDZdklRrctfOtqQ
         jb+L0koqePCArX14GNApgq8Gx4kxpeSNtAxaPqwCWpf6yTH3OhcpPXlqc3vhYpslYpSx
         pX1baK12lnPAPB8NZ7PijeOFuo6q3cIKZoNjE4vdyuMpBBa2Fc8nlClhVL94BkqHeZKK
         L2vcRzt3y5oUwRAuY2cUw3hMIbi5LnWWC65PFKhnJmpvXXVi4tmL032ongevZeKrovBi
         qI6Q==
X-Gm-Message-State: AOAM5324TD63KmeRLqfFuLxPXLUun01LIlQA8QNpup4odQeGxRMafb+0
        tsuW37HEmZfIOHw+lHwW8Jk=
X-Google-Smtp-Source: ABdhPJw/e/1RybF2zC67rDGdWdrce2bnJh4qMaSo1Llk+tesU/Kbvse6vCRVdRrAvLmixOPtOt4T7w==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr16589117wmc.59.1616836097132;
        Sat, 27 Mar 2021 02:08:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:85f:2a0a:9300:501f:ca6d:3b18:1e72])
        by smtp.googlemail.com with ESMTPSA id x25sm17346619wmj.14.2021.03.27.02.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 02:08:16 -0700 (PDT)
From:   Stavros Ntentos <stdedos@gmail.com>
X-Google-Original-From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
To:     bagasdotme@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stdedos+git@gmail.com
Subject: Re: [PATCH v1 1/1] ci: facilitate dev to mimic a CI environment
Date:   Sat, 27 Mar 2021 11:08:13 +0200
Message-Id: <20210327090813.7847-1-133706+stdedos@users.noreply.github.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <5196a86c-1153-8998-a8cb-c8bd20687150@gmail.com>
References: <5196a86c-1153-8998-a8cb-c8bd20687150@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > diff --git a/Documentation/howto/setup-local-dev-environment-docker.sh b/Documentation/howto/setup-local-dev-environment-docker.sh
> > new file mode 100644
> > index 0000000000..265602ea55
> > --- /dev/null
> > +++ b/Documentation/howto/setup-local-dev-environment-docker.sh
> > @@ -0,0 +1,43 @@
> > +#!/bin/false
> Wait, why did you make this documentation /bin/false script? I think
> it is better to be in Asciidoc format (.txt)

My full intention was to actually _create_ a script that would put a
wanna-be developer (me) from (a) looking at my terminal inside git/,
to (b) have a ci-like environment, inside an abstraction layer (docker)
with linked sources (i.e. the "${PWD}:/usr/src/git" part).

However, the way sources and docker invocation are defined, I find it hard
to create "the script". Also because (again) my docker knowledge is limited.

I want future nitpick-fixers (hopefully with more docker experience),
to look at this script with such agenda in mind - and not to "just"
document their findings alongside mine.

`#!/bin/false` is simply my way of saying "it's not ready to be run yet",
and I used `.sh` to get formatting / syntax highlighting cheaper than
running a fully-fledged .md file.

If you still insist it's no good as a ".sh",
my intention would be to make it .md (to get some formatting in it).
