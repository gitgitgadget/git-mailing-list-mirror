Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23D871FF6D
	for <e@80x24.org>; Thu, 15 Dec 2016 19:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754476AbcLOTHm (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 14:07:42 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33002 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754451AbcLOTHm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 14:07:42 -0500
Received: by mail-qk0-f171.google.com with SMTP id t184so13344471qkd.0
        for <git@vger.kernel.org>; Thu, 15 Dec 2016 11:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cNZ4YPQWr5qMXbqgGC9uYslkCDyatr9q6ZOyF/nEyNo=;
        b=LpsrA4znv7WQcOYj06nHsPBaYXCKTvy24YrqS1nK8Ft4l+26AUHVwwv0HLhdizerub
         kTn+vSuTR/grwv9aMX1vRLGCvCE3qjUAJkikdFhnNTFCWrfrxnpdQ3Lp7mY1Sl7G9o9n
         zn51NjjyYdO0hSNXCeqllSDkEIpJf8vwyQONkktljpVfcr21eVkNWHf6/KD1xcUduCPK
         elxzfu8LLCUYBllhyaT9Slv92GXVV+wcWSY1kjG9gp7+zGziSAj3ywbC+cTUaA8dfn39
         5WJAatucb8/5pbKXx7uU4kx5SQkSwr242YToqkXdx3QQ1IDzESeG6Djd3kxZBBLdoSQZ
         sk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cNZ4YPQWr5qMXbqgGC9uYslkCDyatr9q6ZOyF/nEyNo=;
        b=F2n5ehot2HNkfnQR+bbgyag7bK7oYDjJwsHt7cg9OFq+ZjbLuKJiOAP/1J5Nx+8TkE
         YKZVDPNxZoCH2BAnfPcYVQ4CcrIS4wbNKQgsnu0uLEQzYZ61i/po7JxQqWeo2N9lpLNK
         IlMoLARNU5zA4/2tM1i/4puAgPBhggSIyCoe1OvIOehVjAPwigYH0TszhqxMd8Ju32Ma
         y2GcCfSZAAxfRbW+5DYNRSfDD1ZlPQ8QqLOImK5LccWch86kq0f0PTw0xDqDrJ+D6p4Y
         WtKPknry8ZGeFfIPWfm7gNpCRBwwX8XLQjLKjDjEdM0Ww32S/AtGikTwZQutDvfpGYXS
         CTiw==
X-Gm-Message-State: AIkVDXLIDH1NGp+uxcoQ2vfxfWR0oKLTnIUdTX8GXfR712dfiuvCMvDJvj/WOhog/7iscEi8mb2jCLXOn5JsBAux
X-Received: by 10.55.105.129 with SMTP id e123mr2164726qkc.173.1481828854826;
 Thu, 15 Dec 2016 11:07:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Thu, 15 Dec 2016 11:07:34 -0800 (PST)
In-Reply-To: <20161215190351.as76panrcz5rgibj@sigill.intra.peff.net>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
 <cover.1481642927.git.johannes.schindelin@gmx.de> <ae521f75a105c6b9e54595d68bda3c5b62f313b6.1481642927.git.johannes.schindelin@gmx.de>
 <20161215190351.as76panrcz5rgibj@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 15 Dec 2016 11:07:34 -0800
Message-ID: <CAGZ79kZ3i-eoxMsVMsb+VBtEVQf2-Fovh_YM5NBN2pSOBHajBg@mail.gmail.com>
Subject: Re: [PATCH v2 07/34] sequencer (rebase -i): add support for the
 'fixup' and 'squash' commands
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 15, 2016 at 11:03 AM, Jeff King <peff@peff.net> wrote:
> wonder if it would be helpful to send that output to the list.

Sure we can try.

Another project I used to run through coverity (Gerrit), shows
similar characteristics w.r.t. false positives, so people complained
when I was force feeding them the niceties of static analysis.

I'll just try to set it up and see how the mailing list reacts.
(Not sure if you can just add emails there or if the email has
to be verified or such.)

Thanks,
Stefan
