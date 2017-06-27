Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23C7820401
	for <e@80x24.org>; Tue, 27 Jun 2017 15:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752546AbdF0PHS (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 11:07:18 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33184 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753209AbdF0PCX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 11:02:23 -0400
Received: by mail-pg0-f45.google.com with SMTP id f127so17029513pgc.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 08:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FiQWUpNUqDdB8JsDGsaMdswRFAig4Zn2RNsSjjFOk5o=;
        b=eOdJ8pkonm8Z8Duae44chTQ8xosInc9GdJyOZw4k2UrFwGztLIaunQkLHjjEQLvXZP
         zpx83kpkEWLW5VcY4RZ6mQivUxedH+B6ns2Ui2ETdVpYdIj+4xVc6Kn4Bx2HKkKxrund
         v+ycX5AgP6MUF/RnymbmGyhSFb3NqV5q+/DFjmI3h78s4BvNMGM6IZA9Em/6hnKa8tkf
         a381WfNYk6pKpxW08VSvIOi4ubShCGkHmsEqYE7YV5KuDMeTVoWvm6Y8/L2ns90RIasn
         SzdlNQifTXAm+MBGoXzqlLr1exuhS7+/UQfsspK150kJqih2TRBqRloSyl/aaGEYSAdL
         p/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FiQWUpNUqDdB8JsDGsaMdswRFAig4Zn2RNsSjjFOk5o=;
        b=RarCwXpm4moYIMBe53UnKehy/hQmmvw1uYSkvH1gtddzWF/nVY+QMQoc7FA8U/Le7j
         Cesh9Fh7Ho4A2mNHN1zgXIdfq8K+vuBO32Hth9kuUWRol9ZjwpaIYhN2kfOlTgSsXIRK
         hD3huxPT+k9Pwq6c+lOJTutdQgxaAR+ox9S/HBqEulukDU1GIR6Ae9C+9jkYbTaXme0e
         I/mCYjQeLMAoAcnMeLSoMHG7jTJE/IEAWK7jy4wdChL2LCbvGDaUNH1ovlJEAgCHmNXc
         zbeLY8WUT07GVx+hD+j2cc5Y48MGNfpYC9IS98wq/ycLB/SIi2grQO0aZT0yvH16SPYi
         xrJA==
X-Gm-Message-State: AKS2vOy4N4/cJMkx4Y+327kJHzqlqxFLR4Huj0IRx1KEzq3SzUCJOtjF
        0mAel47kKTw6kg==
X-Received: by 10.84.217.220 with SMTP id d28mr6471008plj.218.1498575736905;
        Tue, 27 Jun 2017 08:02:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id 79sm6514182pgg.46.2017.06.27.08.02.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 08:02:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     neuling@dakosy.de
Cc:     git@vger.kernel.org
Subject: Re: Bug: Since Git 2.13.2 git rebase autostash doesn't use fast-forward (poor performance)
References: <OF6AC13578.F02B79FA-ONC125814C.004DD247-C125814C.00500A93@dakosy.de>
Date:   Tue, 27 Jun 2017 08:02:14 -0700
In-Reply-To: <OF6AC13578.F02B79FA-ONC125814C.004DD247-C125814C.00500A93@dakosy.de>
        (neuling@dakosy.de's message of "Tue, 27 Jun 2017 16:34:15 +0200")
Message-ID: <xmqqvanh324p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

neuling@dakosy.de writes:

> since the latest version 2.13.2 "git pull --rebase --autostash" doesn't 
> use a fast forward if possible. 

This may not be a bug but instead a fix made deliberately.

cf. http://public-inbox.org/git/CAAZatrCaoB7EXVrCvC9RKmO02G5xcp8GPBaJefHfv7zAXVpL3Q@mail.gmail.com/

A deciding excerpt from the thread was:

> Correctness must trump optimizations

Patches to further update and resurrect the optimization without
breaking correctness of course are of course very much welcomed.

Thanks.
