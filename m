Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBD8C1F45F
	for <e@80x24.org>; Wed,  1 May 2019 14:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfEAOq2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 10:46:28 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43158 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfEAOq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 10:46:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id j20so15096966edq.10
        for <git@vger.kernel.org>; Wed, 01 May 2019 07:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=LtvfFP50An3qypXhYnSFPSUkNmk1HGXPPi4E1qbBvgs=;
        b=OMHx1zhBT7UerbEdmDmmayt/4CJ0UPA0xHKKYhrW+vfdAB9aWwik/62gdehtxokUCK
         8tvtWsclCnGdUwXtYbd1drYzWve0xuIiI+i7CIwWDaN55HZZWH+8bxfsjb7uGiLlQ5d6
         5lWUIqbF4W9E3l2irY6EXEfp3rnYm8D4+lP8B9bSccSD0AMkB06bFScwgb2PelkKX7Rb
         vfFK4mlbOajhraKzxTn4MP5n+y60QIffEPIbSAy0eVJXdmxTIO27kuVxXsMpe3iHy9/c
         FMc/0PuS6AnJ2T0W9owA1xIURqRcTYE2aERr15Gq6Yn8KB+ucKCqtVpjRzEOl3t8gyY8
         P3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=LtvfFP50An3qypXhYnSFPSUkNmk1HGXPPi4E1qbBvgs=;
        b=tzDDU+06nvsjUHOANQyod0gViqegBwNlyW+qdalcEuGuhxSbjMSiVXi0LsVYgzxIWH
         Vs+GDgXKdDU6u18btY1SxsBE2uPObaCXZ5pweC8Y8yTj86WhgRuRniWv3efI5rVbThbd
         cgy1lhITm4rKpuPo6S0+yY/S3ts5mqZ4LxAHGk4wd/YCSeyu4oPMmu+ys4KpFgEKf+8P
         vR1Yw4ShcxA+du2UAYgME9JHo3lR7to2fj434i9fyPCpLmrD5ZHHQcV+Fgd8omNFwSDf
         B/LoVOrbaYFha6K3V5OBQ2PCF4/IPAa+S1skR0VFtQ9c/rVJYnbormL5r+wMAaAab94+
         1XYw==
X-Gm-Message-State: APjAAAWqhncdohZlNrATMGlJ4QKzJimblnQQHP/3DNF3yAn2mKlnaC52
        4rvTNIumz38Ytdg6qzjgdXY=
X-Google-Smtp-Source: APXvYqwRhQQ2LXffFyCRIKmjIHPLgvdAMdwnGpMJVt3lvx0MxfvKWVjlaQnkoV2im4ThvpPjilHqFQ==
X-Received: by 2002:a50:947c:: with SMTP id q57mr20480987eda.81.1556721986607;
        Wed, 01 May 2019 07:46:26 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id 65sm10049284edm.60.2019.05.01.07.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 07:46:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 1/6] commit-graph: return with errors during write
References: <pull.112.v2.git.gitgitgadget@gmail.com> <pull.112.v3.git.gitgitgadget@gmail.com> <91f300ec0acd825494fa13d93cdc4770bbf2ac14.1556716272.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <91f300ec0acd825494fa13d93cdc4770bbf2ac14.1556716272.git.gitgitgadget@gmail.com>
Date:   Wed, 01 May 2019 16:46:24 +0200
Message-ID: <87pnp2qlkv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 01 2019, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The write_commit_graph() method uses die() to report failure and
> exit when confronted with an unexpected condition. This use of
> die() in a library function is incorrect and is now replaced by
> error() statements and an int return type.
>
> Now that we use 'goto cleanup' to jump to the terminal condition
> on an error, we have new paths that could lead to uninitialized
> values. New initializers are added to correct for this.
>
> The builtins 'commit-graph', 'gc', and 'commit' call these methods,
> so update them to check the return value.

Seems good to have a test to check for some of this behavior. I see that
can be done as just:

    echo doesnotexist | git commit-graph write --stdin-packs

And checking the exit code is 1 as it is now, not 128.
