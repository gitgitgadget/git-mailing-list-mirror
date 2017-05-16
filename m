Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C21D51FAA8
	for <e@80x24.org>; Tue, 16 May 2017 17:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbdEPRhL (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 13:37:11 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34064 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbdEPRhK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 13:37:10 -0400
Received: by mail-pg0-f41.google.com with SMTP id u28so79776202pgn.1
        for <git@vger.kernel.org>; Tue, 16 May 2017 10:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8vcpRVR+fci1fWgma12owEbD5hrDb5Y2GUYLxRDYslA=;
        b=p1o/m3miTT7t81Z+OZVCXdPXrSKPXDRW1oz4DF3xF4HJLynaCKqtTxLDcZvVASBq2R
         2y4JMt1xSX6fiyNSA+wLDhq+xFcGdZ+VQRZx1Tgy1cEVd3R5PJMyJwE8lQcbm7fX7qOJ
         9nY5nmzgZUdLgS9AUQv9BGBDfrtFb/PeLJmvBEk/cOoYAI3SZS1miSV3X+epsz7mrC5j
         ObjgGLHbjvABpMbTVxAlmCYtGRzWxibnH2B7ngvJLBi0zaRq5YK5XqDULPP4cwC5bEEG
         xZclNRq//6TEo7LYD+ue7l6TbuP/KP0SgG7jhP3KHFmL33f/J4hLDiX14NJRJB1sCvmV
         f43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8vcpRVR+fci1fWgma12owEbD5hrDb5Y2GUYLxRDYslA=;
        b=i+yY7zm92Ad1IK71h02wIy4UQ7y8Uhi2ciokkzasqfIPnAx2KYA7nNY0a9IRnkF2nO
         HH9gKiOUjK3cfzKHwvCg5B4meiE3bJ9dj50NslX9U4sag9nfJWsU6zMFo73We21QpxSV
         osvTGJHweTLtI3xo/3UVUtlJMxOpO9YNf0JXVtvgdRw+hCgAluCYq/mLH4SrU4znCdWh
         CPPFo6UkAihhLFdchTWlyfMN7ncwvclXvBSYKNbXZpE+OwO0Yo0yODdWZMzaAjkvXW5+
         x2c4BDOZci1Tb8nqa+MYZBFJ1xxwhn2txjIno3KLApkTxdvAhqhjMXbRWIRoB6U5da/p
         clpQ==
X-Gm-Message-State: AODbwcDD7i0xY3hYyKnhRq0bo5A0mj/Q0jCJphd8SZptOrRDyUaZHor7
        NiFy40Fh3H+ZTMK0rf8=
X-Received: by 10.99.150.1 with SMTP id c1mr2494455pge.160.1494956229979;
        Tue, 16 May 2017 10:37:09 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:cd47:ccb1:c55d:4b70])
        by smtp.gmail.com with ESMTPSA id s3sm37929583pgn.29.2017.05.16.10.37.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 10:37:09 -0700 (PDT)
Date:   Tue, 16 May 2017 10:37:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Rannaud <eric.rannaud@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeremy Serror <jeremy.serror@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: git rebase regression: cannot pass a shell expression directly
 to --exec
Message-ID: <20170516173707.GP27400@aiede.svl.corp.google.com>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
 <20170516032503.bzkxmtqpmppxgi75@sigill.intra.peff.net>
 <20170516033736.23cfkouus3p67vhc@sigill.intra.peff.net>
 <20170516164124.GO27400@aiede.svl.corp.google.com>
 <20170516164750.3tw6xlbcbyuu5t72@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170516164750.3tw6xlbcbyuu5t72@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
>>> On Mon, May 15, 2017 at 11:25:03PM -0400, Jeff King wrote:

>>>> One hack would be to look for BASH_FUNC_* in the environment and disable
>>>> the optimization in that case. I think that would make your case Just
>>>> Work. It doesn't help other oddball cases, like:
[...]
>> Hm.  execvp explicitly does this when it hits ENOEXEC, but not for
>> ENOENT.  Do you know why that is?
>
> When execvp(foo) falls back on ENOEXEC, it is not running "sh -c foo".
> It is actually running "sh foo" to run the script contents.

Oh --- now I get it.  This is about the optimization to bypass the shell
in prepare_shell_command.  It has nothing to do with execvp --- our
execvp emulation already does the right thing, and Brandon's patches
did not make this problem any worse or better.

Unconditionally falling back to sh -c when we get ENOENT in the
RUN_USING_SHELL case makes sense to me.

Sorry for the confusion,
Jonathan
