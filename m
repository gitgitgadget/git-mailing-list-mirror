Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12501C43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 13:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiK1NlJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 08:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiK1NlH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 08:41:07 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B1AB1E4
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 05:41:06 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id f3so9959954pgc.2
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 05:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=G8AtT12CHCSPg48rIoIvqEggwYGndBk+VRVuufxJA5M=;
        b=KUoQPKMOFDi2pvs0Xzqy6ph264DvxQInlKBB1P9SiJNvBw2CY+s4yuQMkinKEiweOe
         jfUndSK+s5sJPMxqrBAzM/GaouNSw8BxQ9CflOl3GDWNa299Vlp+OS1aWQoOjGjfdE8u
         AWs4CG0dU9RDnpbyaiIWkFKCta3pC2cR2sw/VUVVWeQemByJ/RzMzpJ/DRLV9UzPiNCd
         yyH2b1LeGz99EmEMs5p3uCV8tHYHTs8Y/zRz6GjTJXXXTguFqhELuIAad2iouOdmt48v
         bqDIAGjVsjd9wVZ0/qIz0G0VIyVaPt8Dk03iY8uN94KD59qgmNWhGuM082PWQxIHZEtC
         ntDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8AtT12CHCSPg48rIoIvqEggwYGndBk+VRVuufxJA5M=;
        b=LGW5mXmJjmhW2jh9+y6VCj6+WIhW7Rj6XY1L4xSemkV1MthXuJn0F9aTQyREeknu0e
         D8RH3Tkl0HC04qylJzqSCM7CDIYqeGNr/7Tgn++Z/SnVXjrWTKeQDnF0X363bJNvOGpR
         HS54cc/Y5CLrMaGph9Li7Lll0qTbDXAKclYpBAggCuqtP70W3UwEGbC6jW1Tg+I/truu
         fuaqFsawiAk4I4jHonvyB5R0biPxRzbJu1sgUQTMCzQb+wmJ7LtPfZ8ICbkdka3moBzv
         c+2WOlcbJBpBDdobZCkbT7CSAchWpaBGkQcPO+1qCH66Rz3OcSmTLqCj6aTb6G35qZUZ
         Yx/g==
X-Gm-Message-State: ANoB5pl8+T/kL+LShPvTeFUiX5sfhDAltUX96J272isBynokNQQ6jHtm
        uqMTQnSgZ9l5oIyd3eJSgqGjmd3w05TcBA==
X-Google-Smtp-Source: AA0mqf5d/wK8IYpeay/0JSX26VoB90JXN9X+/jQFRY8gysarJUIt4r8i3UQNLgd90FQUM+neJp+Jcw==
X-Received: by 2002:a63:2163:0:b0:474:d6fa:f574 with SMTP id s35-20020a632163000000b00474d6faf574mr31171172pgm.190.1669642865486;
        Mon, 28 Nov 2022 05:41:05 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c26-20020a056a00009a00b005749f5d9d07sm7716016pfj.99.2022.11.28.05.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 05:41:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Fangyi Zhou <me@fangyi.io>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] i18n: fix command template placeholder format
References: <pull.1435.git.1669483442230.gitgitgadget@gmail.com>
        <xmqqr0xp9of5.fsf@gitster.g> <Y4Ln43f6iP1b6EHo@pobox.com>
Date:   Mon, 28 Nov 2022 22:41:04 +0900
Message-ID: <xmqqpmd75h8v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

>> Thanks, will queue.
>
> In case its helpful, an identical patch was sent on
> Wednesday, Subject: [PATCH] revert: add angle bracket around
> argument 'parent-number' in usage.

Yup, more eyes finding the same issue is very good and is very much
appreciated.  And in a case like this trivial one, it is not
surprising that there is only a single way to make it correct.

Thanks, all, again for your contributions.

