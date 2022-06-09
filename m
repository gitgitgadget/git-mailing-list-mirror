Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757DDC43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 13:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243004AbiFINyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 09:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243365AbiFINyk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 09:54:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE97AEE36
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 06:54:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b8so14632231edj.11
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 06:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=lpznvjO3Gh0NfXnhV0uYs6y8Fyfm5SZgR9U07//WGaM=;
        b=bCWkIJN0SREoWaYFaPnkC8aY7MYqAksRLLu3st8ibbDbmweygQZ4tb6h/BJ9y8EtSf
         CfBM1ZSW2pfyrX4GGdqPaGhGA3Tdd0HCXKaIuU5uQ4psNIY59MfRRx3KYBHafpWjMyAN
         rErZQ8qdyzLT4RITgT53lEyCPXZe34um7/u+F8IvldoN9HY29DxNKyFsGpbxHxfWOmy6
         FvClhwwRffB6OVwy0jdAedTTtIwHVgHesMRoTH5O3xdRU1PBiXVCbK0xOrBezSJLaxUa
         lphZFzQ5C43jWYpqNrgLjctUhcNPsWS5r1oaab5uNPprKa8YDNy7Vc3W3MC8WJB7A8yc
         LbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=lpznvjO3Gh0NfXnhV0uYs6y8Fyfm5SZgR9U07//WGaM=;
        b=2SL/t3SaYmsoMnEEh9rIFudqR9cYVAIRCAs5RkBjcFIg0VwAqFzabWtV89+gxN729R
         OR1p7nXW866yBmto5sgS/OxguqF17KR60F0jO4SpDXwZIjvya0x6jWOJkmqAInkh/8QN
         zWMwuiVG7NAQMwWN1ev1KFn5W2OX4wR31bva7yQXX7mJWd0LBBbbz14ybZIvsyvpts2X
         k4GtZ4upJS9EXOAPqaCloVd+16/YAalbVycBPjH4kn3AULtFXr8q6ODrVAXjzZO/taUf
         8n8EcJ5lstHsQwNZu9/6aWzLmr4dcbN8QaNotMurEv/lpZAQl704+o7pErxxdptjC0Iq
         M9bw==
X-Gm-Message-State: AOAM530VT9QRbboKuie6llm1i6IrJu68ISLvtejobKnSG4RReNBNq/AD
        glDppIc8YWyObXTQFtU+5lWIHvkUn/c=
X-Google-Smtp-Source: ABdhPJz8wlz4utzb6lVYamxojJDL3+r+LG8GEHZyltevqXNQ1kU24PiWIPkf55ikuU1dvH/dF3ZogA==
X-Received: by 2002:a05:6402:4252:b0:42e:13d4:4f4c with SMTP id g18-20020a056402425200b0042e13d44f4cmr42997412edb.92.1654782876730;
        Thu, 09 Jun 2022 06:54:36 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id v3-20020a056402348300b0042dccb44e88sm3638598edc.23.2022.06.09.06.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 06:54:36 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nzIcN-002uwh-Pf;
        Thu, 09 Jun 2022 15:54:35 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] ci(github): also mark up compile errors
Date:   Thu, 09 Jun 2022 15:47:35 +0200
References: <pull.1253.git.1654774347.gitgitgadget@gmail.com>
 <19d6e34f038121b927cdfacc3c4ae5abd1791415.1654774347.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <19d6e34f038121b927cdfacc3c4ae5abd1791415.1654774347.git.gitgitgadget@gmail.com>
Message-ID: <220609.864k0ut010.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 09 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When GCC produces those helpful errors, we will want to present them in
> the GitHub workflow runs in the most helpful manner. To that end, we
> want to use workflow commands to render errors and warnings:
> https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions

The docs you're linking to state:

	::warning file={name},line={line},endLine={endLine},title={title}::{message}

But here...

> +		sed 's/^\(\([^ ]*\):\([0-9]*\):\([0-9]*:\) \)\(error\|warning\): /::\5 file=\2 line=\3::\1/'

You seem to omit the comma, and the CI output itself seems to note the
filename as "compat/win32/syslog.c line=53#L1".

I haven't tested, but is this the issue you noted in the CL as "the only
downside"? I.e. the link to the source code is nonsensical in that CI
output, it links to the diff of the PR itself.

But the GH docs say "associate the message with a particular file in
your repository.", so it would seem that there should be a way to link
to the file at that revision, not only if it was altered in the given
commit.

On the "sed" one-liner, at least GCC supports emitting JSON error
output:
https://stackoverflow.com/questions/36657869/how-do-i-dump-gcc-warnings-into-a-structured-format

You don't fill in "column" now, but if you used that presumably that
would be easy, and more useful.

It seems clang also supports it, but not any easily machine-readable
format:
https://clang.llvm.org/docs/UsersManual.html#cmdoption-fdiagnostics-format
