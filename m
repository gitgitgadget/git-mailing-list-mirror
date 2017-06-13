Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B449720282
	for <e@80x24.org>; Tue, 13 Jun 2017 09:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbdFMJOz (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 05:14:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:38914 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751884AbdFMJOy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 05:14:54 -0400
Received: (qmail 20754 invoked by uid 109); 13 Jun 2017 09:14:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jun 2017 09:14:54 +0000
Received: (qmail 21876 invoked by uid 111); 13 Jun 2017 09:14:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jun 2017 05:14:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Jun 2017 05:14:52 -0400
Date:   Tue, 13 Jun 2017 05:14:52 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG?] gitlink without .gitmodules no longer fails recursive
 clone
Message-ID: <20170613091452.ew2rwx5r6axxo65p@sigill.intra.peff.net>
References: <20170606035650.oykbz2uc4xkr3cr2@sigill.intra.peff.net>
 <CAGZ79kY-uzardfOvrJufatYgU9bqx4XZMU_GFq5zwc-vtzM-3Q@mail.gmail.com>
 <20170606181024.GA189073@google.com>
 <20170606183914.6iowfhimo5yrvmtf@sigill.intra.peff.net>
 <20170609231935.ysolxkiuhhpa3xrd@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170609231935.ysolxkiuhhpa3xrd@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 09, 2017 at 07:19:35PM -0400, Jeff King wrote:

> Should "git add" check whether there's a matching .gitmodules entry for
> the path and issue a warning otherwise?

Here's my attempt at that.

  [1/2]: add: warn when adding an embedded repository
  [2/2]: t: move "git add submodule" into test blocks

 Documentation/config.txt                     |  3 ++
 Documentation/git-add.txt                    |  7 +++++
 advice.c                                     |  2 ++
 advice.h                                     |  1 +
 builtin/add.c                                | 45 +++++++++++++++++++++++++++-
 git-submodule.sh                             |  5 ++--
 t/t4041-diff-submodule-option.sh             |  8 +++--
 t/t4060-diff-submodule-option-diff-format.sh |  8 +++--
 t/t7401-submodule-summary.sh                 |  8 +++--
 t/t7414-submodule-mistakes.sh                | 40 +++++++++++++++++++++++++
 10 files changed, 115 insertions(+), 12 deletions(-)
 create mode 100755 t/t7414-submodule-mistakes.sh

