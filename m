Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5D3E1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933297AbeBMBia (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:38:30 -0500
Received: from mail-yw0-f175.google.com ([209.85.161.175]:41247 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933287AbeBMBi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:38:29 -0500
Received: by mail-yw0-f175.google.com with SMTP id f12so2490574ywb.8
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0zrmOfX2UosT5ars44X0q8lAonM6RQSaVVXe5q3ZhjU=;
        b=cT47sS0tAvGpMXY6RXcRo19Vnjji3auj0SBRXAM+7AkxEO1I/ziq/o6Hq1nslpiSMi
         ObH9F9l4v9z215fjs6YGp0EV/z5N9t2Krrf/FLgBTksNZ+EZo9lELIWeZDHImk4o5pJh
         kCM4m6mDvEX5PpREWFrVwVKSSxHIpADVPGv3600eD+XSoJ1b7aGFeurnzjejpuBB8OhB
         A4UU079HcjW/sWh8H+agrOJdgkoXcXZyBGmuiYS08y3qF1GnTupYwzMy6sxo7E+z10k1
         13D4W5dm51t3aiXTykvRZX34Z0i8FqPDY+OgO6psMFRpgosv/Y7nyLxgmKgdo+pbWOi4
         DiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0zrmOfX2UosT5ars44X0q8lAonM6RQSaVVXe5q3ZhjU=;
        b=LuLC/0iG+QfADnnW/k1MqRGW5N78c1fcSld4naaj+9vrtQo2edk7VnVMMgNGgcz0un
         FVufcIBIY4p/zKzsG1orVj/8DAN/n0FYqyVv3Lf6Wmwhwu4qZBxxgPZoXAe4FnHT/1SQ
         HOH60CgNBQYRae6Pk9li4xwshllHn3kf60ZA2y0CW8wpD78yt4WF8A3pJBBKxpfB3sz8
         Ii3exWKFdfV1nwvXKHXjqc+CQQf9TB9jq6rH3g4w8KexWg0Bvu/A4PuUMyX4oCUIFCIb
         DSJWuNKlRFG9hcOIjIMr3gT3ewYT2n7f6AOknCThMmJ/EI2KcivEPhByx3Y4RLgz+Qk5
         wVjA==
X-Gm-Message-State: APf1xPDfOZhvk+Th3yBR9SjnQBdDjYhpTCF8NQ68X0uHYrkwklAEEnVl
        B1Wo/rc3FJK8hohM6yxTQBEcKUIJQ8bk6itPv4Khmg==
X-Google-Smtp-Source: AH8x227Y9dmhPDr9teNmNfhB4KgMln7853T5PG8y720NhaKnBXu087QBcOZKaqgJ7NjGTksc7quumHJJPGeTGDBC4ss=
X-Received: by 10.37.180.65 with SMTP id c1mr9199860ybg.438.1518485908834;
 Mon, 12 Feb 2018 17:38:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.203 with HTTP; Mon, 12 Feb 2018 17:38:28 -0800 (PST)
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 12 Feb 2018 17:38:28 -0800
Message-ID: <CAGZ79kY8XmoZHXkMBENJLAXdNNQr-+BTW7kb6BUTiMWxMR5+uw@mail.gmail.com>
Subject: Re: [PATCH 00/26] Moving global state into the repository object
 (part 1)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 5:22 PM, Stefan Beller <sbeller@google.com> wrote:

> I developed this series [...] on top of current master.

also available at https://github.com/stefanbeller/git/tree/object-store-part1
