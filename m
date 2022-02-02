Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1631C433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 11:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343918AbiBBL3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 06:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239784AbiBBL3g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 06:29:36 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623C5C061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 03:29:36 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id n10so41182279edv.2
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 03:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=wL73rBhYorvJA9zsL8PGBlOiHz7umqUQAnt1aLBOxDo=;
        b=LTGPib01X03wwdkopHv5YwnHcupxhazjsQ+8cxB9ci62l5OIlctOCqyghueOT39OBo
         tvvA56piz+21btpKEJrvGI5jYEQ5lKVIKGNvyHPlKSe0862a28m1ev1FU7vlUQg7/6fY
         +wdRHFdmjZ12PUVW4jMZKr0KiMgZ3+bi9LTeStoIw4fG/hhus6K+KBviV2/3v+LjpMSr
         8OVOfsnrH6Z56yWpn1a2LmcPdUjLDJMLXkAbXh6dSvdiUCUp0j2N6rxaKu627rBdM6wj
         kOjaKihy2LH7fPecy6Fz6/6sK3FjKHvEdFoSyQHb64RW4jzEbJUvq8zvXaVjf5ewqV/l
         +ZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=wL73rBhYorvJA9zsL8PGBlOiHz7umqUQAnt1aLBOxDo=;
        b=WHRHiHa2WAMmH+OOoUb/NaF9E8jxx9/vCKZ+mLhLRBm3dZDHqLIVTYw2w18P2mixlc
         85ZEuLB1aglkMUi0NIb6jFaeC6NQXrVBFXoGfffLrDJK3FBMQtkDXrGY9cjFsPWkmW6e
         ysWsyo0jxJ+fCvg+pO75HnP8WqWKDaKlvPH1byTWDN32rlhAi8OWdJ/6UJ168JYq2Ut4
         3fCwcOlWr5CgVhkKiClgsbsQ5bwzq03xo8WWMEdHi8ZpiRo67L/RXdKusQf+jwTCQ05T
         t93/JQ4eRpFk4oQZZySpIT4GzWnSlhCQPkbCYy2WojolWvQZWtcINREjL/YXJMLAp22/
         cXcw==
X-Gm-Message-State: AOAM532Fpr+idGD8ju4hclD7yDs7uFyN2yu9uXzjOesMRyqGRCRjxuS8
        aPAtK4q/cp6FbyoQcsihKR97ap79SN+fYQ==
X-Google-Smtp-Source: ABdhPJz8rcpkJ50Yy57sdyN52ePkQPRBNgcZ5XDLreHQzw57nrrekLuBftMSAN7+f5q+EdXc5UnHKQ==
X-Received: by 2002:aa7:c0ca:: with SMTP id j10mr29863102edp.181.1643801374640;
        Wed, 02 Feb 2022 03:29:34 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n2sm5344569ejl.55.2022.02.02.03.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 03:29:34 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFDpN-004Wx4-RN;
        Wed, 02 Feb 2022 12:29:33 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/auto-detect-zlib-compress2 (was: What's cooking in git.git (Jan
 2022, #07; Mon, 24))
Date:   Wed, 02 Feb 2022 12:28:43 +0100
References: <xmqq35lc53e9.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq35lc53e9.fsf@gitster.g>
Message-ID: <220202.864k5h8q1u.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 24 2022, Junio C Hamano wrote:

> * ab/auto-detect-zlib-compress2 (2022-01-24) 1 commit
>  - compat: auto-detect if zlib has uncompress2()
>
>  Notice older zlib to enable our replacement uncompress2()
>  automatically.
>
>  Will merge to 'next'?
>  source: <xmqqr18x3s5s.fsf@gitster.g>

I think it looks good and that it's ready for "next", thanks for picking
it up!
