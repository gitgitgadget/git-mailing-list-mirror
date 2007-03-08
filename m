From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-bundle: Make thin packs
Date: Wed, 7 Mar 2007 16:34:16 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703071632140.5963@woody.linux-foundation.org>
References: <45ECEB40.4000907@gmail.com>  <7vejo2stlw.fsf@assigned-by-dhcp.cox.net>
 <45EE1242.8080405@gmail.com>  <7vhcsxkb8n.fsf@assigned-by-dhcp.cox.net>
 <45EE2ECA.60403@gmail.com>  <Pine.LNX.4.63.0703070419410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
  <45EE36A1.30001@gmail.com>  <Pine.LNX.4.63.0703070504140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <30e4a070703070834s3dd5bdd7x2e1639aa2979d1cf@mail.gmail.com>
 <Pine.LNX.4.63.0703072330200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0703071516330.5963@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703080121210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 08 01:34:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP6aS-0005lI-IR
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 01:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbXCHAeY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 19:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbXCHAeY
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 19:34:24 -0500
Received: from smtp.osdl.org ([65.172.181.24]:41623 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbXCHAeX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 19:34:23 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l280YHq8008081
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 7 Mar 2007 16:34:17 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l280YGJp014410;
	Wed, 7 Mar 2007 16:34:16 -0800
In-Reply-To: <Pine.LNX.4.63.0703080121210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-2.483 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41708>



On Thu, 8 Mar 2007, Johannes Schindelin wrote:
>
> 	> Since a bundle doesn't make any sense *anyway* unless you have 
> 	> the prerequisites at the other end, I think you might as well do 
> 	> thin packs. That will cut down on the bundle size a *lot* for 
> 	> the common cases.
> 
> 	Well, I disagree on the blanket "*anyway*". Shallow fetches are no 
> 	longer possible from these bundles (at least after this commit 
> 	_and_ ":/git-bundle: avoid packing" which I just sent out).

Does anybody actually use shallow clones in real life?

When I did the numbers a long time ago, the shallow clone didn't actually 
help much, because it meant that there were no deltas. Which meant that 
you got 1% of the history for 60% of the price of all history, and the 
shallow thing didn't really seem to make much sense.

I guess that for something with a really long history, you'd get 0.001% of 
the history for 10% of the price, and maybe it makes sense then.

		Linus
