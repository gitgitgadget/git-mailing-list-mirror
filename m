Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD097C7EE23
	for <git@archiver.kernel.org>; Mon, 29 May 2023 22:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjE2Wef (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 May 2023 18:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjE2Wed (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2023 18:34:33 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2819E4
        for <git@vger.kernel.org>; Mon, 29 May 2023 15:34:31 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96fdc081cb3so549812266b.2
        for <git@vger.kernel.org>; Mon, 29 May 2023 15:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685399669; x=1687991669;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t1DzshB1s49iBVhurLvq1LqZj0tDle+XweMlS7m23uc=;
        b=Sithg6F/InBHioLJx470v/Acin7WLReSgQwnLVkkKQiVG/NifVzidkolJrpHdPOIfz
         sJKU+XRKu7vBto+Ed8RBxg7wzt0lQ7dpoVtpqEa+VIZaVmodAou2PMlmwUxAAewcHq1B
         JzVmC+/qsHtIr+LL1STSGDdGnbQC9IRx8PULhXEHNaWQqsGNTW7eodbXnQisEPp57spX
         9pHUMgUYiYish1PDEctTCOuzOcqvQ5alPYHwgP1AISR0QsEDhFPai0VrovY5vhM5YdrP
         nOeeb2KyUO0QZq/bWSV7z2/qoDX/HhTESKdnAahP5btYk6j0kyfB+sI9nYDVy32GlOZO
         /I3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685399669; x=1687991669;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t1DzshB1s49iBVhurLvq1LqZj0tDle+XweMlS7m23uc=;
        b=kcQ8lyzAso52LgtAbAhAxsrnzCoFvoUulnDn4GpgZafn8SbcAzySiZbb+lbSGcwljH
         nr32dPmr8bYbHwx9xjr7ED4AYnittP+9pP8yErS7RMwskiQF46gFJ3k/vRe3e79qVXLX
         tGcRDmM6nojJ3LCIDyXJFmh6qvaj9SkE/JT4AUFHrr85+65/smxdVq+Ai456Qbii2MB2
         bL77x6xkNwg7UkO9wGvH3yp4SayzCYajGH8nxDNZ7TRa+p7iImDFPuqTYRLWRkDXVAqm
         f5VEQN2tEymUqcOTUiHt8GIRaBeg2/bxdISuHDAG4N8dhgiBV7nozLvB68asavxKMnBf
         8ODw==
X-Gm-Message-State: AC+VfDxJW6z2pXEuZFsHWM2cV/7iAJWY+2n6mI8SQfAUxtv+p9z3sH5M
        XhOJk9LWOLBWuBf5endHFxu6ZRPPy84JKpe4/3L/lykoX6s=
X-Google-Smtp-Source: ACHHUZ6NnXNwdUmsSLqrG4Lm7c5lSiMSmVKIeSgxMBBLE1bx3gHsoO5Z3N+t6cWchm1shfnPpPe0Oq4sd7SnDOSgtGo=
X-Received: by 2002:a17:906:d553:b0:973:9857:b98a with SMTP id
 cr19-20020a170906d55300b009739857b98amr607177ejc.55.1685399669210; Mon, 29
 May 2023 15:34:29 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 30 May 2023 00:34:17 +0200
Message-ID: <CAP8UFD2zaEPKNj2SpgGQUyFRmNp24E-8n1O9K5Se9=OhXckxGQ@mail.gmail.com>
Subject: Draft of Git Rev News edition 99
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bruno Brito <bruno@git-tower.com>,
        Thomas Bock <bockthom@cs.uni-saarland.de>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-99.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/643

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition very late on
Wednesday May 31st.

Thanks,
Christian.
