Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4759EC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 17:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381723AbiBURah (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 12:30:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381727AbiBUR34 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 12:29:56 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA7419C2E
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 09:29:33 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id n5so10551028ilk.12
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 09:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2AZ3/Q4lIPb6lOS78J7kuR+IvRDw0kjBwb3JjeD4M28=;
        b=P3/p4VZm6KK0RSnpYfB9CiduR53JwX+tDybJZLhiBcrikyqEZEfgkyPJ6NQuKEqkpF
         ND8FWYtAhWiNNg12uLDY7fvr6ADjnSJPCMfpW4mk8lqDgmZPvRnW3B6vxnGMiPa+DfG1
         1mI/djm7rzR9H6sWrOMHY7FVNU80+AoyYPvEBeJ6DsQ2PXAJ1KWeoCIWM0zr5ZVzxzoL
         gaih6CZoeH5sFtLCfS4b3RGAnoUCGHgQr6if9AhX2c2AJKWuRtz4Oc5gcCzfQt0i4kGN
         yzrSPozGOLXzGF0v1bpcYYVTiLTqETImlWTj3LTePThZ5do3zdWushTshgJvTnhc8QlB
         cIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2AZ3/Q4lIPb6lOS78J7kuR+IvRDw0kjBwb3JjeD4M28=;
        b=n+6TNAcKOf8QSvMKllPoR7NfGcQOk7RBxMJIBa/bIbRtYohAX7voUzd6TpimP1hJsy
         611MP18QbCNkaBa4+VvZSD0UaMK3xpJ/aF/DgEAyjUGP+Gam05mvXXaCPs8nKLbMkMmz
         JDyaQbzvDaLhMvyG8yzZXF3jNvjwN1myzX/rB3wp//S9vWZOAkqgut0dn/qIK6M/nDKZ
         N4xaq6t0324JGBTfdoZ8qGJsGKaf3nParPURpGZeJX/CEfmLgFn1lqa0f2LenlNU+5mA
         Q8D0V306Ic1dTB4gJa3HaEcVZM+ycZq+5JE8rI4eYs1Rp3FxnQtJl6PcELsBzG7ySpA7
         RjYg==
X-Gm-Message-State: AOAM532zTCYj4ws7aZ8afqKuCt5VsFXlPJXLp/T5fcwFMCkxAaekMqSz
        Hx9PWIzXStE/6vHByNjJtoFNWbR1aiXlLfcn
X-Google-Smtp-Source: ABdhPJz2IHVTy32XeyLJKQBzB+GwVX43bystelPUB7Cr8oo4h5ao54tjAFC68KkXjaRtg0GywOkGBg==
X-Received: by 2002:a92:c606:0:b0:2be:6c59:572 with SMTP id p6-20020a92c606000000b002be6c590572mr16298723ilm.57.1645464572865;
        Mon, 21 Feb 2022 09:29:32 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v4sm3093968ilq.58.2022.02.21.09.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 09:29:32 -0800 (PST)
Date:   Mon, 21 Feb 2022 12:29:31 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] test-lib: make $GIT_BUILD_DIR an absolute path
Message-ID: <YhPL+wSxtI0KIz07@nand.local>
References: <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com>
 <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com>
 <patch-v3-3.4-b03ae29fc92-20220221T155656Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-3.4-b03ae29fc92-20220221T155656Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 21, 2022 at 04:58:34PM +0100, Ævar Arnfjörð Bjarmason wrote:
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 77c3fabd041..ff13321bfd3 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -41,7 +41,7 @@ then
>  	# elsewhere
>  	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
>  fi
> -GIT_BUILD_DIR="$TEST_DIRECTORY"/..
> +GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"

Sorry to notice this so late, but this hunk caught my eye. What happens
if `TEST_DIRECTORY` is provided by the user (and doesn't end in "/t")?

Before this change, we would have set GIT_BUILD_DIR to the parent of
whatever TEST_DIRECTORY is, whether or not it ended in "/t". We'll still
do the same thing with this patch if TEST_DIRECTORY ends in "/t". But if
it doesn't, then we'll set GIT_BUILD_DIR to be the same as
TEST_DIRECTORY, which is a behavior change.

If you just want GIT_BUILD_DIR to be absolute in order to for LSan to
understand how to correctly strip it out of filenames, could we replace
this with:

    GIT_BUILD_DIR="$(cd "$TEST_DIRECTORY/.." && pwd)"

or (an admittedly less clear)

    GIT_BUILD_DIR="$(dirname "$TEST_DIRECTORY")"

Thanks,
Taylor
