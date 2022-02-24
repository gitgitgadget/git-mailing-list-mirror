Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCEBC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 00:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245228AbiBXASY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 19:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbiBXASX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 19:18:23 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF0D4D9D2
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 16:17:54 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id qk11so881301ejb.2
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 16:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=E8H8w7sAblCXV5aYt5U75hhZWpyGc5OS6IuWwXvCQDM=;
        b=htxJVybvdb1ZeNDgVSI8gJXObGUE1Sc8Ogjuo4bkZNWfi01OX0zh2rf4OmXXa+uMj1
         9re8lcb6r+Oq/ROQsS0kUu3qLR/bMxUJz4dIIbRtYDWOLx0F8bkK/0ygM+DcJUcG1toz
         dzlY4cWvNLnus8Or51cVY890Qrn43ANCD8toWzsYwFVcZMC4uPD4wbEfN6g98z/vf0wY
         o4tQkPpz6rFS9YzuEAkvuEtptlsMw6upIFyM4AIMzdkvhjgK4ech3qWQqyne93QmWeZU
         cLHFE9+c9Z+RPeaRXxdG560oXIPGu2IX2nsf2vZykGTq6T/CW+gSamhwZh/i9G+BO38w
         Ngsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=E8H8w7sAblCXV5aYt5U75hhZWpyGc5OS6IuWwXvCQDM=;
        b=cDYbRnL8FS8GiTlu0ERhkofRIK3EcyooBKDJA7Zy8IRB6LCQhB4pKrl6GnWU39j5dJ
         gk++7WvwQ9aXMNcVMgY2pq60uKGE6hpABpTW/BzDDX9prPFDe6au38hNLsPgs20KQezJ
         kgrQbnanR8/nCzwe9DNo4ZbNnYdDKgJcKcKLCwvUnyWP+D4FyCsGA/rdj6EIXpmNCZzJ
         mbC8o4K5wE4m47gMIksBaSiKEhbgtJsYvZaxAuNpSiReaZAnrtT0/Mmu+LG7N382U5Be
         vevIkNSgSnwhUcnMdlr7yh5dqT8CEv2cfqme+8c4JYpQV7Bj1jfdlXVoW6gp5uf/BRuH
         KLLQ==
X-Gm-Message-State: AOAM5317SXoBT2geRPlXgh43cQdlYVeqZhIbAeEFYJUkx0Dj2VhNowKe
        EfiieGPoB2WcdOeDvaLSUGJAIlOsxTU=
X-Google-Smtp-Source: ABdhPJytuxm9VGnX1cNUyJ1GnuF28PuHyT58w+ftIzVRcmiwsHHUvjOntyJq0DewAn1XC4Y1FLTf4A==
X-Received: by 2002:a17:906:3e90:b0:6b6:829b:577c with SMTP id a16-20020a1709063e9000b006b6829b577cmr146594ejj.711.1645661873281;
        Wed, 23 Feb 2022 16:17:53 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s12sm458100ejn.121.2022.02.23.16.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 16:17:52 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nN1pP-0008Bn-SA;
        Thu, 24 Feb 2022 01:17:51 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matt Cooper via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        derrickstolee@github.com, Matt Cooper <vtbassmatt@gmail.com>
Subject: Re: [PATCH v2] index-pack: clarify the breached limit
Date:   Thu, 24 Feb 2022 01:14:25 +0100
References: <pull.1158.git.1645632193.gitgitgadget@gmail.com>
 <pull.1158.v2.git.1645661240356.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1158.v2.git.1645661240356.gitgitgadget@gmail.com>
Message-ID: <220224.86wnhl9ky8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 24 2022, Matt Cooper via GitGitGadget wrote:

> From: Matt Cooper <vtbassmatt@gmail.com>
> [...]
> +test_expect_success 'too-large packs report the breach' '
> +	pack=$(git pack-objects --all pack </dev/null) &&
> +	sz="$(test_file_size pack-$pack.pack)" &&

I don't think this needs a re-roll, but FWIW I have an old-ish local
patch I haven't submitted yet to s/test_file_size/test-tool path-utils
file-size/g in the test suite.

I.e. we've been moving more in the direction of using test-tool
directly, which some tests already do in that case, with some using
test_file_size.

> +	test "$sz" -gt 20 &&
> +	test_must_fail git index-pack --max-input-size=20 pack-$pack.pack 2>err &&
> +	grep "maximum allowed size (20 bytes)" err
> +'

Maybe this is covered by another test, but in case we don't have a test
for this error already: This doesn't cover that we don't error on packs
smaller than the limit, so in terms of black-box testing it's
indistinguishable from us erroring out about this all the time.

But that's probably too paranoid in the first place, and maybe we do
have that other test...
