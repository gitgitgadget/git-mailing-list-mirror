Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 005471F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 22:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733199AbfAPW2J (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 17:28:09 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44659 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730972AbfAPW2J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 17:28:09 -0500
Received: by mail-ed1-f65.google.com with SMTP id y56so6740775edd.11
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 14:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=erCzoryW71mGri5EXhluaNXaBxkS7MeETPq5/QtyxoA=;
        b=Flit1GwAvbK6gRWB8oD5TzKwdaG5sBl//iWlwo8SnGykHPsjze9gzGhf1t6+2QwNE8
         8qmj+s/TioYSC/Z4ks6TQBjsfVmHh22FOw4KI/QJAgJo1xNJwvV29q3GG+SbdTSAI+aQ
         VOW7PV9mg34Ptc87fuXKDT0r7Ni7uLY++tcOY/s75vt/d8n8wz0+zLEyvjN9NZVf1aaM
         CQzloRYGl1v3BRCdqkBP6CKGXNQ18VDoeqd1j1NrjMkNZZGCnKkOMzDq825xuXV/kBid
         qXjS4jyRJATH+WiljtdUjHuGEH4cg4JY3mrVpq1O3SBsyJylrpnQQ5+QQhuhQTxNUkwX
         9WgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=erCzoryW71mGri5EXhluaNXaBxkS7MeETPq5/QtyxoA=;
        b=CLeFoi4D+L5ZpWYT68Api5NmZ41esiU8GHjI7UaGJ0Y6Gjplca913g6d12uWBlusl0
         BnYsVAVGbqm5qzT1FyiqRlNqEjVJVKBXWMcqWX+ni/kJlIHvKr621HKLHjyojJ6myZLM
         Jt0Povzn8h2rfvziSuTiAyd2W30NEiZhoXQcCRfU0CMw8biwaXY+LqUHT0kqvvVkJwSl
         s+546xYQa0MNLn0N1xGqpuD6JfaFp/mFCsJeI5xZO87uI1M8aSSvaN6IEeLqlEeGxkGw
         wx37tdPO46MJpJeRB7jJegNjgJhg/QrE8GTWLJ9vY8n601V28Z4OAgLXin/MPgwapVCT
         35Pw==
X-Gm-Message-State: AJcUukeRM5ukqWwopKiYsZg/flOXDUuQts+/BAfpM55HB0l6Us3aGkVx
        SadCZUi235fYMJbThzGhIJVQ6xoCQqgVVth3YMn2PocG4aU=
X-Google-Smtp-Source: ALg8bN50m+oIFCfZiuvA6CQ2oWnHmEDu+kO6WKpS59qykv24Kw62KOSUh201pqHEsxZWb+d/eB6WWqpCNGSCcFOQTEg=
X-Received: by 2002:a50:8343:: with SMTP id 61mr9249343edh.154.1547677686922;
 Wed, 16 Jan 2019 14:28:06 -0800 (PST)
MIME-Version: 1.0
References: <20190116103159.9305-1-pclouds@gmail.com> <20190116103159.9305-4-pclouds@gmail.com>
In-Reply-To: <20190116103159.9305-4-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 16 Jan 2019 14:27:55 -0800
Message-ID: <CAGZ79kY73eYTSDqyQAYcqVJn4t9kMNW00_=uPN1yCEwaOij3MA@mail.gmail.com>
Subject: Re: [PATCH 03/10] submodule add: support multiple worktrees
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?Q?Tomasz_=C5=9Aniatowski?= <tsniatowski@vewd.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> --- /dev/null
> +++ b/t/t2405-worktree-submodules.sh
> @@ -0,0 +1,42 @@
> +#!/bin/sh
> +
> +test_description='multiple worktrees as superprojects'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'set up submodule source' '
> +       test_create_repo submodsrc &&
> +       (
> +               cd submodsrc &&
> +               test_commit one
> +       ) &&

Just like git itself, test_commit now supports the -C <dir>
argument, so you could replace the whole subshell with

    test_commit -C submodsrc one &&


> +       test_commit initial &&
> +       git worktree add -b secondary secondary HEAD &&

Could we have multiple things not named the same?
(i.e. have the the branch and worktree be spelled differently)
That way it is less confusing and we'd catch errors of swapping
these two in the implementation (unlikely, but...)

> +       git config extensions.worktreeConfig true
> +'
> +
> +test_expect_success 'add submodules' '
> +       SRC="$(pwd)/submodsrc" &&
> +       git submodule add "$SRC" sub1 &&

you can also use relative paths in submodules:

    git submodule add ./submodsrc sub1 &&

if you want to.

> +       git commit -m sub1 &&
> +       git -C secondary submodule add "$SRC" sub2 &&

Oh never mind, by having the absolute path we
add the submodule with the same setting.
(When using relative path we'd have to use ../submodusrc
here, but would that matter?)

> +       git -C secondary commit -m sub2 &&
> +
> +       git config --get-regexp "submodule.*" | sort >actual1 &&
> +       cat >expected1 <<-EOF &&
> +       submodule.sub1.active true
> +       submodule.sub1.url $(pwd)/submodsrc
> +       EOF
> +       test_cmp expected1 actual1 &&
> +       test -d .git/modules/sub1 &&
> +
> +       git -C secondary config --get-regexp "submodule.*" | sort >actual2 &&
> +       cat >expected2 <<-EOF &&
> +       submodule.sub2.active true
> +       submodule.sub2.url $(pwd)/submodsrc
> +       EOF
> +       test_cmp expected2 actual2 &&
> +       test -d .git/worktrees/secondary/modules/sub2

This section is very brittle. For example the way how submodules
are active changed not so long ago, and might change again, which
seems unrelated to the thing tested here?
