Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34007C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 19:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiKGTRX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 14:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiKGTRV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 14:17:21 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC152A408
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 11:17:20 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id z9so6355224ilu.10
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 11:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YQ9njpwW4e1PzluSbffACORSkSq0wUV1UIIhP+brnKg=;
        b=nt/epdMvgjKFZXWij/1V3dJ33Ib7rl9R9LeUgZpJC6tPGotIZDK/8rpmbNosBgsy9c
         4aM6YpRrnkr1Sr3QcxH5ZpjaNqZPH2ysZKJPa5P8h8XNyiQcLCLWClPNPp20JH98T8hW
         cHuz3AaqGR7VvLMYp9aWku4bJ90fjj6ht+IjIwCWlQZOad9xBSqL7TLB3jn1Bda/QL/L
         KkVxOCfM1G5L8YpcLuJ6wa997lEwk7b3i3CIceQEFxEaa05mjA6gX7ZuoC0HffLkmOjG
         bmY9ZQN1QpUdUpezHyNHKB4tNqCHF9MDU2u3BdpFUQVdT+TsvppB18NN9NvwkIpVXfcI
         x57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQ9njpwW4e1PzluSbffACORSkSq0wUV1UIIhP+brnKg=;
        b=dAoUoYW+8FFHTYhaS/N+BcHiWP7Dz+v+tJwOVVmHzD6cuT1z2pNbS19Le24I9IOLg1
         vZAcHbyRlrnM1fYYjsAO7r0Hc933y+nPa8xeJ4eXoo3s2suRmQZbCyc1S6TY2p4aK0t+
         e7m6In+Xrlu2NgCOXaLv/c9gJtfjpYIhxzCbxEaLDbFrbLQPpl+Vis6lukhkVENu5UW8
         DmZQ+eXMNhfw5IP+UPnaLWAsY2j3JIUy+EWzfdENVZuDliQ+pvyHcv9lB+y8EiZNCgtT
         T5bEyR2NhiIH1KS2ikDWf6si8vVumNGUXTVlUc8YX9i82jZE+T8Pk+kC4cz6eQo7tgG2
         5puw==
X-Gm-Message-State: ACrzQf1uEJ8ZBeHTxqi7NHIl1FZwNzLQ8tgpVUx+4WiNJvEuOJzuQxhW
        QxlDQ/KDDlJH5966IBASF7SbtQ==
X-Google-Smtp-Source: AMsMyM44PWvuRuijPRAwWltd+8+KYgbJU9kZmoZKEWj42VrxjqkGrK6YAzbSiswYrAHhCkai65pDZw==
X-Received: by 2002:a92:6b0e:0:b0:2ff:df3e:995b with SMTP id g14-20020a926b0e000000b002ffdf3e995bmr28871100ilc.193.1667848640296;
        Mon, 07 Nov 2022 11:17:20 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m10-20020a056e021c2a00b002fd00a8f8fcsm3129050ilh.47.2022.11.07.11.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 11:17:19 -0800 (PST)
Date:   Mon, 7 Nov 2022 14:17:19 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Victoria Dye <vdye@github.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        "herr.kaste" <herr.kaste@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] rebase --update-refs: avoid unintended ref deletion
Message-ID: <Y2lZv7cgbn4Dx8Jb@nand.local>
References: <20221104165735.68899-1-vdye@github.com>
 <20221107174752.91186-1-vdye@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221107174752.91186-1-vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 09:47:52AM -0800, Victoria Dye wrote:
>  sequencer.c                   |   9 ++-
>  t/t3404-rebase-interactive.sh | 107 ++++++++++++++++++++++++++++++++++
>  2 files changed, 113 insertions(+), 3 deletions(-)

Looks great, thanks. Will queue.

Thanks,
Taylor
