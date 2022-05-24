Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50B3C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 10:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbiEXKGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 06:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiEXKGT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 06:06:19 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5DDDFCB
        for <git@vger.kernel.org>; Tue, 24 May 2022 03:06:18 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2ff53d86abbso157102727b3.8
        for <git@vger.kernel.org>; Tue, 24 May 2022 03:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1Csfn0AUa35dxRa8ceo7u/esGCtfeye0A45mSjdZTAw=;
        b=Clhgx9DeOjnUJTVeTZ42dfCa0QmPtommg+JCPayo1Sx4CaDi+gvx+KmoFbG/aEoqpL
         emr6vOHzO2/MCyJTGRQsG3TBqhl8WXFY9BVg4CAk6fPNW0Jx48ezJkOqFXW8Ai+yY+d3
         GaIp9fyptoxgAXUDaX+Nw0mlK78qp7m3oMhHwQ8/69X/c9ksQjEKQsYpaXLP5Ocmj8UN
         4nPXgQEmJEibyG9dLRujD1xrHHXDwF9NcjbFvUOP6pPxixLCnvHQWcgM+bqm+mk4w+mA
         p9RnieYrBb97cimQagXN3J1lbA5oK0Ov23kR3PDAc8TRhExMcdGQ98abqzkKkhkHFmqB
         w14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1Csfn0AUa35dxRa8ceo7u/esGCtfeye0A45mSjdZTAw=;
        b=jQ26W3/6pDYMNmCzbcmcoTCtZ4gKPDTcM/sZTFGdGv9OF5MJ+wkqXsj8DNIEzfY0ug
         phSt2IswfMw7neU/GSVypPT512qLbrEnUq1Vl9hfngSrDqL67IJu5iYYFCBpA4gAkm0u
         uceaRPuwxMKQYklnR1y+L0nz1W2E4PCw1IcfXNXfLfVIdL5gqwmI/4vKeqrSUEvKHSVT
         AXdK87ZwHxDkDTJDbWjn0tihmyg9yw8pdXrPm4cBbhH4j3ZomUB22m8Pw5iei/cA0sJl
         OIjuE30mHIWGXbaNnomMl19m81e0xNJNG9X35Q5/dKEC9yvs2XzZGgig1vxnoK31QsKg
         4Fsg==
X-Gm-Message-State: AOAM531ppaOpQXaWJFUv3XqSrjPRmjyayJFfszluQsKETh88Z2XUAjVR
        jL2RyL/2C3swC5z9+ek15ToCPx8sRi2KuuWhNUBPMrMBl2I=
X-Google-Smtp-Source: ABdhPJxy0GLJ5dQUZ78Y/8hxNln86EjE2uU2HVsYs+YZRLJKh+6Y4T38FaNuFWh77OzEoclgvEiYgvrwfr/H7mooyn4=
X-Received: by 2002:a81:8801:0:b0:2fe:e24b:1c33 with SMTP id
 y1-20020a818801000000b002fee24b1c33mr26904850ywf.110.1653386777390; Tue, 24
 May 2022 03:06:17 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 24 May 2022 12:06:06 +0200
Message-ID: <CAP8UFD0zeUisMgBzACSqUdQCPJgn0=4uVA=H2ieNMm1cT16-Ww@mail.gmail.com>
Subject: Draft of Git Rev News edition 87
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Bruno Brito <bruno@git-tower.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Dan Moore <dan@fusionauth.io>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-87.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/577

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Thursday
May 26th.

Thanks,
Christian.
