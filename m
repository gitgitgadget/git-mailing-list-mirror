Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C206F20986
	for <e@80x24.org>; Fri, 21 Oct 2016 10:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932162AbcJUKlM (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 06:41:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:60556 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754266AbcJUKlK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 06:41:10 -0400
Received: (qmail 17396 invoked by uid 109); 21 Oct 2016 10:41:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Oct 2016 10:41:09 +0000
Received: (qmail 1865 invoked by uid 111); 21 Oct 2016 10:41:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Oct 2016 06:41:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Oct 2016 06:41:07 -0400
Date:   Fri, 21 Oct 2016 06:41:07 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Subject: [PATCH 0/3] fix travis TAP/--verbose conflict
Message-ID: <20161021104107.vh3bjx6x6pd6izat@sigill.intra.peff.net>
References: <D9C1E13F-88A2-483E-A549-1C2294EACFEB@gmail.com>
 <CAGZ79kZo3LdcRmrjQTAvgx=H6U2tdjASK3qv5A2K5J2HQ2NvSw@mail.gmail.com>
 <20161021082035.xad6wfny5i6wtshh@sigill.intra.peff.net>
 <20161021084348.dp4jfpfownodl7nz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161021084348.dp4jfpfownodl7nz@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 04:43:48AM -0400, Jeff King wrote:

> The obvious fix would be to send "--verbose" output to stderr, but I
> suspect that would end up annoying for people who do:
> 
>   ./t5547-push-quarantine.sh -v | less
> 
> to read long output. Probably we need some option like "--log" which
> logs in the same way that "--tee" does, but _without_ sending the data
> to stdout. Naively, that just means replacing the "tee" invocation with
> "cat", but I suspect it will be a lot more complicated than that,
> because we still need to let the TAP output go to stdout.

Yeah, it was definitely a lot more complicated. This patch series fixes
it.

  [1/3]: test-lib: handle TEST_OUTPUT_DIRECTORY with spaces
  [2/3]: test-lib: add --verbose-log option
  [3/3]: travis: use --verbose-log test option

 .travis.yml   |  2 +-
 t/README      |  6 ++++++
 t/test-lib.sh | 24 ++++++++++++++++++++----
 3 files changed, 27 insertions(+), 5 deletions(-)

-Peff
