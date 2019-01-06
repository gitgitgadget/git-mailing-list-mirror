Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7053221419
	for <e@80x24.org>; Sun,  6 Jan 2019 20:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfAFUim (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Jan 2019 15:38:42 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45784 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfAFUim (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jan 2019 15:38:42 -0500
Received: by mail-ed1-f65.google.com with SMTP id d39so36119997edb.12
        for <git@vger.kernel.org>; Sun, 06 Jan 2019 12:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=I+x16cBs1ExJn9tEMkRz4v/0JsuywAmrecWARle9zU4=;
        b=YU/ThaybQzn3L2pwbld2Q6AixyeyXuUHjzXkpqq0kKSyCiHUwv4+SlvR9Ss40ca36/
         h9gLoH4zXyR2J1XJxhsLr2W+1KhZQU8QekzDhwKa4sW8FAmRcNB27cS0rv/bckDZoAk7
         6UGxgzUHd+CX+b9ZST0mCzxfridUcoOdYnBMV8zRbeHrxjUUaxBVCd+Yh9IW+Aax1N03
         Gbv5bCXJu3uZmxshIxatgRAzmSJlSo/VWs3NFxGLgAJ8qnwfiA8Dupykuyw78otwFtJZ
         5yQzCTVg47Dryd2yJOxzpmfkMvMZ5cbK1wQdcCYHxuKJF+LVeRPrploNc4Pq2TxXctsq
         j8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=I+x16cBs1ExJn9tEMkRz4v/0JsuywAmrecWARle9zU4=;
        b=Ja2dH1tIVr2MhXCm2RC0E0y8P3IEWdXZtwZY+7Sjk4XEQTHHr16HJGjqgpbjvG/O6E
         S7+BytE4YsIp2V1ZiCJZHTG9zYnbvRMfhWji/PQU97z/khQQFY/Lgc0mSnuyjMAdcEXb
         i8k+kWyZTJZc2g3M4mAq4TnT8CWR+SpuUnM1K993WsWtnjqmpDtiV6cg5rpdN8RQjOba
         lBrmXmwrb54C+R1ajbIbcQhNLxc261y+IOw8df8ZB6DI9N1qTNc/JeAm8VeRZvF/qUo0
         FcVIOX9NkXZ2CGGDeKdECjH+kif3q0tA+3yf6UeTMOgfejKY5uGjmCKEdMD+1lqrPd1O
         I/ow==
X-Gm-Message-State: AA+aEWZNaFoRR6D1C4Lt9BRcoSHCfPi4dVjErhEP6xjCY71YuOAYZlek
        t6qmMRy2CCSp6IEOMqjNGx8=
X-Google-Smtp-Source: AFSGD/U8VjedAaZJKR6MtPWCo9LpDrUkozff2Kf/7qGiPqFSLGBRGgVhr7QVJzuTYpnHer0eruD5Tg==
X-Received: by 2002:a50:9ac4:: with SMTP id p62mr54084338edb.179.1546807120812;
        Sun, 06 Jan 2019 12:38:40 -0800 (PST)
Received: from evledraar (i40217.upc-i.chello.nl. [62.195.40.217])
        by smtp.gmail.com with ESMTPSA id r18-v6sm16864179ejz.22.2019.01.06.12.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Jan 2019 12:38:39 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] object-store: use one oid_array per subdirectory for loose cache
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com> <3512c798-aa42-6fba-ee82-d33a8985be91@web.de> <c8dd851f-0a18-848f-8e58-cc0ee5f8e705@web.de>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <c8dd851f-0a18-848f-8e58-cc0ee5f8e705@web.de>
Date:   Sun, 06 Jan 2019 21:38:58 +0100
Message-ID: <87imz1ed25.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 06 2019, René Scharfe wrote:

Thanks. I haven't done my own performance testing but at a glance this
looks good.

> The cache is used for collision checks for the log placeholders %h, %t
> and %p, and we can see the change speeding them up in a repository with
> ca. 100 objects per subdirectory:
>
> $ git count-objects
> 26733 objects, 68808 kilobytes
>
> Test                        HEAD^             HEAD
> --------------------------------------------------------------------
> 4205.1: log with %H         0.51(0.47+0.04)   0.51(0.49+0.02) +0.0%
> 4205.2: log with %h         0.84(0.82+0.02)   0.60(0.57+0.03) -28.6%
> 4205.3: log with %T         0.53(0.49+0.04)   0.52(0.48+0.03) -1.9%
> 4205.4: log with %t         0.84(0.80+0.04)   0.60(0.59+0.01) -28.6%
> 4205.5: log with %P         0.52(0.48+0.03)   0.51(0.50+0.01) -1.9%
> 4205.6: log with %p         0.85(0.78+0.06)   0.61(0.56+0.05) -28.2%
> 4205.7: log with %h-%h-%h   0.96(0.92+0.03)   0.69(0.64+0.04) -28.1%

Can you elaborate on the test setup required to get to the point where
you got these numbers for subsequent comparison, i.e. how you generated
the approx 100 objects per dir, what OS/version & storage type etc.
