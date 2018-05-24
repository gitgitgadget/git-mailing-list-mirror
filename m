Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B64971F42D
	for <e@80x24.org>; Thu, 24 May 2018 15:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966383AbeEXPZd (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 11:25:33 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:40429 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966171AbeEXPZc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 11:25:32 -0400
Received: by mail-wm0-f49.google.com with SMTP id j5-v6so6456208wme.5
        for <git@vger.kernel.org>; Thu, 24 May 2018 08:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:user-agent:date:message-id:mime-version;
        bh=wewKHvTr77RaY9v9KYOucew/FRVpXop62Du/tdxqG8Q=;
        b=guq7PVeFJ+frkJr1Uh732UWTqwmYI9MXVnJvXB7D8ES1hvw60QA/COIF/4yZGp6Xdb
         uzvJGhJ+hhfitHSAtl+Qyxm1NU8zRbgrx1KkTTMnK72u6ckPBjvYz67LOIAcv6RuSDP1
         VXZ0EARFR5i65Bqqf1+B9JtDVCCxY5q/gCXyX/YnJCoPYqrv9sUDGR0wn4FnSfU3Ptwt
         QdQ6xyksZL6OU8h7EPxNWP0U7Ir8MEEmYDGX+lYHVACbNDe92ZpiY1JK2rQ1UMR0NfPt
         tIiHsDtmcEtMY2e8gBHdApLiG/y3rAoUak+4KwZ4IrSmTZMgwngsYkPlReXzoZ/Gfu/F
         ObzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:user-agent:date:message-id
         :mime-version;
        bh=wewKHvTr77RaY9v9KYOucew/FRVpXop62Du/tdxqG8Q=;
        b=rou4tNVKLbiC3K+e5dvp3V3KYpxBQo6D3GAxNx0xKZHhegNpb5uGT5mh70dDT3Satu
         vq9WwK2OpSt/PTEQfsh8PHPsoaFWYd3HIcE/3Loy5KyQTxQufeV8bRrkNS5BGqoN4ddJ
         +lZxL/lyDzPME9Qvq4F60eUv68P182Vxg0bvIDU3R0BpYHTGdpeJdq+u0RdEr/u9t8Q9
         Wp9a6/gn9YgwIM6wwJ3V9xkJLcdywQyhFr42xEs4cuHLJKwrPr/rhvxwL27ZgXESETCw
         MNCSr6ZzP9O91zVJXhvuMwmQLltlQv84IqsNbAN9pRfii+dHH//EUcYWp1AsTX0gTqMa
         VMqw==
X-Gm-Message-State: ALKqPwd2YhzG70duM5U/bvCRqJ523dGk3xfpdmJzS73ydwbEeKYxPEeE
        Edzcp6tyGPBChpvyehmogkL44I2d
X-Google-Smtp-Source: AB8JxZo6xh3HDLyFrYoAj3dHoUBVaqgYmUKk/K4+2Gv8wziG4kRtj5ExoB9lxgNslnvxCdrATR7c4Q==
X-Received: by 2002:a1c:37c2:: with SMTP id e185-v6mr7611410wma.20.1527175530955;
        Thu, 24 May 2018 08:25:30 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id f6-v6sm16223474wrj.63.2018.05.24.08.25.30
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 08:25:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: BUG: No way to set fsck.<msg-id> when cloning
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
Date:   Thu, 24 May 2018 17:25:29 +0200
Message-ID: <87vabd6pp2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I do:

    git -c fetch.fsckObjects=true clone git@github.com:robbyrussell/oh-my-zsh.git

I get:

    error: object 2b7227859263b6aabcc28355b0b994995b7148b6: zeroPaddedFilemode: contains zero-padded file modes
    fatal: Error in object
    fatal: index-pack failed

The docs (https://git-scm.com/docs/git-config#git-config-fsckltmsg-idgt)
say you can override this with -c fsck.zeroPaddedFilemode = ignore, but
I see in builtin/fsck.c that just fsck_config() knows about this, and
indeed this works *after* you clone the repo when you use 'git fsck'.

I don't have time to fix this now, but what's the best approach here?
Make all the relevant commands copy what fsck_config() is doing, or
should fsck_object() be lazily looking up this config by itself?
