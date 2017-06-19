Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD71E20D0C
	for <e@80x24.org>; Mon, 19 Jun 2017 15:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753850AbdFSPvE (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 11:51:04 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36740 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753687AbdFSPvC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 11:51:02 -0400
Received: by mail-pf0-f193.google.com with SMTP id y7so17749775pfd.3
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 08:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yRX4AirBZefTqjUJd9VSB1UJK/t27H3V3Zo2dfBafxY=;
        b=Qw+wrc8xdUqyNgwh4kxc6tsp8wCFzMrRYt8ayplHEce7CNS+7Uz7UHBzJXUimgLetf
         Dt9gUhtZPs+doCHLnls6omjfZnlnJC5wPoMeWSTUuMZ9MBSLm/xFnFmOJ9an7Q8ryNIj
         9v083dqAzY/NduOmQy70H61qxIGx9rO4WK4UbJ/m9Qa6FKTLx/3wKTtwDdE6s69d2ATQ
         Eb9UWebURfAia5nER54kvNfp96HaSZzK4mkA56uiwTRuDE6oCqa89pUdP6deVKkLMVmN
         tr6eo4oZUJMnHcfIKs/GQJfpGJHK7SLQdD5chKEuCXfvQV3i2FL7H9XaBEzE755pRGgg
         3DRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yRX4AirBZefTqjUJd9VSB1UJK/t27H3V3Zo2dfBafxY=;
        b=FE+HB1ZWo16xsirac6UcG+WcAydwIf48ItpXdV943/UErCASG89OpfCZsqlnUhChDS
         otgDy6ZeWPsA9QGOiDpEuk5V9MKDhynfmr3FXy20tM0H0s5z2d/WYztTkibM+83yiP/6
         ocfZmILvgG3S6SaCJzkpz6Xa91k9I9aJkYrUaljmnAyQB0NMdOFzkioQd7sEW59ah02S
         2hs37rZmj4jFOXAGWPss6tkbtSvOlfgvZ4uSX53hTNehs+0WQEiOxBN2qkYqPTe3lEDg
         PSSAllPIBkfVvF+ONjV850vNjta+uGnuky9iRcplwkjgbcjkfcqbcfNg5woCTaCGYyth
         YDPA==
X-Gm-Message-State: AKS2vOwV/Hx6OaxPrrcwtPwsH+zOagXGGKZwNFQyj5dHrJyhrF5TwKf5
        II6O/rKyIXKbBg==
X-Received: by 10.99.124.65 with SMTP id l1mr26359679pgn.279.1497887462112;
        Mon, 19 Jun 2017 08:51:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:7466:3d2b:4ee9:fc7])
        by smtp.gmail.com with ESMTPSA id f72sm22015162pfe.4.2017.06.19.08.51.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 08:51:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGg=?= =?utf-8?B?w6FpIE5n4buNYw==?= Duy 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98yvin?= =?utf-8?Q?d?= Holm <sunny@sunbase.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fix a refname trimming problem in `log --bisect`
References: <cover.1497792827.git.mhagger@alum.mit.edu>
        <20170619091654.vb7krwcmw2y22v7m@sigill.intra.peff.net>
Date:   Mon, 19 Jun 2017 08:51:00 -0700
In-Reply-To: <20170619091654.vb7krwcmw2y22v7m@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 19 Jun 2017 05:16:54 -0400")
Message-ID: <xmqqo9tkt1qz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Jun 18, 2017 at 03:39:40PM +0200, Michael Haggerty wrote:
>
>> As before, the second patch is optional. If it is omitted, it might
>> flush out any other bugs like this one in client code. If it is
>> included, regressions are less likely, but we won't learn about other
>> misuses of the API. I have no strong opinion either way.
>
> My feeling is still slightly towards "don't include", but I also don't
> have a strong opinion.

I am inclined to the "don't include 2/2 and cook 1/2 alone but a bit
longer" approach.

Thanks, both.
