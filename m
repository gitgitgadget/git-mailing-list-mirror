From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 15:28:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702131524130.3604@woody.linux-foundation.org>
References: <45CFA30C.6030202@verizon.net> <200702130932.51601.litvinov2004@gmail.com>
 <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org>
 <7v7iumx7hu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org>
 <20070213204248.GA21046@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 00:28:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH74g-0005GJ-Rl
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 00:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbXBMX2e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 18:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbXBMX2e
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 18:28:34 -0500
Received: from smtp.osdl.org ([65.172.181.24]:60466 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751421AbXBMX2d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 18:28:33 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1DNSHhB009409
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 13 Feb 2007 15:28:18 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1DNSFc5014555;
	Tue, 13 Feb 2007 15:28:16 -0800
In-Reply-To: <20070213204248.GA21046@uranus.ravnborg.org>
X-Spam-Status: No, hits=-0.421 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39599>



On Tue, 13 Feb 2007, Sam Ravnborg wrote:
> 
> This whole auto CRLF things seems to deal with DOS issues that I personally
> have not encountered since looong time ago.

Maybe you stopped using DOS a loong time ago ;)

It's definitely an issue. Yes, all windows programs basically *understand* 
files that have just LF. But almost all of them will *write* files with 
CRLF.

(Which means that I suspect I made the default for "auto_crlf" be wrong in 
my patch: I probably should not default to checking out with CRLF, but 
checking out with just LF, and only do the CRLF->LF conversion on input).

Anybody who has ever worked with _any_ Windows people have long since 
learnt that they always end up having to convert CRLF to just LF when they
get files. Even _I_ know it, and I seldom have to work with people who use 
Windows ;)

So it's a good idea to try to make sure that Windows users don't corrupt 
files by adding CRLF where there is no need for them into a git archive. 
We hope to convert those people to a real OS some day ("here's a nickel, 
boy"), and to make it easier for them to do it, making sure that their 
projects in -git are already in a sane format is probably a good idea.

			Linus
