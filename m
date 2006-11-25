X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/5] get_shallow_commits: Avoid memory leak if a commit
 has been reached already.
Date: Sat, 25 Nov 2006 19:49:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611251947310.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87slg8uc0l.fsf@wine.dyndns.org> <ek9u4f$vmk$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 25 Nov 2006 18:49:44 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <ek9u4f$vmk$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32297>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Go2as-0007an-17 for gcvg-git@gmane.org; Sat, 25 Nov
 2006 19:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967110AbWKYSte (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 13:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967112AbWKYSte
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 13:49:34 -0500
Received: from mail.gmx.de ([213.165.64.20]:21164 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S967110AbWKYSte (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 13:49:34 -0500
Received: (qmail invoked by alias); 25 Nov 2006 18:49:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp042) with SMTP; 25 Nov 2006 19:49:32 +0100
To: Anand Kumria <wildfire@progsoc.org>
Sender: git-owner@vger.kernel.org

Hi,

On Sat, 25 Nov 2006, Anand Kumria wrote:

> Any reason you didn't do:
> 
> if (!commit->util)
> 	commit->util = xcalloc(1, sizeof(int));

xmalloc() does not initialize the memory. Therefore, it is usually 
preferred if you initialize the memory yourself. In this case, the memory 
is initialized to 0, even if it is not allocated.

It may be a minor performance issue, but it is a good habit to use xcalloc 
only if it is needed.

Ciao,
Dscho
