Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9572DC433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 16:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239623AbiC2Qac (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 12:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237573AbiC2Qab (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 12:30:31 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091AF237FD1
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 09:28:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id t2so16329822pfj.10
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 09:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BokgpFD+f6HZ/bJcrkhsBUrkKEv9nzTvoaAFYClV+BY=;
        b=e2m7FGmqYylBDet2xqaHDOqWohFHZUAh7/laR9UZSMKy5Zx/zkad7OGk4wSY4hKYfY
         UGbYTt76vI6utDMyAFk2t4H7C7xpK6NoDDz7DwDF9pyLeUM1MlvC6PhcjlQIAPvSQrWS
         9Uxrifo/7r303nV5ERi/bcvJMkerWplM8SeAebEnv03nTU8mqGYPCjq0enkggDGQgfHo
         Vaodq52eISGxRCUq0fVuypAjSjsdrIa030gYRUbn3oLdPRX5ZfI3MDZAFK3SvPZ0zfV9
         yxg8vecH81cnrZA3e2ASTylZwQGoxwmGlqac35O2NwhY3p0P4e3ZS0jSHoj8O11VX8zD
         ZZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BokgpFD+f6HZ/bJcrkhsBUrkKEv9nzTvoaAFYClV+BY=;
        b=wYllDIFwurhpj74V3P9ukxRsMYRBwSGVW58PmCo6zjbqkNXbYVR4cOSjDIzsDCYA15
         Ackc075ngvuEhnIo7WuLIBCkAAVec97W9DLL07IQqNx2NL6TZYq7+xq5eqpbEcvHNMKt
         HQMYIjnnt4mBAakOeuPhjXcHPS3hzVTfYk3y4nOgc2YTAR3cKo+PD9I0rlooQAG77uVq
         wPQeg5lG0KaycyCt71SPS4aM+KbwShwQM75adWHj2nfCIS2VkkZ6wLVmJ/YQyB0JKDP9
         eKmkv255CbJCQmXucv+udzOzwswq9OffEI1Bi4kCkxWEqbwt1pDoSKrJzUuXqVhtzcj6
         0e/Q==
X-Gm-Message-State: AOAM530dVWrdqJQjp+gtGAZKxj+deJspCf4yV+VQhEZIuheNqWO1XDmu
        jVLiGfvyUZ+5eqjhTWbAfydixEm9sYdTmO/GKtsavsViXT8=
X-Google-Smtp-Source: ABdhPJzFwstLMitG+jSBRmmFaruzU0xAwsAqPx79NDDQS2amuTLlJlZbl97GFPyqBJFb/QK0TKIrqPopG7+bP7u2PfE=
X-Received: by 2002:a05:6a00:87:b0:4fb:39f9:bb9d with SMTP id
 c7-20020a056a00008700b004fb39f9bb9dmr14738623pfj.48.1648571326987; Tue, 29
 Mar 2022 09:28:46 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 29 Mar 2022 18:28:35 +0200
Message-ID: <CAP8UFD3UsWEn-Zv+EiOyje-PVNo8S_HMCz87MLXtJea2bA_r_Q@mail.gmail.com>
Subject: Draft of Git Rev News edition 85
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Bruno Brito <bruno@git-tower.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-85.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/562

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Thursday
March 31st.

Thanks,
Christian.
