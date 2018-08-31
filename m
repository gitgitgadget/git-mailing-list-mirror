Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21F1D1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 15:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbeHaTlc (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 15:41:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36449 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbeHaTlb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 15:41:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id j192-v6so5769958wmj.1
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 08:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lY2Ct3vonNYHSu9f98JmUg6sHUl+QuaPZ1h02agpQ6Y=;
        b=UpX3kMEUlymeLKfbQRBlNGWvR8W7ZGNv+ALtHv0STpFByrEWMXX5OAJt1b9bWM71CP
         tOvTDGOO286musDugFzGNA4yfzuZ6AZWR2IwvesRw/OO4Fgz1sk0Bs52fJCwx61lPOxQ
         BPhSHf+Rb4DaRuV9/bckH+r9J7vwoaopfKIS3RkQGIoCFoppyKU+vEUDM5i3l18CocpD
         xyJJ7uf+QGF0Qe7g31HBYNTlEFoUbcSRVTHy0Q+pvWVp13+zxgmReCrwQBCL6dZSDX2i
         y0ystjFJJoWxkzev6jnG1CEf5agc1qkj5kNUXwMuK8qhVpCpNxxgkziLbxKlmXxlo1VG
         DY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lY2Ct3vonNYHSu9f98JmUg6sHUl+QuaPZ1h02agpQ6Y=;
        b=RMa6njBGCRyLAJk/D9BkQUZXpZ8cnpOfC/v/I8JGIZoMDzhlEvNJEBatcIqWyOzcCU
         gqVCWaOqt15pd1ECdKpnukxSxXFko4R2KAoezmYauR1blCBVAkLG46FyPxzVmYC2XADI
         5kReqqB6xz9g5cwq7P7nzptGL7muTyR0OmZ2aMKohsNwcBd3Q8OmzjJbG8lx9e82RAjq
         S7UXmLAH4XB8lovSc2VyEWDniQEtV2dgwNNkbWdZ4EWfMJDbsTxMzJX3utZhNiLpXdFr
         zAbUrkqgBvHiG/RrIGN8TAMY3M9d+JTg941HbxaQQ8bGGM5/MTjYDReJZdnsPzIHlnch
         medg==
X-Gm-Message-State: APzg51BtC4gv1i05DWJlGc22La2CEPVWTO7AIRIvc3Nkn2C8Nnu4x5bZ
        AxMtQs3gaQeixMeBCaiO7b4=
X-Google-Smtp-Source: ANB0VdZ75NNeP/7XO/drSgz5q1j0sggf9RcF50IcxKBe0o4Ac5uylD/FyGsJnrcyB5+wlD36gi52mg==
X-Received: by 2002:a1c:8893:: with SMTP id k141-v6mr5110644wmd.36.1535729608216;
        Fri, 31 Aug 2018 08:33:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v2-v6sm4183511wme.36.2018.08.31.08.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 08:33:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Jann Horn <jannh@google.com>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/5] t5303: test some corrupt deltas
References: <20180830070548.GA15081@sigill.intra.peff.net>
        <20180830070932.GB15420@sigill.intra.peff.net>
        <xmqq8t4n69gy.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1808311155410.71@tvgsbejvaqbjf.bet>
Date:   Fri, 31 Aug 2018 08:33:26 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1808311155410.71@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 31 Aug 2018 11:58:24 +0200 (DST)")
Message-ID: <xmqqh8ja360p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Would "echo base >base" give us 5-byte long base even on Windows?
>
> Please note that Unix shell scripting is a foreign thing on Windows. As
> such, there is not really any "native" shell we can use [*1*], and

Yeah, I know that; otherwise I wouldn't have asked.  Because ...

> therefore we use MSYS2's Bash which outputs Unix line endings.

... I didn't know what MSYS folks chose, and/or if you have chosen
to tweak their choice, and/or if you switched to somebody else's shell
(e.g. busybox) and/or you chose to tweak what they do out of the box,
it was worth asking and getting yes/no question.  You do not have to
tell me why I should be asking.

So instead of typing 3 lines, you can just say "yes we use echo that
emulates Unix".

Thanks.
