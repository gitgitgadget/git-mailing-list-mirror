Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8755B20C11
	for <e@80x24.org>; Fri,  1 Dec 2017 03:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbdLADxo (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 22:53:44 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:39703 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbdLADxn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 22:53:43 -0500
Received: by mail-it0-f42.google.com with SMTP id 68so1031249ite.4
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 19:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2lbz+FNy5Tj1Rb4pyu5YzTZs/rnZAmZ13LG1Iva1G7g=;
        b=ZfDkGDzMVNC6yLamQMn5uihUi0ABR6JcFc7LTENK9cmnAbbFTylDAk/PRL+9HRMzKm
         Cv1qL+NWcAES0YwgeAeEDj12VYnhZShyVpMLKXT0DctNKShLPxvhp1WKOuz6HveowN8a
         YwepfyVtu2OSad1frEwIxTXzhtsUZWA8XHKGTfOUkx6uxfbHbiSUKmCQ7FgC7JTag1DI
         /WEV9ZiyLK3m8jjmIIil/if70rg2Ag3TG2T7Ve7O0MIozCvFDNIbPRtotSMQoLCcXSiU
         o3bkkBx5KcY77cxYJNVWczMYGM71qTA1APrps5bUDwRpBqMvkkmzTRKGD5/JDUsCgZ58
         fdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2lbz+FNy5Tj1Rb4pyu5YzTZs/rnZAmZ13LG1Iva1G7g=;
        b=BaU0yziPQ8vib/FAlxeCGuD6NfrXpHxm5yAJGwU/+N+ANlFvpjbcviyk3i2Lz/cRWA
         MudphbcHI1iu0lzJbSpVSNoRlLrBAaS/6AEJTrJanlwdTX9lxlAwkLfRuhlNUoc2kMX6
         PUHt6t9TYQiW2ngCzea/hTGOeBuRGMZ596AZrQt11ofoty6WqqdURRIBsPZD550P+oQN
         6NqvBGUiLW7w8ykOsutWmf3JpfZ6BGptkuGPLVPEcIIFjSams0uT+OkU6VanxSB6Ci4i
         IU/rZzqoxmf7Mmm+NOJ9y5oB6ktvEM3KL/6mMpnnJMO9vQ3XvVmOBA0EB38lai2u7hCF
         hF9Q==
X-Gm-Message-State: AKGB3mK4+HpZBb9xi8dsSgTCHTSqLhS4RWm+TlRBqWM5oP3MPHhIkFV5
        xdsFPXbTymW/5KgnCRDiCf49uwmX
X-Google-Smtp-Source: AGs4zMY0ttDJflz7+Z1Mh0Qv1rKHTKywuE8jFftsrSU+DQihWmZeH222aDxSRWF2PPLetzfuutAlOQ==
X-Received: by 10.36.19.81 with SMTP id 78mr167783itz.143.1512100422673;
        Thu, 30 Nov 2017 19:53:42 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id x16sm1553006ioi.62.2017.11.30.19.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2017 19:53:42 -0800 (PST)
Date:   Thu, 30 Nov 2017 19:53:40 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH 2/2] t/lib-git-svn.sh: improve svnserve tests with
 parallel make test
Message-ID: <20171201035340.GJ20640@aiede.mtv.corp.google.com>
References: <20171201023239.26153-1-tmz@pobox.com>
 <20171201023239.26153-3-tmz@pobox.com>
 <20171201030234.GF20640@aiede.mtv.corp.google.com>
 <20171201034519.GE3693@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171201034519.GE3693@zaya.teonanacatl.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger wrote:

> Much better, thank you.  How about this for the full commit message:
>
>    t/lib-git-svn.sh: improve svnserve tests with parallel make test
>
>    Setting SVNSERVE_PORT enables several tests which require a local
>    svnserve daemon to be run (in t9113 & t9126).  The tests share setup of
>    the local svnserve via `start_svnserve()`.  The function uses svnserve's
>    `--listen-once` option, which causes svnserve to accept one connection
>    on the port, serve it, and exit.  When running the tests in parallel
>    this fails if one test tries to start svnserve while the other is still
>    running.
>
>    Use the test number as the svnserve port (similar to httpd tests) to
>    avoid port conflicts.  Developers can set GIT_TEST_SVNSERVE to any value
>    other than 'false' or 'auto' to enable these tests.
>
> ?

Yep, with this description it is
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for putting up with my nits. :)

Jonathan
