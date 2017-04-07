Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E110520966
	for <e@80x24.org>; Fri,  7 Apr 2017 16:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934299AbdDGQzI (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 12:55:08 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35925 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933435AbdDGQzG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 12:55:06 -0400
Received: by mail-pg0-f42.google.com with SMTP id g2so70733118pge.3
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 09:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LXKVZuhqjfNfFdS0mhTB8XPSXvX4PfMX/685n0JFA+s=;
        b=oyvsExPXzphiTlDmdEdnXE0wPhAVaypwMaDFkoNhLlRBqi42jOdt9voKzv5DxTTdrT
         G0TBF8Z8oz/2xTYdI76+xt5yGXxGiur3MTI1p9Q+vyic1ynoNoGAGS550MV3fu4CyVFu
         mwae2zxWeFwbKeXrBIZBVFySs9IR0jA9gaUwefckKwPkF4pdHHWKamCRLCbuYmIf6r1M
         tySwU6z0wbl4bKJZqYU2EAkvBiFen0HlP7pIVRhAo78XDkO1G4bJOae4LLsF0fbcx0zq
         i5U+cZRDgP4i232i39JsmxGkGXWFLuoDwY1vSbi4aSKYU+3owjlPQ0rit55BDCAWsE8k
         gyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LXKVZuhqjfNfFdS0mhTB8XPSXvX4PfMX/685n0JFA+s=;
        b=AvRjhd9cFaL6ErEouFCXFrP5M3y2j6AMD9/3k2OTVEXkDXMWob0y4JmorGvsrYnRyW
         dMDM+vCMV/wj3JdMGieKJ+oWakjLkNzZrRr60pDib7d09LQ9C9kD1Xgd3OFa9BSLP7zV
         0Ce7e7TysR8pOkBc55jQf4eFLUUsDJaFeYC/mqgk1P/X02gwuB4vaMrLBEGQsKlxHCX9
         kEkR4fwR3tvzZ2CIt2CrivNcQS5sZGS9Prk9LhagAi2LsVSz5bYviGxrb/m33hTFwMSC
         BCIOzZ1jb7uRiPKeWzBoYgmLswAeGtRXlCTUEBMA+J5K5/RjTNXho/fNZmIVOAV1Mpvv
         +2eg==
X-Gm-Message-State: AFeK/H1QlDMGmYA70fzKiadkKyPNUhHWUMBvHKAJMfd+17A1cQ/bFPgbweAK7gcjZyhP1tLBMjQvayRPSb1+9OB6
X-Received: by 10.84.241.134 with SMTP id b6mr10599613pll.107.1491584106231;
 Fri, 07 Apr 2017 09:55:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.239 with HTTP; Fri, 7 Apr 2017 09:55:05 -0700 (PDT)
In-Reply-To: <20170407165314.GB142670@google.com>
References: <9e3af7d6-a2c1-2673-53cc-d4c5105d9051@durchholz.org>
 <20170407063057.yjbqavu4uiipslpc@sigill.intra.peff.net> <20170407165314.GB142670@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 7 Apr 2017 09:55:05 -0700
Message-ID: <CAGZ79ka7PEWy2iA8V9s11n2kyD=vHyS2y1K3SJzDq-5HsY7how@mail.gmail.com>
Subject: Re: problem with backslash in directory name
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>, Joachim Durchholz <jo@durchholz.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> Probably it's "read" which does backslash expansion, but nothing else.
>> Just grepping git-submodule.sh, some of the "read" calls should probably
>> be "read -r" (I also don't know how some of those loops would cope with
>> a submodule name that needed quoting).
>
> So I blindly converted all "read" calls to "read -r" and tested against
> the case Joachim ran into and it seems to solve the issues.  All test
> still pass too (though that may not mean too much).

... because we may not have tests with weird names in submodule path.
Thanks for the conversion!

Stefan
