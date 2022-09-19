Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30685C54EE9
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 11:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiISLR3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 07:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiISLR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 07:17:27 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFA010556
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 04:17:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x94so23441261ede.11
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 04:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=20C3XsQHCFj9/FXQqN+YZ02QIZt0bt4j2MAemY6s9AY=;
        b=RKo6NHC2U70jyqT3eolN98nWGmlMKF4xvHj+C/pIAsNwENtofD4iwug3KNdviKmNCt
         l/o0vXhVb1QRFGtTDT0c1KQdRJc2ALn1h2/mAJak9dpVEPnHQdjrQwbtwbqtGzvTifQP
         LtJk1LC1w3FxeGZTnQ5SWf4SIG8gez0jP7DQCikoG3tibH7aFfv30WTY4u65K5eizJJ7
         22fdWqACEoW2lbea2bE6JKvbfCru3tUj+2/RI6Fhly5A672H3ghe1jAsgqqGfvmrr4ck
         g9wtB0YPYhL9ol2sovWV41OQFpShrVzyx+F7yO6eeZW16BDtQRO0KuRWscSP2dP5bdVk
         sJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=20C3XsQHCFj9/FXQqN+YZ02QIZt0bt4j2MAemY6s9AY=;
        b=O2x0E3CUD2Ze15jIhYu72LiI+M0Ath4gWKAURdTa3nLTTO5iw2cR72zmfsBnwcLxEd
         MRj1cerbN3qp8vFXdWwO+B2TqxfI7dvQCaf6j06J9XsUdO4tEc47d/gGAkjr+MTzKXXT
         Y7B4rm4WdFlW/jInEFI1vSCSBH53rXhwL7OZqSJ3b1/tUgPvVd7pEGYJ7C5a60/7jFvi
         mqWsRDCrfaViAFwKr7wEN1k7fgoxTtv1jgu1Reg22wa+l+V5HNMGHOGTHSs471KWolk5
         3sLVaM1htrDN9KyrRcqkd/Nn8pPfYrG5zNaHHq3FhmLl6ToIevekP8Um5IuzJzn83VJv
         mgzQ==
X-Gm-Message-State: ACrzQf1s/txbyIi+l7fZE6seVtPDb6+YNBIoAb/pFT3KlpI1vXhGntJs
        HDv9OcpeiO03feTEtpLlwic9D7bI/TI=
X-Google-Smtp-Source: AMsMyM61j0Prgu0cCkfeSB/qKKzE0OMMtpiDt1VccyYQjKUpJDVAWhlEOTopJgIzN1tLQXEwbFETng==
X-Received: by 2002:a05:6402:2549:b0:452:8292:b610 with SMTP id l9-20020a056402254900b004528292b610mr15090846edb.199.1663586244944;
        Mon, 19 Sep 2022 04:17:24 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id u13-20020a170906408d00b006fe0abb00f0sm15300970ejj.209.2022.09.19.04.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 04:17:24 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oaEmB-000bx5-23;
        Mon, 19 Sep 2022 13:17:23 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Arthur Chan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Arthur Chan <arthur.chan@adalogics.com>
Subject: Re: [PATCH v3] fuzz: reorganise the path for existing oss-fuzz fuzzers
Date:   Mon, 19 Sep 2022 13:10:04 +0200
References: <pull.1353.v2.git.1663457311149.gitgitgadget@gmail.com>
 <pull.1353.v3.git.1663542495094.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1353.v3.git.1663542495094.gitgitgadget@gmail.com>
Message-ID: <220919.86r10762bg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Sep 18 2022, Arthur Chan via GitGitGadget wrote:

> From: Arthur Chan <arthur.chan@adalogics.com>
>
> This patch is aimed to provide a better organisation for oss-fuzz
> fuzzers, allowing more fuzzers for the git project to be added
> in later development.

I don't see any problem with this change per-se, but this rationale
really doesn't explain anything in the end to the reader. How does just
having x/y-*.c files rather than x-y-*.c allow for more fuzzers to be
added? We could also add new fuzzers to the top-level now, why does this
change help us to do so.

I suspect the unstated reason is just "adding a lot more would make the
top-level cluttered", or perhaps some design reason you hinted at in
https://lore.kernel.org/git/2405897f-a774-e0d3-99bb-2185dcbb5432@adalogics.com/
(but I haven't taken the time to fully understand).

So, I'm fine with this v3 as-is, but also wouldn't mind a v4 with an
updated commit message to address the above confusion.

> --- a/.gitignore
> +++ b/.gitignore
> @@ -1,7 +1,7 @@
> -/fuzz-commit-graph
> +/oss-fuzz/fuzz-commit-graph
>  /fuzz_corpora
> -/fuzz-pack-headers
> -/fuzz-pack-idx
> +/oss-fuzz/fuzz-pack-headers
> +/oss-fuzz/fuzz-pack-idx
>  /GIT-BUILD-OPTIONS
>  /GIT-CFLAGS
>  /GIT-LDFLAGS

Speaking of clutter, a much better change here IMO would be to create a
/oss-fuzz/.gitignore file, and then move these there. For prior art see:

	git ls-files '**/.gitignore'

Even better (but I'm not sure how this is all used in the end), can we
perhaps build those in a .gitignore'd oss-fuzz/.build/.

But maybe not, and in any case that would be a larger change to the
Makefile logic, so we can leave it for now, but I do think it makes
sense to create a oss-fuzz/.gitignore in a v4.
