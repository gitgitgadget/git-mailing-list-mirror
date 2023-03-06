Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E366BC64EC4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 21:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCFV0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 16:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCFV0l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 16:26:41 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F0538002
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 13:26:34 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id iw4-20020a170903044400b0019ccafc1fbeso6495396plb.3
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 13:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678137993;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yZKGtnXoN9wvvBZ5JaH934RnNl/po0zY6UrVNYrGT/k=;
        b=l7w8jJbypgncmbNUx6X2dZvHDlaeC+hBWmHiIAF0NL+H4EE0ijADpSDqvDDTvozI5G
         Gc7n50UHXOJyr456/am0sP+5owZaR4kh6e9zxfktA08L42HFBCklREUaIiCNRt+wZdnB
         ASOFZqUfW5khiWVCHj0bAmh/eItCqQkZpma1NAFg20l/KyE8g1RzUYVbG2T//JsN2Yf3
         qtSmwehbneD8L+HKziaQA1EffEXUZkbQ0j+K308nJSo789Mw7D4/nOFSs2UYdLyVisvG
         cbrG/Dj4HpH5IjVldrLtm7DGrhKVRhSg1B5PE62cLe5nrdep1Og2X9pII5sX7TrhkNpt
         +FJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678137993;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZKGtnXoN9wvvBZ5JaH934RnNl/po0zY6UrVNYrGT/k=;
        b=Ruh/O4RaPZeQahJ17puOps8e1QvSIgzse16gDVrbjqeWiL/JceHQTaMulRPCn7xsJB
         8aOKih6RncQsMwQm4LVFcb05s/U3yAUMIjdIj1IGcUa8ppvs10EJXyy+RdWD5KPMngX3
         VjDaR/YIVZlVCFRP1DM3LRp7QJtbyL/iAp0oFnZ46maWM8j26YGMnBBz0MLtnvYDeDS2
         rr13myTyaXFEJNTK10KPpnpAkEUGFcnlOoYMo0iQVNejaYyt0o0Yct0kPOUmYR8xTyMo
         DyYbzw6dE3SAOBe5EJUWRL6P8Q02nJi/6IDnOHoV3vuSbzAA5+ul3tOl0IU/SyJgp0Jv
         ZsvA==
X-Gm-Message-State: AO0yUKXjrQ4I54x1VzbsFIXYzzcKOTHqk+lE9AKvpeqtKDC08BqNle+Q
        2461IeyixBfsxGCxHxiwvGsPW+T1LISFjA==
X-Google-Smtp-Source: AK7set8Hkb1hs7EhGgiXS+r3APyGHf/pE5qXwBMs1Y2T4QoLxQ32UTCXsmj5e7PJSF4O13l4z//OelIACgGxIg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:90a:3cca:b0:234:35bb:978c with SMTP
 id k10-20020a17090a3cca00b0023435bb978cmr4527018pjd.1.1678137993529; Mon, 06
 Mar 2023 13:26:33 -0800 (PST)
Date:   Mon, 06 Mar 2023 13:26:32 -0800
In-Reply-To: <20230228185642.2357806-2-calvinwan@google.com>
Mime-Version: 1.0
References: <20230213182134.2173280-1-calvinwan@google.com> <20230228185642.2357806-2-calvinwan@google.com>
Message-ID: <kl6l5ybdeflj.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 2/6] tests: Use `git submodule add` instead of `git add`
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>, peff@peff.net,
        gitster@pobox.com, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

>                                           This commit cleans up such
> test cases where minimal other changes are required (e.g., committing
> later changes to .gitmodules or changing the counts of committed files
> in the worktree).

Okay, though perhaps not detailed enough to explain why these changes
were needed in some circumstances. It might be helpful to explain the
exact differences that you are adjusting for, i.e.:

- 'git submodule add' requires a './'-prefixed path
- 'git submodule add' changes and tracks .gitmodules

> diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
> index b2bdd1fcb4..dd2858648b 100755
> --- a/t/t2013-checkout-submodule.sh
> +++ b/t/t2013-checkout-submodule.sh
> @@ -10,7 +10,7 @@ test_expect_success 'setup' '
>  	(cd submodule &&
>  	 git init &&
>  	 test_commit first) &&
> -	git add submodule &&
> +	git submodule add ./submodule &&
>  	test_tick &&
>  	git commit -m superproject &&
>  	(cd submodule &&

Junio mentioned that the change from submodule to ./submodule was
surprising, but this seemed quite clear to me. Maybe that's just a sign
that I've worked on submodules for too long.

> @@ -51,6 +51,7 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .gitm
>  	git config diff.ignoreSubmodules none &&
>  	git config -f .gitmodules submodule.submodule.path submodule &&
>  	git config -f .gitmodules submodule.submodule.ignore untracked &&
> +	git commit -m "Update patterns in .gitmodules" .gitmodules &&
>  	git checkout HEAD >actual 2>&1 &&
>  	test_must_be_empty actual
>  '
> @@ -59,6 +60,7 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .git/
>  	git config -f .gitmodules submodule.submodule.ignore none &&
>  	git config submodule.submodule.path submodule &&
>  	git config submodule.submodule.ignore all &&
> +	git commit -m "Update patterns in .gitmodules" .gitmodules &&
>  	git checkout HEAD >actual 2>&1 &&
>  	test_must_be_empty actual

I puzzled a lot over why these changes were necessary. The answer is
that .gitmodules was formerly untracked, so it didn't show up in the
list of files during checkout. But, now that we use 'git submodule add',
we do track .gitmodules, so we instead 'fix' the test by committing the
.gitmodules. This one is unobvious enough that I think it's worth
calling out specifically in the commit message.
