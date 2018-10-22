Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2914A1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 22:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbeJWGvJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 02:51:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:49896 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727313AbeJWGvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 02:51:09 -0400
Received: (qmail 17533 invoked by uid 109); 22 Oct 2018 22:30:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 22 Oct 2018 22:30:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11670 invoked by uid 111); 22 Oct 2018 22:29:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Oct 2018 18:29:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Oct 2018 18:30:41 -0400
Date:   Mon, 22 Oct 2018 18:30:41 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] archive: init archivers before determining format
Message-ID: <20181022223041.GA19019@sigill.intra.peff.net>
References: <cover.1539990488.git.steadmon@google.com>
 <b1f8e288dde9a9dd46386524189da66c7ad2c333.1539990488.git.steadmon@google.com>
 <20181019235945.GB7326@sigill.intra.peff.net>
 <20181022214756.GC233961@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181022214756.GC233961@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 02:47:56PM -0700, Josh Steadmon wrote:

> > Does this work with configured archiver extensions, too? I think so,
> > because we load them via init_tar_archiver().
> 
> If you mean things like .tgz and .tar.gz, then yes, they are affected by
> the bug as well, and this patch fixes them. The test included in v2 uses
> a .tgz file.

Yes, but also ones that are provided by the user. E.g., does:

  git config tar.foo.command "foo"
  git archive -o out.tar.foo HEAD

work? (I think the answer is yes, because we read git_tar_config in the
same place).

-Peff
