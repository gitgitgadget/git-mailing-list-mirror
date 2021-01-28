Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3993DC433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 16:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D7964DF9
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 16:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhA1QkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 11:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbhA1QkT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 11:40:19 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C42C061574
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 08:39:39 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id c2so7327432edr.11
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 08:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=JQzxNY9qYQF/aTHgnavli60eNY5FmUZ0pklcHO1UmCg=;
        b=jcmHbfFPM36iOqQvgr6vnEYk0QnJRzjmk4UlpKwkpzuW0yLIBisfUJ6aefgMpciY1E
         ERCDYm8jGvy6LtHP3Q4jmMmEmC824DMMlh037t0CNpGmJDjnW8PALgfNXcLOx67/XwzT
         ID9lC2nkM10WQlvkPbd8Qu4Rs+rXKag1ZL+MFp0Hxy5d2uI+pNiCgRFrWDgUbUBVLRwv
         Uw4/5bsnu92mwqrRSMY5RPtY4tEALnYnJfXlHdB+UJbqCtJETzJ1uhMHXPBo0KRJrdDS
         nbLZztu7+P3fyVZJ+FPFjXnu/D1cGLxmVjvColByQRvFw7I72INbO9Jm9xbCGl1/JHCK
         CWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JQzxNY9qYQF/aTHgnavli60eNY5FmUZ0pklcHO1UmCg=;
        b=Ei1oxOTmcb1OBGoi+K/3yDnA0UaTjLfLdeXAaGEQFk/qNS8gcDvdVsTIF+3OIdLB49
         5ski1D/uUv01sLuPzMyi8rMpdKSmryIzXGYrGXtcVHh6asderPugAwcQQ/5Ffw19tbZn
         d0hnfPp0wEr7a2PCyqLxUozz3DCZbo6V0UcPdpldFYRKV6qDfOZB4pvO8jJ/JeP5WDoN
         OsY9jmzRsKlHC9EAhTwM0T2LVtLz4RM8h84uQ7Duymr7F4RuFQIpVTjCcdCWu+kvDS2n
         incsjC5ikkaJ4z8aV5jre7jXTlAMFSPFyZ1E7+8TrtP5I9YT2VOlYR2YFLrtpbtCgzUb
         G1vQ==
X-Gm-Message-State: AOAM531dXYkT4gbu5t0Oijcaym05SZyWCdCFU5ekejbjZTlRSkIIZPiv
        9RfmCxs4ehIsYw8b2Mh8xZkEY0zErcf0aDnjrC4ljSHodkFZIw==
X-Google-Smtp-Source: ABdhPJwDefBJ8DDLqCBNwRMp1uWhbqd02FW37aCPUBQEQJI2QEZRimRQtm1EFgGZVWo+bkiLWg65ARa5xZ7pGf66rFY=
X-Received: by 2002:a50:84e7:: with SMTP id 94mr397437edq.87.1611851977643;
 Thu, 28 Jan 2021 08:39:37 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 28 Jan 2021 17:39:26 +0100
Message-ID: <CAP8UFD2bpXSDRkn+q_sM+QXYc0gQ3rOOkst5Xjf0w-UArYSGqA@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 71
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Brooke Kuhlmann <brooke@alchemists.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 71st edition of Git Rev News is now published:

  https://git.github.io/rev_news/2021/01/28/edition-71/

Thanks a lot to Sergey Organov and Brooke Kuhlmann who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

https://github.com/git/git.github.io/issues/477
