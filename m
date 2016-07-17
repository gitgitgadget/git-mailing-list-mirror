Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE8D02018F
	for <e@80x24.org>; Sun, 17 Jul 2016 16:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbcGQQX6 (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 12:23:58 -0400
Received: from imap.thunk.org ([74.207.234.97]:36324 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063AbcGQQX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 12:23:57 -0400
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date; bh=T2qsR37FdYozGynrWyvtOBa90wdVy92Hbg/H/Hi4H5w=;
	b=o43T+f3r9ZmZ2Zm3YM957QA+LqqjfhEhBA1PDUXHIF5l9S6B2u2RbiEedBVLrLbv6RKER+OUKUs5lsV7VclRr1SWeldBFvZyJe0YZNdrSQSPOi1QtnytVsbfVCQA75iC90Po9MJLQes50dXdHebaoD9CeB85M+Mpwphk+AYlRH4=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.84_2)
	(envelope-from <tytso@thunk.org>)
	id 1bOor8-0003xV-9c; Sun, 17 Jul 2016 16:23:50 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 2C03C82F50B; Sun, 17 Jul 2016 12:23:49 -0400 (EDT)
Date:	Sun, 17 Jul 2016 12:23:49 -0400
From:	Theodore Ts'o <tytso@mit.edu>
To:	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Duy Nguyen <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Herczeg Zsolt <zsolt94@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git and SHA-1 security (again)
Message-ID: <20160717162349.GB11276@thunk.org>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <20160716201313.GA298717@vauxhall.crustytoothpaste.net>
 <alpine.DEB.2.20.1607170949360.28832@virtualbox>
 <20160717142157.GA6644@vauxhall.crustytoothpaste.net>
 <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com>
 <20160717154234.GC6644@vauxhall.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160717154234.GC6644@vauxhall.crustytoothpaste.net>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 17, 2016 at 03:42:34PM +0000, brian m. carlson wrote:
> As I said, I'm not planning on multiple hash support at first, but it
> doesn't appear impossible if we go this route.  We might still have to
> rewrite objects, but we can verify signatures over the legacy SHA-1
> objects by forcing them into the old-style object format.

How hard would it be to make the on-disk format be multihash, even if
there is no support for anything other than a single hash, at least
for now?  That way we won't have to rewrite the objects twice.

Personally, so long as the newer versions of the tree are secured, I
wouldn't mind if the older commits stayed using SHA1 only.  The newer
commits are the ones that are most important and security-critical
anyway.  It seems like the main reason to rewrite all of the objects
is to simplify the initial rollout of a newer hash algorithm, no?

		     	   		   - Ted
