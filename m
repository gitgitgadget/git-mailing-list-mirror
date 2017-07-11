Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5927820357
	for <e@80x24.org>; Tue, 11 Jul 2017 10:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755591AbdGKKio (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 06:38:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:36818 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753647AbdGKKin (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 06:38:43 -0400
Received: (qmail 2985 invoked by uid 109); 11 Jul 2017 10:38:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 10:38:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15151 invoked by uid 111); 11 Jul 2017 10:38:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 06:38:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jul 2017 06:38:41 -0400
Date:   Tue, 11 Jul 2017 06:38:41 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 5/7] tag: handle `pager.tag`-configuration within the
 builtin
Message-ID: <20170711103840.ghdoarxlfibfmg2t@sigill.intra.peff.net>
References: <cover.1499723297.git.martin.agren@gmail.com>
 <c5bb98f94757b94c09d0be27dce0df9d07d9eb6f.1499723297.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5bb98f94757b94c09d0be27dce0df9d07d9eb6f.1499723297.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2017 at 11:55:18PM +0200, Martin Ågren wrote:

> Use the mechanisms introduced in two earlier patches to ignore
> `pager.tag` in git.c and let the `git tag` builtin handle it on its own.
> 
> This is in preparation for the next patch, where we will want to handle
> slightly different configuration variables depending on which options
> are used with `git tag`. For this reason, place the call to
> setup_auto_pager() after the options have been parsed.
> 
> No functional change is intended. That said, there is a window between
> where the pager is started before and after this patch, and if an error
> occurs within this window, as of this patch the error message might not
> be paged where it would have been paged before. Since
> operation-parsing has to happen inside this window, a difference can be
> seen with, e.g., `git -c pager.tag="echo pager is used" tag
> --unknown-option`. This change in paging-behavior should be acceptable
> since it only affects erroneous usages.

Thanks for carefully thinking through the details. I agree that it's an
acceptable change of behavior.

-Peff
