X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: lockfiles & fork()
Date: Sat, 28 Oct 2006 15:30:27 +0200
Message-ID: <87fyd8ftzg.fsf@mid.deneb.enyo.de>
References: <Pine.LNX.4.63.0610280319250.26682@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 28 Oct 2006 13:31:57 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0610280319250.26682@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 28 Oct 2006 03:21:38 +0200
	(CEST)")
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30375>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdoHx-0004pJ-Gs for gcvg-git@gmane.org; Sat, 28 Oct
 2006 15:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752324AbWJ1Nbu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 09:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752367AbWJ1Nbu
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 09:31:50 -0400
Received: from mail.enyo.de ([212.9.189.167]:57350 "EHLO mail.enyo.de") by
 vger.kernel.org with ESMTP id S1752324AbWJ1Nbt (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 09:31:49 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de) by
 mail.enyo.de with esmtp id 1GdoHr-0002Xm-8S for git@vger.kernel.org; Sat, 28
 Oct 2006 15:31:47 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.63) (envelope-from
 <fw@deneb.enyo.de>) id 1GdoGZ-0006hc-2z for git@vger.kernel.org; Sat, 28 Oct
 2006 15:30:27 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

* Johannes Schindelin:

> when you setup a lockfile, and then fork(), you could easily end up with 
> atexit() kicking in to remove the lockfile, before the main process has a 
> chance to commit. (Yes, I need to hold the lock long before the fork()).
>
> Any ideas how to solve the problem?

I think you should call _exit in the child instead of exit.
