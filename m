Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B313FC32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 21:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjARVPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 16:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjARVOl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 16:14:41 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE9358961
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 13:13:46 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id g2so197489ila.4
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 13:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WlTJjX6M//YsAuFH55SR//u/M+WRsqo/2gpvimnQkhM=;
        b=7x+H2rOPkEZwkEX78jB1GMRMGSqq/YR2XShRcVn7yGFEuAq96AOwS9Q1j5sBhezhLh
         8X8tcmPpCGaJAw9FjaSNlZuwCfnHP5UDMY+2GW15OlAJamwvfnb9lykbbSqaMIIflbMR
         eARHu7OUa9oCZBZC+yzUrAuyd3kT/20wyMp7WoX9OpPsZxxEAUcQ1C8GeU8+pZV1ce9E
         MjBcFM0F+qyydCOWckgHGHkyRTkre+ol0u8ZgMOPT1jiHPLG3plD/qeQL78G4B9t8XNS
         W+7ljBP2dEqPj2GHINeeHbYChi/v2VsMxGIpzhU3bAV/Z/DiAdpXXZw9d5MCdzmIOfxg
         fPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlTJjX6M//YsAuFH55SR//u/M+WRsqo/2gpvimnQkhM=;
        b=Tk7GpAgHtSELzB4AMpgepIIq0VF8GQRJicUvoYN66iqMfR14z3Ket2BKMmo7n+2QEL
         cw943XenYO9+I2e6j7JxiwYnHYhoW+HTxVk0kPJU2umc/lZqAvHhC+tjSU+/YmPGiSIV
         e8HfHo9VSpO0wNtB3RhaBUEsiKxzdQFYEzT+XrAb8xNI+9VQLogbtrQDL0Eiqrm9xwKl
         svwb1YxNTPaVNf198nkjtUGq+Na/yO6KGerqU19OwAogrMKFMKtWdrfaznzyuE0k31Qr
         Eyb6J4tfbjcWDgJ5aV21bZ4eWib915mUEB7o84Q+3oPfllYjtjz657G6NsCny83eVVpJ
         SkIQ==
X-Gm-Message-State: AFqh2kokeaHlEFC8xtCMg2Xb7NNA9XBbz1PhyAC1hDalj/4WNrvfberY
        Ib2EsBI59XLXKWtneTi0SiZQkQ==
X-Google-Smtp-Source: AMrXdXvJ/eEbvLCuZrgzAoxjcMF9EAcperQnATK68seybmNWinC1OuLa3FhWznF8VbzNzx6DZgsFIQ==
X-Received: by 2002:a92:b708:0:b0:30e:f604:9266 with SMTP id k8-20020a92b708000000b0030ef6049266mr6849008ili.25.1674076425569;
        Wed, 18 Jan 2023 13:13:45 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p27-20020a02b01b000000b003a091a5805asm4603575jah.19.2023.01.18.13.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:13:45 -0800 (PST)
Date:   Wed, 18 Jan 2023 16:13:43 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/6] t1007: modernize malformed object tests
Message-ID: <Y8hhB2U0KD5vXJjZ@nand.local>
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
 <Y8hYEgMze3bY44/0@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8hYEgMze3bY44/0@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2023 at 03:35:30PM -0500, Jeff King wrote:
> The tests in t1007 for detecting malformed objects have two
> anachronisms:
>
>  - they use "sha1" instead of "oid" in variable names, even though the
>    script as a whole has been adapted to handle sha256

I appreciate you saying that we should s/sha1/oid here. But more
importantly, thanks for drawing attention to the fact that this script
already handles sha256, and that the update is purely cosmetic.

> ---
>  t/t1007-hash-object.sh | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

These look obviously correct.

Thanks,
Taylor
