Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 250C41F453
	for <e@80x24.org>; Tue, 22 Jan 2019 20:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfAVUX7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 15:23:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38417 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfAVUX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 15:23:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so28924829wrw.5
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 12:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nL5wHOKz1DdIc8EmTdpU5RUMj4/nvZVuOpJ1qIIbkPQ=;
        b=OdSV5NmHIFW5GDAz6r/KkthCiLmNx7hfgC301yrnHiy7KFXu6tOKMb/OW9RBX61sCi
         CwiT7tC7aHVSgGB7EgbzBHo3VhGNK1K/Ds7p8u2gcnPGK/EMuinM19FP086oJgAUHlVh
         FdVtpug83szSZrCJCnGOL0lIlrHZq6XT/Tsld7f/3MmO4N0rl0iFGnsfL2niiG7Rc381
         g6eYXqjJOjJ+X145jOnxOQ307UDbdKyUCcVODdX07o9o7ZOOwbfh2XPVfAxOPp7J2hdL
         aasj2AgskGUsFY0dNXLMqyvs7hEzVSx5OZHVkmuzfpaeb5qFe4KjRkA3cueaBMdpGmNh
         SagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nL5wHOKz1DdIc8EmTdpU5RUMj4/nvZVuOpJ1qIIbkPQ=;
        b=bH2TiAQ29PHPTigCyBu3InVMz+0Wc7JsrIlQlXKMeoBXbwIpgqGaXHOy9iH5TJIyvJ
         nJfQlSP9bSKgADZYsf8o9I02iT5NOJBAxfGL5uGcJo4gT7WRgyqMwIJXx/jlZVsaHUeV
         ImS9SnxWAwtuPEDbLvDVK/TkwO27WDkNcb1LR6IB52aMg4eG9zP4i4LUO1IocGlQsFeh
         tZZ/w7vh7pBrtGTZG2hKUn30b61/jdIJDI116/QB8ZvlIfcvscK6BGsRPTuTiXNPFiKQ
         w2FCWHhBnjKzEJb43QmBZKWj4dWG1BwOr+9GyF3b/q1M5goorj83TED/Hwf64IE2P8Kp
         124w==
X-Gm-Message-State: AJcUuketNQXneDAVo3XMTsZJ1fPs2NjSRjY8Qomt+LBUG43Yd8edaji3
        LnHpEsLAPk3hzcXqNWeGoS8=
X-Google-Smtp-Source: ALg8bN6Tb1HSpnp3tKiPTKi4O+lnd6V7oheK9TpcPNl2a9i9Xc8SoRgFeflefQSWyZQCCNEEzohO5A==
X-Received: by 2002:adf:f101:: with SMTP id r1mr35367051wro.32.1548188636842;
        Tue, 22 Jan 2019 12:23:56 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k7sm84816770wrl.51.2019.01.22.12.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 12:23:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Sven van Haastregt <svenvh@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] git-submodule.sh: shorten submodule SHA-1s using rev-parse
References: <20190120204653.3224-1-svenvh@gmail.com>
        <nycvar.QRO.7.76.6.1901221623370.41@tvgsbejvaqbjf.bet>
Date:   Tue, 22 Jan 2019 12:23:55 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1901221623370.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 22 Jan 2019 16:24:26 +0100 (STD)")
Message-ID: <xmqqbm48fnl0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +		sha1_abbr_src=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_src)
>
> How about `git -C "$name" rev-parse --short`? That would less likely run
> over 80 columns/line, either.

That would be a separate patch, either as a preliminary or a
follow-up.  The existing code has too many of the same construct.
