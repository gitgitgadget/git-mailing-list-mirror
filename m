Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143A7C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 21:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC0B82072A
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 21:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgD1VEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:04:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:43006 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726386AbgD1VEj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 17:04:39 -0400
Received: (qmail 23751 invoked by uid 109); 28 Apr 2020 21:04:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Apr 2020 21:04:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7140 invoked by uid 111); 28 Apr 2020 21:16:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Apr 2020 17:16:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Apr 2020 17:04:38 -0400
From:   Jeff King <peff@peff.net>
To:     "Nixon, Francis A" <francis.nixon17@imperial.ac.uk>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Log ignores --oneline and --pretty=oneline in combination
 with -L.
Message-ID: <20200428210438.GD4000@coredump.intra.peff.net>
References: <DB8PR06MB6218D1398300AFD016D0B804D5AC0@DB8PR06MB6218.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DB8PR06MB6218D1398300AFD016D0B804D5AC0@DB8PR06MB6218.eurprd06.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 02:28:15PM +0000, Nixon, Francis A wrote:

>  Running `git log --pretty=oneline
>  -L:get_stack_map_frames:stackmapframes.rs`(filename/function names as
>  an example only, consistent across many files.) results on in correct
>  output but doesn't ouput in a oneline format(still includes the full
>  diffs).

The "--oneline" option has nothing to do with the diff display; it
controls the formatting of the commit message.

The default for git-log is not to show a diff at all, which is why "git
log --oneline" truly has only one line per commit. Using the "-L" option
implies showing a diff. Try adding "-s" or "--no-patch" to suppress it.

> Occurs on `git version 2.26.GIT`
> (e870325ee8575d5c3d7afe0ba2c9be072c692b65), as well as whatever `git
> version 2.20.1`.

Note that the combination of "-s" and "-L" was added in v2.22, so it
will work on one but not the other.

-Peff
