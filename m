Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA34C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLOJwH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiLOJvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:51:25 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA3831ECE
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:51:06 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id u19so32461818ejm.8
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d+oMJ0r5uVlDjKaRPnbYQEkF98XS2uU+5JG/dPGDQCs=;
        b=PVrsCPDhpktguspndD2L/wnod2ltRkSg43B8yaa/G1D9HedIdYn+Up18sDAEvqsFFC
         +dXZ3CXnsj1wKB2padcKnc2kOcq3G+cUXDvLUhYgnAPnKHdNVw5OV0f47oKqsLwqTK+S
         9/cIrBq7ONEwR6DhrWD+BGGUpbs98g3SKWPveTWReTOQ1EGI20jxDbIQEOy3UdQ/8fI+
         qpGarWo4lCkXVZpn0nzXZ/pXdZqZcJ0WiDDBipEoyLIIq8v/9aKzzm84fKODfAAXQojY
         duXQfOqEoYbUhpr9rpQo9C7XWupCP34mDsErMmbXCiZQOuO+lZZr9sL5ZwaJjuN4Lj2g
         2D6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+oMJ0r5uVlDjKaRPnbYQEkF98XS2uU+5JG/dPGDQCs=;
        b=6QYygTRPZrX5kefxCykToeYhaT0j3bHnOfm2oPygElnEXAkVG24pQWJuF2P0EAZtlR
         /j/oRF7v9zjsPfhjvpF6LaIPcAFofRP0WZA+KnYQoGuKiEVx4/CK6x57eksruE0U8oCw
         2NiC0HTxZTlRBevW+TqBOPTSwqpdsWLX0UqNmsSataD06pgbC5dvvazS9xwNdmTj2Cxw
         fihhlEKsG/GVmCO9+jX9+8mzczi7KM7GwY3ieahPOEsV1EHR8piW4t6qr9Xxg8gUjsYs
         I4lrJWY9HIa1U91yxrHkEJJweX8x0NBlv98H5kPWQiY54v8RcaBXDZxposnmP/cb+Bta
         CLrw==
X-Gm-Message-State: ANoB5plcYconuUrlY5Ge5hOXepg5RCDydoFCYlMZuP8h5aB6eDMN2K6M
        D2+DG4mNdvRjdJItTkKOSsWXojw5kyGsBQ==
X-Google-Smtp-Source: AA0mqf5L4eXI9Z5WNRD/rxYfChcT1MUALYWnG299K+hTZ/75+kFJgeUiKXNONLDbE+hmkZGvU+aIEw==
X-Received: by 2002:a17:906:cec1:b0:7c0:d606:c570 with SMTP id si1-20020a170906cec100b007c0d606c570mr22541622ejb.61.1671097864763;
        Thu, 15 Dec 2022 01:51:04 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 27-20020a170906311b00b007c0b4387d2asm6870334ejx.8.2022.12.15.01.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:51:04 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p5ktL-006B7M-39;
        Thu, 15 Dec 2022 10:51:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: js/bisect-in-c (was: What's cooking in git.git (Dec 2022, #05; Wed,
 14))
Date:   Thu, 15 Dec 2022 10:49:44 +0100
References: <xmqqiliewbje.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqiliewbje.fsf@gitster.g>
Message-ID: <221215.86mt7p2dx4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 14 2022, Junio C Hamano wrote:

> * js/bisect-in-c (2022-08-30) 17 commits
>  . bisect: no longer try to clean up left-over `.git/head-name` files
>  . bisect: remove Cogito-related code
>  . Turn `git bisect` into a full built-in
>  . bisect: move even the command-line parsing to `bisect--helper`
>  . bisect--helper: make `state` optional
>  . bisect--helper: calling `bisect_state()` without an argument is a bug
>  . bisect: avoid double-quoting when printing the failed command
>  . bisect run: fix the error message
>  . bisect: verify that a bogus option won't try to start a bisection
>  . bisect--helper: migrate to OPT_SUBCOMMAND()
>  . bisect--helper: make the order consistently `argc, argv`
>  . bisect--helper: make `terms` an explicit singleton
>  . bisect--helper: simplify exit code computation
>  . bisect--helper: really retire `--bisect-autostart`
>  . bisect--helper: really retire --bisect-next-check
>  . bisect--helper: retire the --no-log option
>  . Merge branch 'sg/parse-options-subcommand' into js/bisect-in-c
>
>  Final bits of "git bisect.sh" have been rewritten in C.
>
>  Tired of waiting for too long.
>  source: <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>

I submitted
https://lore.kernel.org/git/cover-0.6-00000000000-20221215T094038Z-avarab@gmail.com/
just now, which cherry-picks the various small fixes from this topic.
