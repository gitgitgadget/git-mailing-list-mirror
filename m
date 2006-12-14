X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Avoid accessing a slow working copy during diffcore
 operations.
Date: Thu, 14 Dec 2006 15:12:47 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612141511110.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061214111557.GA24297@spearce.org>
 <81b0412b0612140557u225ca00du5b15823d05fda4b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 14:13:25 +0000 (UTC)
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <81b0412b0612140557u225ca00du5b15823d05fda4b9@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34339>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GurKp-0001aA-4N for gcvg-git@gmane.org; Thu, 14 Dec
 2006 15:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932736AbWLNOMy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 09:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbWLNOMx
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 09:12:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:34049 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932736AbWLNOMu
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 09:12:50 -0500
Received: (qmail invoked by alias); 14 Dec 2006 14:12:48 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp043) with SMTP; 14 Dec 2006 15:12:48 +0100
To: Alex Riesen <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 14 Dec 2006, Alex Riesen wrote:

> On 12/14/06, Shawn O. Pearce <spearce@spearce.org> wrote:
> > If Git is compiled with NO_FAST_WORKING_DIRECTORY set then we will
> > avoid looking at the working directory when the blob in question
> > is available within a packfile and the caller doesn't need the data
> > unpacked into a temporary file.
> 
> Why can't it be useful in generic code? What are the downsides?

It is usually cheaper to just read the file, especially if it is still 
cached, because the alternative means unpacking the loose object, or 
worse, unpacking the packed object _along_ with the objects in its delta 
chain.

Not every OS sucks cache-wise, and you should not make others suffer for 
Redmond's shortcomings.

Ciao,
Dscho
