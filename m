Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C2281F404
	for <e@80x24.org>; Sun, 21 Jan 2018 08:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750933AbeAUIZx (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 03:25:53 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34855 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbeAUIZw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jan 2018 03:25:52 -0500
Received: by mail-wm0-f44.google.com with SMTP id r78so11072703wme.0
        for <git@vger.kernel.org>; Sun, 21 Jan 2018 00:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9lpnH3zmQleeSguiXGdD0c7rt+mq27aY7hh7+5MWeOo=;
        b=GFLWGAzuNNQfcj6r9xFVv+Ajs+lPMmjfEvb+o1FlcvmesU/EZ73havd8ImuOxpql3Q
         8yUNmTqZt/AX17Lpxz8QkL0EFwzW2fbEdvQq4hGej/o/QqEwec/R6g1mk/7nT4LmM/NV
         El9jv9Mysq8TQcNIrxAYaPBM434Jz7SxekBkJc/82nt9Q17AJSZeXuxwZWRMf+HMc2ub
         Z/bEMAKn8xWuMwi5InLFL4d1hyoHq2I2IRZmkz66F6WWX1RofFlS6i43eG61Q9FozPB4
         7Jcdn1MAH2wW/K7SLS8ECzaCEXyPAmskpnRl3EXRLzxiZwWS9cokslrsv8SkSR9ieFA4
         2P5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=9lpnH3zmQleeSguiXGdD0c7rt+mq27aY7hh7+5MWeOo=;
        b=VK2n7OOrGi18PIXYfPa3H6zip7BicvTIEXh71g1YzaB7yNCFxpaBNg2EDI/HA771qK
         cuD/DRH/1FwVuifw96I8h+QMMMSGFUToNRWAXmRdLP/yhsUhOtvxlt71hHwyk3230Vdp
         afLRxvDxBvNtgwUBPKrzOpFArCBVxTxOraH9nuZSnwO5Hx1VIxYnqlA1Bequ9cu61efx
         Tau9J3IabnsxmTVjlzxucImOWZJ2uv5t+G3wIaLJ1OaI08Zx7i3M/o7lOM3pgMPqa/pb
         aRUvQHAjMfVYDkN8jEF3eC1sT7ju24VJEjW+iQzK+CVtdvMgDfrdGwmGK9I3S0u3tEAx
         QtLw==
X-Gm-Message-State: AKwxytdD9g5f88bp9h7ZtH7W3FjHXE93976XgsTlISzIbGz1tvRXPYS8
        CzvZ9+Q1Pivd6dwYY0N5YQK7+1s6
X-Google-Smtp-Source: AH8x227Wu9rYhMHOep8LpJP6z7lnu+oBDw7/BgmQZcfpPiuJTM4WQJ5jSUoGsNF6+VU8CH97YZCubw==
X-Received: by 10.80.182.103 with SMTP id c36mr6352810ede.57.1516523150792;
        Sun, 21 Jan 2018 00:25:50 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id a5sm9977254eda.56.2018.01.21.00.25.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Jan 2018 00:25:49 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 09/12] fetch: don't redundantly NULL something calloc() gave us
References: <20180121000304.32323-1-avarab@gmail.com> <20180121000304.32323-10-avarab@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <20180121000304.32323-10-avarab@gmail.com>
Date:   Sun, 21 Jan 2018 09:25:48 +0100
Message-ID: <874lnfipo3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 21 2018, Ævar Arnfjörð Bjarmason jotted:

> 2007-09-10), where wasn't any reason to do this back then either, it's

s/where wasn't/where there wasn't/

> The initial motivation for this change was to make a subsequent change
> which'll also modify the refs variable smaller, since it won't have to
> copy this redundant "NULL the last + 1 item" pattern.

Which, FWIW is not happening later in this series anymore, so this is
just a "cleanup while I'm at it" patch at this point. Will note that in
a v3 commit message pending more comments.
