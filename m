Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F3CE92719
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 17:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjJERYa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 13:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjJERXu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 13:23:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA53D9
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 10:18:28 -0700 (PDT)
Received: (qmail 23942 invoked by uid 109); 5 Oct 2023 17:18:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Oct 2023 17:18:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25680 invoked by uid 111); 5 Oct 2023 17:18:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Oct 2023 13:18:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Oct 2023 13:18:27 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] doc/cat-file: clarify description regarding various
 command forms
Message-ID: <20231005171827.GC975921@coredump.intra.peff.net>
References: <20231003082513.3003520-1-stepnem@smrk.net>
 <20231003200659.GC1562@coredump.intra.peff.net>
 <20231005132018+0200.47596-stepnem@smrk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231005132018+0200.47596-stepnem@smrk.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 05, 2023 at 01:20:18PM +0200, Štěpán Němec wrote:

> So how about we just butcher the DESCRIPTION completely;
> [...]
> DESCRIPTION
>     This command can operate in two modes, depending on whether an
>     option from the --batch family is specified.
> 
>     In non-batch mode, the command provides information on an object
>     named on the command line.
> 
>     In batch mode, arguments are read from standard input.
> 
> [That's all for a summary, read the following sections for details.]

Yeah, I think that is a big improvement over the status quo. I might
also be worth starting with a single-sentence overview of what is common
to both modes. Something like:

  Output the contents or details of one or more objects. This command
  can operate in two modes, depending on whether an option from the
  --batch family is specified.

  In non-batch mode, the command provides information on a single object
  given on the command line.

  In batch mode, arguments are read from standard input.

> > I think this got a bit inaccurate with "--batch-command", which is a
> > whole different mode itself compared to --batch and --batch-check. I
> > don't think your patch is really making anything worse, but arguably
> > there are three "major modes" here.
> 
> This is not obvious to me (the "three major modes" part).  AIUI it's
> still mainly a batch (read from stdin) vs. non-batch (args on command
> line) dichotomy.  The details differ (just args vs. command + args), but
> so does e.g. -e differ in providing information via exit code rather
> than stdout.

Yeah, I think you understand it correctly. But what the current text
(both before and after your proposed patch) says about batch mode is:

  In batch mode, a list of objects (separated by linefeeds) is provided
  on stdin, [...]

which I think is not really true of --batch-command. But the rewrite you
suggest above takes care of that nicely, I think.

> (But please note I'm not trying to pose as an expert here: this all
> started with me coming to git-cat-file(1) to _learn_ about cat-file
> and finding the description more than a little confusing.)

That is a very valuable perspective. I am probably too much an expert in
cat-file, and it has rotted my brain. ;)

-Peff
