Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0677BC4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 22:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiKYWvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 17:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiKYWvr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 17:51:47 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F230030F7F
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 14:51:46 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ud5so13147759ejc.4
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 14:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jsB2jZxtD3qrew4tKJQX6jpxN++/a/02szDnDQQG1wc=;
        b=pUEZT16JbuGNQW2QkZOYhTWSEyTy8szL2VIhSFVdoV7Mnp0q9F10V1+FaeaVHEqHEm
         FQ2tx5qc1+Oc/ReTAhRjfXxla31gfwqh+XPuMHJ+pQ/XMviLGUxTLL/hBxv29cNqckKL
         7dFS2J2O7jD8M5TnPkOKyKoMlUIv17y7vsiokW9XfBOWsLrHe34nRv9NmzZ43KOF+NNX
         /lhmO4qHW3a/vXeZP36gQlgm9/1GtZw128N2AG1mvbe+v2FV2r2pXPrFJGnpb/1za1+U
         cM1juHRDBGZqFUbaoWhIqkGsYqyV+UF4dwRCN3KDtIBahxnasqys8Ue3oIaHgxfkdpcc
         tsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsB2jZxtD3qrew4tKJQX6jpxN++/a/02szDnDQQG1wc=;
        b=BY6/aCH4g9jRaHVA4JdOl1gHlCM+e36csTs329/DTvrSyTEDoUJCxI+HWT2tQRMxa9
         m8Ja67BHpeOGeP/EoSt/2ARvnWzzLSBT6/r0WUeNQVJWvrKicl0VSn+WMVRBmhgKq3gh
         dmpk8dOX8k/7Zoz6vn3lRl5RHtHon193trwYgHXRYBADaqb+vfn3/lOJb2jEHolPkqcO
         ISsuQnsSEmxBylUWe2yVnYsF9OBPevYFZK2Tv3h3Y9rLxcBVXtIt6WRO6QFlrFU2t/8f
         Y8VWgYmA2HecKJLlI59tGz/KYqJ3BYvhnRoXW6GwQE95TcyHteZ+EMjXWc1hcMiDHOjH
         psPw==
X-Gm-Message-State: ANoB5pkEmmXtthQ3DvFGki8U0VftguBpzjbO8Q5tXYtCm4yPaBAlJd2x
        M0eSgbvIPkaZOWZ3Jn20E09Q/GQgGQnWw+TJ
X-Google-Smtp-Source: AA0mqf4dd6CPxqRcnFkF0JHtmCFXqp+W+juWZ7/Nzuu7cQ34N5AaUJuFEoHVTXZTlrlY+2dqediCLA==
X-Received: by 2002:a17:906:774e:b0:782:55de:4fcf with SMTP id o14-20020a170906774e00b0078255de4fcfmr33964435ejn.85.1669416705294;
        Fri, 25 Nov 2022 14:51:45 -0800 (PST)
Received: from gmgdl ([213.143.127.178])
        by smtp.gmail.com with ESMTPSA id f23-20020a056402161700b00469f58ee2cdsm2274073edv.47.2022.11.25.14.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 14:51:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oyhXq-000bnG-2l;
        Fri, 25 Nov 2022 23:51:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sean Allred via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Subject: Re: [PATCH v2 2/2] var: allow GIT_EDITOR to return null
Date:   Fri, 25 Nov 2022 23:48:08 +0100
References: <pull.1434.git.1669321369.gitgitgadget@gmail.com>
 <pull.1434.v2.git.1669395151.gitgitgadget@gmail.com>
 <427cb7b55ac3fead1651cbad7318b9c0bb454b08.1669395151.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <427cb7b55ac3fead1651cbad7318b9c0bb454b08.1669395151.git.gitgitgadget@gmail.com>
Message-ID: <221125.86pmdamyv5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 25 2022, Sean Allred via GitGitGadget wrote:

> From: Sean Allred <allred.sean@gmail.com>

> +test_expect_success 'get GIT_EDITOR without configuration' '
> +	(
> +		sane_unset GIT_EDITOR &&
> +		sane_unset VISUAL &&
> +		sane_unset EDITOR &&
> +		>expect &&
> +		! git var GIT_EDITOR >actual &&

Negate git with "test_must_fail", not "!", this would e.g. hide
segfaults. See t/README's discussion about it.

> +		test_cmp expect actual

Looks like this should be:

	test_must_fail git ... >out &&
	test_must_be_empty out

> +test_expect_success 'get GIT_EDITOR with configuration and environment variable EDITOR' '
> +	test_config core.editor foo &&
> +	(
> +		sane_unset GIT_EDITOR &&
> +		sane_unset VISUAL &&
> +		sane_unset EDITOR &&
> +		echo foo >expect &&
> +		EDITOR=bar git var GIT_EDITOR >actual &&
> +		test_cmp expect actual
> +	)

Perhaps these can all be factored into a helper to hide this repetition
in a function, but maybe not. E.g:

	test_git_var () {
		cat >expect &&
		(
			[...common part of subshell ...]
		        "$@" >actual &&
			test_cmp expect actual
		)
	}

(untested)
