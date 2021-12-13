Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B63CC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 16:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240694AbhLMQ0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238083AbhLMQ0V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 11:26:21 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72F4C061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:26:20 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id l25so54323208eda.11
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=tAq8yeWVre0sIaVvd+fvRRg9SclSQIYUnPjWgJayL9g=;
        b=mRYX4GIf/qfWh7qJVRgRoORy43g1HyyNFYA7rB+8fl4bADhA3htV420W5Vt9o004J/
         8hnoCmDNTFGj5D0Ieb2p0sRizYN5w3J90hyJcxkyiJLX5gjD/OSYUnmribp4GPpW/Z0l
         tSZDoRO64+XNFkVZTqu2AupD784YIrjtJG5VoF+uwF2UfgeW8bV8XzA2UrOt1M+f8Bp8
         wdJccmPNCeb3DdSWd+XXwU+sjyzjjZVt7uJLH4i48M7C8bburn5s5JT7/n89Rc7LxNPs
         Js7aaXxJ2cw1E/KTWD0NXpp5NdT9ShwkujsPssu42U9B/mGojm0Ul8n7C5Wds+w3EPfN
         NfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=tAq8yeWVre0sIaVvd+fvRRg9SclSQIYUnPjWgJayL9g=;
        b=3GoVd50u1bgqemlcFTC1oKU0WHzICPycNUVsDyTIXGNpy2+NbpQtvDcYwtQV5WAlb0
         TUpow38q4FNq3FHNSbGrn8W1SbCwWLFnCY6CiiYR7umCmRqAfar/1JCmnGkUIWWdKM05
         9I4MOq1c7+c4mHp1MMEGIlNlYSRkksQg3c6ZQGBnsdLx8uXpaJT2u+yklIc2LBdBgd2L
         otpVuBxrWTgjwHiGMfPvSuMhiu2XlfA/VXs2UwpZnb2SYy08pyr/iq4RvKF6EBfcQoQG
         LugVCe/wFJE9UFrqF4iIkGy/23VugDNwvotTdKfEs3vu0EUzHqKNtCY1WoeWXHxuS0IB
         405A==
X-Gm-Message-State: AOAM532T+ogimXtzvBhNqEuuTPL4xP8Rv3GKdFzn83bR92CzTuRoUjjQ
        kjGxQ/QqrCQc6JN18x+7q5ZGH2CoYO7jFw==
X-Google-Smtp-Source: ABdhPJw3nJjZPoPFE8cWEjUfZWmoxu0LSsLkwPeCg7qvf2fgishQK3UGjxCqjo25FSB/7PN5F2d9Cg==
X-Received: by 2002:a17:906:8a62:: with SMTP id hy2mr44179141ejc.347.1639412779282;
        Mon, 13 Dec 2021 08:26:19 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q17sm6675807edd.10.2021.12.13.08.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:26:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mwo9Z-000uBM-Ki;
        Mon, 13 Dec 2021 17:26:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 08/11] reftable: order unittests by complexity
Date:   Mon, 13 Dec 2021 17:25:23 +0100
References: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
 <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
 <9dce18d7349fe2a27859c224068fb5a386f263f1.1639411309.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <9dce18d7349fe2a27859c224068fb5a386f263f1.1639411309.git.gitgitgadget@gmail.com>
Message-ID: <211213.86h7bc8o9i.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 13 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This is a more pratical ordering when working on refactorings of the reftable
> code.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/helper/test-reftable.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
> index 26b03d7b789..f08d66df949 100644
> --- a/t/helper/test-reftable.c
> +++ b/t/helper/test-reftable.c
> @@ -3,15 +3,16 @@
>  
>  int cmd__reftable(int argc, const char **argv)
>  {
> +	// test from simple to complex.

A C99 comment, which I don't mind, but is explicitly forbidden by the
style guide (and when I mentioned recently that we didn't have any
portability reasons not to use these, there wasn't much/any interest in
changing that...).
