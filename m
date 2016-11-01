Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0573520229
	for <e@80x24.org>; Tue,  1 Nov 2016 17:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753357AbcKARpa (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 13:45:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:37063 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753196AbcKARp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 13:45:29 -0400
Received: (qmail 12556 invoked by uid 109); 1 Nov 2016 17:45:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Nov 2016 17:45:28 +0000
Received: (qmail 27905 invoked by uid 111); 1 Nov 2016 17:45:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Nov 2016 13:45:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Nov 2016 13:45:26 -0400
Date:   Tue, 1 Nov 2016 13:45:26 -0400
From:   Jeff King <peff@peff.net>
To:     "Halde, Faiz" <fhalde@paypal.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git issue
Message-ID: <20161101174526.e2tilsriz2fqaru3@sigill.intra.peff.net>
References: <BY2PR0601MB16400EAC3E9683841907F4B2A2A10@BY2PR0601MB1640.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BY2PR0601MB16400EAC3E9683841907F4B2A2A10@BY2PR0601MB1640.namprd06.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2016 at 10:28:57AM +0000, Halde, Faiz wrote:

> I frequently use the following command to ignore changes done in a file
> 
> git update-index --assume-unchanged somefile
> 
> Now when I do a pull from my remote branch and say the file 'somefile'
> was changed locally and in remote, git will abort the merge saying I
> need to commit my changes of 'somefile'.
> 
> But isn't the whole point of the above command to ignore the changes
> within the file?

No. The purpose of --assume-unchanged is to promise git that you will
not change the file, so that it may skip checking the file contents in
some cases as an optimization.

From "git help update-index":

      --[no-]assume-unchanged
	   When this flag is specified, the object names recorded for
	   the paths are not updated. Instead, this option sets/unsets
	   the "assume unchanged" bit for the paths. When the "assume
	   unchanged" bit is on, the user promises not to change the
	   file and allows Git to assume that the working tree file
	   matches what is recorded in the index. If you want to change
	   the working tree file, you need to unset the bit to tell Git.
	   This is sometimes helpful when working with a big project on
	   a filesystem that has very slow lstat(2) system call (e.g.
	   cifs).

	   Git will fail (gracefully) in case it needs to modify this
	   file in the index e.g. when merging in a commit; thus, in
	   case the assumed-untracked file is changed upstream, you will
	   need to handle the situation manually.

-Peff
