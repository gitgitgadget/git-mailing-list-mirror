Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15477C6FA99
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 19:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjCJTJt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 14:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjCJTJk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 14:09:40 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099DE11CD77
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 11:09:02 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id i3so6677981plg.6
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 11:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678475341;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cuJBo+jyERZP30iw9EVk71aRZ/Q/FCHmiblX9bEdpO0=;
        b=JPOPx5tdD3ZQHHreO42AGem6w3chiI6zDMv3mtwA4sdf2tkZc0wmq8hmL08or9Su7Y
         HDpweE33d6lanWbV118Anxi6op2WVoK0uNfRmroYgtrfzZ3KsGhU9UvLafcmQLpj8CXI
         oV3g2zDSdFAdljnAZTtdOtgWG1BnRdeJsboUk4obXM0dO4o6McXANKSMEaTITW3je4Hb
         urv0SsQCL8mqLD+4zgNyeQekJT7NF2ws+Fb62dT0/694MUWeNlUwHABWo45O52vdHcXN
         MANgooeciE52aosuJFPoYzeUfoM9q2E5/ZFb5NqnoU2HFBwzXD8HDX7aDGN1fU9Un2ZB
         /qxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678475341;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cuJBo+jyERZP30iw9EVk71aRZ/Q/FCHmiblX9bEdpO0=;
        b=lzolo1aRnssKa7z9Zgw82dTLk4wG8W55ZWkbUEasfLsjr58s68APAdslvjVQM4J8Bc
         lN4EeRuTBeTpnT1bXwbf3nbwtKjh0pDia0MJ+1tHIxR5FgX1JiG6V9S2tpHk90UlxZl5
         wEIQ3Iu8yWJHmIIeh0moT4lAF5eNGi6AxEqWP9wA4FLqMvyahp/R8RhY9+FcHbET8nvU
         InsV/IY2oqG2zQJQtMKnM008XoI2vYX3eQC1Q9Zno/aSwHdyMuEhdxfXSJYhfv9tutXJ
         CsHjJFuehbz33gWWKUprv13UpkaOFHI+lasKqH/QGtVRc9P/xQgWB1xFSI83+hyMImxJ
         b33w==
X-Gm-Message-State: AO0yUKVyWRnepfpJ/NeaZHewHLtC26qGCwn9VFjGMKuuwfbIg1cCVMRb
        TtnmC0bRNEQskbiWNzkZ51G+1rsE9lI=
X-Google-Smtp-Source: AK7set/d6LzNUcJncceJllWZuZtwGgOC5Y6fggpciK6lGbZXxEuIgRQTxDoxt0GMDSPczsBpfyN03w==
X-Received: by 2002:a17:902:930a:b0:196:3feb:1f1e with SMTP id bc10-20020a170902930a00b001963feb1f1emr22603409plb.47.1678475340879;
        Fri, 10 Mar 2023 11:09:00 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id ke6-20020a170903340600b0019a91895cdfsm372757plb.50.2023.03.10.11.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 11:09:00 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 7/8] for-each-ref: add ahead-behind format atom
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
        <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
        <82dd6f44a33279551bb638357df4bc82253283e5.1678468864.git.gitgitgadget@gmail.com>
Date:   Fri, 10 Mar 2023 11:09:00 -0800
In-Reply-To: <82dd6f44a33279551bb638357df4bc82253283e5.1678468864.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 10 Mar 2023
        17:21:02 +0000")
Message-ID: <xmqqlek45sqb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Test                                            this tree
> ---------------------------------------------------------------
> 1500.2: ahead-behind counts: git for-each-ref   0.27(0.24+0.02)
> 1500.3: ahead-behind counts: git branch         0.27(0.24+0.03)
> 1500.4: ahead-behind counts: git tag            0.28(0.27+0.01)
> 1500.5: ahead-behind counts: git rev-list       4.57(4.03+0.54)
>
> The 'git rev-list' test exists in this change as a demonstration, but it
> will be removed in the next change to avoid wasting time on this
> comparison.

Nice.

> +ahead-behind:<ref>::
> +	Two integers, separated by a space, demonstrating the number of
> +	commits ahead and behind, respectively, when comparing the output
> +	ref to the `<ref>` specified in the format.

Don't we take any commit-ish, not necessarily a ref?  In the context
of for-each-ref documentation, I am afraid that the readers assume
that the word refers to a ref and %(ahead-behind:ea6e93913b) and the
like are forbidden, which is not what you wanted when you used
lookup_commit_reference_by_name() in the implementation.

> +	# Use " !" at the end to demonstrate whitepsace

psace.

> +	# around empty ahead-behind token for tag-blob.

;-)

> +	cat >expect <<-EOF &&
> +	refs/tags/tag-blob  !
> +	refs/tags/tag-left 1 1 !
> +	refs/tags/tag-lines 0 1 !
> +	refs/tags/tag-one-line 0 1 !
> +	refs/tags/tag-right 0 0 !
> +	refs/tags/tag-zero-lines 0 1 !
> +	EOF
> +	git tag -l --format="%(refname) %(ahead-behind:HEAD) !" >actual 2>err &&
> +	grep "refs/tags/tag" actual >actual.focus &&
> +	test_cmp expect actual.focus &&
> +
> +	# Error reported for tags that point to non-commits.
> +	grep "error: object [0-9a-f]* is a blob, not a commit" err
> +'
> +
>  # trying to verify annotated non-signed tags:
>  
>  test_expect_success GPG \
