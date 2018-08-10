Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B1B81F404
	for <e@80x24.org>; Fri, 10 Aug 2018 18:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeHJU6r (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 16:58:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:50142 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726432AbeHJU6r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 16:58:47 -0400
Received: (qmail 17865 invoked by uid 109); 10 Aug 2018 18:27:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Aug 2018 18:27:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21845 invoked by uid 111); 10 Aug 2018 18:27:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 10 Aug 2018 14:27:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2018 14:27:45 -0400
Date:   Fri, 10 Aug 2018 14:27:45 -0400
From:   Jeff King <peff@peff.net>
To:     Philip White <philip@mailworks.org>
Cc:     Phillip Wood <phillip.wood@talktalk.net>, git@vger.kernel.org
Subject: Re: Bug? Git won't apply a split hunk that went through a text editor
Message-ID: <20180810182745.GA8876@sigill.intra.peff.net>
References: <43C90F94-C9B8-49E4-A9E9-C1D652B52E2F@mailworks.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43C90F94-C9B8-49E4-A9E9-C1D652B52E2F@mailworks.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 09, 2018 at 08:17:36PM -0700, Philip White wrote:

> I’d like to report what I suspect is a bug in Git, tested in 2.18 and
> 2.14. (I’d be delighted to be corrected if it is my own
> misunderstanding.) I’m reporting it here based on guidance from
> https://git-scm.com/community.
> 
> I created a minimal testcase with a detailed README here:
> https://github.com/philipmw/git-bugreport-2018-hunk-fail
> 
> Overview of the bug:
> 
> When interactively selecting hunks to apply, using `git checkout -p
> <tree> <file>`, git will correctly apply an unmodified hunk, but will
> refuse to apply a hunk that went through a text editor ("e" command),
> even when I made no changes in the text editor.
> 
> Thanks for any advice or attention you can give to this matter.

This sounds like the bug discussed in:

  https://public-inbox.org/git/be321106-2f10-e678-8237-449d2dd30fee@talktalk.net/

(that message and the surrounding thread).

The fix is in f4d35a6b49 (add -p: fix counting empty context lines in
edited patches, 2018-06-11), which is in the current tip of 'master',
but not yet any released version.

-Peff
