Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B2BF1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 02:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeJPKFB (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 06:05:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40738 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbeJPKFB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 06:05:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id d2-v6so23520574wro.7
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 19:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kqovcFMY2ztEzPHlLEsvLXyl4HlHEk7YNgk5Izooumg=;
        b=N0157j2NiDGy20eLLW9rjIi+FUZpkpX7ccpV4n3zVjKNlkT8JdDI1GLkG98Mn+kX/W
         r8DXSqWXUKPSo3Wmqv3wCfik5BAe6V2rncAH0lIrIJikvbGpr/9r6CLh8ATz8160uXod
         EIGogLpSoSL808/vK4M66PWRZD8r79ne8/ZXppRfan0ZBasz/CmytcKwJmCV/ICqC9TW
         Sk3JgCWIIPJ3SG7jCHbYYdM5Oawls0Cmsdz3nxRK8rRZP6ckyjv36nLwXTsHnR+MItYL
         LDc+XXrgUnNIai6Ux6az31vYsWWrdqhaAoo6smM9fPGtd7bafoyEhdJEE05kHq38cfL8
         7fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kqovcFMY2ztEzPHlLEsvLXyl4HlHEk7YNgk5Izooumg=;
        b=eZsTaZXZ+N2rkPG/JJwMsMMMcA0eXL5jVz3Ng+pyblbu8Hm2BwvtAcu6+QhXVZ1crN
         DJgZ7lFIOcb3xAaEcltDD0c4OpDRDCOw8X9nCyeQLQFw12gl6Dsuog6MPioPLI50pcq3
         PezUBamWcleLv4gFmEiSSO5lxnHJTFS1DTdAQBBwqY5K08Lep6a/xEWE2wwi0boV8TaR
         Hy92li+CdXzIac+Z7HmlHAMK+ZKHxPgcWTV31Iig/3g7e3SoEv6dLvebY/gjJgvONg2o
         9/F/5AEaedZ+6mW5jfQZnaUM/LIkcXREpUd4fWPDHpqzM0HLvIcPJj1APAHMCQJXHQqR
         LZvA==
X-Gm-Message-State: ABuFfoiBTRVkDpXEvVd53xjOWgAiJq007U/v95CYx9sZ9yHpdaENYDJ7
        cDMa8JorYEOkZAnrNTr+buo=
X-Google-Smtp-Source: ACcGV610g/2NRbqTXLonRFJhcvmEtuUqOPAe7o974ChPVRpBE6jJGuUnb3gr4p7tWCnAQ29AU+Pe8g==
X-Received: by 2002:adf:f14a:: with SMTP id y10-v6mr16072074wro.29.1539656219744;
        Mon, 15 Oct 2018 19:16:59 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q17-v6sm8134561wrw.19.2018.10.15.19.16.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 19:16:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/4] merge-recursive: increase marker length with depth of recursion
References: <20181012212551.7689-1-newren@gmail.com>
        <20181012212551.7689-3-newren@gmail.com>
        <xmqq8t2z6bem.fsf@gitster-ct.c.googlers.com>
        <CABPp-BFJTFN1prCwkidnQiKNP=5wdAV0AdXEkTjCT3HTHyB=Mg@mail.gmail.com>
Date:   Tue, 16 Oct 2018 11:16:57 +0900
In-Reply-To: <CABPp-BFJTFN1prCwkidnQiKNP=5wdAV0AdXEkTjCT3HTHyB=Mg@mail.gmail.com>
        (Elijah Newren's message of "Mon, 15 Oct 2018 08:02:05 -0700")
Message-ID: <xmqqr2gq3aau.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Would you like me to edit the commit message to include this more
> difficult case?

Neither.  If the "marker length" change is required in a separate
series that will build on top of the current 4-patch series, I think
dropping this step from the current series and make it a part of the
series that deals with rename/rename would make more sense.
