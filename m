Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B92C47089
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 04:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiLGEeS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 23:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiLGEdy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 23:33:54 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4BD537F2
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 20:33:54 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so374209pjj.4
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 20:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1J+M6FWm4GiRv1KyRqm8T3vv3v0J+WwPgFouDPmkOpg=;
        b=bariAnXVMlu6gm8UCvJ6Vzt3tHHZQcRDbvKHJcF6U+4NsO5Bl/vNVAgxHgYD7sawZ8
         tnbaUqTdnaZpst7qpgi6t8Icp5nZelGxO0OWA49DmNfEiQis8dA+yLvYRuFidKDifGjV
         UMnEatVHWXRqFXR/v/Yvei9HVHMi7zHFS1PFy3w8LTSkZezNrVMZns65AKEW604kG7I2
         zcGFYZcH0i2Fd1Ohrd480SrXHWVL6BgLD9tWYx15DnEUmk5Rp3DDokdmt587bsAlzkpF
         qW8cFnecOAaLWLRq9q/QHDkPY7DCp5EWS+Xc19e6vvCUh3mnU6d3GfpLw0qv4CihAyaM
         pWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1J+M6FWm4GiRv1KyRqm8T3vv3v0J+WwPgFouDPmkOpg=;
        b=R1jBBK/oelypyZX25MlMB+o5UKse0APuMZFmhJc7YQCYVu8/WYLGnHDu8wULCqwzwG
         6j+e9G17getkt/plKSK5RMkjUZKDriywZSYdSeOTmWazeEFMfdmTyPJePje59eVInsER
         3lPxOTvdYkPcywBV2J7TZlNriIL68dQILBwPSYLomuphDH9wPJDiNBK3LEZFOmwzoSlg
         9w4FuooW8DUP/HEv4+FqjmdTSmwR5rER1WLufW9eioeq6OoWdMgRAEh5aGLcRrdOUiyX
         KnQgH/9NZkHdQg6BYdlTAuY00PRoTdDAg8vXOfH/6+QfO93/NhS2RPgKjyU/pJrWj/nM
         GFhg==
X-Gm-Message-State: ANoB5pl6haj4vXziH2qNdZsanCxImsKiK5X9gprgU+51UkoPClZsB5dW
        xb3HRTNAQEE1a++Hrm/KSbk=
X-Google-Smtp-Source: AA0mqf7FmTETPLEKEouWfyh4kegIgpWALfKuJxd943t6rriNL5w/0ghDF+8a0V2DG2tvl0f5uA8D4A==
X-Received: by 2002:a17:90a:5d05:b0:219:57e:7790 with SMTP id s5-20020a17090a5d0500b00219057e7790mr61891663pji.3.1670387633581;
        Tue, 06 Dec 2022 20:33:53 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a199d00b0020b2082e0acsm222227pji.0.2022.12.06.20.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 20:33:53 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
References: <pull.1309.v4.git.1668434812.gitgitgadget@gmail.com>
        <pull.1309.v5.git.1670339267.gitgitgadget@gmail.com>
        <6a80fab7e3936ec56e1583d6136d47487327e907.1670339267.git.gitgitgadget@gmail.com>
        <31d3bf6c-c0a2-d2d5-c6e2-b185fde99170@web.de>
Date:   Wed, 07 Dec 2022 13:33:52 +0900
In-Reply-To: <31d3bf6c-c0a2-d2d5-c6e2-b185fde99170@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 6 Dec 2022 22:54:36 +0100")
Message-ID: <xmqqbkof7ryn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Only t3920 needs mingw_test_cmp on my system.  [2] on top of [1] removes
> that dependency.  Does that work for you as well?
> ...
> [1] https://lore.kernel.org/git/febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org/

This is on js/t3920-shell-and-or-fix topic and in 'next'.

> [2] https://lore.kernel.org/git/cbe88abc-c1fb-cb50-6057-47ff27f7a12d@web.de/

I forgot to pick this up, which I just did.

> I'm a bit disappointed by the performance of the patch below, but we'd
> need something like this to compare precisely (no longer ignoring CRs),
> I suppose.
>

