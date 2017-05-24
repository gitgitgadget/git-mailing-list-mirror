Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B860A20281
	for <e@80x24.org>; Wed, 24 May 2017 02:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937949AbdEXCpp (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 22:45:45 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34058 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937945AbdEXCpl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 22:45:41 -0400
Received: by mail-pg0-f54.google.com with SMTP id u28so58470425pgn.1
        for <git@vger.kernel.org>; Tue, 23 May 2017 19:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=9gtUd10Kc0w8kiT24X4f/vMm/rEtffK73WcWKd8yWMk=;
        b=cyiyobgctu414sW2AXa+OOT7mCeU0nZe2tD5bicS71IPomYrUgMPYw09O1SyF6KjFf
         SggWv3U+2/+yuQ6wfeBSThQ6qcVJAEqcJkes15kR66N7+Q4Mg3Bsawu4LqhblodM3kg+
         V2QYAGi/8PZpYwzaDFMJE3eMvNHwWYd+/EQh1/RD/Ebh4KsukW0LnWVRVWi0+5bnI8oJ
         Y2XPd/xX6n2trdKgc+SWklpyD/54p/SL/h6UNLxQ3Fj0hjElMWP+Gm74j/E/nUpOMK//
         DZEYbkk49jBSG2n3SBWzrq1imSkswL/n/VugcOdbwHXEoSgDhCRIKdJW0AIKqRB+qPoJ
         j8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=9gtUd10Kc0w8kiT24X4f/vMm/rEtffK73WcWKd8yWMk=;
        b=ijXqyOAudh12Iz/cmzlh9R8iT4bPZP3kG/p9pxteKc+EVqNNqpFZpU3GhP7FSnadvq
         gCcQZ3/edEFP08EdwCOb8TRgRoNKoOPX1DCgx6UP9Nou86ughNflOlqnryv3BetpqCq2
         ZkOg+mLAPETj066viQKAVUYuqnCKFw95dYepLkqvdADIzi4MtM3p0IhsMak6vBCHWnrN
         zLNRBig7k3bqxoeCC5mOXmxQFbHPqoAcIs2y6UgGPw0RjcFfr4cVaIIQLlQJuZAqNZQH
         KVLVoqrGHp3xtdgCSrxMz+MqeEs0RJUzGk3pudyYTTlsA5nRAx47LgPAM+xt/BjSKLE3
         ksOw==
X-Gm-Message-State: AODbwcDzfS8AuD3NgNsqG+P4kifOjuVKAeun+2dwm19ECMwORc4vNWE1
        W9QFuPiMErke9+3Qg01eag==
X-Received: by 10.84.217.141 with SMTP id p13mr39573536pli.59.1495593940976;
        Tue, 23 May 2017 19:45:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:167:7063:293b:a24d])
        by smtp.gmail.com with ESMTPSA id i68sm4643398pfi.72.2017.05.23.19.45.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 19:45:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 03/15] handle_revision_arg: stop using "dotdot" as a generic pointer
References: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
        <20170519125006.gbvzr2dqrcycmpx7@sigill.intra.peff.net>
Date:   Wed, 24 May 2017 11:45:39 +0900
Message-ID: <xmqqzie3gegc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The handle_revision_arg() function has a "dotdot" variable
> that it uses to find a ".." or "..." in the argument. If we
> don't find one, we look for other marks, like "^!". But we
> just keep re-using the "dotdot" variable, which is
> confusing.
>
> Let's introduce a separate "mark" variable that can be used
> for these other marks. They still reuse the same variable,
> but at least the name is no longer actively misleading.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> It may make sense to pull each of these into its own helper. I didn't
> really look because they're so small, and because the return semantics
> seemed confusing to me. Some of them return, and some of them keep
> parsing. Some of them restore the NUL they overwrite, and some do not.
>
> I didn't dig in to see if there are weird corner cases where they
> misbehave.

I do not quite know what corner cases you meant, but I agree that
many places in the codepath we forget to restore "^" we temporarily
overwrite.  I suspect that none of them is deliberately leaving "^"
unrestored and they are just being careless (or they truly do not
care because they assume nobody will look at arg later).

And I think not restoring cannot be a correct thing to do.  After
all of these parsing, add_rev_cmdline() wants to see arg_ intact.

But let's keep reading; perhaps they are addressed in a later patch,
or they are left as-is, and either is OK.
