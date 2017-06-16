Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C0C520282
	for <e@80x24.org>; Fri, 16 Jun 2017 10:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbdFPKug (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 06:50:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:41411 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752447AbdFPKuf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 06:50:35 -0400
Received: (qmail 10371 invoked by uid 109); 16 Jun 2017 10:50:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jun 2017 10:50:34 +0000
Received: (qmail 3318 invoked by uid 111); 16 Jun 2017 10:50:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jun 2017 06:50:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Jun 2017 06:50:32 -0400
Date:   Fri, 16 Jun 2017 06:50:32 -0400
From:   Jeff King <peff@peff.net>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Samuel Lijin <sxlijin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] wt-status.c: Modified status message shown for a
 parent-less branch
Message-ID: <20170616105032.rjmmql56ifol34mk@sigill.intra.peff.net>
References: <1497255003.1718.1.camel@gmail.com>
 <xmqqa85dnjpz.fsf@gitster.mtv.corp.google.com>
 <20170612212025.ytyukvmmthfcsejh@sigill.intra.peff.net>
 <xmqqshj4nb9u.fsf@gitster.mtv.corp.google.com>
 <20170612213759.f2scl3r46vboolna@sigill.intra.peff.net>
 <1497514760.2394.6.camel@gmail.com>
 <20170615084248.elfsh4of5qdsk3pa@sigill.intra.peff.net>
 <CAJZjrdXXGb-QrvJW9JusPT597QDnQD_shzVJq-5GN=hZCBJYeA@mail.gmail.com>
 <20170615131245.zh5nuipmaadcfpdx@sigill.intra.peff.net>
 <1497609408.2517.4.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1497609408.2517.4.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2017 at 04:06:48PM +0530, Kaartic Sivaraam wrote:

> From what I could get from this thread, I guess the current patch
> stands something like the one below. I tried building it with the below
> change, it seems to be having a little issue. I'm not sure why, it
> seems to be working the other way round i.e., the message "No commits
> yet on the branch" message is shown in the commit template and the
> message "Initial commit" is shown when `git status` is invoked.
> 
> Also, let me know if any other change is required.
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 1d805f5da..3ed8e40bc 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1364,6 +1364,7 @@ int cmd_status(int argc, const char **argv, const
> char *prefix)
>                 usage_with_options(builtin_status_usage,
> builtin_status_options);
>  
>         status_init_config(&s, git_status_config);
> +       s.commit_template = 1;
>         argc = parse_options(argc, argv, prefix,
>                              builtin_status_options,
>                              builtin_status_usage, 0);

Wouldn't you want this in cmd_commit(), not cmd_status()?

-Peff
