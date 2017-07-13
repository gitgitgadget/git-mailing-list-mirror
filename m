Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DDB9202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 19:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbdGMTVN (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 15:21:13 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36605 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752587AbdGMTVM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 15:21:12 -0400
Received: by mail-pg0-f68.google.com with SMTP id y129so7953840pgy.3
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 12:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QFFeIdslMTHoQ6rwmGvdHkf09OSkFYcw/8b3VbVTlzA=;
        b=pHWJh93TcaJgEqlWcYk6UrtV8novHKzYOgvSKpFh48YasWP+1NCENH8Me6xZy2wnG8
         Atz8IpnNfSPLDhsp8Xb3D/tdTZhOI7rgNuImesM8vkgTH3Ny/JWW7a7raz+w6+tIzRTY
         aJZe2OoWD+uamIq5QcXpeKVAqEK9zJEqbdT1/56JbQJUh3vNNi0Bu+vOpn/D4vhWVqQF
         3QWRFCpddN/7UZKzHbmG6VpORip6TR9G46cZFFBcCd07w6AQrsdIgc90YIpmuWKcEUE9
         CdBy84xVBF/2WdilPOELkwl7M7xNdufeBv4C7EPQt88dSOo1wZlgPZi+1M7mwzmmJHqw
         8riQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QFFeIdslMTHoQ6rwmGvdHkf09OSkFYcw/8b3VbVTlzA=;
        b=SPqcTNbSzeGLnxsbMnqjfMPFwN071uFekI3b+FWf47UMsWbA5U+h8RwkFDJziXkQPZ
         bxz4Ac6HtStHHkjudp9TPROMi7LSbx1Gm/BpALXWnwB1WqUFrDbS7FkcZt+N0Joy4Pys
         oNOfp+yJG0hHEXYWCgimA5R4MvRlDQyQcjAZyLEuwXIpdxqDC/z3jsOuNpfuHh+9ikcQ
         t6M2smzcUOZK0HXt0Q2iV2qwled0xpxF6wuqoKLUjvhzxZm7NYKvwg13pBa+aAqbkTsS
         j93br30d6GiMlgNNnfAYUflGNxInQOkci8pl4Z4bvIQM0Wx7uOinwOnb57Wg6+7jONn9
         YuPQ==
X-Gm-Message-State: AIVw112JrpuKmAQev/rL+noaomMeEvxk/djcar/2ArF3Gt6STBDmEuKB
        9qum93kIyq1h/w==
X-Received: by 10.84.133.38 with SMTP id 35mr11770170plf.141.1499973671487;
        Thu, 13 Jul 2017 12:21:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id o1sm12383129pgq.10.2017.07.13.12.21.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 12:21:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1 0/4] Teach 'run' perf script to read config files
References: <20170713065050.19215-1-chriscool@tuxfamily.org>
        <20170713165840.e5cdw7pa2m6haaen@sigill.intra.peff.net>
        <xmqqeftkxkax.fsf@gitster.mtv.corp.google.com>
        <20170713184051.fcwg76o6ovnsjjbm@sigill.intra.peff.net>
Date:   Thu, 13 Jul 2017 12:21:10 -0700
In-Reply-To: <20170713184051.fcwg76o6ovnsjjbm@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 13 Jul 2017 14:40:52 -0400")
Message-ID: <xmqqmv88w3bt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... But if
> we did have a third-party system, I suspect the interesting work would
> be setting up profiles for the "run" tool to kick off. And we might be
> stuck in such a case using whatever format the tool prefers. So having a
> sense of what the final solution looks like might help us know whether
> it makes sense to introduce a custom config format here.

Agreed.

Thanks.
