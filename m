X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Mon, 11 Dec 2006 21:54:55 +0100
Message-ID: <200612112154.56166.Josef.Weidendorfer@gmx.de>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com> <200612112128.06485.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0612111238560.3515@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 20:55:28 +0000 (UTC)
Cc: Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0612111238560.3515@woody.osdl.org>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34035>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtsBG-0005Uh-6T for gcvg-git@gmane.org; Mon, 11 Dec
 2006 21:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1763076AbWLKUzM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 15:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763075AbWLKUzM
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 15:55:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:50821 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1762953AbWLKUzK
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 15:55:10 -0500
Received: (qmail invoked by alias); 11 Dec 2006 20:55:08 -0000
Received: from p5496B761.dip0.t-ipconnect.de (EHLO noname) [84.150.183.97] by
 mail.gmx.net (mp048) with SMTP; 11 Dec 2006 21:55:08 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Monday 11 December 2006 21:40, Linus Torvalds wrote:
> On Mon, 11 Dec 2006, Josef Weidendorfer wrote:
> > A general question: How many context switches are involved in such
> > a producer/consumer scenario, given that the consumer writes one
> > line at a time, and the consumer uses poll/select to wait for the
> > data?
> > Is there some possibility to make the kernel write-combine single
> > small producer writes into bigger chunks, which will be delivered
> > at once (or smaller data only after a small timeout)?
> 
> The data will be write-combined.
> 
> The kernel doesn't context-switch after a write() to a pipe if there is 
> space left (and usually the pipe buffer is 64kB with current kernels, so 
> there obviously will be), unless the reader has a higher priority for some 
> reason (ie the reader has been waiting a long time).

Ah, thanks.
So the implementation in Qt's QProcess is a little bit pessimistic, probably
to make it work fine with other UNIXs out there.

