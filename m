Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 726B020A26
	for <e@80x24.org>; Tue, 26 Sep 2017 00:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935611AbdIZA2J (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 20:28:09 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:51104 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934198AbdIZA2I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 20:28:08 -0400
Received: by mail-pf0-f172.google.com with SMTP id m63so4674176pfk.7
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 17:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MavkN1ej1/VBzTood+r0ekD2E8WeYD5hXCRM38zMaLM=;
        b=ZyX/qJWcsIRdRka2JMDfggNQ9a2FAZ5v+QZxvmSoH60yRhpHcfv+ZOVzdKp4ST0zts
         gNDkLiEMyLQ/NT+tsr+T+NLbs14YTgPuWEFCzNRq+z+971NAIxluNLKlo8kYAj5utT9b
         YuO16C1jIBJAOLS5Tn7hi/k6F/OCRoSlDonLO6J/EYwXBX5PXTUT+cknwKkOAKHtGnmd
         xKnlWU9uRS8BRW48uDuUpB2wz1Am5IaUnWOkaYMimkhyZ8Dv+73rrfJSarunmeVkLQ55
         ovIDAm1yWlAxJv5w329nrILBJ11JX131mFulXukaFxAKj+aZIrN5P1Wv+0/dEb4OY9M4
         3W+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MavkN1ej1/VBzTood+r0ekD2E8WeYD5hXCRM38zMaLM=;
        b=pXIxjg2Br0OUSCVLM/SjlNL+LZTy7XDhOE+UAo/NGJ0mYmmFeRgpFPoo/BNML2wsuY
         1FdmD/ittrkR7uTLcwQKRJAPLPozVrJwe/W9/HgYBm0Bj1qp+Rz7pwvEGoteD0kuJgM9
         ZWeTQeOkNY1rSfPSwsnSwymbfHaOosnWYr53lzTmyHSBBoY74RLqAmjHbiNEJno+JnHe
         ZQfaOtQN/J8i02Zj/RgQc8//0sG+a4TfOjKEH435Xn21RO6B/7KMeNQZ8wax0wcopSTm
         jXGIhJWy64LzUWf1qo4UVefnoIuJM0rXGv57geBLBayT+/Afw0vs8v3brdeeceHurcKC
         MrFg==
X-Gm-Message-State: AHPjjUjT+ATp1U6asE8wfb3kD4cMdCBuhumc9uq4UbKgmHEmjlW61fR4
        UCFb3FsUkVptbpb2IIzS48k=
X-Google-Smtp-Source: AOwi7QCekJYRtBL9dN78Y6r3jwe9fSpVmdssfgHlULMGHmyikeqsdkdZ3r5V+Gm3K5tbE/SlsvBjYg==
X-Received: by 10.159.244.132 with SMTP id y4mr9249318plr.354.1506385687794;
        Mon, 25 Sep 2017 17:28:07 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:b5cd:5017:828c:d0cb])
        by smtp.gmail.com with ESMTPSA id o5sm12905620pfh.67.2017.09.25.17.28.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 17:28:07 -0700 (PDT)
Date:   Mon, 25 Sep 2017 17:28:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/7] read_in_full: reset errno before reading
Message-ID: <20170926002805.GS27425@aiede.mtv.corp.google.com>
References: <20170925232313.hhtqpxuzpzbnbdop@sigill.intra.peff.net>
 <20170925233316.GI27425@aiede.mtv.corp.google.com>
 <20170925233732.4lqavl56qwpfjuxy@sigill.intra.peff.net>
 <20170925234541.l6qcislhfwtnxf5m@sigill.intra.peff.net>
 <20170925235510.GL27425@aiede.mtv.corp.google.com>
 <20170926000117.y3solltovyueq3zc@sigill.intra.peff.net>
 <20170926001354.GN27425@aiede.mtv.corp.google.com>
 <20170926001724.cxuwsdadjbqqmnig@sigill.intra.peff.net>
 <20170926002020.GQ27425@aiede.mtv.corp.google.com>
 <20170926002510.xmusj6fkvb25fm5w@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170926002510.xmusj6fkvb25fm5w@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> What do you think of patch 7 in light of this? If the short-read case
> gives us a sane errno, should we even bother trying to consistently
> handle its error separately?

I like the read_exactly_or_die variant because it makes callers more
concise, but on the other hand a caller handling the error can write a
more meaningful error message with the right amount of context.

So I think you're right that it's better to drop patch 7.

Thanks,
Jonathan
