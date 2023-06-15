Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295FBEB64DB
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 17:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjFORA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 13:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjFOQ7q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 12:59:46 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD45110FE
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 09:59:45 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-53fa00ed93dso5721900a12.3
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 09:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686848385; x=1689440385;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXGtBE1okUOFtT7lclIe2S0ggI9S9wuKi2xx/c47QOM=;
        b=xC1qPz+e1yff105wtzAypJxITbo9ruLXa0UESPApZJFetD4C6LSyMfk4XXjniG4moQ
         DGOFio2aHQdsdMXkL2QByc/BjoXyv2s7yrpESWLih18ngXH4Gvsy4+try5miadhjb0A5
         0nUAvg6ASyrylVdze9b/Y6gjUyfqR0jajjDDlqRqeECE3sIHTvwnRHNxIllGkppwlVh6
         BgEdcs+BZGsu4fvqIgL2tvqyf1iK65DO90vr1sroEU1eYfKQVEV9d46wXlqa/60hJjjn
         yzVUQaXdjIRLMqOHuwAF9r4C3w8y5RcASlRxpX4LU1yFKCx0wfp/E7jvFbVSpO80QSuk
         g/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686848385; x=1689440385;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QXGtBE1okUOFtT7lclIe2S0ggI9S9wuKi2xx/c47QOM=;
        b=cBHu+9RQbF2uFbEkzm33rhGCTSwBOSE961yvfh3yFmlUoOt2jjiNxFc+ldnXKBr7W6
         Mfn8QqCSVs8S+3N3+Fk77OeB3KrHGgARvHm7yaSxywX/WI4xjNeUAxkpGopOmLQA6GDV
         ug0ss6nhg+7h+9sCTfPCJt7KzPnSFQe5LsF4wODtBuUbu0g4LzxRIpHl1ZcyEr+MVC+H
         EquzpLEPEAyzcATZtbcuRK56/M0RWvtvonkdmppnk5jwpAafXrs8YMrgpIyt6jVJK5OJ
         k966hv07qD6F2g9sBx2pUCLxlKDZu89vrVidfmOFkmX9KiqdNRuB+S+7DMJ0B5z6VOZV
         gHGw==
X-Gm-Message-State: AC+VfDyo1r4a1dVUUw8pEY7OWD3HpiX97zZJofyAylVlh9CCH45Vqz7g
        qY2CrUVtyPhJGAEgNi1v1JabjA+1UTs=
X-Google-Smtp-Source: ACHHUZ4EXL+8oX0+jeGehkHO/R1E/FBdERXI1d0EmV33ew8H1AVJhX1BMTseuQfX5H+3zL54OOoDuMpmnG8=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a63:d16:0:b0:53f:567d:2e98 with SMTP id
 c22-20020a630d16000000b0053f567d2e98mr2780570pgl.9.1686848385193; Thu, 15 Jun
 2023 09:59:45 -0700 (PDT)
Date:   Thu, 15 Jun 2023 09:59:43 -0700
In-Reply-To: <owlya5x1o20r.fsf@fine.c.googlers.com>
Mime-Version: 1.0
References: <xmqqedmdwput.fsf@gitster.g> <owlya5x1o20r.fsf@fine.c.googlers.com>
Message-ID: <owly7cs4oe4g.fsf@fine.c.googlers.com>
Subject: Re: What's cooking in git.git (Jun 2023, #04; Wed, 14)
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:

>> * la/docs-typofixes (2023-06-12) 1 commit
>>    - docs: typofixes

>>    Typofixes.

>>    Will merge to 'next'.
>>    source: <pull.1542.v2.git.1686166007816.gitgitgadget@gmail.com>

> I am in the middle of addressing some review comments and have rerolled
> to v4 [1] for the time being.

> [1]
> https://lore.kernel.org/git/pull.1506.v4.git.git.1686797630.gitgitgadget@gmail.com/

v4 has been LGTM'd [1].

[1]  
https://lore.kernel.org/git/CAP8UFD3ryDoewoKnSWQcXE2H7OFn6aqK-D6Gjav=qXFGmUnHLw@mail.gmail.com/
