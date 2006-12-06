X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Fast access git-rev-list output: some OS knowledge required
Date: Thu, 7 Dec 2006 00:27:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612070025450.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e5bfff550612061124jcd0d94em47793710866776e7@mail.gmail.com>
 <20061206192800.GC20320@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 6 Dec 2006 23:27:16 +0000 (UTC)
Cc: Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061206192800.GC20320@spearce.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33535>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs6AV-0003Wq-8W for gcvg-git@gmane.org; Thu, 07 Dec
 2006 00:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937787AbWLFX1M (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 18:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937792AbWLFX1M
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 18:27:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:43334 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S937791AbWLFX1L
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 18:27:11 -0500
Received: (qmail invoked by alias); 06 Dec 2006 23:27:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp017) with SMTP; 07 Dec 2006 00:27:09 +0100
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 6 Dec 2006, Shawn Pearce wrote:

> Marco Costalba <mcostalba@gmail.com> wrote:
> > The time it takes to read, without processing, the whole Linux tree
> > with this approach it's almost _double_ of the time it takes 'git
> > rev-list' to write to a file:
> > 
> > 3) Other suggestions?  ;-)
> 
> The revision listing machinery is fairly well isolated behind some 
> pretty clean APIs in Git.  Why not link qgit against libgit.a and just 
> do the revision listing in process?

Because, depending on what you do, the revision machinery is not 
reentrable. For example, if you filter by filename, the history is 
rewritten in-memory to simulate a history where just that filename was 
tracked, and nothing else. These changes are not cleaned up after calling 
the internal revision machinery.

Hth,
Dscho
