Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A67041F404
	for <e@80x24.org>; Mon,  5 Mar 2018 02:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeCECYW (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Mar 2018 21:24:22 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:44361 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752025AbeCECYV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Mar 2018 21:24:21 -0500
Received: by mail-wr0-f169.google.com with SMTP id v65so15635797wrc.11
        for <git@vger.kernel.org>; Sun, 04 Mar 2018 18:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7OlDgnyYmwrl0AujRkPP59CauSQ5GrxlaZNvZbxMYwY=;
        b=mNGh7+A6VXV8TgrP7O860MUtjI4i7zGqPoED+QGD5OrteRBljSOrCho/E8eTbL9e61
         zWsZ8kY7jbUnejlQukBchu259FliJG4u6rSPhBydRd1dkoKQyFTbDQ67MslV/nxc4hEv
         8PJXOCa+7/o5uSisUdTLfKtEO5/AVpUvwo0pa7bVusGB7yagvfALY/Qv4YecWZpG3iiZ
         CMNDr99t+NC1/iAl2j3zZbrb6S0N4aP1PopLciP+ngCD1n7l9WvYjFnPTbZ0tMdhyPxw
         Bn9TGzriUOvhmCRKqyw/9c1x8rq7x9h/Xpn38I3ZOagnx2EUyD4dZrAub5qmDoRe6oLr
         1zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7OlDgnyYmwrl0AujRkPP59CauSQ5GrxlaZNvZbxMYwY=;
        b=qV8l1x71NMw++RShRoa6FTzzEnEQj3h7Eiwz1rkuSwBiJLsgobL4YnAk/3JhC85tMZ
         y/OZl3BFMVno+OlCkOSbAggA5Ryp70hNaPvZN7vuROQ1+2A7sct4amu5jqd7WZt74wSk
         s6WZGxsYECvYarwiYgF3wfwoYFlsoh4jXFyTKPQbJ5i77iXWiQeC5qE2Wb12mu5fLyT6
         3z8p9alq7Q4s04WWf4sM8aKdMWsQrQ/Z4xv+bO7rR4b572/chnFe++PbBOc84KUP7kKp
         0DZ/EvAbeN/fpDZg4HZQUMgXCltYMjugtBT1wAMbzEfbHnbzxGOBjyMho2kkphhkiG4m
         9hIg==
X-Gm-Message-State: APf1xPAKy/kip8x5j09END2v4sJJD2rojLqpCBq2hGL23Zg12MigT1fS
        4iulCtsSGlO3/qYxtwAQiKE=
X-Google-Smtp-Source: AG47ELskbnkxyWdXqSwmPSduc1Pp24Xab9yrKzMhmBuJoEKOk/mmi7iYsn8lUDAkIhAzv2oZ5SQZhQ==
X-Received: by 10.223.195.23 with SMTP id n23mr9281023wrf.126.1520216659932;
        Sun, 04 Mar 2018 18:24:19 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d8sm5718670wmd.20.2018.03.04.18.24.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Mar 2018 18:24:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Leah Neukirchen <leah@vuxu.org>, git@vger.kernel.org
Subject: Re: [RFC PATCH] color: respect the $NO_COLOR convention
References: <87zi3reoez.fsf@gmail.com>
        <xmqqefl3iuvx.fsf@gitster-ct.c.googlers.com> <87efl3emlm.fsf@vuxu.org>
        <xmqq8tbbhayi.fsf@gitster-ct.c.googlers.com>
        <20180304223925.GA808005@genre.crustytoothpaste.net>
Date:   Sun, 04 Mar 2018 18:24:18 -0800
In-Reply-To: <20180304223925.GA808005@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 4 Mar 2018 22:39:25 +0000")
Message-ID: <xmqqvaeb9s4t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> As a note, turning off color can improve accessibility for some people.
> I have a co-worker who has deuteranomaly and virtually all colored text
> at the terminal poses readability problems.  It would be beneficial if
> he could just set NO_COLOR=1 in his environment and have everything just
> work.
>
> For this reason, I'm in favor of taking this patch, assuming it comes
> with tests.

Oh, I agree 100% the world would be a better place if there already
is an established way to turn off all colors, instead of having to
run around and setting tool specific configuration like LS_COLORS
etc. for 42 different tools one uses during one's daily life.  I
just am not getting the feeling this no-color.org's effort is the
one.  We already have a way specific to our project already (i.e.
configuration variables), so if we adopt NO_COLOR but other people
do not universally support it (and they support something else),
we'd end up having to maintain yet another knob that only a handful
of projects understand forever, and that is where my reluctance
comes from.
