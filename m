Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 799961F406
	for <e@80x24.org>; Wed,  3 Jan 2018 22:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751066AbeACWo7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 17:44:59 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:44192 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbeACWo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 17:44:57 -0500
Received: by mail-wm0-f42.google.com with SMTP id t8so379442wmc.3
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 14:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shabtay.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7qXv4OLxcwMSMRTpJ5SUzRoo6wTnsu1t2soaF3651nc=;
        b=Ewu00cbIKl5AUcVvB21Jz+6N/iUk9dCmC6lucD08l4YHk4/wKWRkIW+5lcKR7VPAHk
         CnRnohDZpnPhHF2CLLU2Dl2k/0Y3Z/FK6pEJxXyetgL6HDsgy/sQc1INVb7yxN34xrFY
         qf5vc/n6FzVVD8OYYNgjMwaS3p61l20gwzwbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7qXv4OLxcwMSMRTpJ5SUzRoo6wTnsu1t2soaF3651nc=;
        b=Ut95ucEDtUoOxkYssC2Plfs1lnxvfimYgUl4D77t9OylZGDW13OkR+CWEVRHesuqSD
         74A4YyJaejk/QOa4F/CXzvv+ca88QKn+L49JGmw4vFMhzmYaqZP9jdSIzKzYVUwjc2Im
         FH2y34i5CjVpgoL87Ch44+BxZWvFSprTuMgwtv+svaKsgmIvaCIrkBOIUh8p6vJd9lMq
         p/qdY8+1IvNyM7P9T+njqNx2rbi99k8//uDm/EPMABsuDbsEeOvR37khvg8hF1VpOeVM
         C487COB6X0kmjSRe6bZEza3LOV4FoeYzbr4cP2t1aXXtLaxBVVh87ofva8rw8OWfsgQs
         SnGw==
X-Gm-Message-State: AKGB3mLj7ylyVHAAgyPMCJ9YRuKH+agvCz6er98R89ywU+khhNdWJbDf
        n/rVq9VuRuWzQ0bQ6U3S47eXNmpOmb3Q2dc05txXKg==
X-Google-Smtp-Source: ACJfBov+H0rdNvds5DAGApbEcxXY7pNAzKGYlvQtXGI4AtaoLA8Lx/uNOSSG09a6yB7mQBrIFMPlUrMA8cREFh2s0ho=
X-Received: by 10.80.171.89 with SMTP id t25mr4496320edc.224.1515019496395;
 Wed, 03 Jan 2018 14:44:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.170.203 with HTTP; Wed, 3 Jan 2018 14:44:16 -0800 (PST)
In-Reply-To: <20180103222821.GA32287@sigill.intra.peff.net>
References: <CAK2k7nSsygwRj_Hhrz7-qXZ8UBB=O+deOeC2FFTkrGmWSUpKqA@mail.gmail.com>
 <20180103222821.GA32287@sigill.intra.peff.net>
From:   Isaac Shabtay <isaac@shabtay.com>
Date:   Wed, 3 Jan 2018 14:44:16 -0800
Message-ID: <CAK2k7nRdk5qBp6Xzud-GS7YeSpchrQoOdqRd-3uXVeWZ1xsnVg@mail.gmail.com>
Subject: Re: Bug report: git clone with dest
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Indeed interesting... this one's for the books...
Thanks for the patches. Any idea when these are going to make it to
the official Git client builds? (specifically the Windows one)

On 3 January 2018 at 14:28, Jeff King <peff@peff.net> wrote:
> On Wed, Jan 03, 2018 at 12:59:48PM -0800, Isaac Shabtay wrote:
>
>> Target directory is deleted on clone failures.
>>
>> Steps to reproduce, for example on Windows:
>>
>> cd /d %TEMP%
>> mkdir dest
>> git clone https://some-fake-url/whatever-makes-git-clone-fail dest
>>
>> Of course, the clone will fail as it should. But looks like the Git
>> client also ends up deleting the "dest" directory.
>
> Interesting. AFAICT Git has behaved this way for almost 9 years, and now
> we have two reports in two days. Serendipity, or did something else
> change? :)
>
> Anyway, you might be interested in the patch series I posted yesterday:
>
>   https://public-inbox.org/git/20180102210753.GA10430@sigill.intra.peff.net/
>
> -Peff
