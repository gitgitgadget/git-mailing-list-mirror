From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What to expect after 0.99.8
Date: Tue, 4 Oct 2005 17:10:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510041706330.31407@g5.osdl.org>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510031522590.23242@iabervon.org> <7vmzlqnwmw.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510031709360.23242@iabervon.org> <7v1x32l0gz.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510031606550.31407@g5.osdl.org> <20051004071210.GA18716@localdomain>
 <Pine.LNX.4.63.0510040321170.23242@iabervon.org> <pan.2005.10.04.14.18.59.102722@smurf.noris.de>
 <434296F1.5030006@zytor.com> <20051004154640.GC4682@kiste.smurf.noris.de>
 <4342AF4B.7020806@zytor.com> <7vu0fx9c1c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 02:11:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMwrd-0000tv-1J
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 02:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbVJEAK0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 20:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbVJEAK0
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 20:10:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39070 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965048AbVJEAKZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2005 20:10:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j950AK4s010057
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 4 Oct 2005 17:10:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j950AIYH019704;
	Tue, 4 Oct 2005 17:10:19 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0fx9c1c.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.119 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9693>



On Tue, 4 Oct 2005, Junio C Hamano wrote:
> 
> I vaguely recall there was an interesting regression in recent
> kernel history when the implementation of the pipe buffer was
> changed, with which, writing the same amount of data with
> different number of writes made things behave differently and
> making the worst case buffer size less than traditional 4K.

Just for performance reasons, I ended up doing merging anyway, so in fact 
regardless of how you write the current pipe buffer size is up to 16 
pages.

I think you can safely assume that pretty much any file descriptor you use 
has at least 1kB of buffer. Even 4kB is likely a "safe assumption", and in 
reality, most of them end up having even more.

With something like ssh, you probably end up having even deeper ones, 
since you end up having the local pty or socket to ssh, and then ssh has 
the TCP buffer to the network..

			Linus
