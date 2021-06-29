Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F52AC11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77CB461CCE
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhF2But (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 21:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhF2Buq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 21:50:46 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8A8C061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:48:19 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id k206so5530753oif.2
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=49KMojQN9BzZA3dpyULXC3dj+qSVdquJ7KD/M8ejRes=;
        b=ehFJTXbHhFpAjdGJApCO0/ekMNSUEuRmDOpahECRv/TExjhZbfXPHzQMcYj82Tn7fE
         qWwr5muEcrFIC/DUj7f44fCopnAgI3ZWXbC9/acFQmqWCriIVMzTIqk/errASY/1eawJ
         bbKjYpwve/twWeVpEVwlMSnr1Kwf6ivYvUfhmuHbepUr/leU5YKyeowlyVx8bnygNqoh
         lBpk6eAzavxaeCt9vjDBWbG1pHNISsflD8Nr14XDW+ZvgdpE+RAq9Y12pQyqjoZt0FCE
         s033Tz0K+jKsEZxJiC5Kkg/J94XiK0OE2+fetVhbqflwiY05s08I0cLrthcGPAm8M45G
         cAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=49KMojQN9BzZA3dpyULXC3dj+qSVdquJ7KD/M8ejRes=;
        b=M1sBVhDJ/1mnqzwP258SKpwSVWODx/KbF8sUuMTP3lD5x0EQQ6RVwzlKpe6i/3WtRW
         VSJZms3tgiVOFGKky6/1Ll0htueLa6xaVmAvIM1n5Tusj+oo2J6bPrrym9V3VIOCH0Re
         7whQnhm/RJKPnkmZCOmBtjChz6+Ye9SGZUBBuz6vaQEDzwcYR4UeY8xtlHxW5ONEkFCZ
         FEcxaCWt3YZCGcfnw+D+NUS/fi/ueIV59HYMAMXBd7AnRKsp+Kb3RhNLPPL+RUzzMmQb
         OGi/znLExCC3y1+jNmA8IQce3mOowRD+kRX25PT2RMbcALQdfrwWOZZvzDJet0URe9id
         PQhQ==
X-Gm-Message-State: AOAM530BTaDFfDIwwhldIZAIemXEgxd3Wt2kkWl/LF0S1GUbEh4LzTvx
        t0+uiOLF3qx0fN07ujwvwmE=
X-Google-Smtp-Source: ABdhPJy46VL8Mt0wsUNIcljO20x3jIKZJ/riHCDksMJTCK48oubRIMWmJImcXZnAYsretNmS1vWj8Q==
X-Received: by 2002:a05:6808:128c:: with SMTP id a12mr19551546oiw.136.1624931298923;
        Mon, 28 Jun 2021 18:48:18 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id r25sm3759581otp.21.2021.06.28.18.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 18:48:18 -0700 (PDT)
Date:   Mon, 28 Jun 2021 20:48:17 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <60da7be142144_2054b2088d@natae.notmuch>
In-Reply-To: <xmqq7did30q6.fsf@gitster.g>
References: <xmqq4ke8pig9.fsf@gitster.g>
 <patch-1.1-a950ef49e28-20210621T083254Z-avarab@gmail.com>
 <YNPM4yvk/71oeAPx@coredump.intra.peff.net>
 <xmqq7did30q6.fsf@gitster.g>
Subject: Re: [PATCH v7] help: colorize man pages if man.color=true under
 less(1)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > .... But from your
> > description (and I think the code matches this), doing:
> >
> >   [color]
> >   ui = false
> >   man = true
> >
> > would still disable the man-colors. So there's no way to enable this
> > feature without enabling colors everywhere else. I think it should
> > simply be independent of color.ui (with the exception that it may
> > eventually use it as a fallback like all the other color.* booleans,
> > _if_ we want to move it to default-to-on).
> 
> That matches my perception.  Thanks.

This is already integrated into v8.

https://lore.kernel.org/git/20210626025040.104428-1-felipe.contreras@gmail.com/

-- 
Felipe Contreras
