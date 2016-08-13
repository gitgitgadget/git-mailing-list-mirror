Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E611F1FD99
	for <e@80x24.org>; Sat, 13 Aug 2016 10:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbcHMKgq (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 06:36:46 -0400
Received: from mta02.prd.rdg.aluminati.org ([94.76.243.215]:38028 "EHLO
	mta02.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751566AbcHMKgp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2016 06:36:45 -0400
Received: from mta02.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id 98B26230B3;
	Sat, 13 Aug 2016 11:36:43 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTP id 9460133E0;
	Sat, 13 Aug 2016 11:36:43 +0100 (BST)
X-Quarantine-ID: <CqjXuAY43nVn>
X-Virus-Scanned: Debian amavisd-new at mta02.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta02.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CqjXuAY43nVn; Sat, 13 Aug 2016 11:36:41 +0100 (BST)
Received: from john.keeping.me.uk (unknown [10.2.0.9])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTPSA id B088E33D4;
	Sat, 13 Aug 2016 11:36:39 +0100 (BST)
Date:	Sat, 13 Aug 2016 11:36:39 +0100
From:	John Keeping <john@keeping.me.uk>
To:	"Tom Tanner (BLOOMBERG/ LONDON)" <ttanner2@bloomberg.net>
Cc:	git@vger.kernel.org
Subject: Re: git difftool and git mergetool aren't returning errors when the
 tool has issues
Message-ID: <20160813103639.mxscvfyztee4hbvh@john.keeping.me.uk>
References: <57AD772501C207A400390148_0_15304@p057>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57AD772501C207A400390148_0_15304@p057>
User-Agent: Mutt/1.6.2 (2016-06-11)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 12, 2016 at 07:13:41AM -0000, Tom Tanner (BLOOMBERG/ LONDON) wrote:
> For instance, if you set your diff/mergetool to meld and you don't have it installed:
> > git difftool
> 
> Viewing (1/1): 'blah'
> Launch 'meld' [Y/n]? y
> /home/ttanner/bin/meld[8]: /opt/swt/bin/meld: not found
> > echo $?
> 0
> 
> > /home/ttanner/bin/meld
> /home/ttanner/bin/meld[8]: /opt/swt/bin/meld: not found
> > echo $?
> 127

Have you looked at the --trust-exit-code option to git-difftool?

It would be nice if there was a way to differentiate between complete
failure and just the diff tool exiting with a non-zero return status
because the files differ, but I'm not sure whether we can do that
reliably.  POSIX uses 127 and 126 as errors that mean the command didn't
run [1] so it may be sensible to to treat those as special values.

[1] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_08_02
