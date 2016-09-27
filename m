Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A33D020986
	for <e@80x24.org>; Tue, 27 Sep 2016 19:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933931AbcI0TZn (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 15:25:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:49035 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933380AbcI0TZn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 15:25:43 -0400
Received: (qmail 3923 invoked by uid 109); 27 Sep 2016 19:25:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 19:25:42 +0000
Received: (qmail 19086 invoked by uid 111); 27 Sep 2016 19:25:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 15:25:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Sep 2016 15:25:40 -0400
Date:   Tue, 27 Sep 2016 15:25:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [Q] would it be bad to make /etc/gitconfig runtime configurable?
Message-ID: <20160927192539.ybooc34iodnzs2ab@sigill.intra.peff.net>
References: <xmqqoa39p926.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqoa39p926.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 27, 2016 at 10:05:37AM -0700, Junio C Hamano wrote:

> The subject says it all.  Would it be bad if we introduce an
> environment variable, GIT_SYSTEM_CONFIG=/etc/gitconfig, that names
> an alternative location of the system-wide configuration file?
> 
> That would supersede/deprecate GIT_CONFIG_NOSYSTEM that we
> introduced primarily so that we can run our tests without getting
> affected by the configuration that happens to be effective on the
> host that the test is being run.

I can't think of a reason it would be bad. There shouldn't be a security
question, as controlling the environment already lets you run arbitrary
code, override system config variables, etc.

I know when I was writing the tests for 0d44a2d (config: return
configset value for current_config_ functions, 2016-05-26) I had to omit
the "system" case, because we had no way of pointing at a specific file.
So I do not know whether a runtime system config variable would be
useful for users, but it would definitely make testing easier.

-Peff
