From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 9 Jun 2006 21:11:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606092109380.5498@g5.osdl.org>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com> 
 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com> 
 <46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com> 
 <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>  <Pine.LNX.4.64.0606091837040.5498@g5.osdl.org>
  <9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com> 
 <Pine.LNX.4.64.0606091853180.5498@g5.osdl.org>
 <46a038f90606092041neadcc54n2acb6272d1f71de7@mail.gmail.com>
 <Pine.LNX.4.64.0606092043460.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 10 06:12:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoupY-0002bz-QJ
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 06:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWFJEME (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 00:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWFJEME
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 00:12:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35487 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932385AbWFJEMB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jun 2006 00:12:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5A4Bxgt018395
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Jun 2006 21:11:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5A4Bwqt009143;
	Fri, 9 Jun 2006 21:11:58 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0606092043460.5498@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21595>



On Fri, 9 Jun 2006, Linus Torvalds wrote:
> 
> You can try to approximate the latency by just looking at the number of 
> packets, and using a large MTU (and on localhost, the MTU will be pretty 
> large - roughly 16kB. Don't count packet size at all, just count how many 
> packets each protocol sends (both ways), ignoring packets that are just 
> empty ACK's.

Btw, the reason you should ignore empty acks is that they happen when you 
have a nice streaming one-way thing, because the TCP rules say that you 
should send an ACK every two full packets minimum, even if you have 
nothing to say.

So empty acks really approximate to "streaming data", while packets with 
payload _could_ obviously mean "nice streaming data going both ways", but 
almost always end up being synchronization discussion of some sort.

		Linus
