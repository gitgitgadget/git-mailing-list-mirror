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
	by dcvr.yhbt.net (Postfix) with ESMTP id D530A1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 18:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfBHSdL (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 13:33:11 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40149 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfBHSdL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 13:33:11 -0500
Received: by mail-wm1-f65.google.com with SMTP id q21so4651811wmc.5
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 10:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tnRuNODxaJb/tzr1W9D7ltF3PeclRLbMePaRgWuKpww=;
        b=V5SZiJc1ugEyQ3jwKxI/lNECh/ywXDnc4SpFV4tV7jZ9ErNxLiYdWELK7GPwcdGTTU
         tt2bRb/16eCJNiPWOV3z+uGnR2o+QVYmbAKWBGZXLk+CT0B0VJCYi8aYZKypw5OX6TMP
         tuUwkb1+ETou0w1vR+Q0L8+/jk00Ul8TB2fmHPCFr4lBsAFKFgUwQkyVaSKdOTaaHDSB
         3BCgCb68L3E/nuRDJznYRSRi3ILgFt62iFfOeukqFxl6FWOs4tRPp22GTH6NqsQPaA37
         fnGzGagqR0DpqNscYQZv3VkH9XT5YrlQ5ZeWTlEY8kmp6vF5RIZiaM31s8MpG+NgiH3x
         /JVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tnRuNODxaJb/tzr1W9D7ltF3PeclRLbMePaRgWuKpww=;
        b=n9DpSVbBM6yYSudDwi8bIsp+89DhLoyK2oe41MGJwMUsOI1wukk+tXJ9vU+UgfUUCu
         NwR2008NR30kf0dRL8ENYs6AVSMS8Wif8wD2di8K78qXfDkYz/KJ6CB89f7/m/b/k4+Z
         +B744EVjNAXAJ3csw/MeWVDgE97qtYthQB/OMH22r+R/uLEonI7e8h81odXLUwK9Gxjt
         zlE2JXAbYC4ay3W9rshf/PeTSzmUMXW4fINJs+0F2ZVxvWu7HOVG+xn7OVUqFGVby1CD
         ZjSbWKfO4oZBzQtaBLpoay1gajAj/rU/jFBn/koWXSfq6o2GOOmOjFiV1bwu766ZI92/
         9X0A==
X-Gm-Message-State: AHQUAuakqRhuY0DLpyvpyOkQeyUFJB+srwp33aycLb4kG0OzI++dU39b
        8Ekig4mjACc9pyzPGTu6QaHJif3c
X-Google-Smtp-Source: AHgI3IYQXXPBaWayYqS5CovJd7zRh/ibMaqY9lDIl23tO9mYvLpmututYkOQF/mx2V3EjwWRkbinoQ==
X-Received: by 2002:a5d:56d2:: with SMTP id m18mr13237325wrw.113.1549650789982;
        Fri, 08 Feb 2019 10:33:09 -0800 (PST)
Received: from szeder.dev (x4db62aaa.dyn.telefonica.de. [77.182.42.170])
        by smtp.gmail.com with ESMTPSA id a8sm6636950wme.23.2019.02.08.10.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 10:33:09 -0800 (PST)
Date:   Fri, 8 Feb 2019 19:33:07 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: make '--stress' more bisect-friendly
Message-ID: <20190208183307.GZ10587@szeder.dev>
References: <20190208115045.13256-1-szeder.dev@gmail.com>
 <20190208164732.GA23461@sigill.intra.peff.net>
 <20190208164937.GB23461@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190208164937.GB23461@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 11:49:37AM -0500, Jeff King wrote:
>   One other thing I've noticed with it: I forget to add my custom
>   --root=/var/ram/git-tests when I invoke it, so my hard disk goes
>   crazy (and the tests often run slower!). I'm not sure if there's a
>   convenient fix.

OTOH, that could introduce more variance in the timing of the test's
commands, thus potentially increasing the chances of a failure.  I
dunno.

Maybe ./t1234-foo.sh should learn to respect DEFAULT_TEST_OPTS
somehow?

