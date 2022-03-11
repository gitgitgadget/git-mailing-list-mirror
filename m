Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1562AC433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 13:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348963AbiCKNqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 08:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240780AbiCKNqo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 08:46:44 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CB71C4B16
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 05:45:41 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id g20so10979394edw.6
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 05:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=9JObHHE55Sg62i1Jyf9HKv49ZowyGnCOAhIywXr+imU=;
        b=kLu+ikkfo+DuXCNoB5X/gMCQJW2Cf3+Kdgj09aW6gLzt0jOA+aNwzuXFPu37wNbc7m
         7UmAYLiyfBpTjRiGxZ70FJdA3wvMGVGuPYB0iGamvyAiwp0pWlBImaO1O0BFnBmzPPRF
         krsb2zO5h7j9NbDrDwIodos24fL31G+HM/Ob3+PiTZhWtNROd3syS12hcHAXTuYwJJwH
         u8LvnDdgCt06PfBeNqWJlqhUZJcgj3bkx5eQv/Nieey3q3f4Us1mtl6uZiHa1H0t4jMj
         B5JvdQtJiVC7FgyH/DMLh5fzX0qGNWCOWM0aL+X+i5c99Cf2LPmrnPl+sh/pEqwvJdgw
         nQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=9JObHHE55Sg62i1Jyf9HKv49ZowyGnCOAhIywXr+imU=;
        b=ovZKtCt8+oeWO3kMOKIKRSiM6Y5A1d1/9cv+Et0pL8h1fASWHbGg/l4VmrNgVUf2RD
         cTxSulHBiPCHk+6qaj/9ivh+dU3KuJ+lL1cGgsaHpZ5q1MfiFUkkFj1bJrEvNKmMxCka
         r3rFPe89K/5XtAGU+UhApKhWXZot1QjnK0VVy4I8i7byaTF8Oytg032ZIE8mLZBzVByE
         hWpF4re9jjGgK5jHu/TTbWv2GQOMchETIf0CSatg+n3j6tAS8GCSXtmbV1O7FUjyKCyC
         O4wNZBeU8o2CBtE9RrZmD/Mwtq8vwnCakqM/Q78agKTB5W0x413vMhlAj9E/teQswC1s
         oAKQ==
X-Gm-Message-State: AOAM531VHXuWgYLRMHeen1zKmnSdBR3qnBp3QbaIrz8VviwmW7Ed6AvY
        pM+ww6XrABq1RR3zpDf+jqKoTbwpa4eEuw==
X-Google-Smtp-Source: ABdhPJwJxPj7lC35EPTYXtuRVjZr9Q69cRiCf8qk8wD8PwEEwCmmZtEvF0UwjflYa+JYrnmCSisS3Q==
X-Received: by 2002:a50:aa87:0:b0:40f:28a0:d0d6 with SMTP id q7-20020a50aa87000000b0040f28a0d0d6mr8879173edc.368.1647006339589;
        Fri, 11 Mar 2022 05:45:39 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o13-20020a170906974d00b006dbb09089d7sm441483ejy.121.2022.03.11.05.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 05:45:38 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nSfaM-0012vr-D4;
        Fri, 11 Mar 2022 14:45:38 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        aevar@gmail.com, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 10/25] bundle: add --filter option to 'fetch'
Date:   Fri, 11 Mar 2022 14:44:36 +0100
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
 <fa0e83b39dd3c3bb16e932c39aff080a1fdf8fe4.1645641063.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <fa0e83b39dd3c3bb16e932c39aff080a1fdf8fe4.1645641063.git.gitgitgadget@gmail.com>
Message-ID: <220311.86h784habh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 23 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
> [...]
> +			/* Skip if filter does not match. */
> +			if (!filter && info->filter_str)
> +				continue;
> +			if (filter &&
> +			    (!info->filter_str || strcasecmp(filter, info->filter_str)))
> +				continue;

General API comment: Do we have a need for strcasecmp() now anywhere
when dealing with filters?

    $ git clone --no-checkout --filter=BlOb:nOnE https://github.com/git/git
    fatal: invalid filter-spec 'BlOb:nOnE'
