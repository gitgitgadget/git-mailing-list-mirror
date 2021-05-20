Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1460FC433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E320D6121E
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbhETPaF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 11:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239185AbhETPaE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 11:30:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D23C061761
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:28:42 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r11so19837437edt.13
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=5sYnVxcY5UlXwjNIOJAVgLoWfJY4TPkCaurla0NbMKY=;
        b=asS5wQdRwDMK1ep++ADC/rO5XYcx+o5Kvi4IjV6AmIpGHagj+eefMgN3ULdw4ZKJs4
         YaExou7vzppmHiabbbM6b7Xz0Yag7Ax2M9Efe9mgVhn1F3Ckq1TYtuhrwPMCpnmt9yg+
         w42Y8HyRXle62gMwKhZ4o0Lp0xHdLPQTL1r6kS9bXhpIuhBryzuPfENe/9AczLKF8Bg/
         UeKShdnnIx7jP/F/H869JIRNrQnoYy8tR28ydjqfxXInrwBR3AW/x8loQwGhxnH2G8lW
         Azy+Da4ST5o1ma7ImXfcU+Y7xbg0vpuVpm8cdrj/iC+OpJMtby1xxacE0ct9chdK07QR
         7NZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=5sYnVxcY5UlXwjNIOJAVgLoWfJY4TPkCaurla0NbMKY=;
        b=B2SYinY7M+pLy7hG+XFFYncuiCkutVgXUnE0P0Rz4GW8q8k3Ng7AHQMNtKO+J+vdCN
         Y3R6GFmFzoGs6JqM3XzcO+mBQ3x3NE66757ITra5zSQ2fSlZPIiNTHqw6EQ5jya/kLGB
         7uSdzl1AhzyWJozkcu6NH6fMj3TLS4tfCbemeLE0PmaBI7EwhQi7VbXLmPwiJ/GmAgTD
         zNjwClZx7saz7UneJI/oCbPr7HTqhaNPYuayBGDUjH1ItsLCojr3P5G0bXGhHN8A2Y79
         hcmYo9EUyB0gLXfBdPl7HmdHjbZyr+vWpt0NhnWZu5MK8WLoD59Lcc8G3PcbkEZHcVY6
         Y8Hw==
X-Gm-Message-State: AOAM531OXqwkHZaR1BkaRl/aIpFrePhmGi+x13SBMPymIa4Nz97bWfzm
        UsywAIVI8ue+b66rSSBXG6R0RJibgS2tnw==
X-Google-Smtp-Source: ABdhPJyQ4DQHOlx6qtITivQiy1yiJt6qAH3Yc2Lzjw5ajTOLfBsqD8mGuLWQc8jE8VJJqFKOnBGCQg==
X-Received: by 2002:aa7:ccc6:: with SMTP id y6mr5628872edt.303.1621524520959;
        Thu, 20 May 2021 08:28:40 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id t20sm1551510ejc.61.2021.05.20.08.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 08:28:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 12/21] t5304: use "reflog expire --all" to clear the
 reflog
Date:   Thu, 20 May 2021 17:27:23 +0200
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
 <d8e80d83b6f8ee929b187aaffd5f37c3c981b50b.1619519903.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <d8e80d83b6f8ee929b187aaffd5f37c3c981b50b.1619519903.git.gitgitgadget@gmail.com>
Message-ID: <87sg2hpgpk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 27 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This is more explicit, and reduces the depency between test functions. It also
> is more amenable to use with reftable, which has no concept of (non)existence of
> a reflog

Sounds good in principle, but:

> @@ -94,9 +94,7 @@ test_expect_success 'prune: prune unreachable heads' '
>  test_expect_success 'prune: do not prune detached HEAD with no reflog' '
>  	git checkout --detach --quiet &&
>  	git commit --allow-empty -m "detached commit" &&
> -	# verify that there is no reflogs
> -	# (should be removed and disabled by previous test)
> -	test_path_is_missing .git/logs &&
> +	git reflog expire --all &&
>  	git prune -n >prune_actual &&
>  	test_must_be_empty prune_actual
>  '

Isn't the point of the existing test to check that there isn't an
existing reflog, not to just expire it if we find it, or does expire
--all return non-zero if none was found ?

> @@ -104,6 +102,7 @@ test_expect_success 'prune: do not prune detached HEAD with no reflog' '
>  test_expect_success 'prune: prune former HEAD after checking out branch' '
>  	head_oid=$(git rev-parse HEAD) &&
>  	git checkout --quiet main &&
> +	git reflog expire --all &&
>  	git prune -v >prune_actual &&
>  	grep "$head_oid" prune_actual
>  '

Just skimming this I'm perplexed why this needs expiring now, as opposed
to being s/file/command/ changes like the rest...
