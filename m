Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 468E41F516
	for <e@80x24.org>; Thu, 21 Jun 2018 20:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933511AbeFUUwL (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 16:52:11 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35366 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933499AbeFUUwK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 16:52:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id j15-v6so8538811wme.0
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 13:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=w2ZOTv0L2kycC1oQIjGOSMLDUmF1msAtB7yKTXgCBMk=;
        b=IT87emp1F5ve3+KBMnipbV5J7Jf225Bh6lHICflfAsxwpWjNpv6jM9VZ/3oRjU50es
         co3l0qd8BWhlS2sMGuoUUlHptIQShSYYswj6rxpAYA3b1505oMsDDYzSpWz0ehcV2fMq
         OA5kbQPmABUTSBW0JmFge5iKgAC6bbn+vuk8JarlQGKE++t26/kwumWjsW8LSTt3FexN
         T4nc03/FYakDxdpAun1ErnynHwMPthM6SkLOAtVSdi592ToyJzSAKOHocAKAn4SU7hZ5
         yV0rh8fJoEatwgmWtewlLvOGh9Om1DMu9xyy46vI8VcqQvwNRu0G08CD7n/Kq+Tefgsp
         c+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=w2ZOTv0L2kycC1oQIjGOSMLDUmF1msAtB7yKTXgCBMk=;
        b=J9gwLhb9TaTOCXdSxwt84zveHHbqU1J8M0wAqPUCKD9mDJDHLch7Iiyfz6Akswhuj+
         IiS9xYn8jOhakqXTWbw6CdmPNp47w6aOJmi/+6fwW09+C/g2sT8X3oA/Bv0gAwPwW7K/
         9EGVznIKD/BWE/nQ9GCtxbPStATwjvzxJdKJ9Ns9hjUezA6YOcS0k/y+VZr/Oj/D2C1g
         gHOgpZUODjq+4edkqtRagpgivtHWsr8tVVKMgb49VG6yTy4KoXL+WnAkoU0T0Bt9XlOO
         CCjY/aeUbwDel0PqH1/3opJRl20vswsJWhOSvBQdYModVt8cbhvSDKWVMckQ6fOXAngG
         GY7w==
X-Gm-Message-State: APt69E20yaeQ7R4oXf0Rbu7FX3uhBgYCGaPpCEc/aVSjTFshqj9WVj8z
        gL1Rt5E3Mp2TrSVV1eYfD+8=
X-Google-Smtp-Source: ADUXVKLGGaCRIwo8OSsHXL9KTRUPDPzkpN/ZDtACjeIrZLEpE2sBKSxOBKqj0Bq2emVF0yC4VB553w==
X-Received: by 2002:a1c:a54e:: with SMTP id o75-v6mr6502669wme.157.1529614328888;
        Thu, 21 Jun 2018 13:52:08 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r9-v6sm7002959wrs.63.2018.06.21.13.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 13:52:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH v2 0/7] grep.c: teach --column to 'git-grep(1)'
References: <cover.1529365072.git.me@ttaylorr.com>
        <cover.1529524852.git.me@ttaylorr.com>
        <20180621115302.GB15293@sigill.intra.peff.net>
Date:   Thu, 21 Jun 2018 13:52:06 -0700
In-Reply-To: <20180621115302.GB15293@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 21 Jun 2018 07:53:02 -0400")
Message-ID: <xmqq7emrsw09.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I wasn't sure where we landed in the discussion on "how much crazy stuff
> to support". But AFAIK, the code in this iteration handles every crazy
> case already except this one. If we're going to care about OR, maybe we
> should just cover all cases.

I think I was the only one who didn't like the tool knowing more
boolean logic then the mere mortal user.  As long as the resulting
behaviour appears logically consistent to more math minded people, I
am actually OK if the outcome to overly complex input feels "too
magical" ;-)

And it appears that not short-circuiting AND will make the result
better in that respect, so I am all for the suggestion above.

