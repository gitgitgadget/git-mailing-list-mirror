Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C988C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 21:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiKGVdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiKGVdK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 16:33:10 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7462EF1D
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 13:33:09 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id u24so19615486edd.13
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 13:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/aF0bO79ZYt89EDNT60S/q19W1erTeB3PggwNfQLdCY=;
        b=HOVsn39P6IlH8wdjSPszPpLTCBuvvF2q1kNPBOByvpwB5Nj2prpyuEoh23Q09jTT5p
         njrzHMqnmtD47LTWAeelmZdZVq1usB6NHWZCxEXjuY1gZsahVSfaDJzwpNU5XEGp+k6a
         I04c7heBXf/PALsjDB+5lRQgrWw8EypAGjz4QeeOIOAGpcCrflD1eZzWujAmn0zJ2aqB
         H8Nf2R+1pl7u1n0qFEi8QyuzSXSlFhismZF9BKfKVWLNO2BjP/mAFz2mnS5m8k90EYDR
         +tFHQwu5z7MBjLz9m8G4cKXnHBpF9I+bH3sb8c/BQ5A/cKoTtOj2AodYKux8zeXP2RoT
         AJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/aF0bO79ZYt89EDNT60S/q19W1erTeB3PggwNfQLdCY=;
        b=m/HiRbzpw9jYpNo7P9dwyTKe3DAL1zJUt5mjC4Z6CrRkzkNzF3k4OSYRSbd5nfhk+i
         pOKDofigTNbfvPgFRFuh2l9CiF9gm8AVpQx6HHxhPVsg8ioDzaxy7YGlbNpqZKk18Ht+
         i6MdkvfqhUfmjCZJBhh4OMIwjfY75UG9lSuM/Nfs6KOGJtmNViuDHW+Rp3+1Ol7hZ2NF
         x8TIK96ZsYU9z2AVUdbU+TAO6USZdjrLvww2Qqq3GOJ/2SZ6Iy5JMImlSOOHFiYZw70k
         g9hViftuRkh5dGQBWwSkPzCX6zEja7IS3dhv2VNySlMEz4SS461BSireJRYHUan5QzC1
         Ur6w==
X-Gm-Message-State: ACrzQf3Sx09GCDQtVKcLZOJO+AXEF+xRgemz8AVMMV9DtikK8McTcNyk
        7KuicVTHT9XAHMHmWt2M1A8=
X-Google-Smtp-Source: AMsMyM52sXl3RU8WTdfD9K0/Hr3gOPhkhwPy0VPrxwhNZYhW4C2m41ioL/CjZxl6nWEHP8IOTcEf1A==
X-Received: by 2002:a05:6402:e01:b0:442:dd7e:f49d with SMTP id h1-20020a0564020e0100b00442dd7ef49dmr52036414edh.355.1667856787760;
        Mon, 07 Nov 2022 13:33:07 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id d14-20020aa7d5ce000000b0046447e4e903sm4806731eds.32.2022.11.07.13.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:33:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1os9ju-000M3G-29;
        Mon, 07 Nov 2022 22:33:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 01/13] bisect tests: test for v2.30.0 "bisect run"
 regressions
Date:   Mon, 07 Nov 2022 22:31:50 +0100
References: <cover.1667667058.git.congdanhqx@gmail.com>
 <cover.1667667460.git.congdanhqx@gmail.com>
 <5571bc36b84210e16ab8731fea8bf0ed8d62cca3.1667667460.git.congdanhqx@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <5571bc36b84210e16ab8731fea8bf0ed8d62cca3.1667667460.git.congdanhqx@gmail.com>
Message-ID: <221107.86o7titppp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 06 2022, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> Add three failing tests which succeed on v2.29.0, but due to the topic
> merged at [1] (specifically [2]) have been failing since then. We'll
> address those regressions in subsequent commits.
>
> There was also a "regression" where:
>
> 	git bisect run ./missing-script.sh
>
> Would count a non-existing script as "good", as the shell would exit
> with 127. That edge case is a bit too insane to preserve, so let's not
> add it to these regression tests.
>
> 1. 0a4cb1f1f2f (Merge branch 'mr/bisect-in-c-4', 2021-09-23)
> 2. d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell
>    function in C, 2021-09-13)
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gma=
il.com>
> ---
>  t/t6030-bisect-porcelain.sh | 79 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)

Looks good, if I do say so myself :) (unchanged from my topic)

But I wonder why your "fix the regression" base topic isn't starting
with this. I.e. our intial report was about that "--log" issue, but now
we know we altered the output in ways we didn't intend.

It's fine if we say "that's less important", but then ... something
should say that .. :)
