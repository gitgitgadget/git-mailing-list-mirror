Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EF3ECAAA3
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 16:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343803AbiHZQQn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 12:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343750AbiHZQQm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 12:16:42 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418CCD8B27
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 09:16:41 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 76so1995671pfy.3
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 09:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc;
        bh=UmzM3d9sqNeD1nymtWm1oINMpAHTWtSnecYHsIkVIHY=;
        b=ZKmZlSc5tfSDXVyv03oAPsMSE56QHjMhnI/4LILun2LNn1b+8OHSK33jEx5vHDWay9
         9fUAO/BdiVvVCzlMbUGC9F+0Zr1ChfwCw5OtnwyYfHXZ+3N2fHZntS0+y6uI7M5OQWXN
         d5ms80GBRVzCXuOdQJHksSg/301PZdItzDprZwgiltmD5UPue3Uf0z01YJH4WrgSpHL/
         gzLsnwTar+SJLBK/VTm8bZ7OBV6PD8tFfuqBE99/7BlzYzJR1R3uDLD9oaaI/y/JWPqk
         +YGsbYx4jl7lyNeDXp22zxNOpiXe6iQzg6FKDtFkLwy2Adn+BAJT6UKDHHV7d1I1Xerj
         qizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=UmzM3d9sqNeD1nymtWm1oINMpAHTWtSnecYHsIkVIHY=;
        b=TQvLQJrCfyVY5O2nhbv+VHpAjdvlDx/1u4EV5eNKG4h2L4kYQk10RBIctTs8D6SFa6
         WWf4S2UisoM8bdA9c5BstCb9hGXuWFe98JDgcyLCowMKv22VwIOSF6LiPMZBsP7OGUAM
         bDhNrNbPctziTJTmgrgXMp7sjJdurfibyhSZCSZpqJE2Thfc7Mk+ShG3GbtJGZ+hHzWK
         WW7+Xkp2J7rLW/nrFd/CflVbPsY0dFLDKndws7DtsAgEndmaJu9I0u8T11l3jUT2u0XH
         vTcUE+VaBBJUc/6hgxt/SANL7l1wtKJ1A/+y2U1JQMu4wh7Ou0i5WI4Oedi7ymbUWd+k
         rkvA==
X-Gm-Message-State: ACgBeo2sejBymBE04qVKftaODn/40JT9isz9k9WGEKS7dTyLz8cteSKJ
        0qXFKow6RC3vgsLfdCxve7o=
X-Google-Smtp-Source: AA6agR6Sef25IT5LqiU26YPEKitVBu5ZxzJkSm2aWhVr0T1UQ8dVAD8C1kMHk+dJlb8urc3mlaobxQ==
X-Received: by 2002:a65:6d9a:0:b0:42b:4ab5:b87 with SMTP id bc26-20020a656d9a000000b0042b4ab50b87mr3803230pgb.5.1661530600723;
        Fri, 26 Aug 2022 09:16:40 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b0016ecc7d5297sm1781346plg.292.2022.08.26.09.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 09:16:40 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Javier Mora <cousteaulecommandant@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Potential problems with url.<base>.insteadOf
References: <CAH1-q0iPsnkypiF=2LRgXwNqE_+R0gj706FCKgqGEUum+OAhQg@mail.gmail.com>
Date:   Fri, 26 Aug 2022 09:16:40 -0700
In-Reply-To: <CAH1-q0iPsnkypiF=2LRgXwNqE_+R0gj706FCKgqGEUum+OAhQg@mail.gmail.com>
        (Javier Mora's message of "Fri, 26 Aug 2022 01:47:08 +0200")
Message-ID: <xmqq35dj0yl3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Javier Mora <cousteaulecommandant@gmail.com> writes:

> This results in an ambiguous case, and Git does nothing to prevent it!
> The documentation says that the longest insteadOf value wins, but both
> have the same length since both are the same URL.

The longest has this case in mind:

    [url "A"] insteadof = https://example.com/
    [url "B"] insteadof = https://example.com/special/

So "A" is used as a replacement for the whole site, except for the
special hierarchy that is rewritten to "B".

Getting rid of what you no longer need with "config --unset" is the
right thing to do, and you did fine in the previous example.
