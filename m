X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] shortlog: fix segfault on empty authorname
Date: Sat, 9 Dec 2006 22:45:24 -0500
Message-ID: <20061210034524.GA11819@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0612082205240.2630@xanadu.home> <20061209040421.GA29113@coredump.intra.peff.net> <Pine.LNX.4.63.0612100019270.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 03:45:41 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612100019270.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33864>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtFdC-0001VV-5P for gcvg-git@gmane.org; Sun, 10 Dec
 2006 04:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760121AbWLJDp1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 22:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760110AbWLJDp1
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 22:45:27 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:34661
 "HELO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id
 S1760121AbWLJDp1 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006
 22:45:27 -0500
Received: (qmail 20594 invoked from network); 9 Dec 2006 22:45:26 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 9 Dec 2006 22:45:26 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Dec
 2006 22:45:24 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Sun, Dec 10, 2006 at 12:21:03AM +0100, Johannes Schindelin wrote:

> > Instead, remove at most one space between name and address.
> 
> Why? We can fix it properly: Instead of
> 
> > -				while (isspace(bob[-1]))
> > +				if (isspace(bob[-1]))
> 
> do something like
> 
> 				while (bob - 1 != buffer + 7 && 
> 						isspace(bob[-1]))

It doesn't look like there are ever extra spaces to get soaked up in the
kernel or git repositories, but if there is a reason to expect
  Full Name    <user@domain>
then we should probably replace my fix with yours.

