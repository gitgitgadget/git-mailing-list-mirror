From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How do get a specific version of a particular file?
Date: Tue, 27 Feb 2007 17:24:54 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702271719300.12485@woody.linux-foundation.org>
References: <E1HM1XL-00071C-N5@candygram.thunk.org>
 <Pine.LNX.4.63.0702271356040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070227154241.GA8228@thunk.org> <Pine.LNX.4.63.0702272053080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070227223929.GA9027@thunk.org> <86vehnnpy2.fsf@blue.stonehenge.com>
 <7vfy8rb2do.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702271605290.12485@woody.linux-foundation.org>
 <7vejob9l70.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702271643080.12485@woody.linux-foundation.org>
 <alpine.LRH.0.82.0702272004370.29426@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Theodore Tso <tytso@mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 02:25:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMDZK-0008WV-RH
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 02:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbXB1BZR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 20:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbXB1BZR
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 20:25:17 -0500
Received: from smtp.osdl.org ([65.172.181.24]:33468 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984AbXB1BZP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 20:25:15 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1S1OYhB025883
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Feb 2007 17:24:35 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1S1OXfp002916;
	Tue, 27 Feb 2007 17:24:33 -0800
In-Reply-To: <alpine.LRH.0.82.0702272004370.29426@xanadu.home>
X-Spam-Status: No, hits=-0.445 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40870>



On Tue, 27 Feb 2007, Nicolas Pitre wrote:
> 
> /me wonders why Linux wasn't written in C++ with overloaded operators...

Actually, there was a short while that we tried it.

In the end, we ended up using the C pre-processor (and some gcc hackery) 
instead, since it's just superior to the mess that is C++.

See "<asm/uaccess.h>" and various other header files, and realize that we 
have overloaded operations for things like "get_user()" and "xchg()" and 
friends.

Overloading of operators wouldn't be very useful, though: it really only 
pays in either real math (where having "+" etc do the right thing for 
complex numbers/vectors/matrices/whatever is totally unambiguous and just 
makes code a lot more readable) or with really trivial stuff (ie "+" for 
string concatenation).

Outside of math and really trivial stuff, it's just a horribly bad idea, 
because it just makes for subtle and hard to understand code.

Same largely goes for overloading of functions too, for that matter, 
except for the cases where you really can pretty much do it by argument 
size (and then the C preprocessor and few gcc extensions actually generate 
better and more readable code than C++ ever did - which is admittedly 
not saying a whole lot).

		Linus
