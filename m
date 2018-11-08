Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35FD21F453
	for <e@80x24.org>; Thu,  8 Nov 2018 14:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeKIAXb (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 19:23:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42322 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbeKIAXa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 19:23:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id y15-v6so21526716wru.9
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 06:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PiJH4hOkHzlWnfqYp69kxsPhvm5X+Bnm4gA5nP8tvs0=;
        b=nrOXvWKmXn0gzAE9FYkGfOZuX/td75+y1q6BlesfYFzQLNeoi8MVWhcwIQ4aitFTfp
         Bz/ldC8bDyfHkBBtM2DlkKLP0ICqMP6yJxUgSRbVdM/ZzlerMaNoYFAhaq0GR0GG5OvO
         PXzzdRgeSEnzg1ck4+pmjNNuZQcYBvFjKseTQGO9hUGEcyJXAMaaVHdpSdgiJ2GrZxC5
         xaAexAWRyYQX6DuBqwPH8zIv3woG4x0ApmX9GRRasXuDJC63Kde1g0JWWfBQ7nvpWgAO
         3TWVhPmOsaTVKLVeAJ5YBjtbS/7nUNx3l37DGdOg6Lgjpvx18VY8Hlhf4aGQdii/YQKD
         AcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PiJH4hOkHzlWnfqYp69kxsPhvm5X+Bnm4gA5nP8tvs0=;
        b=CJF0WyHwGehFEBhB3kjzzdN2K4sIPmQr0s9B6FBK/X7PbsETmebLL0khVYLb3ts3yO
         5ZXn8AVx499zU9x7tdXSxXQPiWZ4+tx8PM1RV4HZH7yFR6W8NfoWZUIp2hvpldQEdPeK
         y99sVim4vI8k+xuu57MX9Q0ROEFRDBA4jkWDw53m6BfW+p8Q9UlvKPZhbFunSz8+k8Pf
         bKSVwOgmi5tEq/C0moZqnZbgTUe9rIxVqQY3qHZ8Couo6Jt7McCTIf+sXnqPvKY0AAxz
         c4Cd7LqdkKzLh1bdt6UMvvngpUKYRJhldWKLX+ymWtYlbifCxk2e4iWRkxm+lAJGeKGB
         LFUQ==
X-Gm-Message-State: AGRZ1gLUz62FSd6Z3EGNOnWJ1Ge0M/Fk35XxgfPlSIMQ+vWuMNsDnLXd
        rrpg4uZyqfof98wvKpte74w=
X-Google-Smtp-Source: AJdET5fKMx0kU2GUZEKTyNNx35NTQMpv0Rak/PTOj4qASzVAyK5SsTgTtpflvgIyanc2sWwaDZMd3g==
X-Received: by 2002:adf:e983:: with SMTP id h3-v6mr4367928wrm.58.1541688459242;
        Thu, 08 Nov 2018 06:47:39 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r1sm5275139wrx.15.2018.11.08.06.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 06:47:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
References: <pull.66.git.gitgitgadget@gmail.com>
        <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
        <a374e4bb-1970-9ec7-fe94-a273f1206d6b@kdbg.org>
        <nycvar.QRO.7.76.6.1811071222200.39@tvgsbejvaqbjf.bet>
        <efd57458-07f6-2813-483b-dc7fba785dc0@kdbg.org>
        <20181107204142.GA30078@sigill.intra.peff.net>
        <e7ff6f22-fe5a-3cca-9305-2c8a6fb55d45@kdbg.org>
        <20181107220320.GA8970@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1811081408310.39@tvgsbejvaqbjf.bet>
Date:   Thu, 08 Nov 2018 23:47:36 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1811081408310.39@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 8 Nov 2018 14:11:53 +0100 (STD)")
Message-ID: <xmqqmuqj7hiv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> But now I have a really crazy idea: how about ~~/ssl/certs/ca-bundle.crt?
> The `~` prefix is *already* a reserved character,...

We would need to prepare for a future where we need yet another
special thing to be expanded, and it will quickly become cryptic if
you said "~/ is HOME, ~USER/ is USER's HOME, ~~/ is runtime prefix,
and ~~~/ is this new thing...".  ~runtime_prefix~/ (i.e. carve out
the namespace for USERNAME by reserving any names that ends with a
tilde) may be a viable way to do this, though.   It is just as good
as your other idea, <runtime_prefix>, in an earlier message.

