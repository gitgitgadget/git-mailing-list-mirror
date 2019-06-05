Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90C1E1F462
	for <e@80x24.org>; Wed,  5 Jun 2019 20:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfFEUUW (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 16:20:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46351 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfFEUUW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 16:20:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id y11so15472133pfm.13
        for <git@vger.kernel.org>; Wed, 05 Jun 2019 13:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3QKPV+rE9kpX6rgTU5pmG/0LqnM/2CdZQt2C+yhwfPI=;
        b=IcNNKIRfLqnH+bR6teP+fe8GtxbRaL3y86rIQV2xZkKu1ftA28L4moRgIl8QTKXc0D
         WCLasrS102XChisS/9+8t2zBuMrkZQ3bWD0pS9uSQWaFidkDkCHDfHCgrJe3MPISr+EM
         OagNVSRkkP6MWrD7sx1DA5jf6rvx2GffOxq//pYpN9EfYgEUw3Y1PB/HpRmhoaDTS35s
         XHHjx3NDsTASjHow8Bdk1LzksQdqlW/+LpQzJ+0HjAaWpMXnIiq7VI25Pnl1GUpk7xXE
         lGdF5a4kij0mzylroMn3DZF9BfogzKOr/kxJRXVdSiAt3yCmICAVbf1jDwPuZxB8U3xm
         DfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3QKPV+rE9kpX6rgTU5pmG/0LqnM/2CdZQt2C+yhwfPI=;
        b=gy0sUvJnLjnTKiZXoSTtyokcHmqvCCDzy17VNEkli/bVPQ9tkaGZfC/mJ6o386mhwG
         0ZWjNbtG14152EA/4yolAkHCkgCAPqsZ9SHq3gT815jLEodl/qaE3mpk4EKREtkPvMrP
         u9XjBxPF2/jSq66bwR1IIUAlbCMiuvvM1k0jKymEUEYCuU+7ITbyCFhHDbRv26SaFfLo
         kUQ8jCFnqnYEHr3Iz7k07L2MOOgjw9+evuHKowJ5eCseph7uVf5o6dHbTzA9bo+ZoQp2
         A0nS9iMo6eXnZiDQsb4u2itIbQH+NKiX4JwNNw+XecjhlsW1iQxjup8ivXy8KZD2bqm2
         hkbQ==
X-Gm-Message-State: APjAAAXeh7lBBPulCRvZhZP4VDtErdw0CaBjNblUc+lUqswGB8bB4zsK
        icGKjRYrOSIF0xcf5peo62rnCA==
X-Google-Smtp-Source: APXvYqzsbxeOlcYfrUu5sJt3oPQ3Zbe1kI5q7a2JVvSke7cFgBljnJMnrkz/o7N5g2kooPA6CEFBww==
X-Received: by 2002:a63:4d5d:: with SMTP id n29mr726920pgl.235.1559766021703;
        Wed, 05 Jun 2019 13:20:21 -0700 (PDT)
Received: from localhost ([205.175.106.159])
        by smtp.gmail.com with ESMTPSA id 140sm27459241pfw.123.2019.06.05.13.20.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 13:20:20 -0700 (PDT)
Date:   Wed, 5 Jun 2019 13:20:19 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stephan Beyer <s-beyer@gmx.net>, Taylor Blau <me@ttaylorr.com>,
        Patryk Obara <patryk.obara@gmail.com>
Subject: Re: [PATCH] clang-format: use git grep to generate the ForEachMacros
 list
Message-ID: <20190605202019.GA84760@D-10-18-172-221.dhcp4.washington.edu>
References: <20190603224814.GA15851@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603224814.GA15851@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miguel,

On Tue, Jun 04, 2019 at 12:48:14AM +0200, Miguel Ojeda wrote:
> The ForEachMacros list can reasonably be generated grepping
> the C source code for macros with 'for_each' in their name.
>
> Taken almost verbatim from the .clang-format file in the Linux kernel.
>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Thanks for CC-ing me on this. I suspect that it was because I show up
somewhere recently in the blame for 'git grep' (I believe I worked on
adding `-o` about a year ago).

You 'git grep' usage of course looks correct, so this patch looks good
to me, too.

Thanks,
Taylor
