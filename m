Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 840601F406
	for <e@80x24.org>; Fri, 12 Jan 2018 13:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933308AbeALNF5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 08:05:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:42024 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932797AbeALNF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 08:05:56 -0500
Received: (qmail 3034 invoked by uid 109); 12 Jan 2018 13:05:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 12 Jan 2018 13:05:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30525 invoked by uid 111); 12 Jan 2018 13:06:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 12 Jan 2018 08:06:30 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jan 2018 08:05:54 -0500
Date:   Fri, 12 Jan 2018 08:05:54 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 2/4] trace.c: print program 'git' when
 child_process.git_cmd is set
Message-ID: <20180112130554.GC27499@sigill.intra.peff.net>
References: <20180111094712.2551-1-pclouds@gmail.com>
 <20180112095607.18293-1-pclouds@gmail.com>
 <20180112095607.18293-3-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180112095607.18293-3-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 12, 2018 at 04:56:05PM +0700, Nguyễn Thái Ngọc Duy wrote:

> We normally print full command line, including the program and its
> argument. When git_cmd is set, we have a special code path to run the
> right "git" program and child_process.argv[0] will not contain the
> program name anymore. As a result, we print just the command
> arguments.
> 
> I thought it was a regression when the code was refactored and git_cmd
> added, but apparently it's not. git_cmd mode was introduced before
> tracing was added in 8852f5d704 (run_command(): respect GIT_TRACE -
> 2008-07-07) so it's more like an oversight in 8852f5d704.
> 
> Fix it, print the program name "git" in git_cmd mode. It's nice to have
> now. But it will be more important later when we start to print env
> variables too, in shell syntax. The lack of a program name would look
> confusing then.

Makes sense. Note that "git" isn't quoted here, but the rest of the
arguments are. More on that in a minute. :)

-Peff
