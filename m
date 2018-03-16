Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 844DB1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 21:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbeCPVKY (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 17:10:24 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:40736 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752416AbeCPVKW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 17:10:22 -0400
Received: by mail-wr0-f181.google.com with SMTP id z8so3179106wrh.7
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 14:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+T+8F21XDmv+gpkFwgsg1tNNVwBqmMm2ucQERmSh54A=;
        b=tCx0JrLBJe/KRbKjYxaLThxn33Q0LdFJsOdq5Uk9UwwsUbkF57u5VdtIyh7LlYm80e
         ukw5iWpZ4TkWESehxQdgNpcNcIi4Eiz49QAZOD6OziKCDa2Y5Xt+iZEHofe6HVH6jT5H
         7LjjNrFjZ50dD/9r+uTSmseKsnplI+HUW2xKaSDbX3mCHuifFvCe8kNjZ/qQD98jPo/t
         TelRSRLJ+WNZCk6N0/6F1JgwdxAOw7joWLHIJ+DHfKjfiM9nwtiDqALpiyWC9Mm2hLlg
         ml7x3mlKp7MJT9RgpFH4pKWn8p44P659vWC4e4UZFz+l+/fixVguLFUIZ2/IivDX7QEn
         k9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=+T+8F21XDmv+gpkFwgsg1tNNVwBqmMm2ucQERmSh54A=;
        b=cfbqz0bB6n6JtT5uMGkcic4sUoX14fT5GEsjtrBZxkKn7W5AtaiJIu48+r8Pptq7T3
         o12anS8VxRlHwJ27NwTmjq26Fyulug0Yr6O3P2OCxkX9n8JgswP3A/lU+Q67CtWtoe6g
         hFk6LImGCVNGKc0AJmBCsjv7NBUGUFr02YJOZ9NZ+PaIlCXAdgDIKwMXP1xXleJYt4Nm
         Db9XVPoWNe+MoYcs8In9PMfi/xRhRlt6dwEHOtEnW4A6PqPJIZ2FMS1IGIdcpRHcut5J
         rS51ZyWcLGVho5lDmMH9G1hr2JK1o6p90jgNlVDGk3isCq2g2ZvPGSge062IV2W4tLJL
         BFzg==
X-Gm-Message-State: AElRT7GbMq7000qHT0nM8zA4vig6gAyRX5M7q0bpStaxUh7xDp79D+Tg
        XwM2Lk4DY5RcrJ2QWNla20k=
X-Google-Smtp-Source: AG47ELur4I9Za7tp3aAzmv77wKHfmJFfQwULjHot6/LPZehg5PXiofNFH8FDezX348I1selDE8FCYQ==
X-Received: by 10.223.154.100 with SMTP id z91mr2842326wrb.120.1521234621591;
        Fri, 16 Mar 2018 14:10:21 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id u62sm8415489wma.15.2018.03.16.14.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 14:10:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     e@80x24.org, git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v3 5/7] gc: handle a corner case in gc.bigPackThreshold
References: <20180306104158.6541-1-pclouds@gmail.com> <20180316192745.19557-1-pclouds@gmail.com> <20180316192745.19557-6-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180316192745.19557-6-pclouds@gmail.com>
Date:   Fri, 16 Mar 2018 22:10:19 +0100
Message-ID: <87y3ird8w4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 16 2018, Nguyễn Thái Ngọc Duy jotted:

> This config allows us to keep <N> packs back if their size is larger
> than a limit. But if this N >= gc.autoPackLimit, we may have a
> problem. We are supposed to reduce the number of packs after a
> threshold because it affects performance.
>
> We could tell the user that they have incompatible gc.bigPackThreshold
> and gc.autoPackLimit, but it's kinda hard when 'git gc --auto' runs in
> background. Instead let's fall back to the next best stategy: try to
> reduce the number of packs anyway, but keep the base pack out. This
> reduces the number of packs to two and hopefully won't take up too
> much resources to repack (the assumption still is the base pack takes
> most resources to handle).

I think this strategy makes perfect sense.

Those with say a 1GB "base" pack might set this setting at to 500MB or
something large like that, then it's realistically never going to happen
that you're going to then have a collision between gc.bigPackThreshold
and gc.autoPackLimit, even if your checkout is many years old *maybe*
you've accumulated 5-10 of those 500MB packs for any sane repo.

But this also allows for setting this value really low, e.g. 50MB or
something to place a very low upper bound on how much memory GC takes on
a regular basis, but of course you'll need to repack that set of 50MB's
eventually.

Great!
