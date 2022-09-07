Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B3FC54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 18:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiIGSMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 14:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIGSMM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 14:12:12 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39870C0B68
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 11:12:11 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso19132003pjh.5
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 11:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=j4ivq9gSNN/8MFV5I0975VDAS4XpjB5k6yMjJswMfys=;
        b=XBhfFkvMPZN4sHDPFXCMk7mA9dO17zJW70Xbiu124kNrMwPWN5mWpcpoCi90bJQRHj
         3/cYHwtaJkCvstjFySSYabQtNTvu4uShKNWwtDQmW8mkuabBt+1ox8s58/OrePq4H2dR
         jTLl/a67mLnfnmNJ0TTSYQ63KiJbqR/hSyrv/IslFtHhL2r9mLaTjKEjYQXefdaSnQLV
         DADbJ7MPlscSLYNUZvd24d0RRdZvdgKSvswP2yIPqtdqWFZ28szgQOnOO4xy5Db1G47K
         OapyValxeb+Kyi5+1+3nY7uspbwaNXslcpuwZ58DeT2hjywYHAXhVIKtD250/kyCL2WE
         PKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=j4ivq9gSNN/8MFV5I0975VDAS4XpjB5k6yMjJswMfys=;
        b=BUlQYN2Y1K1HeHW1YyIncyaejoRF0v0CIne4hWSFNKR1j2ZGfWK5pQQFbe/C5mXtpx
         Y3MfFtM6dsCbZj4/L5L7Cqh+OhgQz2HkHh78msHkdobrM7SsXbRK50L9Coqyen7GVTUO
         8fvgABpJpHj7xcRaEK9uNEJxavTJsRe2iqyhBXXmk2p2RCzolvSazdwYYEl3tWuObwut
         0vKiw08cx/V8u2GtM5NyHQsHvR9Y9NwEz3BaLmqf/2cSPLyHcAnaBfg9FhGjVYWEYVA0
         incY+XBg2Wkum5h0z8JPR48ZQZXBdoCVroiK2Jl4b6sKwllNCHTaM1+e9KWI98STgR+E
         ZkFw==
X-Gm-Message-State: ACgBeo3T3ODhZND2ylmrXXfKriqH5f8sQk1dG4m1c29LLB0ZEMmkSdXb
        azyTqCyV/wrMknFhBBymZDU=
X-Google-Smtp-Source: AA6agR6ytOMkklKIpHY+SY6jErXqkI43Ur89lxlK7CviYa9PNPN67q9OJ/iLctf7LiDK5QboK6YhYw==
X-Received: by 2002:a17:90b:1b10:b0:200:934b:741f with SMTP id nu16-20020a17090b1b1000b00200934b741fmr5366113pjb.212.1662574330574;
        Wed, 07 Sep 2022 11:12:10 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b00176b7dcf2c0sm6868054plg.240.2022.09.07.11.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 11:12:10 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 5/7] rebase: factor out branch_base calculation
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
        <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
        <fc45b996d34af43f8e333f7c43a8b06489a1fda2.1662561470.git.gitgitgadget@gmail.com>
Date:   Wed, 07 Sep 2022 11:12:09 -0700
Message-ID: <xmqqo7vruk92.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index dd5e0e1feb6..b5c78ce1fb0 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -871,13 +871,9 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
>  	struct commit_list *merge_bases = NULL;
>  	int res = 0;
>  
> -	merge_bases = get_merge_bases(onto, head);
> -	if (!merge_bases || merge_bases->next) {
> -		oidcpy(branch_base, null_oid());
> +	if (is_null_oid(branch_base))
>  		goto done;

Naïvely, I would have expected the condition of branch_base being
null to mean "the caller doesn't have branch base specified (like
parsing --onto), so we would need to compute one" and this
"branch_base is null, so leave without doing anything" looked
confusing at first.

After computing options.onto_name (given either with --onto or
falling back to .upstream_name), we make sure branch_base is
correctly filled, either from an explicit A...B notation or a single
committish object name given and converted with a call to
fill_branch_base().  And fill_branch_base() uses null object name as
a signal that it punted due to multiple merge bases.

> +static void fill_branch_base(struct rebase_options *options,
> +			    struct object_id *branch_base)
> +{
> +	struct commit_list *merge_bases = NULL;
> +
> +	merge_bases = get_merge_bases(options->onto, options->orig_head);
> +	if (!merge_bases || merge_bases->next)
> +		oidcpy(branch_base, null_oid());
> +	else
> +		oidcpy(branch_base, &merge_bases->item->object.oid);
> +
> +	free_commit_list(merge_bases);
> +}

So it is doing the same thing as the original, but unlike the
original, it is not immediately obvious why "goto done" is the right
thing to do here.  Perhaps it deserves a comment, e.g.

	if (is_null_oid(branch_base))
		goto done; /* fill_branch_base() already checked and punted */

or something.

Thanks.
