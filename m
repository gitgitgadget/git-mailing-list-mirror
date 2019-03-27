Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B333B20248
	for <e@80x24.org>; Wed, 27 Mar 2019 10:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbfC0KYz (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 06:24:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36933 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732380AbfC0KYz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 06:24:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so16121191wmf.2
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 03:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Y9iHfu2qJ1rYwaY6oWEzIs5Qx7zIs9SJRUxpbN3JEB8=;
        b=d+VVYnW3XdjEq2BovFuDHS3kVRzFKGCfC87smKlbvckwkIrktav+2G/Ub5ggePAWKO
         JratSPHnutTYsHgKHEJft4wVPzcYRAwzzTEFkUVqimmBKiA7QNJ4atElnamDPtWVuh2Y
         UO1yjpSiPiPQIsRA2EaYlmtnFbZSvXteXH6e6+vm2xS+XzYPa+p9d3CQguKah/niHuFC
         tu4RpL7eqOo/FJTY8COWqsi+T6EXavB4iUrt41JYyNLnauJJ/7ADl6JKW7OyKdPvKHBm
         bWij0X0clPdMoOeOV6jlVOfWbhQyP4rBMb8gbAk80/RWyBpMS2kOnpn9kXdEqt45+ECm
         1imw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Y9iHfu2qJ1rYwaY6oWEzIs5Qx7zIs9SJRUxpbN3JEB8=;
        b=NMAH5lXvrr4Z0JzEo1yh3f4LjybB4QS5Z/I5ZPZoZKVumQWuvLCcxFKEDysnY6rzBm
         zcQXW7I8PR0togG0EvAU137qSbIb69C9+ziQp0D63VMHe/1UNEDe1IAC74Hh6rfo70T2
         G9wm2Dc77rsetxX0095R8k+scaulyDx28zA41oOZMrHKysMayR3Tl44aUc6vdeDet44y
         /L4fLmhxeCZHbD5O8MqF/CG+cROHYlguNr1Y42G30Dve0NCeD9iJi81JKQplD2gbYBGY
         3jqIzn+D3LrygCKvXShoo7iXb0ZIuTuzBeQrECDJS02Ry+gBV2ZLhiea2R5aYSe9XHrK
         3nHA==
X-Gm-Message-State: APjAAAU/EuhHj76tpdUtdB/UHM8pjm5fToGIvVyQkzLt2YDZd6s1PaMd
        iwtolDPRIg/3lflXG3c9TYo=
X-Google-Smtp-Source: APXvYqyyicB7efzPVK+/7Ooco8a4mIzx65nBETaaJK1+Y3WNcpNuYgwk98J6WD47WIYOExkZ7I+VTw==
X-Received: by 2002:a7b:cc19:: with SMTP id f25mr11904064wmh.8.1553682293659;
        Wed, 27 Mar 2019 03:24:53 -0700 (PDT)
Received: from szeder.dev (x4d0c7b09.dyn.telefonica.de. [77.12.123.9])
        by smtp.gmail.com with ESMTPSA id o12sm6413988wrx.92.2019.03.27.03.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 03:24:52 -0700 (PDT)
Date:   Wed, 27 Mar 2019 11:24:51 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 3/5] progress: assemble percentage and counters in a
 strbuf before printing
Message-ID: <20190327102451.GC32732@szeder.dev>
References: <20190325103844.26749-1-szeder.dev@gmail.com>
 <20190325103844.26749-4-szeder.dev@gmail.com>
 <20190326054541.GD1933@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190326054541.GD1933@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 01:45:41AM -0400, Jeff King wrote:
> On Mon, Mar 25, 2019 at 11:38:42AM +0100, SZEDER Gábor wrote:
> 
> > The following patches in this series want to handle the progress bar's
> > title and changing parts (i.e. the counter and the optional percentage
> > and throughput combined) differently.
> > 
> > To prepare for those changes assemble the changing parts in a separate
> > strbuf before printing.
> 
> Makes sense. Unlike the previous patch, we're already in the "slow path"
> of the function here, so we don't need to worry about adding an extra
> buffer (though do still think it's worth reusing the same buffer each
> time, as you do here).

The commit message doesn't mention this, but the next patch needs the
length of the previously displayed progress bar to properly clean up
its remnants.  Or the length of its changing parts anyway.  So I could
either add a 'prev_len' field to 'struct progress', or the whole
strbuf.  The strbuf containing the throughput is already stored in
there and reused, so I just followed suit.

